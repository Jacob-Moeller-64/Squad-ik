---
description: Step 20 final verification gate that proves build, tests, runtime, and control-point alignment before broader review steps continue.
agent: OpX-AppMod-P3-Review
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

# Step 20 Final Verification

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 20 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 20 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 20 is the full final verification gate before visual and acceptance review. It must prove build, suites, runtime, and control-point conformance are current for the exact reviewed source state.
- Dev work: Run the narrowest truthful final verification path, repair same-slice defects when clear, and keep any failed verification family explicit in the evidence.
- QA plan: Use `[WORKFLOW] Final Verification` as the focused validation gate for the current verification artifact and handoff to Step 23.

Objective
- Execute Step 20 `Final Verification` as the final build, suite, runtime, and control-point proof pass before broader review.
- Prove the current fusion-aligned modernization state is operational enough to move into the visual and acceptance review gates.
- Classify Step 20 completion explicitly with these statuses:
  - `verificationEvidenceStatus`: `Current`, `Partial`, or `Blocked`
  - `controlPointConformanceStatus`: `Aligned`, `DriftDetected`, or `Blocked`
  - `step21HandoffStatus`: `ReadyForVisualReview`, `NotReadyForVisualReview`, or `Blocked`
- Do not report Step 20 ready when build or suite proof is stale, when runtime proof does not cover the approved target roots, or when control-point ownership still drifts from the approved final state.

Execution mode
- This prompt is operational, not advisory. Run the narrowest truthful full verification path from the current application state and repair the same slice when one clear local defect appears.
- Reuse current Step 19 review findings and Step 17 plus Step 18 prerequisites when they still match the reviewed source state. Refresh the Step 20 verification artifact and only the prerequisite evidence families that the current verification actually invalidates.
- Do not close the step until the mapped QA workflow ran for the current review gate or the exact QA blocker was reported, the Step 20 verification artifact was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/fusion-restructure/decisions.json`, `.modernization/fusion-restructure/control-point-inventory.json`, and `.modernization/fusion-restructure/migration-plan.json` before final verification.
- Before final verification begins, confirm the current Step 21 Fusion review artifact exists for this pass and that Step 19 verification proof plus Step 20 cleanup disposition are still the active prerequisites for the reviewed state. If not, return `Blocked` with the exact stale or missing prerequisite.
- Use the Step 7 and restructure decisions to confirm the approved target roots. When the selected target is the standard simple browser-led shape, final verification should prove `src/<AppName>.Library`, `src/<AppName>.Web.Api`, and `src/<AppName>.Web.Client`. When Step 7 approved another valid target shape, prove that approved shape instead of forcing the simple layout.
- Run final build proof for the valid modernization scope.
- Run the owned backend and frontend suites for the approved final state, including the real frontend test script in non-watch mode when the repo supports it.
- Verify the protected starter shell still owns the approved platform control points for startup, DI, auth, OpenAPI or Scalar, logging, client bootstrap, and client configuration rather than parallel custom platform stacks.
- For backend runtime proof:
  - verify API startup and the relevant runtime health or startup endpoint when one exists
  - verify at least one unauthenticated protected endpoint returns the expected auth challenge behavior
  - verify at least one mapped-role success case and one insufficient-role rejection case when the app owns protected backend behavior
  - when the app owns a current-user endpoint, custom policy handler, or security helper, confirm it resolves memberships from the same evaluator and membership source used by protected endpoints
  - confirm platform-owned auth, role, policy, and connection-string configuration resolves from the approved final-state sections or approved centralized composition seam, and exercise one database-backed path when the app depends on database runtime proof
- For frontend runtime proof when the app owns a browser surface:
  - verify canonical routes, default landing behavior, callback or logout behavior, and protected-route ownership against the Step 5 control-point contract
  - verify significant protected client API paths use the approved protected-request mechanism, including bearer-token or equivalent proof when the Step 5 contract marked those paths as protected
  - verify client provider and service ownership matches the approved final state rather than an untracked bridge path
  - confirm the preserved visual contract is still usable before and after any deliberate primitive-family replacement, including styling foundation, layout framing, widths, gutters, control heights, grid or table density, dialog sizing, and breakpoint behavior on the touched routes
  - confirm remaining browser bridges, UI wrappers, or high-risk widget exceptions match the approved artifacts instead of being hidden as final-state behavior
- Make any failing verification family explicit in the returned data and refreshed evidence instead of hiding it behind a prose-only summary.
- Make any remaining `Temporary bridge` behavior explicit in the returned data and refreshed evidence instead of hiding it behind a prose-only summary.

Completion gate
- Return `Ready for Step 21 Figma Review: Yes` only when final build, owned suites, runtime proof, and final control-point alignment are current enough for the later review lane.
- Otherwise keep the exact next step on `<MOJIBAKE: emoji + keycap digits> Final Verification`.
- In the numbered-step response, include explicit `verificationEvidenceStatus`, `controlPointConformanceStatus`, and `step23HandoffStatus` values.
