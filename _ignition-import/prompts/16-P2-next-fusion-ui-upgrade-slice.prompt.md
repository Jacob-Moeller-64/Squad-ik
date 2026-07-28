---
description: Step 16 deliberate UI continuation lane that derives and executes exactly one next eligible primitive-family upgrade slice.
agent: OpX-AppMod-P2-Modernize
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
  - agent
  - browser
  - edit/editFiles
  - todo
  - vscode/vscodeAPI
  - fusion/copilot-docs/*
---

# Step 16 Next Fusion UI Upgrade Slice

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 15-30 min per primitive family (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 16 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before taking the next UI slice: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 16 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change the slice until the restore point is present.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 16 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** The continuation lane for the Fusion UI migration - it picks the next eligible primitive family or sub-pattern from the Step 14 order, runs the Step 15 replacement for that one slice, or declares the UI lane exhausted when nothing eligible remains.
- **Why it matters:** This is how the migration finishes one safe slice at a time without guessing. A family chosen out of order can break a dependency; a false "exhausted" claim leaves the app half-modernized.
- **What you will have when it is done:**
  - One more primitive family/sub-pattern advanced (or a backed `Exhausted` declaration).
  - The touched slice's per-slice parity diff and a sibling-regression check.
  - `ui-fusion-map.json` and `ui-migration-order.json` reconciled with this pass.

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 16 OWNS choosing and advancing the NEXT eligible family/sub-pattern** (exactly one per pass), or proving the deliberate UI lane is genuinely exhausted. It runs Step 15's replacement contract for that one slice - it does not invent a different process.
- **This step does NOT own:** the parity baseline (Steps 10-13), the plan/order (Step 14 - follow `ui-migration-order.json`, do not guess outside it), batching multiple families, or final verification (Step 17).
- **This step CONSUMES:** the Step 14 order and the running `ui-fusion-map.json` `subPatternProgress` to pick the next dependency-safe slice.

**Desired completed state:** either one more eligible family/sub-pattern advanced with parity held and siblings un-regressed (`nextEligibleFamilyStatus: Advanced`), or a `nextEligibleFamilyStatus: Exhausted` backed by the eligibility predicate showing no eligible slice remains - so Step 17 verification begins over a complete, reconciled UI lane.

About To Do
- Context: Step 16 is the continuation lane for deliberate UI replacement. It must prove whether one more eligible family advanced or whether the UI lane is genuinely exhausted for now.
- Dev work: Select the next dependency-safe family from current artifacts, execute exactly one new slice when eligible, or record that the lane is exhausted without guessing.
- QA plan: Use `[WORKFLOW] Next Fusion UI Upgrade Slice` inside the active Step 16 loop at meaningful checkpoints and at closeout to confirm the lane either advanced truthfully or exhausted cleanly before Step 17 verification begins.

Objective
- Execute Step 16 `Next Fusion UI Upgrade Slice` as the continuation lane for deliberate primitive-family replacement.
- Determine the next eligible primitive family from the current artifacts, execute exactly one new family, and stop cleanly when the deliberate UI lane is exhausted.
- Classify Step 16 completion explicitly with these statuses:
  - `nextEligibleFamilyStatus`: `Advanced`, `Exhausted`, or `Blocked`
  - `artifactReconciliationStatus`: `Current`, `Partial`, or `Blocked`
  - `step17HandoffStatus`: `ReadyForVerification`, `ContinueUiLane`, or `Blocked`
- Do not report Step 16 complete when the next family was guessed outside the approved order, when no-family-remaining claims are not backed by current artifacts, or when the touched family artifacts still lag source.

Execution mode
- This prompt is operational, not advisory. Use the current browser-surface artifacts to choose the next family instead of ad hoc guesses.
- Treat the mapped QA workflow as the Step 16 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the portal was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-component-map.json` when present, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-verification-report.json` when present, and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-task-list.md` when the repo uses task-graph-driven UI slices.
- Determine the next incomplete and dependency-safe primitive family from the current migration-order and component-level evidence.
- If no eligible family remains, state that the deliberate primitive-family UI lane is exhausted for the current browser surface and stop cleanly.
- If a next family exists, execute `.github/prompts/15-P2-fusion-ui-integration.prompt.md` in full for that one family.
- Stop after that one family. Do not continue automatically into a second family from this step.

**Sub-Pattern Progress (MANDATORY)**
When the selected family contains multiple sub-patterns (different binding shapes, value types, or wrapper-capability requirements) as cataloged at Step 16:
- Execute exactly one sub-pattern per pass. Do not chain two sub-patterns even when they belong to the same family.
- Read `subPatternProgress` on the family from prior Step 17 and Step 18 entries in `.modernization/fusion-restructure/ui-fusion-map.json` before selecting the next sub-pattern.
- Select the next dependency-safe sub-pattern from the family's `suggestedPassOrder` (Step 16). Do not guess outside that order.
- Skip with a recorded reason any sub-pattern whose `requiresWrapperCapability` is not yet satisfied by the current wrapper; the next-action choice is either close the wrapper-capability gap first or move to the next-eligible sub-pattern.
- Close the pass with `familyRetirementStatus: Partial` and a named `followUpSlice` when sub-patterns remain. Use `familyRetirementStatus: Complete` only when every sub-pattern is migrated or has a recorded deferral.

**ROI-First Sub-Pattern Selection (MANDATORY)**
- Step 16 sub-pattern selection MUST follow the ROI rule defined in Step 15 ``ROI-First Slice Selection``.
- Among dependency-safe and eligible sub-patterns, choose the one with the highest ``(visibilityScore + interactionScore) - riskScore``. Interactive primitives (buttons, dropdowns, dialog launchers, primary inputs) come before passive container scaffolding.
- The first three Step 16 passes on a new surface MUST produce a noticeable change visible on the running application.
- Record the score in the pass entry so the choice is reviewable.

**Per-Slice Parity Diff & Gain Floor (MANDATORY)**
Step 16 inherits the per-slice parity diff and 5-to-10 percentage-point gain floor defined in Step 15. The diff artifact path for Step 16 passes is ``.modernization/portal/data/images/parity-diffs/step16-pass-{passId}/``. A pass with ``parityGain < 5`` and pre-pass parity ``< 95`` is incomplete and must rework, split, or report ``Partial``.

**Repeat-Run Recommendation (MANDATORY)**
At the end of every Step 16 pass that advanced eligible work without exhausting all families, the QA summary and Step Status MUST explicitly recommend rerunning Step 16 with the expected next parity gain (5 to 10 percentage points) and name the next-eligible sub-pattern with its visibility/interaction score. Exhaustion claims must cite the eligibility predicate.

**Eligibility Predicate (MANDATORY)**
A slice is eligible to advance only when all of the following are true:
- the slice's `migrationEligible` field (Step 16) is not `false`
- the slice's `bindingShape` (Step 16) is supported by the wrapper or target primitive without a binding-shape refactor in the same pass
- every entry in the slice's `requiresWrapperCapability` (Step 16) is present in the current wrapper
- the slice has not already been advanced in a prior Step 15 or Step 16 pass (check `ui-fusion-map.json` map keys)
If no remaining slice is eligible under this predicate, classify `nextEligibleFamilyStatus: Exhausted` and proceed to Step 17. Do not improvise eligibility outside this predicate.

Completion gate
- Keep the exact next step on `<MOJIBAKE: emoji + keycap digits "1" "8"> Next Fusion UI Upgrade Slice` while eligible primitive families still remain.
- Hand off to `<MOJIBAKE: emoji + keycap digits "1" "9"> Rewire All Tests & Verify` only when the deliberate primitive-family UI lane is exhausted for the current browser surface or the approved plan says the remaining families are intentionally deferred.
- In the numbered-step response, include explicit `nextEligibleFamilyStatus`, `artifactReconciliationStatus`, and `step19HandoffStatus` values.

Sibling Slice Regression Gate (MANDATORY)
- After the active Step 18 pass finishes its primary slice, rerun the verification suite (visual parity, E2E click-through, accessibility scan, console-error watch) for the 2-3 nearest sibling slices on the same route, the same parent module, or the same shared wrapper family.
- Sibling selection is data-driven from ``/.modernization/fusion-restructure/slice-graph.json``: nearest siblings are the slices that share a route ancestor, a parent module/feature folder, or a common wrapper from the Step 17 ``wrapper-versions.json``.
- Emit ``/.modernization/fusion-restructure/sibling-regression/<sliceId>.json`` with ``primarySliceId``, ``siblingSlicesChecked[]``, ``regressionFindings[]`` (each with ``siblingSliceId``, ``check`` (``visual-parity``, ``e2e``, ``a11y``, ``console-errors``), ``status`` (``pass``, ``warn``, ``fail``), ``evidencePath``).
- Any sibling ``fail`` blocks the primary slice from closing; ``warn`` requires either remediation in this pass or a documented variance in the Step 18 pass report.
- Generic across MVC, Razor Pages, AngularJS, Angular, React, Vue, Blazor, and server-rendered HTML. The slice graph is derived from ``componentCensus`` and route adjacency, not hard-coded slice lists.

If You Hit A Blocker (finish this step, do not drift)
- Guessing the next family outside the approved order, or claiming "exhausted" without the eligibility predicate, poisons Step 17 verification, so resolve the selection honestly here.
- Name the exact blocked slice and why (a missing wrapper capability, an unsupported binding shape, a sibling regression), the most likely cause in plain language, and the concrete fix to finish this slice - or, if the lane is truly exhausted, cite the eligibility-predicate rows that prove no eligible slice remains. Apply the smallest in-scope fix and re-run the build and per-slice diff before reporting `Blocked`.
- Only advance to Step 17 when the lane is exhausted (or intentionally deferred per the approved plan). Otherwise keep the exact next step on `Step 16 Next Fusion UI Upgrade Slice`.

## Step 16 DEV complete - next action

Step 16 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 16 QA will:** Same shape as Step 15 QA, applied to the slice Step 16 DEV just advanced.
**Lanes:** Browser-contract, Visual parity, Accessibility smoke
**Expected ETA:** 3-5 min ET

Reply with the number of your choice:
1. `QA` - run `16-QA-next-fusion-ui-upgrade-slice` now (recommended).
2. `next` - continue to Step 17 DEV (Rewire All Tests & Verify).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/16-QA-next-fusion-ui-upgrade-slice`.
