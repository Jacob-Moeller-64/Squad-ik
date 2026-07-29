---
description: "Squad-as-runner pilot for the Ignition Kit Discovery phase (Steps 1-6). Defines how the Squad coordinator executes the original numbered Discovery prompts in order, one subagent per step, stopping between steps for developer review, writing to the original Ignition artifact homes. Token efficiency is the point: each subagent loads only its step's contract inputs."
applyTo: ".github/agents/squad.agent.md,.squad/agents/lead/charter.md,.squad/agents/reviewer/charter.md,.squad/agents/tester/charter.md,.github/prompts/0[1-6]-P1-*.prompt.md"
---

# Discovery Runner (Squad executes the Ignition Discovery prompts, Steps 1-6)

## What this is

The modernization PROCESS is the original Ignition Kit design: the numbered prompts under `.github/prompts/**`, the portal + `ignition-artifacts` outputs, and the per-step producer/consumer contract in `.github/instructions/AppMod-Artifact-Contract.json`. Squad is the EXECUTION LAYER that runs that process. This file wires the FIRST pilot: Discovery, Steps 1-6. Later phases (7-24) will follow the same runner pattern once this one is proven.

Stay as close to the Ignition Kit design as possible. Squad's only job here is to run the same prompts more token-efficiently and with an explicit stop after each step so the developer sees every change.

## Kickoff (copy-paste this verbatim, every time)

This is the canonical invocation. It does not change between apps or between sessions - only the two bracketed values change. Pasting anything else (a hand-written paraphrase) risks silently dropping one of the rules below (the Step 4 override in particular).

**Determining `[START]` - do NOT trust `lastCompletedStep` at face value.** A step showing `"status": "Completed"` in `step-workflow-state.json` only ever proves it passed the deterministic `verify-step-artifacts.ps1` presence check (Layer 1 below) - that check confirms a file exists and is non-empty, nothing more. It is NOT proof the artifact is deep enough to trust, and any `Completed` entry recorded BEFORE this runner's independent reviewer completeness gate (Layer 2 below) existed has NEVER been checked for depth at all.
- Steps 1-2 are procedural, not analytical (workstation env check; a rename that either built or didn't). Their `Completed` status is trustworthy at face value - correctly skip them once shown `Completed`.
- Steps 3-6 produce analytical depth (inventories, review findings, design docs, test plans). A `Completed` status for one of these recorded before the reviewer completeness gate ran means that artifact was NEVER independently verified and must be treated as unverified, not done - regardless of what `lastCompletedStep` claims. In that case `[START]` is the first such step in range (normally `3`), not whatever step number `lastCompletedStep` happens to report.
- Only trust a Step 3-6 `Completed` status at face value once its OWN stop already recorded a `reviewer` `Pass` verdict under this runner. No recorded reviewer verdict for that step = treat it as `[START]`.

`[END]` is `6` unless the developer explicitly wants a partial re-run of fewer steps.

```
Read .github/instructions/discovery-runner.instructions.md in full before doing anything - it is not automatically attached in this session. Run Discovery Steps [START] through [END] using that pilot wiring. Check .modernization/portal/data/json/step-workflow-state.json first, but a step marked Completed there only proves it passed the deterministic verify-step-artifacts.ps1 presence check, not that it is deep enough - only skip a Completed step if its OWN stop already recorded an independent reviewer Pass verdict under this runner; otherwise run it anyway regardless of its Completed status.

For each step: dispatch one subagent to execute that step's numbered prompt in full, then dispatch a SEPARATE reviewer subagent for the independent completeness review described in .squad/agents/reviewer/charter.md. Then STOP and show me: the step label, artifacts produced/changed, the reviewer's Pass/Partial/Fail verdict with cited evidence, and the recommended next step. Wait for me to say "continue" before moving to the next step.

Step 4 exception (always apply this if Step 4 is in range): do not run 04-P1-generate-report.ps1 -Phase Baseline. Use the AI-only compliance flow instead (compliance-scan manifest before -> review every file -> assemble before --manifest --enforce -> render before, per .github/skills/appmod-compliance-review/SKILL.md), writing to .modernization/ignition-artifacts/compliance/.
```

Do not paraphrase this. If the wording needs to change (a new exception, a new gate), edit this section - do not improvise a new kickoff message in chat and leave this file stale.

## Why Squad (the token-efficiency contract)

Running all six Discovery steps in one long chat accumulates every step's transcript in a single context, which balloons by Step 5-6. The Squad runner avoids that:

- **One subagent per step.** The coordinator dispatches step N to a subagent that starts with a fresh, scoped context.
- **Scoped inputs only.** The subagent loads ONLY that step's `requiredInputs` from `AppMod-Artifact-Contract.json` (plus the step's prompt) - not prior step transcripts. Downstream steps read prior outputs from disk, not from context.
- **Coordinator keeps summaries only.** After a step returns, the coordinator retains a short summary + which step is next, not the full step transcript.

The irreducible per-step work (for example reviewing every file in `review-manifest.json`) costs the same tokens either way; the savings come from eliminating cross-step context accumulation.

## The run-loop protocol

For each step 1 -> 6, in order:

1. **Check inputs.** Confirm the step's `requiredInputs` (see `AppMod-Artifact-Contract.json`) exist and are current. If a `hardStop` input is missing/stale, run its `selfHeal` command or report the step `Blocked` with the exact missing artifact - do NOT fabricate the missing truth.
2. **Dispatch one subagent** for the step (VS Code: `runSubagent`; CLI: `task`). The dispatch prompt is: *"Execute `<promptPath>` in full. Your inputs are `<requiredInputs>`. Produce `<producedOutputs>` at their exact Ignition paths. Follow the numbered-step completion contract in `AppMod-Step-Contract.json` (save `step-workflow-state.json`, run `Invoke-StepReconciliation.ps1 -Step <N>`, read back the saved state). Return a short summary + the step self-check result only."* **Step 4 override (always include this line verbatim in Step 4's dispatch):** *"Exception: do NOT run `04-P1-generate-report.ps1 -Phase Baseline` even though the prompt body references it. Produce the compliance report via the AI-only flow instead: `compliance-scan manifest before` -> review every file -> `assemble before --manifest --enforce` -> `render before` (see `.github/skills/appmod-compliance-review/SKILL.md`), written to `.modernization/ignition-artifacts/compliance/`. Every other part of the prompt runs as written."*
3. **Subagent executes the prompt** in its own scoped context, writes outputs to the original Ignition homes (`.modernization/portal/**` and `.modernization/ignition-artifacts/**` per the contract), and returns a concise summary.
4. **Independent completeness review (`reviewer`, mandatory, every step).** Dispatch a SEPARATE `reviewer` subagent to judge the step's `producedOutputs` — not the producing agent grading its own work. This is AI judgment, never a script: reviewer reads the artifact against the owning prompt's own stated completeness bar and real, independently countable ground truth (actual controllers/services/routes/files in `LegacyCode/`, actual row count in `review-manifest.json`, etc.), and returns `Pass` / `Partial` / `Fail` per artifact with the specific gap cited (a bare "looks fine" is not an acceptable verdict). See `.squad/agents/reviewer/charter.md` "Discovery artifact completeness review." A `Fail` or a `Partial` on a `hardStop`-consumed artifact blocks advancing to the next step until fixed or the developer explicitly accepts the gap.
5. **Stop and show the developer.** Surface: the step label, the artifacts produced/changed (paths), the step self-check result, and the recommended next step. Then STOP.
6. **Wait for the developer's `continue`** (or a fix request) before dispatching step N+1. Never chain two steps without the stop.

Keep `Pass` / `Partial` / `Blocked` / `Fail` distinct at every stop. A step is complete only when its mapped workflow ran and the completion contract in `AppMod-Step-Contract.json` is satisfied.

## Verification: two layers, and why both matter

**Layer 1 - deterministic presence (`verify-step-artifacts.ps1 -Step <N> -Mode Output`).** Cheap, fast, always run. Confirms a declared artifact exists, is non-empty, and (when a schema is declared) has the required fields. Exit 0 pass / 2 fail. **This is a floor, not proof of completeness** - a thin, shallow artifact can still pass this check.

**Layer 2 - independent AI completeness review (`reviewer`, step 4 of the run-loop above).** This is the real gate. Presence-only checks cannot tell a 14-service inventory from the ~40 services that actually exist in `LegacyCode/` - both are "present and non-empty." Only reading the artifact against real ground truth catches that gap. Never skip Layer 2 to save a dispatch; a step that only passed Layer 1 has not been verified for completeness.

## Step map (Discovery, Steps 1-6)

Owning Squad agent is the Squad-roster equivalent of the prompt's original `OpX-AppMod-P1-Discovery` owner, routed per `.squad/routing.md`. Inputs/outputs below are the headline set - the authority is `AppMod-Artifact-Contract.json`.

**Step identity (`stepId`).** Each step has a stable `stepId` in `.github/instructions/step-registry.json` (the `Step ID` column below). Cross-references between toolkit files use `step:<stepId>` tokens so renumbering only touches the registry, not every reference. Two hard rules from `step-registry.json`: ALWAYS translate a `stepId` to its human label (e.g. `step:26b4e1` -> `Step 3 - Legacy System Analysis`) in every developer-facing stop, and NEVER surface a raw `stepId` to the developer. The registry-migrated shared scripts (`verify-step-artifacts.ps1`, `Invoke-StepReconciliation.ps1`) also accept `-StepId '<stepId>'` in place of `-Step <N>`; scripts not yet migrated still take `-Step <N>`.

| Step | Step ID | Label | Prompt | Squad owner | Key inputs | Key outputs |
|---|---|---|---|---|---|---|
| 1 | `7be409` | Workstation Readiness | `.github/prompts/01-P1-workstation-readiness.prompt.md` | lead | (none) | (env checks only) |
| 2 | `1fc2ba` | Rename Starter To `<AppName>` | `.github/prompts/02-P1-rename-starter-to-appname.prompt.md` | lead | `kit-params.md` | `rename-verification.json`, `step-workflow-state.json` |
| 3 | `26b4e1` | Legacy System Analysis | `.github/prompts/03-P1-legacy-system-analysis.prompt.md` | lead | `kit-params.md` | `discovery/{service-behavior,interaction-wiring,workflow-trace}-inventory.json`, `fusion-restructure/inventory.json`, `legacy-system-analysis-report.json` |
| 4 | `261769` | Baseline Acceptance-Criteria Review | `.github/prompts/04-P1-baseline-acceptance-criteria-review.prompt.md` | reviewer | `discovery/review-manifest.json` (hardStop) | `discovery/baseline-review.json`; **compliance report via the AI-only flow (see below)** |
| 5 | `d847e7` | Modernization Solution Design | `.github/prompts/05-P1-modernization-solution-design.prompt.md` | lead | Step 3 + Step 4 outputs, `review-manifest.json`, `fusion-restructure/inventory.json` (all hardStop) | `Modernization-{Solution-Design,Execution-Contract,Phase-Assessment}.md`, `addendums/Architecture-Structure.md`, `fusion-restructure/{decisions,migration-plan,control-point-inventory}.json`, portal machine-forms |
| 6 | `6c50db` | Modernization Quality Design | `.github/prompts/06-P1-modernization-quality-design.prompt.md` | tester | `Modernization-Solution-Design.md`, `Modernization-Phase-Assessment.md` (hardStop) | `qa-test-plan.json`, `executable-testcase-catalog.json`, `characterization-test-planning.json`, `fusion-restructure/{forbidden-references,slice-status}.json`, `per-route-behavior-plan.json`, `test-accumulation-tracker.json`, `discovery/testing-ownership-matrix.generated.json` |

## The one deliberate deviation from Ignition: the compliance report

Step 4 produces the baseline compliance report, but NOT via Ignition's deterministic `04-P1-generate-report.ps1` path. Instead the `reviewer` uses the **AI-only** compliance flow: the review manifest supplies the file set, a fixed template gives a consistent report shape across apps, and AI judgment does the complete review. Run `tools/appmod/gates/compliance-scan.* manifest before` -> review every file -> `assemble before --manifest --enforce` -> `render before`, per `.github/skills/appmod-compliance-review`. Output goes to `.modernization/ignition-artifacts/compliance/`. Everything else in Step 4 (baseline acceptance findings, `baseline-review.json`) follows the Ignition prompt as written.

## Boundaries

- Do not skip the stop between steps. The visible, step-by-step cadence is a requirement, not a nicety.
- Do not retarget the prompts' output paths. Write to the original Ignition homes so the run stays Ignition-faithful and downstream steps find their inputs where the contract says they are.
- `tools/appmod/` gates + the frozen scorecard remain available as supplementary proof, but they do not replace the numbered-step artifact contract.
- This pilot covers Steps 1-6 only. Do not auto-advance into Step 7+ without an explicit developer go.
