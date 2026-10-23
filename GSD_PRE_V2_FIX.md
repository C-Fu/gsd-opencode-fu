# GSD Pre-v2 Fix — Runtime Detection / agents_installed

**Date:** 2026-10-23
**Affected:** all `/gsd-*` commands, gsd-sdk (`query init.*`)
**Symptom:** every GSD workflow displayed

```
⚠ GSD agents not installed. The following agents are missing from your agents directory:
  gsd-planner, gsd-roadmapper, gsd-executor, ... (18 agents)
Proceeding without research subagents — roadmap will be generated inline.
```

even though all 33 `gsd-*` agents, ~88 `gsd-*` slash commands, and 24 skills were installed.

## Root cause

In `.opencode/sdk/dist/query/helpers.js`, the SDK resolves the agents directory like this:

```
GSD_AGENTS_DIR (env override)
  → <getRuntimeConfigDir(runtime)>/agents
      where runtime = GSD_RUNTIME env || config.runtime || 'claude'   ← the bug
```

`detectRuntime()` **defaults to `claude`** when no env var and no config key exist.
It then probes `~/.claude/agents`, which doesn't exist on this machine — while the
agents actually live at:

| Location | Contents |
|----------|----------|
| `~/.config/opencode/agents/` | 33 global `gsd-*` agents |
| `.opencode/agents/` (project) | 33 project copies |
| `~/.config/opencode/commands/` | ~88 `gsd-*` commands |
| `~/.config/opencode/skills/` + `.opencode/skills/` | 24 skills |

Nothing was missing — the SDK was just asking the wrong runtime.

## Fix

1. **Project-scoped (primary):** set `runtime` in `.planning/config.json`:

   ```json
   { "runtime": "opencode" }
   ```

   `detectRuntime()` reads this before falling back to `claude`.

2. **Shell-scoped fallback:** `export GSD_RUNTIME=opencode` in `~/.bashrc`
   (for callers that run gsd-sdk outside a project config context).

3. **Last-resort override env:** `GSD_AGENTS_DIR=/home/dietpi/.config/opencode/agents`
   (highest precedence in `resolveAgentsDir()`).

## Verification

```
$ gsd-sdk query init.new-project | grep agents_installed
  "agents_installed": true,
  "missing_agents": []
```

## Doing it again

Run the fix script from the project root (repo root — where `.planning/` lives):

```bash
bash gsd_pre_v2_fix.sh            # default runtime: opencode
bash gsd_pre_v2_fix.sh --runtime <runtime>   # any supported runtime
```

It first checks the OpenCode version — **only OpenCode v1.x is supported**
(v2 aborts with an error, since it has a different agents/install layout).
Then it checks gsd-sdk on PATH, locates the installed agents, writes `runtime`
into `.planning/config.json`, adds the `GSD_RUNTIME` export to `~/.bashrc`,
and fails loudly if verification still reports `agents_installed: false`.

## Note

If `/gsd-new-project` regenerates `.planning/config.json` via
`config-new-project`, re-run `gsd_pre_v2_fix.sh` afterwards if the
`runtime` key is dropped.
