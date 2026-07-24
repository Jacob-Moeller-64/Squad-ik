---
description: Step 11 browser migration lane that moves shared client code and route families into the approved target browser root while preserving the current visual contract.
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

# Step 11 Frontend Migration

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 20-45 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 11 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Content reconciliation before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/Invoke-StepReconciliation.ps1 -Step 11`. This proves every `LegacyRoute` in `per-route-behavior-plan.json` actually appears in the Step 3 Legacy analysis (a shape check cannot catch a behavior plan that invents a route that never existed in the legacy app), follow the `Fix:` line printed for each route - confirm the legacy route and re-run Step 3 if it is real, or correct the plan via Step 6 if it is wrong - then re-run the reconciliation.
> - Restore-point precheck before moving shared client code or route families: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 11 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not move files until the restore point is present.
> - Scaffold-debt scan before closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-scaffold-debt.ps1 -CurrentStep 11 -Quiet`. This flags surviving scaffold-debt markers ("Step N wires this", placeholder bodies) whose owning step has been reached. Exit 2 means overdue markers survive: finish the announced behavior against the legacy answer key and remove the now-stale marker, or accept a genuinely-intentional note in the scaffold-debt registry. The output verify below fails while overdue markers remain.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 11 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** Moves the real legacy pages and shared client code into the destination app, one route family at a time, keeping each page's controls, layout, and behavior intact.
- **Why it matters:** This is where features are preserved or lost. A page re-created from memory drops buttons, row actions, popovers, and admin-gated controls; moving the real component keeps them. Missing features here are felt by every user.
- **What you will have when it is done:**
  - Migrated route families and shared code in the target client root.
  - `runtime-parity-checkpoint.json` - proof each migrated route renders its controls (visible, not hidden) and loads real data.
  - A refreshed `ui-parity-gap-scan.json` showing missing-control gaps trending to zero.
  - `perRouteBehaviorList` - any per-route behavior explicitly deferred with an owner step.

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 11 OWNS that every legacy page is moved in with its controls, columns, and fields present, visible, and behaving, and every data call site wired to its real service.** Page structure and control/field presence are settled here.
- **This step does NOT own the authoritative live-data verdict.** Proving each route returns real data under real auth - and that parameterized/detail routes load a real record with no `4xx`/`5xx` route-contract error - is **Step 12's single authoritative data gate**. In Step 11 a route's data may render provisionally (dev session, partial auth) or stay a wired-but-empty grid; a call site wired to the real service is enough here. A shipped placeholder/fixture/hard-coded sample as the *final* state is not.
- **This step does NOT own:** the styling foundation (Step 10), auth ownership (Step 12), visual/layout polish (Step 13), or Fusion swaps (Steps 15-16).
- **This step CONSUMES:** the Step 10 styling foundation. Run `scan-styling-foundation.ps1` as an entry check; if the foundation regressed, report it back to Step 10 and fix it there, do not re-author styling per page.

**Desired completed state:** every in-scope route is reachable and renders its full legacy control/column/field set - no dropped columns, no inert handlers, nothing hidden behind an unwired flag - with each data call wired to its real service, so Step 12 can prove live data under auth without rediscovering missing controls.

About To Do
- Context: Step 11 is the route-family move lane after the Step 10 shell is real. It must prove the current migrated slice is genuinely in the target browser root and that the remaining gaps belong to platform integration rather than unfinished moves.
- Dev work: Move shared client code and route families in dependency order, preserve the shell contract, and stop only when the current migration checkpoint is real or blocked.
- QA plan: Use `[WORKFLOW] Frontend Migration` inside the active Step 11 loop at meaningful checkpoints and at closeout to confirm the migrated route family is buildable, parity-safe, and truly ready for Step 12.

Objective
- Execute Step 11 `Frontend Migration` as the route-family move lane after Step 10 formed the browser shell.
- Move shared client code, page slices, and route families into the Step 7-approved target root without folding platform integration, shell stabilization, or deliberate Fusion UI replacement back into the same step.
- Classify Step 11 completion explicitly with these statuses:
  - `sharedCodeMigrationStatus`: `Validated`, `Partial`, or `Blocked`
  - `routeFamilyStatus`: `Validated`, `Partial`, or `Blocked`
  - `behaviorPreservationStatus`: `Preserved`, `PartialPerRouteList`, or `Blocked`
  - `step12HandoffStatus`: `ReadyForPlatformIntegration`, `NotReadyForPlatformIntegration`, or `Blocked`
- Do not report Step 11 complete by feel when core shared client seams are still split across old and new roots, when migrated route families are not the slices actually being built, when migrated routes render but their legacy click handlers, modal triggers, banners, or data-binding seams were not ported (page renders is not the same as page works), or when remaining issues still belong to unfinished file moves.

Execution mode
- This prompt is operational, not advisory. Continue through the highest-value eligible shared-code and route-family migration work until the current migration checkpoint is real, a blocker is reached, or the remaining gaps clearly belong to Step 12 or later.
- Treat the mapped QA workflow as the Step 11 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required modality posture
- Use the Step 7 modality and `browserSurfaceApplicability` decision instead of assuming Angular-only migration.
- When `browserSurfaceApplicability` is `Required`, execute the full migration lane.
- When `browserSurfaceApplicability` is `NotApplicable`, execute a lightweight proof pass that confirms no managed browser migration is owed and return a quick completion decision without republishing the portal.

Required behavior
- Read `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json` before moving client code.
- Verify the Step 10 foundation is still trustworthy before moving deeper browser behavior.
- Default to moving the real legacy component as the starting point, not re-creating a thinner version from scratch. Port the legacy page's template, styles, and component logic into the destination and get it building with the legacy markup and framework classes intact. Parity is the starting state you preserve, not a percentage you climb toward. A page rebuilt from memory that drops controls, row actions, popovers, or admin-gated buttons is a parity defect even when it compiles and looks close.
- Step 11 is a move-and-preserve lane, not a Fusion conversion lane. Deliberate, systematic primitive-family replacement - swapping every button, dropdown, textbox, grid, or dialog of a kind across one or more routes - belongs to Step 14 planning and Step 15/16 execution, never Step 11. An opportunistic single-control swap is allowed only when it is incidental to moving that one control AND the swapped control reaches legacy visual parity (variant, size, width, spacing, and layout) in the same pass. A control that cannot reach visual parity in the same pass must stay as legacy markup and be deferred with an owned `perRouteBehaviorList` entry whose `ownerStepIfDeferred` is Step 14 or later. Never leave a half-configured Fusion control behind in Step 11: a `fusion-*` primitive that renders with the wrong variant, color, or field width is a parity defect, not progress.
- Move shared browser code before page slices when the source app requires it:
  - models, interfaces, enums, and explicit view-model shapes
  - shared services, guards, interceptors, resolvers, and utility seams
  - shared layout and reusable components that route families depend on
- Migrate route families and page slices in dependency order:
  - move one route family or tightly coupled page slice at a time
  - wire routes into the approved browser route tree
  - update imports and DI ownership to match the Step 7 contract
  - run the real client build after each meaningful slice
  - preserve selectors, DOM or class hooks, and sizing behavior needed by the visual contract
  - verify framework class hooks copied from the legacy template (for example Bootstrap `nav-tabs`, `panel`, `dropdown`, `btn-*`, `col-*`, grid utilities, or any third-party CSS toolkit class) are actually backed by a stylesheet loaded in the modern shell. When the matching rules are not in scope, either load the source stylesheet, port the minimal rules into the component or shared styles, or replace the class hooks with native styling instead of shipping bare DOM that renders as unstyled lists or stacked blocks.
- Preserve per-route behavior, not just DOM. For every migrated route, use the Step 6 per-route behavior plan (or the Step 5 inventory when Step 6 has not enumerated the route yet) as the explicit checklist. For each interactive element on the route, the migration pass must port it to a real component method, route guard, or service call, or explicitly classify it as a Step 12 platform-integration item or a deliberate later-step item. The following per-route hand-offs are forbidden and must be fixed in this step or named as explicit blockers:
  - `javascript:void(0)`, `href="#"`, `onclick="return false"`, or any legacy inline-script handler surviving on a migrated control instead of an Angular `(click)`, `routerLink`, or component event binding
  - legacy modal, dialog, banner, toast, or confirmation triggers (for example authorization or "authorized users only" banners, unsaved-changes guards, error overlays, success toasts) that have no modern trigger wired in the migrated route
  - data-bound controls (grids, tables, dropdowns, summary cards, charts) that render placeholder, seed, hard-coded, or fixture data instead of the migrated service call site, when the Step 5 inventory shows the legacy route had a real backing call
  - a data grid, table, or list that renders **real** data but in **fewer or more generic columns/fields than the legacy route showed** (column collapse) - for example several typed legacy columns folded into one generic `details` column, or a typed grid reduced to an id/name pair. Every legacy column/field is part of the parity contract; a dropped or collapsed column is a parity defect even though the grid loads real rows, and must be restored or recorded as an owned `perRouteBehaviorList` entry.
  - export, print, download, upload, copy-to-clipboard, or file-drop controls that exist visually on the migrated route but call no service method
  - keyboard shortcuts, focus traps, and navigation behaviors named in the Step 5 inventory that no longer fire on the migrated route
- Each unresolved per-route hand-off must appear in `Returned Data.perRouteBehaviorList` with `{route, interactiveElement, dispositionInStep11, ownerStepIfDeferred}` and the matching `behaviorPreservationStatus` must be `PartialPerRouteList` or `Blocked`, never `Preserved`.
- Keep platform integration, shell stabilization, UI inventory generation, and deliberate primitive-family replacement explicit for later numbered steps instead of hiding them here.
- In the numbered-step response, add a `Modernization Added` section immediately before `Returned Data` and enumerate the exact routes, views, components, services, selectors, or tests moved or materially expanded during the pass.
- In `Returned Data`, include explicit `sharedCodeMigrationStatus`, `routeFamilyStatus`, `behaviorPreservationStatus`, and `perRouteBehaviorList` (may be empty when `behaviorPreservationStatus` is `Preserved`), and `step12HandoffStatus` values.

Runtime Parity Checkpoint (required before closeout)
- "Page renders" is not "page works," and "control exists in the template" is not "control is visible." Before closing Step 11, run the running-app checkpoint from `/.github/skills/runtime-parity-checkpoint/SKILL.md` and save `.modernization/fusion-restructure/runtime-parity-checkpoint.json`.
- For each migrated route, open it in the integrated browser and prove every inventoried control is present AND visible. A control hidden behind an unwired role or feature flag (for example an admin button gated by a placeholder `isAdmin` that is never set) counts as missing, not present. Record each such control in `controlsHiddenBehindFlag` and either wire it now or record an explicit, owned waiver.
- Prove primary data calls fire and render real rows where reachable in the current dev session; watch the integrated-browser console for component/runtime errors and the backend log for `4xx`/`5xx`. (Attaching the approved auth and proving the authoritative success status across every route is **Step 12's** gate, not settled here.)
- **Provisional data render here; Step 12 owns the authoritative live-data verdict.** Step 11 proves each route's primary call site is wired to the real service and, where it renders in the current dev session, shows real rows - not a shipped placeholder, fixture, or hard-coded sample. Step 11 does NOT have to authenticate every route and prove live data end-to-end across the app; that is **Step 12's single authoritative data gate**. A wired-but-empty grid is acceptable provisionally; a placeholder shipped as the *final* state is a migration defect. Do not mark a route "done" on a build, a scanner `majorGaps=0`, or an HTTP 200 alone - those are proxies, and the authoritative auth + proof happens at Step 12.
- **Wire and reach parameterized/detail routes; never silently drop them.** Make every path-parameter route (for example `filekeys/log/:keyNo/:changeNo`) reachable from its parent grid and wire its data call to the real service. Step 12 then proves the authoritative real-record load under auth and is the gate of record that catches a `404` (the client calls a path-parameter endpoint the backend never registered - it exposed only a query-string GET) or a `4xx`/`5xx` when the backing query faults. If you can already see such a route-contract gap here, flag it; but the authoritative route-contract proof is Step 12's UI→API wiring gate, not a Step 11 closeout blocker.
- **Guard redirect target audit:** For every `canActivate` guard that specifies a denial redirect path (for example `FusionRoleGuard(GROUPS, 'access-denied')`), confirm that redirect path is a declared route. A guard that redirects to an undeclared path silently falls through to the wildcard route - typically the app home - hiding the access-denied condition entirely. This is a routing integrity defect that belongs to this step, not Step 12. Fix it by declaring a minimal denial route, or change the redirect target to a route that already exists. Record any accepted gap in `waivers[]`.
- Cross-check the deterministic UI Control Parity scanner: when `unmappedInteractiveControlCount > 0`, the named controls (for example a missing "+ Add Row" or export action) are migration work for this step, not a later cosmetic pass. The same scanner also reports `unmappedColumnCount` (MissingColumn Major: a grid that renders real data in fewer or more generic columns than legacy) and `inertControlCount` (InertControl Major: a control present but wired to an empty/TODO handler or a literal `[disabled]="true"`). Treat each as migration work for this step - restore the dropped columns and wire the dead handler, or record an owned `perRouteBehaviorList` waiver. These Major kinds also fail the `majorGaps = 0` binary gate below.
- Read `deferredInertControlCount` alongside `majorGaps`. A stubbed handler may be suppressed from the Major count only by an explicit entry in the deferral registry `.modernization/ignition-artifacts/discovery/ui-deferral-registry.json` (`{ handler, ownerStep, reason }`), and the scanner still lists it in `deferredInertControls[]`. `majorGaps = 0` with a nonzero `deferredInertControlCount` means behavior is PARKED, not done: every parked handler must have a truthful `ownerStep` whose completion gate actually verifies that behavior (a dead export/add/delete button belongs to Step 12 "no button is dead", not a vague "later"), and a matching `perRouteBehaviorList` entry. A deferral with no truthful `ownerStep`, or pointed at a step that does not own that behavior, is a Step 11 defect, not a valid waiver.

Completion gate
- Return `Ready for Step 12 Frontend Platform Integration: Yes` only when the migrated shared code and route families build in the approved target root, the Step 10 shell contract still holds, `behaviorPreservationStatus` is `Preserved` or every per-route hand-off in `perRouteBehaviorList` is explicitly classified with an owner step that is Step 12 or later AND is registered in the deferral registry with a truthful `ownerStep` whose gate verifies that behavior, and the remaining gaps truthfully belong to client platform ownership rather than unfinished file moves or dropped per-route behavior.
- Binary completion gates (each must be `pass` or carry an explicit, owned waiver):
  - migrated shared code and route families build in the target root
  - UI Control Parity scanner `majorGaps = 0` (no missing interactive control), or each remaining gap is a named, owned waiver
  - runtime checkpoint `controlVisibilityParity = pass` (no inventoried control missing or hidden behind an unwired flag)
  - runtime checkpoint `fieldParity = pass` (every legacy grid column/field is rendered - no column collapse - and no control is inert behind a stubbed/empty/`TODO` handler)
  - runtime checkpoint `dataBindingParity = pass (provisional)` - every route's primary call is wired to the real service and renders real dev-session rows where reachable, with no placeholder/fixture/hard-coded sample shipped as the final state; the **authoritative** live-data-under-auth verdict (including parameterized/detail routes and `4xx`/`5xx` route-contract errors) is owned by Step 12, not settled here
- If any binary gate fails, do not advance. The missing or hidden controls are this step's work.

If You Hit A Blocker (finish this step, do not drift)
- Advancing a route that looks done but is missing controls or data poisons Steps 12-16, so finish the move here.
- Name the exact failing control or data call, the most likely cause in plain language, the concrete fix to finish Step 11, and whether the gap belongs upstream in the Step 6 per-route behavior plan. Apply the smallest in-scope fix and re-run the checkpoint before reporting `Blocked`.
- Otherwise keep the exact next step on `Step 11 Frontend Migration`.

Dead-Code Trace Gate (MANDATORY)
- Before Step 11 closeout, every modern source file added or migrated in this pass must trace to at least one of: an active route entry, a referenced module/component declared in `migration-plan.json`, or an explicit `keepReason` row in `migration-plan.json` with evidence.
- Run a static reachability sweep from the modern router/composition roots (Angular `Routes`, React `createBrowserRouter`, Vue `createRouter`, Blazor `Router`, MVC route table, Razor Pages folder roots) and emit `.modernization/ignition-artifacts/modernize/fusion-restructure/dead-code-trace.json` listing every modern source file with `filePath`, `reachableFromRoot` (`true`/`false`), `rootChain[]` (entry -> intermediate refs), and `keepReason?` when present.
- `reachableFromRoot: false` with no `keepReason` blocks Step 11 closeout. The fix is to either wire the file in, document a `keepReason` (with reviewer-approved evidence), or delete it.
- Generic across MVC, Razor Pages, AngularJS, Angular, React, Vue, Blazor, and server-rendered HTML. Root discovery is data-driven from the framework declared in `componentCensus`.

## Step 11 DEV complete - next action

Step 11 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 11 QA will:** Verify migrated route families render and match the captured legacy visual contract.
**Lanes:** Browser-contract, Visual parity
**Expected ETA:** 5-10 min ET

Reply with the number of your choice:
1. `QA` - run `11-QA-frontend-migration` now (recommended).
2. `next` - continue to Step 12 DEV (Frontend Platform Integration).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/11-QA-frontend-migration`.
