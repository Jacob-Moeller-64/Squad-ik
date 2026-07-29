# Copilot Repository Instructions

Purpose: This is the repository-wide custom instructions file for this Squad-based App Modernization repo. Keep it concise, project-wide, and non-task-specific. Put narrower or file-scoped rules in `.github/instructions/*.instructions.md`.

## Repo Summary

- This repo carries a modernization Squad (`.squad/`) plus its gate/scorecard tooling (`tools/appmod/`) that modernizes the app in `LegacyCode/` into `src/`.
- `LegacyCode/` is the immutable legacy reference application - the parity answer key. Leave it untouched unless the active work explicitly targets legacy inventory, runtime verification, or in-place backend upgrade work.
- `src/<AppName>.*` and `tests/` are the modernization target workspace.
- `.squad/` is the authoritative team definition: roster (`team.md`), routing (`routing.md`), standing decisions (`decisions.md`, D-001..D-016), and agent charters.
- `.github/agents/squad.agent.md` is the Copilot coordinator entry point (`/agent squad` in an active session, or `copilot --agent squad` to launch one).
- `.github/skills/appmod-*` hold the modernization process knowledge: the phase sequence, backend/frontend traps, the Fusion target shape, and the testing/gates model.
- `tools/appmod/` holds the deterministic gate scripts and the frozen scorecard engine that prove a step is actually done - never self-declared.
- `.github/prompts/**` (the 24 numbered DEV/QA prompts), `.github/instructions/AppMod-Process.instructions.md`, and the step/artifact contracts (`.github/instructions/AppMod-Step-Contract.json`, `.github/instructions/AppMod-Artifact-Contract.json`) are the ACTIVE modernization process authority. Squad executes them as a token-efficient runner: the coordinator dispatches each step to a subagent scoped to that step's contract inputs and stops between steps for developer review. Discovery (Steps 1-6) is wired first via `.github/instructions/discovery-runner.instructions.md`. See "Process Model And Execution Layer" below.
- `.modernization/ignition-artifacts/` is the CURRENT home for Discovery and planning artifacts, restored per the original Ignition Kit convention: `discovery/` (route/UI/workflow inventories, the review manifest, baseline findings), `modernize/fusion-restructure/` (migration decisions, control-point inventory, slice status), `addendums/` (chosen architecture), plus root-level planning docs (`Modernization-Solution-Design.md`, `Modernization-Execution-Contract.md`, `Modernization-Phase-Assessment.md`) and `status/<AppName>/` run status. The human-facing compliance report family (BASELINE/FINAL compliance reports + rendered markdown, review manifests, comparison) also writes here, under `.modernization/ignition-artifacts/compliance/`. Deterministic gate tool I/O (the frozen scorecard, plus score inputs like `security-scan.json`, `dependency-eol.json`, `coverage.cobertura.xml`, `endpoint-inventory.json` goldens) stays in `tools/appmod/artifacts/` - that split is deliberate: `.modernization/ignition-artifacts/` is human-facing evidence and planning, `tools/appmod/artifacts/` is deterministic tool input/output.
- `.modernization/portal/**` (the QA Portal data location) is the active machine-artifact home for the numbered-prompt process; each step writes its portal JSONs there per `AppMod-Artifact-Contract.json`.

## Always-Use Sources

- Use `.squad/team.md` for the current roster and `.squad/routing.md` for which agent owns which kind of work.
- Use `.squad/decisions.md` (D-001..D-016) for standing policies with rationale - the auth-strangler order, Fusion MCP as sole structure authority, the frozen-scorecard rule, and more.
- Use `.github/skills/appmod-modernization-process/SKILL.md` for the phase sequence (Discovery -> Backend wave -> Frontend wave -> Fusionization -> Close-out) and the parity rules that gate it.
- Use `.github/instructions/AppMod-Artifact-Contract.json` for each step's required inputs and produced outputs, and `.github/instructions/discovery-runner.instructions.md` for how Squad runs Discovery (Steps 1-6) step-by-step with stops.
- Use `.github/instructions/step-registry.json` as the stable step identity registry. Every registered step has a 6-char hex `stepId`. Use `step:<stepId>` tokens (e.g., `step:26b4e1`) in all cross-references between prompts, instructions, agents, and scripts instead of hard-coding step numbers or names. Always translate a `stepId` to its human label (e.g., `step:26b4e1` -> `Step 3 - Legacy System Analysis`) before producing any user-facing output. Never surface raw `stepId` tokens to the user.
- Use `tools/appmod/pins.json` for version/model pins and `tools/appmod/scorecard/rubric.md` for the frozen scoring rubric (D-008 - read-only to executing agents, changes require a `tools/appmod/scorecard/VERSION` bump).
- Use `AGENTS.md` at the repo root for the thin, always-on engineering conventions every agent follows (behavior preservation, readability, testing, security, accessibility).
- Use `.github/instructions/kit-update.instructions.md` before changing reusable toolkit files under `.github/`, `.modernization/`, `.vscode/`, or `starter-deploy/`.
- Use `/.modernization/.readme/kit-params.md` for app identity when present. Do not hard-code the current app name into reusable toolkit assets.

## Process Model And Execution Layer

- The modernization PROCESS is the original Ignition Kit design: the 24 numbered prompts under `.github/prompts/**`, the machine-artifact homes under `.modernization/portal/**` and `.modernization/ignition-artifacts/**`, and the per-step producer/consumer contract in `.github/instructions/AppMod-Artifact-Contract.json` (with `AppMod-Step-Contract.json` and `AppMod-Process.instructions.md`). Stay as close to that design as possible.
- Squad (`.squad/` + `.github/agents/squad.agent.md`) is the EXECUTION LAYER, not a replacement process. Its value is token efficiency: the coordinator runs the numbered steps in order, dispatches each to a subagent scoped to only that step's contract inputs, keeps just summaries in its own context, and STOPS between steps for developer review. Discovery (Steps 1-6) is wired first via `.github/instructions/discovery-runner.instructions.md`; later phases follow the same runner pattern.
- Deliberate deviation from Ignition methodology - the compliance report is AI-only: it reads the review manifest for the file set, uses a fixed template for a consistent report shape across apps, and uses AI judgment for the complete review (`tools/appmod/gates/compliance-scan.*` + `.github/skills/appmod-compliance-review`). This replaces Ignition's deterministic `04-P1-generate-report.ps1` compliance path; the rest of each prompt runs as written.
- `tools/appmod/` gates + the frozen scorecard remain available as supplementary deterministic proof; they do not replace the numbered-step artifact contract. The pre-Squad `.github/agents/*.agent.md` roster (everything except `squad.agent.md`) is historical - Squad agents execute the prompts instead.
- `.github/skills/appmod-*` are the high-level phase map and reverse-engineering knowledge; the numbered prompts + artifact contract are the detailed step authority.

## Working Defaults

- Preserve the distinction between the Squad/tooling assets and app-specific runtime outputs.
- Keep Squad agents, skills, and gate scripts strategy-first. Encode reverse-engineering and modernization guidance as behavior families, artifact families, decision rules, and evidence-driven derivation instead of current-app controller names, route names, entity names, or labels.
- When the repo is teaching the Squad a reusable lesson, promote the portable rule into a charter, skill, or decision, and keep the current app's concrete facts in generated evidence, `kit-params.md`, or runtime artifacts under `tools/appmod/artifacts/` instead of hard-coding them into reusable assets.
- Do not create ad hoc scripts, scanners, backup files, `_debug`, `_tmp`, or `_bak` files.
- Prefer documentation-only edits when clarifying purpose, ownership, or usage; avoid changing agent handoff behavior unless the user asks for a behavior change.
- When work hits a deterministic local failure with one clear in-scope remediation, apply that remediation and rerun the affected gate before reporting blocked.
- Ask the user before stopping only when the next action needs a real product decision, destructive change, missing credential, missing external dependency, or there are multiple materially different remediation paths.
- Keep charters, skills, and gates generic and aligned with the current Discovery -> Backend -> Frontend -> Fusionization -> Close-out sequence.
- Keep `tools/appmod/gates/` behavior data-driven. Derive targets, routes, artifact families, and priorities from manifests, inventories, runtime evidence, or generated app artifacts instead of durable app-name branches or fixed route lists.
- Keep Fusion-backed modernization aligned to the starter shell throughout the run. Do not treat Fusion auth, login, caching, logging, or configuration as a late optional add-on once the target app is known to be Fusion-backed.
- Treat `/.modernization/OpXUtil/archive/**` (including `/.modernization/OpXUtil/archive/.github-archive/**`) as archival history. Do not read, search, or edit archived files unless the user explicitly asks for archive recovery or historical forensics.
- Run from the repository root when executing `tools/appmod/` scripts.
- After meaningful changes, run the smallest validation that proves the change: `python tools/appmod/gates/lib/tests/run_tests.py`, `tools/appmod/verify-kit.ps1`, or a focused gate script.
- Use `AGENTS.md` as the detailed engineering standard for behavior preservation, readability, commenting, testing, accessibility, API design, security, logging, configuration, and maintainability.
- Default to junior-readable code and comments. When in doubt, choose clearer code and clearer comments over shorter code.
- Do not assume `rg` is available in the current Windows shell. Check `Get-Command rg` first; otherwise use VS Code search tools, `grep_search`, or PowerShell `Select-String`.
- When adding a cross-reference to a numbered step in any toolkit file, look up the step in `.github/instructions/step-registry.json` and use its `stepId` token. If the step does not yet have a registered ID, add one before writing the reference (generate with `[System.Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(3)).ToLower()` and verify uniqueness against the registry).

## Build, Run, And Validation Basics

- Run `tools/appmod/` scripts from the repository root.
- If PowerShell execution policy blocks a script, use `powershell -NoProfile -ExecutionPolicy Bypass -File <script-path>`.
- Prefer the VS Code task `src: start api + client` for the normal starter-derived API and client run flow, and `legacy: run app` / `workspace: start legacy + src (hard rule)` when a runtime-parity checkpoint needs the legacy app running too.
- If the client has dependency drift, use the app's real scripts in this order: `npm run update`, then `npm run install`, then `npm run start`.
- Use Sonatype as the only npm package source for this repo. Do not switch npm commands to public registries or ad hoc alternate feeds unless the user explicitly approves a temporary exception.
- For Fusion package additions or upgrades (NuGet `Fusion.*` and npm `@fusion/*`), use the latest production version available in Sonatype feeds. Do not pin to historical examples from prior chats or docs.
- Use `/.modernization/.readme/HowToRun.md` for the developer-facing local run sequence, when still current.
- Validate scorecard/gate changes with `python tools/appmod/gates/lib/tests/run_tests.py` and `pwsh -File tools/appmod/verify-kit.ps1`.
- Treat generated `.modernization/` outputs as historical evidence unless the repo explicitly promotes them into reusable guidance.

## Customization Model

- `.github/copilot-instructions.md` is the repository-wide always-on instructions file (this file).
- `AGENTS.md` at the repo root is the thin, always-on engineering-conventions file every Squad agent loads.
- `.squad/` is the Squad definition: `team.md`, `routing.md`, `decisions.md`, and per-agent `agents/<name>/charter.md` files.
- `.github/agents/squad.agent.md` is the Copilot coordinator agent definition.
- `.github/skills/appmod-*/SKILL.md` files are the modernization-domain skills (process, backend, frontend, Fusion target, testing/gates).
- `tools/appmod/gates/` and `tools/appmod/scorecard/` are the deterministic proof mechanisms - gate scripts and the frozen scorecard engine.
- `.github/instructions/*.instructions.md` files remain path-scoped or purpose-scoped instructions where still applicable.

## Repository Layout

- `.readme/` is the developer guidance area for people using the kit on a legacy application, where still current.
- `.modernization/OpXUtil/` is the operator and maintainer utility area, including `.conversation/`, `archive/`, journaling references, and utility scripts - historical unless explicitly reused.
- `starter-deploy/` contains reusable deployment materialization assets and must stay generic.
- Leave `LegacyCode/` untouched unless the active work explicitly targets legacy inventory, runtime verification, or in-place backend upgrade work.

## Editing Policies

- Emoji is allowed in docs and prompts, but text files must stay UTF-8.
- If the repo hook blocks a change because of mojibake or encoding issues, fix the file encoding and restage.
- Do not create ad hoc scripts, scanners, backup files, `_debug`, `_tmp`, or `_bak` files.
- Use `AGENTS.md` as the detailed engineering standard for behavior preservation, readability, testing, accessibility, security, logging, configuration, and maintainability.

Trust this file for repo-wide facts. Search further only when `.squad/`, `.github/skills/appmod-*`, `tools/appmod/`, a narrower instruction file, or the current code makes more specific behavior necessary.
