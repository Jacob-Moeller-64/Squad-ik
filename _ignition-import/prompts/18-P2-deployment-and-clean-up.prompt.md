---
description: Step 18 cleanup lane that updates deployment-facing references, removes validated leftovers, and records explicit cleanup disposition before review starts.
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

# Step 18 Deployment & Clean Up

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 10-20 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 18 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before changing deployment-facing references or removing leftovers: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 18 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change deployment files until the restore point is present.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 18 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

About To Do
- Context: Step 18 is the pre-review cleanup lane. It must prove deployment-facing references and leftover disposition match the validated modernization state instead of leaving review to discover cleanup drift.
- Dev work: Update real deployment-facing references, remove only validated leftovers, and make every retained leftover or alias explicit with rationale.
- QA plan: Use `[WORKFLOW] Deployment & Clean Up` inside the active Step 18 loop at meaningful checkpoints and at closeout to confirm cleanup and deployment references are aligned strongly enough for review entry.

Objective
- Execute Step 18 `Deployment & Clean Up` as the pre-review cleanup lane.
- Update deployment-facing references to the real app roots, remove validated leftovers, and make remaining cleanup disposition explicit before review begins.
- Classify Step 18 completion explicitly with these statuses:
  - `deploymentReferenceStatus`: `Aligned`, `Partial`, or `Blocked`
  - `cleanupDispositionStatus`: `Explicit`, `Partial`, or `Blocked`
  - `step19HandoffStatus`: `ReadyForReview`, `NotReadyForReview`, or `Blocked`
- Do not report Step 18 complete when deployment or pipeline references still point at obsolete roots, when leftovers remain without rationale, or when stale portal aliases still misdirect later review evidence.

Execution mode
- This prompt is operational, not advisory. Apply only the cleanup and deployment-reference changes that are justified by the validated modernization state.
- Treat the mapped QA workflow as the Step 18 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the portal was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json` and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` before changing deployment-facing references or cleanup disposition.
- Update Dockerfiles, overlays, solution references, and pipeline paths to point at the approved app-named projects under `src/`.

**Production-Ready Cleanup Verification (MANDATORY)**
Before handoff to review, verify:
- **Code Quality**: No TODO/FIXME/HACK comments in production code (move to backlog)
- **No Debug Code**: Remove `console.log`, `debugger`, test-only code from production
- **No Dead Code**: Remove unused imports, variables, functions, components
- **Consistent Formatting**: Run formatters (Prettier, dotnet format) on all code
- **Documentation**: README updated with current architecture and run instructions
- Cleanup without code hygiene verification is incomplete Step 18 coverage.

**Test Coverage Verification (MANDATORY)**
Before handoff to review, verify:
- Backend test coverage > 80% on Library business logic
- Frontend Playwright test coverage for all routes
- All POM classes current with latest selectors
- All Gherkin scenarios runnable and passing
- No skipped or ignored tests without documented reason
- Cleanup without test verification is incomplete Step 18 coverage.

**Accessibility Verification (MANDATORY)**
Before handoff to review, verify:
- All interactive elements have `aria-label` or `aria-labelledby`
- All testable elements have `data-testid`
- Keyboard navigation works for entire application
- No accessibility warnings in build output
- Cleanup without accessibility verification is incomplete Step 18 coverage.

**Deployment Readiness (MANDATORY)**
Before handoff to review, verify:
- Health check endpoints exist and respond
- Environment-specific config properly externalized
- No secrets in source code
- Dockerfile builds and runs successfully
- OpenShift deployment manifests reference correct image/paths
- Cleanup without deployment verification is incomplete Step 18 coverage.
- Remove only obsolete sample business code, dead project references, and validated leftovers from earlier modernization locations.
- Keep protected starter shell files that now host the real app.
- Remove UI bridge wrappers only when the corresponding Fusion component family has already been verified and recorded as final state.
- Search for leftover placeholder `Starter` identity values and replace them only where they still refer to sample app content.
- Remove or explicitly retain stale portal aliases, dead selected-page tokens, retired step-surface names, and other outdated workflow references when they still point at obsolete modernization outputs.
- Run the narrowest build proof needed for the touched deployment or cleanup scope and record any intentional retained leftovers as explicit cleanup disposition.

**Cutover And Rollback Verification (MANDATORY)**
Step 18 MUST verify the cutover plan locked at Step 5 ``cutoverAndRollbackPlan`` is real and executable. Phase 2 cannot ship without it.
- Confirm the feature flag is named, owned, and switchable in the target environment.
- Confirm the rollback procedure is documented in the deployment notes with steps, owner, and max time-to-rollback.
- Execute a dry-run of the rollback against a non-prod environment and record the outcome under ``.modernization/portal/data/json/step18-rollback-dryrun.json`` with ``{ env, executedAt, durationSec, success, evidencePath }``.
- Promote ``environmentConfigPlan.environments[]`` values into the deployment config for QA and Prod. Secrets resolve from the planned secret store; raw secret values must not appear in any committed file.
- Generic across deployment targets (OpenShift, Kubernetes, App Service, IIS, ECS, on-prem). Adapt the verification to the target while preserving the gate.

**Performance And Bundle Verification (MANDATORY when browser-surface is in scope)**
Step 18 MUST verify ship-time perf and bundle sizes meet Step 5 ``performanceBudgetPlan``.
- Re-run the perf measurement against the deployed artifact (not just the dev build).
- Re-measure gzipped initial bundle and lazy chunks per route.
- Record results in ``.modernization/portal/data/json/step18-perf-verification.json`` and fail the step if any budget regresses without a recorded deferral.

Completion gate
- Return `Ready for Step 19 Final Fusion Restructure Review: Yes` only when the approved deployment-facing references are aligned, validated leftovers are removed or intentionally retained with rationale, stale portal or workflow aliases are cleaned up or explicitly retained, and no hidden cleanup drift remains for the touched scope.
- Otherwise keep the exact next step on `18-P2-deployment-and-clean-up`.
- In the numbered-step response, include explicit `deploymentReferenceStatus`, `cleanupDispositionStatus`, and `step19HandoffStatus` values.

## Step 18 DEV complete - next action

Step 18 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 18 QA will:** Verify deployment-facing references were updated and the cleanup disposition was recorded.
**Lanes:** Build verify, Deploy-config schema validation
**Expected ETA:** 3-5 min ET

Reply with the number of your choice:
1. `QA` - run `18-QA-deployment-and-clean-up` now (recommended).
2. `next` - continue to Step 19 (Phase 3 Review).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/18-QA-deployment-and-clean-up`.
