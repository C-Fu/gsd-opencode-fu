#!/usr/bin/env bash
#
# gsd_pre_v2_fix.sh — Fix GSD runtime detection so gsd-sdk sees installed agents.
#
# Problem this fixes:
#   gsd-sdk's runtime detection defaults to `claude` (probing ~/.claude/agents)
#   unless GSD_RUNTIME is set or `runtime` is configured. On OpenCode setups
#   where agents are installed at ~/.config/opencode/agents (or project
#   .opencode/agents), every GSD workflow reports:
#
#     ⚠ GSD agents not installed. ... missing_agents: [...]
#
# Fix:
#   1. Set "runtime": "opencode" in .planning/config.json (project-scoped).
#   2. Set GSD_RUNTIME=opencode in ~/.bashrc (shell-scoped fallback).
#   3. Verify with `gsd-sdk query init.new-project | jq .agents_installed`.
#
# Usage:
#   bash gsd_pre_v2_fix.sh [--runtime opencode]
#
set -u

RUNTIME="opencode"
if [[ "${1:-}" == "--runtime" && -n "${2:-}" ]]; then
  RUNTIME="$2"
fi

fail() { echo "ERROR: $1" >&2; exit 1; }
ok()   { echo "  OK: $1"; }

echo "== gsd_pre_v2_fix: runtime=${RUNTIME} =="

# 0. Runtime version guard — this fix targets OpenCode v1.x ONLY.
#    (v2 has a different agents/install layout; running this against v2
#     could write wrong config keys.)
command -v opencode >/dev/null 2>&1 \
  || fail "opencode binary not found on PATH — expected an OpenCode environment."
OC_VERSION_RAW=$(opencode --version 2>/dev/null || opencode -v 2>/dev/null || true)
OC_VERSION=$(echo "$OC_VERSION_RAW" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
[[ -n "$OC_VERSION" ]] || fail "Could not determine opencode version (got: '${OC_VERSION_RAW}'). Not applying v1 fix."
OC_MAJOR=${OC_VERSION%%.*}
if [[ "$OC_MAJOR" -ge 2 ]]; then
  fail "OpenCode v${OC_VERSION} detected (v2+). gsd_pre_v2_fix only applies to opencode v1.x — do NOT run this fix on v2."
fi
ok "opencode version ${OC_VERSION} (v1.x) — fix applies"

# 1. gsd-sdk must be on PATH
command -v gsd-sdk >/dev/null 2>&1 \
  || fail "gsd-sdk not found on PATH. Install GSD first (npx gsd-opencode@latest --global)."
ok "gsd-sdk found on PATH"

# 2. Agents must exist somewhere reachable
GLOBAL_AGENTS="${HOME}/.config/${RUNTIME}/agents"
PROJECT_AGENTS="${PWD}/.${RUNTIME}/agents"
if [[ -d "$GLOBAL_AGENTS" && -n "$(ls "$GLOBAL_AGENTS" 2>/dev/null)" ]]; then
  AGENTS_DIR="$GLOBAL_AGENTS"
elif [[ -d "$PROJECT_AGENTS" && -n "$(ls "$PROJECT_AGENTS" 2>/dev/null)" ]]; then
  AGENTS_DIR="$PROJECT_AGENTS"
else
  fail "No agents directory found (looked at: ${GLOBAL_AGENTS}, ${PROJECT_AGENTS}). Run: npx gsd-opencode@latest --global"
fi
AGENT_COUNT=$(ls "$AGENTS_DIR" | grep -c '^gsd-')
ok "agents directory: ${AGENTS_DIR} (${AGENT_COUNT} gsd agents)"

# 3. Persist runtime in project config (the actual fix)
mkdir -p .planning
if [[ -f .planning/config.json ]]; then
  node -e '
    const fs = require("fs");
    const f = ".planning/config.json";
    const c = JSON.parse(fs.readFileSync(f, "utf8"));
    c.runtime = process.argv[1];
    fs.writeFileSync(f, JSON.stringify(c, null, 2) + "\n");
  ' "$RUNTIME"
else
  node -e '
    const fs = require("fs");
    fs.writeFileSync(".planning/config.json",
      JSON.stringify({ runtime: process.argv[1] }, null, 2) + "\n");
  ' "$RUNTIME"
fi
ok "runtime=${RUNTIME} written to .planning/config.json"

# 4. Shell fallback: export GSD_RUNTIME for tooling that bypasses the config file
if ! grep -qs "export GSD_RUNTIME=" ~/.bashrc; then
  printf '\n# GSD: make gsd-sdk detect the %s runtime (agents_installed fix)\nexport GSD_RUNTIME=%s\n' "$RUNTIME" "$RUNTIME" >> ~/.bashrc
  ok 'GSD_RUNTIME=opencode added to ~/.bashrc'
else
  ok "GSD_RUNTIME already exported in ~/.bashrc"
fi
export GSD_RUNTIME="$RUNTIME"

# 5. Verify
VERIFY=$(gsd-sdk query init.new-project 2>/dev/null || true)
if echo "$VERIFY" | grep -q '"agents_installed": true'; then
  ok "gsd-sdk now reports agents_installed: true"
else
  echo "$VERIFY"
  fail "Verification failed — agents_installed is still false. Set GSD_AGENTS_DIR=${AGENTS_DIR} as a last resort."
fi

# 6. Sanity: workflow commands present?
CMD_COUNT=$(ls "${HOME}/.config/${RUNTIME}/commands" 2>/dev/null | grep -ci '^gsd')
ok "gsd slash commands visible for runtime: ${CMD_COUNT}"

echo "== done =="
