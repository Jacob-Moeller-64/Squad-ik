
---
description: Define the developer-facing modernization solution design, execution contract, and migration structure from legacy-system-analysis evidence.
agent: OpX-AppMod-P1-Discovery
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
  - edit
---

# Modernization Solution Design

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 20-40 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 5 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 5 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 5 is the last major planning gate before implementation. It must prove that ownership decisions, unresolved user-input gates, and execution sequencing are settled strongly enough for Step 6 Quality Design.
- Dev work: Turn current runtime truth and baseline evidence into the modernization plan, execution contract, target map, and explicit ownership decisions without reopening discovery later. Step 5 closes from its own planning artifacts and hands Step 6 the helper workflows it may reuse internally.

Objective
- Execute Step 5 `Modernization Solution Design` after Step 3 `Legacy System Analysis` and Step 4 `Baseline Acceptance-Criteria Review` are complete.
- Use `/.github/instructions/modernization-deep-scan-checklist.instructions.md` when Step 3 evidence is broad enough to summarize but not yet precise enough to plan from without rediscovery.
- Make Step 5 the developer-facing modernization plan that later steps can build from without reopening architecture, control-point, move-sequencing, browser-ownership, or legacy view-logic extraction decisions.
- Treat `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` as the authoritative Dominion acceptance standard for modernization decisions and drift control.
- Treat Fusion as the target outcome when browser delivery, shared auth, or shared platform wiring is in scope. MVC, Razor, AngularJS, Angular, and other client technologies are source patterns or temporary bridges, not the target-state goal by default.
- Use `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` as the structured Step 3 handoff and confirm or correct its provisional ownership hints in Step 5.
- Use Step 3 screenshot evidence as a required visual baseline input: `.modernization/portal/data/json/legacy-system-analysis-report.json` (`screenshotCoverageMatrix`) plus `.modernization/portal/data/images/legacy-system-analysis/**`.
- If browser-surface work is in scope and Step 3 has zero captured screenshots, mark Step 5 `executionReadinessStatus` as `NotReadyForQualityDesign` until Step 3 screenshot capture is rerun or explicit `captured-user-provided` rows are recorded.
- If browser-surface work is in scope and Step 3 has partial screenshots, require explicit operator screenshot review and decision logging in Step 5. Operator-approved partial coverage is not a hard blocker by itself; record the approval note and continue with `executionReadinessStatus` based on remaining unresolved gates.
- Classify Step 5 planning readiness explicitly with these statuses:
  - `ownershipDecisionStatus`: `DecisionGrade`, `NeedsFollowUp`, or `Blocked`
  - `userInputGateStatus`: `Cleared`, `Outstanding`, or `Blocked`
  - `executionReadinessStatus`: `ReadyForQualityDesign`, `NotReadyForQualityDesign`, `UserInputRequired`, or `BlockedMissingArtifact`
- Distinguish user-input gaps from artifact gaps:
  - Use `UserInputRequired` when artifacts are current but one or more user-supplied gates remain unresolved.
  - Use `BlockedMissingArtifact` when required upstream artifacts are missing, stale, or structurally invalid.
- Read and update `/.modernization/.readme/kit-params.md` section `User Input Required` as the canonical intake surface for Step 5 user gates.
- When asking about database runtime configuration, ask explicitly for either the authoritative connection string or how the connection string is retrieved and composed at runtime. Do not use opaque wording such as `connection ownership` without explaining what information is needed.
- Do not report Step 5 ready by feel when major ownership decisions are still provisional, required auth or membership inputs remain unowned, or the execution sequence is too vague for the next gate to use safely.
- Do not report Step 5 ready by feel when material Step 3 or Step 4 carry-forward items still exist but are not explicitly dispositioned into a planning decision, user-input gate, later-step owner, companion-gate owner, or blocker.

Step 5 ownership boundary
- Step 5 owns the developer-facing modernization solution design, target architecture, execution contract, phase assessment, planned `LegacyCode/`-to-`src/` and `tests/` move inventory, `.cshtml` logic-extraction plan, source-stack treatment decisions, frozen-baseline strategy, Step 7 upgrade workspace contract, Step 8 move targets, protected control-point decisions, and browser-surface planning pack when applicable.
- `Modernization Quality Design` owns the shareable requirements document, `.modernization/portal/data/json/qa-test-plan.json`, `.modernization/ignition-artifacts/discovery/testing-ownership-matrix.generated.json`, `.modernization/portal/data/json/executable-testcase-catalog.json`, `.modernization/portal/data/json/characterization-test-planning.json`, the phased characterization ladder, executable testcase direction, testing strategy, regression plan, risk matrix, tool rationale, and ADO CI/CD planning.
- If those QA-owned artifacts already exist, treat them as companion inputs. Do not fork or re-own them here.
- Do not auto-chain `[WORKFLOW] Modern Build Planned QA Tests` from Step 5. Route to `Modernization Quality Design (Step 6)` as the next required gate before Step 7.

Primary Step 5 deliverables
- Refresh `.modernization/ignition-artifacts/Modernization-Solution-Design.md` as the primary human-readable Step 5 development plan. Markdown is the canonical format; `.*` peers are advisory only and do not substitute for the `.md` file.
- Refresh `.modernization/ignition-artifacts/Modernization-Execution-Contract.md` as the named execution contract Step 7, Step 8, and the browser decomposition prompts read by exact path. The companion JSON form at `.modernization/portal/data/json/modernization-execution-contract.json` is required when downstream prompts reference it; it does not replace the named markdown report.
- Refresh `.modernization/ignition-artifacts/Modernization-Phase-Assessment.md` as the named phase-assessment report Step 7 and Step 8 read by exact path to confirm later-step modes (`Skip`, `ValidateOnly`, `Execute`).
- Author the three control-plane JSON companions directly in this DEV step so they exist on every run, including `No QA` runs: `.modernization/portal/data/json/modernization-execution-contract.json`, `.modernization/portal/data/json/modernization-phase-assessment.json`, and `.modernization/portal/data/json/modernization-solution-design.json`. Derive their content from this app's real `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` evidence and the three named markdown reports above. These are DEV-owned control files: the QA portal refresh validates and renders them but must not be their sole author. Do not fabricate routes; use the app's discovered routes or leave route arrays empty when evidence is absent. Each control-plane JSON MUST include at minimum a non-empty `reportId` and a non-empty `title` identity field so the shared verifier can confirm it is a real control-plane document rather than a truncated or hallucinated fragment; the field-contracts under `.github/contracts/schemas/` enforce this on Step 5 closeout.
- Refresh `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`.
- Refresh `*Planned-File-Inventory.*` as the destination-side mirror of the Step 5 `LegacyCode/`-to-`src/` move ledger when that artifact family exists in the workspace.
- Refresh `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` as companion structured artifacts. They do not substitute for the three named markdown reports above; downstream prompts read the `.md` files by exact path.
- Refresh the Step 5 structured `.cshtml` and view-hosted logic extraction plan inside `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` when server-rendered browser inputs exist.
- When `browserSurfaceApplicability` is `Required`, refresh `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-inventory.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-visual-contract.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-migration-order.json`.
- When `browserSurfaceApplicability` is `Required`, consolidate the Step 3 `legacyVisualContract` evidence into the browser pack so it is the durable answer key for the Step 13 visual-parity gate:
  - `.modernization/fusion-restructure/styling-foundation.json` must record the **applied** foundation the modern shell will inherit: `themePalette` (brand/header/primary-action/neutral/semantic colors mapped to app-owned design-token ids), `typographyContract` (font families, weights, label sizing, and `@font-face` families with asset paths), `shellChromeRegions` (header, nav, footer presence and the source markup each came from), `navRouteModel` (the ordered nav links the shell must render), and the `fusionThemeBinding` plan that points the Fusion theme at the app-owned tokens.
  - `.modernization/fusion-restructure/ui-visual-contract.json` must record the **measured** legacy contract used for comparison: palette, typography, header/nav/footer chrome presence, the nav route model, per-route reference screenshots, and the sizing/spacing/layout-density values, each traceable to the Step 3 evidence.
  - Do not fabricate values. Carry them from the Step 3 `legacyVisualContract`; when the legacy app could not run, preserve the `runtimeMeasured: false` marker so the gate knows the contract is static-only.
- Do not claim ownership of the Discovery QA companion artifacts from this prompt.

Development plan rules
- Keep the primary Step 5 deliverable concise, developer-readable, and evidence-backed.
- Use sections that make the later execution path obvious:
  - `Executive Summary`
  - `Discovery Carry-Forward Disposition`
  - `Target Architecture And Mode`
  - `Source Stack Treatment Decisions`
  - `LegacyCode To src File And Phase Map`
  - `Protected Control Points`
  - `Runtime And Workspace Strategy`
  - `Browser-Surface Plan` when applicable
  - Wrapper Capability Plan when `browserSurfaceApplicability` is `Required`
  - UI Migration Sub-Pattern Order when `browserSurfaceApplicability` is `Required`
  - API Integration Plan (REQUIRED)
  - Auth Integration Plan (REQUIRED)
  - Test-Hook And Playwright Readiness Plan (REQUIRED when browser-surface is in scope)
  - `Code Quality Standards` (REQUIRED)
  - `Test Coverage Targets` (REQUIRED)
  - `Blockers And User Input Gates`

**Code Quality Standards Section (MANDATORY)**
Step 5 MUST define explicit quality gates that Steps 7-18 will enforce:
- **.NET Code Quality**:
  - Nullable reference types: enabled in all projects
  - Async patterns: no .Result, .Wait(), .GetAwaiter().GetResult()
  - DI: all services via constructor injection, no new HttpClient()
  - SOLID: methods < 50 lines, classes < 500 lines
  - Fusion packages: IFusionLogger, IFusionHttpClientFactory, IFusionCache
  - Security: [Authorize] on all controllers, no secrets in code
- **Angular Code Quality**:
  - Standalone components only (no NgModules)
  - Signals for reactive state
  - Modern control flow (@if, @for, @switch)
  - inject() function for DI
- **Accessibility Requirements**:
  - All interactive elements: aria-label or aria-labelledby
  - All testable elements: data-testid attribute
  - Semantic landmarks: header, nav, main, footer, aside
  - Keyboard navigation: full application coverage
- **Test Requirements**:
  - Backend coverage: > 80% on Library business logic
  - Frontend Playwright: POM class per route, Gherkin scenario per user journey
  - Naming convention: MethodName_Scenario_ExpectedResult
- Plan MUST explicitly state these standards. Steps 7-18 will enforce them.
- Step 24 Technical Review will verify compliance - prevention is better than detection.

**Legacy Unit Test Baseline (Prerequisite to Step 7)**
- Step 6 `Modernization Quality Design` establishes a frozen baseline of legacy unit tests under `LegacyCode/<LegacyTestProject>/Characterization/Baseline/` before Step 7 begins.
- These baseline tests are NOT prerequisites for Step 5 execution; they are generated as part of Step 6's quality design gate.
- Step 7 runs legacy tests green, upgrades .NET, then runs the same tests against the upgraded code to prove behavior parity.
- Do NOT assume legacy unit tests already exist during Step 5 planning. Step 6 owns baseline infrastructure and baseline characterization scaffolding. Step 7 DEV populates the tests with actual characterization scenarios derived from Step 3 behavior inventory.

**API Integration Plan (MANDATORY)**
Step 5 MUST close every API connection decision before Phase 2 starts so the API never has to be debugged mid-modernization.
- Read every row from Step 3 `apiEndpointCatalog`. Each legacy endpoint MUST map to: target `Web.Api` controller and action, target route template, request and response DTO names (planned), error envelope contract, auth attribute (`[Authorize]` plus policy or scopes), and the typed client method on the Angular side that will consume it.
- If repo evidence already contains controller actions or service-behavior rows, Step 5 must treat missing or placeholder endpoint mappings as a Step 3 generation defect and correct the catalog from available evidence before planning continues.
- Lock the `baseUrlStrategy` per environment: development uses the Angular dev-server proxy with the documented proxy config file, QA and Production use the deployed API origin via Fusion config. Hard-coded `localhost`, hard-coded ports, or per-component `HttpClient` instances are forbidden.
- Lock the HTTP plumbing: `IFusionHttpClientFactory` ownership, interceptor list (auth header, correlation id, error envelope), CORS policy, request/response logging redactions.
- Record decisions as `apiIntegrationPlan[]` rows in `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` with at minimum `{ endpointId, controller, action, routeTemplate, requestDto, responseDto, errorEnvelope, authPolicy, typedClientOwner, baseUrlEnvironments, owningStep }`.
- A Phase 2 step that discovers a missing endpoint, missing base URL decision, or missing typed client owner is a Step 5 planning gap and must route back here, not be absorbed in Step 9 or Step 11.

**Auth Integration Plan (MANDATORY)**
Step 5 MUST close every identity, Okta, AD, and role decision before Phase 2 starts so auth wiring is never discovered mid-modernization.
- Read every key from Step 3 `authIntegrationCatalog`. The plan MUST declare: identity provider (Okta, AD, ADFS, hybrid, or legacy-windows-ad), library choice (`okta-angular`, `msal-angular`, `angular-auth-oidc-client`), exact issuer, client id, tenant or authorization server, scopes, redirect URIs, post-logout URIs, silent-refresh strategy, and storage mode.
- Treat LegacyCode `Web.config` as authoritative for legacy auth detection when present. If `authentication mode="Windows"` and/or `AppletSecurity.SarRoleMapping` are present, auto-populate `legacyAuthProviderSelection` and `legacyAuthoritativeRoleGroupIds` in `kit-params.md` before asking the user.
- Declare the backend side: JWT validation handler, authority, audiences, accepted scopes, claim-to-role mapping, `[Authorize]` policy names, anonymous-allowed routes, and the current-user bootstrap endpoint shape.
- Resolve every `authIntegrationCatalog.unresolvedInputs[]` item HERE. If a legacy AD role group, modern identity provider detail, or scope is unknown, the `Blockers And User Input Gates` section MUST list it by exact identifier name with a question the user can answer in one line.
- Treat `oktaIssuerOverride` as fixed to `https://<company-tenant>.okta.com` <!-- REDACTED: real Okta tenant URL in work-side original --> for this kit. Do not request issuer input from the user unless an explicit override policy is introduced.
- If `oktaClientIdOverride` is `default`, treat the client ID as resolved to `<default-okta-client-id>` <!-- REDACTED: concrete Okta client id in work-side original --> and do not classify it as a blocker. Keep it mutable only when the user later provides a replacement value.
- For `env.connectionStringRuntimeInput`, ask one explicit question the user can answer directly, using shorthand values when possible: `Use OCPEnv (default OpenShift/Kubernetes split env vars), LocalIntegrated (or OpEx) for local Windows integrated auth, OpX to defer, or provide a concrete legacy config-file reference / direct connection string when required.`
- If `kit-params.md` records a gate value as `OpX`, treat it as intentionally deferred by operator choice and keep it visible as a tracked gate rather than a missing-value blocker.
- In most modernization engagements, assume the preferred final-state pattern is OpenShift/Kubernetes secret-backed environment variables whose values are composed once at startup into the required `ConnectionStrings` entry. If the operator intentionally defers that final-state wiring with `OpX`, do not treat that deferment as a hard blocker for Step 5 planning.
- Record decisions as `authIntegrationPlan` in `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` with at minimum `{ identityProvider, libraryChoice, providerConfig, backendValidationConfig, policyMap, currentUserBootstrap, protectedRoutePatterns, anonymousRoutePatterns, openUserInputs[] }`.
- A Phase 2 step that discovers an Okta or AD config gap is a Step 5 planning gap and must route back here.

**Test-Hook And Playwright Readiness Plan (MANDATORY when browser-surface is in scope)**
Step 5 MUST lock the modern test-hook contract so Step 10 onward can author POMs and Gherkin features without inventing selectors.
- For every `uiControlClassification` row with `migrationEligible: true`, confirm the Step 3 `recommendedTestId`. Fill any missing values HERE.
- Adopt the convention: `data-testid` is mandatory on every wrapper component template root and on every input, button, and command surface inside it. Wrappers MUST forward a `testId` input down to the underlying Fusion primitive's host element.
- Record the POM allocation: every route gets one `{Route}Page.ts` class extending `BasePage.ts`. Capture `{ routeId, pomClassName, pomFilePath, gherkinFeatureFile, selectorContract }` as `testHookPlan[]` in `decisions.json`.
- `selectorStability != 'stable'` rows from Step 3 MUST have a recorded remediation in this plan (add `data-testid`, refactor index-bound DOM, etc.) before Phase 2 starts.

**Data Fixture And Seeding Plan (MANDATORY)**
Step 5 MUST close every fixture-data decision so populated, empty, and error screenshots are reachable and Step 17 tests have realistic data.
- Read every row from Step 3 ``dataFixtureCatalog``. For each ``surfaceId`` decide: ``fixtureOwner`` (seed-script, json fixture, mock service, recorded-har, synthetic-generator), ``populatedDataSource``, ``emptyDataPath``, ``errorInjectionPath``, ``runFrequency`` (per-test, per-suite, per-environment), and ``ownerStep``.
- Record decisions as ``dataFixturePlan[]`` in `decisions.json` with `{ surfaceId, fixtureOwner, populatedDataSource, emptyDataPath, errorInjectionPath, runFrequency, ownerStep }`.
- A Phase 2 step that discovers a missing fixture is a Step 5 planning gap and routes back here.

**Performance Budget Plan (MANDATORY when browser-surface is in scope)**
Step 5 MUST set perf budgets so Step 17 can verify no regression vs Step 3 baseline.
- Per route, set ``fcpMaxMs``, ``lcpMaxMs``, ``ttiMaxMs``, ``apiCallCountMax``, ``totalPayloadBytesMax``. Defaults: modern must be within +10% of Step 3 ``performanceBaseline`` numbers unless an explicit deferral is recorded.
- Set per-route ``initialBundleBytesMax`` and ``lazyChunkBytesMax``. Defaults for Angular: initial route bundle <= 500 KB gzipped; lazy chunks <= 200 KB gzipped.
- Record as ``performanceBudgetPlan[]`` in ``decisions.json`` with ``{ routeId, budgets, baselineRef, deferralId? }``.

**Accessibility Audit Plan (MANDATORY when browser-surface is in scope)**
Step 5 MUST lock the a11y tooling, baseline, and ship-time targets.
- Tool choice (``axe-core``, ``Lighthouse``, ``pa11y``), invocation path (CI step name, test file), and per-route Lighthouse a11y score target (default >= 90).
- Defect policy: critical and serious axe violations block Step 17 exit; minor and moderate require a recorded deferral.
- Record as ``accessibilityAuditPlan`` in ``decisions.json``.

**State Management Decision (MANDATORY when browser-surface is in scope)**
Step 5 MUST lock ONE primary client-state pattern so Phase 2 does not mix paradigms.
- For SPA targets: choose ``services-with-rxjs``, ``signals``, ``ngrx``, ``component-store``, or ``zustand-react``. For server-rendered targets: choose ``view-model``, ``page-model``, or ``htmx-fragments``.
- Cross-page communication mechanism: ``route-state``, ``shared-service``, ``store``, ``query-params``, ``broadcast-channel``.
- Record as ``stateManagementPlan`` in ``decisions.json`` with ``{ primaryPattern, crossPageCommunication, formStateOwnership, cachePolicy }``.

**Realtime And Push Plan (MANDATORY when ``realtimeSurfaceCatalog`` is non-empty)**
For every row in Step 3 ``realtimeSurfaceCatalog``: target transport (``signalr``, ``websocket``, ``sse``, ``polling-rxjs``), reconnection strategy, auth scheme, payload shape, and affected wrapper components.
Record as ``realtimePlan[]`` in ``decisions.json``.

**Logging And Telemetry Plan (MANDATORY)**
For every row in Step 3 ``loggingAndTelemetryCatalog``: target logger (Fusion logger, Serilog, ApplicationInsights, console-only-with-justification), correlation-id propagation, telemetry sinks, analytics tag preservation, health-check endpoints.
Record as ``loggingAndTelemetryPlan`` in ``decisions.json``.

**Environment Config Plan (MANDATORY)**
For every env in Step 3 ``environmentConfigMatrix``: lock target ``apiBaseUrl``, ``authConfig``, ``featureFlags``, and ``secretReferences`` (key vault path or env var name; never secret values).
Record as ``environmentConfigPlan.environments[]`` in ``decisions.json``.

**Cutover And Rollback Plan (MANDATORY)**
Step 5 MUST plan the production cutover before Phase 2 starts. Step 18 verifies it; Phase 2 does not invent it.
- ``featureFlagStrategy`` (per-route flag, blue-green, dark launch), ``staggeredRolloutPlan`` (user cohorts, percent rollout, soak time), ``rollbackProcedure`` (steps, owner, max time-to-rollback), ``dryRunOwner`` (which step rehearses the rollback).
- Record as ``cutoverAndRollbackPlan`` in ``decisions.json``.

**Test Isolation And Flake Budget (MANDATORY)**
- Per Playwright project: ``retryCount`` (default 2), ``flakeBudgetPercent`` (default 1), ``isolationStrategy`` (per-test setup, transaction rollback, container reset), ``quarantineLifetimeDays`` (default 14).
- Record as ``testIsolationPlan`` in ``decisions.json``.

**Localization Plan (MANDATORY)**
For Step 3 ``localizationCatalog``: target i18n library (``@angular/localize``, ``ngx-translate``, ``react-i18next``, framework default), resource format, default locale, RTL support, culture formatting source. ``notPresent`` paths require attestation that no localization is required.
Record as ``localizationPlan`` in ``decisions.json``.


**Wrapper Capability Plan (MANDATORY when browser-surface is in scope)**
Step 5 MUST lock the app-owned wrapper input surface before Phase 2 starts. Phase 2 must not extend wrapper inputs mid-stream.
- Read every distinct `requiresWrapperCapability` value from Step 3 `uiControlClassification` (all rows and all sub-patterns).
- For each capability, decide one of: `ShipFromDayOne`, `ExtendAtStep15`, `ExtendAtStep17Preflight`, or `IntentionallyDeferred` (with a recorded follow-up gate).
- For wrappers that front a generic Fusion primitive (for example `fusion-dropdown`), require a permissive `options` input type (`Record<string, unknown>` or equivalent). Do not allow a domain-specific narrowing in the planned wrapper contract.
- For form-field-style wrappers, require both `readOnly` and `disabled` inputs with a derived `controlDisabled = readOnly || disabled`.
- For every wrapper, require pass-through `elementId` and `testId` inputs so legacy `<label for=...>` association and Playwright `data-testid` selectors keep resolving after the swap.
- Record the wrapper input surface as `wrapperCapabilityPlan[]` rows in .modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json with `{ wrapperName, supportedKinds[], requiredInputs[], optionalInputs[], capabilityDecisionPerSlice }`.
- A Phase 2 wrapper extension that was not anticipated here is a Step 5 planning gap and must route back to Step 5, not be absorbed inside Step 15 or Step 16.

**UI Migration Sub-Pattern Order (MANDATORY when browser-surface is in scope)**
Step 5 MUST express the migration order down to the sub-pattern level so Step 16 selection is deterministic.
- Read `uiControlClassification.subPatterns[]` from Step 3.
- Order families in `ui-migration-order.json` as today, then within each family order sub-patterns by `suggestedPassOrder` from Step 3.
- For each sub-pattern, record `{ familyId, subPatternId, dependsOnSubPatterns[], dependsOnWrapperCapabilities[], expectedPassCount, deferralPolicy }`.
- Step 16 eligibility predicate reads this order. Step 16 must not improvise sub-pattern order or skip ahead.
- Sub-pattern order omissions are Step 5 gaps, not Phase 2 discovery items.
- The `Blockers And User Input Gates` section must explicitly call out unresolved auth-role inputs when repo evidence does not already prove them, especially authoritative Okta or AD group identifiers or equivalent membership-source inputs needed for current-user or bootstrap routes and protected API policies.
- `export.downstreamOwnership` is always optional in Step 5 and must not be treated as a hard stop. When its value is `OpX`, keep it in the tracked optional-gates list and continue.
- The `Discovery Carry-Forward Disposition` section must explicitly map each material Step 3 and Step 4 carry-forward item to one of these outcomes: `ResolvedByPlanningDecision`, `UserInputGate`, `OwnedByModernizationQualityDesign`, `OwnedByLaterStep`, or `Blocked`.
- The file-and-phase map must show the `LegacyCode/` source path or source family, the destination `src/` or `tests/` path, its purpose, the owner step, whether the destination exists now, and the current completion percent.
- When legacy `.cshtml` files hold business, validation, export, lookup, shaping, or orchestration logic, split the render-focused view from the planned `Library` or approved backend logic file that will receive that extracted behavior.
- Keep test-root discussion structural only: where suites will live and which step or required companion gate owns them. Deep QA planning belongs to `Modernization Quality Design`.
- Do not present the main Step 5 deliverable as a requirements document.
- Keep supporting reports concise and derived from the main Step 5 development plan instead of letting them become parallel narratives.
- Prefer one canonical structured artifact per step-owned evidence family. When a numbered step already owns the proof record, extend that artifact in place instead of adding a proof-of-proof sidecar file for the same state.

Execution mode
- This prompt is operational, not advisory. Produce or refresh the required Step 5 development-planning artifacts.
- If the user includes the exact phrase `No QA` in the request, skip the mapped QA workflow for this run and note QA was skipped by operator request.
- Finish with a decision-grade development pack and a concrete Step 6 readiness recommendation.
- Step 5 plans the frozen baseline strategy, the Step 7 mutable upgrade workspace, the original-runtime and upgraded-runtime launch contracts, the Step 8 move sequence into `src/<AppName>.*`, and the delete-after-validation rule for each major artifact family.
- Step 5 must define the immutable-baseline contract: after Step 3, AI may write under `LegacyCode/` only in `LegacyCode/<LegacyTestProject>/Characterization/Baseline`; all other legacy-tree writes are forbidden.
- Step 5 must ban generated JSON, reports, portal pages, and modernization helper outputs anywhere under `LegacyCode/`.

Required inputs
- Step 3 legacy-system-analysis report pack in `.modernization/ignition-artifacts/`.
- Step 4 baseline acceptance and compliance evidence.
- `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md`.
- Runtime verification outputs.
- Review manifest: `.modernization/ignition-artifacts/discovery/review-manifest.json`.
- `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json`.
- Raw legacy application source under `LegacyCode/` for direct code verification.
- Existing architecture docs, if present.
- Application and solution structure in the repo.
- Existing `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` when present; refresh them instead of forking alternates.
- Existing browser-surface planning artifacts when present.
- Existing `Modernization Quality Design` outputs when present, only as companion inputs.

Fail-fast gates
- Stop immediately if `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` is missing.
- Stop immediately if the Step 3 legacy-system-analysis pack is missing, stale, or clearly incomplete for target-state planning.
- Stop immediately if the Step 4 baseline acceptance evidence is missing or stale.
- Stop immediately if runtime verification output is missing.
- Stop immediately if the review manifest is missing or stale relative to the Step 3 pass.
- Stop immediately if `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` is missing, stale, or materially incomplete for the Fusion-first planning decisions Step 5 must confirm.
- Stop immediately if raw legacy source under `LegacyCode/` cannot be inspected directly and the Step 3 inventory does not already prove an explicit `InventoryOnly`, `ExternalManaged`, or `UnavailableByDesign` planning posture.
- Stop immediately if the active application root or solution shape cannot be determined from repo evidence.
- Stop immediately if proposed modernization slices cannot be traced back to Step 3 derived screens, routes, APIs, and characterization coverage.
- Stop immediately if Step 3 does not trace high-risk command families to their best-known downstream seams or explicitly record the exact cannot-locate gap for those controls.
- Stop immediately if the migration structure is missing, stale, or incomplete for any significant artifact family needed by the proposed slices.
- Stop immediately if existing Step 5 structured artifacts materially conflict with each other.
- Stop immediately at Step 5 closeout if any of `.modernization/ignition-artifacts/Modernization-Solution-Design.md`, `.modernization/ignition-artifacts/Modernization-Execution-Contract.md`, or `.modernization/ignition-artifacts/Modernization-Phase-Assessment.md` is missing from disk or zero-byte. The companion `.modernization/ignition-artifacts/modernize/fusion-restructure/*.json` files are not a substitute for these named markdown reports; downstream prompts read the `.md` files by exact path and will fail-fast.
- Stop immediately at Step 5 closeout if `.modernization/ignition-artifacts/Modernization-Phase-Assessment.md` does not state an explicit Step 8 disposition of `Skip`, `ValidateOnly`, or `Execute`. Step 8 fails fast without this disposition.

Planning core
- Validate the Step 3 truth first: raw `LegacyCode/`, source-stack fingerprint, `sourceAcquisitionStatus`, inventory completeness, high-risk control traces, and any cannot-locate backlog must be strong enough to plan from.
- Decide the target shape and execution model: target architecture, split ownership, modernization mode, later step modes (`Skip`, `ValidateOnly`, `Execute`), and the treatment of each detected stack family.
- Define the move and extraction plan: ordered `src/` and `tests/` creation, `viewLogicExtractionPlan`, frozen baseline, `step7UpgradeWorkspaceRoot` under `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`, runtime launch contracts, Step 8 move sequence, and delete-after-validation handling.
- Decide the protected control-point and auth posture: final ownership vocabulary, browser applicability, client carry-forward contracts, and any unresolved authoritative role or membership inputs that must become explicit user-input gates.
- Disposition every material Step 3 and Step 4 carry-forward item before closing Step 5. Each item must end as a planning decision, user-input gate, later-step owner, companion-gate owner, or blocker.
- Confirm `Modernization Quality Design (Step 6)` is the next required gate before Step 7.

Closure contract
- Refresh existing Step 5 artifacts in place, keep naming aligned to current `.modernization` conventions, and do not produce a second numbered-flow restructure tracker.
- Refresh the Step 5 portal planning surfaces, but do not claim Test Plan or Characterization pages as Step 5-owned outputs before `Modernization Quality Design` completes.
- When server-rendered browser inputs exist, `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` must include `viewLogicExtractionPlan` rows with `sourceViewPath`, `surfaceName`, `presentationTarget`, `logicExtractionTargets`, `ownerStep`, `confirmationStatus`, and `notes`.
- The final Step 5 development pack must be concise but specific enough that Steps 7 through 11 can execute without re-deciding structure, ownership, or move sequencing.
- Required outputs verification: before returning `Ready for Modernization Quality Design: Yes`, verify on disk that `.modernization/ignition-artifacts/Modernization-Solution-Design.md`, `.modernization/ignition-artifacts/Modernization-Execution-Contract.md`, and `.modernization/ignition-artifacts/Modernization-Phase-Assessment.md` all exist and are non-empty. If any are missing, write them from the matching decisions in `.modernization/ignition-artifacts/modernize/fusion-restructure/*.json` and `.modernization/ignition-artifacts/addendums/Architecture-Structure.md` before closing Step 5.
- Control-plane JSON verification: before returning `Ready for Modernization Quality Design: Yes`, also confirm the three DEV-owned control files exist and are non-empty at `.modernization/portal/data/json/modernization-execution-contract.json`, `.modernization/portal/data/json/modernization-phase-assessment.json`, and `.modernization/portal/data/json/modernization-solution-design.json`. Run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 5 -Mode Output` and confirm it exits `OK`. This proves later steps (including `No QA` runs) can read the control plane without depending on the QA portal refresh.
- Return these sections in order: `Prerequisite status`, `Development plan`, `Discovery carry-forward disposition`, `Target-state decision`, `Source stack planning inputs`, `Fusion ownership decisions`, `Planning readiness status`, `File and phase map`, `Supporting artifact status`, `Required outputs verification`, `Portal evidence verification`, and `Readiness decision`.
- End every Step 5 response with `User Input Required` section containing:
  - `Required now`: unresolved gates from `kit-params.md` `User Input Required` excluding values already set and excluding optional gates.
  - `Optional`: unresolved optional gates that still exist in the current kit contract. Ignore retired fields such as `exportDownstreamOwnership` if they appear in older clones or stale notes.
  - `Auto-detected from legacy config`: provider mode and role-group hints extracted from LegacyCode `Web.config`.
  - `Operator deferrals`: gates set to `OpX`.
- Keep the final response concise, lead with the development plan and main file-and-phase map, name what blocks `Modernization Quality Design` if anything still does, state exactly which portal pages were refreshed, and end with one explicit line: Ready for Modernization Quality Design: Yes or No.
