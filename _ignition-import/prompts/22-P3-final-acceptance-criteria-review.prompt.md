---
description: Run the Step 22 final acceptance-criteria review after modernization, compare with baseline, and refresh the final compliance gate artifact.
agent: OpX-Code-Reviewer
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
  - fusion/*
  - fusion/copilot-docs/*
---

# FINAL ACCEPTANCE-CRITERIA REVIEW

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 10-20 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 22 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 22 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 22 is the final acceptance gate after verification and visual review. It must prove the accepted modernization state matches both the acceptance criteria and the approved target-state control-point contract.
- Dev work: Re-run the final acceptance review against the current verified state, preserve a criterion-by-criterion decision-grade artifact, and keep remaining blockers explicit.
- QA plan: Use `[WORKFLOW] Final Acceptance-Criteria Review` as the focused validation gate for the current acceptance artifact and handoff to Step 23.

Use the same review contract and outputs as the prior final acceptance review lane, but treat this as Step 22 in the current numbered process.

**Review Type:** Final acceptance (after modernization)
**Manifest:** .modernization/ignition-artifacts/discovery/review-manifest.json
**Output:** .modernization/ignition-artifacts/reviews/final-review.json
**Final Gate Artifact:** .modernization/portal/data/json/FINAL-COMPLIANCE-REPORT.json
**Compare Against:** .modernization/ignition-artifacts/discovery/baseline-review.json

Step 22 acceptance-status model
- Record these explicit statuses in the numbered-step response and refreshed evidence:
  - `acceptanceMatrixStatus`: `DecisionGrade`, `Partial`, or `Blocked`
  - `controlPointAcceptanceStatus`: `Aligned`, `DriftDetected`, or `Blocked`
  - `step23HandoffStatus`: `ReadyForReadinessReview`, `NotReadyForReadinessReview`, or `Blocked`
- Do not treat Step 22 as complete when acceptance findings exist but the artifact still cannot tell Step 23 whether the final acceptance state is decision-grade.

Operator focus
- Keep the numbered-step response tight: acceptance decision, top blockers, control-point acceptance state, refreshed artifact status, and the three Step 22 status fields.
- Keep criterion-by-criterion deltas, remaining bridge detail, and browser-surface contract detail in the Step 22 artifacts instead of replaying them in chat.

Review core
- Validate the final app against the acceptance criteria and the Step 7 target-state contract together, not as separate unrelated checks.
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json` before closing the review.
- Before acceptance review begins, confirm current Step 20 final verification evidence and Step 21 visual-review or explicit not-applicable proof exist for this pass. If either prerequisite is stale or missing, return `Blocked` with the exact prerequisite instead of accepting against drift.
- Confirm the protected starter shell is still preserved for platform-owned backend and browser concerns, and that app-owned behavior landed in the approved destinations instead of reintroducing a parallel custom platform surface.
- Confirm any remaining `Temporary bridge` behavior is explicit, approved, and reflected as an exception or blocker rather than silently accepted as final state.
- When `browserSurfaceApplicability` is `Required`, confirm the final browser surface still aligns to `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json`, or record the exact approved defer reason.
- Treat unresolved control-point drift, unapproved bridge carry-forward, or a regressed protected-browser-API ownership contract as final-acceptance blockers, not as post-review polish.

Execution mode
- This prompt is operational, not advisory. Execute the Step 22 acceptance gate against the current verified modernization state.
- Reuse current Step 20 and Step 21 prerequisite proof when it still matches the accepted source state. Refresh the Step 22 acceptance artifact and only the prerequisite evidence families that the current acceptance review actually invalidates.
- Do not close the step until the mapped QA workflow ran for the current review gate or the exact QA blocker was reported, the Step 22 acceptance artifact was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json` and `.modernization/portal/data/json/step-workflow-state.json`, and the saved entries were read back with populated `status`, `updatedAt`, and `latestFullResponse` values.

Artifact contract
- Include criterion-by-criterion status, baseline-to-final deltas, and blocker severity as before.
- Also include the final control-point conformance status, protected starter-shell preservation status, remaining bridge status, and browser-surface contract status when the app owns a browser surface.
- Keep those details in `.modernization/artifacts/reviews/final-review.json` and `.modernization/portal/data/json/FINAL-COMPLIANCE-REPORT.json` as the exhaustive Step 24 proof artifacts.

Closure contract
- In the numbered-step response, keep the summary tight and include explicit `acceptanceMatrixStatus`, `controlPointAcceptanceStatus`, and `step25HandoffStatus` values.
- If Step 24 is blocked by stale prerequisites or unresolved acceptance blockers, return the exact blocker and next recovery path instead of replaying the full acceptance matrix in chat.
