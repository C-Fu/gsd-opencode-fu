# GSD_FIX.md — Notes on repairing the GSD-OpenCode install

**Date:** 2026-10-21
**Package:** `gsd-opencode` v1.38.5 (installed via `npx gsd-opencode` → global scope, `~/.config/opencode/`)

## Symptoms

Inside OpenCode, none of the `/gsd-*` commands were available, and `gsd-sdk` appeared broken/missing.

## Root causes (two separate issues)

### 1. Slash commands were registered under the wrong names — `/gsd/gsd-*`, not `/gsd-*`

The v1.38.5 distribution manager installs the 88 GSD command files into a **nested subdirectory**:

```
~/.config/opencode/commands/gsd/gsd-plan-phase.md
~/.config/opencode/commands/gsd/gsd-execute-phase.md
...
```

This layout predates OpenCode V2's command discovery rules. In V2, nested paths become
**namespaced** slash commands (documented at https://opencode.ai/v2/docs/commands/):

- `commands/gsd/gsd-execute-phase.md` → `/gsd/gsd-execute-phase` (what OpenCode registered)
- instead of `/gsd-execute-phase` (what the GSD README documents and users expect)

Verified against the running service via `opencode api get /api/command`: every command was
registered as `gsd/gsd-*`, so typing `/gsd-*` found nothing — they "seemed" missing even though
the files were all present (the installer's `gsd-opencode check` reported 755/755 files intact,
which is exactly why the health check did not catch this).

**Fix:** flattened the command files:

```bash
mv ~/.config/opencode/commands/gsd/*.md ~/.config/opencode/commands/
rmdir ~/.config/opencode/commands/gsd
```

OpenCode hot-reloads command files, so the `/gsd-*` names registered immediately (confirmed via
the `/api/command` endpoint — 88 flat `gsd-*` commands, zero `gsd/gsd-*` entries).

### 2. `gsd-sdk` was a dangling symlink into the ephemeral npx cache

Running the installer via `npx gsd-opencode` leaves the "global" binaries pointing into
`~/.npm/_npx/*.*/node_modules/.bin/`, which npx may garbage-collect at any time:

```
~/.local/bin/gsd-sdk -> ~/.npm/_npx/2ada84fac427087c/node_modules/.bin/gsd-sdk   # fragile
```

Every GSD command/agent shells out to `gsd-sdk query …`; when the npx cache is pruned, all of
those calls die silently.

**Fix:** installed a pinned global copy and re-pointed the shim:

```bash
npm install -g gsd-opencode
ln -sf ~/.nvm/versions/node/v24.18.0/bin/gsd-sdk ~/.local/bin/gsd-sdk
```

Verified with `gsd-sdk query state.load` (succeeds) and `gsd-sdk --version`.

## Side notes

- `which gsd-opencode` also resolved to a **Windows npm shim** (`/mnt/c/Users/.../npm/gsd-opencode`)
  on the WSL PATH from a previous install on the Windows side. Harmless but confusing; the Linux
  binaries under `~/.nvm/.../bin` now take precedence for `gsd-sdk`.
- The installer's own health checker (`gsd-opencode check`) still expects the old nested
  `commands/gsd/` layout and will report the 88 flattened files as "missing" — this is a false
  positive caused by the checker not knowing about OpenCode V2's namespacing rules. The files
  are fine where OpenCode can find them.
- After changing GSD model profiles, note the package requires a full OpenCode restart
  (agent→model mappings come from `opencode.json` and are read at startup).

## Current state

| Item | Status |
|---|---|
| `/gsd-*` slash commands | ✅ 88 registered flat at `~/.config/opencode/commands/` |
| `gsd-sdk` CLI | ✅ stable symlink to global npm install (`~/.nvm/.../bin/gsd-sdk`) |
| Agents / skills / rules / sdk files | ✅ untouched, integrity verified |
| `gsd-opencode check` | ⚠️ reports false "missing files" (stale checker, see above) |
