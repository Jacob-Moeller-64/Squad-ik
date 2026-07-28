---
description: Step 21 visual review gate that compares the modern UI against the approved Figma direction and records remaining drift by screen or route.
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
  - figma/*
  - fusion/copilot-docs/*
---

# FIGMA REVIEW

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 10-20 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 21 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 21 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 21 is the visual review gate, but it only counts when the reviewed UI scope is both visually aligned and functionally complete enough for review.
- Dev work: Compare the current UI against the approved visual direction and parity evidence, keep critical visible-but-unwired controls explicit, and record a durable review artifact for the exact reviewed scope.
- QA plan: Use `[WORKFLOW] Figma Review` as the focused validation gate for the current visual-review artifact and handoff to Step 22.

Objective
- Execute Step 21 `Figma Review` as the required browser-led review gate before final acceptance review, or as a lightweight proof pass when the app has no managed browser surface.
- Compare the current modern UI against the approved Figma stylesheet, visual direction, icons, and the latest parity screenshot evidence.
- Preserve validated feature coverage, route coverage, and required acceptance behavior while correcting remaining visual drift.
- Produce a durable visual-review artifact at `.modernization/artifacts/reviews/figma-review.json` that names reviewed screens or routes, screenshot evidence, unresolved drift by severity, or the explicit `NotApplicable` reason, plus a clear Pass, Blocked, or Fail decision.
- Classify Step 23 completion explicitly with these statuses:
  - `visualReviewStatus`: `Aligned`, `DriftOpen`, or `NotApplicable`
  - `criticalControlStatus`: `Clear`, `Blocked`, or `NotApplicable`
  - `step22HandoffStatus`: `ReadyForAcceptance`, `NotReadyForAcceptance`, or `Blocked`
- Do not treat Step 21 as complete when the screenshots look acceptable but the reviewed scope still contains critical visible-but-unwired controls or unresolved drift that materially affects acceptance.

Operator focus
- Keep the numbered-step response tight: reviewed scope, review decision, top blockers or approved not-applicable reason, refreshed artifact status, and the three Step 23 status fields.
- Keep route-by-route screenshot comparisons, drift-by-severity detail, and reviewed-screen evidence in `.modernization/artifacts/reviews/figma-review.json` instead of replaying them in chat.

Execution mode
- This prompt is operational, not advisory. Execute the Step 21 visual review gate against the currently verified application state and the current parity evidence.
- Do not treat Step 21 as a cosmetic-only pass. It is blocked when critical feature completeness is still missing even if the screenshots look good.
- Reuse current Step 20 verification proof and working-versus-visible interaction inventory when they still match the reviewed source state. Refresh the Step 21 visual-review artifact and only the prerequisite evidence families that the current review actually invalidates.
- Do not close the step until the mapped QA workflow ran for the current review gate or the exact QA blocker was reported, the Step 21 visual-review artifact was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json` and `.modernization/portal/data/json/step-workflow-state.json`, and the saved entries were read back with populated `status`, `updatedAt`, and `latestFullResponse` values.

Review core
- Read `.modernization/fusion-restructure/decisions.json` first and resolve `browserSurfaceApplicability` before making a Step 23 decision.
- Before visual review starts, confirm current Step 20 final verification evidence exists for this pass and that the working-versus-visible interaction inventory is current enough for the reviewed routes. If either prerequisite is stale or missing, return `Blocked` with the exact prerequisite instead of reviewing against drift.
- When `browserSurfaceApplicability` is `NotApplicable`, do not force a browser screenshot or Figma comparison pass. Record the explicit not-applicable reason in `.modernization/artifacts/reviews/figma-review.json`, confirm no managed browser-surface visual-contract obligation remains hidden in the final review state, and return a truthful lightweight proof decision for Step 24.
- Treat unresolved critical visible-but-unwired controls as Step 23 blockers by default.
- Critical visible-but-unwired controls include primary workflows, data-changing controls, exports, print actions, and secondary admin controls unless the evidence pack records an explicit approved defer reason.
- When Step 21 is blocked by an unresolved control, return the exact route or screen, the exact blocked control, why it is critical, and the clearest remediation path.

Artifact contract
- `.modernization/artifacts/reviews/figma-review.json` is the exhaustive Step 23 proof artifact for reviewed screens or routes, screenshot evidence, unresolved drift by severity, approved defer reasons, and explicit `NotApplicable` rationale when applicable.

Closure contract
- Return `Pass` only when either the reviewed browser scope is visually aligned enough for review and there are zero unresolved critical visible-but-unwired controls in that same reviewed scope, or `browserSurfaceApplicability` is `NotApplicable` and the explicit lightweight-proof reason was recorded truthfully.
- Return `Blocked` when visual drift or missing critical control wiring still prevents truthful review completion.
- In the numbered-step response, keep the summary tight and include explicit `visualReviewStatus`, `criticalControlStatus`, and `step24HandoffStatus` values.
