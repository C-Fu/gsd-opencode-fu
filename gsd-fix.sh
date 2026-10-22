#!/usr/bin/env bash
#
# gsd-fix.sh — post-install fixer for GSD-OpenCode on OpenCode 2.0
#
# Run this AFTER `npx gsd-opencode` (or `npx gsd-opencode install --global`).
# See GSD_FIX.md for the full background. What it does:
#
#   1. Flattens  ~/.config/opencode/commands/gsd/*.md  ->  ~/.config/opencode/commands/
#      (OpenCode 2.0 turns nested command dirs into namespaced /gsd/gsd-* commands;
#       GSD expects flat /gsd-* names.)
#   2. Pins `gsd-sdk` to a real global npm install instead of the ephemeral npx cache
#      (npx can garbage-collect ~/.npm/_npx, killing the symlink silently).
#   3. Verifies that OpenCode registered the /gsd-* commands.
#
# Idempotent: safe to run any number of times.
# Kotlin of scope: local (.opencode/) installs — set GSD_CONFIG_DIR for a non-default config dir.
#
set -euo pipefail

GSD_CONFIG_DIR="${GSD_CONFIG_DIR:-$HOME/.config/opencode}"
OPENCODE_NODE_BIN="${OPENCODE_NODE_BIN:-$HOME/.nvm/versions/node/v24.18.0/bin}"

info()  { printf '  \033[36m→\033[0m %s\n' "$*"; }
ok()    { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn()  { printf '  \033[33m⚠\033[0m %s\n' "$*"; }
fail()  { printf '  \033[31m✗\033[0m %s\n' "$*"; }

if [[ ! -d "$GSD_CONFIG_DIR" ]]; then
    fail "OpenCode config dir not found at $GSD_CONFIG_DIR (set GSD_CONFIG_DIR if you use a custom path)"
    exit 1
fi

echo "GSD fix — OpenCode 2.0 (config: $GSD_CONFIG_DIR)"

# ---------------------------------------------------------------------------
# 1. Flatten commands/gsd/ -> commands/
# ---------------------------------------------------------------------------
CMD_DIR="$GSD_CONFIG_DIR/commands"
NESTED_DIR="$CMD_DIR/gsd"

if [[ -d "$NESTED_DIR" ]]; then
    info "Found nested commands/gsd/ — flattening (nested dirs become /gsd/gsd-* in OpenCode 2.0)"
    COLLISIONS=0
    for f in "$NESTED_DIR"/*.md; do
        base="$(basename "$f")"
        if [[ -e "$CMD_DIR/$base" ]]; then
            warn "collision: $base already exists in $CMD_DIR, leaving nested copy in place"
            COLLISIONS=1
        else
            mv "$f" "$CMD_DIR/$base"
        fi
    done
    # Only remove the nested dir if it is now empty/missing .md files
    if [[ "$COLLISIONS" -eq 0 ]] && ! ls "$NESTED_DIR"/*.md >/dev/null 2>&1; then
        rmdir "$NESTED_DIR"
        ok "commands flattened"
    else
        warn "nested commands/gsd/ kept (collisions occurred) — review manually"
    fi
else
    ok "commands already flat (no commands/gsd/ dir)"
fi

# ---------------------------------------------------------------------------
# 2. Make `gsd-sdk` stable (real global npm install, not the npx cache)
# ---------------------------------------------------------------------------
SHELL_BIN="$(command -v npm >/dev/null 2>&1 && npm bin -g 2>/dev/null || true)"
FIND_GSD_SDK() {
    # Prefer an already-stable global npm install
    for cand in "$OPENCODE_NODE_BIN/gsd-sdk" "$(command -v gsd-sdk || true)"; do
        [[ -n "$cand" && -e "$cand" && "$(readlink -f "$cand")" != *"node_modules/.bin/gsd-sdk"* ]] && { echo "$cand"; return 0; }
    done
    return 1
}

CURRENT_SDK="$(readlink -f "$(command -v gsd-sdk 2>/dev/null)" 2>/dev/null || true)"
if [[ "$CURRENT_SDK" != *"node_modules/.bin/gsd-sdk"* ]] && [[ -n "$CURRENT_SDK" ]]; then
    ok "gsd-sdk already stable: $CURRENT_SDK"
else
    info "gsd-sdk points into the npx cache (`${CURRENT_SDK:-curl}`) — pinning a global install"
    if command -v npm >/dev/null 2>&1; then
        npm install -g gsd-opencode >/dev/null 2>&1 || { fail "npm install -g gsd-opencode failed"; exit 1; }
        # Locate the fresh npm global bin path
        GLOBAL_BIN="$(npm prefix -g)/bin"
        TARGET="$GLOBAL_BIN/gsd-sdk"
        if [[ -e "$TARGET" ]]; then
            mkdir -p "$HOME/.local/bin"
            ln -sf "$TARGET" "$HOME/.local/bin/gsd-sdk"
            hash -r 2>/dev/null || true
            ok "gsd-sdk -> $TARGET"
        else
            fail "npm global install succeeded but $TARGET not found; fix the symlink manually"
            exit 1
        fi
    else
        fail "npm not found on PATH — install node/npm and re-run this script"
        exit 1
    fi
fi

# Smoke-test the CLI
if out="$(gsd-sdk query state.load 2>&1)"; then
    ok "gsd-sdk query state.load works"
else
    fail "gsd-sdk query state.load failed: ${out:0:200}"
    exit 1
fi

# ---------------------------------------------------------------------------
# 3. Verify OpenCode registered the /gsd-* commands (service must be running)
# ---------------------------------------------------------------------------
if command -v opencode >/dev/null 2>&1; then
    if cmds="$(opencode api get /api/command 2>/dev/null)"; then
        flat_count="$(printf '%s' "$cmds" | grep -o '"name":"gsd-[a-z_-]*"' | wc -l || true)"
        nested_count="$(printf '%s' "$cmds" | grep -o '"name":"gsd/gsd-' | wc -l || true)"
        if [[ "$nested_count" -gt 0 ]]; then
            warn "$nested_count commands still registered as /gsd/gsd-* — restart the OpenCode service to pick up the flattened files:"
            warn "  opencode service restart"
        elif [[ "$flat_count" -gt 0 ]]; then
            ok "$flat_count /gsd-* commands registered in the running OpenCode service"
        else
            warn "no gsd-* commands visible yet; if none appear after a restart, check $CMD_DIR"
        fi
    else
        warn "could not reach the OpenCode service (/api/command) — run `opencode service restart` and re-check"
    fi
else
    warn "opencode CLI not found; skipping command-registration check"
fi

echo
ok "Done. If commands stay missing in a running TUI, restart OpenCode (it hot-reloads command files, but a stale session may need relaunch)."
