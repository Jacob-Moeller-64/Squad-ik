---
name: agent-toolkit-protection
description: Shared toolkit-edit boundary for all non-edit agents. Only Ultimate-Ignition-edit may mutate toolkit assets under the reusable toolkit roots.
applyTo: ".github/agents/*.agent.md"
---

# Agent Toolkit Protection

This file is the single source of truth for toolkit-edit boundaries on non-edit agents.

Unless the active agent is `Ultimate-Ignition-edit`, treat the Ignition Kit surfaces as protected.

## Canonical App Identity File

The canonical app identity file is always:

```
.modernization/.readme/kit-params.md
```

**This path is the single source of truth for `appName` and all kit runtime parameters.** Scripts, agents, and prompts MUST derive `appName` from this file at runtime. No other path is valid. The path `.readme/kit-params.md` (without the `.modernization/` prefix) is a retired location and MUST NOT be used.

If a script or prompt currently reads from `.readme/kit-params.md` without the `.modernization/` prefix, treat that as a defect that must be fixed in `Ultimate-Ignition-edit` before the script can be trusted.

## Protected Toolkit Areas

Do not edit files under any of these locations while acting as any other agent:

- `/.github/**` — prompts, agents, instructions, skills, scripts
- `/.modernization/.readme/**` — developer quick-start and kit identity (including `kit-params.md`)
- `/.modernization/OpXUtil/**` — shared training and reference material
- `/.vscode/**` — workspace configuration

This keeps prompts, agents, instructions, skills, scripts, and other reusable toolkit assets owned by the dedicated edit lane (`Ultimate-Ignition-edit`).

**A non-edit agent MUST NOT edit any file in the above areas even when:**
- the user says "just fix it quickly,"
- the change appears trivial (e.g., fixing a comment or a path string),
- the request was delivered inside a modernization step prompt,
- the file is a PowerShell script under `.github/scripts/`.

The only exception is `Ultimate-Ignition-edit` itself, which is the designated toolkit maintenance agent.

## Definitive Agent List

Agents that are permitted to edit files under `/.github/**`, `/.modernization/.readme/**`, `/.modernization/OpXUtil/**`, and `/.vscode/**`:

- **`Ultimate-Ignition-edit`** — the only agent authorized to edit toolkit assets.

Every other agent — including `Ultimate-AppMod-Ignition`, `OpX-AppMod-P1-Discovery`, `OpX-AppMod-P2-Modernize`, `OpX-AppMod-P3-Review`, `OpX-Fusion-Transform`, `OpX-csharp-expert`, `OpX-csharp-janitor`, `OpX-dotnet-upgrade`, `OpX-Pre-Modernization-Test-Generator`, `OpX-QA-Hub`, `OpX-QA-Create`, `OpX-QA-Run`, `OpX-Code-Reviewer`, `OpX-Fusion-Reviewer`, `OpX-fusion-ui-component-upgrade`, `modernize-dotnet`, `Microsoft-Researcher`, and any future agent not explicitly listed above — is prohibited from editing toolkit assets.

## Terminal Command Write Boundary

The write boundary applies to terminal commands as well as direct file edits. A non-edit agent MUST NOT:

- Run `Set-Content`, `Out-File`, `Add-Content`, `tee`, or any other write command targeting a path under `/.github/**`.
- Run a PowerShell script that itself writes to `/.github/**` as a side effect.
- Use `git` commands that would stage or commit changes to toolkit files.

If a step prompt instructs running a script that would write to `/.github/**`, the non-edit agent MUST refuse that specific write, explain why, and route the user to `Ultimate-Ignition-edit` for the equivalent toolkit change.

Note: calling `qa-refresh-test-plan.ps1` or similar QA scripts that write only to `/.modernization/portal/**` or `/.modernization/ignition-artifacts/**` is **allowed** for any agent, because those targets are in the non-protected runtime artifact zone.

## Allowed Runtime Artifact Areas

Non-edit agents may still create or update runtime evidence, workflow outputs, and task-owned artifacts under these locations when their workflow requires it:

- `/.modernization/portal/**`
- `/.modernization/coverage/**`
- `/.modernization/ignition-artifacts/**` (generated evidence and reports only)
- `/.modernization/ignition-artifacts/discovery/**` (generated analysis only)
- `/.modernization/ignition-artifacts/modernize/fusion-restructure/**` (generated planning only)

Files under `/.modernization/.readme/` are **not** in this allowed zone even though they sit under `.modernization/`. That subfolder is toolkit-protected.

## Routing Rule

If the requested work appears to require editing one of the protected toolkit areas, stop and tell the user that toolkit maintenance must be done from `Ultimate-Ignition-edit`.

Do not auto-handoff, auto-route, or silently continue in another agent lane.

Tell the user to manually switch to `Ultimate-Ignition-edit` themselves before any protected toolkit edit is attempted.

The message to the user MUST name the exact file and the exact change that requires toolkit access so they can make an informed decision about switching agents.
