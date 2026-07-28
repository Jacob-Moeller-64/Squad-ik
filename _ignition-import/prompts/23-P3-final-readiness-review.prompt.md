---
description: Final readiness review that rebuilds the release-decision evidence pack before declaring modernization complete.
agent: OpX-AppMod-P3-Review
tools:
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

# Final Readiness Review

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 10-20 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 23 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 23 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 23 is the final release-decision gate. It must rebuild the readiness pack from current prerequisite proofs and make the release decision plus any remaining bridge or cleanup posture explicit.
- Dev work: Rebuild the final readiness evidence from the active accepted state, confirm readiness scope across build, runtime, cleanup, and browser ownership, and record one release decision from current proof.
- QA plan: Use `[WORKFLOW] Final Readiness Review` as the focused validation gate for the current readiness artifact and release decision.

Objective
- Run the Step 23 final readiness pass before declaring modernization complete.
- Prove the modernization build, test suite, and runtime startup.
- Confirm the final readiness pass is still aligned to the acceptance criteria and to the latest Dominion compliance review output.
- Produce the durable Step 23 deployment-readiness artifact at `.modernization/ignition-artifacts/reviews/deployment-readiness-review.json`.
- Classify Step 23 completion explicitly with these statuses:
  - `readinessEvidenceStatus`: `Current`, `Partial`, or `Blocked`
  - `bridgeAndCleanupStatus`: `Explicit`, `Partial`, or `Blocked`
  - `releaseDecisionStatus`: `Pass`, `Blocked`, or `Fail`
- Do not report Step 23 complete when the readiness artifact exists but still relies on stale prerequisite proofs or leaves remaining bridge or cleanup posture implicit.

Operator focus
- Keep the numbered-step response tight: release decision, top remaining blockers, bridge-and-cleanup disposition, refreshed artifact status, and the three Step 23 status fields.
- Keep detailed deployment-readiness, packaging, and high-risk widget parity proof in the Step 23 artifact instead of replaying that detail in chat.

Execution mode
- This prompt is operational, not advisory. Execute the Step 23 readiness gate against the current accepted modernization state.
- Reuse current Step 17, Step 18, Step 20, and Step 22 prerequisite proof when it still matches the accepted source state. Refresh the Step 23 readiness artifact and only the prerequisite evidence families that the current readiness pass actually invalidates.
- Do not close the step until the mapped QA workflow ran for the current review gate or the exact QA blocker was reported, the Step 23 readiness artifact was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json` and `.modernization/portal/data/json/step-workflow-state.json`, and the saved entries were read back with populated `status`, `updatedAt`, and `latestFullResponse` values.

Readiness core
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json` before closing readiness.
- Before rebuilding the final readiness pack, confirm current Step 17 verification proof, Step 18 cleanup disposition, Step 20 final verification evidence, and the Step 22 final acceptance artifact exist for this pass. If any prerequisite is stale or missing, return `Blocked` with the exact prerequisite instead of rebuilding readiness from drift.
- Confirm the final build, owned suites, and runtime proof still match the Step 5 ownership contract and the accepted Step 22 final-acceptance posture.
- Confirm the protected starter shell remains the owner for platform-owned backend and browser concerns, with no unapproved custom replacement seams introduced during the final passes.
- Confirm remaining backend or browser `Temporary bridge` behavior is either retired or explicitly approved with owner, rationale, and downstream follow-up captured in the final readiness artifact.
- Confirm deployment and cleanup posture is explicit: validated leftovers from earlier workspaces or bridge locations are either removed, intentionally retained with rationale, or recorded as blockers instead of being left implicit.
- When `browserSurfaceApplicability` is `Required`, confirm the final browser control-point ownership, protected API ownership, callback/logout behavior, and shell stabilization evidence are current enough for deployment-readiness discussion.
- When `browserSurfaceApplicability` is `Required`, also confirm the current primitive families are either in their approved `Fusion-owned final state`, `App-owned wrapper over Fusion`, `Temporary bridge`, or `Keep as app-owned` state as recorded in `ui-fusion-map.json`, and that high-risk widgets such as grids, charts, heavily customized tables, and composite forms have explicit parity evidence before any legacy version is treated as retired.
- When deliberate primitive-family replacement ran for the browser surface, also confirm `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-component-map.json` and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-verification-report.json` agree with the real current source instead of claiming families were swapped when legacy selectors or bridges still remain.

Artifact contract
- The deployment-readiness artifact must record packaging or build proof, deployment-readiness proof, final compliance posture, remaining blockers, and one explicit release decision of `Pass`, `Blocked`, or `Fail`.
- It must also record starter-shell preservation status, control-point conformance status, remaining bridge status, cleanup disposition for any validated leftovers that remain outside the final target roots, and the final primitive-family ownership plus high-risk-widget parity disposition when the app owns a browser surface.
- The deployment-readiness artifact must be grounded in the current Step 17, Step 18, Step 20, and Step 22 prerequisite proofs rather than silently reusing stale readiness inputs.
- Keep those details in `.modernization/ignition-artifacts/reviews/deployment-readiness-review.json` as the exhaustive Step 23 proof artifact.

Closure contract
- In the numbered-step response, keep the summary tight and include explicit `readinessEvidenceStatus`, `bridgeAndCleanupStatus`, and `releaseDecisionStatus` values.
- If Step 23 is blocked by stale prerequisites or unresolved readiness blockers, return the exact blocker and next recovery path instead of replaying the full readiness artifact in chat.
