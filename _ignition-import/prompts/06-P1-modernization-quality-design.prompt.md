---
description: Create the required Discovery QA modernization design pack that turns legacy truth and solution design into drift-proof test-planning sources of truth.
agent: OpX-AppMod-P1-Discovery
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
---

# Modernization Quality Design

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 20-40 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 6 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 6 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

> **Legacy Unit Test Baseline Prerequisite** (runs BEFORE quality design work)
> - This gate establishes a frozen baseline of legacy code behavior via unit tests to support Step 7 characterization.
> - Run: `Use .github/prompts/P1-Discovery/legacy-unit-test-baseline.prompt.md and execute it in full.`
> - Proceed only when `step7ReadinessStatus: Ready`. If `Blocked` or `RequiresGeneration`, resolve the legacy test baseline first before continuing.
> - If legacy unit tests do not exist, this gate will generate minimal characterization-focused tests from Step 3 evidence.

> **Before designing tests**: Read `.github/instructions/testing-design-contract.instructions.md` for folder structure, parity gates, mandatory vs optional test types, user checkpoints, and visual parity remediation behavior.

About To Do
- Context: Step 3, Step 4, and Step 5 already produced Discovery truth, and this gate now has to turn that truth into one canonical QA planning pack before Step 7 begins.
- Dev work: Reconcile baseline gaps, planning decisions, suite ownership, characterization timing, and execution commands into the canonical QA artifacts instead of leaving them split across notes or stale JSON. Step 6 itself owns any helper-workflow reuse needed to prove the planning pack is current, traceable, and ready for Step 7.

Quality-design status model
- Return `discoveryInputStatus` as `Aligned`, `Partial`, or `Blocked`.
- Return `planningArtifactStatus` as `Current`, `Partial`, or `Blocked`.
- Return `step7ReadinessStatus` as `Ready`, `UserInputRequired`, `NotReady`, or `BlockedMissingArtifact`.
- Status semantics are mandatory:
  - `UserInputRequired`: planning artifacts are current, but one or more Step 5 user-input gates remain unresolved.
  - `BlockedMissingArtifact`: required upstream artifacts are missing, stale, or structurally incomplete.
  - `NotReady`: non-artifact, non-user-input planning quality gap that still needs deterministic remediation.
- Treat this gate as incomplete when Step 4 baseline blockers are not converted into owned suite or remediation rows, or when later Step 17 verification obligations are still implied instead of named.

Objective
- Run Step 6 `Modernization Quality Design` after Step 3 `Legacy System Analysis`, Step 4 `Baseline Acceptance-Criteria Review`, and Step 5 `Modernization Solution Design` before Step 7 begins.
- This prompt owns the Discovery QA planning pack that was previously overloaded into Step 5 and now feeds the dedicated Modernization Quality Design portal hub.
- Read the QA prompt stack in this exact order before producing or refreshing QA planning artifacts:
  1. `.github/prompts/qaTestPrompts/qa-core-master.prompt.md`
  2. `.github/prompts/qaTestPrompts/qa-core-contract.prompt.md`
  3. `.github/prompts/qaTestPrompts/qa-core-workflows.prompt.md`
  4. `.github/prompts/qaTestPrompts/qa-plan-strategy.prompt.md`
  5. `.github/prompts/qaTestPrompts/qa-legacy-characterization.prompt.md`
  6. Portal publication is paused, so leave the portal and test-plan pages unchanged in this gate
- Reuse `[WORKFLOW] Modernization Solution Design` as the planning companion workflow and `[WORKFLOW] Modern Build Planned QA Tests` as the suite-materialization companion workflow inside Step 6. Do not make Step 5 the owner again just because those reusable QA workflows are reused here.

Ownership boundary
- This gate owns the shareable requirements document, the test plan, the testing ownership matrix, the characterization ladder, executable testcase direction, testing strategy, regression plan, risk matrix, tool rationale, and ADO CI/CD planning.
- Step 5 owns the developer-facing modernization solution design, execution contract, migration structure, protected control-point decisions, and browser-surface planning pack when applicable.
- Do not let Step 5 reabsorb the QA planning pack. If Step 5 already drafted any of these QA-owned artifacts, reconcile them here and make Step 6 the canonical owner going forward.

Required inputs
- Step 3 legacy-system-analysis outputs.
- Step 4 baseline acceptance and compliance outputs.
- Step 5 development-planning outputs, especially `Modernization-Solution-Design.*`, `Modernization-Execution-Contract.*`, `Modernization-Phase-Assessment.*`, `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, and browser-surface planning artifacts when present.
- Runtime verification evidence.
- Review manifest.
- Current portal QA JSON or HTML outputs when present.
- Raw `LegacyCode/` and active `tests/` folders.
- Existing `.modernization/portal/data/json/qa-test-plan.json`, `.modernization/portal/data/json/executable-testcase-catalog.json`, `.modernization/ignition-artifacts/discovery/testing-ownership-matrix.generated.json`, and `.modernization/portal/data/json/characterization-test-planning.json` when present.

Fail-fast gates
- Stop immediately if Step 3, Step 4, or Step 5 evidence is missing, stale, or materially inconsistent.
- Stop immediately if the legacy unit test baseline gate (`.github/prompts/P1-Discovery/legacy-unit-test-baseline.prompt.md`) reports `step7ReadinessStatus: Blocked`. Resolve legacy test infrastructure before proceeding.
- Stop immediately if the QA prompt stack cannot be read in the required order.
- Stop immediately if the deterministic legacy characterization root, the modernization characterization testcase root, the characterization report root, or the official suite roots cannot be resolved from current evidence.
- Stop immediately if planned suites cannot be traced back to Step 3 behaviors, routes, APIs, reports, or high-risk flows.
- Stop immediately if the work would create a second competing source-of-truth JSON instead of refreshing the canonical planning artifacts already used by the repo.

Required outputs
- Refresh `.modernization/ignition-artifacts/discovery/*Business-Requirements-Draft.md` as the shareable SME-facing requirements document for modernization and testing intent.
- Refresh `.modernization/portal/data/json/qa-test-plan.json` as the authoritative planning and execution-status surface.
- Refresh `.modernization/portal/data/json/executable-testcase-catalog.json` as the authoritative planned-test catalog with exact suite roots, ownership, commands, and characterization lineage.
- Refresh `.modernization/ignition-artifacts/discovery/testing-ownership-matrix.generated.json` as the authoritative planned-versus-created ownership and count surface.
- Refresh `.modernization/portal/data/json/characterization-test-planning.json` as the authoritative phased characterization ladder and future-phase timing surface.
- Ensure `.modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json` exists as the Step 8 layering enforcement baseline.
- Ensure `.modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json` exists as the Step 8 closed-slice baseline.
- Keep portal pages and mirrors unchanged while portal publication is paused. Refresh only the source-of-truth artifacts in this step.
- Retire legacy planning mirrors once active consumers use the canonical JSON artifacts. Do not treat any compatibility mirror as the primary source of truth.

Required planning content
- The requirements document must carry the signoff-friendly summary, functional requirement ids, user stories derived from Step 3 evidence, open questions, test strategy summary, regression strategy summary, risk summary, tool rationale summary, and ADO CI/CD planning summary.

**Test Coverage Targets (MANDATORY)**
The QA planning pack MUST define explicit coverage thresholds:
- **Backend Coverage Targets**:
  - Unit test coverage: > 80% line coverage on Library business logic
  - Integration test coverage: all database and external service seams
  - Contract test coverage: all API endpoints match OpenAPI spec
  - Health check endpoints: /health, /ready, /live required
- **Frontend Coverage Targets**:
  - Playwright POM coverage: one Page Object class per route
  - Gherkin scenario coverage: one feature file per user journey
  - Accessibility coverage: 100% of interactive elements with aria-label
  - Testability coverage: 100% of testable elements with data-testid
  - Visual parity: before/after screenshots for all migrated routes
- **Coverage Verification**:
  - Step 17 MUST verify all coverage targets before Step 18
  - Step 24 Technical Review will audit compliance
  - Gaps found at Step 22 should be rare, not the norm
- **Step 17 Exit Criteria** (Plan these now, verify then):
  - POM coverage: 100% (one Page class per route)
  - Gherkin coverage: 100% (one feature file per user-facing feature)
  - aria-label coverage: 100% (all interactive elements)
  - data-testid coverage: 100% (all testable elements)
  - Backend unit coverage: > 80%
  - ALL smoke tests passing

**Screenshot Coverage Matrix (MANDATORY when browser-surface is in scope)**
Step 6 MUST carry Step 3 `screenshotCoverageMatrix` into the QA plan so coverage math is state-based, not route-based.
- Total required captures = total rows in `screenshotCoverageMatrix`. Phase 2 `frontend.screenshotsCaptured` percentages report against this denominator.
- Every `migrationEligible: true` route MUST have at minimum these planned states: `idle`, `populated`, `empty` (when applicable), `validationError` (when the route has a form), `postAction` (per safe command), `dialogOpen` (per `dialogContext: true` control), `focus` (one per primitive family), `authStateVariants` (one per distinct role render).
- Step 6 MUST flag any `screenshotCoverageMatrix` row with `captureStatus` other than `captured` or `captured-user-provided` as a tracked remediation row in the QA test plan with the exact `blockerReason`. Do not silently exclude blocked captures from the denominator.
- The QA plan MUST require Step 10, 11, 13, 15, and 16 to refresh the captures for the routes they touch and to update `capturedScreenshots` in `componentCensus`. A pass that touches a route without refreshing captures is a planning violation.

**Fusion Primitive Coverage Census (MANDATORY when browser-surface is in scope)**
Step 6 MUST verify Step 3 `fusionPrimitiveCoverageCensus` against the live Fusion package surface before Phase 2 starts so Fusion gaps are not discovered mid-swap.
- Every `capabilityId` row MUST have `mcpVerifiedUtc` set within the current Discovery window. Stale verification is a Step 6 gap.
- Every row with `gapState: needsWrapperExtension` MUST be cross-referenced to a Step 5 `Wrapper Capability Plan` row. If the cross-reference does not exist, route back to Step 5.
- Every row with `gapState: needsFusionFeatureRequest` or `noFusionEquivalent` MUST be recorded in the QA risk matrix with the planned bridge or deferral and the owning step.
- Phase 2 `frontend.fusionPrimitiveCoverage` percentages report against total capability rows.

**Modernization Progress Metric Contract (MANDATORY)**
Step 6 MUST publish the denominators every Phase 2 progress report consumes so percentages are real, not estimates.
- Refresh `.modernization/portal/data/json/qa-test-plan.json` with a `progressDenominators` block carrying at minimum: `totalBackendFilesPlanned`, `totalApiEndpoints`, `totalRoutes`, `totalComponents`, `totalMigrationEligibleControls`, `totalSubPatterns`, `totalRequiredScreenshots`, `totalFusionCapabilities`, `totalPlannedPoms`, `totalPlannedGherkinFeatures`, `totalTestableControls`, `backendCoverageTarget`.
- Each denominator MUST cite its source artifact and field path so the count is reproducible.
- The contract in `/.github/instructions/appmod-phase-agent-contract.instructions.md` `### Modernization Progress Metric` requires Phase 2 step responses to compute `done / remaining / total (percent%)` against these denominators. A Phase 2 step that reports progress without these denominators is consuming guesses, not measurements.
- Step 17 exit criteria MUST verify every denominator-backed percentage reaches its planned target or is explicitly accepted as a deferral with a recorded `deferralId`.

**Discovery-Backed Denominator Extensions (MANDATORY)**
The Step 5 planning extensions added by the slice-parity and ROI-first kit upgrade introduce new denominators every Phase 2 progress report MUST honor. Add to ``progressDenominators`` in ``qa-test-plan.json`` and cite the source artifact in ``decisions.json``:
- ``totalErrorStates`` from Step 3 ``errorStateCatalog[]`` length (404, 500, 401, 403, session-expired, network-down, concurrency, validation-server, rate-limited, maintenance). Step 17 verifies coverage.
- ``totalExportSurfaces`` from Step 3 ``exportSurfaceCatalog[]`` length (print, pdf, excel, csv, email, clipboard, download). Step 17 verifies each renders the planned artifact.
- ``totalRealtimeSurfaces`` from Step 3 ``realtimeSurfaceCatalog[]`` length. Step 17 verifies push semantics preserved.
- ``performanceBudgetRoutes`` from Step 5 ``performanceBudgetPlan[]`` length, with per-route ``budgetTargets`` carried through. Step 17 measures actuals vs targets.
- ``initialBundleBytesMaxPerRoute`` and ``lazyChunkBytesMaxPerRoute`` carried from Step 5. Step 17 measures actual gzipped bundle sizes.
- ``accessibilityScoreTargetPerRoute`` from Step 5 ``accessibilityAuditPlan`` (default Lighthouse a11y >= 90). Step 17 records actual score.
- ``flakeBudgetPercent`` from Step 5 ``testIsolationPlan`` (default 1 percent). Step 17 fails if quarantine exceeds budget or any quarantined test exceeds ``quarantineLifetimeDays``.
- ``dataFixtureCoverage`` from Step 5 ``dataFixturePlan[]`` length. Step 17 verifies every planned fixture is reachable.
- ``localesPlanned`` from Step 5 ``localizationPlan.supportedLocales``. Step 17 verifies each locale renders without missing keys.
- ``routeStateParityFloor`` set to 90 percent unless the agent contract Modernization Progress block carries an explicit accepted deferral. Step 17 verifies ``frontend.routeStateParity`` meets this floor.
Every percentage Phase 2 reports against these denominators MUST be ``done / total`` with both numerator and denominator citing real artifacts. Estimated percentages are forbidden by ``/.github/instructions/appmod-phase-agent-contract.instructions.md`` rule 20.

**Per-Control Test Coverage Mapping (MANDATORY when browser-surface is in scope)**
Step 6 MUST tie Step 3 `uiControlClassification` rows to concrete planned test rows so Step 17 verification is mechanical.
- For each row with `migrationEligible: true`, plan at minimum: one POM selector entry keyed by `a11yContract.testIdPattern`, one Gherkin scenario per `dialogContext` it appears in, and one visual-parity capture in the route POM.
- For each row with `migrationEligible: false` (parity scaffolds and reverse-engineering capture controls), record an explicit exclusion row in the catalog with reason `parity-scaffold` so Step 17 coverage math does not double-count them.
- For each `compositeGroupId`, plan one Gherkin scenario that exercises the composite together (numeric input plus adjuster buttons, search input plus action) rather than three independent control scenarios.
- For each `requiresWrapperCapability` Step 5 deferred to `IntentionallyDeferred`, record a tracked exclusion row referencing the Step 5 deferral id so Step 17 does not flag it as missing coverage.
- The catalog row `description` MUST reference the `controlId` so Step 17 can prove POM/test-row alignment by id, not by label drift.

**API Smoke Probe Plan (MANDATORY when backend API surface is in scope)**
Step 6 MUST plan a backend API smoke probe that proves every endpoint in `totalApiEndpoints` is **reachable, routed, and auth-gated** without ever mutating data. This is the backend counterpart to the Step 17 frontend navigation smoke and is the first proof requested by every Phase 2 step before deeper integration work runs.
- **Source of truth.** The endpoint set is the Step 3 / Step 9 API inventory (controllers + actions + verbs). The probe MUST cover 100% of `totalApiEndpoints`. Missing endpoints are a planning gap, not an opt-out.
- **Default-safe contract.** The probe MUST default to read-only behavior. Mutating verbs (POST / PUT / PATCH / DELETE) are smoked under one of the explicit safety tiers below; never by sending a real mutation. This honors the kit's "GET-first, do not modify data" data-safety posture.
- **Catalog entries.** Each endpoint produces one catalog row with `category: "api-smoke"`, `owningStep: 9`, the chosen `safetyTier`, the expected status code, and the verification evidence the tier requires (file + line for Tier 3, capability marker for Tier 4, ephemeral-data declaration for Tier 5).
- **Output location.** Authored under `tests/backend/smoke/` (sibling to the existing `tests/frontend/smoke/`). Run as a gate at Step 9, re-run at Step 12 (before integration suite) and Step 17 (final).
- **Denominator.** The probe reports `apiSmokeCoverage = passing / totalApiEndpoints`. 100% is required before any Step 12 integration test runs; sub-100% must be a tracked deferral with an explicit `deferralId`.

**API Smoke Safety Tiers (MANDATORY — Step 6 MUST assign a tier per endpoint)**

Pick the lowest tier that proves reachability. Higher tiers require named evidence recorded in the catalog row.

| Tier | Name | What it sends | What it proves | Mutates? | Evidence the catalog row MUST carry |
| ---- | ---- | ------------- | -------------- | -------- | ----------------------------------- |
| **T1** | Unauthenticated reachability | Real verb (GET/POST/PUT/PATCH/DELETE), **no auth header / no cookie** | Endpoint exists, route is registered, auth middleware is wired, request short-circuits at auth before reaching the handler. Expected: **401 or 403**. | No (handler never runs) | `expectedStatus: 401\|403` |
| **T2** | CORS preflight | `OPTIONS` with the documented `Origin` and `Access-Control-Request-Method` headers | Route is published, CORS policy returns the documented allow-list. Expected: **204 or 200**. | No (OPTIONS is never a handler call) | `expectedStatus: 204\|200`, `expectedHeaders: [...]` |
| **T3** | Authenticated invalid-body rejection (POST/PUT/PATCH only) | Authenticated request with an **intentionally invalid body** (wrong type, missing required field, malformed JSON) | Validation gate (ModelState, FluentValidation, custom guard) executes BEFORE persistence and returns 400/422 `ProblemDetails`. | No, **only when the gate evidence is recorded** | `validationGate: { file, line }` + `firstMutationCall: { file, line }`. The gate line MUST precede the mutation line in the same code path. Without this evidence the row is rejected. |
| **T4** | Dry-run / preview / calculate-only POST | Authenticated request with a real-shape body to an endpoint whose success path performs **no persistence** (e.g. calculate, preview, validate, quote) | Full handler executes end-to-end. Expected: **200** with a domain response. | No, **only when `mutatesState: false` is evidenced** | `mutatesState: false` with grep evidence that the success path contains no `SaveChanges`, no repository write, no external write, no file write |
| **T5** | Ephemeral round-trip (POST then DELETE, or DELETE of seeded fixture) | Authenticated mutating request against an **ephemeral test database** seeded just for the probe | Real CRUD path works end-to-end. | **Yes — only against ephemeral data** | `kit-params.md` carries `dataSafety: ephemeral` AND the user has opted in by name. Default OFF. Forbidden against shared dev, QA, or any data source whose loss would be noticed. |

**Tier-selection rules:**
1. Every endpoint gets **T1 as a floor**, regardless of verb. T1 is the universal liveness probe and is the only tier required when the endpoint has no safe deeper coverage.
2. Every endpoint also gets **T2** when CORS is part of the platform contract (any browser-facing API). T1 + T2 together produce the curl-style health table.
3. A POST / PUT / PATCH endpoint MAY add T3 when the validation-gate evidence is real and recorded. DELETE generally cannot use T3 because it has no body to invalidate.
4. A POST endpoint MAY add T4 when `mutatesState: false` is evidenced. This is the preferred deep probe for calculate, preview, quote, validate, and similar pure-compute endpoints.
5. T5 is OFF by default. Step 6 MUST NOT plan a T5 probe unless `kit-params.md` declares an ephemeral data surface AND the user explicitly opted in. T5 is forbidden against the same data source any developer or stakeholder reads from.
6. Real authenticated POST / DELETE against persistent data is **never** an API smoke. It belongs in the Step 12 integration suite, where mutating verbs are intercepted by `page.route(...)` per the existing UI -> API Integration contract.

**Catalog example (per-endpoint row):**
```json
{
  "id": "STEP9-SMOKE-CALCULATEPJ-001",
  "category": "api-smoke",
  "owningStep": 9,
  "endpoint": "POST /api/CalculatePJ",
  "safetyTier": "T4",
  "expectedStatus": 200,
  "mutatesState": false,
  "mutationEvidence": "grep showed CalculatePjController.Post success path returns CalculationResults without DbContext.SaveChanges or repository writes",
  "testFile": "tests/backend/smoke/PjCalculationSmokeTests.cs",
  "testMethod": "CalculatePJ_PreviewBody_Returns200",
  "status": "Planned"
}
```

**Playwright + Gherkin Architecture (MANDATORY)**
Define the test architecture that Steps 11-17 will build:
- **Directory Structure**:
  - `tests/frontend/e2e/` - Playwright tests
  - `tests/frontend/e2e/pages/` - Page Object Model classes
  - `tests/frontend/e2e/support/` - Shared utilities
- **POM Naming Convention**:
  - `{RouteName}Page.ts` for each route (e.g., `DashboardPage.ts`)
  - All inherit from `BasePage.ts`
  - All selectors use `data-testid` attributes

**Test Scenario Planning (Step 6 Creates, Steps 7-17 Implement):**

Step 6 MUST plan test scenarios in `executable-testcase-catalog.json` with detailed test case structure.

**Test Case Entry Format:**
```json
{
  "testCases": [
    {
      "id": "STEP8-ORDER-001",
      "caseId": "STEP8-ORDER-001",
      "feature": "Order Service Business Logic",
      "scenario": "Service needs to calculate order total with valid items",
      "description": "The CalculateTotal method should sum all item prices correctly without errors",
      "input": "Valid Order with 3 items priced at $10, $20, $30",
      "expected": "The method returns total of $60",
      "testFile": "tests/backend/unit/OrderServiceTests.cs",
      "testMethod": "CalculateTotal_ValidItems_ReturnsCorrectSum",
      "category": "unit",
      "owningStep": 8,
      "status": "Planned"
    }
  ]
}
```

**Required catalog fields per row:**
- `category` — one of `characterization` | `unit` | `integration` | `contract` | `browser-contract` | `e2e`.
- `owningStep` — the Phase 2 step that implements the test. Use the routing table below.

**owningStep routing (planning-time decision, executed by Phase 2):**

| Category | owningStep | Why | Canonical `testFile` location |
| --- | --- | --- | --- |
| `characterization` (baseline behavior pinned BEFORE the .NET upgrade so QA can prove parity AFTER) | **7** | Step 7 DEV authors and runs these. The legacy run and the post-upgrade run both happen during Step 7 to prove the upgrade preserved behavior. **Do not place characterization scenarios in Step 6 implementation — Step 6 plans them, Step 7 implements them.** | `LegacyCode/Characterization/Baseline/...` (single .NET test project under the preserved legacy tree, so the frozen baseline ships with the code it protects) |
| `unit` (service behavior in `src/<App>.Library`) | **8** | Step 8 DEV moves code into the target architecture and implements every unit-class catalog entry. | `tests/backend/unit/...` |
| `integration` / `contract` (API surface, auth, error envelope) | **9** | Step 9 DEV hardens the .NET integration surface. | `tests/backend/contractApi/...` or `tests/backend/integrationBackend/...` |
| `browser-contract` / `e2e` (frontend lanes) | 10-16 as appropriate | Per the frontend step matrix; default to the earliest step where the route or primitive is in scope. | `tests/frontend/...` |

Planning rule: every characterization scenario derived from legacy facts (Step 3 inventory + Step 5 control points) MUST be written into the catalog with `category: "characterization"` and `owningStep: 7`. Step 7 QA uses these rows as the parity verification work order: run legacy-green then modern-green and compare. Step 7 DEV does not run characterization tests. Discovery does not create the test code itself.

**Characterization Scenario Derivation Rules (MANDATORY — apply before writing `category:characterization` catalog entries)**

Characterization is **behavioral parity**, not just source-shape lock. The catalog must prove that every behavior family below survives the .NET upgrade (Step 7) and every later modernization slice (Steps 8-16) unchanged.

**Backend behavior families that MUST be covered (Step 7 baseline + Step 7 modern parity run):**

1. **Business rules** — conditional logic, eligibility rules, state-machine transitions, workflow gating.
2. **Calculations** — arithmetic, aggregations, rounding, unit conversions, ratio/factor lookups, multi-step formulas.
3. **Validation behavior** — required-field checks, range/format/regex checks, cross-field rules, server-side guards that throw or return 4xx.
4. **API responses** — status codes, response shape, response body content for happy path AND every documented error path (400/401/403/404/409/422/500). Empty-result and large-result responses included.
5. **Database side effects** — inserts, updates, deletes, soft-delete flags, audit columns, cascade behavior, transaction boundaries, optimistic-concurrency tokens.
6. **Legacy quirks** — known workarounds, intentional non-standard returns, suppressed exceptions, hard-coded edge-case branches, vendor-specific encoding/quoting, time-zone or culture-specific formatting, integer-overflow tolerances. Anything Step 3 flagged as "weird but load-bearing."
7. **Permission behavior** — `[Authorize]` / `[AllowAnonymous]` enforcement, role checks, claim checks, owner-only access, multi-tenant scoping, anonymous-vs-authenticated response differences.

Each backend behavior family above MUST appear in the catalog as **three coordinated entries** when the seam has any business weight: one `category:"characterization"` (parity proof, owningStep 7), one `category:"unit"` (isolated behavior in `src/<App>.Library`, owningStep 8), and one `category:"integration"` or `category:"contract"` (API surface, owningStep 9). Thin no-logic seams may collapse to a single characterization entry — annotate `coverageLevel: "single-layer"` so QA Lane 5 can audit the decision.

**Frontend behavior coverage is delegated to the UI Screenshot Parity lane.** Step 6 does NOT enumerate frontend behavior families as catalog entries. Frontend parity is proved by the visual-parity gates at Steps 11, 12, 15, and 18 (see `.github/instructions/testing-design-contract.instructions.md` — Parity Gates by Step). The legacy screenshots captured in Step 3 are the contract; the modern screenshots at each gate are the proof.

**Source-shape lock rules (C1-C9) — structural floor, not a substitute for backend behavior families above**

The C1-C9 rules below produce the **structural floor**: they prove the upgrade did not silently delete or rename a controller, action, entity, config key, startup hook, view marker, helper method, or JS file. They are necessary but not sufficient. Every behavior family above must still be planned as its own behavioral catalog entry on top of the C-series structural entries.

Apply these 9 rules mechanically against the Step 3 legacy-system-analysis inventory and `LegacyCode/` source shape. Every rule that finds at least one matching artifact in the legacy surface must produce at least one catalog entry with `category: "characterization"` and `owningStep: 7`. Step 7 QA runs these entries as the parity proof between the frozen baseline and the upgraded workspace. Step 6 catalogs — it does not write test code.

**Rule C1 — Controller class presence**
For every `.cs` file under `Controllers/`, plan one scenario that asserts the class declaration exists with the exact class name. Use a Theory/InlineData pattern when there are many controllers so a single test method covers all of them. This is the minimum floor; Rules C2 and C3 build on top of it for non-trivial controllers.

**Rule C2 — API endpoint action name and HTTP verb**
For every controller that exposes API routes, plan scenarios that assert the action method names exist with their expected HTTP verb attributes (`[HttpGet]`, `[HttpPost]`, `[HttpPut]`, `[HttpDelete]`). Mid-tier controllers (ratio, temp-ratio, lookup tables) that have only class-presence coverage from Rule C1 are thin seams — Rule C2 fills them. One Fact per controller/action-family is sufficient when the family is uniform.

**Rule C3 — API contract shape for mutating endpoints**
For every POST, PUT, or DELETE endpoint that carries a request body or returns a meaningful response, plan a scenario that asserts the parameter type, the validation guards (conflict check, required-field check), and the expected response shape (200/201/409/400) are present in the source. These are behavioral contracts — if the upgrade silently drops a guard or renames an input type, this scenario catches it.

**Rule C4 — Data model entity shape**
For every EF entity (every `DbSet<T>` member on the DbContext), plan a scenario that asserts: the table-name annotation, the primary-key annotation, required/maxlength constraints, and any legacy mapping quirks (column name overrides, composite keys). Run these against the upgraded codebase to prove EF metadata was not silently removed by the framework migration.

**Rule C5 — Config seams**
For every Web.config or App.config entry that drives runtime behavior — connection string names, app setting keys (ENV, log path, feature flags), authentication configuration — plan a scenario that asserts the key exists with the expected literal or pattern. Split into sub-scenarios for DEV/QA/PROD connection names when the config has environment-specific named blocks.

**Rule C6 — Bootstrap and startup sequence**
For the application startup surface (`Global.asax`, `WebApiConfig`, `RouteConfig`, `FilterConfig`, `BundleConfig`, `Startup.cs`), plan scenarios that assert: the bootstrap methods exist by name, route templates carry the expected literal pattern (e.g., `api/{controller}/{id}`), global filters are registered, and bundle keys are registered. One scenario per startup file is sufficient; do not over-specify — assert the named seam, not every implementation detail.

**Rule C7 — View and template behavioral markers**
For every view file (`.cshtml`, `.html`) that carries business-critical UI markers — AngularJS directives (`ng-click`, `ng-model`, `ng-repeat`), tab/accordion `data-toggle` attributes, bundle render calls (`@Scripts.Render`, `@Styles.Render`), print-flow triggers, environment-conditional titles — plan a scenario per marker family. Use Theory/InlineData to sweep multiple markers across multiple views in a single test method. These lock the UI contract surface so a runtime change cannot silently drop a required directive.

**Rule C8 — Calculation and business-logic helper contracts**
For every helper or service class that performs calculation, transformation, or data-shaping logic (e.g., `Calculator.cs`, `PJCalculator.cs`, `ExportHelper.cs`), plan a scenario that asserts: the public method names exist, the parameter count and type pattern match, and any header-array or output-format contract is preserved. These are source-shape locks, not behavioral unit tests — the goal is to prove the upgrade did not rename or remove a business-critical method.

**Rule C9 — JS controller file and function-name presence (browser lane, owningStep: 10+)**
For every AngularJS controller or service file (`mainController.js`, `pjApp.js`, `pjService.js`, etc.), plan one scenario per file that asserts the file exists at its expected path and the primary controller/factory registration string is present as a marker. **Assign these entries `owningStep: 10`** (or the earliest frontend step where the route is in scope), NOT `owningStep: 7`. JS characterization is browser-contract territory, not .NET characterization. Catalog them here so Step 10 has a work order; do not execute them in Step 7.

**After applying all 9 rules:** every seam the upgrade could silently break should have a catalog entry. When a controller is covered only by Rule C1 (class presence) and Rules C2/C3 were not applied, explicitly mark that row as `coverageLevel: "class-presence-only"` in the catalog. Step 7 QA Lane 5 (coverage gap assessment) will route those thin seams back here when they cover a business-critical API.

**Per-Service Unit Test Scenario Derivation (MANDATORY — apply before writing catalog entries)**

Input contract: Step 3 must have produced the **Service & Behavior Inventory** at `.modernization/ignition-artifacts/discovery/service-behavior-inventory.json`. If that artifact is missing or any service rows lack the required per-method facts (branchingParameters, throwGuards, nullCoalescingDefaults, listOrCollectionReturn, displayDecorators, delegationPaths, nullable return flag), STOP and route back to Step 3 to complete the inventory. Do not improvise from the legacy code at planning time — fix Step 3 instead.

For each service row in the inventory, apply these 8 rules mechanically to derive the complete set of test scenarios that must appear in `executable-testcase-catalog.json`. The mapping is deterministic: each rule reads named fields from the inventory and emits one or more catalog entries with a CaseId, owning step, and the exact behavior the test must prove. Phase 2 implements these entries verbatim. Phase 2 does NOT derive scenarios.

1. **Every public method gets at least one planned scenario.**
   List all public methods from the interface or class. Each one must produce at least one catalog entry. Do not stop after the most visible or frequently-called method.
2. **Methods returning nullable (`T?`) get a found-path scenario AND a not-found scenario.**
   Plan both. The not-found path is a real business rule — the caller depends on getting `null` back rather than an exception.
3. **Every guard that throws gets its own scenario.**
   Guards like duplicate-ID rejection, required-field enforcement, or invalid-state protection are business rules. Plan a catalog entry that names the guard condition and what exception is expected.
4. **Methods that branch on a mode or flag get a scenario per distinct mode.**
   Example: a `FindMaxLoadFactorMultiplier` parameter with `"Manual Overload"` and `"Normal Overload"` takes different code paths. Plan one catalog entry per mode the app actually uses — not just the default.
5. **Methods with null-coalescing defaults (`??=`) get two scenarios: null-supplied and non-null-supplied.**
   Plan one scenario that proves the default fills in when the caller passes `null`, and one that proves a non-null caller-supplied value is NOT overwritten. Both are correctness rules.
6. **List and collection methods get an empty-collection scenario.**
   Plan a scenario where the repository returns zero rows and the service returns an empty list rather than throwing.
7. **Display decorators applied on read get an idempotency scenario.**
   If the service adds a prefix, suffix, or transforms a field on the way out, plan a scenario that calls the read method twice on the same record and asserts the decoration is only applied once.
8. **Delegation orchestrators get one scenario per delegation path.**
   If a service has three export methods that each delegate to a different workbook helper, each delegation path needs its own catalog entry. One test does not cover all three.

**Applying this during Step 6 means every gap has a CaseId before a single test file exists.** Steps 7-17 implement the planned entries verbatim. Step 17 verifies them. Traceability runs from Step 3 service-method row → Step 6 catalog entry → Step 8/11/12/etc. test method → Step 17 verification.

**Phase 2 has no derivation authority.** If Phase 2 finds a test it believes should exist but the catalog does not list it, the agent must STOP and route back to Step 6 to refresh the catalog. The catalog is the work order. Adding tests in Phase 2 without first updating the catalog is a phase-discipline violation and will not survive the kit being reused on the next application.

**Per-Route Behavior Plan (MANDATORY — drives Step 11 behavior preservation and Step 12 per-route API wiring)**

Steps 11 and 12 ship dead routes when they only have to prove "the page renders" and not "the page works." Step 6 closes that gap by producing a per-route behavior plan that those steps tick off, derived from the Step 3 legacy inventory and the Step 5 control-point contract.

Write the per-route behavior plan to `.modernization/portal/data/json/per-route-behavior-plan.json`. Every browser route in the modernized scope must appear as one entry with:
- `route` — the modern route path (e.g., `/home`, `/customers/:id`).
- `legacyRoute` — the matching legacy route or view path from the Step 3 inventory.
- `primaryDataCalls` — array of `{httpMethod, endpointPath, authProtection, expectedSuccessStatus, consumedBy}` where `authProtection` is `bearer`, `cookie`, `anonymous`, or the Step 5-approved equivalent, and `consumedBy` names the migrated component or service that must render the response. This is the list Step 12 proves are live per route.
- `interactiveElements` — array of `{kind, legacyHandlerReference, modernBindingTarget, ownerStep}` enumerating every button, link, tab, dropdown, modal trigger, banner trigger, export, print, download, upload, drag-drop, copy-to-clipboard, keyboard shortcut, focus trap, and navigation control the legacy route exposes. `ownerStep` is `11` when the migration pass must port the handler shape itself, `12` when the wiring depends on the protected API/auth seam, or `15+` when the upgrade lane will replace the control family. This is the list Step 11 ticks off as behavior preservation.
- `modalsAndBanners` — array of `{trigger, kind, ownerStep}` enumerating legacy authorization banners, access-denied overlays, unsaved-changes guards, error overlays, success toasts, confirmation dialogs, and other surface behaviors the route depends on.
- `placeholderDataPolicy` — `forbidden` for routes that have a real backing call in the Step 3 inventory, or `allowedUntilStep<N>` when placeholder rendering is explicitly approved for a later slice.

## Closeout Summary

- After the step response is saved, refresh `.modernization/.readme/.StepSummary.md` with a short human-readable entry for Step 6.
- Keep the summary skimmable: when the QA pack was refreshed, the main planning artifacts touched, and the Step 7 readiness result.

**Step 6 Exit Criteria:**
- [ ] Legacy unit test baseline gate completed: `step7ReadinessStatus: Ready` reported from `.github/prompts/P1-Discovery/legacy-unit-test-baseline.prompt.md`.
- [ ] Step 3 Service & Behavior Inventory present and complete; if not, route back to Step 3 and rerun.
- [ ] All legacy behaviors from Step 3 mapped to test scenarios.
- [ ] Each scenario has: CaseId, Scenario, Description, Input, Expected.
- [ ] Each scenario assigned to owning step (7-17).
- [ ] For every row in the Service & Behavior Inventory, every applicable rule from the 8-rule scan has produced at least one catalog entry. The catalog must be traceable back to the inventory: each catalog entry references its source `className.methodName` and the rule number that produced it.
- [ ] `executable-testcase-catalog.json` created and complete (no Phase 2 step is allowed to add catalog entries on its own).
- [ ] `test-accumulation-tracker.json` initialized.
- [ ] `per-route-behavior-plan.json` created with one entry per in-scope modern route, each entry carrying `primaryDataCalls`, `interactiveElements`, `modalsAndBanners`, and `placeholderDataPolicy`. Routes whose interactive controls or data calls are not enumerated are a Step 6 blocker, not a Step 11 or Step 12 discovery item.
- [ ] Functional Parity Ledger schema gate: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 6 -Mode Output`. Require `RESULT: OK` before closing. This confirms the `interaction-wiring-inventory.json` has the Phase 1 `effectClass` schema, so the behavior plan maps every control by its real effect type (mutate/filter/read/navigate/export/open-dialog) rather than treating everything as `ui-only`. If blocked, re-run Step 3 (`03-P1-generate-manifest.ps1`) to regenerate the inventory with the Phase 1 schema, then re-run this gate.

**Steps 7-17 implement these planned catalog entries verbatim as test files. Steps 7-17 do not analyze the legacy code, do not derive new scenarios, and do not add unplanned tests. If a Phase 2 step finds a gap, the loop is: stop Phase 2 → route back to Step 3 or Step 6 → refresh the inventory and catalog → resume Phase 2.**

- NO raw CSS or XPath selectors allowed
- **Gherkin Naming Convention**:
  - `{feature-name}.feature` kebab-case
  - Scenarios use Given/When/Then format
  - Business-readable language, not technical
  - Required tags: `@smoke`, `@regression`, `@journey`, `@critical`
- **data-testid Convention**:
  - Format: `{component}-{element}-{purpose}` (e.g., `user-form-submit-button`)
  - Required on: buttons, inputs, links, cards, tables, modals, navigation
- **aria-label Convention**:
  - Required on: all interactive elements
  - Human-readable action descriptions
  - Match data-testid purpose when applicable
- This architecture MUST be created at Step 8 and expanded through Step 17.

**Step-by-Step Testing Accumulation Plan (MANDATORY)**
Define exactly what each step must contribute to reach 95+ at Step 22:

**Step 7 - Backend Upgrade:**
- Create/validate `tests/backend/unit/` directory structure
- Ensure all existing backend tests pass after upgrade
- Fix async anti-patterns during upgrade
- Target: Backend compiles, existing tests green

**Step 8 - Backend Formation:**
- Create unit tests for each service moved to Library
- Create `tests/backend/unit/{ServiceName}Tests.cs` for each service
- Use xUnit with `[Fact]` and `[Theory]`
- Target: > 60% unit coverage on Library (grow to 80% by Step 9)

**Step 9 - Backend Hardening:**
- Create `tests/backend/contractApi/` for API contract tests
- Create `tests/backend/integrationBackend/` for integration tests
- Add health check endpoint tests
- Verify IFusionLogger/IFusionCache usage where applicable
- Target: > 80% backend coverage, ALL API endpoints contract-tested

**Step 10 - Frontend Foundation:**
- CREATE the test foundation (this is where testing infrastructure starts):
  - `tests/frontend/e2e/playwright.config.ts`
  - `tests/frontend/e2e/global-setup.ts`
  - `tests/frontend/e2e/pages/BasePage.ts`
- Create initial POM class for EACH scaffolded route shell
- Create skeleton `.feature` files for EACH route family
- Install Playwright + @cucumber/cucumber
- Target: Test infrastructure exists, one POM per shell, `npx playwright test` runs

**Step 11 - Frontend Migration:**
- UPDATE POM classes for each migrated route
- ADD aria-label to ALL migrated interactive elements
- ADD data-testid to ALL migrated testable elements
- CREATE/update Gherkin scenarios for migrated features
- Target: POM coverage matches migration progress, aria/testid on all migrated

**Step 12 - Platform Integration:**
- ADD auth-related POMs (LoginPage, CallbackPage)
- ADD Gherkin scenarios for login/logout/callback
- ADD aria-label/data-testid for auth UI elements
- Target: Auth flows fully tested via POM and Gherkin

**Step 13 - Shell Stabilization:**
- VERIFY POM coverage for stabilized shell
- ADD tests for navigation, shell interactions
- Target: Shell navigation fully POM-covered

**Step 14 - UI Inventory:**
- VERIFY all components have aria-label/data-testid
- Gap analysis for missing testability attributes
- Target: Inventory shows 100% accessibility coverage plan

**Step 15-16 - UI Upgrades:**
- UPDATE POMs for upgraded components
- VERIFY upgraded components maintain aria/testid
- Target: Upgraded components fully testable

**Step 17 - S-TIER VERIFICATION GATE:**
- VERIFY 100% POM coverage
- VERIFY 100% Gherkin coverage
- VERIFY 100% aria-label coverage
- VERIFY 100% data-testid coverage
- VERIFY > 80% backend unit coverage
- FIX any gaps found
- RUN all smoke tests, verify 100% pass
- Target: Quality Score 95+ ready for Step 22

- `qa-test-plan.json` must own the testing strategy, suite families, environment expectations, entry and exit criteria, regression plan, tool rationale, ADO CI/CD lane and pipeline expectations, explicit Playwright allocation across frontend integration, whole-frontend smoke, journeys, UI parity, accessibility, and visual proof when a managed browser surface exists, and exact run expectations by suite family.
- `testing-ownership-matrix.generated.json` must own the exact suite roots, owning step, first create step, first run step, planned counts, carry-forward posture, materialization posture, and deferred or blocked rationale.
- `executable-testcase-catalog.json` must own every planned testcase or planned suite slice, stable ids, exact owning step or required companion gate, canonical root, planned command, characterization lineage, whether the case is create, update, run, or defer, whether the case lands in backend, frontend, Playwright, or modernization parity roots, and whether later Step 17 verification depends on refresh-safe preflight or protected browser-to-API proof.
- `characterization-test-planning.json` must own `Baseline` plus the later step-name modernization phases through `Deployment & Clean Up`, the legacy baseline location, the modernization characterization testcase root, the per-step Markdown report path, the owner gate, when each phase first runs, and whether the phase is baseline capture, parity carry-forward, or modernization-only.
- Keep the human-readable requirements document and portal pages derived from these JSON sources rather than inventing conflicting second narratives.

**Test Accumulation Tracker Artifact (MANDATORY)**
Create and maintain `.modernization/portal/data/json/test-accumulation-tracker.json`:
```json
{
  "currentStep": 8,
  "lastUpdated": "2025-01-15T10:00:00Z",
  "backendCoverage": {
    "unitTestCount": 0,
    "coveragePercent": 0,
    "step6Target": 60,
    "step7Target": 80,
    "step15Target": 80,
    "status": "NotStarted"
  },
  "frontendCoverage": {
    "pomClassCount": 0,
    "routeCount": 0,
    "pomCoveragePercent": 0,
    "target": 100,
    "status": "NotStarted"
  },
  "gherkinCoverage": {
    "featureFileCount": 0,
    "scenarioCount": 0,
    "stepDefinitionCount": 0,
    "undefinedStepCount": 0,
    "featureCount": 0,
    "coveragePercent": 0,
    "target": 100,
    "status": "NotStarted"
  },
  "accessibilityCoverage": {
    "interactiveElementCount": 0,
    "ariaLabelCount": 0,
    "coveragePercent": 0,
    "target": 100,
    "status": "NotStarted"
  },
  "testabilityCoverage": {
    "testableElementCount": 0,
    "dataTestIdCount": 0,
    "coveragePercent": 0,
    "target": 100,
    "status": "NotStarted"
  },
  "smokeTestStatus": {
    "totalTests": 0,
    "passingTests": 0,
    "passRate": 0,
    "target": 100,
    "status": "NotStarted"
  },
  "step17ReadinessScore": 0,
  "step22ProjectedScore": 0,
  "gaps": []
}
```

Each step from 9-20 must UPDATE this tracker. Step 17 must VERIFY all targets met.

Execution rules
- Reuse the existing QA scripts and prompt workflows. Do not create new scripts.
- Start by reconciling what Step 5 already decided about architecture, sequencing, and control points.
- Then map preserved legacy behaviors into the future executable backlog.
- Use this Discovery QA pack to define which tests are created now, which are deferred to later numbered steps, and which behavior lineage each later suite protects.
- Define the frozen baseline rule clearly: after Step 2, `LegacyCode/` writes stay inside the approved `Baseline` characterization root only.
- Make every planned suite traceable to a Step 3 behavior, route, API, report, or risk.
- When Step 5 and the QA pack disagree, resolve the conflict here and record the corrected owner and rationale in the refreshed JSON artifacts.
- Do not leave approximate counts or suite ownership only in markdown prose when the JSON artifacts can carry them.
- Materialize executable tests in the owning suite roots under `tests/backend`, `tests/frontend`, and `tests/modernization`; keep modernization-only parity harness files under `tests/modernization/characterization/testcase`.
- Do not create new step-named subfolders or duplicate step-prefixed parity files under `tests/modernization/characterization`. Track modernization phase ownership through testcase metadata and write one Markdown execution report per modernization step under `tests/modernization/characterization/testResult/`.
- When a managed browser surface exists, plan Playwright proof explicitly across `tests/frontend/integrationFrontend`, `tests/frontend/smoke`, `tests/frontend/e2e/journeys`, `tests/frontend/e2e/accessibility`, and `tests/frontend/visualParity`.
- Plan the canonical frontend smoke lane as one high-level `tests/frontend/smoke/ui-navigation-smoke.spec.ts` that opens the major routed UI surfaces, safe menus, tabs, links, grids, and scroll containers, proves no blank-screen or broken lazy-load behavior, watches for browser console errors plus 404 or 500 responses, avoids create, save, submit, delete, export, or other business-transaction actions, targets roughly 30 to 45 seconds, and prefers the tracked helper `.github/scripts/QA/playwright-navigation-smoke-helper.js` for shared route-open, runtime-monitor, scroll, and routed self-heal behavior rather than generated bespoke helpers under `tests/`.
- When that canonical smoke fails because one clear routed surface redirects unexpectedly, lands on an access-rejected or sign-in screen, or hits an obvious late protected-route seam, require one deterministic self-heal attempt before the lane is reported `Blocked`: prefer an earlier or in-app navigation path, refresh the authenticated session input when the current evidence shows auth drift, or reorder the affected route check so the smoke still proves the route family without broadening scope. Encode that single retry through `.github/scripts/QA/playwright-navigation-smoke-helper.js` or a tracked kit-equivalent helper rather than duplicating the logic inside each generated smoke file.
- Treat the smoke evidence publisher as tracked QA helper infrastructure rather than generated test content. Reusable publication logic belongs under `.github/scripts/QA/`, while the generated suite-local outputs stay under each lane's `testResult/` folder.
- When the browser surface triggers protected or high-risk APIs from user actions, plan Playwright frontend-integration cases that navigate to the route, trigger the control, capture the matched request or response, record the response code, and assert the resulting UI state. **Derive `frontend-integration` cases mechanically from `.modernization/ignition-artifacts/discovery/ui-api-wiring-map.json` per `Rule-Route-1` in `.github/instructions/testing-design-contract.instructions.md`.** Each in-scope modern route gets at least one spec under `tests/frontend/integrationFrontend/` derived from `tests/frontend/integrationFrontend/_template/ui-api-wiring.spec.template.ts`. Plan one entry per `apiActions[]` and per `uiTriggers[]` row in the map; record any wiring entry that Step 6 intentionally retires or redirects so Step 12 does not flag it as a broken call. **Honor the read-only default from the data-safety contract**: route every `read-only` action (GET/HEAD) to Pattern A (live backend round-trip), and every `mutates` action (POST/PUT/PATCH/DELETE) to Pattern B (interception) unless the catalog entry explicitly sets `dataSafety: "mutates"` with a reviewer-approved `isolationMechanism`. Default `dataSafety: "read-only"` for every catalog row that targets a GET/HEAD; default `dataSafety: "intercepted"` for every row that targets a mutating verb without isolation.
- Do not introduce Pact-style contract tooling or performance or load suites as default Modernization Quality Design obligations. Add them only when the current app's requirements or compliance obligations explicitly require them.

Execution order
1. Read the QA prompt stack in the required order.
2. Read Step 3, Step 4, and Step 5 outputs.
- 3. Confirm the official test roots, the modernization characterization testcase root, the modernization characterization report root, and the deterministic legacy characterization root.
4. Refresh or generate the phased characterization ladder and baseline carry-forward plan.
5. Refresh the shareable requirements document.
6. Generate `qa-test-plan.json`, `testing-ownership-matrix.generated.json`, and `executable-testcase-catalog.json` by running the canonical planning script from the repo root:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/QA/qa-refresh-test-plan.ps1
   ```
   This is the authoritative generator for all three planning artifacts and Step 8 layering-gate baselines (`.modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json`). Do not hand-author these files. The script derives unit rows (owningStep 8), contract rows (owningStep 9), and integration rows (owningStep 9) from the current characterization and execution contract evidence. After the script succeeds, verify that `.modernization/portal/data/json/executable-testcase-catalog.json` contains at least one Unit suite entry with `materializationPhase` containing `Step 8` before proceeding.
7. Leave portal views unchanged while portal publication is paused.
8. State whether Discovery is complete and ready for Step 7 or whether Step 6 Modernization Quality Design still blocks it.

Mandatory response sections
- `Prerequisite status`
- `QA prompt stack status`
- `Requirements document`
- `Test source-of-truth status`
- `Characterization ladder`
- `Regression and risk plan`
- `Tool and ADO planning`
- `Portal evidence verification`
- `Readiness decision`

Response expectations
- Keep the response concise.
- Name the refreshed source-of-truth JSON artifacts explicitly.
- State whether Step 5 and the QA design pack are aligned.
- State `discoveryInputStatus`, `planningArtifactStatus`, and `step7ReadinessStatus` explicitly, and name the exact blocker when any status is not at its ready state.
- End with one explicit line: Ready for Step 7 Backend - Upgrade .NET: Yes or No.
