---
description: Testing design contract defining folder structure, parity gates, step ownership, mandatory vs optional test types, and visual parity remediation behavior.
applyTo: tests/**,.modernization/**/qa-test-plan.json,.github/prompts/08-*.prompt.md,.github/prompts/qaTestPrompts/*.prompt.md
---

# Testing Design Contract

## Core Principles

1. **Characterization tests and Visual Parity tests are MANDATORY** — never optional, never deferred.
2. **All other test types may be deferred to Step 17** — ask user at each checkpoint.
3. **All tests must be Gherkin-style** with `Feature:`, `Scenario:`, and clear `Given/When/Then` comments.
4. **Tests live in `tests/`** — never colocated in `src/`.
5. **Visual parity priority**: Functionality → Placement → Style/Color.
6. **Characterization is behavioral, not just structural.** The structural source-shape lock (controller/action/entity/config presence) is the floor; the behavior families below are the mandate.

## Behavior Families That MUST Be Covered

Step 3 inventory and Step 6 catalog must produce at least one catalog entry for every behavior family that the legacy application exhibits. Step 7 QA uses this list to audit coverage gaps.

### Backend behavior families (catalog as `characterization` + `unit` + `integration`/`contract` triples when the seam has business weight)

| Family | What "covered" looks like |
| --- | --- |
| Business rules | Conditional logic, eligibility, state-machine transitions, workflow gating |
| Calculations | Arithmetic, aggregations, rounding, unit conversions, lookups, multi-step formulas |
| Validation behavior | Required/range/format/regex/cross-field guards; 4xx-returning guards |
| API responses | Status codes + body shape for happy path AND every documented error path (400/401/403/404/409/422/500); empty-result and large-result paths |
| Database side effects | Inserts/updates/deletes, soft-delete flags, audit columns, cascade behavior, transaction boundaries, optimistic-concurrency tokens |
| Legacy quirks | Workarounds, intentional non-standard returns, suppressed exceptions, hard-coded edge cases, vendor-specific encoding, culture/time-zone formatting — anything Step 3 flagged as "weird but load-bearing" |
| Permission behavior | `[Authorize]`/`[AllowAnonymous]`, role/claim checks, owner-only, multi-tenant scoping, anon-vs-auth response differences |

### Frontend behavior coverage

Frontend behavior parity is owned by the **UI Screenshot Parity lane**, not by the behavioral-characterization catalog. Step 3 captures the legacy screenshots; the visual-parity gates at Steps 11, 12, 15, and 18 (see Parity Gates by Step below) compare modern vs legacy and drive remediation. Step 6 does not enumerate frontend behavior families as catalog entries.

#### Interaction wiring parity (frontend orphan-control check)

Visual parity must be paired with **interaction wiring parity**. The Step 3 **Interaction Wiring Inventory** (`.modernization/ignition-artifacts/discovery/interaction-wiring-inventory.json`) is the contract: for every legacy interactive control it records `controlId`, `surface`, `label`, `triggerEvent`, `wiringKind`, `target`, `sideEffects`, `authGate`, and `legacyEvidence`.

For every high-risk control in that inventory (anything whose `wiringKind` is `api-call`, `state-mutation`, `navigation-then-api`, `export`, `print`, `upload`, `download`, `auth-callback`, or whose label is in the high-risk command family), Step 3 must also produce a row in the **Workflow Trace Inventory** (`.modernization/ignition-artifacts/discovery/workflow-trace-inventory.json`) that captures the complete request-and-response workflow: `clientHandler`, `confirmDialog`, `preCallStateMutations`, `requestShape` (full payload tree with nesting and casing), `serverHandler`, `responseShape`, `postCallStateMutations`, `visibleStateLabels` (the exact in-flight and post-success text the legacy actually shows), `sideEffects`, `parityRisks`, and `legacyEvidence`. Step 12 integration specs assert against this row; missing fields here become missing assertions there.

At each visual-parity gate (Steps 11, 12, 15, 18), the modern UI must satisfy two checks:

1. **No orphan controls** — every interactive control rendered in `src/` must map to an entry in the Interaction Wiring Inventory (or to a recorded planned-deletion decision). A modern button, link, or menu item with no handler, no route, no API call, or no recorded wiring is a parity defect, not a cosmetic issue.
2. **Wiring fidelity** — the modern control's `target` and `sideEffects` must match the legacy entry (same route, same API endpoint + verb, same modal, same print/export/download behavior, same auth gate) unless a Step 6 decision explicitly retires or redirects it.

Deviations are remediated the same way visual deltas are: fix the modern code, or record an explicit Step 6 decision to retire/redirect the wiring with rationale.

## UI -> API Integration Contract (Step 3 catalog, Step 6 plan, Step 12 hard gate, Step 15 carry-over)

The Interaction Wiring Inventory above is the **what**. This section is the **how**: the deterministic artifact, generator script, and integration-test gate that prove every wired UI control actually reaches a real modern API endpoint and gets real data back.

### Canonical artifact

- **Path**: `.modernization/ignition-artifacts/discovery/ui-api-wiring-map.json`
- **Map generator (kit script, app-agnostic)**: `.github/scripts/QA/generate-ui-api-map.ps1`
- **Spec generator (kit script, app-agnostic)**: `.github/scripts/QA/generate-integration-tests.ps1` -- emits one Playwright integration spec per resolved `(trigger, apiCall)` chain under `tests/frontend/e2e/integration/generated/`. The `generated/` folder is wiped and re-emitted on every run; hand-authored integration specs MUST live in sibling folders (e.g. `tests/frontend/e2e/integration/custom/`) so they survive regeneration.
- **Companion summary (human-readable)**: `.modernization/ignition-artifacts/discovery/ui-api-wiring-map.md`

The generator scans three sources of evidence and cross-references them:

1. `src/<AppName>.Web.Api/Controllers/*.cs` -> every `[Http*]` action, with route, verb, auth policy, source file.
2. `src/<AppName>.Web.Client/src/app/services/**/*.ts` -> every `httpClient`/`_fusionHttp` call site, with verb + resolved endpoint (constants are expanded).
3. `src/<AppName>.Web.Client/src/app/features/**/*.html` -> every `(click)`/`(pressed)`/`(change)`/`(submit)` binding, with handler method, `data-testid`, and `aria-label`.

It then emits two failure lists that drive remediation:

- `orphanApiActions[]` -> API endpoint exists but no UI caller. Either dead code that should be removed, or missing UI wiring that must be added.
- `brokenClientCalls[]` -> UI service call points at an endpoint+verb that does not match any modern controller action. This is a guaranteed runtime failure once the user clicks.

### Step ownership

| Step | Owns | Required state |
| --- | --- | --- |
| Step 3 Legacy System Analysis | Initial run of the generator against the legacy-to-modern endpoint plan. Populates Interaction Wiring Inventory **and Workflow Trace Inventory** (`.modernization/ignition-artifacts/discovery/workflow-trace-inventory.json`) for every high-risk control. | `ui-api-wiring-map.json`, `interaction-wiring-inventory.json`, and `workflow-trace-inventory.json` all exist with a baseline catalog. |
| Step 6 Modernization Quality Design | Plans `frontend-integration` cases per `Rule-Route-1` from the map. Records any wiring entry intentionally retired or redirected. **Each high-risk row in the Workflow Trace Inventory becomes a planned `frontend-integration` test case that asserts request shape AND visible state labels, not just that the API was called.** | Catalog references the map by `controller`+`method` or `endpoint`+`verb`, and references the workflow-trace `workflowId` for high-risk controls. |
| Step 12 Frontend Platform Integration | **Hard gate.** Generator is re-run; the integration suite under `tests/frontend/integrationFrontend/` MUST drive every wired control and assert (a) the API was called with the expected verb and route, (b) the request payload structure matches the Workflow Trace Inventory `requestShape` exactly (nested-vs-flat included), (c) the UI populated, and (d) every `visibleStateLabels` entry from the workflow trace appears and disappears at the correct point in the state machine. Step 12 cannot close while `brokenClientCalls.Count > 0`, while any control listed in the map has no executing integration test, or while any `workflow-trace-inventory.json` row whose `workflowStatus` is `fully-traced` lacks an integration spec asserting its `requestShape` and `visibleStateLabels`. | Generator output is current. Suite passes. Map, workflow-trace, and Step 12 `perRouteApiWiringList` agree. |
| Step 15 Fusion UI Integration | When a primitive family is replaced, the same integration spec must continue to pass against the Fusion-replaced control. | No regressions in `brokenClientCalls`. |

### Test pattern

Each `frontend-integration` spec under `tests/frontend/integrationFrontend/` MUST:

1. Authenticate (Development policy is `RequireAuthenticatedUser`; protected endpoints will 401 otherwise).
2. Navigate to the route that owns the control.
3. Locate the control by `data-testid` (the kit's locator contract).
4. Set up a request expectation for the expected endpoint+verb.
5. Trigger the user interaction (click, submit, change).
6. Assert: (a) the request fired with the expected verb+route, (b) the response status is 2xx (or the documented error if the case targets an error path), (c) the UI populated with the response data (not seed/fixture/placeholder), (d) **the request payload structure matches the Workflow Trace Inventory `requestShape` exactly**, including nested-vs-flat object structure and casing of every property name (flat-vs-nested mismatches such as `selectedSubstationName: "name"` vs `selectedSubstationName: { selectedSubstationName: "name" }` are the most common parity 400 and MUST be caught here), and (e) **every `visibleStateLabels` entry from the Workflow Trace Inventory appears and disappears at the correct point in the state machine** -- the pre-call label is absent before the click, the in-flight label(s) (e.g. `CALCULATING: <sub> - <tref>`, `Completing 37 calculations...`, spinner, counter) appear after the click and before the response resolves, and the post-success label (e.g. `CALCS COMPLETE FOR: <sub> - <tref>`) appears once the response is bound. Asserting only that the API was called is insufficient and has shipped parity defects to users.

A reference spec is shipped at `tests/frontend/integrationFrontend/_template/ui-api-wiring.spec.template.ts`.

### Read-Only Default (Data Safety)

Integration tests run against the live modernized backend, which may share its database with developer workflows or other test lanes. To prevent accidental data loss or pollution, `frontend-integration` specs are **read-only by default**.

**Allowed by default**: `GET` and `HEAD` verbs only.

**Restricted verbs** (`POST`, `PUT`, `PATCH`, `DELETE`): may only be exercised when ALL of the following are true:

1. The spec runs against an explicitly isolated test database, ephemeral container, or a per-test transaction that is rolled back in `afterEach`.
2. The spec file declares the restricted verb in a top-level comment block: `// data-safety: mutates (<verb> <route>) - isolation: <mechanism>`.
3. The Step 6 catalog entry for that case has `dataSafety: "mutates"` and `isolationMechanism` populated.
4. A reviewer-approved Step 6 decision authorizes the mutation lane.

**Coverage of mutating endpoints without invoking them**: For `POST`/`PUT`/`PATCH`/`DELETE` controls whose mutation lane is not authorized, the spec MUST still prove the wiring by one of:

- Asserting the control is rendered, enabled, and bound to the expected handler (DOM + handler proof, no click).
- Intercepting the click with `page.route(<pattern>, route => route.fulfill({status: 200, body: ...}))` so the request is observed but never reaches the backend.
- Driving the control in a documented dry-run mode the modern app exposes (e.g. a `?dryRun=1` flag or a `preview` endpoint).

The wiring map generator output already lists each endpoint's verb, so Step 6 planning can route every wired control to the right lane without invoking destructive verbs.

### Enforcement

- Step 12 portal report MUST surface counts from `ui-api-wiring-map.json` summary.
- Step 12 portal report MUST surface an explicit `Wiring Hard Gate Verdict` status row derived from `summary.brokenCallCount`. The verdict is `PASS (0 broken client calls)` when the count is zero, `BLOCKED (<n> broken client calls ...)` when it is greater than zero, and `NOT GENERATED ...` when the wiring map artifact is absent. Step 12 MUST NOT be closed while the verdict is `BLOCKED` or `NOT GENERATED`.
- The generator supports `-FailOnOrphans` to be wired into CI once Step 12 declares the map clean for the first time.
- The generator supports `-FailOnBrokenCalls` as a focused Step 12 hard-gate switch that throws when `brokenCallCount > 0` without bundling the (advisory) orphan check. Use this in CI or agent loops that need to fail fast on the closure-blocking condition only.
- The generator splits no-match client calls into two buckets: `brokenClientCalls` (endpoint resolved to a literal route but no API serves it -- closure-blocking, drives `brokenCallCount`) and `unresolvedClientCalls` (endpoint comes from a parameter/expression the static analyzer cannot resolve, e.g. a helper that takes an `endpoint` arg -- advisory only, drives `unresolvedCallCount`, never trips the hard gate). Unresolved entries are surfaced in their own markdown section so a reviewer can trace the helper back to its concrete callers if needed.
- Each entry in `brokenClientCalls` ships with two heuristic triage hints: `suggestedFixSameRoute` (same route exists under a different verb -> likely client verb typo) and `suggestedFixSameVerb` (same verb exists under a near-identical route -> likely route typo). Both hints are advisory; the reviewer still confirms the fix.
- The generator's `summary` block also reports `mutatingApiCount` (count of `POST`/`PUT`/`PATCH`/`DELETE` actions) so Step 6 planning can size the dry-run / interception lane explicitly.

## Catalog Category Routing Rules (Step 6 Pyramid Contract)

The Step 6 executable test-case catalog MUST honor the test pyramid. Every rule-driven case in
`.modernization/portal/data/json/executable-testcase-catalog.json` is routed to a category according
to the table below. This is the contract — deviations are a Step 6 defect, not a judgment call.

### Pyramid Distribution Targets

| Category | Target share of total catalog | Notes |
| --- | --- | --- |
| `unit` | ~50-65% | Single largest bucket. One per method (Rule-1 unit) plus per-rule logic cases. |
| `characterization` | ~15-25% | One per method (Rule-1 char) plus C1-C8 structural floor. |
| `contract` | ~10-20% | One per controller action. Asserts route/verb/schema vs generated OpenAPI doc. |
| `integration` (backend) | ~10-20% | One per controller action. Asserts HTTP round-trip + payload shape. |
| `frontend-integration` | small fixed | One per modern route from the UI inventory. |
| `e2e` | small fixed (target <=10 for small apps) | One per documented acceptance-criteria user journey. |
| `browser-contract` | minimal | C9 structural floor for legacy JS source-shape lock. |

`unit` + `characterization` SHOULD combine to >=70% of the catalog. `unit` MUST exceed `integration`
by at least 2x. `e2e` MUST stay small (a handful of canonical user journeys); E2E breadth is not a
substitute for unit or contract coverage.

### Rule -> Category Routing (Authoritative)

Apply these rules per method in the Service & Behavior Inventory. Each rule emits exactly the
categories listed; never collapse logic-rule cases into integration tests.

| Rule | Trigger | Emits |
| --- | --- | --- |
| Rule-1 (always) | every method | `characterization` (parity proof) + `unit` (Library extraction) + `integration` (only if controller, one per action) + `contract` (only if controller, one per action) |
| Rule-1b | method has parameters | `unit` (invalid-input / model-state-invalid) |
| Rule-1c | method has reference parameters | `unit` (null-argument guard) |
| Rule-2 | `nullableReturn` true | `unit` (not-found returns null) |
| Rule-3 | per `throwGuards[i]` | `unit` (guard violation throws) |
| Rule-4 | per `branchingParameters[i]` | `unit` (per-branch behavior) |
| Rule-5a / Rule-5b | per `nullCoalescingDefaults[i]` | `unit` x 2 (null-supplied applies default + non-null-supplied preserved) |
| Rule-6 | `listOrCollectionReturn` true | `unit` (empty repository returns empty collection) |
| Rule-7 | `displayDecorators` non-empty | `unit` (decoration idempotency) |
| Rule-8 | per `delegationPaths[i]` | `unit` (delegation routing) |
| Rule-Route-1 | per modern route from UI inventory | `frontend-integration` (Playwright spec round-tripping a representative API call) |
| Rule-Journey-1 | per documented user journey | `e2e` (Gherkin .feature under tests/frontend/e2e/journeys) |
| C1-C8 | structural floor | `characterization` (theory sweeps for source-shape lock) |
| C9 | legacy JS source-shape | `browser-contract` (Playwright spec for legacy JS registration markers) |

### Common Mistakes To Reject

1. Emitting a `unit` case for non-controllers only. Controllers also produce unit cases because the
   Step 8 Library extraction turns the action body into a Library method that needs unit coverage.
   The HTTP routing layer is the only thing that stays controller-shaped and needs integration.
2. Routing Rules 2-8 to `integration` when the source method is a controller. Those rules describe
   pure logic behavior that lives in the extracted Library after Step 8. They are always `unit`.
3. Skipping `contract` cases. Every controller action gets one contract test in addition to its
   integration test. Contract asserts the schema; integration asserts the round-trip.
4. Skipping `frontend-integration` cases. Every modern route gets at least one Playwright spec
   that round-trips through the modern API for a representative interaction.
5. Inflating `e2e`. E2E is reserved for acceptance-criteria user journeys; keep it under 10 for
   small apps. Use `frontend-integration` instead for per-control or per-API coverage.
6. Hand-authoring the catalog. The catalog MUST be generated from the Service & Behavior Inventory
   by applying the rule table above. A hand-written catalog drifts away from inventory evidence and
   silently misses methods.

## Folder Structure (Designed in Step 6)

```
tests/
├── backend/
│   ├── unit/
│   │   ├── Library.UnitTests/        # Step 8: Logic extracted from .cshtml, services
│   │   └── Web.Api.UnitTests/        # Step 8: API-layer unit tests
│   ├── contractApi/                  # Step 9: API shape contract tests
│   └── integrationBackend/           # Step 9: End-to-end backend flows
├── db/                               # Step 17: Schema, stored procs, data migration
├── frontend/
│   ├── angular/                      # Step 11: Component unit tests (Karma/Jasmine)
│   ├── e2e/
│   │   ├── journeys/                 # Step 17: Acceptance-criteria E2E flows
│   │   └── accessibility/            # Step 17: a11y checks
│   ├── integrationFrontend/          # Step 12: Playwright functional tests
│   │   ├── testResults/
│   │   │   ├── videos/
│   │   │   ├── <group>.html
│   │   │   └── <group>.md
│   │   └── testcases/
│   │       └── <Section>.<type>.spec.ts
│   ├── smoke/                        # Step 17: Navigation smoke tests
│   ├── pageObjectModels/             # Step 17: POM for stable routes
│   └── visualParity/
│       ├── legacy/                   # Baseline screenshots from LegacyCode runtime
│       ├── modern/                   # Current screenshots from src/ runtime
│       └── gates/
│           ├── 25/                   # Step 10 gate screenshots
│           ├── 50/                   # Step 13 gate screenshots
│           ├── 75/                   # Step 16 gate screenshots
│           └── Final/                # Step 17 gate (85%+)
└── modernization/
    ├── characterization/             # Step 7+: Cumulative characterization phases AFTER the frozen baseline
    │   ├── Backend-Upgrade/          # Step 7: .NET upgrade phase (modern-side parity run)
    │   ├── Backend-Formation/        # Step 8: Library/API formation
    │   ├── Frontend-Foundation/      # Step 10: Shell formation
    │   └── Frontend-Migration/       # Step 11: Feature migration
    └── testResult/                   # Markdown reports per step
```

> **Frozen baseline lives under `LegacyCode/`, not under `tests/`.**
> The Step 7 baseline characterization project (the legacy-green run) is authored at
> `LegacyCode/Characterization/Baseline/` so the baseline ships and stays with the
> preserved legacy tree it protects. All other characterization phases above are
> modernization-product tests and live under `tests/modernization/characterization/`.

## Parity Gates by Step

The canonical visual-parity comparator is `tests/frontend/visualParity/run-visual-parity.mjs`. It is invoked from each QA step prompt with `--gate <N> --out gates/<N>` and writes per-route diffs plus `visualParity.{md,json}` under `tests/frontend/visualParity/gates/<N>/` and `testResult/`. Exit code 0 = every graded route at or above the gate; exit 1 = at least one route below.

| Step | Visual Parity Gate | Test Type Owned | Dev Work |
|------|--------------------|-----------------|----------|
| 6 | — (planning only) | Design structure, plan characterization, plan all tests | No dev |
| 7 | — | Run baseline characterization | .NET upgrade |
| 8 | — | Backend unit tests (Library layer) | Backend formation |
| 9 | — | Contract + Integration (API layer) | Backend hardening |
| 10 | Baseline capture (no gate) | Shell screenshot baseline | CSS/routes scaffold |
| 11 | 25% (single-pass; route failures route to Step 11 DEV) | Angular component tests + visual-parity comparator | Feature migration |
| 12 | 50% (loop until every graded route >= 50% or remaining sub-50 routes routed to Step 13/15 with rationale) | Frontend integration (Playwright functional) + visual-parity comparator | Platform integration |
| 13 | — (no comparator gate; shell stabilization may still apply tweaks if Step 12 routed sub-50 deltas here) | Shell stabilization parity | Shell stabilization |
| 14 | — | No testing | UI inventory |
| 15 | 75% full-route (loop) **OR** primitive-scoped informational evidence when the slice changes design system (see Primitive-substitution clause below). Remaining sub-75 / residual-theme deltas routed to Step 16/17 with rationale. | Visual-parity comparator + a11y smoke | Fusion upgrade slice 1 |
| 16 | — (no comparator gate; next primitive-family slice carries its own scoped check inside Step 15's loop pattern when re-entered) | Fusion upgrade parity | Fusion upgrade slice 2+ |
| 17 | — (polish only; user may rerun the comparator ad-hoc but no required gate here) | ALL remaining tests completed | Final verification |
| 18 | User-driven (default 90%, `--gate <N>` configurable, reruns preserved under `gates/Final[-<N>]/`) | Visual-parity comparator (final) | Deployment + cleanup |

### Legacy Visual Contract Gate (Step 13 closeout, before Step 14)

The per-route screenshot comparator gates above advance pixel parity as migration progresses. They are paired with one dedicated **Legacy Visual Contract Gate** at the Step 13 closeout that proves the modern shell inherited the legacy *visual language* before any Fusion primitive family is swapped in.

- **Owner / placement:** Step 13 produces it at closeout; Step 14 must not begin the map-and-swap block until it is `pass`. This is the gate that closes the prior gap where Step 13 had no comparator gate and Step 14 had no testing.
- **Answer key:** the legacy app in `LegacyCode/` plus the extracted contract in `.modernization/fusion-restructure/ui-visual-contract.json` and `styling-foundation.json` – never a finished modern reference.
- **Skill:** `/.github/skills/visual-parity-gate/SKILL.md`, which composes the `runtime-parity-checkpoint` and `screenshot-capture` skills, boots modern (and legacy on a second port when runnable), and diffs computed styles plus screenshots against the contract.
- **Evidence:** `.modernization/fusion-restructure/visual-parity-report.json` with per-route `pass | partial | fail` across palette, typography, header/nav/footer presence, the nav route model, and layout density. A raw default framework theme, an empty nav, or missing header/footer chrome is a `fail`. `overall` is `pass` only when every route is `pass` or every non-`pass` route is an explicitly accepted residual gap with a reason and owner.

## User Checkpoints

After these steps, ask: **"Do you want to complete [X] tests now or defer to Step 17?"**

- **After Step 9**: Backend unit, contract, integration tests
  - Message: "Backend dev work is complete. Finish backend tests now or wait until Step 17?"
- **After Step 11**: Angular component tests
  - Message: "Angular migration complete (visual parity at 25% gate). Finish Angular component tests now or wait until Step 17?"
- **After Step 12**: Frontend integration tests + 50% visual-parity loop
  - Message: "Platform integration complete (visual parity loop closed at 50% gate). Finish frontend integration tests now or wait until Step 17?"
- **After Step 15**: Fusion UI primitive-family slice + 75% visual-parity loop
  - Message: "At 75% visual parity. Continue Fusion slices (Step 16) or move toward final?"
- **After Step 18**: Final visual parity (user-driven gate)
  - Message: "Final visual parity at gate <N>%. Push higher with `raise <N>` or accept and ship?"

## Visual Parity Test Behavior

When a visual parity test fails below the gate threshold:

1. **Load legacy screenshot** from `tests/frontend/visualParity/legacy/`
2. **Load modern screenshot** from `tests/frontend/visualParity/modern/`
3. **Identify delta** using priority order below
4. **Fix modern** code until the comparison passes the gate
5. **Repeat** until gate threshold is met

**Each route/page/interactive-component = one screenshot test.**

### Visual Comparison Priority Order

1. **Functionality** — Routes and pages that connect to actions/APIs work first
2. **Interactive components** — Forms, buttons, tables, dropdowns behave correctly
3. **Layout and placement** — Elements are positioned correctly
4. **Style, color, feel** — Polish last (colors, fonts, shadows, spacing)

### Gate Thresholds

| Gate | Threshold | Meaning |
|------|-----------|---------|
| 25% | Baseline | Routes load, shell visible, major layout present |
| 50% | Functional | Interactive components work, data displays |
| 75% | Near-parity | Minor styling differences only |
| 85% | Acceptable | Ready for review |
| 90% | Polish | Optional stretch goal |

### Primitive-substitution clause (Step 15 / Step 16 slices)

When a UI upgrade slice intentionally swaps design systems (e.g. a legacy CSS-framework control replaced by a Fusion primitive with different intrinsic dimensions, theme tokens, and active-state rendering), the full-route pixel-parity gate at 75% is the wrong contract and cannot be lifted by in-scope tweaks. The gate becomes structural-plus-informational:

1. The full-route comparator still runs and writes evidence to `gates/<N>/`.
2. A **primitive-scoped comparator run is required.** The routes JSON for that run specifies, per affected route:
   - `primitiveSelector` -- modern CSS selector for the replaced primitive.
   - `legacyUrl` -- legacy path to navigate (resolved against `LEGACY_URL`, default `http://localhost:8085`).
   - `legacySelector` -- legacy CSS selector for the equivalent control.
   The comparator crops both sides to the primitive bounding box, normalizes to a common pixel grid via nearest-neighbor resize, and writes per-route diffs to `gates/<N>-primitive/`.
3. **Cross-design-system preprocessing is required** on every primitive-scoped route so the score reflects shape and layout parity instead of color-palette and font-antialiasing noise. Each primitive-scoped route entry MUST set:
   - `preprocess: ["grayscale","blur"]` -- pure-JS luminance conversion + 5-pass 3x3 box blur (no native deps). Removes color-palette diffs (Fusion blue vs Bootstrap blue) and smooths sub-pixel AA wobble that would otherwise read as 100% diff.
   - `threshold: 0.5` -- pixelmatch per-pixel sensitivity (default 0.1, strict 0.2). 0.5 is a tightened lenient floor that still lets two visually-identical labels register as a match across different font metrics but rejects coarse color or shape diffs. Use `0.6` with `preprocess: ["grayscale","blur-heavy"]` (12-pass blur) when the legacy and modern primitives use different CSS frameworks with very different padding/typography stacks.
   - Result JSON records the actual `preprocess` array and `effectiveThreshold` used so evidence stays reproducible.
4. **Shape-grid normalization is required** for every primitive-scoped run. The comparator scales both cropped primitives down to a coarse common grid (width capped at 128px via area-average downscale, height scaled proportionally with an 8px floor) before pixelmatch. This eliminates the vertical/horizontal stretch artifact created when the legacy and modern primitives render at different intrinsic widths or heights, and collapses per-character font diffs into a few pixels per tab while preserving overall tab geometry, headings, and gaps. The shape-grid normalization is implemented inside `tests/frontend/visualParity/run-visual-parity.mjs` and is not a per-route knob.
5. With preprocessing and shape-grid normalization on, the primitive-scoped match % **is** a numeric gate at the 95% threshold for cross-design substitution slices. The binding gate becomes:
   - Browser-contract green on every affected route.
   - Accessibility smoke green on the new primitive.
   - The correct Fusion primitive is structurally present at the correct location on every affected route.
   - Primitive-scoped match % >= 95 on every affected route, or remaining sub-95 routes are explicitly routed to Step 16 / Step 17 with rationale. Routes whose legacy and modern primitives have intrinsic geometric asymmetry (different widths/heights of the captured primitive bounding box) MUST be excluded from the primitive-scoped run and tracked via full-route parity instead, because no preprocessing recipe can resolve real shape mismatch at the 0.5 threshold.
6. Residual visual delta (Fusion theme vs legacy theme) is recorded and routed to Step 16 (theme-token / sizing slice) or Step 17 (final polish) with rationale.
7. The routes-JSON file used for the primitive-scoped run is committed under `tests/frontend/visualParity/` so the run is reproducible.

This clause applies to any visual-parity gate where the slice substitutes the underlying design system. Layout-preservation slices (Steps 10-13) continue to use full-route pixel parity unchanged.

## Characterization Test Phases

Characterization tests run **cumulatively** — each step runs all prior phases plus its own.

| Phase | Owner Step | Location | What It Proves |
|-------|------------|----------|----------------|
| Baseline | Step 7 | `LegacyCode/Characterization/Baseline/` | Legacy behavior locked. Lives inside the preserved legacy tree so the frozen baseline ships with the code it protects. |
| Backend Upgrade | Step 7 | `tests/modernization/characterization/Backend-Upgrade/` | .NET upgrade preserves behavior |
| Backend Formation | Step 8 | `tests/modernization/characterization/Backend-Formation/` | Library/API split preserves behavior |
| Frontend Foundation | Step 10 | `tests/modernization/characterization/Frontend-Foundation/` | Shell scaffold works |
| Frontend Migration | Step 11 | `tests/modernization/characterization/Frontend-Migration/` | Feature migration preserves behavior |

## Playwright Artifact Contract

All Playwright tests produce standardized artifacts:

```
testResults/
├── videos/            # Always captured, every test run
├── <testGroup>.html   # HTML report per test group
└── <testGroup>.md     # Markdown summary per test group
```

Test file naming: `<Section>.<testType>.spec.ts`

Examples:
- `home.navigation.spec.ts`
- `pj.calculation.spec.ts`
- `auth.login-callback.spec.ts`

## Mandatory vs Optional Tests

### MANDATORY (never skip, never defer)

| Test Type | Why Mandatory |
|-----------|---------------|
| Characterization | Proves behavior preservation at every step |
| Visual Parity | Proves UI matches legacy at gate thresholds |
| UI -> API Integration (Step 12) | Proves every wired control fires the expected verb on the expected endpoint. Generated from `ui-api-wiring-map.json` by `generate-integration-tests.ps1`; Step 12 cannot close while any resolved `(trigger, apiCall)` chain lacks a passing spec. Mutating verbs are intercepted with `page.route(...)` so the suite stays safe under the read-only-default data-safety rule. |
| API Smoke Probe (Step 9; re-run Step 12 + Step 17) | Proves every endpoint in `totalApiEndpoints` is reachable, routed, and auth-gated without mutating data. Planned by Step 6 per the API Smoke Probe Plan, authored under `tests/backend/smoke/`, run as a hard gate before Step 12 integration begins. Default-safe via the tiered safety contract below; mutating verbs are only smoked via Tier 1 (auth-gate), Tier 3 (validation-rejection with evidenced gate), Tier 4 (`mutatesState: false` dry-run/preview), or Tier 5 (opt-in ephemeral data only). |

### API Smoke Probe – Safety Tiers (Step 6 plans, Step 9 authors)

Every endpoint MUST be probed under the lowest tier that proves reachability. Higher tiers require named evidence in the `executable-testcase-catalog.json` row. This applies the kit's GET-first / do-not-modify-data posture to mutating verbs so POST / PUT / PATCH / DELETE can be smoked without touching data.

| Tier | Name | What it sends | Expected | Mutates? | Required evidence |
| ---- | ---- | ------------- | -------- | -------- | ----------------- |
| T1 | Unauthenticated reachability | Real verb, no auth | 401 or 403 | No (auth short-circuit) | `expectedStatus: 401\|403` |
| T2 | CORS preflight | `OPTIONS` with documented origin | 204 or 200 | No | `expectedStatus`, `expectedHeaders` |
| T3 | Authenticated invalid-body rejection (POST/PUT/PATCH) | Auth + intentionally invalid body | 400 / 422 ProblemDetails | No, only when gate evidence is recorded | `validationGate: {file,line}` precedes `firstMutationCall: {file,line}` in the success path |
| T4 | Dry-run / preview / calculate-only POST | Auth + real-shape body to a non-persisting endpoint | 200 with domain response | No, only when `mutatesState: false` is evidenced | grep evidence that the success path contains no `SaveChanges`, no repository write, no external write, no file write |
| T5 | Ephemeral round-trip | Auth + real mutation against a seeded test DB | 200 / 201 / 204 | Yes, against ephemeral data only | `kit-params.md` declares `dataSafety: ephemeral` AND user has explicitly opted in. Forbidden against shared dev / QA / any data source a developer or stakeholder reads from. |

Rules:
1. T1 is the floor for every endpoint regardless of verb. It is the only tier required when no safe deeper coverage exists.
2. T2 is required when CORS is part of the platform contract (any browser-facing API).
3. DELETE typically cannot use T3 (no body to invalidate); rely on T1 unless an opt-in T5 is approved.
4. T4 is the preferred deep probe for calculate / preview / quote / validate endpoints.
5. T5 is OFF by default. Real authenticated POST / DELETE against persistent data is **never** an API smoke – it belongs in the Step 12 integration suite where mutating verbs are intercepted by `page.route(...)`.

### OPTIONAL (can defer to Step 17)

| Test Type | When Created | Can Defer? |
|-----------|--------------|------------|
| Backend unit tests | Step 8 | Yes, ask after Step 9 |
| Backend contract tests | Step 9 | Yes, ask after Step 9 |
| Backend integration tests | Step 9 | Yes, ask after Step 9 |
| Angular component tests | Step 11 | Yes, ask after Step 11 |
| Frontend integration tests (hand-authored, beyond the generator) | Step 12 | Yes, ask after Step 12 |
| Smoke tests | Step 17 | No, required at Step 17 |
| E2E journeys | Step 17 | No, required at Step 17 |
| DB tests | Step 17 | Only if applicable |
| Accessibility tests | Step 17 | No, required at Step 17 |

## Step 17: Final Testing Gate

Step 17 is the **"put a bow on testing"** step. Everything deferred arrives here.

### Step 17 Checklist

- [ ] Page Object Model created (`tests/frontend/pageObjectModels/`)
- [ ] Final characterization tests run (100% behavior preserved)
- [ ] All unit tests complete and passing
- [ ] All contract tests complete and passing
- [ ] All integration tests complete and passing
- [ ] All Angular component tests complete and passing
- [ ] All frontend integration tests complete and passing
- [ ] DB tests created (if applicable)
- [ ] Navigation smoke tests created and passing
- [ ] E2E journeys from acceptance criteria
- [ ] Visual parity at 85% minimum (option to push to 90%)
- [ ] Ad hoc E2E flow testing added

### Step 17 Exit Criteria

- POM coverage: 100% (one Page class per route)
- Gherkin coverage: 100% (one feature file per user-facing feature)
- aria-label coverage: 100% (all interactive elements)
- data-testid coverage: 100% (all testable elements)
- Backend unit coverage: > 80%
- ALL smoke tests passing
- Visual parity: 85%+ on each screenshot

## Test Style Requirements

### Gherkin-Style Comments (Required for ALL tests)

Every test file must include Gherkin-style documentation:

```typescript
/**
 * Feature: Home page transformer list
 *
 * Scenario: User views transformer list on home page
 *   Given the user is authenticated
 *   And the user navigates to /home
 *   When the page loads
 *   Then the transformer list table should be visible
 *   And the table should contain at least one row
 */
```

### Test File Header (Required)

```typescript
/**
 * @file home-transformer-list.spec.ts
 * @description Tests for the home page transformer list functionality
 * @feature Home Page
 * @scenario Transformer List Display
 * @tags @smoke @regression
 * @owner Step 11
 * @created 2026-05-27
 */
```

## Implementation Notes

- Step 6 designs this structure but does NOT create tests
- Step 6 plans which tests go where and when they're created
- Each subsequent step follows this contract when creating tests
- Deferred tests are tracked in `.modernization/portal/data/json/test-accumulation-tracker.json`
- Visual parity gates are enforced at step completion, not skipped


## Slice Parity Floor And Flake Budget

- **Per-state parity floor for Step 17 exit.** Step 17 cannot exit ``Ready`` until ``frontend.routeStateParity`` reaches at least 90 percent across all ``screenshotCoverageMatrix`` rows that are not explicitly dispositioned. Each dispositioned row carries a ``parityDeferralId`` with reason and owner.
- **Slice-based progress over big-bang.** Every Phase 2 frontend pass must advance parity by at least 5 percentage points or report ``Partial``. Big-bang parity refreshes are forbidden; they hide regressions.
- **Per-slice diff retention.** Per-slice visual-diff artifacts under ``.modernization/portal/data/images/parity-diffs/`` are retained until Step 24 review closes, then archived per the cleanup contract.
- **Flake budget.** Each Playwright suite is allowed at most 1 percent flaky tests with retry-count 2. Quarantine list lives at ``.modernization/portal/data/json/test-flake-quarantine.json`` with ``{ testId, suite, owningStep, firstSeenUtc, lastSeenUtc, owner, plannedRemovalStep }``. A test on the quarantine list older than 14 days is a Step 17 gate failure.
- **Test isolation.** Tests must not depend on prior test state. Shared fixtures use per-test setup or transaction rollback. Cross-test ordering dependency is a contract violation.

