---
description: Step 13 shell-stabilization lane that repairs browser-shell drift after migration and platform integration without folding in broader UI replacement.
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

# Step 13 Frontend Shell Stabilization

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 10-25 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 13 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before stabilizing the browser shell: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 13 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change shell-owned files until the restore point is present.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 13 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** Stabilizes the app shell inside the Fusion theme after pages were moved - fixing layout, navigation, spacing, and styling drift so the running app is recognizably the legacy app.
- **Why it matters:** This is the last shell-level gate before UI planning. An empty nav, a missing landmark, or a hidden control left here gets baked into every later UI slice.
- **What you will have when it is done:**
  - A stabilized shell that renders its navigation and matches the visual contract.
  - `runtime-parity-checkpoint.json` - proof the shell nav renders every configured link and no control is hidden.
  - Responsive parity results across the configured breakpoints.
  - Refreshed shell guard tests aligned to the live shell.

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 13 OWNS the visual, layout, navigation, and responsive parity of the stabilized shell** - the last shell-level gate before UI planning. Palette, typography, header/nav/footer chrome, layout density, and breakpoint behavior matching the legacy answer key are settled here.
- **This step does NOT re-derive data.** Live-data parity is Step 12's authoritative verdict; control/column presence is Step 11's. Step 13 CONSUMES those verdicts. The field/control reconciliation below is a **regression guard** that confirms they still hold after shell stabilization - if Step 13 finds a dropped column or an unfilled grid, that is a **Step 11/12 regression** to route back to its owner and fix at the source, not new Step 13 work.
- **This step does NOT own:** the styling foundation itself (Step 10 - if the scheme/chrome/sizing regressed, fix it at the foundation and re-record `styling-foundation.json`), or Fusion primitive swaps (Steps 15-16). Step 13 stabilizes the shell as-is; it does not begin deliberate Fusion replacement.
- **This step CONSUMES:** the Step 10 foundation, the Step 11 control/column presence verdict, and the Step 12 live-data verdict.

**Desired completed state:** the running shell visually matches the legacy app - branded chrome, legacy palette/typography, correct layout density, nav rendering every route link, clean responsive behavior at every breakpoint - with `visual-parity-report.json overall: pass` and the Step 11/12 field+data verdicts confirmed un-regressed, so Step 14 can plan Fusion replacement over a shell that already resembles and works like legacy.

About To Do
- Context: Step 13 is the shell-level parity gate after platform integration. It must prove the shell is stable enough that Step 14 can inventory and plan deliberate UI replacement without rediscovering basic layout drift.
- Dev work: Repair the smallest real shell or layout root causes, keep shell guard coverage aligned to the live shell, and rerun focused proof until the shell state is trustworthy or blocked.
- QA plan: Use `[WORKFLOW] Frontend Shell Stabilization` inside the active Step 13 loop at meaningful checkpoints and at closeout to confirm shell parity, layout trustworthiness, and guard-test freshness before UI planning proceeds.

Objective
- Execute Step 13 `Frontend Shell Stabilization` as the shell-level parity and usability gate after platform integration landed.
- Stabilize the migrated browser surface inside the protected starter shell before UI inventory generation and deliberate primitive-family replacement continue.
- Classify Step 13 completion explicitly with these statuses:
  - `shellParityStatus`: `Stable`, `Drifting`, or `Blocked`
  - `shellGuardStatus`: `Aligned`, `Stale`, or `Blocked`
  - `fieldParityStatus`: `Reconciled`, `Drifting`, or `Blocked`
  - `step14HandoffStatus`: `ReadyForUIPlanning`, `NotReadyForUIPlanning`, or `Blocked`
- Do not report Step 13 complete when the shell looks better but guard tests still point at deleted starter surfaces, when layout drift is only partially understood, or when the shell is not yet trustworthy enough for Step 14 planning work.

Execution mode
- This prompt is operational, not advisory. Verify the shell and layout contract, repair the smallest real root cause for each drift item, and rerun focused proof until the shell state is trustworthy or blocked.
- Treat the mapped QA workflow as the Step 13 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the portal was refreshed, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json` before evaluating parity drift.
- Verify style entry points, include paths, import order, assets, fonts, icons, and static files still match the approved parity foundation.
- Verify every framework class hook used in modern templates (for example Bootstrap `nav-tabs`, `panel`, `dropdown`, `btn-*`, `col-*`, grid utilities, or any third-party CSS toolkit class carried over from the legacy DOM) resolves to a CSS rule actually loaded in the shell. Unbacked class hooks render as bare DOM (bullet lists where tabs are expected, always-open dropdowns, stacked blocks where grid columns are expected) and silently defeat visual parity. For each unbacked hook, either load the source stylesheet, port the minimal rules into the component or shared styles, or replace the class hook with native styling, then rerun the shell proof.

**Shell Accessibility (MANDATORY)**
All shell elements MUST have:
- Semantic landmarks: `<header>`, `<nav>`, `<main>`, `<footer>`, `<aside>`
- Skip-to-content link as first focusable element
- ARIA labels on all navigation elements and menus
- `data-testid` attributes on shell components for Playwright
- Keyboard navigation working for entire shell
- Focus trap management for any overlays/modals
- The `<nav>` landmark MUST render every link declared in the route menu metadata, and each link MUST navigate. A present-but-empty `<nav>` landmark (the element and its test id exist but no links render) passes the landmark check yet is a navigation parity defect and is incomplete Step 13 coverage.
- Shell without proper landmarks and testids is incomplete Step 13 coverage.

**Shell Guard Tests (MANDATORY)**
- Step 13 must maintain:
  - Playwright tests for shell rendering and navigation
  - POM classes for shell components (header, nav, sidebar, footer)
  - Gherkin scenarios for shell navigation flows
  - Visual regression baseline for shell layout
- Shell guards without Playwright coverage are incomplete Step 13 coverage.
- Refresh or repair the cheapest shell guard tests when they still target deleted starter components, stale routes, or old service seams. Keep at least one focused shell-level guard aligned to the live shell so later refreshes catch drift before broader parity reruns.
- Verify shell and layout behavior still matches the preserved visual contract closely enough for parity:
  - header, nav, sidebar, and footer positioning
  - page max-width, padding, and landmark spacing
  - control heights, button density, modal sizing, table and grid density
  - breakpoint behavior and container width rules
  - shell overlap, z-index, and host or body class compatibility
- For each failing item, identify the exact file, selector, template seam, or config seam causing the problem, apply the minimal parity-preserving fix, rerun the relevant build or smoke proof, and record the fix in the numbered-step evidence.
- Temporary UI bridge wrappers are allowed when still needed for parity, but keep them explicit in `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json` and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`.
- Do not perform broad primitive-family replacement in this step.

Response contract
- Start with `About To Do` and keep the three bullets in the required order: `Context`, `Dev work`, and `QA after`.
- In the numbered-step response, add a `Shell Parity Snapshot` section before `Returned Data`. Use the newest trustworthy quantitative shell artifact. When no newer shell-specific quantitative artifact exists, reuse the current Step 12 runtime comparison artifact and state that it remains the active shell baseline.
- In `Shell Parity Snapshot`, report the current gate-bearing numbers that matter to shell trust, including:
  - `Screenshot coverage: <capturedModernCounterpartCount> of <requiredLegacyScreenshotCount> (<screenshotCoveragePercent>%)` when the current shell baseline still comes from Step 12 runtime comparison evidence
  - `Visual parity: <currentVisualParityPercent>% (<currentVisualParityBand>)`
  - `Inventory parity: <currentInventoryParityPercent>% weighted`
  - `Selector contract coverage: <selectorContractCoveragePercent>% weighted`
  - `Shell parity status: <shellParityStatus>`
  - `Shell guard status: <shellGuardStatus>`
- Add a `Suggestions` section immediately after `Shell Parity Snapshot`. Return 1 to 3 concrete next actions that name the exact drift item, stale guard, freshness mismatch, or sign-off follow-up still worth doing.
- If `frontend-parity-status.generated.json`, route summaries, and the newer runtime comparison artifact disagree, use the newer gate-bearing numbers in chat, call out the stale artifact as freshness drift, and keep the step decision anchored to the reconciled evidence.
- In `Returned Data`, include at least:
  - `shellParityStatus`
  - `shellGuardStatus`
  - `step14HandoffStatus`
  - `quantitativeParityArtifactPath`
  - `screenshotCoveragePercent`
  - `currentVisualParityPercent`
  - `currentVisualParityBand`
  - `currentInventoryParityPercent`
  - `selectorContractCoveragePercent`
  - `fieldParityStatus`
  - `routesBelowFieldParity`
  - `topShellSuggestions`

Runtime Parity Checkpoint (required before closeout)
- Before closing Step 13, run the running-app checkpoint from `/.github/skills/runtime-parity-checkpoint/SKILL.md` and save `.modernization/fusion-restructure/runtime-parity-checkpoint.json`.
- Open the stabilized shell in the integrated browser and prove the nav renders every configured route link and each link navigates, the header/footer/landmarks render, and no inventoried control is missing or hidden. Watch the integrated-browser DevTools console for component/runtime errors (Angular template errors, unhandled promise rejections, failed XHR) and the backend log for `4xx`/`5xx`; any unexplained error is a Step 13 failure and must be fixed before closeout.
- This is the last shell-level gate before UI planning, so an empty nav, a missing landmark, or a hidden control found here must be fixed now, not deferred to Step 14 or later.

Visual Parity Gate (required before closeout)
- Functional runtime parity proves the shell works; the visual-parity gate proves the shell looks like the legacy app. Both must pass before Step 14 begins the Fusion map-and-swap block.
- Run the gate from `/.github/skills/visual-parity-gate/SKILL.md` and save `.modernization/fusion-restructure/visual-parity-report.json`. The gate composes the runtime-parity-checkpoint and screenshot-capture skills, boots the modern app (and the legacy app on a second port when it is runnable), captures matching routes, and diffs computed styles plus screenshots against the legacy answer key in `.modernization/fusion-restructure/ui-visual-contract.json` and `styling-foundation.json`.
- Score each route `pass`, `partial`, or `fail` across palette, typography, header/nav/footer presence, the nav route model, and layout density. A raw default framework theme, an empty nav, or missing header/footer chrome is a `fail`.
- `overall` is `pass` only when every route is `pass`, or every non-`pass` route is recorded in `acceptedResidualGaps[]` with a real reason and owner. Do not silently downgrade a `fail` route to an accepted gap.

Field & Control Parity Reconciliation Gate (required before closeout)
- Visual parity proves the shell **looks** like legacy; this field-parity check is a **regression guard** confirming the Step 11 (control/column presence) and Step 12 (live data) verdicts still hold after shell stabilization - Step 13 does not re-derive them from scratch. A route can pass palette/typography/chrome while a grid silently dropped columns (real data shown in fewer or more generic columns) or a control renders with a stubbed handler; if that appears here it is a **Step 11/12 regression** to fix at the source. Both the visual gate and this regression guard must be clean before Step 14.
- For every in-scope route, reconcile the modern rendered surface against the legacy answer key:
  - the route's data grids/tables/lists render **every** column/field the legacy route showed (header label and bound field); a grid that shows real data collapsed into fewer or generic columns is a field-parity `fail`, not a pass.
  - every legacy filter input and action control is present AND wired to a real handler (event binding to a component method, route, or service call) - a control whose handler is empty, a `TODO`, or permanently `disabled` without an owner is an inert control and counts as missing.
- Derive the legacy answer key from the per-route inventory; when the inventory lacks column/field grain, extract it directly from the legacy route source. Prefer a **side-by-side** comparison in the integrated browser: boot the modern app and the runnable legacy app (`LegacyCode_NETXX_Upgrade` when the original `LegacyCode/` host is not runnable) on separate ports and compare each route column-for-column and control-for-control.
- Record the result through the runtime-parity-checkpoint `fieldParity` roll-up and `columnsMissing[]` / `inertControls[]` per route. `fieldParity = pass` only when no route has a dropped column or inert control without an explicit, owned waiver.

Completion gate
- Return `Ready for Step 14 Frontend UI Inventory & Fusion Map: Yes` only when shell-level parity is stable enough that later UI-planning and primitive-family work does not have to rediscover unresolved shell drift, the focused shell guard tests are aligned to the live shell, and the visual-parity gate reached `overall: pass` (or every residual gap is explicitly accepted with reasons).
- Binary completion gates (each must be `pass` or carry an explicit, owned waiver):
  - shell builds and the stabilized routes render in the integrated browser
  - runtime checkpoint `navParity = pass` - the nav renders every configured route link and each navigates
  - no inventoried control is missing or hidden behind an unwired flag at runtime
  - responsive breakpoint gate has no `fail` rows
  - visual-parity gate `overall = pass` - `visual-parity-report.json` shows palette, typography, header/nav/footer presence, and layout meeting the legacy contract, or every residual gap explicitly accepted
  - field-parity reconciliation `fieldParity = pass` - no in-scope route has a dropped/collapsed grid column or an inert (stubbed-handler) control versus the legacy answer key, or each gap is an explicit, owned waiver
  - `filterEffectParity = pass` - every filter/search control on every route changes the visible row set when applied (no filter returns identical rows before and after; a filter that does nothing is a `filterEffect: fail` regardless of whether the API call returns 200)
  - `siblingListDistinctnessOverall = pass` - every route with multiple sibling list sections (tabs/accordions each backed by separate data calls) shows distinct first-row content across sections (two sections with identical rows indicate a wrong discriminator or shared endpoint bug)
- If any binary gate fails, do not advance. Fix the shell here.

If You Hit A Blocker (finish this step, do not drift)
- Step 13 is the last shell gate before UI planning, so a broken nav or hidden control found here cannot be pushed to Step 14 or later.
- Name the exact failing item, the most likely cause in plain language, and the concrete fix to finish Step 13. Apply the smallest in-scope fix and re-run the checkpoint before reporting `Blocked`.
- Otherwise keep the exact next step on `Step 13 Frontend Shell Stabilization`.
- In the numbered-step response, include explicit `shellParityStatus`, `shellGuardStatus`, `fieldParityStatus`, and `step14HandoffStatus` values.

Responsive Breakpoint Parity Gate (MANDATORY)
- Capture the modern shell and every Step 15 stabilized route at three viewport widths: 375 (mobile), 768 (tablet), 1440 (desktop). The breakpoint set is loaded from ``/.modernization/fusion-restructure/responsive-breakpoints.json`` when present; otherwise the 375/768/1440 default applies.
- For each route x breakpoint pair, perform visual parity against the corresponding legacy capture and emit ``/.modernization/fusion-restructure/responsive-parity/<routeId>.json`` with ``breakpointPx``, ``legacyScreenshotPath``, ``modernScreenshotPath``, ``pixelDiffPercent``, ``layoutShifts[]``, ``overflowEvents[]``, ``horizontalScrollDetected``, ``parityState`` (``pass``, ``warn``, ``fail``).
- ``fail`` at any breakpoint blocks Step 15 closeout. ``warn`` requires either remediation or a documented variance row in the Step 15 stabilization report.
- Generic across MVC, Razor Pages, Web Forms, AngularJS, Angular, React, Vue, Blazor, and server-rendered HTML. Breakpoints used by the legacy app are reverse-engineered from ``componentCensus`` media-query evidence and may add to (not replace) the default trio.

## Step 13 DEV complete - next action

Step 13 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 13 QA will:** Verify shell-level routing, layout, navigation, and error/loading states after stabilization.
**Lanes:** Browser-contract regression, Navigation smoke
**Expected ETA:** 3-5 min ET

Reply with the number of your choice:
1. `QA` - run `13-QA-frontend-shell-stabilization` now (recommended).
2. `next` - continue to Step 14 DEV (Frontend UI Inventory & Fusion Map).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/13-QA-frontend-shell-stabilization`.

## Self-Audit Checklist (MANDATORY)

Before emitting the Step 13 closeout, the executing agent MUST include a `Step 13 Self-Audit` block in the chat reply attesting per-item to every checklist row below. For each row reply with one of:

- `YES` and a one-line evidence pointer (file path, test id, command output line, or artifact field).
- `NO` and an explicit deferral rationale plus a Step 14 carry-forward entry recorded in the closeout.
- `N/A` and a one-line rationale why the item does not apply to the current app shape.

Checklist:

1. Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `control-point-inventory.json`, `styling-foundation.json`, and `ui-visual-contract.json` in the current pass.
2. Style entry points, include paths, assets, fonts, icons, and static files verified against the approved parity foundation.
3. Framework class hooks (Bootstrap, FontAwesome, third-party) used in modern templates audited for resolution; unbacked hooks resolved or recorded as deferred drift items.
4. Shell accessibility audited: semantic landmarks (`<header>`, `<nav>`, `<main>`, `<footer>`, `<aside>`), skip-to-content link as first focusable element, ARIA labels, keyboard navigation, focus trap on overlays, and the `<nav>` landmark actually renders every configured route link at runtime (not an empty landmark).
5. Shell selectors extracted to a Page Object Model under `tests/frontend/e2e/pageObjects/shell/` and consumed by the shell journey spec.
6. Gherkin scenarios (Feature / Scenario / Given-When-Then) documented for every shell guard test, embedded inline in the spec or in a sibling feature file.
7. Shell-scoped visual regression baseline captured under `tests/frontend/e2e/journeys/*.ts-snapshots/` (or sibling snapshot folder) and committed.
8. Layout / breakpoint / z-index / density audited against the visual contract; each drift item resolved or recorded with file + selector + Step 17 carry-forward.
9. Temporary UI bridges (transitional CSS, retained legacy classes, wrapper components) classified explicitly in `.modernization/fusion-restructure/ui-fusion-map.json` and `.modernization/fusion-restructure/control-point-inventory.json` with retirementStep.

Agent Contract Rule (HARD GATE):

- `step16HandoffStatus: ReadyForUIPlanning` is INVALID when any checklist row is `NO` without (a) a documented deferral rationale and (b) an explicit Step 16 carry-forward entry inside the closeout `topShellSuggestions` array.
- If any checklist row is `NO` without those two artifacts, the agent MUST downgrade `step16HandoffStatus` to `NotReadyForUIPlanning` and keep the exact next step on `Step 13 Frontend Shell Stabilization`.
- The closeout response MUST include the literal `Step 15 Self-Audit` heading followed by the checklist attestations. A closeout without this block is treated as a skipped Step 15 and must be re-run.
