# Ignition Kit import (photo transcriptions)

Prompts from the OpX-Ignition-Kit, transcribed from screen photographs supplied by the
kit owner (work-machine transfer restrictions prevent direct file transfer). Content is
reconstructed faithfully; per-file transcription uncertainties are listed below.
No credentials appear in these files (env-var *names* like SONATYPE_USERNAME are
references, not values).

## Index

| File | Phase/Step | Status |
|---|---|---|
| `prompts/01-P1-workstation-readiness.prompt.md` | P1 Discovery, Step 1 | transcribed from 2 photos |
| `prompts/02-P1-rename-starter-to-appname.prompt.md` | P1 Discovery, Step 2 | transcribed from 3 photos |
| `prompts/03-P1-legacy-system-analysis.prompt.md` | P1 Discovery, Step 3 | transcribed from 6 photos |
| `prompts/04-P1-baseline-acceptance-criteria-review.prompt.md` | P1 Discovery, Step 4 | transcribed from 4 photos |
| `prompts/05-P1-modernization-solution-design.prompt.md` | P1 Discovery, Step 5 | transcribed from 7 photos; 2 values redacted (see below) |
| `prompts/06-P1-modernization-quality-design.prompt.md` | P1 Discovery, Step 6 | transcribed from 13 photos |
| `prompts/07-P2-backend-upgrade-dotnet.prompt.md` | P2 Modernize, Step 7 DEV | transcribed from 7 photos |
| `prompts/08-P2-backend-modernization-formation.prompt.md` | P2 Modernize, Step 8 DEV | transcribed from 11 photos |
| `prompts/09-P2-backend-dotnet-integration-hardening.prompt.md` | P2 Modernize, Step 9 DEV | transcribed from 4 photos |
| `prompts/10-P2-frontend-foundation-and-scaffold.prompt.md` | P2 Modernize, Step 10 DEV | transcribed from 8 photos |
| `prompts/11-P2-frontend-migration.prompt.md` | P2 Modernize, Step 11 DEV | transcribed from 4 photos |
| `prompts/12-P2-frontend-platform-integration.prompt.md` | P2 Modernize, Step 12 DEV | transcribed from 9 photos |
| `prompts/13-P2-frontend-shell-stabilization.prompt.md` | P2 Modernize, Step 13 DEV | transcribed from 5 photos |
| `prompts/14-P2-frontend-ui-inventory-and-fusion-map.prompt.md` | P2 Modernize, Step 14 DEV | transcribed from 4 photos |
| `prompts/15-P2-fusion-ui-integration.prompt.md` | P2 Modernize, Step 15 DEV | transcribed from 4 photos |
| `prompts/16-P2-next-fusion-ui-upgrade-slice.prompt.md` | P2 Modernize, Step 16 DEV | transcribed from 3 photos |
| `prompts/17-P2-rewire-all-tests-and-verify.prompt.md` | P2 Modernize, Step 17 DEV | transcribed from 9 photos |
| `prompts/18-P2-deployment-and-clean-up.prompt.md` | P2 Modernize, Step 18 DEV | transcribed from 3 photos |
| `prompts/19-P3-final-fusion-restructure-review.prompt.md` | **P3 Review**, Step 19 | transcribed from 1 photo |
| `prompts/20-P3-final-verification.prompt.md` | P3 Review, Step 20 | transcribed from 2 photos |
| `prompts/21-P3-figma-review.prompt.md` | P3 Review, Step 21 | transcribed from 2 photos |
| `prompts/22-P3-final-acceptance-criteria-review.prompt.md` | P3 Review, Step 22 | transcribed from 2 photos |
| `prompts/23-P3-final-readiness-review.prompt.md` | P3 Review, Step 23 | transcribed from 2 photos |
| `prompts/24-P3-technical-review.prompt.md` | P3 Review, Step 24 | transcribed from 27 photos (5 were a re-shot of an already-captured range); complete — 16 heading line numbers spot-verified against the source |

### Agents

| File | Role | Status |
|---|---|---|
| `agents/OpX-AppMod-P1-Discovery.agent.md` | Phase 1 Discovery coordinator (Steps 1-6) | transcribed from 2 photos — complete (source lines 1-102, blank to 113) |
| `agents/OpX-AppMod-P2-Modernize.agent.md` | Phase 2 Modernize coordinator (Steps 7-18) | transcribed from 3 photos — complete (source lines 1-136, blank to 140) |
| `agents/OpX-AppMod-P3-Review.agent.md` | Phase 3 Review coordinator (Steps 19-24) | transcribed from 2 photos — complete (source lines 1-82, blank to 83) |
| `agents/OpX-csharp-expert.agent.md` | .NET coding-violations fixer (specialist, user-invocable) | transcribed from 8 photos — complete (source lines 1-437, blank to 439); 20 heading line numbers spot-verified |
| `agents/OpX-csharp-janitor.agent.md` | .NET cleanup / quick-wins specialist (user-invocable) | transcribed from 5 photos — complete (source lines 1-275, blank to 277); 18 heading line numbers spot-verified. **Source file is currently broken — 3 YAML errors, see findings** |
| `agents/OpX-dotnet-upgrade.agent.md` | .NET Framework → .NET 10 upgrade specialist (Step 7 lane) | transcribed from 6 photos — complete (source lines 1-287); 25 heading line numbers spot-verified |
| `agents/OpX-Frontend-Angular-Transform.agent.md` | **Archived** compatibility redirect for the retired Angular specialist lane | transcribed from 1 photo — complete (source lines 1-50, blank to 51) |
| `agents/OpX-Fusion-Reviewer.agent.md` | Fusion restructure reviewer (Step 19 lane) | transcribed from 2 photos — complete (source lines 1-90, blank to 92); 16 heading line numbers spot-verified |
| `agents/OpX-fusion-ui-component-upgrade.agent.md` | Fusion UI slice executor (Steps 15-16 lane) | transcribed from 1 photo — complete (source lines 1-57, blank to 59); 12 heading line numbers spot-verified |
| `agents/Ultimate-AppMod-Ignition.agent.md` | Top-level modernization orchestrator | transcribed from 2 photos — complete (source lines 1-95, blank to 96); 21 heading line numbers spot-verified |
| `agents/Ultimate-Ignition-edit.agent.md` | Kit-maintenance agent (edits the toolkit itself) | transcribed from 2 photos — complete (source lines 1-93, blank to 94); 26 heading line numbers spot-verified. **Frontmatter is byte-identical to `Ultimate-AppMod-Ignition` except the `name:` line — see findings** |

## Structural facts about the Ignition Kit learned from transcription

- Prompts are **VS Code Copilot prompt files** (`.github/prompts/NN-Px-name.prompt.md`)
  with frontmatter: description, name, argument-hint, **agent** (per-phase custom agents,
  e.g. `OpX-AppMod-P1-Discovery`), and a tools allowlist.
- Steps carry **per-prompt model-tier recommendations** ("Light (low thinking)") and
  estimated run times.
- The kit already has **artifact gates**: `.github/scripts/shared/verify-step-artifacts.ps1
  -Step N -Mode Input|Output` with `RESULT: OK` (exit 0) / `RESULT: BLOCKED` (exit 2) —
  input prechecks and output verification per step.
- **Step registry**: `/.github/instructions/step-registry.json` maps opaque step ids
  (e.g. `step:1fc2ba`) to human labels; prompts reference next steps by id.
- **State tracking**: `step-workflow-state.json` with a mandated human-readable readback
  block (Updated At / Recorded Step / Recommended Next Step).
- Conventions: legacy app copied to `LegacyCode/`; target is `src/<AppName>.Web.Api`
  (dotnet, **Scalar at https://localhost:4200/scalar**) + `src/<AppName>.Web.Client`
  (npm, https://localhost:5001). Docs under `/.modernization/.readme/`
  (Prerequisites.md, HowToRun.md). Package source: Sonatype (env creds + .npmrc/NuGet
  source checks). "Fusion G1" identifies a legacy Fusion generation.

## Structural facts added by prompt 02

- **The real Fusion Starter Kit layout** (corrects the reference kit's assumed
  `src/{Library,API,Client}`): `src/<App>.Library`, `src/<App>.Web.Api`,
  `src/<App>.Web.Client` — PascalCase backend naming, client as an `.esproj`
  (JS project system), scaffolded from `Starter.*` templates that Step 2 relabels.
- **Client baseline policy**: Angular even-major baseline, currently **Angular 20**.
- **Fusion specifics**: `AppInfo.xml` per project; `appsettings.json` Fusion keys
  (`Fusion.DataDirectory.PathBase`, `Fusion.Web.Api.OpenApi.Title`,
  `Fusion.Web.Client.Config.ApplicationName`); `<fusion-header label>` component;
  per-environment `fusion.config.*.ts` (e.g. `.dvl`) carrying Fusion OAuth hostnames
  that MUST NOT change during identity rename (later auth step owns them).
- **Run params**: `/.modernization/.readme/kit-params.md` holds `appName`;
  `.StepSummary.md` is a per-run human-readable step log; toolkit self-edits governed
  by `/.github/instructions/kit-update.instructions.md`.
- **Dual-surface completion model** (step 2): `physicalRenameStatus` +
  `referenceRewriteStatus` must both pass or the step reports `Blocked` — a
  two-column done-definition, not a single flag.
- Step ids observed: `step:1fc2ba`, `step:261769`.

## Structural facts added by prompt 03

- **Per-prompt model pins in frontmatter**: Step 3 carries `model: Claude Opus 4.6 (copilot)`
  directly in the prompt-file frontmatter — the kit pins specific models per step, not just
  tier hints in prose. (Step 3's prose tier is "Premium reasoning (high thinking)", 20-40 min.)
- **Schema contract versioning**: `step3ArtifactSchemaContractVersion: 1.0.1` in the prompt
  must match `.github/skills/step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md`
  — schemas are versioned artifacts owned by a *skill folder*, and prompts only keep an
  inline "minimum field floor". The kit has `.github/skills/` (screenshot-capture with
  SKILL.md + scripts/, step3-legacy-system-analysis with references/).
- **Hard Stops pattern**: numbered STOP gates inside the prompt (STOP 1 live-QA-URL
  resolution with exact priority order currentQaUrl → currentDevUrl → ask in chat → halt,
  plus a mandatory `qaUrlSource` echo; STOP 2 preflight limited to step-owned inputs, with
  non-step dependencies reported as "contract drift blockers"; STOP 2.5 modality branch;
  STOP 3 artifact completeness). STOP 2.5 classifies `detectedModality` as
  `api-only|mvc|spa|hybrid` from deterministic file-evidence criteria and everything
  downstream (artifact requiredness, response sections) branches on it.
- **Portal report system**: `.modernization/portal/data/json/` holds 9 named JSON reports
  (legacy-system-analysis, manifest-coverage, current-state-classification,
  runtime-topology, integration-contract-catalog, environment-and-secrets-map,
  data-and-cutover-risk, gap-and-exception-register, leadership-summary) seeded as
  skeletons by scripts and *enriched* by the agent; screenshots live under
  `.modernization/portal/data/images/<page>/`; portal publication is manual-only and
  never part of the done-definition. State files `step-workflow-state.json` and
  `step-response-ledger.json` also live under portal data and are written gate-authoritatively.
- **Ignition artifact layout**: structured analysis artifacts live in
  `.modernization/ignition-artifacts/discovery/` (service-behavior-inventory,
  interaction-wiring-inventory, workflow-trace-inventory) and
  `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json`
  (apiEndpointCatalog, uiControlClassification, fusionPrimitiveCoverageCensus fields).
  Every entry must carry `legacyEvidence` with a real file path + line range; no
  fabricated placeholder rows.
- **Modality applicability matrix**: a Required/Conditional/notApplicable grid per
  artifact × modality feeds STOP 3; `notApplicable` artifacts must still exist with an
  explicit `{notApplicable: true, reason}` marker — absence is never a valid encoding.
- **Screenshot progression rule**: partial capture may proceed only with (1) ≥1 image,
  (2) explicit user review, (3) explicit user approval; zero images + none user-provided
  = blocked. User evidence goes under `.modernization/.readme/user-provided-info/` and is
  referenced as `captured-user-provided` matrix rows.
- **Legacy Visual Contract Capture**: Step 3 extracts a `legacyVisualContract` block
  (palette, typography, shellChromeRegions, navRouteModel, controlAndLabelRules, per-route
  field sets with `headerLabel`+`boundField`) in two layers — static (always, from source)
  and runtime (Playwright computed styles + per-route reference screenshots when the app
  is reachable; `runtimeMeasured: false` marker when not). Step 5 consolidates it into
  `.modernization/fusion-restructure/styling-foundation.json` + `ui-visual-contract.json`;
  Step 13 uses it as the field-parity/visual-parity answer key ("column-collapse parity
  defect" is a named failure class).
- **Deterministic response shape**: 10 exact response headings in fixed order with
  placeholder vocabulary (`NotApplicable`/`NoneDetected`/`Blocked`), mandatory counts
  (`cannotLocateCount`, `unknownBacklogCount`, `blockedArtifactCount`), and a fixed
  closing sentence for the readiness decision — response format is contract, not style.
- **Gate statuses**: the step gate yields three axes (`scanCoverageStatus`,
  `traceabilityStatus`, `planningReadinessStatus`), each `Ready|Constrained|Blocked`;
  `Constrained` still allows planning to proceed, `Blocked` stops Step 4.
- **Governing Sources section**: prompts end by delegating policy to canonical
  `.github/instructions/*.instructions.md` files (AppMod-Process,
  ui-capture-reverse-engineering, testing-design-contract, fusion-restructure,
  qa-portal-reporting, appmod-phase-agent-contract) + `.github/skills/*/SKILL.md` —
  "do not re-derive the rules here".
- **Config/deployment conventions**: `connectionStringRuntimeInput` in kit-params.md;
  `OCPEnv` is the default final-state mode (alternatives `OpX`, `LocalIntegrated`/`OpEx`);
  default split SQL env var names `SqlServer__Server|Database|Username|Password|Encrypt|TrustServerCertificate`
  for the OpenShift/Kubernetes final state; Dapper row-model type hints
  (`dbParameterTypeHints[]`, `dbResultColumnTypeHints[]`) captured at discovery for
  Steps 8-9.

## Structural facts added by agent `Ultimate-Ignition-edit`

The kit-maintenance agent — the only identity permitted to modify toolkit files, named as the
escalation target by `OpX-AppMod-P1-Discovery`. 93 lines.

- **Its Primary Role is the inverse of every other agent's**: "making changes directly to the
  Ignition Kit itself — prompts, agents, scripts, instructions, skills, and modernization
  guidance files under `.github/` and `.modernization/`." Every other agent is forbidden from
  exactly this.
- **A two-tier reference-loading contract.** *Always load*:
  `.github/instructions/kit-update.instructions.md` (kit structure, reusable asset boundaries,
  naming, validation) and `.github/skills/ignition-kit-maintenance/SKILL.md`. *Load on demand*,
  four more, each gated on what the user asked for.
- **Keyword-triggered lazy loading**, spelled out with the literal trigger phrases:
  | Reference | Triggers |
  |---|---|
  | AppMod-Process | "edit step", "change workflow", "update 24-step", "new phase", "routing" |
  | Architecture-Structure | "restructure", "formation", "move to src", "LegacyCode-to-src" |
  | PowerShell-Maintenance | ".ps1", "script", "powershell" |
  | Branch-Integration | "sync", "merge", "branch", "integrate", "propagate" |

  With the rationale stated: "This prevents unnecessary context loading when the task doesn't
  actually require those domains." This is the most token-conscious design in the kit and the
  pattern worth copying elsewhere.
- **"update 24-step"** as a literal trigger phrase confirms 24 is the current, intended step
  count.
- **A Branch Sync Policy**: syncing a non-main validation branch into `main` or `main-dev`
  defaults to **toolkit-only integration**, excluding `LegacyCode/**`, `src/**`, and
  local-only runtime or generated folders under `/.modernization/**`. So the kit is developed
  on validation branches against a real app and only the toolkit is merged back — which is
  exactly the workflow this transcription effort is reconstructing.
- **Three more instruction files**: `kit-update.instructions.md`,
  `AppMod-Process.instructions.md`, `powershell-script-maintenance.instructions.md`. **Two
  more skill surfaces**: `ignition-kit-maintenance/SKILL.md` and its
  `references/branch-integration-policy.md`.

## ⚠ Findings in `Ultimate-Ignition-edit.agent.md`

**1. HIGHEST RISK FOR THE HACKATHON — this agent is indistinguishable from the orchestrator in
an agent picker.**

Lines 1-32 of `Ultimate-Ignition-edit.agent.md` and `Ultimate-AppMod-Ignition.agent.md` are
**byte-identical except for the `name:` line** (verified by diff). Both declare:

```
description: Ultimate agent for application modernization using the DE App Mod process with Fusion
argument-hint: Outline the goal or problem to research
```

…and the same 26 tools, including `edit`, `web/fetch`, `vscode/installExtension`, and
`vscode/newWorkspace`.

The kit-maintenance agent's description was copied from the orchestrator and never updated. It
describes a job this agent does not do. In any UI that lists agents by name + description, a
developer sees two entries whose descriptions are identical, one of which **rewrites the
toolkit itself**. The body (line 36) is correct — but by then the agent has already been
selected.

For a hackathon with 40 participants sharing one kit, this is the defect most likely to cause
real damage: a participant picks `Ultimate-Ignition-edit` expecting to modernize their app,
and instead gets an agent whose stated primary job is editing `.github/`. Every other agent in
the kit has a Write Boundary specifically to prevent that; this one is the exception, and its
description hides it. **A one-line description fix removes the entire risk class.**

**2. The kit violates its own maintenance contract — in three places, all already documented
above.**

> **Consistency Rule**: Any change to modernization processes, steps, agents, prompts, or file
> structure **must be propagated across all files** … Remove all stale references to old
> processes, retired steps, or former file locations … **every file in the repo must stay
> consistent**.
> **Consistency Enforcement**: If a file path was renamed, update all references and delete the
> old location (**no redirect shims**).

Against that standard, the kit currently contains:

| Violation | Evidence |
|---|---|
| Stale references to retired steps | The +2 drift in prompts 12-16, 19-21, `OpX-AppMod-P2-Modernize` line 113, and `OpX-Frontend-Angular-Transform`'s entire Core Rules block |
| A retired file not deleted | `OpX-Frontend-Angular-Transform.agent.md`, archived but still installed in `.github/agents/` |
| A redirect shim | `step9UpgradeWorkspaceRoot` as fallback for `step7UpgradeWorkspaceRoot`, four times in `OpX-dotnet-upgrade` |

This is useful rather than merely ironic: **the kit already contains the written standard the
cleanup should be measured against.** The fix list does not need to be invented — it needs to
be enforced. Note the redirect-shim rule and the `step9` fallback are in genuine conflict, so
that one needs a human decision (keep the shim and amend the rule, or drop the shim and
migrate the artifacts).

**3. The Consistency Rule and Consistency Enforcement disagree about scope.**
Line 58 says changes must propagate across `.github/` and `.modernization/`. Line 80 says to
verify propagation across `.github/` and `.modernization/OpXUtil/**`. The second is a strict
subset of the first, in the same file, describing the same obligation.

**4. A seventh frontmatter variant** — no opening `---`, `argument-hint` present, no
`handoffs`, no `agents`. Identical in shape to `Ultimate-AppMod-Ignition`, which is the point
of finding 1.

## Transcription uncertainties (agent `Ultimate-Ignition-edit`)

- Line alignment verified at 26 anchors — 30, 32, 34, 36, 38, 40, 42, 44, 47, 49, 54, 56, 58,
  60, 62, 64, 66, 70, 72, 74, 76, 78, 84, 86, 88, 93 — all matching. Content ends at 93; the
  editor shows line 94 blank.
- **Source line 31 is blank before the closing `---` at line 32**, matching
  `Ultimate-AppMod-Ignition` exactly.
- Lines 36-37, 58-59 and 64-65 wrap in the editor; reconstructed from wrap positions.
- The frontmatter was verified against `Ultimate-AppMod-Ignition` by direct diff rather than by
  eye; the two are identical on lines 2-32.
- No mojibake anywhere in this file.

## Structural facts added by agent `Ultimate-AppMod-Ignition`

The top-level orchestrator — the identity `OpX-Frontend-Angular-Transform` hands back to via
"Back To Orchestrator". 95 lines, and structurally unlike every other agent in the kit.

- **`OpX` = `OpEx`.** Line 36 spells it out: "the **OpEx** Ignition Kit". The agent-name prefix
  is Operational Excellence.
- **A new process name: "the DE App Mod process"** (in the `description`). Not defined
  anywhere else transcribed so far.
- **The target stack is named explicitly**: "the **Fusion Generation 2** stack
  (**Angular 19+ / .NET 10**)". This is the first place the Fusion generation is stated for
  the *target* rather than the legacy source — prompt 01 mentioned "Fusion G1" as a legacy
  generation.
- **26 declared tools — by far the largest allowlist in the kit**, and the only one with
  outbound and workspace-mutating powers: `web/fetch`, `web/githubRepo`,
  `microsoftdocs/mcp/*`, `vscode/installExtension`, `vscode/newWorkspace`,
  `vscode/getProjectSetupInfo`, `execute/createAndRunTask`, `execute/runNotebookCell`,
  `read/getNotebookSummary`, `execute/testFailure`, `read/problems`, `search/changes`,
  `search/usages`, `vscode/extensions`, `ms-azuretools.vscode-containers/containerToolsConfig`,
  plus coarse `edit`, `search`, `todo`, `agent`.
- **`argument-hint: Outline the goal or problem to research`** — a frontmatter field seen on
  prompt files but on no other agent.
- **A File Protection Policy written as MAY / MUST NOT lists plus a rule of thumb**:
  > If a file defines *how the kit works*, do not touch it. If a file is *generated output or
  > evidence from the modernization process*, you may edit it.
  > When in doubt, **read but do not edit**.

  This is the clearest statement of the kit-protection intent anywhere, and it is the only
  place that explains *why* the boundary sits where it does.
- **Four generic problem-solving phases** layered on the shared baseline: Analyze & Plan,
  **Adversarial Review** (challenge assumptions, identify failure points, consider
  alternatives, stress-test edge cases), Implement & Validate, Verify & Complete — plus a
  four-item Modernization-Specific Checklist.
- **The shared baseline contract has five named sections**: Communication, Execution, Web
  Research, Obstacle Handling, Completion Gate — all living in
  `appmod-agent-personality-baseline.instructions.md`.

## ⚠ Findings in `Ultimate-AppMod-Ignition.agent.md`

**1. The orchestrator has no knowledge of the 24-step pipeline, and no way to route into it.**
This file contains **zero references to any numbered step**, no `handoffs:` block, and no
`agents:` key. Yet `OpX-Frontend-Angular-Transform` sends users here with
"Back To Orchestrator" and "Build & Run Modern App". A developer returning to "the main
workflow" lands in an agent that has never heard of Step 10, cannot present a step menu, and
cannot hand off to `OpX-AppMod-P1-Discovery` / `-P2-Modernize` / `-P3-Review`. It is a
general-purpose modernization agent wearing the orchestrator's name — the routing layer lives
entirely in the three phase coordinators, which this file does not mention.

**2. Angular version conflict across three files.**

| File | Stated target |
|---|---|
| `Ultimate-AppMod-Ignition` | Fusion Generation 2, **Angular 19+** |
| prompt 02 (rename starter) | "Angular even-major baseline, currently **Angular 20**" |
| prompt 24 (technical review) | "**Angular 20+**" |

"Angular 19+" is technically satisfied by 20, but 19 is an *odd* major and prompt 02 states
the baseline policy is **even-major**. So the orchestrator's floor contradicts the kit's own
stated versioning policy. One of these is the source of truth; right now a model can justify
either.

**3. The kit-maintenance agent is referenced generically, not by name.**
> If a task requires changes to kit infrastructure, tell the user to use **the kit-maintenance
> agent** instead.

`OpX-AppMod-P1-Discovery` names it precisely — "tell the user to switch to
`Ultimate-Ignition-edit`". Here the model has to guess which agent that is. Two files
describing the same escalation, one with an identifier and one without.

**4. The `.modernization/` boundary is stated by intent, not by path — and it is the one
boundary that actually needs paths.**
The MAY list permits "QA portal pages and generated reports under `.modernization/`"; the
MUST NOT list forbids "Kit infrastructure files under `.modernization/`". Both are the same
directory, separated only by a judgement call about what counts as infrastructure.
`OpX-AppMod-P1-Discovery` does this correctly with globs
(`/.modernization/.readme/**`, `/.modernization/OpXUtil/**`). The rule of thumb here is a good
*explanation*, but it is not machine-checkable and it is the boundary a model is most likely
to get wrong under pressure.

**5. A sixth frontmatter variant.** No opening `---` (coordinator-style), but also no
`handoffs`, no `agents`, and a unique `argument-hint` field. Across ten agent files the
frontmatter now varies on five independent axes.

## Transcription uncertainties (agent `Ultimate-AppMod-Ignition`)

- Line alignment verified at 21 anchors — 30, 32, 34, 36, 38, 40, 42, 44, 50, 54, 56, 58, 60,
  66, 73, 79, 84, 88, 90, 92, 95 — all matching. Content ends at 95; the editor shows line 96
  blank.
- **Source line 31 is blank, immediately before the closing `---` at line 32.** Transcribed as
  photographed. `OpX-Frontend-Angular-Transform` shows the same blank-before-close pattern.
- Lines 36-37 and 51-53 wrap in the editor; reconstructed from wrap positions.
- The em dash in "application code — the actual modernization work" is transcribed as an em
  dash; at photo resolution it could be a double hyphen.
- No mojibake anywhere in this file.

## Structural facts added by agent `OpX-fusion-ui-component-upgrade`

The Steps 15-16 Fusion UI execution lane. 57 lines, and the densest file in the kit for
concrete Fusion facts.

- **The real Fusion Angular package name: `@fusion/ngx-fusion`.** First time the actual npm
  scope and package appear anywhere in the transcribed material.
- **The slice loop is a real task graph, not prose.** `ui-fusion-map.json` carries a
  `taskGraph` and a `completedTaskIds` list; the agent derives "the next eligible task" from
  those plus dependency order. That is what makes Step 16 ("Next Fusion UI Upgrade Slice")
  re-runnable — it is a worklist drain, and the artifact is the cursor.
- **A companion markdown artifact**: `ui-fusion-task-list.md`, alongside the JSON map. One of
  very few `.md` artifacts in a mostly-JSON artifact set (the other is Step 24's
  `technical-review-report.md`).
- **One slice per run, enforced**: "Execute exactly one route-local or shell-local slice."
- **Validation is the real client build**: `npm run build`, run as "the first validation
  action after the first substantive edit" — before any artifact reconciliation. Artifacts
  update *only after* validation passes.
- **Target surface named precisely**: `src/<AppName>.Web.Client/src/app/**`.
- **A fourteenth named surface: `OpX-Fusion-Transform`** — the sole handoff target
  ("Back To Restructure Workflow"). Distinct from the archived
  `OpX-Frontend-Angular-Transform`.
- **A new skill**: `.github/skills/fusion-ui-component-upgrade/SKILL.md`, loaded "before
  selecting or editing any route surface" — same skill-owns-method / agent-owns-execution
  split as `OpX-Fusion-Reviewer`.
- **Third file to guard the retired Fusion-only state tracker**: "Do not create or rely on a
  retired parallel Fusion-only state tracker as numbered-step state; the numbered workflow
  artifacts remain authoritative." (`OpX-Fusion-Reviewer` and `OpX-AppMod-P2-Modernize` carry
  the same rule.)
- **Its step numbers are correct.** The description names Steps 15 and 16 and they match
  `15-P2-fusion-ui-integration` and `16-P2-next-fusion-ui-upgrade-slice`; the execution
  contract's "step-14 UI inventory and Fusion map artifacts" matches
  `14-P2-frontend-ui-inventory-and-fusion-map`. No drift in this file.
- **The reporting contract names the exact button to click** (`Back To Restructure Workflow`)
  rather than describing it — the only agent that closes the loop that precisely.

## ⚠ Findings in `OpX-fusion-ui-component-upgrade.agent.md`

**1. Its only handoff points at an agent not yet seen — `OpX-Fusion-Transform`.**
This is the agent's sole exit, and the Reporting Contract instructs the model to tell the user
to click it by name. If `OpX-Fusion-Transform` does not exist in `.github/agents/`, this lane
is a dead end and the closing instruction is unfollowable. Note the kit already contains an
*archived* `OpX-Frontend-Angular-Transform` whose job was to redirect away from a retired
frontend lane — so a stale reference here is plausible. **Needs a directory listing of
`.github/agents/` to confirm; flagged, not assumed.**

**2. The description covers Steps 15 *and* 16; the Mission covers only Step 16.**

> `description:` "Runs the **Step 15** Fusion UI Integration **and Step 16** Next Fusion UI
> Upgrade Slice lane…"
> `## Mission` — "Execute exactly one artifact-driven Fusion UI slice during restructure
> **Step 16**."

Step 15 is the initial Fusion UI integration; Step 16 is the repeatable next-slice drain.
They are different jobs, and the Mission — the part the model actually acts on — only claims
one of them. Either Step 15 has no execution lane of its own, or the Mission is under-scoped.

**3. `description` is a quoted YAML string; every other agent's is unquoted.** Harmless, but
it is the fifth distinct frontmatter convention observed across nine agent files
(opening-`---` or not, `user-invocable` or not, `handoffs` or not, `agents` or not, quoted
`description` or not).

## Transcription uncertainties (agent `OpX-fusion-ui-component-upgrade`)

- Line alignment verified at 12 anchors — 17, 19, 21, 23, 25, 28, 30, 37, 39, 47, 49, 51 —
  all matching.
- **The exact end line is approximate.** The seven Reporting Contract bullets are transcribed
  consecutively as lines 51-57, which is consistent with every verified anchor above them and
  with the editor showing blanks at 58-59. The photo's gutter in that region was not legible
  enough to rule out a blank line between the last two bullets, which would shift the final
  line to 58.
- Line 3 (`description`) wraps across three editor rows; reconstructed from wrap positions.
- No mojibake anywhere in this file.

## Structural facts added by agent `OpX-Fusion-Reviewer`

The Step 19 review lane, and the first agent with a genuinely clean separation between
*method* and *execution*. 90 lines, zero numbering defects, zero mojibake.

- **A fourth frontmatter variant**: opens with `---`, but has **no `user-invocable`, no
  `handoffs:`, and no `agents:` key** — only `name`, `description`, `tools`. It is the
  minimal agent shape in the kit.
- **Explicit skill/agent separation**, stated as a contract:
  > - the **skill** owns the review method
  > - this **agent** executes the review as a named restructure checkpoint
  > - when the caller asks for fixes, only apply the skill's safe-remediation rules

  This is the cleanest division of responsibility anywhere in the kit — the rubric lives in
  `.github/skills/fusion-restructure-review/SKILL.md` and is versioned independently of the
  lane that runs it.
- **A documented evidence precedence order**, in the description: Fusion MCP docs first, then
  the current starter shell, then `Original_Starter_kit` or `SimpleArchitectureExample` as
  **reference-only comparators**. Two more named reference surfaces.
- **Two more skills**: `.github/skills/fusion-restructure-review/SKILL.md` and
  `.github/skills/architecture-structure/SKILL.md`. One more instructions file:
  `.github/instructions/modernization-starter-boundaries.instructions.md`.
- **Seven required inputs and nine optional ones**, all named explicitly — the most precise
  input contract of any agent so far.
- **A required platform-status report covering exactly the integrations that matter for the
  hackathon**: Okta / auth, Scalar / OpenAPI, Fusion logging, Fusion config / appsettings,
  startup / DI composition, protected HTTP transport. This is the single place in the kit
  where "did Scalar and Okta actually land correctly?" is a mandatory reported field.
- **Six named protected control points**: `Program.cs`, the API Fusion composition seam, the
  Library Fusion composition seam, `main.ts`, `app.config.ts`, `fusion.config*.ts`. These are
  the seams the whole starter-shell-preservation contract is defined against.
- **A twelve-part output contract** ending in a three-way bridge disposition
  (keep / retire / safe remediation candidates), plus an explicit instruction that a clean
  review must *still* include the platform-status section rather than returning "no issues".
- **Every artifact path uses the `.modernization/ignition-artifacts/modernize/fusion-restructure/`
  root**, with no competing form anywhere in the file — a third vote for `ignition-artifacts`
  in the two-roots conflict.

## ⚠ Findings in `OpX-Fusion-Reviewer.agent.md`

**1. It is told to apply fixes but has no `edit` tool.**
Six tools: `read/readFile`, `search/codebase`, `execute/runInTerminal`,
`execute/getTerminalOutput`, `read/terminalLastCommand`, `read/terminalSelection`. Yet the
Review Method says *"when the caller asks for fixes, only apply the skill's safe-remediation
rules"* and the output contract ends with **Safe remediation candidates**. Applying a
remediation requires writing a file. This is the **fourth** agent with this defect
(`OpX-AppMod-P1-Discovery`, `OpX-AppMod-P3-Review`, `OpX-dotnet-upgrade`'s missing question
tool, and now this one) and the pattern is consistent enough to be worth a single sweep:
**diff every agent's declared tools against the verbs in its own body.**

**2. It is a dead end — the only agent with no handoffs at all.**
`OpX-AppMod-P3-Review` dispatches Step 19 here, but this file declares no `handoffs:` block,
so there is no "Back To Phase 3 Workflow" button and no route onward to Step 20. Every other
agent transcribed so far offers at least one exit. A developer who enters the Step 19 review
has no in-kit way back to the numbered flow; they have to re-select the coordinator manually.

**3. Line 59 is unterminated.** The bullet ending "…instead of requiring a retired parallel
Fusion-only state tracker" has no closing period, unlike every other bullet in the file.
Cosmetic, but it is also the longest and most important rule in the section (it tells the
agent to trust numbered-lane state over the retired Fusion-only tracker), so it reads as
truncated rather than merely unpunctuated.

**4. Another entry for the path-inconsistency ledger.**
This agent reads
`.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`. Prompt 21
(`21-P3-figma-review`) reads the same file as `.modernization/fusion-restructure/decisions.json`
— no `ignition-artifacts/modernize/` prefix. Two different absolute paths for one artifact,
in two files that run 40 minutes apart in the same phase.

## Transcription uncertainties (agent `OpX-Fusion-Reviewer`)

- Line alignment verified at 16 anchors — 11, 13, 17, 19, 27, 31, 39, 41, 50, 52, 61, 63, 65,
  75, 82, 90 — all matching. Content ends at 90; the editor shows blank lines through 92.
- Lines 3, 15 and 59 wrap in the editor; reconstructed from wrap positions.
- No mojibake anywhere in this file; nothing was placeholder-substituted.

## Structural facts added by agent `OpX-Frontend-Angular-Transform`

An **archived, retired** agent still sitting in `.github/agents/`. 50 lines. Its entire job is
to tell the caller it no longer has a job.

- `description`: "Archived compatibility redirect for the retired Angular specialist lane.
  Retained only for historical reference."
- **No `user-invocable`, no `edit` tool** — six read/terminal tools only. Three handoffs, all
  `send: false`.
- **A twelfth named surface: `Ultimate-AppMod-Ignition`**, the target of two of its three
  handoffs ("Back To Orchestrator", "Build & Run Modern App"). This appears to be the
  top-level orchestrator identity, and it is distinct from `Ultimate-Ignition-edit` (the
  toolkit-edit identity named in `OpX-AppMod-P1-Discovery`).
- **Documents a real architectural decision**: there used to be an "Angular specialist
  slice-loop" execution lane, and it was merged away into the numbered browser steps. Both
  `OpX-AppMod-P2-Modernize` ("Do not revive the retired browser-specialist slice-loop lane as
  a second frontend execution surface") and this file guard the same retirement from
  opposite ends.
- Mentions a **"manual Path A helper"** for planning-only MVC or Razor browser decomposition —
  a surface not seen anywhere else so far.

## ⚠ Findings in `OpX-Frontend-Angular-Transform.agent.md`

**1. Its Core Rules are entirely on the old numbering — while its own handoffs are on the new
one. Inside 30 lines.**

| Core Rule says | Actual step | Offset |
|---|---|---|
| "Route shell and scaffold work to **Step 12**" | Step 10 (`10-P2-frontend-foundation-and-scaffold`) | +2 |
| "Route browser migration work to **Step 13**" | Step 11 (`11-P2-frontend-migration`) | +2 |
| "platform integration, shell stabilization, and UI-planning work to **Steps 14 through 16**" | Steps 12, 13, 14 | +2 |

And the file's own handoff two lines earlier routes "Build & Run Modern App" to
`.github/prompts/10-P2-frontend-foundation-and-scaffold.prompt.md` — i.e. **Step 10**, the
thing Core Rule 2 calls Step 12. The handoff block was renumbered; the prose was not.

This is the single cleanest demonstration of the +2 drift in the whole kit: same file, same
screen, one surface correct and one surface stale, with the mapping unambiguous because the
prompt filenames are right there.

The Scope line ("the numbered **Step 12 through Step 16** prompts") is the one ambiguous case
— `OpX-AppMod-P2-Modernize` states the active browser path is **Step 10 through Step 16**, so
the lower bound is +2 but the upper bound matches. Recorded as ambiguous rather than assigned
an offset.

**2. A retired agent is still installed, and it is indistinguishable from a live one in an
agent picker.**
Nothing in the filename or the agent's `name:` marks it as archived — only the `description`
does. It sits in the same `.github/agents/` directory as the eleven live agents. For a
hackathon with 40 participants browsing an agent list, "OpX-Frontend-Angular-Transform" reads
exactly like a legitimate frontend agent. If the goal is historical reference, it belongs in
an `archive/` subfolder or outside `.github/agents/` entirely.

**3. Emoji inconsistency within a three-item handoff list.** Handoffs 1 and 2
("Back To Orchestrator", "Build & Run Modern App") carry no emoji at all; handoff 3
("Step 11 Frontend Migration") carries a mojibake emoji. Same list, same file.

## Transcription uncertainties (agent `OpX-Frontend-Angular-Transform`)

- Line alignment verified at 10 anchors — 25, 27, 29, 31, 33, 37, 39, 46, 48, 50 — all
  matching. Content ends at 50; the editor shows line 51 blank.
- **Source line 24 appears to be blank *inside* the frontmatter**, immediately before the
  closing `---` at line 25. Transcribed as photographed; harmless in YAML but unusual, and no
  other agent file shows it.
- The handoff-3 emoji is mojibake and is recorded as a `<MOJIBAKE: emoji>` placeholder.

## Structural facts added by agent `OpX-dotnet-upgrade`

The most rigorously engineered file in the kit, and the only one that encodes hard-won
runtime-failure knowledge rather than style rules. 287 lines.

- **A third frontmatter variant**: opens with `---` like the other specialists, but has **no
  `user-invocable` field** (the two csharp specialists do). Same seven-tool list as those two.
- **All five handoffs are `send: true`** — the csharp specialists are all `send: false`, the
  P3 coordinator is all `send: false` for numbered steps, and P1/P2 are `send: true`. Four
  files, three different policies, none documented.
- **An eleventh agent: `OpX-QA-Run`** (backend-only test runner). Plus a **third unnumbered
  prompt directory**: `.github/prompts/qaTestPrompts/qa-hub-routing.prompt.md`, routed with a
  `::`-delimited workflow selector (`… :: [WORKFLOW] Backend - Upgrade .NET`).
- **Two orthogonal mode contracts** must be declared per run:
  - *Upgrade Mode* — `Retarget` (default, behavior-preserving, hold every package version
    constant) or `Modernize` (opt-in, operator-requested).
  - *Topology Execution Mode* — `RunnableRuntime` (host can be started and probed) or
    `ConstrainedLegacyHost` (classic System.Web/MVC/WebForms; cannot run as net10 in-place,
    and explicitly **must not** be called blocked just because probing is impossible).
- **`step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`)** — the Step 7 uplift
  happens in a separate mutable workspace defined by `Modernization-Execution-Contract.*`,
  never in place inside `LegacyCode/` and never in `src/`.
- **The single-version package consistency gate** is the standout piece of engineering:
  `verify-upgrade-invariants.ps1 -WorkspaceRoot … [-PublishDir …]`, `RESULT: OK` (exit 0)
  required to proceed, `RESULT: BLOCKED` (exit 2) on a split. Its rationale is written out:
  NuGet builds green when two projects reference different versions of one package, only the
  highest version ships to the run folder, and the other project then throws
  `MissingMethodException`/`TypeLoadException` at runtime — which the app's own error handling
  can disguise as an ordinary error status. Structural fix proposed: central package
  management via `Directory.Packages.props`.
- **The penetration-proof requirement**: an anonymous probe returning 401 proves auth is
  wired, not that upgraded code runs, because middleware rejects before controller logic.
  At least one real business route must be exercised under an authenticated context.
  Startup/request logs must be scanned for loader-class exceptions
  (`MissingMethodException`, `TypeLoadException`, `MissingFieldException`, `FileLoadException`,
  `FileNotFoundException`, "Could not load file or assembly") — any of which is a hard failure
  even on a healthy HTTP status. On a 500, read the response **body**, not the status.
- **A named, diagnosed regression**: on a 3.x → 8 jump, `Microsoft.Data.SqlClient` flips its
  `Encrypt` default from false to true (SqlClient 4.0+ arrives transitively via EF Core 7/8);
  restore with `TrustServerCertificate=True` on every affected connection string including
  `appsettings.Development.json`. This is real institutional knowledge, not generic advice.
- **A question-tool gate**: the first Step 7 action must confirm with the operator, via a
  strict clickable `Yes`/`No` question tool, that the current `src/` baseline builds locally.
  The `src/` gate is **attestation-only** — this lane must not run `dotnet build`,
  `dotnet run`, or HTTP probes against `src/`.
- A breaking-changes mapping table (`HttpContext.Current` → `IHttpContextAccessor`,
  `ConfigurationManager` → `IConfiguration`, `System.Web.Mvc`/`System.Web.Http` →
  `Microsoft.AspNetCore.Mvc`, `Global.asax` → `Program.cs`/`Startup.cs`, `Web.config` →
  `appsettings.json`), a 10-item Verification checklist, and a fixed `.NET UPGRADE COMPLETE`
  report template.

## ⚠ Findings in `OpX-dotnet-upgrade.agent.md`

**1. The mandatory question-tool gate is not in the declared tool list.**
The file says the *first* Step 7 action "must be a question-tool invocation … with strict
clickable `Yes`/`No` options (no freeform answer)", and that asking it as plain markdown is
"non-compliant". The seven declared tools are `edit/editFiles`, `read/readFile`,
`search/codebase`, `execute/runInTerminal`, `execute/getTerminalOutput`,
`read/terminalLastCommand`, `read/terminalSelection`. **No question tool.** The file already
contains a fallback for "if the host cannot render the question tool" — framing a missing
grant as an environment limitation. Same capability-gap class as P1 Discovery and P3 Review,
but this one is self-aware.

**2. `## Upgrade Mode Contract` is an empty shell; its subsections live under the wrong
parent.**
Line 46 `## Upgrade Mode Contract` contains one sentence ("Every run operates in exactly one
declared mode. Default to Retarget.") and no subsections. Line 50
`## Topology Execution Mode (required)` then owns **four** `###` subsections:
`RunnableRuntime`, `ConstrainedLegacyHost`, `Retarget (default)`, and `Modernize`. The last
two are upgrade modes, not topology modes. Any model reading structurally concludes Retarget
is a topology mode — and the two contracts are genuinely orthogonal, so conflating them is a
real comprehension hazard.

**3. PowerShell inside ` ```bash ` fences — third file with this pattern.**
`Get-ChildItem -Recurse -Filter "*.csproj" | Select-Object FullName` and
`./.github/scripts/QA/qa-run-dotnet-tests.ps1 -ProjectPath … -NoBuild` are both in bash
fences, while the adjacent SDK-instructions block correctly uses ` ```powershell `. Same
defect appears in `OpX-csharp-expert` and `OpX-csharp-janitor`.

**4. `step9UpgradeWorkspaceRoot` — the +2 drift baked into a variable name, but as a
*deliberate* shim.**
The pairing `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`) appears four
times. Old Step 9 = new Step 7 under the +2 offset, so this is a backwards-compatibility
fallback someone wrote on purpose for artifacts produced under the old numbering. **This is
the first hard evidence that the kit authors knew about the renumbering** — which strengthens
the case that every *other* +2 reference is an unintentional leftover rather than a second
live numbering system. Do not "fix" this one; it is load-bearing.

## Structural facts added by agent `OpX-csharp-janitor`

Sibling specialist to `OpX-csharp-expert`, same shape, narrower job: safe, behavior-preserving
cleanup rather than violation remediation.

- **Same specialist frontmatter shape as `OpX-csharp-expert`**: opening `---` at line 1, a
  YAML comment (`# For the .NET cleanup step.`), `user-invocable: true`, and the identical
  seven-tool list (`edit/editFiles`, `read/readFile`, `search/codebase`,
  `execute/runInTerminal`, `execute/getTerminalOutput`, `read/terminalLastCommand`,
  `read/terminalSelection`). This confirms a genuine two-tier agent convention:
  coordinators (no opening `---`, browser tools, `agents: ["*"]`) vs specialists
  (opening `---`, `user-invocable`, edit + terminal only, no `agents` key).
- **Four handoffs, all `send: false`**, including a self-handoff (`Run Tests` →
  `OpX-csharp-janitor`) exactly mirroring the expert's. The specialists form a triangle:
  janitor → `OpX-csharp-expert` (Fix Code Violations), expert → `OpX-csharp-janitor`
  (Run Cleanup), and both → `OpX-AppMod-P2-Modernize` (Back To Phase 2 Workflow).
- **A second unnumbered prompt**: `.github/prompts/P2-Modernize/fix-violations.prompt.md`
  (the expert revealed `.github/prompts/P2-Modernize/cleanup.prompt.md`). The
  `P2-Modernize/` prompt folder therefore holds at least two prompts outside the numbered 24,
  and each is owned by the *other* specialist — the janitor routes to `fix-violations`, the
  expert routes to `cleanup`.
- **It also routes into the numbered pipeline**: `Upgrade .NET` →
  `OpX-dotnet-upgrade` running `07-P2-backend-upgrade-dotnet.prompt.md`.
- **Thirteen numbered cleanup tasks**, each a `[BAD]`/`[GOOD]` pair: remove unused usings
  (IDE0005), sort usings (System first then alphabetical), remove unused variables (CS0219),
  remove unused private members (IDE0051), simplify null checks (`?.`/`??`), expression-body
  members, object initializers, collection expressions (C# 12+), pattern matching (including
  switch expressions), string interpolation, `nameof()`, remove commented-out code, remove
  empty regions.
- **Emoji-free and mojibake-free**, like `OpX-csharp-expert`. Both specialists use literal
  `[BAD]`/`[GOOD]` markers.

## ⚠ Findings in `OpX-csharp-janitor.agent.md`

**1. The file is currently broken. VS Code reports three errors in it.**
This is the first transcribed file with objective evidence of being invalid rather than
merely inconsistent: the editor tab reads `OpX-csharp-janitor.agent.md 3` and the status bar
shows `⊗ 3  ⚠ 0`. The three errors correspond to three YAML indentation faults in the
`handoffs:` block, at source lines 16, 18 and 20:

```yaml
handoffs:
  - label: "Back To Phase 2 Workflow"
        agent: OpX-AppMod-P2-Modernize          # line 16 — over-indented
      prompt: "Cleanup complete. Continue the Phase 2 workflow from the next required step."
  send: false                                    # line 18 — under-indented, escapes the mapping
  - label: "Run Tests"
        agent: OpX-csharp-janitor                # line 20 — over-indented
    prompt: "Run ./.github/scripts/QA/qa-run-all-tests.ps1."
    send: false
```

The last two handoffs (`Upgrade .NET`, `Fix Code Violations`) are correctly indented. If the
frontmatter fails to parse, this agent has no tool allowlist and no handoff menu at runtime.
**This one is not a judgement call and not a style preference — it is a broken file sitting in
`.github/agents/`, and it should be fixed before anyone runs the kit.**

**2. The mission places the janitor before modernization; every route into it arrives after.**

> **Your Mission** — Clean up the codebase **before major modernization work**.

But `OpX-AppMod-P2-Modernize` states that `Optional Run Cleanup` "never replaces any numbered
modernization or review step, and **Step 24 owns cleanup** once review reaches the technical
gate", and `OpX-csharp-expert` reaches the janitor via its `Run Cleanup` handoff *after*
fixing violations. So the agent's self-description says "before" while the kit's routing puts
it at the end. Its own `Upgrade .NET` handoff (to Step 7) is the only thing consistent with
"before".

**3. Section 13 does not do what its title says.**
The heading is `### 13. Remove Empty Regions`, but the `[BAD]` example includes a region that
is *not* empty, and the `[GOOD]` fix is captioned "Just remove regions entirely":

```csharp
#region Properties
public string Name { get; set; }     // not an empty region
#endregion
```

Removing all `#region` markers is a defensible house style, but it is a different, broader
change than "remove empty regions" — and it is the kind of edit a developer will be surprised
by in a diff. The title and the rule need to agree.

**4. No `## Workflow` and no `## Output` section — unlike its sibling.**
`OpX-csharp-expert` ends with a Workflow (read finding → find file → apply fix → run tests →
pass/fail branch), an `After Each Fix` regression-test step, and a fixed `CODE VIOLATIONS
FIXED` report template. The janitor has none of the three. It has a `Run Tests` handoff but no
instruction to use it, no completion report, and no definition of done. Two sibling
specialists with the same frontmatter and opposite levels of procedural rigour.

**5. `Select-String` invoked inside a ` ```bash ` fence** — the same bash/PowerShell confusion
found in `OpX-csharp-expert`:

```bash
dotnet build --no-incremental 2>&1 | Select-String "IDE0005"
```

## Transcription uncertainties (agent `OpX-csharp-janitor`)

- Line alignment was spot-verified against the source at 18 anchors — 33, 37, 41, 43, 60, 67,
  80, 99, 118, 135, 158, 176, 188, 213, 224, 236, 262, 275 — all matching. Content ends at
  275; the editor shows blank lines through 277.
- **The exact indentation on source lines 16, 18 and 20 is approximate.** Column positions
  were read from glyph offsets in the photo, so the reproduced space counts may be off by a
  character or two. What is *not* approximate is that those three lines are misaligned
  relative to their siblings and that the editor reports exactly three errors — the count
  matches the three anomalies one-for-one.
- No mojibake anywhere in this file; nothing was placeholder-substituted.
- The file was open with unsaved changes (dot on the tab) when photographed, so it may differ
  from the committed version in the kit repo.

## Structural facts added by agent `OpX-csharp-expert`

First **specialist** agent transcribed (the previous three are phase coordinators), and the
first file that reveals a second tier of kit structure.

- **Different file shape from the coordinators.** It opens with `---` at line 1, carries a
  YAML **comment** in the frontmatter (`# For the .NET coding-violations step.`), and
  declares `user-invocable: true` — a field none of the three coordinators has.
- **Seven tools**, and it is a *worker*: `edit/editFiles`, `read/readFile`,
  `search/codebase`, `execute/runInTerminal`, `execute/getTerminalOutput`,
  `read/terminalLastCommand`, `read/terminalSelection`. No `agent`, no `todo`, no `browser`.
- **Four handoffs, all `send: false`**, one of which is a **self-handoff** (`Run Tests` →
  `OpX-csharp-expert`). Exits are: back to `OpX-AppMod-P2-Modernize`, run tests, run
  Step 22 via `OpX-Code-Reviewer`, or run cleanup via `OpX-csharp-janitor`.
- **Two new agents named**: this file (`OpX-csharp-expert`) and `OpX-csharp-janitor`.
  Ten named agent surfaces are now known: the three phase coordinators,
  `OpX-dotnet-upgrade`, `OpX-Fusion-Reviewer`, `OpX-Code-Reviewer`, `OpX-QA-Hub`,
  `Ultimate-Ignition-edit`, `OpX-csharp-expert`, `OpX-csharp-janitor`.
- **There is an unnumbered prompt tree.** The cleanup handoff routes to
  `.github/prompts/P2-Modernize/cleanup.prompt.md` — a **subdirectory** under
  `.github/prompts/`, which breaks the flat `NN-Px-name.prompt.md` convention the 24
  numbered prompts follow. The kit therefore contains prompts outside the numbered
  pipeline, organised by phase folder.
- **New script**: `.github/scripts/QA/qa-run-all-tests.ps1`.
- **Six worked violation classes**, each as a `**Problem**` / `**Fix**` pair with `// [BAD]`
  and `// [GOOD]` markers and the matching `Program.cs` registration:
  DI violations → constructor injection; `.Result`/`.Wait()`/`async void` → async all the
  way; `new HttpClient()` → `IHttpClientFactory`; static mutable state →
  `IDistributedCache`; `User.IsInRole()`/`[Authorize(Roles=…)]` → policy-based
  authorization; `Console.WriteLine` → `ILogger` structured logging. Plus magic numbers →
  `IOptions<T>` + `appsettings.json`, and empty catch blocks → typed catch with
  `OperationCanceledException` re-throw.
- **A fixed report template** at the end (`CODE VIOLATIONS FIXED`, counts by severity with
  per-class breakdown, `Tests:` / `Build:` lines, `Ready for final acceptance review.`).
- **This file is completely free of emoji and of mojibake.** It uses literal `[BAD]`,
  `[GOOD]` text markers where other kit files use corrupted emoji. It is the cleanest file
  transcribed so far and a good model for de-emojifying the rest.

## ⚠ Findings in `OpX-csharp-expert.agent.md`

**1. The missing frontmatter delimiter in the three coordinators is now confirmed as a real
inconsistency, not a rendering artifact.**
This file's line 1 is `---`. `OpX-AppMod-P1-Discovery`, `-P2-Modernize` and `-P3-Review` all
begin bare at `name:`. Same directory, same editor, same photo session. Under a strict
frontmatter parser the three coordinators have no frontmatter at all — their `name`,
`description`, `tools`, `handoffs` and `agents` would be read as body text, which would mean
their tool allowlists and handoff menus never take effect. This supersedes the "possibly a
VS Code artifact" note recorded three times above.

**2. The mission contradicts its own priority list.**

> **Your Mission** — Fix **HIGH and MEDIUM** code violations from the baseline compliance review.
> **3. Prioritize fixes:** — CRITICAL first (security issues) / HIGH second (architectural
> violations) / **MEDIUM if time permits**

`CRITICAL` is outside the stated mission scope but is first in the priority list *and*
appears in the mandatory report template (`CRITICAL Fixed: 0`). And "MEDIUM if time permits"
walks back the mission's commitment to fix MEDIUM. A model reading the mission statement and
a model reading the checklist get two different jobs.

**3. Two severity vocabularies exist in the kit with no mapping between them.**
This agent works in `CRITICAL / HIGH / MEDIUM`. Prompt 24 — the step that *invokes* violation
remediation — scores in `P1 / P2 / P3 / P4`. Nothing translates one to the other, so a P1
finding handed to this agent has no defined severity here, and this agent's `CRITICAL Fixed`
count has no slot in Step 24's report.

**4. Two different test commands for the same purpose, 12 lines apart.**
Workflow step 4 says run `./.github/scripts/QA/qa-run-all-tests.ps1`; the very next section,
`## After Each Fix`, says "Run tests to ensure no regressions:" → `dotnet test`. Both are
"run the tests after a fix". One is the kit's QA harness, the other is raw dotnet — and
`dotnet test` would skip the frontend suites entirely.

**5. A PowerShell script is invoked inside a ` ```bash ` fence.**

```bash
./.github/scripts/QA/qa-run-all-tests.ps1
```

Cosmetic on a dev box with pwsh on PATH, but it is the same class of error as the
`.feature` conflict: the prompt tells the model one thing and the runtime expects another.
The `Run Tests` handoff phrases it a third way ("Run ./.github/scripts/QA/qa-run-all-tests.ps1.").

**6. The Dominion skill path disagrees with the one referenced elsewhere.**
Here: `.github/skills/dominion-requirements/SKILL.md`. Elsewhere in the kit:
`/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md`. Both may exist, but
the agent is told to read "the Dominion requirements" and pointed at only one of them.

**7. It resolves the two-artifact-roots conflict — in favour of `ignition-artifacts`.**
It reads `.modernization/ignition-artifacts/discovery/baseline-review.json`, matching
prompt 04's header block rather than prompt 04's closure contract
(`.modernization/artifacts/reviews/baseline-review.json`). A useful vote when the single-root
decision gets made.

## Transcription uncertainties (agent `OpX-csharp-expert`)

- Line alignment was spot-verified against the source at 20 anchors — 33, 37, 41, 53, 58,
  60, 114, 164, 206, 246, 285, 303, 360, 396, 408, 415, 418, 419, 436, 437 — all matching.
  Content ends at 437; the editor shows blank lines through 439.
- **The fence block at source lines 49-52 is the one structurally odd spot.** It reads as
  an opening ` ``` ` at 49, a blank line at 50, the skill path at 51, and a closing ` ``` `
  at 52, with no blank line before `3. Prioritize fixes:` at 53 (unlike the item-1 block,
  which has one). The line numbers are forced by the verified anchors either side, but the
  blank-line-inside-the-fence reading is inferred from glyph positions rather than read
  cleanly. Note the item-1 block uses ` ```bash ` with a `cat` command while this one uses a
  bare fence with only a path — two different ways of saying "read this file".
- No mojibake anywhere in this file; nothing was placeholder-substituted.

## Structural facts added by agent `OpX-AppMod-P3-Review`

Third and shortest agent (82 lines vs 136 and 102). With all three phase coordinators in
hand, the set can be compared as a whole.

- **Every numbered step number in this file is correct.** The six handoff labels carry
  their step numbers as keycap emoji (19-24) and all six match their prompt filenames.
  After the +2 drift in P2 and prompt 24's five Step-23 self-references, this is the first
  file in the kit with zero numbering defects.
- **All six numbered review handoffs are `send: false`** — the exact inverse of P1 and P2,
  where every numbered step is `send: true`. Only the two QA helpers auto-send. This reads
  as deliberate: review gates require a human to pull the trigger, implementation steps do
  not. Worth confirming, because if it *is* deliberate it is a good pattern and should be
  stated somewhere rather than left implicit in three files.
- **Review steps fan out to three different specialist agents**, so the coordinator is a
  router rather than an executor: Step 19 → `OpX-Fusion-Reviewer`, Steps 20/21/23 → itself,
  Steps 22/24 → `OpX-Code-Reviewer`.
- **Step 20 is named the "technical falsification gate"** — it must run before visual,
  acceptance and readiness review continue. That gives Phase 3 an explicit fail-fast
  ordering rather than six equal-weight reviews.
- **Step 24 absorbed the optional helper lanes**: "the final technical quality and
  remediation gate, including bounded cleanup and code-violation fixes that were previously
  handled through optional helper lanes." This matches P2's statement that
  `Optional Run Cleanup` and `Optional Fix Code Violations` hand ownership to Step 24, and
  explains why prompt 24 both fixes and reports.
- **Sign-off framing**: "Treat final review outputs as sign-off evidence, not as exploratory
  analysis or a substitute for missing Phase 2 implementation work." Phase 3 cannot be used
  to finish Phase 2's job.

## ⚠ Findings in `OpX-AppMod-P3-Review.agent.md`

**1. Capability gap, and it is the worst of the three: no `edit`, and no `browser` either.**
Declared tools are exactly eight: `read/readFile`, `search/codebase`, `vscode/runCommand`,
`execute/runInTerminal`, `execute/getTerminalOutput`, `read/terminalLastCommand`,
`read/terminalSelection`, `agent`. But:

- Steps 19-24 must **write** durable JSON artifacts (`figma-review.json`,
  `final-review.json`, `deployment-readiness-review.json`, `FINAL-COMPLIANCE-REPORT.json`)
  and update `step-response-ledger.json` and `step-workflow-state.json`. No `edit` tool.
- **Step 21 is a browser-led visual review gate.** Prompt 21 declares `browser` and
  `figma/*` in its own frontmatter and requires screenshot evidence per route. The
  coordinator agent that runs it declares no browser tool at all.

Combined with the same finding in P1 Discovery, **two of the three phase coordinators
cannot write files, and the one that owns the screenshot gate cannot open a browser.**
Only P2 declares `edit`. This is now the highest-priority defect class in the kit — it is
not a numbering nit, it is agents lacking the capability to do their stated job.

**2. `QA Portal Full Refresh` hands Phase 3 control to the Phase 2 coordinator.**

```yaml
  - label: "<emoji> QA Portal Full Refresh"
    agent: OpX-AppMod-P2-Modernize      # <- in the Phase 3 agent
```

In P1 this handoff points at `OpX-AppMod-P1-Discovery`; in P2 at
`OpX-AppMod-P2-Modernize`. P3's copy also points at `OpX-AppMod-P2-Modernize` — it was
copied from the P2 file and the `agent:` line was not updated. A developer refreshing the
QA portal during final review is silently switched to the Phase 2 coordinator, which is
the agent whose own rules say Phase 2 is execution-only.

**3. Still no Write Boundary section.** Only `OpX-AppMod-P1-Discovery` has one. Two of
three coordinators say nothing about protected toolkit roots. (For P3 the practical risk is
lower, since it has no `edit` — but that is finding 1, not a mitigation.)

**4. Two rules are stated twice inside this one file.**
Line 68 and line 78 are both "return the full shared chat contract response shape for
numbered-step replies, including short completion follow-ups" (the second prefixed
"Always"). Line 63 and line 82 both say "Treat final review outputs as sign-off evidence,
not as exploratory analysis" — the second is a truncated copy that drops the "or a
substitute for missing Phase 2 implementation work" clause. The entire `Phase-Specific
Notes` section is that one duplicated bullet. Duplicated rules that differ slightly are how
contradictions start.

## Transcription uncertainties (agent `OpX-AppMod-P3-Review`)

- Same as P1 and P2: **no opening `---` frontmatter delimiter** — line 1 is
  `name: OpX-AppMod-P3-Review`, closing `---` at line 46. All three coordinators show this.
  > **SUPERSEDED by `OpX-csharp-expert`**: that file, in the same directory and the same
  > photo session, *does* open with `---` at line 1. So this is a real inconsistency
  > between coordinator and specialist agents, not a kit-wide convention and not a VS Code
  > rendering artifact. See the findings under `OpX-csharp-expert`.
- Handoff labels contain both a leading pictographic emoji and a two-digit keycap sequence
  (e.g. `1️⃣9️⃣`); both are mojibake in the photo and are recorded as
  `<MOJIBAKE: emoji>` / `<MOJIBAKE: keycap NN>` placeholders. The keycap digits were
  legible enough to confirm every step number.
- File content ends at line 82; the editor shows line 83 blank.

## Structural facts added by agent `OpX-AppMod-P2-Modernize`

Second agent transcribed. Same file shape as P1 Discovery, but the differences between the
two are more informative than either file alone.

- **`tools` is a YAML block list here, not the inline array P1 Discovery uses** — same
  field, two different syntaxes across two files in the same directory.
- **P2 has `edit`; P1 Discovery has no editing tool at all** (see the finding below).
  P2 also declares coarse-grained `vscode`, `browser`, `agent` entries *alongside* their
  fine-grained forms (`vscode/runCommand`, `browser/readPage`, `agent/runSubagent`) —
  redundant, and it means the broad grants are what actually apply.
- **15 handoffs**: a `Refresh Discovery Planning Gate` recovery route, the twelve numbered
  Steps 7-18, `QA Portal Full Refresh`, and `QA Test Hub`.
- **`Refresh Discovery Planning Gate` is the only handoff in either agent with `send: false`**,
  and the only one that dispatches *backwards across a phase boundary* — to
  `OpX-AppMod-P1-Discovery` running prompt 06. Not auto-sending a cross-phase rollback is
  the right call; it makes re-opening Discovery a deliberate human act.
- **A hard backend-before-frontend gate**: "Treat Step 7 through Step 9 as the required
  backend gate before Step 10 through Step 18. Do not route frontend formation or
  migration until backend upgrade, backend formation in `src/`, and backend integration
  hardening are truthfully complete or the blocker is explicit."
- **Phase 2 is declared execution-only**: "implement against Discovery-owned inventories,
  plans, and catalogs; do not derive new legacy scenarios in this phase." This is the
  counterpart to P1's ownership-reclamation rule and it names the exact upstream owner for
  each missing-input class — Step 3/4 for baseline or inventory evidence, Step 5/6 for
  planning or QA-design derivation.
- **Generic browser-source decomposition**: MVC/Razor decomposition prompt for
  server-rendered sources, Angular/browser-client decomposition prompt for SPA sources,
  and mixed/hybrid/already-modern surfaces treated as validation or consolidation cases —
  explicitly "instead of inventing a second frontend lane."
- **Two more instruction surfaces named**:
  `/.github/instructions/fusion-mcp-restructure.instructions.md` and
  `/.github/skills/fusion-feature-standards/SKILL.md`, both required before "inventing
  custom platform code" for Fusion-owned platform, startup, auth, HTTP, or UI decisions.
- **Named optional lanes**: `Optional Run Cleanup`, `Optional Fix Code Violations`,
  `QA Portal Full Refresh`, plus a "retired browser-specialist slice-loop lane" that must
  not be revived as a second frontend execution surface.
- **Step 24 is referenced correctly twice** ("Step 24 owns cleanup once review reaches the
  technical gate", "Step 24 owns violation remediation…"). Independent corroboration that
  prompt 24 — which calls itself Step 23 five times — is the stale file, not this one.

## ⚠ Findings in `OpX-AppMod-P2-Modernize.agent.md`

**1. Smoking-gun drift pair: the same three artifacts cited with a +2 difference, in the
same file.**

> Line 113: "If **Step 6, Step 7**, or `Modernization Quality Design` artifacts are missing,
> stale, or contradictory, route back to Discovery…"

> Line 131: "`Refresh Discovery Planning Gate` is the recovery route when **Step 4, Step 5**,
> or `Modernization Quality Design` inputs are no longer trustworthy enough…"

Both sentences name the same set — the baseline-acceptance artifact, the solution-design
artifact, and the Quality Design pack — as the Discovery inputs Phase 2 depends on. Under
current numbering those are Steps 4, 5 and 6, so **line 131 is correct and line 113 is +2**.
This is the same adjacent-reference proof found in prompt 21, and it confirms the
renumbering was applied per-line rather than per-file.

Two more lines carry the +2 form: line 112 cites "the **Step 7** execution-contract and
control-point decisions" (the target-state contract is Step 5's output — and prompt 22
repeats this same "Step 7 target-state contract" phrasing, so the error is consistent
across files), and line 116 drives the browser lane from "the current **Step 5 and Step 7**
evidence" (legacy analysis is Step 3, solution design is Step 5). Meanwhile lines 114, 115,
117, 118, 119, 131-136 are all correct under current numbering. Roughly a quarter of this
file's step references are stale.

**2. P1 Discovery declares no file-editing tool, yet its own text says it writes artifacts.**
This is a cross-file finding, visible only now that a second agent exists for comparison.
`OpX-AppMod-P2-Modernize` declares `edit`. `OpX-AppMod-P1-Discovery` declares no `edit`
entry of any kind — yet its Write Boundary section states that
"`.modernization/portal/**`, `.modernization/ignition-artifacts/**` … **are still writable
by this agent as needed by the active step**", and Discovery steps 1-6 are required to
produce inventory, baseline and planning artifacts. Either P1 is silently relying on
`execute/runInTerminal` to write files — which would make its own "do NOT use `Set-Content`
/`Out-File`/`Add-Content`" prohibition the *only* write path it has, aimed at the wrong
target — or the `edit` grant was dropped by accident. This is a hard blocker for Phase 1,
not a lint nit.

**3. Phase 2 has no Write Boundary section at all.**
P1 Discovery devotes 18 lines to protected toolkit roots and the all-mechanisms
prohibition. P2 Modernize — the phase that actually rewrites the application, has `edit`,
and runs twelve steps — has **no equivalent section**. The agent most able to damage
`.github/**` is the one with no rule against it. Whatever the shared
`appmod-phase-agent-contract.instructions.md` says, the asymmetry between the two files is
itself the risk: a reader of either file draws opposite conclusions about what is protected.

**4. `QA Test Hub` here *does* carry `send: true` — so P1's missing one is an oversight.**
The same handoff in `OpX-AppMod-P1-Discovery` omits `send: true`; here it is present. The
prompt text also differs between the two ("Open QA Hub and route through the current
workflow catalog." vs "Open the QA Hub"). Two copies of one handoff, diverging in both
fields. Resolves finding 3 in the P1 section: it is drift, not intent.

**5. Coarse and fine tool grants are both declared.**
`edit`, `todo`, `vscode`, `browser`, `agent` appear as bare entries *and* as
`vscode/runCommand`, `browser/openBrowserPage`, `agent/runSubagent`, etc. The bare grants
supersede, making nine of the fine-grained entries decorative — and making the file read as
more restricted than it is.

## Transcription uncertainties (agent `OpX-AppMod-P2-Modernize`)

- Same as P1: **no opening `---` frontmatter delimiter** — line 1 is
  `name: OpX-AppMod-P2-Modernize`, closing `---` at line 90. Transcribed as photographed.
  Two agent files now show this, which makes a VS Code rendering artifact less likely and a
  real convention (or a real defect) more likely.
- Handoff label emoji are mojibake; recorded as `<MOJIBAKE: emoji>` placeholders.
- Lines 112-121 and 131-136 wrap in the editor; reconstructed from wrap positions.
- File content ends at line 136; the editor shows blank lines through 140.

## Structural facts added by agent `OpX-AppMod-P1-Discovery`

First agent file transcribed. Agents are a **different file shape** from prompts and carry
routing behavior the prompts do not.

- **Location**: `.github/agents/<Name>.agent.md`. Frontmatter fields observed:
  `name`, `description`, `tools` (single-line JSON-ish array, not the YAML block list the
  prompt files use), `handoffs`, `agents`.
- **`tools` is a flat inline array of 18 entries** — a *superset* of what any single P1
  prompt declares: `vscode/runCommand`, `execute/getTerminalOutput`, `execute/runInTerminal`,
  `read/readFile`, `read/terminalSelection`, `read/terminalLastCommand`, `agent/runSubagent`,
  `search/codebase`, and the full browser family (`openBrowserPage`, `readPage`,
  `screenshotPage`, `navigatePage`, `clickElement`, `dragElement`, `hoverElement`,
  `typeInPage`, `runPlaywrightCode`, `handleDialog`).
- **`handoffs` is the UI menu** the coordinator renders: 8 entries, each with
  `label` (emoji + step title), `agent`, `prompt` (a literal "Use .github/prompts/NN-….prompt.md
  and execute it in full." sentence), and `send: true`. This is how a step is launched —
  the coordinator does not contain step logic, it dispatches to the numbered prompt file.
- **Handoff prompt strings are the canonical filename list**, and they match the 6 P1
  prompt filenames exactly as transcribed (`01-P1-workstation-readiness` …
  `06-P1-modernization-quality-design`).
- **Two non-numbered handoffs** exist alongside the six steps:
  `QA Portal Full Refresh` → `run .\.github\scripts\QA\qa-refresh-portal.ps1 -AutoRefresh`,
  and `QA Test Hub` → agent `OpX-QA-Hub`.
- **A seventh agent exists**: `OpX-QA-Hub` (previously unseen; the six known were
  `OpX-AppMod-P1-Discovery`, `OpX-dotnet-upgrade`, `OpX-AppMod-P2-Modernize`,
  `OpX-Fusion-Reviewer`, `OpX-AppMod-P3-Review`, `OpX-Code-Reviewer`).
- **An eighth named surface exists**: `Ultimate-Ignition-edit` — the *only* identity
  permitted to modify toolkit files. Referenced as the escalation target when a phase
  agent must refuse a protected write.
- **`agents: ["*"]`** — this coordinator may delegate to any agent.
- **The Write Boundary is a first-class contract**, and it is enforced against *mechanisms*,
  not just file edits: no `Set-Content`/`Out-File`/`Add-Content`/`tee` into `/.github/**`,
  no invoking a script that writes there as a side effect, no `git` staging of toolkit files.
  Protected roots: `/.github/**`, `/.modernization/.readme/**`, `/.modernization/OpXUtil/**`,
  `/.vscode/**`. This is the strongest anti-drift control seen in the kit so far and it
  lives in the agent, not the prompts.
- **Two routing authorities are named**: `/.github/instructions/AppMod-Step-Contract.json`
  (machine routing) and `/.github/instructions/AppMod-Process.instructions.md`
  (human-readable phase authority). Note this is a *different* path family from the
  `.github/contracts/schemas/` referenced by the prompts.
- **Three-layer instruction inheritance, with explicit precedence**:
  `appmod-agent-personality-baseline.instructions.md` (baseline) →
  `appmod-phase-agent-contract.instructions.md` (overrides baseline for numbered-step
  behavior, QA flow, response shape) → local agent rule / routed prompt / narrower
  instruction file (overrides when more specific).
- **Discovery is explicitly a proof-and-planning phase, not a code-fix phase**: no edits to
  `LegacyCode/` or `src/`, and no rewriting `.github/` "just to make a Discovery step pass."
  Blocked-with-exact-file is the required response instead.
- **Ownership reclamation rule**: if a later phase reports a missing inventory fact, baseline
  input, planning decision, or catalog rule, the fix routes *back* to the owning Discovery
  step rather than being patched into Phase 2/3. This is the mechanism that makes
  "one concern per step" hold across phases.
- **Step 6 is the named Discovery completion gate** before Step 7 backend execution, and it
  is the canonical owner of the QA planning pack (reading `qa-core-master.prompt.md`, then
  reusing `[WORKFLOW] Modernization Solution Design` and
  `[WORKFLOW] Modern Build Planned QA Tests`) without reassigning QA ownership back to Step 5.
- **Retired numbered runtime steps**: manual starter verification and copied-legacy
  verification now happen *before Step 2* rather than as standalone numbered prompts;
  Step 1 owns the workstation/manual verification gate.

## ⚠ Findings in `OpX-AppMod-P1-Discovery.agent.md`

Three defects, one of them the same +2 drift signature found across the prompts.

**1. +2 numbering drift — seventh confirmed instance, and the first one found in an agent file.**
Line 83, Response Contract:

> When `Modernization Quality Design` is the required follow-up, say that plainly instead of
> implying **Step 9** can start directly from **Step 7**.

`Modernization Quality Design` is Step 6. It sits between Step 5 and Step 7. The sentence is
only coherent as *"instead of implying Step 7 can start directly from Step 5."* Both numbers
are exactly +2. This is the same offset proven in prompts 12-16, 19, 20, 21 and acknowledged
in prose by prompt 22 — so the renumbering missed the agent files as well as the prompt
bodies. The linter must sweep `.github/agents/**`, not just `.github/prompts/**`.

**2. A duplicated path in the writable-areas allowlist.**
Line 77 lists `.modernization/ignition-artifacts/**` **twice**:

```
(`.modernization/portal/**`, `.modernization/ignition-artifacts/**`,
 `.modernization/ignition-artifacts/**`, `.modernization/ignition-artifacts/discovery/**`,
 `.modernization/ignition-artifacts/modernize/fusion-restructure/**`)
```

Harmless at runtime (the broad glob already covers the two narrower ones), but it is a
tell: the list was hand-edited during the artifact-root migration and one entry was meant
to be a different root. Given that prompts 04 and 22 each name *two different roots for the
same file* (`.modernization/ignition-artifacts/…` vs `.modernization/artifacts/…`), the
likely intent was for one of these to be `.modernization/artifacts/**`. Worth resolving as
part of the single-artifact-root decision rather than just deduping.

**3. The `QA Test Hub` handoff is missing `send: true`.**
Every other handoff in the file — all six numbered steps and `QA Portal Full Refresh` —
ends with `send: true`. The eighth and last one does not:

```yaml
  - label: "<emoji> QA Test Hub"
    agent: OpX-QA-Hub
    prompt: "Open QA Hub and route through the current workflow catalog."
agents: ["*"]
```

It is also the only handoff that dispatches to a *different* agent, so it may be
deliberate (hand off without auto-sending). Flagged rather than corrected — needs a
one-line answer from the kit owner.

> **RESOLVED by `OpX-AppMod-P2-Modernize`**: the same `QA Test Hub` handoff in the P2 agent
> *does* carry `send: true`, and its prompt text differs too ("Open the QA Hub" vs
> "Open QA Hub and route through the current workflow catalog."). Two copies of one
> handoff, diverging in both fields — so this is drift, not intent.

## Transcription uncertainties (agent `OpX-AppMod-P1-Discovery`)

- **No opening `---` frontmatter delimiter.** Line 1 of the file is `name: OpX-AppMod-P1-Discovery`
  and the closing `---` is at line 37. Every prompt file transcribed so far opens with `---`
  at line 1. Transcribed exactly as photographed (no opening delimiter) rather than
  "corrected", per the standing rule — but this is worth verifying on the real file, since
  it is equally likely to be a VS Code rendering artifact.
- **Handoff label emoji are mojibake in the photo** and are recorded as
  `<MOJIBAKE: emoji>` placeholders, the same convention used in the prompt transcriptions.
  Best-guess readings from glyph shape: Step 1 monitor, Step 3 magnifier, Step 4 green
  check, Step 5 ruler/triangle, Step 6 grid, QA Test Hub pencil. Not asserted.
- Line 3 (`tools:`) wraps in the editor; the array order was reconstructed across the wrap
  boundary (`…browser/screenshotPage,` → `browser/navigatePage,…`).
- Line 77 wraps; reconstructed from wrap position.
- File content ends at line 102; the editor shows blank lines through 113.

## Structural facts added by prompt 24

Step 24 `Technical Review - S-Tier Quality Gate` is the largest prompt in the kit
(1251 source lines vs ~570 for the next largest) and the only one that is a **scored
rubric** rather than a gated procedure.

- **Agent**: `OpX-Code-Reviewer`. **Tier**: Premium reasoning (high thinking), 15-30 min.
- **Nine weighted categories summing to exactly 100%**: Parity 20, Functionality 18,
  Dominion/Fusion Compliance 15, Code Quality 12, Security 12, Testing 10, Architecture 5,
  OCP Cloud & DevOps 5, Production Readiness 3.
- **GO/NO-GO thresholds**: 90-100 GO, 80-89 "Close", <80 "Work needed".
- **Step 24 Remediation Contract** with a disposition ledger of `Resolved` / `Deferred` /
  `Blocked` / `AcceptedRisk` — the only step that both *fixes* and *reports*.
- **Scope fence**: "PROJECT CODE ONLY" (`src/<AppName>.Library`, `.Web.Api`, `.Web.Client`,
  `tests/backend`, `tests/frontend`) vs "DO NOT TOUCH" kit infrastructure.
- **Emoji Integrity Check (Tooling)** — an embedded PowerShell repair that reads a file as
  Latin1, re-decodes as UTF-8, and rewrites it when the round-trip differs. See the
  finding below: it is scoped to the wrong directory.
- **Step Verification Matrix** — a 14-row artifact-existence table spanning the whole
  pipeline, used as a cross-step completeness check at the end of the run.
- **Testing section is Playwright + Gherkin/BDD**, with a Page Object Model contract
  (`BasePage.ts`, `<Feature>Page.ts`, no raw locators in test files), a STRICT locator
  policy (`getByRole` preferred, `getByTestId` **required on every testable element**,
  no CSS selectors, no XPath, no `nth-child`), and a mandate that every Angular button,
  input, link, custom component, and dialog carry **both** `aria-label` and `data-testid`.
- **xUnit backend contract**: `tests/backend/{unit,contractApi,integrationBackend}/`,
  BDD naming (`Given_When_Then` or `Method_Scenario_Result`), `[Fact]`/`[Theory]`,
  Moq or NSubstitute, FluentAssertions, >80% coverage on business logic.
- **Durable output is markdown, not JSON** — the only step in the kit that writes one:
  `.modernization/ignition-artifacts/technical-review-report.md`, with **append-history
  semantics** ("don't overwrite previous runs, add to history table"), ISO timestamps,
  raw scan output in a collapsed `<details>` block, and per-category deltas.
- **Recheck Mode** — a second run reads the previous report, re-scans, and reports
  Resolved / Remaining / New Issues plus an updated recommendation. No other step has a
  re-entrant mode.
- **Issue-to-Step Mapping Reference** — a 16-row table mapping each defect class to the
  numbered step that owns the fix, with a one-line rationale per row. This is the single
  most useful anti-drift artifact found anywhere in the kit: it converts "here is a defect"
  into "re-run step N", which is exactly the routing a hackathon participant needs.
  Its step numbers are **correct** under current numbering (7, 8, 9, 10, 11, 12, 13, 15,
  17, 18) — notably the only place in prompt 24 where they are.
- **ROI Calculation** — an explicit prioritization formula:
  `ROI Score = (P1 fixed × 5 + P2 fixed × 3 + P3 fixed × 1) / estimated minutes`,
  with the rule "always recommend the step with the highest ROI Score first." Remediation
  ordering is therefore deterministic rather than model judgement.
- **Severity ladder P1-P4** with worked definitions (P1 Blocker: security gaps, async
  anti-patterns, missing Fusion, no health checks → P4 Polish: comments, formatting).
- **Two worked example outputs** — a 15-issue "72/100 NO-GO" case and a 3-issue
  "96/100 GO" case — so the model has calibration anchors for the score, not just a rubric.
- **Accessibility Coverage is a reported metric**, targeting **100%** of interactive
  elements carrying both `aria-label` and `data-testid`.
- **`**Pick fixes**` interaction contract** — the report ends by inviting a natural-language
  fix selection ("Fix #1, #5, #12" / "Fix all P1" / "Fix #1-8").

## ⚠ Findings in prompt 24

**1. The `.feature` file contradiction — the worst conflict found in the kit, and it is
structural, not a stray sentence.**
Step 24 requires Gherkin in two independent places. §6 requires `.feature` files plus a
`steps/` directory of Cucumber definitions, and the Playwright Checklist independently
scores:

```
- [ ] Feature files in `features/` directory
- [ ] Step definitions in `steps/` directory
- [ ] Every user-facing feature has a `.feature` file
- [ ] Scenarios use Given/When/Then syntax
- [ ] Tags: `@smoke`, `@regression`, `@journey`, `@critical`
- [ ] Step definitions match feature file steps
```

Steps 12 and 17 (Gate 9) explicitly forbid `.feature` files ("NO .feature files").
**No repository state satisfies both.** Because Gherkin is load-bearing in a *scored*
category (Testing, 10%), every participant who follows Steps 12/17 correctly will take an
unavoidable deduction at Step 24. This needs a human decision — either Step 17 stops
forbidding `.feature` files, or Step 24's §6 and checklist are rewritten to score
Playwright-without-Gherkin. A linter cannot resolve it.

**2. Prompt 24 refers to itself as Step 23 — five times, and one of them dates the file.**

```
**If NO-GO**: Fix issues in priority order, then rerun Step 23.
**If CLOSE**: Fix P1s only, then rerun Step 23.
**If GO**: Proceed to Step 23/23 sign-off.
*This report can be referenced before rerunning Step 23 to track progress.*
When user says "recheck" or runs Step 23 again:
```

These are **-1** self-references, a different signature from the +2 drift elsewhere, and
they are operationally live: both the What's-Next block and Recheck Mode instruct the agent
to re-run "Step 23", which is *Final Readiness Review* — a different prompt, a different
agent, and a different artifact. A NO-GO verdict therefore routes the developer to the
wrong step.

**`Proceed to Step 23/23 sign-off` is the most informative line in the file.** `23/23` is
an "N of N" progress indicator, so **the pipeline had exactly 23 steps when this prompt was
written, and this prompt was the last of them.** That dates the file and explains the
self-references: it was Step 23 of 23, a step was later added ahead of it, and the title
and frontmatter were updated while every internal reference was left behind.

Note this runs *opposite* to the +2 drift in the frontend block (where old numbers are
higher than new) and to the +1 drift in this same file's Step Verification Matrix. At least
two independent renumberings, in opposite directions, are visible — which is why the linter
must compare against the **declared** step number of each file rather than assume a single
global offset.

**3. A second, distinct +1 drift confined to the Step Verification Matrix's Discovery rows.**
The matrix reads `3 | Rename complete`, `4 | Legacy analysis`, `6 | Solution design` —
but those are Steps 2, 3 and 5. Every row from 7 onward is correct. Two separate
compressions are therefore visible in one file.

**4. The kit's own emoji-repair script is pointed at the wrong directory.**
The Emoji Integrity Check does exactly the right Latin1→UTF-8 round-trip repair, but:

```powershell
$agentFiles = Get-ChildItem .github/agents -Filter *.agent.md -File -ErrorAction SilentlyContinue
```

It only scans `.github/agents`. The corruption is in `.github/prompts` — which is precisely
why every prompt file transcribed here still shows mojibake. One-line fix:
`Get-ChildItem -Path .github/prompts,.github/agents -Filter *.md -File -Recurse`.

**5. Capability gap: the frontmatter cannot run what the body demands.**
Declared tools are `agent`, `browser`, `edit/editFiles`, `todo`, `vscode/vscodeAPI`,
`fusion/copilot-docs/*`. The body is almost entirely PowerShell scans and requires reading
source files — yet `execute/runInTerminal`, `read/readFile`, and `search/codebase` are all
absent. This is the most severe capability gap in the kit (prompt 23 is missing
`read/readFile` + `search/codebase`; prompt 24 is missing those *plus* terminal execution).

**6. The durable report escapes the `reviews/` convention.**
Every other review artifact lands in `.modernization/ignition-artifacts/reviews/`.
Step 24 writes `.modernization/ignition-artifacts/technical-review-report.md` — bare, at
the artifacts root, and in markdown rather than JSON.

**7. Sub-step numbering collides with pipeline-step numbering.**
Within prompt 24 the internal procedure is labelled "Step 2: Create Persistent Report File"
and "Step 3: Recheck Mode". These are sub-steps of prompt 24 itself, but they share a
namespace with pipeline Steps 2 and 3 (rename starter / legacy analysis). Given the file
already misnumbers itself, this is a live ambiguity for an agent reading it.

**8. Loose step-range references.** `**Backend Architecture** (Steps 5-9)` — backend
formation spans 7-9; Step 5 is solution design. Similar loose ranges appear as
`Frontend Architecture (Steps 10-14)`, `OCP Cloud Checklist (Steps 18, 23)`,
`Production Checklist (Steps 18, 20, 23)`, `xUnit Backend Checklist (Steps 7-9, 17)`.

**9. Nested triple-backtick fences will truncate the report template.**
The Report File Template opens a fence at source line 1125:

```
1125  ```markdown          <- outer fence opens
1137  ```                  <- ASCII scorecard fence — CLOSES the outer block
1147  ```                  <- intended to close the scorecard, actually REOPENS
```

Because both fences are three backticks, the outer ```markdown block terminates at 1137
rather than at its intended end. Any model or renderer parsing this prompt sees the
Summary Dashboard onward as *outside* the template. The fix is to make the outer fence
four backticks (or use `~~~` for the inner one). This is a live parsing defect in the
mandatory report schema, not a cosmetic issue.

**10. Gherkin is required in a third independent place — and attributed to Step 10.**
The Issue-to-Step Mapping Reference routes missing Playwright tests to Step 10 with the
rationale **"Foundation creates POM/Gherkin scaffold."** So Step 24 now asserts Gherkin
in §6, in the Playwright Checklist, *and* as a Step 10 deliverable — against Steps 12 and
17, which forbid `.feature` files outright. Whatever decision is made about finding 1 has
to be applied in three places in this file plus Step 10's description of its own scaffold.

**11. The category weights are stated three times in one file.**
Once in the nine scored section headers (`## 1. Parity (20%)` …), once in the
`## Category Weights` table at line 992, and once in the `## Category Breakdown` report
template at line 1034. Three copies of the same numbers is three chances to drift; one
should be the source and the others should be generated or removed.

## Transcription uncertainties (prompt 24)

- **Complete.** Line alignment was spot-verified against the source at 16 headings —
  860, 862, 864, 906, 917, 992, 1008, 1050, 1094, 1107, 1121, 1135, 1157, 1182, 1196,
  1240 — all matching. Transcribed content ends at 1247; the source shows blank lines
  through 1251.
- Lines 571-863 were photographed twice; the second batch was diffed against the first
  transcription and matched line-for-line with zero corrections.
- **Source line 879 is transcribed as `...` (an ellipsis marking omitted table rows), not
  as a closing code fence.** At photo resolution the two are indistinguishable, but the
  reading is forced by fence balance: line 864 opens ```` ```markdown ```` and line 884
  closes it, and the same `...` convention appears unambiguously at line 1056 in the
  Issue List template. It is also consistent with the block's own heading
  ("Found: 15 issues" above a 10-row table).
- Emoji throughout are mojibake in the source itself (UTF-8 read as Windows-1252) and are
  recorded as `<MOJIBAKE: emoji>` placeholders. The mojibake marker inside the Emoji
  Integrity Check's own `-match` pattern was replaced with `<MOJIBAKE MARKER>` rather than
  transcribed literally, to avoid propagating the corrupted byte sequence into this repo.
- Scope bullets render their leading glyph as `?` in the photos (e.g. `? src/<AppName>.Library/`);
  preserved as photographed.
- The History table's Delta cell shows a mojibake glyph before `X`
  (`| Previous | [date] | [X] | [X] | [<MOJIBAKE: emoji>X] |`).
- Recheck-example delta cells likewise contain mojibake arrows/checks
  (`| Score | 72 | 86 | <MOJIBAKE: emoji> +14 |`).
- File content ends at source line 1251.

## Structural facts added by prompt 23

- **The release-decision gate.** Back to `OpX-AppMod-P3-Review`. Balanced tier, 10-20 min,
  72 lines. H1 is `# Final Readiness Review` (no step-number prefix, as in 21-22).
- **No handoff status — it terminates the chain.** Every prior step declared a
  `step<N+1>HandoffStatus`; Step 23 instead declares **`releaseDecisionStatus`:
  `Pass` | `Blocked` | `Fail`**. Plus `readinessEvidenceStatus` (Current|Partial|Blocked)
  and `bridgeAndCleanupStatus` (Explicit|Partial|Blocked). This is the terminal decision of
  the numbered pipeline — notable given Step 5 referenced a "Step 24 Technical Review",
  which must therefore sit outside this handoff chain.
- **It re-grounds on four prerequisites at once**: Step 17 verification proof, Step 18
  cleanup disposition, Step 20 final verification evidence, and the Step 22 final
  acceptance artifact — "If any prerequisite is stale or missing, return `Blocked` with the
  exact prerequisite **instead of rebuilding readiness from drift**." The readiness pack
  must be "grounded in the current [Step 17/18/20/22] prerequisite proofs **rather than
  silently reusing stale readiness inputs**."
- **Anti-false-completion rule on the swap claim** — the sharpest line in the prompt:
  confirm `ui-component-map.json` and `ui-verification-report.json` "agree with the real
  current source **instead of claiming families were swapped when legacy selectors or
  bridges still remain**." A direct check against a modernization that *reports* done.
- **High-risk widget carve-out**: grids, charts, heavily customized tables, and composite
  forms need "explicit parity evidence **before any legacy version is treated as
  retired**."
- **Release artifact**: `.modernization/ignition-artifacts/reviews/deployment-readiness-review.json`,
  recording packaging/build proof, deployment-readiness proof, final compliance posture,
  remaining blockers, starter-shell preservation, control-point conformance, remaining
  bridge status, cleanup disposition for leftovers outside the final target roots, and the
  single explicit release decision.
- **"Dominion" reappears** at the end of the pipeline: the readiness pass must align "to
  the acceptance criteria and to the latest **Dominion compliance review output**" —
  bookending its first appearance in Step 4.
- **Numbering is CLEAN in this prompt.** Every step reference is correct: "Reuse current
  Step 17, Step 18, Step 20, and Step 22 prerequisite proof", "the **Step 5** ownership
  contract", "the accepted **Step 22** final-acceptance posture", and the Closure contract
  lists exactly the three statuses the Objective declared. First clean Phase 3 prompt.

## ⚠ Missing file-reading tools in prompt 23's frontmatter

The `tools:` list omits **`read/readFile`** and **`search/codebase`** — every other prompt
in the kit (1-22) includes both, and this prompt's list starts straight at
`execute/runInTerminal`. Yet its Readiness core instructs: "**Read**
`.../decisions.json`, `.../control-point-inventory.json`, and `.../migration-plan.json`
before closing readiness", and it must inspect `ui-fusion-map.json`,
`ui-component-map.json`, and `ui-verification-report.json`.

An agent bound to this tool list cannot perform its own required reads. This is a
different defect class from the numbering drift — a **capability gap** — and it would
surface at the hackathon as a Step 23 that either fails immediately or silently substitutes
terminal commands for file reads. Worth verifying at source (a wrapped line could in
principle hide the entries, though the visible indentation shows `tools:` on line 4 with
`execute/runInTerminal` on line 5).

A mechanical sweep of all 23 transcribed prompts confirms Step 23 is the anomaly:

| Prompt | `read/readFile` | `search/codebase` | note |
|---|---|---|---|
| 1 | yes | **no** | legitimate — workstation readiness needs no codebase search |
| 9 | **no** | **no** | declares **no `tools:` block at all** (uses the
  `description`/`name`/`argument-hint`/`agent` frontmatter style) — inherits agent defaults |
| **23** | **no** | **no** | **has a `tools:` block but omits both**, while instructing "Read …" |
| all others (2-8, 10-22) | yes | yes | |

So 23 is the only prompt that declares a tool list and leaves out the reading tools it
needs. Prompt 9's omission is a different (probably benign) style difference worth
confirming separately.

## Transcription uncertainties (prompt 23)

- The missing `read/readFile` / `search/codebase` entries are recorded as photographed;
  confirm against the source file before treating it as a real defect.
- Artifact paths are consistently under `.modernization/ignition-artifacts/…` in this
  prompt (no `.modernization/artifacts/…` variant), unlike prompts 21-22.
- No mojibake present.
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 33-59
  across the two photos.
- File ends at line 72.

## Structural facts added by prompt 22

- **A sixth agent**: `agent: OpX-Code-Reviewer`. Full roster: `OpX-AppMod-P1-Discovery`,
  `OpX-dotnet-upgrade`, `OpX-AppMod-P2-Modernize`, `OpX-Fusion-Reviewer`,
  `OpX-AppMod-P3-Review`, `OpX-Code-Reviewer`. Balanced tier, 10-20 min, 74 lines.
  H1 is `# FINAL ACCEPTANCE-CRITERIA REVIEW` with no step-number prefix (same as prompt 21).
- **This closes the Step 4 → Step 22 scorecard loop** — the before/after acceptance
  comparison the kit has been building toward since Discovery. The header block names all
  four artifacts explicitly:
  - **Review Type:** Final acceptance (after modernization)
  - **Manifest:** `discovery/review-manifest.json` (same manifest Step 4 used)
  - **Output:** `reviews/final-review.json`
  - **Final Gate Artifact:** `portal/data/json/FINAL-COMPLIANCE-REPORT.json`
  - **Compare Against:** `discovery/baseline-review.json` ← **Step 4's output**
  So `BASELINE-COMPLIANCE-REPORT.json` (Step 4) and `FINAL-COMPLIANCE-REPORT.json`
  (Step 22) are the bookends, with per-criterion `improvementDelta` computed between them
  exactly as prompt 04 promised.
- **"Validate the final app against the acceptance criteria AND the [Step 5] target-state
  contract together, not as separate unrelated checks"** — acceptance is not just "does it
  score well" but "does it score well *and* match the architecture we approved."
- **Three statuses**: `acceptanceMatrixStatus` (**DecisionGrade**|Partial|Blocked),
  `controlPointAcceptanceStatus` (Aligned|DriftDetected|Blocked), `step23HandoffStatus`
  (ReadyForReadinessReview|NotReadyForReadinessReview|Blocked). The completion bar is
  explicitly about *usefulness to the next step*: "Do not treat Step 22 as complete when
  acceptance findings exist but the artifact **still cannot tell Step 23 whether the final
  acceptance state is decision-grade**."
- **Four named final-acceptance blockers** (not "post-review polish"): unresolved
  control-point drift, unapproved `Temporary bridge` carry-forward, a regressed
  protected-browser-API ownership contract, and a browser surface no longer aligned to the
  Step 14 UI contract artifacts without a recorded defer reason.
- **Protected starter shell preservation is an acceptance criterion**: confirm platform-owned
  backend and browser concerns still live in the starter shell "instead of reintroducing a
  parallel custom platform surface" — the anti-fork rule enforced one last time at the gate.
- **Same chat-vs-artifact discipline as Step 21**: criterion-by-criterion deltas, bridge
  detail, and browser-surface contract detail stay in the artifacts "instead of replaying
  them in chat."
- **Step 23's name implied**: `ReadyForReadinessReview` → Step 23 is the **Readiness
  Review**.

## ⚠ Prompt 22 contains an explicit acknowledgement of the renumbering

This is the most important drift finding so far, because it shows the problem was **known
and worked around in prose rather than fixed**:

> "Use the same review contract and outputs as the prior final acceptance review lane,
> **but treat this as Step 22 in the current numbered process.**"

That line only makes sense if the author knew the surrounding content carried old step
numbers and chose to patch it with an instruction to the model instead of correcting the
references. It also explains why the drift is per-line rather than per-file: nobody swept
the bodies, they added a disclaimer.

Prompt 22's own instances (seventh handoff mismatch):
- Declares **`step23HandoffStatus`** (correct: 22 → 23); Closure contract requires
  **`step25HandoffStatus`** — never defined.
- "as the exhaustive **Step 24** proof artifacts" (should be 22); "If **Step 24** is blocked
  by stale prerequisites…" (should be 22).
- "the **Step 7** target-state contract" — target-state decisions are Step 5's.
- **Correct** in Operator focus ("the three **Step 22** status fields", "in the **Step 22**
  artifacts"), in the completion bar ("Do not treat **Step 22** as complete… tell **Step
  23**…"), and in all prerequisite citations ("**Step 20** final verification evidence and
  **Step 21** visual-review", "Reuse current **Step 20** and **Step 21** prerequisite
  proof"). The Objective/Operator/Review sections were updated; the Artifact and Closure
  contracts were not.

Running tally of the declared-vs-required handoff-field mismatch: **13, 15, 16, 19, 20, 21,
22** affected; **7, 8, 10, 11, 14, 17, 18** clean; 1-6, 9, 12 declare no handoff field.
Every Phase 3 prompt so far (19-22) is affected.

## Transcription uncertainties (prompt 22)

- **Path inconsistency within the same prompt**: the header block gives
  **Output:** `.modernization/ignition-artifacts/reviews/final-review.json` while the
  Artifact contract says "Keep those details in
  `.modernization/artifacts/reviews/final-review.json`" — same filename, different root.
  Both transcribed as shown; worth resolving at source since a script reading one and
  writing the other would silently diverge.
- No mojibake in this prompt (no emoji or non-ASCII symbols present).
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 47-60
  across the two photos.
- File ends at line 74.

## Structural facts added by prompt 21

- **First Figma MCP integration**: tools gain **`figma/*`** alongside `fusion/*` and
  `fusion/copilot-docs/*`. Same `OpX-AppMod-P3-Review` agent as Step 20. Balanced tier,
  10-20 min, 70 lines.
- **The H1 is just `# FIGMA REVIEW`** — no "Step 21" prefix, unlike every other prompt
  (`# Step NN Title`). Minor, but it means a header-based step-number extractor would fail
  on this file.
- **"Not a cosmetic-only pass" is the whole point**: "Step 21 is the visual review gate,
  but **it only counts when the reviewed UI scope is both visually aligned AND functionally
  complete enough for review**" and "It is blocked when critical feature completeness is
  still missing **even if the screenshots look good**." A design-comparison gate that
  refuses to be fooled by a pretty screenshot.
- **"Critical visible-but-unwired controls" is the named failure class** and blocks by
  default. Defined explicitly as: primary workflows, data-changing controls, exports, print
  actions, and secondary admin controls — "unless the evidence pack records an explicit
  approved defer reason." When blocked, the response must name "the exact route or screen,
  the exact blocked control, why it is critical, and the clearest remediation path."
- **Three statuses, all with a `NotApplicable` arm**: `visualReviewStatus`
  (Aligned|DriftOpen|NotApplicable), `criticalControlStatus` (Clear|Blocked|NotApplicable),
  `step22HandoffStatus` (ReadyForAcceptance|NotReadyForAcceptance|Blocked).
- **`browserSurfaceApplicability: NotApplicable` is a first-class path**, resolved from
  `decisions.json` *before* any review decision: "do not force a browser screenshot or
  Figma comparison pass. Record the explicit not-applicable reason … confirm no managed
  browser-surface visual-contract obligation remains hidden in the final review state, and
  return a truthful lightweight proof decision." API-only apps get an honest lightweight
  pass rather than a fabricated visual review.
- **Operator focus / chat-vs-artifact split** — a token-discipline pattern worth stealing:
  "Keep the numbered-step response **tight**: reviewed scope, review decision, top blockers
  …, refreshed artifact status, and the three status fields. Keep route-by-route screenshot
  comparisons, drift-by-severity detail, and reviewed-screen evidence in
  `figma-review.json` **instead of replaying them in chat**." Explicitly separates the
  durable artifact from the conversational summary.
- **New artifact path variant**: `.modernization/**artifacts**/reviews/figma-review.json`
  — a third root alongside `.modernization/ignition-artifacts/reviews/` (Step 19) and
  `.modernization/fusion-restructure/` (Steps 19-20).
- **Step 22's name implied**: "Ready**ForAcceptance**" / "final acceptance review" — Step
  22 is the acceptance review gate.

## ⚠ +2 drift in prompt 21 (sixth handoff-field mismatch, now with adjacent-line proof)

Prompt 21 makes six prompts with the declared-vs-required handoff mismatch (13, 15, 16, 19,
20, 21):

- Objective declares **`step22HandoffStatus`** (correct: 21 → 22); Closure contract requires
  the response to include **`step24HandoffStatus`** — never defined in the prompt.
- "Classify **Step 23** completion explicitly with these statuses" — this step is 21.
- "the three **Step 23** status fields" (Operator focus); "before making a **Step 23**
  decision" and "as **Step 23** blockers by default" (Review core); "the exhaustive
  **Step 23** proof artifact" (Artifact contract).
- "return a truthful lightweight proof decision for **Step 24**" — under the +2 offset that
  is Step 22, the acceptance gate.

**The tightest evidence yet that the update was applied per-line, not per-file:** two
adjacent bullets in Review core disagree —

```
- Treat unresolved critical visible-but-unwired controls as Step 23 blockers by default.   <- old (+2)
...
- When Step 21 is blocked by an unresolved control, return the exact route or screen ...   <- new (correct)
```

Prerequisite citations are correct throughout ("Reuse current **Step 20** verification
proof", "confirm current **Step 20** final verification evidence"), so the drift is
concentrated in self-referential statements about *this* step's own number.

Running tally of the declared-vs-required mismatch: **13, 15, 16, 19, 20, 21** affected;
**7, 8, 10, 11, 14, 17, 18** clean; 1-6, 9, 12 declare no handoff field.

## Transcription uncertainties (prompt 21)

- No mojibake step-reference string appears in this prompt (its Closure contract uses
  `Pass`/`Blocked` rather than a "keep the exact next step on `…`" line), consistent with
  Phase 3 prompts having a different closeout shape.
- Artifact path recorded as `.modernization/artifacts/reviews/figma-review.json` exactly as
  shown — note this differs from Step 19's `.modernization/ignition-artifacts/reviews/`.
  Whether these are genuinely different directories or a typo is worth checking at source.
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 29-59
  across the two photos.
- File ends at line 70.

## Structural facts added by prompt 20

- **A fifth agent**: `agent: OpX-AppMod-P3-Review` — distinct from Step 19's
  `OpX-Fusion-Reviewer`. So Phase 3 uses at least two agents: a Fusion specialist for the
  restructure review and a general P3 reviewer for verification. Full agent roster so far:
  `OpX-AppMod-P1-Discovery`, `OpX-dotnet-upgrade`, `OpX-AppMod-P2-Modernize`,
  `OpX-Fusion-Reviewer`, `OpX-AppMod-P3-Review`.
- **Same broad tool grant as Step 19** (`fusion/*` + `fusion/copilot-docs/*`). Balanced
  tier, 15-30 min, 73 lines. **No closing DEV/QA menu** — confirming that as the Phase 3
  shape rather than a one-off in prompt 19.
- **Three statuses**: `verificationEvidenceStatus` (Current|Partial|Blocked),
  `controlPointConformanceStatus` (Aligned|DriftDetected|Blocked), `step21HandoffStatus`
  (ReadyForVisualReview|NotReadyForVisualReview|Blocked).
- **Target-shape flexibility with proof obligation** — a good generalization rule: "When
  the selected target is the standard simple browser-led shape, final verification should
  prove `src/<AppName>.Library`, `src/<AppName>.Web.Api`, and `src/<AppName>.Web.Client`.
  When [Step 5] approved another valid target shape, **prove that approved shape instead of
  forcing the simple layout**." The gate verifies against the *approved* architecture, not
  a hard-coded one.
- **Backend runtime proof is a 5-item list**, notable for going beyond happy-path: API
  startup + health endpoint; **at least one unauthenticated protected endpoint returns the
  expected auth challenge**; **at least one mapped-role success case AND one
  insufficient-role rejection case**; current-user/policy-handler membership resolution
  "from the same evaluator and membership source used by protected endpoints"; and
  platform-owned config resolving from approved final-state sections plus "exercise one
  database-backed path when the app depends on database runtime proof." Negative-path auth
  testing as a first-class gate item.
- **Frontend runtime proof** covers canonical routes/landing/callback/logout, protected
  client API paths using the approved protected-request mechanism, client provider and
  service ownership "rather than an untracked bridge path", and — the sharp one — "confirm
  the preserved visual contract is still usable **before and after** any deliberate
  primitive-family replacement, including styling foundation, layout framing, widths,
  gutters, control heights, grid or table density, dialog sizing, and breakpoint behavior."
- **Anti-prose-summary rule, stated twice**: any failing verification family and any
  remaining `Temporary bridge` behavior must be "explicit in the returned data and
  refreshed evidence **instead of hiding it behind a prose-only summary**." A direct
  countermeasure to a model narrating success.
- **Step 21's name confirmed: "Figma Review"** — a design-comparison gate, the first
  reference to Figma anywhere in the kit.

## ⚠ +2 drift continues in prompt 20 (fifth handoff-field mismatch)

Prompt 20 has the same declared-vs-required mismatch, making it **five prompts** with this
defect (13, 15, 16, 19, 20):

- Objective declares **`step21HandoffStatus`** (correct: 20 → 21); Completion gate requires
  the response to include **`step23HandoffStatus`** — never defined in the prompt.
- QA plan says "handoff to **Step 23**" where the declared handoff is Step 21.
- Required behavior: "confirm the current **Step 21** Fusion review artifact exists … and
  that **Step 19** verification proof plus **Step 20** cleanup disposition are still the
  active prerequisites" — under current numbering those are Steps **19, 17, 18**
  respectively (and must be, since Step 20 *is* the verification step).
- "Use the **Step 7** and restructure decisions to confirm the approved target roots …
  When **Step 7** approved another valid target shape" — target-shape decisions are Step 5's
  (`decisions.json`), and the same prompt correctly cites "the **Step 5** control-point
  contract" twice in the frontend-proof section.
- **Same per-section split as prompt 19**: Execution mode uses correct new numbering
  ("Reuse current Step 19 review findings and Step 17 plus Step 18 prerequisites") while
  Required behavior ten lines later uses old numbering for the same prerequisites.
- Completion-gate "keep the exact next step on `…`" is mojibake again.

Running tally of the declared-vs-required handoff-field mismatch — the most directly
executable defect, since the agent is ordered to emit a field the prompt never defines:

| Prompt | Declares | Completion gate requires |
|---|---|---|
| 13 | `step14HandoffStatus` | `step16HandoffStatus` |
| 15 | `step16HandoffStatus` | `step18HandoffStatus` |
| 16 | `step17HandoffStatus` | `step19HandoffStatus` |
| 19 | `step20HandoffStatus` | `step22HandoffStatus` |
| 20 | `step21HandoffStatus` | `step23HandoffStatus` |

Clean: 7, 8, 10, 11, 14, 17, 18 (and 1-6, 9, 12 declare no handoff field). The defect is
**non-contiguous and spans both Phase 2 and Phase 3**, so the linter must sweep all 24.

## Transcription uncertainties (prompt 20)

- The mojibake step-reference on the Completion gate line is recorded as a placeholder;
  the decoded value is presumably old-numbering `2️⃣2️⃣`, inferred from the consistent +2
  offset rather than read.
- Artifact paths use `.modernization/fusion-restructure/…` throughout (no
  `ignition-artifacts/` prefix), matching prompt 19's Required-behavior paths.
- Window title reads `OpX-Ignition-Kit [Administrator]` as in prompt 19, with the same
  extra tabs open.
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 36-59
  across the two photos.
- File ends at line 73.

## Structural facts added by prompt 19

- **First Phase 3 prompt, and a new specialist agent**: `agent: OpX-Fusion-Reviewer` —
  the fourth agent seen (after `OpX-AppMod-P1-Discovery`, `OpX-dotnet-upgrade`,
  `OpX-AppMod-P2-Modernize`). Filename prefix changes from `P2` to **`P3`**. Premium
  reasoning (high thinking), 15-30 min.
- **Tools gain `fusion/*`** in addition to `fusion/copilot-docs/*` — the broadest Fusion
  MCP surface granted to any prompt, fitting a reviewer that must discover packages.
- **New skill**: `/.github/skills/fusion-final-restructure-review/SKILL.md` (the review
  rubric).
- **Shortest prompt in Phase 2/3 at 59 lines**, and notably **it has no closing DEV/QA
  choice menu** — no "## Step 19 DEV complete - next action", no numbered QA/next/stop
  options, no "list every file created or modified" line. Every prompt from 7-18 had one.
  Phase 3 review steps appear to use a different closeout shape.
- **Three statuses**: `fusionAlignmentStatus` (Aligned|**DriftDetected**|Blocked),
  `bridgeDispositionStatus` (Explicit|Partial|Blocked — same "explicit or it doesn't
  count" model as Step 18's cleanup disposition), `step20HandoffStatus`
  (ReadyForFinalVerification|NotReadyForFinalVerification|Blocked).
- **Anti-stale-review rule**: "Before running the review, confirm current [Step 17]
  verification proof and [Step 18] cleanup disposition exist **for the same source state
  under review**. If either prerequisite is stale or missing, return `Blocked` with the
  exact prerequisite **instead of reviewing against drift**." A review of stale evidence is
  treated as worse than no review.
- **Selective evidence invalidation**: "Refresh the Step 19 review artifact and **only the
  prerequisite evidence families that the current review actually invalidates**" — avoids
  the cascade where one review finding forces a full re-verification sweep.
- **MCP-first discovery ordering**: "Use Fusion MCP package or docs discovery **first**,
  then compare against the current starter shell under `src/`" — look up what Fusion
  offers before judging custom code, not after.
- **Review artifact**: `.modernization/ignition-artifacts/reviews/final-fusion-restructure-review.json`
  (new `reviews/` directory), carrying prioritized findings with explicit severity plus
  identified "safe remediation candidates."
- **Closing gate**: `Ready for Step 20 Final Verification: Yes` only when critical findings
  are "resolved, explicitly accepted, or recorded as real blockers **instead of being left
  implicit**." Step 20's name confirmed: **"Final Verification"**.

## ⚠ CORRECTION: the +2 drift is NOT confined to prompts 12-16 — prompt 19 has it too

Recorded under prompts 17 and 18 was the conclusion that the +2 numbering drift was
"confined to the frontend block (prompts 12-16)", because 17 and 18 are clean. **Prompt 19
breaks that conclusion.** The drift recurs after two clean prompts, so it is not a
contiguous block and cannot be fixed by scoping repairs to 12-16.

Prompt 19's instances, all +2:
- The Objective declares **`step20HandoffStatus`** (correct: 19 hands off to 20), but the
  Completion gate requires the response to include **`step22HandoffStatus`** — a field the
  prompt never defines. This is the **fourth** prompt with the declared-vs-required
  handoff-field mismatch (after 13, 15, 16).
- The prerequisite rule reads "confirm current **Step 19** verification proof and **Step
  20** cleanup disposition exist" — those are Steps 17 and 18 under current numbering
  (and semantically must be, since Step 19 *is* the reviewing step).
- **Internal inconsistency in the same prompt**: Execution mode says "Reuse current **Step
  17 and Step 18** prerequisite proof" (new numbering, correct) while Required behavior
  says "**Step 19** verification proof and **Step 20** cleanup disposition" (old numbering)
  — two lines describing the same two prerequisites with different numbers. A clean
  demonstration that the update was applied per-section, not per-file.
- The Completion gate's "keep the exact next step on `…`" string is mojibake again (emoji
  + keycap digits), consistent with the corrupted step-reference strings in prompts 15-16.

**Revised scope for the linter**: run it across **all 24 prompts**, not a range. The
observed pattern (12,13,14,15,16 drifted / 17,18 clean / 19 drifted) means clean prompts
prove nothing about their neighbours.

## Transcription uncertainties (prompt 19)

- The file ends at line 59 with no closing menu. Since only one photo covers this prompt
  and the editor showed no further content, this is recorded as complete — but worth a
  quick scroll-check at the source to confirm nothing follows.
- The mojibake step-reference on the Completion gate line is recorded as a
  `<MOJIBAKE: emoji + keycap digits>` placeholder; the decoded value is presumably the
  old-numbering `2️⃣1️⃣` given the consistent +2 offset, but that is inferred, not read.
- Artifact paths in Required behavior use `.modernization/fusion-restructure/…` while the
  review artifact uses `.modernization/ignition-artifacts/reviews/…`; both as shown (same
  split noted in prompts 13-16).
- The window title reads `OpX-Ignition-Kit [Administrator]` here rather than
  `IgnitionKit1.2` as in prompts 12-18, and other tabs are open
  (`ORIGINAL-BASELINE-COMPLIANCE-REPORT.md`, an "Execute Discovery Steps Review" Copilot
  tab) — possibly a different workspace or a later session.
- Long wrapped lines reconstructed from wrap positions.

## Structural facts added by prompt 18

- **The pre-review cleanup lane and the last Phase 2 step** (Balanced tier, 10-20 min,
  129 lines — one of the shortest). Exists so "review" does not have to discover cleanup
  drift. Three statuses: `deploymentReferenceStatus` (Aligned|Partial|Blocked),
  `cleanupDispositionStatus` (**Explicit**|Partial|Blocked), `step19HandoffStatus`
  (ReadyForReview|NotReadyForReview|Blocked).
- **`cleanupDispositionStatus: Explicit` is the interesting value** — the gate is not "all
  leftovers removed" but "every retained leftover is *explicit with rationale*." Retention
  is allowed; silent retention is not.
- **Five MANDATORY pre-review verification blocks**, each closing with the same formula
  ("Cleanup without X verification is incomplete Step 18 coverage"):
  - **Production-Ready Cleanup**: no TODO/FIXME/HACK in production code (move to backlog),
    no `console.log`/`debugger`/test-only code, no dead imports/variables/functions/
    components, formatters run (Prettier, `dotnet format`), README updated with current
    architecture and run instructions.
  - **Test Coverage**: backend >80% on Library business logic, Playwright coverage for all
    routes, POMs current with latest selectors, Gherkin scenarios runnable, "no skipped or
    ignored tests without documented reason."
  - **Accessibility**: `aria-label`/`aria-labelledby` on all interactive elements,
    `data-testid` on all testable elements, full keyboard navigation, no a11y warnings in
    build output.
  - **Deployment Readiness**: health check endpoints respond, env-specific config
    externalized, **no secrets in source code**, Dockerfile builds and runs, OpenShift
    manifests reference correct image/paths.
  - **Cutover And Rollback Verification**: verify the Step 5 `cutoverAndRollbackPlan` is
    "real and executable — **Phase 2 cannot ship without it**"; feature flag named/owned/
    switchable; rollback documented with steps, owner, and max time-to-rollback; and
    **execute a dry-run of the rollback against a non-prod environment**, recording
    `{env, executedAt, durationSec, success, evidencePath}` in
    `step18-rollback-dryrun.json`. Explicitly generic across OpenShift, Kubernetes, App
    Service, IIS, ECS, and on-prem.
- **Performance And Bundle Verification (MANDATORY when browser-surface is in scope)** —
  re-runs the perf measurement **against the deployed artifact, "not just the dev build"**,
  re-measures gzipped initial bundle and lazy chunks per route, and fails the step if any
  Step 5 budget regresses without a recorded deferral (`step18-perf-verification.json`).
- **Cleanup ordering rule worth stealing**: "Remove UI bridge wrappers **only when** the
  corresponding Fusion component family has already been verified and recorded as final
  state" — bridges outlive their slice until that slice is provably done.
- **Stale-alias sweep**: retired portal aliases, dead selected-page tokens, retired
  step-surface names, and outdated workflow references must be removed or explicitly
  retained "when they still point at obsolete modernization outputs" — the kit cleaning up
  after its own renamed surfaces (e.g. the `frontend-modernization-parity` → 
  `frontend-foundation-and-scaffold` rename from prompt 10).
- **Secrets rule stated twice**: "No secrets in source code" and "raw secret values must
  not appear in any committed file"; `environmentConfigPlan.environments[]` values get
  promoted into deployment config with secrets resolving from the planned secret store.
- **Numbering is CLEAN** (`step19HandoffStatus`, "Ready for Step 19 Final Fusion
  Restructure Review", "continue to Step 19 (Phase 3 Review)"), reconfirming the +2 drift
  was confined to prompts 12-16.
- **Step 19's name confirmed**: "Final Fusion Restructure Review", and it is **Phase 3** —
  so Phase 2 Modernize spans Steps 7-18 and Phase 3 Review begins at Step 19.

## Transcription uncertainties (prompt 18)

- The Completion gate's "Otherwise keep the exact next step on `18-P2-deployment-and-clean-up`"
  uses the **filename** where every other prompt uses the human step name ("Step NN Title");
  transcribed as shown.
- Double-backtick identifier styling in the Cutover/Rollback and Performance/Bundle
  sections preserved as shown.
- No mojibake observed in this prompt (no emoji or `>=` symbols present), consistent with
  corruption affecting only non-ASCII characters.
- Long wrapped lines reconstructed from wrap positions; overlaps verified at 49-58 and
  104-110.
- File ends at line 129.

## Structural facts added by prompt 17

- **The S-TIER verification gate Step 6 has been planning toward since the start** — and the
  largest prompt in the kit at 446 lines. Balanced tier, 15-30 min. Validates ALL
  accumulated test work from Steps 6-16.
- **Three self-checks including a second content reconciliation**:
  `Invoke-StepReconciliation.ps1 -Step 17` proves "every non-deferred testcase in
  `executable-testcase-catalog.json` points to a test file that **actually exists**" —
  explicitly because "a shape check cannot catch a catalog entry that names a test file
  which was never created." Fix path: implement the test, or mark `Deferred` with a
  `deferralId` and re-run Step 6.
- **THE 12 QUALITY GATES**, each with Criteria checklist / Validation command /
  Remediation steps: (1) Characterization 100%, (2) Unit ≥95% line, (3) Contract 100% API,
  (4) Integration ≥95% critical path, (5) Database 100% table, (6) Angular 100% component
  (Karma/Jasmine ≥90%), (7) Visual Parity ≥85% (90% stretch), (8) Smoke 100% pass,
  (9) E2E 100% journey, (10) Test Quality Standards 100% compliance, (11) Page Object
  Models 100%, (12) Test Documentation 100%.
- **Plus 11 MORE "Discovery-Backed Verification Gates" (MANDATORY)** tied to Step 6
  `progressDenominators` and Step 5 `decisions.json`: Visual Parity Floor
  (`routeStateParity >= 90`), Performance Baseline (FCP/LCP/TTI/apiCallCount/payloadBytes
  within budget), Bundle Size (gzipped, per route), Accessibility Audit (Lighthouse ≥90,
  zero critical/serious axe violations), Error State Coverage, Export Surface Coverage,
  Realtime And Push Coverage, Localization, Flake Budget, **Progress Denominator
  Verification** ("Estimated percentages are forbidden"), and Cutover Readiness Pre-Check.
  Results land in `step17-gate-results.json` as `{gateId, status, evidencePath, deferralId?}`.
- **Mutation Testing Gate (MANDATORY)** — the strongest test-quality idea in the kit:
  `Stryker.NET` (backend Library + Web.Api) and `StrykerJS` (client) run "to prove the
  tests actually catch behavior breaks instead of just executing covered lines." Emits
  `mutation-score.json` with `mutationScorePercent`/`mutantsKilled`/`mutantsSurvived`/
  `mutantsTimedOut`/`survivedMutants[]` (location, mutator, snippet). Thresholds:
  **full-scope ≥60%, critical-path ≥80%**; surviving mutants on critical-path classes are
  blockers — "either add the test that kills the mutant or amend the `criticalPathInventory`
  with reviewer-approved justification." Scoped first to the Step 8 critical-path
  inventory, then expanded.
- **4-phase execution flow**: Validation (run all gates) → Remediation (fix all failures,
  repeat until pass) → Final Verification (rerun ALL gates from start, 100% pass) →
  Documentation Sweep (spot-check 5 random test files for comment-style deviations).
- **A worked completion-gate JSON** with all 12 gates PASS, per-lane test counts
  (characterization 45 / unit 212 / contract 28 / integration 56 / database 24 /
  angular 87 / e2e 32 / smoke 12 / **total 496**) and coverage metrics — a concrete shape
  the agent fills rather than invents.
- **Four returned values**: `step17Status` (Complete|InProgress|Blocked),
  `qualityGateStatus` (per-gate pass/fail), `testDocumentationCompliance`
  (100%|Partial|Incomplete), `step18HandoffStatus`
  (ReadyForCleanup|NotReadyForCleanup|Blocked).
- **Numbering is CLEAN in this prompt** — `step17Status`, `step18HandoffStatus`, "Step 18
  Deployment & Clean Up" all correct. This confirms the +2 drift was confined to the
  frontend block (prompts 12-16). Only two minor suspects: "+10% of **Step 5**
  `performanceBaseline`" (prompt 06 attributes `performanceBaseline` to Step 3) and
  "amend **Step 7's** `criticalPathInventory`" (surrounding text says Step 8 twice).
- **Step 18's name confirmed**: "Deployment & Clean Up". QA twin
  `17-QA-rewire-all-tests-and-verify` runs every lane (Unit, Integration, Contract,
  Browser-contract, E2E, Legacy characterization; 15-30 min) — "the full Phase 2 quality
  gate before **Phase 3** review", first explicit reference to a Phase 3.

## ⚠ Internal contradiction in prompt 17: does Step 17 author tests or not? (HIGH fork-risk)

The prompt states both positions in load-bearing places:

**"Step 17 does the work":**
- frontmatter description: *"ALL TESTING IS DONE HERE. Steps are NEVER validation-only.
  Dev work is ALWAYS done."*
- CORE PRINCIPLE banner: *"Step 17 makes testing PERFECT… ALL TEST WORK WILL BE DONE HERE.
  WE WILL COMPLETE EVERYTHING."*
- Dev work bullet: *"Complete any missing tests…"*
- Gates 1, 3, 4, 5, 6, 9, 11, 12 remediation: *"Create missing … tests with full
  documentation"*
- Phase 2 of the execution flow: *"Add missing tests with full documentation"*

**"Step 17 must NOT author tests":**
- Gate 2 remediation: *"Step 17 does not derive new scenarios… Route back to that step
  (Step 8/9/12/etc.)… then to Step 6 to extend the catalog… **Do not author tests directly
  inside Step 17. Step 17 verifies; it does not plan and does not derive.**"*

Gate 2 is the position consistent with the rest of the kit (Step 6's "Phase 2 has no
derivation authority", Step 14's "any field it has to invent is an upstream gap"), and its
routing loop is precisely correct. But it is one bullet against the title, the description,
the all-caps banner, and eight other gates. Under time pressure a developer follows the
banner, authors tests locally, and silently breaks the catalog-is-the-work-order contract
the whole kit depends on — the catalog then no longer describes the test suite, and the
Step 17 reconciliation that is supposed to catch exactly that will pass because the files
now exist.

## ⚠ App-specific leakage into a generic kit (prompt 17)

Gate 10 and Phase 4 both hard-code a specific app's test file as the style oracle:
*"Comment style matches **`LegacyConnectionStringProviderTests.cs`** exactly"* and
*"Spot-check 5 random test files against `LegacyConnectionStringProviderTests.cs`"*. That
file will not exist in any other application, so both instructions are unsatisfiable at a
hackathon. The kit's own pattern elsewhere (data-driven from `componentCensus`,
`progressDenominators`, registries) shows the intended fix: name the style contract, not a
file from one app.

## Transcription uncertainties (prompt 17)

- **Encoding corruption is confirmed widespread, not just in step-reference strings.** `≥`
  renders as `â‰¥` throughout the gate headings ("Unit Tests (â‰¥95% Line Coverage)"), `✅`
  renders as `âœ…` in the "Do NOT close Step 17 until" checklist, and all four section
  emoji are mojibake. Transcribed with ASCII equivalents (`>=`, `[x]`) and
  `<MOJIBAKE: emoji>` placeholders rather than reproducing corrupted bytes.
- Gate 1 remediation says "Find all CaseIds with `owningStep < 10`" — likely intended as a
  characterization-owning-step bound (Step 6 assigns characterization to owningStep 7);
  transcribed as shown.
- The completion-gate JSON's `completedAt` is a literal example timestamp
  (`2026-05-28T10:00:00Z`), not a placeholder token; preserved as shown.
- Double-backtick identifier styling throughout the Discovery-Backed and Mutation Testing
  sections preserved as shown.
- Long wrapped lines reconstructed from wrap positions; overlaps verified at 51-61,
  101-115, 149-165, 195-215, 265-272, and 405-410.
- File ends at line 446.

## Structural facts added by prompt 16

- **The continuation lane**: picks the next eligible family/sub-pattern from the Step 14
  order and runs **Step 15's prompt in full** for that one slice
  (`.github/prompts/15-P2-fusion-ui-integration.prompt.md`) — the first prompt in the kit
  that invokes another numbered prompt as its executor. "It runs Step 15's replacement
  contract for that one slice - it does not invent a different process."
- **Or proves the lane exhausted.** `nextEligibleFamilyStatus`:
  `Advanced` | `Exhausted` | `Blocked`; plus `artifactReconciliationStatus`
  (Current|Partial|Blocked) and `step17HandoffStatus`
  (ReadyForVerification | **ContinueUiLane** | Blocked) — the `ContinueUiLane` value makes
  "loop back to me" a first-class status rather than an implicit outcome.
- **Eligibility Predicate (MANDATORY)** — the anti-guessing core, four conjunctive
  conditions: `migrationEligible` is not `false`; `bindingShape` is supported by the
  wrapper/target "without a binding-shape refactor in the same pass"; every
  `requiresWrapperCapability` entry is present in the current wrapper; and the slice was
  not already advanced in a prior pass (checked against `ui-fusion-map.json` map keys).
  "If no remaining slice is eligible under this predicate, classify
  `nextEligibleFamilyStatus: Exhausted` and proceed to Step 17. **Do not improvise
  eligibility outside this predicate.**" Exhaustion claims must cite the predicate rows.
- **Sub-Pattern Progress (MANDATORY)**: exactly one sub-pattern per pass — "do not chain
  two sub-patterns even when they belong to the same family"; read `subPatternProgress`
  before selecting; follow `suggestedPassOrder`; skip-with-reason when a wrapper capability
  is unsatisfied (choice is "close the wrapper-capability gap first or move to the
  next-eligible sub-pattern"); close as `familyRetirementStatus: Partial` with a named
  `followUpSlice` while sub-patterns remain, `Complete` only when all are migrated or
  deferred.
- **Sibling Slice Regression Gate (MANDATORY)** — genuinely new and the sharpest idea in
  this prompt: after the primary slice lands, **rerun the verification suite (visual
  parity, E2E click-through, accessibility scan, console-error watch) for the 2-3 nearest
  sibling slices**. Siblings are data-driven from `slice-graph.json` — slices sharing a
  route ancestor, a parent module/feature folder, or a common wrapper from
  `wrapper-versions.json`. Emits `sibling-regression/<sliceId>.json` with
  `primarySliceId`/`siblingSlicesChecked[]`/`regressionFindings[]`
  (`siblingSliceId`, `check` ∈ visual-parity|e2e|a11y|console-errors, `status` ∈
  pass|warn|fail, `evidencePath`). **Any sibling `fail` blocks the primary slice from
  closing.** This is blast-radius verification — catching the case where swapping one
  family silently breaks its neighbours through a shared wrapper.
- **Inherits Step 15's economics**: same ROI-First scoring
  (`(visibilityScore + interactionScore) - riskScore`, first three passes must be visible
  on the running app), same 5-10pp parity gain floor, same repeat-run recommendation — but
  with its own diff path `parity-diffs/step16-pass-{passId}/`.
- **Step 17's name confirmed**: "Rewire All Tests & Verify".

## ✅ Numbering drift SOLVED: a clean +2 offset, confirmed by decoding the mojibake

Prompt 16 resolves the drift question definitively, and **corrects the "messy mixed drift"
characterization recorded under prompt 14.**

Two lines in prompt 16's Completion gate render as mojibake in the editor:

```
- Keep the exact next step on `ðY"ß 1ï.ßâfE8ï.ßâf£ Next Fusion UI Upgrade Slice`
- Hand off to `ðY§ª 1ï.ßâf£9ï.ßâf£ Rewire All Tests & Verify`
```

`ðŸ` is the classic signature of UTF-8 bytes decoded as Windows-1252, and `1ï¸â£` is
exactly how the emoji keycap `1️⃣` mis-decodes. So those strings are really:

- `🔷 1️⃣8️⃣ Next Fusion UI Upgrade Slice`  → **Step 18**
- `🧪 1️⃣9️⃣ Rewire All Tests & Verify` → **Step 19**

…inside the prompt whose filename, header, and Objective all say **Step 16**. Every
mis-numbered reference across the frontend block is exactly **+2**:

| Prompt (declared) | Objective declares | Completion gate requires | Old-number self-refs |
|---|---|---|---|
| 12 | — | — | "Step 14" ×9 |
| 13 | `step14HandoffStatus` ✓ | `step16HandoffStatus` | "Step 15 Self-Audit" |
| 14 | `step15HandoffStatus` ✓ | — | "Step 15 coverage" ×3 (+1, the one partial fit) |
| 15 | `step16HandoffStatus` ✓ | `step18HandoffStatus` | "Step 17 pass", `step17-pass-{passId}/` |
| 16 | `step17HandoffStatus` ✓ | `step19HandoffStatus` | "Step 18 pass", "Step 17 `wrapper-versions.json`" |

**Mechanism:** the pipeline was renumbered **down by two** (old 14→12, 15→13, 16→14,
17→15, 18→16, 19→17). Frontmatter, headers, and **Objective** blocks were updated;
**Completion gates, Self-Audit blocks, and several MANDATORY sections were not.** Prompt 16
is internally split down the middle — its "If You Hit A Blocker" section uses correct new
numbering ("Only advance to Step 17…", "keep the exact next step on `Step 16 Next Fusion UI
Upgrade Slice`") while its Completion gate ten lines earlier uses old numbering with
corrupted emoji.

**Two independent defects, both mechanically fixable:**
1. **Numbering:** a linter comparing each prompt's declared step against every `Step N` /
   `step<N>HandoffStatus` / `-CurrentStep N` / `stepNN-pass-` reference catches all of it.
   Every prompt 13/15/16 orders the agent to emit a `step<N>HandoffStatus` it never
   defines.
2. **Encoding:** the emoji in step-reference strings are corrupted UTF-8-as-Windows-1252.
   These appear inside "keep the exact next step on `…`" instructions, so an agent
   following them literally emits garbage. Detect with a grep for `ðŸ` / `ï¸â£` across the
   kit and re-save the affected files as UTF-8. (Prompt 15 showed the same corruption; its
   status bar reads "UTF-8 **with BOM**" where earlier prompts read plain UTF-8.)

## Transcription uncertainties (prompt 16)

- The two mojibake strings in the Completion gate are recorded in the transcription as
  `<MOJIBAKE: emoji + keycap digits …>` placeholders rather than reproducing the corrupted
  bytes, since the corruption is the finding and reproducing it would risk propagating it.
  The decoded intent (`🔷 1️⃣8️⃣` / `🧪 1️⃣9️⃣`) is inferred from the standard
  UTF-8→Windows-1252 mapping, not read directly — verify against the source file.
- Double-backtick identifier styling in the ROI-First, Per-Slice, and Sibling Regression
  sections preserved as shown.
- Artifact paths again split between `…/ignition-artifacts/modernize/fusion-restructure/…`
  (Required behavior) and `.modernization/fusion-restructure/…` (gates); both as shown.
- Long wrapped lines reconstructed from wrap positions; overlaps verified at 51-59 and
  95-101.
- File ends at line 138.

## Structural facts added by prompt 15

- **The one-family-per-pass swap lane** (Premium reasoning / high thinking, **15-30 min
  _per primitive family_** — the first per-unit estimate in the kit). Advances exactly ONE
  primitive family to its mapped Fusion target. "One family per pass keeps each change
  small, reviewable, and reversible."
- **New skill**: `/.github/skills/fusion-ui-component-upgrade/SKILL.md`, loaded and
  followed "before selecting or editing the family surface."
- **The Steps 10-13 baseline is named the "reference oracle"** every swap is proven
  against — and if a swap reveals the baseline was wrong, "that is an upstream regression
  to fix at its owner step," not Step 15 work. Batching families is explicitly out of
  scope: "one family only - the next family is Step 16."
- **Wrapper-Extension Preflight (MANDATORY)** — do the wrapper work *once*, up front: read
  both the wrapper's current input surface AND the underlying Fusion primitive's surface
  **via Fusion MCP** ("do not infer the primitive's input surface from prior
  conversations"), then add every input the family will need in one pass (`placeholder`,
  `min`, `max`, `step`, `decimals`, `rows`, `valuePrimitive`, `readOnly`, `disabled`,
  `elementId`, `testId`, generic `options`) "so later sub-pattern passes do not need to
  extend the wrapper mid-stream." Generic-primitive wrappers (e.g. `fusion-dropdown`) must
  keep `options` permissive (`Record<string, unknown>`); form-field wrappers need both
  `readOnly` and `disabled` with a derived `controlDisabled = readOnly || disabled`; and
  `elementId`/`testId` must forward so `<label for=…>` and `data-testid` keep resolving.
  **"A first swap that requires a wrapper extension after the swap is incomplete Step 15
  coverage and must be retried with the preflight applied."**
- **Wrapper API Stability Gate (MANDATORY)** — genuinely new, and the most
  library-engineering idea in the kit: once a wrapper has shipped a pass, its public
  surface is **frozen** — every `@Input`, `@Output`, `ContentChild`, exposed template
  variable, exposed CSS custom property, and exposed slot becomes "the wrapper's published
  contract." Later passes may add **additive** inputs only when the wrapper-capability plan
  is amended, the change is backwards compatible (defaults preserve behavior), and the
  version is bumped in `wrapper-versions.json`. Breaking changes (rename, remove,
  type-narrow, default-shift) require **a new wrapper name plus a planned
  consumer-migration row** — "legacy callers cannot be silently rewritten."
  `wrapper-api-snapshots/<wrapperName>.<version>.json` is emitted every pass and the
  snapshot diff becomes review evidence.
- **Parity Gain Floor (MANDATORY)**: each pass must raise touched-family parity by ≥5
  percentage points (target 5-10) unless already above 95%. A pass with `parityGain < 5`
  and pre-pass parity `< 95` must rework the slice, split it into a smaller higher-impact
  slice, or be classified `Partial` with the exact blocker recorded.
- **ROI-First Slice Selection (MANDATORY)**: score candidates
  `{visibilityScore 1-5, interactionScore 1-5, riskScore 1-5, parityGainEstimate}` and take
  the highest `(visibility + interaction) - risk`; record the score in the pass entry "so
  the choice is reviewable." The first three passes on a new surface must produce "a
  noticeable change on the live application" — interactive controls and primary action
  buttons before "low-visibility passive containers or background scaffolding."
- **Repeat-Run Recommendation (MANDATORY)**: every non-exhausting pass must explicitly
  recommend rerunning with the expected `+5 to +10` point gain and name the next-eligible
  slice with its visibility/interaction score.
- **Per-Slice Visual Parity Diff (MANDATORY)**: before/after for the touched
  `{routeId, stateId}` rows only — "not the whole app" — with pixel and structural diff
  artifacts, recorded into `ui-fusion-map.json` as
  `{passId, sliceId, parityBefore, parityAfter, parityGain, diffArtifacts[]}`.
- **Fusion accessibility + POM mandates**: preserve-or-improve ARIA, `data-testid` pattern
  `fusion-{family}-{purpose}` (e.g. `fusion-button-submit`), keyboard navigation identical
  to legacy; POM selectors and Gherkin steps updated with the swap.
  `npm run verify:fusion-ui` refreshes the component-level verification report.
- **Blocker framing worth stealing**: "A half-swapped family — a `fusion-*` primitive
  rendering with the wrong variant, width, or a broken binding — is **worse than the legacy
  control it replaced**, so finish or cleanly revert the one family here rather than moving
  on." Named likely causes: missing wrapper input, or `valuePrimitive` not set so the bound
  value broke.
- **Closing menu**: QA twin `15-QA-fusion-ui-integration` (Lanes: Browser-contract, Visual
  parity, Accessibility smoke; ETA 3-5 min) / `next` → Step 16 DEV / `stop`. Step 16's name
  confirmed: "Next Fusion UI Upgrade Slice".

## ⚠ Cross-step numbering drift found in prompt 15 (HIGH — includes a self-contradiction)

Same class as prompts 12-14, and this one contradicts itself on a status field name:

- **Declared vs. required status field disagree.** The Objective declares
  **`step16HandoffStatus`** (`ReadyForNextSlice` | `NotReadyForNextSlice` | `Blocked`) —
  correct for Step 15 handing off to Step 16. But the Completion gate requires the response
  to "include explicit `primitiveFamilyExecutionStatus`, `componentVerificationStatus`, and
  **`step18HandoffStatus`** values." `step18HandoffStatus` is never defined anywhere in the
  prompt.
- **Step 17 used for this step's own coverage and artifacts**: "A pass that did not produce
  a per-slice diff is incomplete **Step 17** coverage and cannot close"; diff artifacts are
  written to `parity-diffs/**step17**-pass-{passId}/`; "Once a Fusion wrapper has shipped
  one **Step 17** pass, its public surface is frozen." (By contrast "part of the **Step 17**
  review evidence" is plausibly correct — Step 17 is the S-TIER verification gate per
  prompt 06.)
- **Wrong producer step for the wrapper plan**: "only when **Step 7's**
  `wrapperCapabilityPlan` is amended" — `wrapperCapabilityPlan` is a Step 5 deliverable per
  prompt 05 (and prompt 14 correctly cites Step 5 for the same artifact).

Running tally of the drift pattern (prompts 12-15): every frontend Phase 2 prompt carries
step-number references that disagree with its own declared number, in mutually
inconsistent directions (12→14, 13→15/16, 14→15, 15→17/18). Prompts 13 and 15 both
reference a `step<N>HandoffStatus` they never define, which is the most directly executable
failure — an agent asked to emit an undefined field must either error or invent it.

## Transcription uncertainties (prompt 15)

- Completion-gate line 137 shows apparent mojibake where the step name belongs — rendered
  as emoji/box glyphs before "Fusion UI Integration" rather than the expected "Step 15".
  Transcribed as `Step 15 Fusion UI Integration`; flag for re-read against the source since
  it may be a real encoding corruption in the file (the file is saved as UTF-8 **with BOM**
  per the status bar, unlike earlier prompts).
- Double-backtick identifier styling in the Per-Slice Diff, Parity Gain Floor, ROI-First,
  and Wrapper API Stability sections preserved as shown.
- Artifact paths again split between
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` (Required behavior)
  and `.modernization/fusion-restructure/…` (gates); both transcribed as shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  51-61, 104-112, and 125-133.
- File ends at line 170.

## Structural facts added by prompt 14

- **Planning-only lane — the first Phase 2 step that changes no code.** "It is planning
  only: no `src/` behavior changes here." Balanced tier, 15-30 min. Produces the four
  artifacts Steps 15-16 execute against: `ui-inventory.json` (per-control classification),
  `ui-visual-contract.json` (the measurable visual answer key),
  `ui-fusion-map.json` (Fusion-owned / wrapper / bridge / keep), and
  `ui-migration-order.json` (dependency-safe order).
- **Entry discipline is a hard gate on the previous step's artifact**: Step 14 "begins the
  Fusion map-and-swap block, so do not start it until the Step 13 visual-parity gate
  passed" — requires a current `visual-parity-report.json` with `overall: pass`; missing,
  stale, or `fail` routes back to Step 13 "instead of mapping and swapping over a shell
  that does not yet resemble the legacy app."
- **"Upstream Source Of Truth (MANDATORY)" — the cleanest anti-absorption rule in the
  kit**: "Step 14 is a refresh, not a discovery." Per-control classification originates in
  Step 3 `uiControlClassification`; wrapper-capability requirements in Step 5
  `decisions.json.wrapperCapabilityPlan`; sub-pattern order in Step 5
  `ui-migration-order.json`. **"Any field Step 14 has to invent from raw source is an
  upstream gap and must route back to Step 3 or Step 5 instead of being absorbed here."**
- **Seven mandatory per-control classification fields**, each tied to a concrete downstream
  swap hazard: `bindingShape` (twoWayNgModel | oneWayNgModel | uncontrolledValueEvent |
  reactiveFormControl | uncontrolledNoModel), `optionsAreLiteralModelValues` (`<option>`
  with no `value` attribute → replacement arrays must satisfy `label === value` and bind
  `valuePrimitive=true`), `migrationEligible` (`false` for parity-scaffold /
  reverse-engineering capture controls — "must never surface as Step 15 or Step 16
  candidates"), `compositeGroupId` (visually paired controls forming one semantic unit —
  swapped as a unit or explicitly deferred), `dynamicId` (template-interpolated ids like
  `id="lrSum-{{i}}"` require a documented `testIdFn` before swap),
  `requiresWrapperCapability` (Step 16 must skip slices whose capability is absent), and
  `dialogContext` (dialog controls belong to a dialog family, not the main-shell family).
- **Sub-Pattern Cataloging (MANDATORY)**: group by binding shape, value type
  (boolean/numeric/string-literal/lookup-object), and wrapper-capability requirement;
  record `{subPatternId, description, controls[], requiresWrapperCapability[],
  suggestedPassOrder}`; a family with 3+ sub-patterns must declare a dependency-safe
  `suggestedPassOrder` "so Step 16 selection is deterministic."
- **Component Reuse Analysis (MANDATORY)** — new technique: cluster components *across
  routes* by shape signature (input props, emitted events, content slots, control
  composition, layout role), via normalized template-AST hashing, `@Input`/`@Output`
  similarity, or visual signature comparison of captured screenshots. Emits
  `component-reuse-clusters.json` with `clusterId`/`signatureSummary`/`members[]`/
  `similarityScore` (0..1)/`recommendation` (unify-now | unify-at-step-15 | keep-distinct |
  needs-review)/`recommendationReason`. **≥ 0.85 similarity defaults to
  `unify-at-step-15`** "so Step 15 wrapper work consolidates the duplicate surfaces into a
  single Fusion-backed wrapper instead of shipping N near-identical wrappers." Signature
  extraction is data-driven from `componentCensus` + `uiControlClassification`, "not from
  hard-coded component names."
- **Accessibility Inventory + Playwright Test Inventory** per primitive family (current
  ARIA/`data-testid`/keyboard/screen-reader status and required remediation; existing POM
  and Gherkin coverage or gaps). Grids, charts, heavily customized tables, and composite
  forms are flagged high-risk families requiring explicit test plans.
- **Three status axes**: `inventoryCoverageStatus` (DecisionGrade|Partial|Blocked),
  `visualContractStatus` (Measured|Partial|Blocked), `step15HandoffStatus`
  (ReadyForUIReplacement|NotReadyForUIReplacement|Blocked). Fixed closing gate:
  `Ready for Step 15 Fusion UI Integration: Yes`.
- **The lightest QA twin in the kit**: `14-QA-frontend-ui-inventory-and-fusion-map` —
  "Artifact schema validation only (no test execution)", "Under 1 min ET. Chainable /
  auto-runnable." Because Step 14 changes no code, its QA is pure schema validation and is
  explicitly safe to auto-chain. Step 15's name confirmed: "Fusion UI Integration".

## ⚠ Cross-step numbering drift found in prompt 14 (MEDIUM — milder than 12/13)

Prompt 14 is largely self-consistent (`step15HandoffStatus` and "Ready for Step 15 Fusion
UI Integration" are correct for a Step 14 prompt handing off to Step 15), but three
coverage statements describe **this** step's own completeness using the wrong number:

- "Inventory without accessibility gaps documented is incomplete **Step 15** coverage."
- "Inventory without test gap analysis is incomplete **Step 15** coverage."
- "Inventory without these per-control fields populated is incomplete **Step 15** coverage
  and **Step 16** must not advance."

All three describe the inventory — Step 14's own deliverable — so they should read
Step 14 (and, in the third, likely Step 15 rather than Step 16). Notably the parallel line
in the Sub-Pattern section gets it right: "families without sub-pattern cataloging are
incomplete **Step 14** coverage."

**SUPERSEDED — see "Numbering drift SOLVED" under prompt 16.** This section originally
concluded that no single renumbering hypothesis fit prompts 12-14. Prompt 16's decoded
mojibake (`1️⃣8️⃣`/`1️⃣9️⃣` inside the Step 16 prompt) established a clean **+2 offset**
across the whole frontend block: the pipeline was renumbered down by two, and Objective
blocks were updated while Completion gates and Self-Audit blocks were not. Prompt 14's
three "incomplete Step 15 coverage" lines remain the one +1 outlier, most likely
copy-pasted boilerplate from the neighbouring prompt.

## Transcription uncertainties (prompt 14)

- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  53-61, 104-116, and 123-133.
- Double-backtick identifier styling in the Component Reuse Analysis section preserved as
  shown.
- The Required-behavior artifact paths use
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` while the
  visual-parity and visual-contract references use `.modernization/fusion-restructure/…`;
  both transcribed as shown (same divergence noted in prompt 13).
- File ends at line 164.

## Structural facts added by prompt 13

- **The last shell-level gate before UI planning** (same agent + browser tools; Balanced
  tier, 10-25 min). Owns visual, layout, navigation, and responsive parity of the
  stabilized shell. Four status axes: `shellParityStatus` (Stable|Drifting|Blocked),
  `shellGuardStatus` (Aligned|Stale|Blocked), `fieldParityStatus`
  (Reconciled|Drifting|Blocked), `step14HandoffStatus`
  (ReadyForUIPlanning|NotReadyForUIPlanning|Blocked).
- **"Regression guard, not re-derivation"** — the cleanest ownership statement in the kit:
  Step 13 CONSUMES Step 11's control/column verdict and Step 12's live-data verdict. If a
  dropped column or unfilled grid shows up here, it is "a **Step 11/12 regression** to
  route back to its owner and fix at the source, **not new Step 13 work**." Same for the
  styling foundation (Step 10). Three adjacent steps, three non-overlapping jobs, with the
  routing rule stated explicitly.
- **Visual Parity Gate** (`/.github/skills/visual-parity-gate/SKILL.md`) — composes the
  runtime-parity-checkpoint and screenshot-capture skills, **boots the modern app AND the
  legacy app on a second port when runnable**, captures matching routes, and diffs
  computed styles + screenshots against `ui-visual-contract.json` +
  `styling-foundation.json`. Per-route `pass`/`partial`/`fail` across palette, typography,
  header/nav/footer presence, nav route model, layout density. `overall: pass` only when
  every route passes or every non-pass route is in `acceptedResidualGaps[]` with a real
  reason and owner — "do not silently downgrade a `fail` route to an accepted gap."
- **Field & Control Parity Reconciliation Gate** — side-by-side comparison in the
  integrated browser, booting the modern app and the runnable legacy app
  (`LegacyCode_NETXX_Upgrade` when the original `LegacyCode/` host is not runnable) on
  separate ports, comparing "column-for-column and control-for-control". Records
  `fieldParity` roll-up plus `columnsMissing[]` / `inertControls[]` per route.
- **Two behavioral gates carried from Step 12's assertion families** now as binary
  completion gates: `filterEffectParity = pass` ("a filter that does nothing is a
  `filterEffect: fail` regardless of whether the API call returns 200") and
  `siblingListDistinctnessOverall = pass` (two tab/accordion sections showing identical
  rows "indicate a wrong discriminator or shared endpoint bug").
- **Responsive Breakpoint Parity Gate (MANDATORY)** — new dimension: capture every route
  at 375/768/1440 (overridable via `responsive-breakpoints.json`), emit
  `responsive-parity/<routeId>.json` with `breakpointPx`, legacy/modern screenshot paths,
  `pixelDiffPercent`, `layoutShifts[]`, `overflowEvents[]`, `horizontalScrollDetected`,
  `parityState` (pass|warn|fail). Legacy breakpoints reverse-engineered from
  `componentCensus` media-query evidence and "may add to (not replace) the default trio."
- **Self-Audit Checklist (MANDATORY)** — a genuinely new pattern: before closeout the
  agent must emit a self-attestation block answering every checklist row with `YES` + a
  one-line evidence pointer (file path, test id, command output line, artifact field),
  `NO` + deferral rationale + a carry-forward entry, or `N/A` + rationale. Nine rows
  covering artifact reads, style entry points, framework class-hook resolution, shell
  a11y, shell POM extraction, Gherkin scenarios, visual-regression baseline commit,
  layout/breakpoint/z-index audit, and temporary-UI-bridge classification with
  `retirementStep`. Backed by an **Agent Contract Rule (HARD GATE)** that invalidates the
  ready status when any row is `NO` without both artifacts.
- **Shell accessibility mandate** with a sharp anti-false-green clause: the `<nav>`
  landmark must render every link in the route menu metadata and each must navigate — "a
  present-but-empty `<nav>` landmark (the element and its test id exist but no links
  render) passes the landmark check yet is a navigation parity defect."
- **Unbacked framework class hooks** restated as a shell-level check (Bootstrap
  `nav-tabs`/`panel`/`dropdown`/`btn-*`/`col-*`): they "render as bare DOM (bullet lists
  where tabs are expected, always-open dropdowns, stacked blocks where grid columns are
  expected) and silently defeat visual parity."
- **Closing menu**: QA twin `13-QA-frontend-shell-stabilization` (Lanes: Browser-contract
  regression, Navigation smoke; ETA 3-5 min) / `next` → Step 14 DEV / `stop`. Step 14's
  name confirmed: "Frontend UI Inventory & Fusion Map".

## ⚠ Cross-step numbering drift found in prompt 13 (HIGH fork-risk — same class as prompt 12)

Transcribed **as photographed**, not corrected. This is the second prompt in a row with
renumbering drift, which makes it a systemic pattern rather than a one-off:

- **The Self-Audit `Agent Contract Rule (HARD GATE)` references a status field the prompt
  never defines.** The prompt declares `step14HandoffStatus`, but the hard gate says
  "`step16HandoffStatus: ReadyForUIPlanning` is INVALID when…", "an explicit **Step 16**
  carry-forward entry", and "the agent MUST downgrade **`step16HandoffStatus`** to
  `NotReadyForUIPlanning`". An agent following this literally must either error or invent
  a field.
- **The Self-Audit section contradicts itself on its own block name.** Its opening line
  requires "a `Step 13 Self-Audit` block in the chat reply"; its closing line requires
  "the literal **`Step 15 Self-Audit`** heading… A closeout without this block is treated
  as a skipped **Step 15** and must be re-run." Both cannot be satisfied.
- **The Responsive Breakpoint Parity Gate is written against Step 15**: "every **Step 15**
  stabilized route", "`fail` at any breakpoint blocks **Step 15** closeout", "a documented
  variance row in the **Step 15** stabilization report" — inside the Step 13 prompt.
- **Mixed carry-forward targets**: the Self-Audit `NO` branch says "a **Step 14**
  carry-forward entry" while checklist row 8 says "**Step 17** carry-forward" and the hard
  gate says "**Step 16** carry-forward".
- Path divergence for the same artifacts: the Required-behavior section reads them from
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` while the checklist
  and the runtime/visual gates write to `.modernization/fusion-restructure/…`.

Combined with prompt 12's 9 × "Step 14" references, this strongly suggests the frontend
block was renumbered (platform integration 14→12, stabilization 15→13, and the UI
inventory/upgrade lanes shifted with it) without the prompt bodies being updated. Every
one of these is a fork point where different developers' models will resolve the
contradiction differently, and the `-CurrentStep <n>` drain gates depend on step numbers
being literal.

## Transcription uncertainties (prompt 13)

- The drift references above are transcribed exactly as photographed and are the highest
  priority items to re-read against the source before acting.
- Window title reads `IgnitionKit1.2` (as in prompt 12's later photos) while the
  breadcrumb still reads `OpX-Ignition-Kit`.
- Double-backtick identifier styling in the Responsive Breakpoint Parity Gate preserved as
  shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  53-59, 105-110, 154-161, and 177-192.
- File ends at line 220.

## Structural facts added by prompt 12

- **The authoritative live-data + auth gate of record** for the whole app (same
  `OpX-AppMod-P2-Modernize` agent + browser tools; Premium reasoning *medium-high*
  thinking, 15-30 min). Steps 11 and 13 explicitly defer to it.
- **The two-verdict model** — the kit's strongest anti-false-green design:
  - `routeContractStatus` = the deterministic, **auth-free GATE OF RECORD** from
    `generate-ui-api-map.ps1 -FailOnBrokenCalls`. Proves every client call resolves to a
    real controller action+verb with no credentials. `brokenCallCount = 0` → `Clean`
    (required to close); `> 0` → `BrokenCalls` (closure-blocking, "a guaranteed runtime
    failure"); method-built/dynamic URLs → `UnresolvedOnly` (advisory).
  - `liveDataRenderStatus` = the authenticated render confirmation, **"never faked"**.
    `Verified` only when a route is *observed* rendering real rows under a real session.
    Explicitly NOT `Verified`: a `401`, a scanner result, a `200`, or a carried-forward
    prior observation. No usable auth session → `UnverifiedPendingAuth` (honest Partial),
    "never infer `live` from a protected `401`."
  - **Closure requires `Clean` AND `Verified`.** `Clean` + `UnverifiedPendingAuth` keeps
    the step Partial. Canonical render path: operator completes the real sign-in in the
    shared integrated-browser page, then each route's live render is observed.
- **Five status axes total**: the two above plus `protectedApiOwnershipStatus`
  (Aligned|DriftDetected|Blocked), `authRuntimeStatus` (Verified|403GapOpen|Blocked),
  `perRouteApiWiringStatus` (LiveAllInScope|PartialPerRouteList|Blocked — `LiveAllInScope`
  only when `liveDataRenderStatus: Verified`).
- **Two more MANDATORY self-check scanners** (now 6 total on this step):
  `scan-backend-parity.ps1` (dropped-mutation detection — "the UI still shows
  Add/Edit/Delete buttons over placeholder modals while no backend endpoint exists";
  waivers in `backend-parity-registry.json` `acceptedDrops[]`) and
  **`scan-functional-parity-ledger.ps1`** — new: answers "are ALL legacy behaviors
  implemented?" across Step 3 `effectClass` (mutate/filter/navigate/export/dialog), not
  just endpoints and fields. Catches "missing buttons, dead filters, or filter controls
  that show identical rows before and after applying"; waivers in
  `functional-parity-registry.json`.
- **Runtime-checkpoint assertion families** (new, behavioral not structural):
  `filterAssertions[]` must show `rowsChanged: true` per filter control (identical rows
  before/after = `filterEffect: fail`); `siblingListDistinctness[]` must confirm sibling
  list sections backed by separate calls return distinct first-row content;
  `mutateWiringAssertions[]` must show `networkCallObserved: true` ("a modal that opens
  but never fires a write call is a `mutateWiring: fail`").
- **Full Playwright auth infrastructure shipped inline**: `LoginPage` / `CallbackPage` /
  `UnauthorizedPage` POMs plus a 4-case `auth.journey.spec.ts` (sign-in, sign-out,
  unauthorized redirect, 403-insufficient-permissions) with `STEP12-E2E-AUTH-00N` CaseIds
  in JSDoc and Given/When/Then comments. Explicit rule: **"NO .feature files"** — all
  scenarios live inline as comments, no step definitions. (Note this contradicts Step 6's
  Gherkin `.feature`-per-journey planning; see uncertainties.)
- **Angular 20+ code-quality mandate**: standalone components with `imports: []` (no
  NgModules), signals (`signal()`/`computed()`/`effect()`), `@let`, `inject()` over
  `@Inject()`, `@if`/`@for`/`@switch`, `DestroyRef` + `takeUntilDestroyed()`. "Platform
  code with NgModules or legacy patterns is incomplete Step 12 coverage."
- **A11y & testability mandate**: `aria-label`/`aria-labelledby`, `data-testid`, `role`
  when semantic HTML is insufficient, focus management for auth flows/callbacks, error
  messages linked via `aria-describedby`.
- **API Smoke re-run before any integration work**: re-run the Step-8-planned
  `tests/backend/smoke/` probes at 100% pass against `progressDenominators.totalApiEndpoints`
  — "the cheapest signal that the backend process actually loaded the current build
  (a stale-DLL / stale-process regression …)". Honors the T1-T5 safety tiers; sub-100%
  must be a tracked `deferralId`, "not a silent skip."
- **Deferral-drain gate — "Step 12 owns 'no button is dead'"**: `scan-ui-parity-gaps.ps1
  -CurrentStep 12` re-flags any deferral whose `ownerStep <= 12` as a Major InertControl;
  `deferredInertControlCount` for Step-12-or-earlier owners must reach 0. "A
  `majorGaps = 0` with parked stubs still owed here is not a pass."
- **Per-Route HAR Diff Gate (MANDATORY)** — new proof technique: record a HAR for the same
  scripted journey against BOTH legacy and modern runtimes, diff into
  `route-har-diff/<routeId>.json` (`apiCallSequenceLegacy/Modern[]`, `extraCallsInModern`,
  `missingCallsInModern`, `reorderedCalls`, `payloadShapeDeltas`, `authHeaderDeltas`,
  byte/count totals). Any extra/missing/reordered call or auth-header drift blocks the
  route unless approved as an intentional plan delta. Journey script comes from
  `screenshotCoverageMatrix` + a new `userJourneyCatalog`, "not from hand-written per-app
  scripts."
- **Workflow Trace coverage gate (state-machine parity, not just edge parity)**: for every
  `fully-traced` row, a spec must assert (a) verb+URL, (b) payload structure matches
  `requestShape` **exactly** incl. nested-vs-flat and casing ("the most common parity
  400"), (c) response bound to documented UI surfaces, and (d) every `visibleStateLabels`
  entry appeared *and disappeared* at the correct state-machine point. "Asserting only
  that the API was called is insufficient and has shipped parity defects to users."
- **Parameterized/detail routes: "never defer"** — a detail route marked "route-verified,
  deferred to UAT because it needs a real record" hides a `404` (client calls a
  path-parameter endpoint the backend only registered as a query-string GET).
- **Runtime Error Watch**: integrated browser DevTools console + backend log stream open
  side by side; a route that "looks loaded" while the console shows a swallowed `400` or
  the backend logged a `500` is not `live`.
- **Closing menu**: QA twin `12-QA-frontend-platform-integration` (Lanes: Contract, Auth
  interceptor checks; ETA 5-8 min) / `next` → Step 13 DEV / `stop`. Step 13's name
  confirmed: "Frontend Shell Stabilization".

## ⚠ Cross-step numbering drift found in prompt 12 (HIGH fork-risk)

This is the most consequential drift found so far and is transcribed **as photographed**,
not corrected:

- **"Step 14" appears 9 times inside the Step 12 prompt** — "resolve every broken call
  before Step 14 closes", "the Step 14 hard gate is machine-enforced", "Step 14 cannot
  close while `summary.brokenCallCount > 0`", "Step 14 owns the gate that every migrated
  route's primary data calls actually reach the real protected backend", "Step 14 must
  also load `workflow-trace-inventory.json`", "Step 14 cannot close while any
  `fully-traced` row lacks a passing spec", "keep Step 14 open" (403 gap), "When Step 14
  cites current startup-proof evidence…", "For every route exercised by Step 14 platform
  integration". Meanwhile the header, ownership boundary, verdict model, completion gate,
  and closing menu all say **Step 12**.
- Companion drift in the same region: "the **Step 8** per-route behavior plan" (that
  artifact is Step 6's `per-route-behavior-plan.json`), "the **Step 13**
  `perRouteBehaviorList`" (that list is Step 11's), "`workflow-trace-inventory.json`
  (produced in **Step 5**)" (Step 3 produces it per prompt 03), "an intentional plan delta
  in **Step 7's** `apiIntegrationPlan`" (Step 5 owns `apiIntegrationPlan` per prompt 05),
  "record an explicit **Step 8** retirement decision" (retirement decisions are Step 8 in
  prompt 11's wording, so this one may be correct), and a `workflow-trace-inventory.json`
  path under `.modernization/legacy-analysis/` where prompt 03 puts it under
  `.modernization/ignition-artifacts/discovery/`.
- **Why it matters:** this reads like content authored when platform integration was
  numbered Step 14 (and analysis/planning sat at different numbers), then renumbered
  without updating the body. Every one of these is a fork point — two developers' models
  will resolve "Step 14 cannot close" differently inside a step labelled 12, and the
  `-CurrentStep` drain gates depend on step numbers being literal.

## Transcription uncertainties (prompt 12)

- The step-number references above are transcribed exactly as photographed; several are
  in heavily-wrapped lines, so the *specific* numbers in the "Step 8 per-route behavior
  plan / Step 13 perRouteBehaviorList" clause are the least legible of the set and should
  be re-read against the source before acting on them.
- The window title changes from `OpX-Ignition-Kit [Administrator]` (photos 1-5) to
  `IgnitionKit1.2` (photos 6-9) while the breadcrumb still reads `OpX-Ignition-Kit`;
  possibly a second workspace or version folder. Both photo sets agree on the overlapping
  lines 237-256, so the content is consistent.
- The Step-12 "NO .feature files" rule directly contradicts prompt 06's Gherkin planning
  (`{feature-name}.feature` per user journey, `@smoke`/`@regression` tags); preserved
  as-is in both files.
- `generate-integration-tests.ps1` writes to `tests/frontend/e2e/integration/generated/`
  in one clause and `tests/frontend/integrationFrontend/` in the next; both transcribed
  as shown.
- Double-backtick identifier styling in the HAR Diff Gate section preserved as shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  237-256, 287-301, 323-327, and 347-363.
- File ends at line 381.

## Structural facts added by prompt 11

- **The route-family move lane** (same `OpX-AppMod-P2-Modernize` agent + browser/agent/todo/
  vscodeAPI/fusion-copilot-docs tools as Step 10; Premium tier this time, 20-45 min).
  Moves the *real* legacy pages and shared client code into the target root "one route
  family at a time," explicitly NOT re-creating thinner versions from memory: "Parity is
  the starting state you preserve, not a percentage you climb toward."
- **A new self-check: content reconciliation** (`Invoke-StepReconciliation.ps1 -Step 11`)
  — proves every `LegacyRoute` in `per-route-behavior-plan.json` actually existed in the
  Step 3 legacy analysis ("a shape check cannot catch a behavior plan that invents a
  route that never existed"). Each failure prints a `Fix:` line routing back to Step 3
  (real route) or Step 6 (wrong plan). First appearance of semantic (not just structural)
  input validation.
- **A new self-check: scaffold-debt scan** (`scan-scaffold-debt.ps1 -CurrentStep 11`) —
  flags surviving "Step N wires this" markers / placeholder bodies whose owning step has
  been reached; exit 2 = overdue markers survive; a scaffold-debt registry holds
  genuinely-intentional notes. Same `-CurrentStep <n>` drain pattern as Step 10's
  `deferral-drain` dimension.
- **The single-authoritative-data-gate boundary is spelled out**: Step 11 OWNS control/
  column/field presence + wiring each data call site to its real service; it does NOT own
  the authoritative live-data verdict — that's **Step 12's single authoritative data
  gate**. A wired-but-empty grid is acceptable *provisionally*; a shipped placeholder as
  *final* state is a defect. `dataBindingParity = pass (provisional)` is a distinct gate
  value. This is the cleanest example yet of two adjacent steps deliberately NOT
  re-litigating each other's territory.
- **Move-and-preserve, NOT Fusion-conversion**: deliberate primitive-family swaps belong
  to Step 14 planning + Step 15/16 execution; an opportunistic single-control swap is
  allowed only if incidental AND reaches legacy visual parity in the same pass. "Never
  leave a half-configured Fusion control behind" — a `fusion-*` primitive with wrong
  variant/color/width is a parity defect, not progress.
- **Forbidden per-route hand-offs** (must be fixed or named as blockers): surviving
  `javascript:void(0)`/`href="#"`/`onclick="return false"` inline handlers; unwired
  legacy modal/banner/toast/confirmation triggers (incl. "authorized users only"
  banners); data-bound controls rendering placeholder/seed/fixture instead of the real
  call site; **column collapse** (real data but fewer/more-generic columns than legacy —
  "every legacy column is part of the parity contract"); export/print/upload controls
  that call no service; keyboard shortcuts/focus traps that no longer fire. Each
  unresolved one → `perRouteBehaviorList` row `{route, interactiveElement,
  dispositionInStep11, ownerStepIfDeferred}`.
- **Framework-class-hook verification**: Bootstrap `nav-tabs`/`panel`/`dropdown`/`btn-*`/
  `col-*` etc. copied from legacy templates must be backed by a stylesheet actually
  loaded in the modern shell — otherwise "bare DOM that renders as unstyled lists or
  stacked blocks." (Exactly the FieldServe-style gotcha from our rehearsals.)
- **Guard redirect-target audit**: every `canActivate` denial-redirect (e.g.
  `FusionRoleGuard(GROUPS, 'access-denied')`) must point at a *declared* route — an
  undeclared target silently falls through to the wildcard/home route and "hides the
  access-denied condition entirely." A routing-integrity defect owned here, not Step 12.
- **Parameterized/detail-route wiring**: wire every path-param route (e.g.
  `filekeys/log/:keyNo/:changeNo`) and reach it from its parent grid; Step 12 is the gate
  of record for the `404` case (client calls a path-param endpoint the backend only
  registered as a query-string GET) — a concrete route-contract failure class.
- **`deferredInertControlCount` vs `majorGaps`**: `majorGaps=0` with a nonzero deferred
  count means behavior is "PARKED, not done"; every parked handler needs a truthful
  `ownerStep` whose gate actually verifies it ("a dead export/add/delete button belongs
  to Step 12 'no button is dead', not a vague 'later'"). The `ui-deferral-registry.json`
  is the same registry Step 10's scanner reads.
- **Dead-Code Trace Gate (MANDATORY)**: static reachability sweep from the modern router
  roots (Angular `Routes` / React `createBrowserRouter` / Vue `createRouter` / Blazor
  `Router` / MVC route table / Razor Pages folders — data-driven from `componentCensus`)
  → `dead-code-trace.json` with `filePath`/`reachableFromRoot`/`rootChain[]`/`keepReason?`.
  `reachableFromRoot:false` + no `keepReason` blocks closeout (wire it, document a
  reviewer-approved keepReason, or delete). A modernization-specific dead-code gate we
  didn't have.
- **Four-axis status**: `sharedCodeMigrationStatus` (Validated|Partial|Blocked),
  `routeFamilyStatus` (Validated|Partial|Blocked), `behaviorPreservationStatus`
  (Preserved|PartialPerRouteList|Blocked), `step12HandoffStatus`
  (ReadyForPlatformIntegration|NotReadyForPlatformIntegration|Blocked). Fixed closing
  gate line: `Ready for Step 12 Frontend Platform Integration: Yes`.
- **Closing menu**: QA twin `11-QA-frontend-migration` (Lanes: Browser-contract, Visual
  parity; ETA 5-10 min) / `next` → Step 12 DEV (Frontend Platform Integration) / `stop`.
  Step 12's name confirmed: "Frontend Platform Integration".

## Transcription uncertainties (prompt 11)

- This prompt is unusually dense with very long wrapped lines (the forbidden-handoffs and
  runtime-checkpoint bullets each wrap 4-6 visual lines); reconstructed from wrap
  positions with overlaps verified at 46-53, 84-94, and 118-120.
- Double-backtick identifier styling appears in the Dead-Code Trace Gate section (as in
  prompts 04-10); preserved as shown.
- `4xx`/`5xx` and `≈`-free inline code transcribed exactly as shown.
- File ends at line 158 (content through line 157 + trailing blank).

## Structural facts added by prompt 10

- **First frontend prompt; expanded tools list**: same `OpX-AppMod-P2-Modernize` agent,
  Balanced tier (15-30 min, no model pin), but the frontmatter `tools` now adds `agent`,
  `browser`, `todo`, `vscode/vscodeAPI`, and `fusion/copilot-docs/*` — the first prompt
  that drives a live browser and the Fusion copilot-docs MCP.
- **Plain-language framing**: opens with a "What This Step Does (plain language)" block
  (what/why-it-matters/what-you'll-have) per `step-confidence-contract.instructions.md`
  ("open in plain language, end on binary gates, prove `src/` changes against the running
  app"). This is a different rhetorical register from the backend prompts.
- **Anti-drift ownership contract made explicit**: "Each numbered step owns exactly one
  concern so a defect always has one home and no two steps re-litigate the same
  territory." Step 10 **OWNS the styling foundation outright**; Steps 11-16 consume it,
  never re-author it. Steps 11/12/13 must re-run `scan-styling-foundation.ps1` as an
  entry check — a regressed foundation is a "Step 10 regression" fixed at the foundation,
  never patched in one page.
- **Shared decomposition-skill router**: `/.github/skills/browser-source-decomposition/SKILL.md`
  classifies the legacy source (server-rendered / browser-led SPA / Fusion G1 / mixed /
  static-document / already-modern / validate-only). Each branch routes to a dedicated
  sub-prompt that must run in full before shell formation closes:
  `.github/prompts/P2-Modernize/mvc-to-browser-client.prompt.md` (→
  `MVC-To-Browser-Client-Decomposition-Contract.generated.json`) and
  `angular-to-browser-client.prompt.md` (→
  `Angular-To-Browser-Client-Decomposition-Contract.generated.json`). Mixed/hybrid runs
  both. A whole family of decomposition contracts we hadn't seen.
- **`browserSurfaceApplicability` from Step 7** gates the lane: `Required` = full
  foundation+scaffold loop; `NotApplicable` = lightweight proof pass. Portal republish is
  never automatic — staleness is reported in chat for manual refresh.
- **Two deterministic parity scanners** (both under `.github/scripts/parity/`):
  - `scan-styling-foundation.ps1 -ModernClientRoot <root>` — statically fails on OS
    `prefers-color-scheme` following instead of pinned legacy scheme, no style
    `includePaths`, no shared partials, header not bound to legacy brand color, or a data
    grid with all auto-sized columns.
  - `scan-ui-parity-gaps.ps1 -Quiet` — multi-dimensional control-parity scanner. Pairs
    every legacy `<a>`/`<button>`/`<li>` with every modern `<app-*>`/`<fusion-*>` wrapper
    (incl. inline `template:` blocks and tab-data arrays) across a **registry of named
    parity dimensions**, each a self-contained rule pack (legacy extractor / modern
    extractor / normalizer / comparator / allowlist). Built-in dimensions: `label`
    (MissingLabel Major), `icon` (FA4 alias + semantic-vocab normalization → MissingIcon
    Critical / IconMismatch Minor), `color` (Bootstrap `btn-*` ↔ Fusion `color=` via
    `$BootstrapColorMap` → ColorMismatch Minor), `column` (MissingColumn Major — the
    "column-collapse" defect), `handler-wiring` (empty/TODO `(click)` or
    `[disabled]="true"` → InertControl Major), `deferral-drain` (per-app deferral registry
    `ui-deferral-registry.json` with `{handler, ownerStep, reason}`; `-CurrentStep <n>`
    re-flags any deferral whose `ownerStep <= n` — "a deferral cannot survive past the
    step that promised to wire it"). Gate fails on `criticalGaps>0 || majorGaps>0`.
- **"Discovery probe" for unknown-unknowns**: the same scan emits a `discoveryProbe` block
  ranking every legacy attribute/class-token family that NO active dimension consumed, by
  frequency — the kit's mechanism for surfacing parity dimensions it has never seen
  (`confirm`, `tooltip`, `ng-disabled`, `accesskey`...). Plus a documented "Adding a new
  dimension (recipe)" (alias map → `$rec.X` in both Scan-File branches → copy the color
  DIMENSION PASS block → append to `summary.dimensions`). This is a self-extending gate.
- **Render-verified over field-recorded**: the Runtime Parity Checkpoint insists gates be
  proved by *observed browser render*, not by trusting `colorSchemeForced` /
  `brandBindingVerified` JSON claims. "A clean build, a scanner `majorGaps=0`, or an HTTP
  200 are necessary but never sufficient" — a gate recorded `pass` from those proxies is
  invalid; unrenderable → `blocked`/`unverified`, keep the step open. Strongest
  false-green guard in the kit so far.
- **Interaction Wiring + Workflow Trace enforcement at scaffold time**: every rendered
  control must map to a Step 5 `interaction-wiring-inventory.json` entry (reproduce
  `target`/`sideEffects`/`authGate`); high-risk `wiringKind` controls must reproduce the
  `workflow-trace-inventory.json` `requestShape` EXACTLY (verb/URL/payload nesting+casing
  — "flat-vs-nested mismatches ... are the most common parity 400") and every
  `visibleStateLabels` entry. "A button that looks right but has no handler" is a parity
  defect, not cosmetic.
- **Design Tokens Extraction (MANDATORY)**: first pass extracts
  `styling-foundation.tokens.json` (families: color/spacing/typography/borderRadius/
  shadow/zIndex/motion; each row `tokenId`/`valueLight`/`valueDark?`/`sourceEvidencePath`/
  `usageCount`/`mapsToFusionToken?` verified via Fusion MCP), emitted as CSS custom
  properties in `src/<App>.Web.Client/src/styles/_tokens.css`. Raw hex/pixels/font-stacks
  in component CSS are a violation caught by Step 13 + Step 17.
- **"Legacy Visual Language By Construction"**: the goal is the modern shell resembles the
  legacy app "from the first page paste rather than being restyled to parity later." Bind
  the legacy palette through the theme system's **actual consumed API** (`@fusion/theme`
  override map + `root/main` header-branding, or Bootstrap `$bootstrap-config`), NOT as
  orphan CSS custom properties ("a generated `--color-brand-*` that no generator reads
  changes nothing"). Force the legacy color scheme — never inherit OS
  `prefers-color-scheme` (the starter `index.html` ships a `dark-theme`-from-OS script
  that must be neutralized). Five named failure conditions (empty nav / raw default theme
  / wrong scheme / wrong header color or field sizing / missing chrome) = exactly what the
  Step 13 visual-parity gate measures.
- **Per-Slice Shell Parity + Repeat-Run Recommendation (both MANDATORY)**: Phase 2
  frontend advances incrementally from Step 10, one shell slice per pass targeting +5-10pp
  of screenshot/visual/inventory parity, ROI-scored
  `(visibilityScore + interactionScore) - riskScore`; first 3 passes must produce a
  user-visible change. Each pass emits per-slice pixel+structural diffs under
  `parity-diffs/step10-pass-{passId}/` and a `step10-pass-log.json`. Closeout `Suggestions`
  must recommend rerunning with the next slice + expected gain (same wording as Steps
  15/16). New instructions files: `frontend-modernization-learning.instructions.md`
  (Slice Parity And ROI Rules) and `testing-design-contract.instructions.md` (Slice
  Parity Floor And Flake Budget).
- **Fixed response spine**: `About To Do` (Context/Dev work/QA after) → `Modernization
  Added` → `UI Parity Snapshot` (screenshot coverage / visual parity / inventory parity /
  selector coverage / overall rating/10) → `Suggestions` → `Returned Data` (~35 named
  fields incl. the 3 status axes, parity percentages, and `controlParity*` gap counts).
- **Portal surface rename**: canonical Step 10 page is now `frontend-foundation-and-scaffold`
  (`.html`+`.json` under `portal/data/pages/`); the old `frontend-modernization-parity.*`
  is retired and any lingering reference is "dead-surface drift."
- **Three-axis status**: `decompositionContractStatus`
  (Current|NotApplicable|Blocked), `shellFoundationStatus` (Validated|Partial|Blocked),
  `step11HandoffStatus` (ReadyForMigration|NotReadyForMigration|Blocked). Fixed closing
  gate line: `Ready for Step 11 Frontend Migration: Yes`.
- **Closing menu**: QA twin `10-QA-frontend-foundation-and-scaffold` (Lanes:
  Browser-contract shell smoke; ETA 3-5 min) / `next` → Step 11 DEV (Frontend Migration) /
  `stop`. Step 11's name confirmed: "Frontend Migration".

## Transcription uncertainties (prompt 10)

- Double-backtick identifier styling appears in the Design Tokens and Legacy-Visual
  sections (as in prompts 04-09); preserved as shown.
- The `deferral-drain` and `column`/`handler-wiring` dimension bullets wrap heavily and
  were reconstructed from wrap positions; wording verified across the 216-221 overlap
  between the two photo batches.
- `≈` (approximately-equal) used in the icon FA4 alias examples renders faintly in the
  photo; transcribed as `≈`.
- A couple of long completion-gate / visual-language paragraphs were reconstructed from
  wrap positions; overlaps verified at 249-255 and 274-294.
- File ends at line 313 (content through line 311 + trailing blanks).

## Structural facts added by prompt 09

- **Step 9 = production-style backend hardening lane** after Step 8 formation (same
  `OpX-AppMod-P2-Modernize` agent, GPT-5.3-Codex model requirement, Premium tier,
  20-40 min). Frontmatter uses the full `description`/`name`/`argument-hint`/`agent`
  form (like prompts 01-03), not the inline-array style of 07.
- **New MANDATORY self-check: backend functionality-parity scan** — a fourth self-check
  bullet beyond input/restore-point/output. `scan-backend-parity.ps1 -Quiet` proves
  every LEGACY backend endpoint — especially every mutation
  (POST/PUT/DELETE/PATCH: Add/Edit/Delete/Link/Export) — has a modern counterpart.
  Exit 2 = modern API dropped write endpoints; port them or record `acceptedDrops[]`
  (with reason) in `.modernization/ignition-artifacts/discovery/backend-parity-registry.json`.
  Rationale captured verbatim: "Catching a dropped mutation HERE (backend formation) is
  far cheaper than discovering at Step 12 that the UI has Add/Edit/Delete buttons with
  no endpoint behind them." New shared script dir: `.github/scripts/parity/`.
- **Fusion Console logging provider is the mandated logging path**: install
  `Fusion.Fx.Logging.Providers.Console` (latest Sonatype production version), add
  `"FusionConsole": {}` to the `appsettings.json` Logging section (presence triggers
  auto-registration via the Fusion app builder), consult
  `fusion-readme:///src/dotnet/Fusion.Fx.Logging.Providers.Console/README.md` via
  **Fusion MCP** (`fusion-readme://` is a real MCP resource URI scheme). Logs emit as
  JSON to stdout/stderr — no extra ILogger registration needed. Application Insights is
  explicitly a future lane, not required for Step 9.
- **Store-level logging + error-handling contract**: repositories inject `ILogger<T>`,
  log at every DB failure boundary; connection-open failures caught and logged with
  `SqlException.Number` + message + `Data Source` (never passwords) then rethrown → HTTP
  500; each mutation (`Insert`/`Update`/`Delete`/`Upsert`) catches `SqlException`
  separately and returns the legacy error-signaling value instead of throwing (preserves
  service contract); `LogDebug` before each stored-proc call. Same Dapper typed-mapping
  and constructor-parity rules as Step 8, now with the exact materialization exception
  string quoted as a hard-fail signature.
- **Connection-string startup proof**: validate `ConnectionStrings:<name>` resolves
  non-empty at construction time (log `LogError` at startup if empty — "a green
  `dotnet build` does NOT prove the connection string is populated"); DNS-lookup/ping
  the server name before committing; correct env-specific name comes from legacy
  `Configuration/<env>/` files, NOT commented-out `Repository.cs` shortcuts. Split
  env-var pattern reconfirmed:
  `SqlServer__Server|Database|Username|Password|Encrypt|TrustServerCertificate`;
  `startupProofStatus = Blocked` when a first-request 500 comes from a missing config key.
- **SqlClient TLS scar restated** (3rd appearance): `Microsoft.Data.SqlClient` on
  .NET 6+ enforces TLS validation → `Win32Exception 0x80090325 "certificate chain was
  issued by an authority that is not trusted"` even when PowerShell `SqlConnection`
  (older `System.Data.SqlClient`) works; fix `TrustServerCertificate=True` in
  `appsettings.Development.json` only, never prod/staging.
- **Authorization policy registration verification**: grep `[Authorize(Policy =` and
  cross-check every named policy against `AddAuthorization(...AddPolicy(...))` — a missing
  policy throws `InvalidOperationException` at first request (generic 500), invisible at
  build time. Verify during startup proof, not by reading code.
- **Three-axis Step 9 status**: `controlPointAlignmentStatus`
  (Aligned|DriftDetected|Blocked), `integrationProtectionStatus` (Current|Partial|Blocked),
  `startupProofStatus` (CurrentBuildBacked|SkippedBuildCoverageExplicit|Blocked). The
  "SkippedBuildCoverageExplicit" value + the `test-workspace-gates.json`
  `refreshSafePreflight`/`skipFlags.skipApiBuild` check = the kit refuses to let a skipped
  API build masquerade as real hardening proof (false-green guard).
- **DEV/QA lane separation restated**: Step 9 DEV *creates* the IntegrationBackend,
  ContractApi, and Db test projects + initial tests but does NOT execute them —
  execution proofs owned by `09-QA-backend-dotnet-integration-hardening`. DEV proof is
  `dotnet build` against `src/<AppName>.Web.Api` (build-backed startup proof) plus ≥1
  real runtime request per newly hardened DB-backed endpoint.
- **Backend Load Smoke Gate (MANDATORY)** — new perf gate: 60s load smoke (configurable
  from Step 7 `performanceBudgetPlan`) against top-N `apiEndpointCatalog` endpoints
  (default N=5) using Bombardier/k6/NBomber/hey, data-driven from `load-smoke.config.json`
  (default Bombardier on Windows, k6 on Linux/macOS). Captures rps/p50/p95/p99/errorRate
  to `backend-load-smoke.json`; fails when below `requestsPerSecondFloor` or above
  `p95LatencyCeiling`; when Step 7 declared no budget, this run *becomes* the baseline
  floor/ceiling for Step 17. Auth scheme from `authIntegrationCatalog` — "never invent a
  token shape."
- **Comment/annotation cleanup**: strip stale future-step wording ("another step *will*
  harden this"), remove unused `using` directives, declare `ProducesResponseType` with
  concrete CLR types, no anonymous-object success payloads for documented API surfaces.
- **Closing menu**: QA twin `09-QA-backend-dotnet-integration-hardening` (Lanes:
  Integration, Contract, Db; ETA 5-10 min) / `next` → Step 10 DEV (Frontend Foundation &
  Scaffold) / `stop`. No fixed "Ready for Step 10..." closing line in this prompt (unlike
  07/08) — closeout is the three status fields + the menu.

## Transcription uncertainties (prompt 09)

- The `About To Do` header is rendered as a bullet (`- About To Do`) in the photo,
  unlike prompts 07/08 where it's a plain heading; preserved as photographed.
- Several long connection-string / SqlClient / policy-verification paragraphs wrap
  heavily and were reconstructed from wrap positions; wording verified across photo
  overlaps at lines 38-51, 106-134.
- Double-backtick identifier styling appears in the DEV/QA-separation and Load-Smoke
  sections (as in prompts 04-08); preserved as shown.
- `Win32Exception 0x80090325` and `TrustServerCertificate=True` transcribed exactly as
  shown.
- File ends ~line 172 in the editor (trailing blanks after line 167 of content).

## Structural facts added by prompt 08

- **Cross-vendor per-step model pin**: `Model requirement: Step 8 execution must run on
  GPT-5.3-Codex` (in prose, not frontmatter). With prompt 03's `model: Claude Opus 4.6
  (copilot)` frontmatter pin, the kit picks specific models per step across vendors —
  Opus for heavy analysis, Codex for heavy code movement. New agent:
  `OpX-AppMod-P2-Modernize` (Premium tier, 20-40 min).
- **Two new self-check gates**: restore-point precheck
  (`.github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 8 -Mode Verify|Ensure` —
  no `src/` or `LegacyCode/` mutations until a restore point exists) and a **Fusion MCP
  preflight** (must successfully call `mcp_fusion_fusion_api_docs_entrypoints` or the
  step is `Blocked` with "Fusion MCP unavailable" — never make unverified
  Fusion-structure decisions).
- **Two new skills**: `/.github/skills/architecture-structure/Architecture-Structure.md`
  (applied "literally": entities under `Library/Models/Entities/`, API transport DTOs
  stay in Web.Api, ambiguity resolved explicitly as `Entity` | `API transport model` |
  `Temporary bridge`) and `/.github/skills/fusion-feature-standards/SKILL.md`. Per-app
  addendum: `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`
  (additive clarification only — never rewrite authored guidance).
- **Formation ordering law**: `Library` formed and validated FIRST, then `Web.Api`;
  client scaffold explicitly belongs to Steps 10-11. Statuses:
  `libraryFormationStatus`/`apiFormationStatus` (Validated|Incomplete|Blocked),
  `step9HandoffStatus` (ReadyForHardening|NotReadyForHardening|Blocked).
- **Move-not-copy doctrine**: form destination slice → validate there → remove prior
  source; fallback only create-validate-delete with leftovers reported as "visible
  drift"; closeout gate blocks if movement accounting is `none` when blockers are
  absent; Step 7 clone workspace deleted after consumption (disposition recorded as
  `Deleted`|`Retained by user request`|`Blocked`).
- **Anti-fake-data guardrail**: production seams must not replace DB-backed behavior
  with hardcoded in-memory stores (in-memory only under `tests/**`); unavoidable
  bridges classified `Temporary bridge`, thin, replacement routed to Step 9.
- **Battle scars**: Authorization Policy DI checklist (unported named policies throw
  `InvalidOperationException` → generic 500 before controller body, invisible at build;
  grep legacy Startup for AddPolicy/AddAuthorization/IAuthorizationHandler); Dapper
  typed-mapping parity rule (constructor CLR types must match SQL column CLR types;
  two-step mapping when contracts differ; ≥1 real runtime call per DB-backed endpoint
  before closeout); domain-capability naming (no `Home*`/`Pj*` service names);
  starter placeholder cleanup (MyEntitiesController/PublicTextController).
- **Step 8 = heaviest unit-test growth step**: full scaffolding specified inline
  (csproj net10.0 + xunit/Moq/FluentAssertions/coverlet, GlobalUsings, 4-line file
  purpose block, CaseId/Scenario/Description/Input/Expected comments per catalog);
  exit criteria "EXECUTION ONLY — DO NOT DERIVE"; tracker update shows
  `step8Target: 60`, `step9Target: 80` (confirming prompt 06's tracker keys were
  step-numbered oddly there; flagged in prompt 06 uncertainties).
- **Layering Enforcement Gate**: NetArchTest-style rules in
  `tests/backend/<App>.Architecture.Tests` run via `dotnet test` in CI — Library must
  not reference Web.Api/hosting types; Web.Api must not reference legacy assemblies
  after a slice closes (closed-slice list from `slice-status.json`); no
  System.Web/System.Web.Mvc/System.Web.Http/WebActivatorEx per
  `forbidden-references.json` — forbidden-namespace list is **data-driven from JSON,
  not hard-coded in the test class**. Layering violations fail the build.
- **Protected starter shell**: `Program.cs`, DI composition seams, logging/bootstrap,
  auth wiring, OpenAPI/Scalar setup are never replaced/regenerated unless Step 5
  decisions explicitly allow a narrow rebind; platform concerns re-home into
  starter/Fusion-native sections or `ConnectionStrings` (one centralized startup-bound
  composition seam for split DB env vars — no raw env reads in feature code);
  policy-based authorization only (no Windows auth/Negotiate/direct role checks as
  target state).
- **Code comment quality contract**: file-header comments (what/why/fit), `<summary>`
  on every public type/method, inline comments wherever non-obvious legacy behavior is
  preserved, "explain *why*, not just *what*", no TODO-without-owner, no
  `// generated` markers.
- **Closing menu**: QA twin `08-QA-backend-modernization-formation` (Lanes: Unit,
  ETA 3-5 min) / `next` → Step 9 DEV / `stop`. Step 9's name confirmed: "Backend
  .NET Integration Hardening". Step 10's name confirmed: "Frontend Foundation &
  Scaffold". Fixed closing line: `Ready for Step 9 BackEnd - .NET Integration
  Hardening: Yes or No`.

## Transcription uncertainties (prompt 08)

- The unit-test directory tree (lines ~124-134) renders its box-drawing characters as
  garbled glyphs in the photo; transcribed with ASCII `+--`/`|` tree characters.
- Double-backtick identifier styling appears in the Layering Enforcement Gate and a few
  earlier sections (as in prompts 04-06); preserved as shown.
- Two adjacent near-duplicate bullets under Required work ("Move or prepare only the
  backend shell..." with and without the trailing clause) preserved as photographed —
  apparent source duplication.
- Duplicate Quality-bar bullets ("stable enough for Step 10...") with and without the
  trailing clause likewise preserved as photographed.
- Long wrapped lines reconstructed; overlaps verified at 57-61, 97-113, 135-158,
  193-200, 248-256, 301-306, 355-360, 395-400, 437-444, and 475-498.
- File ends at line 523.

## Structural facts added by prompt 07

- **First Phase 2 prompt; new per-lane agent**: `agent: OpX-dotnet-upgrade` (not the
  Discovery agent) — confirming agents are per-workstream. Frontmatter uses a third
  style: inline `tools: [...]` array. Balanced tier, 15-30 min; no model pin.
- **DEV/QA prompt pairing**: every Phase 2 step has a QA twin (`07-QA-backend-upgrade-dotnet`,
  invocable as `/07-QA-backend-upgrade-dotnet`). DEV ends with a numbered-choice menu
  (`QA` recommended / `next` / `stop`) plus per-lane QA preview (HTTP verify, Screenshot,
  Legacy characterization, Modern characterization, Coverage gap assessment, Legacy
  frontend compatibility, Evidence refresh) and an ETA. Closeout must list every
  created/modified file as workspace-relative markdown links.
- **Dual execution modes** declared from host topology: `RunnableRuntime` (full runtime
  proof required) vs `ConstrainedLegacyHost` (classic System.Web/MVC/WebForms that cannot
  truthfully run as net10 in-place → build + invariant + handoff evidence instead, with
  runtime marked `N/A`, not `Blocked`) — a "truthful constraint" pattern that avoids
  false-red gates without softening them.
- **"Build-green is NOT done" doctrine** with layered runtime proof: infrastructure probe
  (OpenAPI → Swagger JSON → Swagger UI → root, with curl retry flags) → **deep API probe**
  (authenticated real controller route; anonymous 401/403 is explicitly *inconclusive*;
  capture the body, never `-o NUL`; a 500's `InnerMessage` naming DB/TLS/login is a REAL
  upgrade regression, not environmental) → **loaded-vs-compiled invariant re-check** on
  the run/publish folder → **loader-exception log scan** (MissingMethodException etc. is
  a hard failure even with healthy HTTP status — "the app's own error handling can remap
  a fatal loader fault to an ordinary status") → **readiness gate 8a** (cross-origin CORS
  test from the planned Angular port, middleware source-reading, fix/rebuild/retest loop,
  `readinessVerification` block recorded in the step ledger).
- **`verify-upgrade-invariants.ps1`** — new shared gate: single-version package invariant
  across the whole closure (catches split-version/diamond breaks a green build hides),
  with `-PublishDir` mode for shipped-vs-compiled cross-check; test projects classified
  separately (report, don't block).
- **Mutable workspace discipline**: work ONLY in `step7UpgradeWorkspaceRoot`
  (`.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`), never repo `src/`
  (gate-only input, reminder-only baseline check) and never `LegacyCode/`; workspace
  self-heals by copying the whole legacy solution from `authoritativeLegacyRoot`;
  contract values are advisory and path-verified ("never treat a value read from the
  contract as ground truth"). Port defaults 5100/5200; 4200/5001 reserved for the
  modernized src app. Port clearing requires PID ownership validation before
  force-stopping.
- **Project taxonomy**: `Direct` (can move fully to target runtime now) vs `BlockedHost`
  (legacy ASP.NET host started via IIS Express `/clr:v4.0` instead); copied test
  projects are carry-forward context only (Step 8 owns test upgrades).
- **Battle-scar package rules** (mirrors our rehearsal findings): SqlClient 4.0+
  `Encrypt` default flip → `TrustServerCertificate=True` (full failure narrative,
  "a build never reveals this"); EF Core version-matching (3.x on .NET 10 "will compile
  but crash at runtime"); `SqlFunctionExpression.Create` removal →
  `HasDbFunction().HasTranslation()`; EF internals reflection → `ToQueryString()`;
  SPA middleware removal (SpaServices deprecated .NET 7/removed 8+); NETSDK1152
  duplicate-appsettings publish break; NU1102/NU1107/NU1202 zero-tolerance after
  package moves; "move package majors atomically across the entire closure".
- **State save/readback contract**: `step-workflow-state.json` requires populated
  TOP-LEVEL `status`/`updatedAt`/`latestFullResponse` plus `lastExecutedStep`,
  `recommendedNextStep`, and a `stepResponses.steps[]` entry ("a nested step status
  alone is NOT enough"); `step-response-ledger.json` mirrors it; closeout blocked until
  `verify-step-artifacts.ps1 -Step 7 -Mode Output` returns OK.
- **Completion bar** lists explicit truths incl. "`LegacyCode/` was not modified" and a
  scripted blocked-message ("The Step 7 mutable workspace was created but the .NET
  upgrade did not complete successfully. Re-run Step 7 before Step 8.").

## Transcription uncertainties (prompt 07)

- The Required final report list shows a duplicated ordinal in the photo (test
  carry-forward note and build result both read as item "4."), consistent with markdown
  auto-numbering hiding a source-side duplication; preserved as photographed.
- Two references to the single-version invariant say "Execution order step 6" while the
  invariant actually lives under Execution order item 7 (clean build); preserved as-is —
  likely stale numbering after the step-0 reminder was inserted.
- Self-Check block wording reconstructed to the standard two-bullet form seen in prompts
  01-06 (photo wraps obscure some mid-line text).
- Long wrapped lines reconstructed; overlaps verified at 47-54, 100-107, 134-147,
  192-199, 241-249, and 267-299.
- File ends at line 305.

## Structural facts added by prompt 06

- **Step 6 = QA planning pack owner** (extracted from a previously overloaded Step 5):
  owns requirements doc, test plan, testing ownership matrix, characterization ladder,
  testcase catalog direction, testing strategy, regression plan, risk matrix, tool
  rationale, ADO CI/CD planning. Preceded by a **Legacy Unit Test Baseline pre-gate**
  (`legacy-unit-test-baseline.prompt.md`, a sub-prompt invoked from inside Step 6) that
  must report `step7ReadinessStatus: Ready` before quality design runs.
- **A QA prompt stack exists** under `.github/prompts/qaTestPrompts/` read in exact order:
  qa-core-master, qa-core-contract, qa-core-workflows, qa-plan-strategy,
  qa-legacy-characterization. Named reusable workflows: `[WORKFLOW] Modernization
  Solution Design`, `[WORKFLOW] Modern Build Planned QA Tests`.
- **owningStep routing table**: characterization → Step 7 (tests live in
  `LegacyCode/Characterization/Baseline/` — "the frozen baseline ships with the code it
  protects"); unit → Step 8 (`tests/backend/unit/`); integration/contract → Step 9
  (`tests/backend/contractApi|integrationBackend/`); browser-contract/e2e → Steps 10-16
  (`tests/frontend/`).
- **"Phase 2 has no derivation authority"**: the testcase catalog is the work order;
  Steps 7-17 implement entries verbatim, never analyze legacy code or add unplanned
  tests. Gap discovered mid-phase → stop → route back to Step 3/6 → refresh catalog →
  resume. Same drift-control philosophy as Squad-ik gates, applied to test planning.
- **Characterization = behavioral parity, not source-shape lock**: 7 backend behavior
  families (business rules, calculations, validation, API responses incl. every
  documented error path, DB side effects, legacy quirks "weird but load-bearing",
  permission behavior), each needing **three coordinated catalog entries**
  (characterization/unit/integration) unless a thin seam collapses to
  `coverageLevel: "single-layer"`. Frontend behavior is delegated to the UI Screenshot
  Parity lane (visual gates at Steps 11/12/15/18) — legacy screenshots are the contract.
- **C1-C9 source-shape lock rules** (structural floor): controller class presence, API
  action+verb, mutating-endpoint contract shape, EF entity shape, config seams,
  bootstrap/startup sequence, view/template markers (ng-* directives, @Scripts.Render),
  calculation-helper contracts, JS controller file presence (owningStep 10+, browser
  lane). Thin coverage marked `coverageLevel: "class-presence-only"` for QA Lane 5 audit.
- **8-rule per-service scenario derivation** reading Step 3 service-behavior-inventory
  fields (branchingParameters, throwGuards, nullCoalescingDefaults, ...): every public
  method ≥1 scenario; nullable returns get found+not-found; every throwing guard its own
  scenario; mode/flag branches one per mode; `??=` defaults two scenarios; collection
  methods empty-case; display decorators idempotency; delegation orchestrators one per
  path. Deterministic inventory→catalog mapping with rule-number traceability.
- **Five-tier API smoke safety model** (T1 unauthenticated reachability expecting
  401/403 → T2 CORS preflight → T3 authenticated invalid-body rejection with
  validation-gate file+line evidence that must precede the first mutation call → T4
  dry-run/pure-compute POST with grep-evidenced `mutatesState: false` → T5 ephemeral
  round-trip, **default OFF**, requires `dataSafety: ephemeral` in kit-params + explicit
  named user opt-in, forbidden against any data source whose loss would be noticed).
  T1 floor for every endpoint; real mutations belong to Step 12 integration with
  `page.route(...)` interception. 100% `apiSmokeCoverage` before Step 12.
- **Progress denominators contract**: qa-test-plan.json publishes `progressDenominators`
  (totalBackendFilesPlanned, totalApiEndpoints, totalRoutes, ..., plus extensions:
  totalErrorStates, totalExportSurfaces, totalRealtimeSurfaces, performanceBudgetRoutes,
  flakeBudgetPercent, dataFixtureCoverage, localesPlanned, routeStateParityFloor 90%);
  every Phase 2 percentage must be `done / total` citing real artifacts — "estimated
  percentages are forbidden" (appmod-phase-agent-contract rule 20).
- **Per-route behavior plan** (`per-route-behavior-plan.json`): per route
  `primaryDataCalls`, `interactiveElements` (with ownerStep 11/12/15+),
  `modalsAndBanners`, `placeholderDataPolicy: forbidden|allowedUntilStep<N>` — exists
  because "Steps 11 and 12 ship dead routes when they only have to prove 'the page
  renders' and not 'the page works'."
- **Testing accumulation plan Steps 7-17** with per-step targets (Step 8 >60% Library
  coverage growing to 80% by Step 9; Step 10 creates Playwright+Cucumber foundation;
  Step 17 = "S-TIER VERIFICATION GATE" 100% POM/Gherkin/aria/testid + >80% backend →
  Quality Score 95+ ready for Step 22), tracked in `test-accumulation-tracker.json`
  (updated by Steps 9-20, verified by Step 17; fields step17ReadinessScore,
  step22ProjectedScore).
- **Canonical planning script**: `qa-refresh-test-plan.ps1` is the authoritative
  generator for qa-test-plan/ownership-matrix/testcase-catalog + Step 8 layering-gate
  baselines (forbidden-references.json, slice-status.json) — "do not hand-author".
- **Frontend smoke lane doctrine**: one `ui-navigation-smoke.spec.ts` (~30-45s, read-only,
  no business transactions), shared helper `playwright-navigation-smoke-helper.js` under
  `.github/scripts/QA/`, exactly **one deterministic self-heal attempt** before reporting
  `Blocked`; smoke-evidence publisher is tracked infrastructure, not generated content.
- **Data-safety patterns**: Pattern A (live round-trip) for read-only GET/HEAD, Pattern B
  (interception) for mutating verbs; `ui-api-wiring-map.json` + spec template
  `_template/ui-api-wiring.spec.template.ts` drive mechanical derivation (Rule-Route-1).
- **Test root layout**: `tests/backend/{unit,contractApi,integrationBackend,smoke}`,
  `tests/frontend/{smoke,integrationFrontend,visualParity,e2e/{pages,journeys,
  accessibility,support}}`, `tests/modernization/characterization/{testcase,testResult}`;
  no step-named subfolders; one Markdown execution report per modernization step.
  Anti-Pact/perf-suite default: add only when compliance explicitly requires.
- Fixed closing line: `Ready for Step 7 Backend - Upgrade .NET: Yes or No` — and step
  names now confirmed: Step 7 "Backend - Upgrade .NET", Step 22 quality-score gate,
  Steps 9-20 update the tracker.

## Transcription uncertainties (prompt 06)

- Several headings/dashes render as garbled glyphs in the photos (e.g. "MANDATORY <?>
  Step 6 MUST assign a tier per endpoint"); transcribed as em dashes (`—`) — almost
  certainly UTF-8 em dashes displaying oddly at an angle.
- The owningStep routing table says characterization "Step 7 DEV authors and runs
  these", while the planning rule below it says "Step 7 QA uses these rows ... Step 7
  DEV does not run characterization tests" — tension preserved exactly as photographed.
- `test-accumulation-tracker.json` backendCoverage keys read `step6Target: 60`,
  `step7Target: 80`, `step15Target: 80` in the photo; the accumulation plan says Step 8
  >60% and Step 9 >80%, so these could plausibly be `step8Target`/`step9Target`/
  `step17Target` — transcribed as photographed and flagged.
- Line 525 says "Each step from 9-20 must UPDATE this tracker" while the exit criteria
  say scenarios are assigned to steps 7-17; preserved as-is.
- Execution order item 3 renders as "- 3." (stray list dash) in the photo; preserved.
- The "NO raw CSS or XPath selectors" bullet and Gherkin/data-testid/aria conventions
  appear detached after the bold Steps-7-17 paragraph (lines 378-391), likely displaced
  from the Playwright architecture section; transcribed in photographed order.
- Double-backtick identifier styling in the denominator sections preserved as shown.
- Long wrapped lines reconstructed; overlaps verified at 54-62, 92-114, 139-151,
  181-189, 222-245, 276-279, 315-321, 359-371, 411-422, 461-472, 516-522, 538-544.
- File ends at line 576.

## Structural facts added by prompt 05

- **Step 5 is the plan-closure gate** ("last major planning gate before implementation"):
  thirteen mandatory plan families — API Integration, Auth Integration, Test-Hook/Playwright,
  Data Fixture & Seeding, Performance Budget, Accessibility Audit, State Management,
  Realtime & Push, Logging & Telemetry, Environment Config, Cutover & Rollback,
  Test Isolation & Flake Budget, Localization — each recorded as a named plan array in
  `fusion-restructure/decisions.json`, each with the same drift-control rule: *"a Phase 2
  step that discovers a gap is a Step 5 planning gap and must route back here."*
- **Dominion confirmed as the acceptance-standard**: authoritative file is
  `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` (fail-fast if
  missing). Fusion is the default target outcome; MVC/Razor/AngularJS/Angular are "source
  patterns or temporary bridges, not the target-state goal by default."
- **Three-axis Step 5 readiness**: `ownershipDecisionStatus`
  (DecisionGrade|NeedsFollowUp|Blocked), `userInputGateStatus`
  (Cleared|Outstanding|Blocked), `executionReadinessStatus`
  (ReadyForQualityDesign|NotReadyForQualityDesign|UserInputRequired|BlockedMissingArtifact) —
  with `UserInputRequired` (artifacts fine, human gates open) explicitly distinguished from
  `BlockedMissingArtifact` (upstream artifacts missing/stale).
- **Named markdown reports are canonical, JSON is companion**: Step 5 must produce
  `Modernization-Solution-Design.md`, `Modernization-Execution-Contract.md`, and
  `Modernization-Phase-Assessment.md` (read downstream by exact path; the Phase-Assessment
  must state a Step 8 disposition of `Skip`|`ValidateOnly`|`Execute`) plus three DEV-owned
  control-plane JSONs under portal data. Anti-hallucination contract: every control-plane
  JSON needs non-empty `reportId` + `title` so the shared verifier can reject "a truncated
  or hallucinated fragment"; field contracts live under **`.github/contracts/schemas/`**
  (new kit directory).
- **Immutable-baseline contract**: after Step 3, AI may write under `LegacyCode/` ONLY in
  `LegacyCode/<LegacyTestProject>/Characterization/Baseline`; all other legacy-tree writes
  (and any generated JSON/reports/portal pages) are forbidden — same principle as
  Squad-ik's read-only LegacyApplication/ rule. Step 7 upgrade workspace root:
  `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`.
- **Code Quality Standards section** Steps 7-18 enforce (and Step 24 Technical Review
  verifies — confirming the 24-step count): .NET (nullable everywhere, no
  .Result/.Wait/GetAwaiter, ctor DI, methods <50 lines / classes <500,
  IFusionLogger/IFusionHttpClientFactory/IFusionCache, [Authorize] on all controllers),
  Angular (standalone components only, signals, @if/@for/@switch, inject()), a11y
  (aria-label, data-testid on all testables, landmarks, full keyboard), tests (backend
  >80% on Library, POM class per route + Gherkin per journey,
  MethodName_Scenario_ExpectedResult).
- **Wrapper capability vocabulary**: each `requiresWrapperCapability` gets
  `ShipFromDayOne`|`ExtendAtStep15`|`ExtendAtStep17Preflight`|`IntentionallyDeferred`;
  wrappers fronting generic Fusion primitives need permissive `options:
  Record<string, unknown>`; form-field wrappers need `readOnly`+`disabled` with derived
  `controlDisabled`; every wrapper passes through `elementId`+`testId` so `<label for>`
  and Playwright selectors survive the swap.
- **Carry-forward disposition vocabulary**: every material Step 3/4 item must end as
  `ResolvedByPlanningDecision`|`UserInputGate`|`OwnedByModernizationQualityDesign`|
  `OwnedByLaterStep`|`Blocked` — "do not report ready by feel."
- **Auth plan machinery**: legacy `Web.config` is authoritative for auth detection
  (`authentication mode="Windows"`, `AppletSecurity.SarRoleMapping` auto-populate
  kit-params); Okta issuer + default client id are pinned kit-wide (values redacted here);
  connection-string runtime intake uses shorthand `OCPEnv` (default OpenShift/K8s split
  env vars) | `LocalIntegrated`/`OpEx` (local Windows integrated) | `OpX` (operator
  deferral, tracked-not-blocking) | concrete config-file ref/connection string.
- **`No QA` run mode**: the exact phrase `No QA` in a request skips the mapped QA workflow
  for the run (noted as operator-requested) — the control-plane JSONs exist specifically
  so `No QA` runs still work.
- **Fixed response spine**: 12 ordered sections, a closing `User Input Required` block
  (`Required now` / `Optional` / `Auto-detected from legacy config` / `Operator
  deferrals`), and one explicit final line `Ready for Modernization Quality Design: Yes
  or No`.
- Frontmatter gains an `edit` tool entry (first Discovery prompt that writes artifacts);
  **no `model:` pin despite Premium reasoning tier** — so pins are not simply
  tier-correlated.

## Redactions (prompt 05 — deliberate, not uncertainties)

- Line ~138: the real Okta tenant URL pinned as `oktaIssuerOverride` is replaced with
  `https://<company-tenant>.okta.com` and an inline `REDACTED` comment.
- Line ~139: the concrete default Okta client ID (`0oa1…`) is replaced with
  `<default-okta-client-id>` and an inline `REDACTED` comment.
- Rationale: standing repo policy — no real Okta tenant hostnames or IDs in this repo.
  The work-side original pins the real values; restore them there, never here.

## Transcription uncertainties (prompt 05)

- Frontmatter tools list ends with a bare `- edit` (prompt 02 used `edit/editFiles`);
  transcribed as photographed.
- Double-backtick identifier styling appears from the Data Fixture section onward (mixed
  with single backticks earlier); preserved as shown.
- The `wrapperCapabilityPlan[]` bullet shows the decisions.json path without backticks,
  unlike sibling bullets; preserved as shown.
- "Step 5 closes from its own planning artifacts…" joined to the Dev-work bullet based on
  indentation in the photo.
- Long wrapped lines reconstructed from wrap positions; wording verified across photo
  overlaps at lines 14-59, 57-62, 98-108, 143-150, 189-199, and 236-246.
- File ends ~line 288 in the editor.

## Structural facts added by prompt 04

- **This is the Ignition scorecard step** (maps to Squad-ik's steps 03/19 scorecard
  machinery): a hybrid review with a deterministic layer and an AI-judgment layer, scored
  by closure formula `100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`.
- **"Dominion"** is the compliance/acceptance-criteria framework name ("Dominion
  compliance evidence", "Dominion criteria", "Dominion requirements").
- **Deterministic pattern catalog with stable IDs**: A1.x CRITICAL (-10 each, 5 patterns:
  hardcoded creds, SQL injection, tokens in localStorage, unsanitized innerHTML, sensitive
  data in logs), A2.x HIGH (-5 each, 18 patterns incl. FormsAuthentication, .Result/.Wait
  blocking, new HttpClient(), Session state, jQuery-in-Angular), A3.x MEDIUM (-2 each,
  13 patterns incl. missing OnPush, subscribe-without-unsubscribe, UseSwagger without dev
  check, verb-based URLs). Each row is Pattern + "What It Looks Like" example.
- **AI-judgment criteria with IDs**: B1 SOLID (5), B2 Security (4), B3 12-Factor (5),
  B4 API design (2, controllers only), B5 Angular (3, .ts/.html only) — plus file-level
  thresholds (class >500 lines HIGH, ctor >7 params HIGH, interface >15 methods HIGH)
  and an explicit "NOT violations" skip-list (DTO `new`, `static readonly`, IMemoryCache,
  `new` in tests).
- **Per-criterion scoring is data-driven**: criteria load from a versioned
  `acceptance-criteria-catalog.json`, each criterion gets `criterionId`/`baselineScore`
  (0..100)/`observedEvidencePaths[]`/`findingIdsContributing[]`/`confidence` in
  `baseline-review.json`; Step 5 plans remediation order from it and **Step 17 computes
  per-criterion `improvementDelta`** (baseline vs modern) — same before/after delta idea
  as Squad-ik's delta-report. Explicitly framework-generic (MVC, Razor Pages, Web Forms,
  Blazor, AngularJS, Angular, React, Vue, server-rendered HTML).
- **AI-judgment artifact with guardrails**: design-level criteria the scanner can't decide
  (SOLID SRP/OCP/LSP/ISP, stateless posture) surface as `UNKNOWN` unless an evidence-backed
  `judgments[]` artifact (`baseline-criterion-judgments.json`; Final phase uses
  `final-criterion-judgments.json`) resolves them. Guardrails: status must be
  PASS/FAIL/PARTIAL with >=1 cited `path:line - reason`; inferred-without-evidence is
  disallowed; deterministic rows are never overridden ("hard findings always outrank AI
  reasoning"); undecidable -> `PARTIAL` with reason, never a guessed clean result.
- **Step 4 three-axis status model**: `criterionCoverageStatus`
  (DecisionGrade|BroadButIncomplete|Blocked), `blockingGapStatus`
  (None|Present|BlockedByMissingEvidence), `planningInputStatus`
  (ReadyForStep5|NeedsFollowUp|Blocked). Step 4 is "incomplete" until findings are ranked
  into exact Step 5 planning inputs — evidence alone isn't done.
- **Cross-step courtesy rule**: `rename-verification.json` (Step 2-owned) unresolved items
  do NOT hard-block Step 4 when Step 2 is recorded complete in step-workflow-state.json —
  treated as informational. Steps don't re-litigate other steps' gates.
- **Model tier**: Balanced (medium thinking), 10-20 min; **no `model:` pin in this
  prompt's frontmatter** (unlike prompt 03's Opus pin) — pins appear only on the heavy
  reasoning steps.
- **Chunked review protocol**: process manifest files in chunks of 10-15, save progress
  after each chunk, require 100% file coverage verified by
  `P2-Modernize/verify-coverage.ps1` before `04-P1-generate-report.ps1 -Phase Baseline`
  refreshes `BASELINE-COMPLIANCE-REPORT.json` (portal). Fixed completion phrase:
  "BASELINE REVIEW COMPLETE".

## Transcription uncertainties (prompt 04)

- Two artifact roots appear for the same file: header block says **Output:**
  `.modernization/ignition-artifacts/discovery/baseline-review.json`, while the closure
  contract saves chunks to `.modernization/artifacts/reviews/baseline-review.json` (and
  the judgment artifact lives under `.modernization/artifacts/reviews/`). Transcribed
  exactly as photographed — possibly a source inconsistency or an intentional
  staging-vs-final split.
- The Per-Criterion Baseline Score section visibly uses **double backticks** around
  identifiers (e.g. ``criterionId``) unlike single backticks elsewhere; preserved as
  shown.
- `A2.6 async void` example shows a trailing space inside the backticks (`async void `);
  preserved.
- Long wrapped lines (status model, artifact contract, AI-judgment guardrails, closing
  bullet) reconstructed from wrap positions; wording verified across photo overlaps at
  lines 55-62, 112-118, and 157-175.
- File ends ~line 207 with trailing blank lines to 211 in the editor.

## Transcription uncertainties (prompt 03)

- Frontmatter shows only `description`, `agent`, `model`, `tools` — no `name:`/
  `argument-hint:` lines visible (unlike prompts 01-02). A "Configure Tools…" UI
  affordance appears between `model:` and `tools:`; transcribed as photographed.
- The Step Artifact Self-Check header may carry the "(QA-independent; works on `No QA`
  runs)" parenthetical seen in prompts 01-02; not legible in the photo, so omitted here.
- Source-internal inconsistency preserved as-is: the Required Artifacts table has **10**
  rows, but Required Response Sections / Output Normalization Rules say "each of the 7
  artifacts" / "list all 7 artifacts every run" (likely the A1-A7 schema artifacts).
- Line 88's `OPX_ENABLE_QA_PORTAL_REFRESH=1;` prefix transcribed exactly as shown
  (env-assignment + semicolon before a `powershell` invocation).
- Long wrapped lines (Hard Stops, capture requirements, enrichment rules, visual
  contract) reconstructed from wrap positions; wording verified across photo overlaps
  at lines 53-62, 101-109, 148-156, 203-208, and 251-260.
- File ends ~line 305 with trailing blank lines to 309 in the editor.

## Transcription uncertainties (prompt 02)

- Frontmatter `name:` line hidden behind the wrapped description in the photo;
  reconstructed from the visible filename.
- Line 6 in the tools list shows a "Configure Tools…" UI affordance, not file content.
- `npm run install` (Required Edits #6) transcribed as shown — possibly `npm install`
  in source; flagged rather than corrected.

## Transcription uncertainties (prompt 01)

- Frontmatter opening `---` not visible in photo (closing `---` at line 11 is); standard
  prompt-file frontmatter assumed.
- Lines 54-55 both appear in the source with near-duplicate wording (remove stale
  `.vs`/`obj` vs `.vs`/`bin`/`obj` "when the old build outputs are poisoning the legacy
  import graph") — transcribed as-is; possibly an intentional escalation, possibly a
  source duplication.
- Minor wrapped-line reconstruction in the Step Artifact Self-Check block (lines 22-24).
