---
description: Step 19 specialist Fusion review gate that checks the final src state for starter-shell alignment, Fusion package usage, and remaining bridge validity before final verification.
agent: OpX-Fusion-Reviewer
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

# Step 19 Final Fusion Restructure Review

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 19 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 19 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 19 is the specialist Fusion review gate after modernization and cleanup. It must prove starter-shell alignment, Fusion package usage, and bridge disposition are review-grade for the exact current source state.
- Dev work: Review the current `src/` state against Fusion and starter-shell expectations, capture prioritized findings, and keep prerequisite drift explicit instead of reviewing stale evidence.
- QA plan: Use `[WORKFLOW] Final Fusion Restructure Review` as the focused validation gate for the current review artifact and handoff to Step 20.

Objective
- Execute Step 19 `Final Fusion Restructure Review` as the specialist Fusion review gate before final verification.
- Review the current `src/` state for Fusion package usage, starter-shell alignment, remaining temporary bridges, and safe remediation opportunities.
- Classify Step 19 completion explicitly with these statuses:
  - `fusionAlignmentStatus`: `Aligned`, `DriftDetected`, or `Blocked`
  - `bridgeDispositionStatus`: `Explicit`, `Partial`, or `Blocked`
  - `step20HandoffStatus`: `ReadyForFinalVerification`, `NotReadyForFinalVerification`, or `Blocked`
- Do not close Step 19 when the review artifact exists but still leaves starter-shell drift or remaining bridge status to inference.

Execution mode
- This prompt is operational, not advisory. Use the Fusion review rubric to produce review-grade findings against the current numbered-lane state.
- Reuse current Step 17 and Step 18 prerequisite proof when it still matches the reviewed source state.
- Do not close the step until the mapped QA workflow ran for the current review gate or the exact QA blocker was reported, the Step 19 review artifact was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`. Refresh the Step 19 review artifact and only the prerequisite evidence families that the current review actually invalidates.

Required behavior
- Read `/.github/skills/fusion-final-restructure-review/SKILL.md`, `.modernization/fusion-restructure/decisions.json`, `.modernization/fusion-restructure/control-point-inventory.json`, `.modernization/fusion-restructure/migration-plan.json`, and the current browser-surface artifacts when the app owns a browser surface.
- Before running the review, confirm current Step 19 verification proof and Step 20 cleanup disposition exist for the same source state under review. If either prerequisite is stale or missing, return `Blocked` with the exact prerequisite instead of reviewing against drift.
- Review Fusion package usage, starter-shell alignment, temporary-bridge validity, and places where documented Fusion packages or patterns should replace custom code.
- Use Fusion MCP package or docs discovery first, then compare against the current starter shell under `src/`.
- Return prioritized findings with explicit severity and identify safe remediation candidates.
- Preserve the review artifact for this pass at `.modernization/ignition-artifacts/reviews/final-fusion-restructure-review.json`.

Completion gate
- Return `Ready for Step 20 Final Verification: Yes` only when critical Fusion restructure review findings are resolved, explicitly accepted, or recorded as real blockers instead of being left implicit.
- Otherwise keep the exact next step on `<MOJIBAKE: emoji + keycap digits> Final Fusion Restructure Review`.
- In the numbered-step response, include explicit `fusionAlignmentStatus`, `bridgeDispositionStatus`, and `step22HandoffStatus` values.
