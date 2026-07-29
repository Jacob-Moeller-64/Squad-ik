---
name: runtime-parity-checkpoint
description: Reusable boot-observe-assert checkpoint that runs the modernized app in src, uses the integrated browser plus the backend log stream to verify each in-scope route renders, its inventoried controls and navigation are present and visible, primary data calls return real data, and no unexplained browser-console or backend errors occur. Emits runtime-parity-checkpoint.json as binary closeout evidence.
argument-hint: Route list to verify, or "all in-scope routes", or a specific runtime defect to confirm
---

# Runtime Parity Checkpoint Skill

Use this skill whenever a numbered step changes runnable behavior under `src/` and must prove the result against the **running** application, not just a successful compile. It is the standard way to secure a visible checkpoint where the user can see how the modernization is progressing.

This skill catches the failure modes that static, content-only scans cannot see:

- **Configured but not rendering** — for example route menu metadata exists but the shell renders an empty nav.
- **Present but hidden** — for example a control exists in the template but is gated behind an unwired flag and never appears at runtime.
- **Rendered but collapsed** — a grid, table, or list renders real data but in **fewer or more generic columns/fields than the legacy route showed** (for example several legacy columns folded into one generic `details` column, or a typed grid replaced by an id/name pair). The data is present, but fields the user relied on are gone. A pixel or palette diff cannot see this; only a column-by-column reconciliation against the legacy answer key can.
- **Present but inert** — a control renders and is visible but its handler is an empty body, a `TODO`, or a permanently `disabled` flag with no owner. The label is preserved while the behavior is gone, so a control-presence check passes while the feature is dead.
- **Filter wired but ineffective** — a filter or search button is present, its handler fires, and the API call succeeds, but the visible row set is identical before and after applying the filter. This happens when filter parameters are not bound to the API query, or the API ignores them. Presence checks and data-binding checks both report green while the filter silently does nothing. Only comparing the pre-filter and post-filter row sets catches it.
- **Sibling lists return identical data** — when a route has multiple list sections or tabs backed by separate data calls (for example, five Spec Book types: Foundation, Pole Calc, Rehab, Transmission, Antenna), each section must return distinctly different rows. A component that passes the wrong discriminator — or calls the same endpoint for every tab — renders five identical grids. Only loading each section and comparing first-row content or row counts catches this. This is never visible on a single screenshot.
- **Mutate fires a modal but no API call follows** — an Add, Edit, or Delete button opens a modal form, but the form submit never calls the API (the placeholder-modal pattern). The control is visible, it opens a dialog, so the presence check and inert-control check both pass. Only observing the browser network tab or backend log while triggering the control confirms whether a real POST/PUT/DELETE/PATCH fires.
- **Same label, different control type** — a legacy dropdown, radio group, checkbox, date picker, or typeahead is re-created as a free-text textbox (or vice versa). The label matches, so a label/presence scan passes, but the input affordance and the allowed value set changed — the user can now type anything where they used to pick from a constrained list. Only a per-control type comparison against the legacy answer key sees it.
- **Verified by proxy, not by render** — the checkpoint is "passed" from a successful build, a parity-scanner `majorGaps=0`, an SPA route returning HTTP 200, or an unauthenticated `401` read as "route registered, will work once authenticated." None of those observe the rendered page, so the wrong color scheme, unbranded chrome, full-bleed controls, and authenticated `4xx`/`5xx` data faults all slip through while every proxy signal is green. A verdict not produced from an actual rendered observation is invalid evidence, not a pass.
- **Deferred instead of driven (parameterized/detail routes)** — a route with path parameters (a detail/edit route such as `.../:id` or `.../:keyNo/:changeNo`) is recorded as "route-verified, deferred to UAT because it needs a real record" instead of being driven with a real record from its parent route. That deferral is exactly how a broken detail route ships unseen: the client's path-parameter call (`GET /api/.../{a}/{b}`) may hit **no registered server route (404)** or the backing query may fault (`4xx`/`5xx`), and only loading it with a real record reveals it.

## Why both browser and backend logs

A checkpoint is trustworthy only when it watches both sides of the request:

- **Integrated browser (primary):** console errors, failed network requests (401, 404, 500), and the DOM presence **and visibility** of every inventoried control and navigation link on the route.
- **Backend log stream (secondary):** unhandled exceptions and 500s that the browser only sees as an opaque error. The legacy-vs-modern contract mismatches, auth failures, and data-layer faults surface here first.

Prefer the VS Code integrated browser as the inspection surface. Use Edge or Chrome only for secondary manual confirmation.

## No Status-Proxy Shortcut (hard rule)

This checkpoint is an **observed render**, never a proxy. The following are necessary but never sufficient and must never be recorded as a `pass` on their own: a clean client build, a parity-scanner `majorGaps=0`, an SPA route returning HTTP 200, or a `curl`/unauthenticated probe returning `401`/`404`/`500`. An unauthenticated `401` proves only that the route is **registered and protected** — it is not `dataBindingParity: pass`, and "expected to work once authenticated" is **unverified**, not passed. Every route's data-binding verdict must come from an **authenticated session** that fires the primary data calls and observes **real rows in the DOM** while the backend log is watched for `4xx`/`5xx`. Do not carry forward a prior session's row counts or screenshots as the current verdict. If the current environment cannot perform the authenticated render, record the checkpoint `blocked`/`unverified` and keep the step open — do not write `pass` from assumption. When an authenticated session is not already present, the canonical way to obtain one is the **integrated-browser operator share**: open the running app in the integrated browser and have the operator complete the real sign-in in that shared page, then observe each route. When even that is unavailable, the consuming step records its own honest pending state (for example Step 12's `liveDataRenderStatus: UnverifiedPendingAuth`) instead of carrying forward a prior observation.

## Inputs (derive, never hard-code)

- App identity from `/.modernization/.readme/kit-params.md`.
- In-scope routes and their expected controls from the current inventory evidence: `.modernization/fusion-restructure/inventory.json`, `.modernization/legacy-analysis/interaction-wiring-inventory.json`, the per-route behavior plan, and the route menu metadata in the modern `routes.config.ts`.
- The expected **per-route field set** — the grid/table/list columns (header label and bound field), filter inputs, and action controls the legacy route exposed — as the reconciliation answer key. Read it from the inventory evidence above; when the inventory lacks column/field grain, derive it directly from the legacy route source under `LegacyCode/` (or the runnable `LegacyCode_NETXX_Upgrade` workspace) before judging parity. The legacy field set is mechanically derivable from legacy source for any application, so a missing column is a gate failure, not an accepted default.
- The captured legacy screenshots and visual contract as the appearance baseline.

Routes and controls are always read from these artifacts so the checkpoint stays generic across applications and frameworks.

## Procedure

1. **Boot `src`.** Prefer the VS Code task `src: start api + client`. When you need a persisted backend log file to read errors from, use `/.github/skills/runtime-parity-checkpoint/scripts/Start-SrcRuntime.ps1`, which starts the API (and optionally the client) with combined stdout and stderr redirected to a timestamped file under `.modernization/artifacts/runtime-logs/` and writes `runtime-endpoints.json` with the resolved URLs and log paths.
2. **Confirm reachability.** Verify the API answers and the client serves before asserting parity. An empty body with no backend log entry means the request never reached the server (for example a dev-proxy or port mismatch); fix that before judging parity.
3. **Per in-scope route, observe in the integrated browser:**
   - the route renders its real page (not a blank outlet or an error alert),
   - the shell navigation renders every link the route menu metadata declares, and each link navigates,
   - every inventoried control for the route is present **and visible** — explicitly check that no control is missing and that none is hidden behind an unwired role or feature flag,
   - every data grid, table, or list renders **every column/field the legacy route showed** (header label and bound field). A grid that shows real data but in fewer or more generic columns than the legacy answer key is a **field-parity** defect, not a pass — record each dropped or collapsed column in `columnsMissing[]`,
   - every inventoried action control invokes a **real** handler — an event binding wired to a component method, route, or service call — not an empty body, a `TODO`, or a control left permanently `disabled` without an owner. A visible control whose behavior is stubbed counts as missing — record it in `inertControls[]`,
   - every inventoried input control keeps its legacy control **type** — a legacy single/multi-select dropdown, radio group, checkbox, date picker, or typeahead must not be silently replaced by a free-text box (or vice versa). A control that changes the input affordance and the set of allowed values (for example a legacy line-number **dropdown** re-created as a free-text **textbox**) is a parity defect a label/presence check cannot see, because both carry the same label. Record each divergence in `controlTypeMismatches[]`,
   - primary data calls fire, attach the approved auth, return success, and render real rows (not placeholder, seed, or empty arrays),
   - the browser console has no unexplained errors.
4. **Assert `effectClass`-typed behavioral effects — not just control presence.** For each route, read the `effectClass` for its ledger entries from `interaction-wiring-inventory.json` and assert the corresponding runtime effect was observed. These assertions are required because a control can be present, wired, and calling a real API while still being functionally broken to the user:

   a. **`filter` entries — assert the filter changes the row set.** For every filter/search control on the route: note the current visible row count (or first-row identifier), apply the filter with a representative real value, and assert the rendered row set changes. A filter that returns the same rows before and after applying is a `filterEffect: fail`. Record `preFilterRows`, `postFilterRows`, and `rowsChanged` per control in `filterAssertions[]`. Do not accept "API call returned 200" as proof — observe the DOM row count change.

   b. **`distinct-data` — assert sibling list sections return different rows.** When the route has multiple list sections or tabs that should each show a different data subset (for example, separate Spec Book types, separate file-type grids), navigate to each section, record first-row content sample and row count, and assert no two sections have identical first-row content. Two sections with the same first row are a `siblingListDistinctness: fail` — record in `siblingListDistinctness[]` with the duplicated sections named. A screenshot cannot detect this; the assertion must be made from observed DOM content.

   c. **`mutate` entries — assert a real API write call is observed.** For every Add/Edit/Delete/Submit control on the route: observe the browser network tab (Developer Tools → Network, or the backend log stream) while invoking the control. A `mutate` entry is `mutateWiring: pass` only when a real POST/PUT/DELETE/PATCH network request is observed firing toward the API. Do NOT actually submit destructive operations; use non-destructive trigger (open form, observe preflight or OPTIONS request) or read the backend log for the incoming request entry. A control that only opens a modal without ever firing a write call is a `mutateWiring: fail` — record in `mutateWiringAssertions[]`. This is the definitive test for the placeholder-modal pattern.

5. **Drive parameterized and detail routes with a real record - never defer.** For every route with path parameters (a detail/edit route such as `.../:id` or `.../:keyNo/:changeNo`), open it with a REAL record reached from its parent route - open the parent grid and click through to a real row - and assert its data load like any other route. Do NOT record it as "route-verified, deferred to UAT because it needs a real record." That deferral hides a `404` when the client's path-parameter call hits an endpoint the backend never registered (it exposed only a query-string GET), or a `4xx`/`5xx` when the backing query faults. When the parent route has at least one real row, the detail route is reachable and in scope. A client API path with no matching server route is a route-contract defect for this checkpoint, not a later pass.
5. **Guard redirect target audit (static, runs once per checkpoint):** For every `canActivate` guard in `routes.config.ts` (or equivalent) that specifies a denial redirect path, confirm that redirect path is a declared route. A guard that redirects to an undeclared path causes a silent fallthrough to the wildcard route - typically the app home - which hides the access-denied condition entirely. Record any missing denial target in `waivers[]` with `owningStep` until it is fixed.
6. **Read the backend log** for the same interval and record any exception or 500.
7. **Compare appearance** against the captured legacy screenshot and visual contract for the route closely enough to confirm it is recognizably the same screen.

## Evidence Output

Write `.modernization/fusion-restructure/runtime-parity-checkpoint.json` with at least:

- `generatedUtc`, `appName`, `apiUrl`, `clientUrl`, `backendLogPath`
- `routesChecked`: one entry per route with `{ route, rendered, navLinksExpected, navLinksRendered, navParity, controlsExpected, controlsVisible, controlsMissing[], controlsHiddenBehindFlag[], controlVisibilityParity, controlTypeMismatches[], controlTypeParity, gridColumnsExpected, gridColumnsRendered, columnsMissing[], inertControls[], fieldParity, primaryDataCalls[ {endpoint, status, returnedRows} ], dataBindingParity, filterAssertions[ {controlId, label, preFilterRows, postFilterRows, rowsChanged, verdict} ], siblingListDistinctness[ {sectionLabel, firstRowSample, rowCount} ], siblingListDistinctnessVerdict, mutateWiringAssertions[ {controlId, label, networkCallObserved, endpoint, verdict} ], mutateWiringParity, consoleErrors[], backendErrors[] }`
- Roll-ups: `navParity`, `controlVisibilityParity`, `controlTypeParity`, `fieldParity`, `dataBindingParity`, `filterEffectParity`, `siblingListDistinctnessOverall`, `mutateWiringParity`, `consoleErrorCount`, `backendErrorCount`, `overall`
- `waivers[]`: any accepted gap as `{ item, reason, owningStep }`

`overall` is `pass` only when every route renders, `navParity`, `controlVisibilityParity`, `controlTypeParity`, `fieldParity`, and `dataBindingParity` are `pass`, every `filter` assertion shows `rowsChanged: true`, `siblingListDistinctnessOverall` is `pass`, every `mutate` control shows `networkCallObserved: true`, and `consoleErrorCount` and `backendErrorCount` are `0` or every nonzero item has an explicit waiver. `controlsMissing`, `controlsHiddenBehindFlag`, `controlTypeMismatches`, `columnsMissing`, `inertControls`, a `filterEffect: fail`, a `siblingListDistinctness: fail`, or a `mutateWiring: fail` being non-empty without a waiver is a `fail`. Each route's verdict must be backed by an authenticated observed render (see **No Status-Proxy Shortcut**); record the authenticated observation per route with `verifiedBy: observed-render` and the observed row count. A `dataBindingParity` claimed from an unauthenticated `401`, a build, a scanner result, or a carried-forward prior observation is invalid \u2014 set that route `dataBindingParity: unverified` and `overall` cannot be `pass`.

## How A Step Uses This

- A step that changes `src/` is not complete until `runtime-parity-checkpoint.json` exists and `overall` is `pass` (or every gap is an explicit, owned waiver).
- On `fail`, follow the owning step's blocker-to-completion guidance: fix the rendering, visibility, or data-binding defect and re-run this checkpoint before advancing. Do not advance a failing checkpoint, because a route that looks done but is behaviorally dead poisons every later step.

## Cleanup

When the checkpoint is finished and the app no longer needs to run, stop the processes started for the checkpoint with `/.github/skills/runtime-parity-checkpoint/scripts/Stop-SrcRuntime.ps1`, or stop the VS Code task.
