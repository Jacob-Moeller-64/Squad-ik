---
description: Step 15 deliberate Fusion UI replacement lane that advances exactly one primitive family using the approved browser-surface planning pack.
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

# Step 15 Fusion UI Integration

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 15-30 min per primitive family (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 15 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before replacing a primitive family: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 15 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change the family surface until the restore point is present.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 15 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** Replaces exactly ONE primitive family (for example every button, or every text field) across the app with its Fusion primitive, following the Step 14 plan, and proves parity held before stopping.
- **Why it matters:** One family per pass keeps each change small, reviewable, and reversible. If a swap quietly changes a control's size, color, or behavior, the per-slice parity diff catches it before it spreads.
- **What you will have when it is done:**
  - One primitive family advanced to its mapped Fusion target (or thin wrapper).
  - A per-slice before/after parity diff for the touched routes.
  - `ui-fusion-map.json` updated with this pass's `{passId, sliceId, parityBefore, parityAfter, parityGain}`.
  - A green client build with untouched families confirmed un-regressed.

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 15 OWNS the deliberate replacement of exactly ONE primitive family** with its mapped Fusion primitive, parity held, and the touched-family artifacts reconciled. The functional, legacy-faithful baseline from Steps 10-13 is the reference oracle every swap is proven against.
- **This step does NOT own:** parity-baseline work (Steps 10-13 - if a swap reveals the baseline was wrong, that is an upstream regression to fix at its owner step), the plan itself (Step 14), or batching multiple families (one family only - the next family is Step 16).
- **This step CONSUMES:** the Step 14 planning pack (`ui-fusion-map.json`, `ui-visual-contract.json`, `ui-migration-order.json`) and the Step 10-13 parity baseline.

**Desired completed state:** exactly one primitive family advanced to its mapped Fusion target, the client build green, the per-slice parity diff showing the touched family held or improved parity, untouched families confirmed un-regressed, and the artifacts reconciled to the real source - `primitiveFamilyExecutionStatus: Advanced`.

About To Do
- Context: Step 15 is the deliberate one-family UI replacement lane. It must prove exactly one primitive family advanced, parity held, and the artifacts match the real source before the next family is considered.
- Dev work: Use the approved planning pack to replace one eligible family, run the narrow verification loop for that family, and stop cleanly after reconciliation.
- QA plan: Use `[WORKFLOW] Fusion UI Integration` inside the active Step 15 loop at meaningful checkpoints and at closeout to confirm the touched family is current, verified, and not hiding drift in other families.

Objective
- Execute Step 15 `Fusion UI Integration` as the current-family deliberate primitive-replacement lane.
- Advance exactly one eligible primitive family using the approved UI map, then stop after build, parity, regression, and artifact reconciliation for that family.
- Classify Step 15 completion explicitly with these statuses:
  - `primitiveFamilyExecutionStatus`: `Advanced`, `Partial`, or `Blocked`
  - `componentVerificationStatus`: `Current`, `Partial`, or `Blocked`
  - `step16HandoffStatus`: `ReadyForNextSlice`, `NotReadyForNextSlice`, or `Blocked`
- Do not report Step 15 complete when more than one family changed, when the touched family lacks current component-level verification, or when artifact reconciliation still lags the real source.

Execution mode
- This prompt is operational, not advisory. Load and follow `/.github/skills/fusion-ui-component-upgrade/SKILL.md` before selecting or editing the family surface.
- Treat the mapped QA workflow as the Step 15 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the portal was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-component-map.json` when present, and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-verification-report.json` when present.
- Execute exactly one primitive family. Do not batch unrelated families.

**Wrapper-Extension Preflight (MANDATORY)**
Before the first swap in a family, when the swap routes through an app-owned wrapper over a Fusion primitive:
- Read the wrapper's current input surface and the underlying Fusion primitive's input surface via Fusion MCP (`mcp_fusion_*` tools). Do not infer the primitive's input surface from prior conversations.
- Reconcile the wrapper inputs against the primitive in one preflight pass. Add any missing inputs the family will need (`placeholder`, `min`, `max`, `step`, `decimals`, `rows`, `valuePrimitive`, `readOnly`, `disabled`, `elementId`, `testId`, generic `options`) so later sub-pattern passes do not need to extend the wrapper mid-stream.
- For wrappers fronting generic Fusion primitives (for example `fusion-dropdown`), the wrapper `options` input must be permissive (`Record<string, unknown>` or equivalent). Do not narrow `options` to a domain-specific shape.
- Both `readOnly` and `disabled` inputs are required on form-field-style wrappers; the underlying primitive must receive a derived `controlDisabled = readOnly || disabled`.
- Wrappers must accept and forward `elementId` and `testId` so legacy `<label for=...>` association and Playwright `data-testid` selectors keep resolving after the swap.
- A first swap that requires a wrapper extension after the swap is incomplete Step 15 coverage and must be retried with the preflight applied.

**Fusion Component Accessibility (MANDATORY)**
Every Fusion component replacement MUST:
- Preserve or improve ARIA attributes from legacy component
- Add `data-testid` using pattern: `fusion-{family}-{purpose}` (e.g., `fusion-button-submit`)
- Verify keyboard navigation works identically to legacy
- Test with screen reader (or document expected SR behavior)
- Fusion swaps without accessibility parity are incomplete Step 15 coverage.

**Playwright Test Updates (MANDATORY)**
For each family replacement:
- Update POM classes with new Fusion selectors
- Update Gherkin steps if element structure changed
- Run existing tests to verify no regressions
- Add new tests for Fusion-specific behavior (if any)
- Family replacement without POM updates is incomplete Step 15 coverage.

**Per-Slice Visual Parity Diff (MANDATORY)**
Every Step 15 pass must produce a before/after diff for the touched route states only (not the whole app):
- Capture pre-swap screenshots for each touched ``{routeId, stateId}`` row from Step 3 ``screenshotCoverageMatrix``. Reuse the legacy baseline when current.
- Capture post-swap screenshots for the same ``{routeId, stateId}`` rows after the family swap stabilizes.
- Emit per-pair pixel-diff and structural-diff artifacts under ``.modernization/portal/data/images/parity-diffs/step17-pass-{passId}/``.
- Record results in ``.modernization/fusion-restructure/ui-fusion-map.json`` under the touched family with ``{ passId, sliceId, parityBefore, parityAfter, parityGain, diffArtifacts[] }``.
- A pass that did not produce a per-slice diff is incomplete Step 17 coverage and cannot close.

**Parity Gain Floor (MANDATORY)**
- Each Step 15 pass MUST raise the touched-family parity score by at least 5 percentage points unless the family was already above 95 percent.
- Target gain per pass is 5 to 10 percentage points so progress is visible to the user run-over-run.
- A pass with ``parityGain < 5`` and pre-pass parity ``< 95`` is incomplete and must either rework the slice, split the slice into a smaller higher-impact slice, or be classified ``Partial`` with the exact blocker recorded.

**ROI-First Slice Selection (MANDATORY)**
- Slice selection MUST prefer the highest user-visible impact slice that is dependency-safe and eligible: interactive controls, primary action buttons, frequently used dropdowns, prominent form fields, and dialog launchers come before low-visibility passive containers or background scaffolding.
- The first three Step 15 and Step 16 passes for a new browser surface MUST produce a noticeable change on the live application (a control the user can see and interact with on a primary route).
- Score each candidate slice with ``{ visibilityScore (1-5), interactionScore (1-5), riskScore (1-5), parityGainEstimate }`` and select the highest ``(visibility + interaction) - risk`` first. Record the chosen score in the pass entry so the choice is reviewable.

**Repeat-Run Recommendation (MANDATORY)**
- At the end of every Step 15 pass that closed eligible work without exhausting the family or the surface, the QA summary and Step Status MUST explicitly recommend rerunning Step 15 or Step 16 with the expected next ``+5 to +10`` percentage-point parity gain. State the next-eligible slice and its visibility/interaction score so the user can decide quickly.

**Visual Parity Verification (MANDATORY)**
- Take before/after screenshots for replaced components
- Verify sizing, spacing, colors match legacy within tolerance
- Document any intentional visual improvements
- High-risk families require visual diff approval
- Family replacement without visual verification is incomplete Step 15 coverage.
- Take a pre-swap snapshot for the touched family including route or file anchors, current selectors or hooks, measurable contract values, and final-state or bridge expectations.
- For each touched component:
  - swap to the mapped Fusion primitive when the approved map says `Fusion-owned final state`
  - use a thin app-owned wrapper when the approved map says `App-owned wrapper over Fusion`
  - keep it explicit and untouched when the approved map says `Temporary bridge` or `Keep as app-owned`
- After the first substantive edit, immediately run the real client build. Repair only the same family until the build is green.
- Run `npm run verify:fusion-ui` when the repo supports it so a component-level verification report is refreshed from current source.
- Verify the swapped family against `.modernization/fusion-restructure/ui-visual-contract.json` and confirm untouched families did not regress.
- Treat grids, charts, heavily customized tables, and composite forms as high-risk families with explicit parity checks before the family is treated as ready.

Completion gate
- Return `Ready for Step 16 Next Fusion UI Upgrade Slice: Yes` only when exactly one primitive family advanced, the build passed, the current-family parity checks passed, and the current artifacts match the real source.
- Otherwise keep the exact next step on `Step 15 Fusion UI Integration`.
- In the numbered-step response, include explicit `primitiveFamilyExecutionStatus`, `componentVerificationStatus`, and `step18HandoffStatus` values.

Wrapper API Stability Gate (MANDATORY)
- Once a Fusion wrapper has shipped one Step 17 pass, its public surface is frozen: every ``@Input``, ``@Output``, ``ContentChild``, exposed template variable, exposed CSS custom property, and exposed slot becomes the wrapper's published contract.
- A later pass may add additive inputs/outputs only when Step 7's ``wrapperCapabilityPlan`` is amended with the new capability row, the additive change is backwards compatible (default values preserve existing behavior), and the wrapper version is bumped in ``/.modernization/fusion-restructure/wrapper-versions.json``.
- Breaking changes to wrapper API (rename, remove, type-narrow, default-shift) require a new wrapper name and a planned consumer-migration row; legacy callers cannot be silently rewritten.
- Emit ``/.modernization/fusion-restructure/wrapper-api-snapshots/<wrapperName>.<version>.json`` after every pass; the diff between snapshots is part of the Step 17 review evidence.
- Generic across Angular wrappers, React wrappers, Vue wrappers, Blazor component wrappers, and any other framework that exposes a typed wrapper API. The wrapper version registry is data-driven, not hard-coded per-app.

If You Hit A Blocker (finish this step, do not drift)
- A half-swapped family - a `fusion-*` primitive rendering with the wrong variant, width, or a broken binding - is worse than the legacy control it replaced, so finish or cleanly revert the one family here rather than moving on.
- Name the exact family and component, the most likely cause in plain language (for example: the wrapper is missing an input the family needs, or `valuePrimitive` was not set so the bound value broke), and the concrete fix to finish Step 15. If the swap exposed a parity-baseline gap, route it back to the Step 10-13 owner. Apply the smallest in-scope fix and re-run the build and per-slice diff before reporting `Blocked`.
- Only advance when exactly one family advanced, the build is green, and parity held. Otherwise keep the exact next step on `Step 15 Fusion UI Integration`.

## Step 15 DEV complete - next action

Step 15 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 15 QA will:** Verify the single primitive family Step 15 DEV replaced renders correctly, matches visual parity, and meets accessibility smoke checks.
**Lanes:** Browser-contract, Visual parity, Accessibility smoke
**Expected ETA:** 3-5 min ET

Reply with the number of your choice:
1. `QA` - run `15-QA-fusion-ui-integration` now (recommended).
2. `next` - continue to Step 16 DEV (Next Fusion UI Upgrade Slice).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/15-QA-fusion-ui-integration`.
