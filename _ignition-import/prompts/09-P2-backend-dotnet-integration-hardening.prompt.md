---
description: "Step 9. Run backend .NET integration hardening for the intended modernization root using the Step 7 backend artifacts and the formed Step 8 backend shell."
name: "09-P2-backend-dotnet-integration-hardening"
argument-hint: "Run Step 9 backend .NET integration hardening"
agent: "OpX-AppMod-P2-Modernize"
---

# Step 9 Launcher

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 20-40 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 9 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before mutating backend integration seams: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 9 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change backend files until the restore point is present.
> - Backend functionality-parity scan before closeout (MANDATORY): run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-backend-parity.ps1 -Quiet`. This proves every LEGACY backend endpoint - especially every mutation (POST/PUT/DELETE/PATCH: Add/Edit/Delete/Link/Export) - has a modern counterpart. Exit 2 means the modern API dropped write endpoints the legacy app shipped; port them (with modern architecture + auth) before the frontend depends on them, or record genuinely out-of-scope operations in `.modernization/ignition-artifacts/discovery/backend-parity-registry.json` (`acceptedDrops[]` with a reason). Catching a dropped mutation HERE (backend formation) is far cheaper than discovering at Step 12 that the UI has Add/Edit/Delete buttons with no endpoint behind them. The output verify below fails while any legacy mutation endpoint has no modern counterpart and no accepted waiver.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 9 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.
> - Fusion MCP preflight gate before any Fusion-backed hardening decision: verify Fusion MCP tools are reachable by successfully calling `mcp_fusion_fusion_api_docs_entrypoints` (or the active equivalent docs/package MCP probe). If the probe fails or tools are unavailable, set Step 9 to `Blocked`, report `Fusion MCP unavailable`, and do not continue hardening work that depends on Fusion guidance.

- About To Do
- Context: Step 9 is the production-style backend hardening lane after Step 8 formation. It must prove control-point alignment, runtime hardening, and test protection are current enough for downstream frontend or review work.
- Dev work: Harden backend auth, config, logging, caching, and runtime integration seams against the Step 7 contract, and create the Step 9-owned backend test projects and initial tests for the IntegrationBackend, ContractApi, and Db lanes under tests/backend so QA has concrete assets to execute.
- QA plan: Use `[WORKFLOW] Backend - .NET Integration Hardening` inside the active Step 9 loop at meaningful checkpoints and at closeout to confirm the backend still matches the protected starter shell and the hardening proof is stronger than artifact presence alone.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.
- Model requirement: Step 9 execution must run on GPT-5.3-Codex.

## Naming, Legacy Evidence, And Placeholder Cleanup Carry-Forward (MANDATORY)

- Keep backend capability names domain-driven; do not keep page-label names like `Home*` or view abbreviations like `Pj*` once domain naming is known.
- Preserve Step 8 starter-cleanup outcomes: placeholder starter controllers and their dependent sample models/services must remain removed unless explicitly re-approved.
- If hardening work needs missing behavioral detail, use Step 3/5/6 artifacts first and then consult the corresponding legacy source files (including `Repository.cs`) as authoritative implementation evidence.

## Production Data Access Hardening Guardrail (MANDATORY)

- Production backend seams in `src/` must be DB-backed for DB-backed legacy behavior; do not ship hardcoded in-memory replacements as final or implicit interim state.
- Any in-memory implementation in `src/` must be treated as a temporary bridge with explicit replacement work in the active Step 9 pass.
- Test-only in-memory seams belong under `tests/**`, not under production `src/<App>.*` runtime paths.

## DB-Backed Store Logging And Error Handling (MANDATORY)

**Fusion Console Logging Provider Setup** (prerequisite for logging to work):
- Add `Fusion.Fx.Logging.Providers.Console` package to the Web.Api project csproj file using the latest production version available in Sonatype feeds.
- Add `"FusionConsole": {}` as a top-level key in the `Logging` section of `appsettings.json` to enable the Fusion console provider at startup. The presence of this key triggers automatic registration via the Fusion app builder.
- Consult `fusion-readme:///src/dotnet/Fusion.Fx.Logging.Providers.Console/README.md` (via Fusion MCP) for detailed console provider configuration and customization options. This is the authoritative source for console logging behavior in Fusion-backed apps.
- The Fusion console provider wires `ILogger<T>` injection through the Fusion app builder and formats logs as JSON for structured output to stdout/stderr. No additional ILogger registration is needed when `Logging:FusionConsole` is present.

**Store-Level Logging Contract**:
- Every class that implements a repository or store interface backed by a real database connection must inject `ILogger<T>` and log at every DB failure boundary.
- Connection open failures must be caught, logged with `LogError` including the full exception, the SQL error number (`SqlException.Number`), the SQL error message, and the `Data Source` value extracted from the connection string (never log passwords). Rethrow after logging so the controller returns a proper HTTP 500 rather than an unobservable crash.
- Each mutation method (`Insert`, `Update`, `Delete`, `Upsert`) must catch `SqlException` separately from other exceptions, log with enough context to identify the failing stored procedure and parameters (excluding sensitive data), and return the legacy error-signaling value (for example `false` or an error string) instead of throwing so the service layer response contract is preserved.
- Add `LogDebug` before each stored procedure call with the procedure name and key identifiers. This provides a request-level execution trail in Development without flooding Production logs.
- Mapping safety rule: for Dapper query materialization, prefer typed `Query<T>` where practical. If dynamic rows are used, do not rely on direct casts for cross-type SQL/application values (for example SQL `int` -> app `string`); use explicit conversions (`Convert.ToString`, `Convert.ToInt32`, etc.) to avoid runtime binder exceptions.
- Dapper constructor parity rule: for typed materialization targets (records/classes mapped by constructor), constructor parameter types must match SQL result column CLR types. A mismatch such as SQL `int` mapped to constructor `string` is a Step 9 blocker until corrected.
- When API contracts require a different type than DB row shape, harden with a two-step mapping: DB-shaped row model for Dapper materialization, then explicit projection to API/entity model.
- Treat this exception signature as a hard failure that must be fixed before closeout: `A parameterless default constructor or one matching signature (...) is required ... materialization`.
- Validate the connection string at construction time: if `ConnectionStrings:<name>` resolves to an empty string, log `LogError` immediately at startup so the misconfiguration appears in host startup output before the first real request fails. A green `dotnet build` does NOT prove the connection string is populated; verify the key resolves at runtime.
- When the modernized backend adds a new connection string key, cross-check the key name against the actual `appsettings.json` (and `appsettings.Development.json`) entry using the exact canonical name the options class will request. Wrong server hostnames and unreachable DNS names are the most common sources of first-request HTTP 500s; verify with a DNS lookup or `ping` before committing the value.
- The correct environment-specific server name must come from the legacy `Configuration/<env>/` config files inside the project being modernized, not from commented-out developer shortcuts in legacy `Repository.cs` files. Commented-out connection strings are for reference only and are not authoritative.
- Step 9 owns generating the runtime configuration seam that composes a SQL connection string from environment variables when the Step 5 contract selected that pattern. Validate the exact environment variable names from deployment evidence when available. The default OpenShift/Kubernetes pattern is `SqlServer__Server`, `SqlServer__Database`, `SqlServer__Username`, `SqlServer__Password`, `SqlServer__Encrypt`, and `SqlServer__TrustServerCertificate`.
- Step 9 must verify both paths explicitly: direct `ConnectionStrings:<name>` resolution when config-file sourcing is still the approved local bridge, and split `SqlServer__*` environment-variable composition when the final-state deployment pattern is selected.

## Breakpoint And Exception Observability (MANDATORY)

- Backend hardening must preserve breakpoint-friendly method boundaries. Do not collapse DB access, mapping, and service logic into opaque one-liners that are hard to inspect in Visual Studio.
- Log exceptions at the boundary where they occur, with enough structured context for diagnosis (operation, procedure, key identifiers) while excluding secrets.
- Avoid catch-all behavior that hides failures. If a method catches `Exception`, it must either rethrow after logging or map to a documented legacy-compatible failure contract.
- Development observability must be visible during runtime testing: failed requests should produce actionable exception and log output without requiring source edits after the fact.

## Architecture Placement Carry-Forward Guardrail (MANDATORY)

- Keep Step 8 architecture-structure placement intact during Step 9 hardening.
- Persistence-facing row models must remain under `src/<AppName>.Library/Models/Entities/`.
- API transport-only request or response contracts must remain in Web.Api (`Models` or `DTOs`), not in Library entities.
- Any detected drift (for example, entity classes moved back into top-level `Models/`) must be corrected or recorded as an explicit blocker before Step 9 can be closed.

## Fusion Standards And Structure Guardrail (MANDATORY)

- Apply `/.github/skills/architecture-structure/Architecture-Structure.md` and `.modernization/ignition-artifacts/addendums/Architecture-Structure.md` as structural source of truth during Step 9 hardening, not only Step 8 formation.
- Apply `/.github/skills/fusion-feature-standards/SKILL.md` for backend hardening decisions that touch auth, config, logging, DI, middleware, caching, and HTTP seams.
- Use Fusion MCP docs/package tools to choose approved Fusion patterns before introducing any custom startup or service-registration behavior.
- For any Fusion package addition or upgrade in Step 9 (NuGet `Fusion.*`, npm `@fusion/*`), use the latest production version available in Sonatype feeds rather than historical sample versions.
- **Logging hardening must use the Fusion console provider approach:**
  - Install `Fusion.Fx.Logging.Providers.Console` into Web.Api using the latest production version in Sonatype feeds.
  - Add `"FusionConsole": {}` to `appsettings.json` Logging section to enable Fusion-aligned console output.
  - Consult the Fusion MCP README endpoint `fusion-readme:///src/dotnet/Fusion.Fx.Logging.Providers.Console/README.md` (via Fusion MCP docs search) for setup and customization details.
  - Backend stores then inject `ILogger<T>` normally; the Fusion provider registration wires everything together at startup.
  - This ensures logs flow through the Fusion-aligned console/STDOUT provider for production observability instead of custom app-owned logging paths.
- Current kit posture: all runtime logging should flow through the Fusion-aligned console/STDOUT provider built on Microsoft logging abstractions (`ILogger` path).
- Application Insights is a future enhancement lane and is not required for Step 9 completion in the current Ignition Kit process.
- DI hardening must remain in starter/Fusion extension points and follow Fusion composition patterns; do not bypass these with ad hoc registrations in feature classes.

## Authentication Transition Posture (MANDATORY)

- Final-state target remains Fusion starter-aligned Okta OAuth policy authorization.
- During mid-modernization backend testing (for example Postman or Scalar), controller-level policy attributes may be temporarily left commented for local validation when Okta client settings are not yet ready.
- If temporary auth relaxation is used, Step 9 evidence must explicitly record which controllers were relaxed and the re-enable trigger.
- Re-enable policy attributes before final frontend auth validation and before review completion.

## Step 9 Comment And Annotation Cleanup (MANDATORY)

- Remove or rewrite stale future-step wording in touched backend files (for example comments that say another step "will" harden the seam).
- After Step 9 executes, comments should describe current state, temporary bridge status, and explicit final-state expectations, not deferred promises.
- Remove unused `using` directives from touched C# files as part of hardening cleanup so backend files reflect final readable state.
- For API endpoints touched in Step 9, declare `ProducesResponseType` with the concrete response CLR type when the payload shape is discernible.
- Avoid anonymous-object success payloads for documented API surfaces; prefer explicit response models so OpenAPI and callers see stable contracts.

## DEV / QA lane separation (critical)

Step 9 DEV owns backend hardening plus the creation of the Step 9-owned backend test projects for the integration, contract, and db lanes under tests/backend. DEV scope is: align auth, config, logging, caching, HTTP/API seams, and middleware to the Step 7 contract; retire stale `Temporary bridge` classifications in .modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json; materialize the lane-specific test projects and initial tests needed by Step 9 QA; and prove the API still builds with `dotnet build` against src/<AppName>.Web.Api. DEV must not skip the test project creation work when those lanes are missing.

Creation and execution of the Contract test project, IntegrationBackend test project, and Db test project belong to the Step 9 pass so QA can execute them immediately afterward. DEV closeout hands off with the three explicit status fields below and the QA prompt is the recommended next action.

Run Step 9 backend .NET hardening for the intended modernization root.

- Classify Step 9 completion explicitly with these statuses:
  - `controlPointAlignmentStatus`: `Aligned`, `DriftDetected`, or `Blocked`
  - `integrationProtectionStatus`: `Current`, `Partial`, or `Blocked`
  - `startupProofStatus`: `CurrentBuildBacked`, `SkippedBuildCoverageExplicit`, or `Blocked`
- Do not report Step 9 complete when auth or configuration drift is still unresolved, when integration protection lags the changed seams, or when startup proof exists only through skipped API-build coverage without saying so plainly.
- Keep execution aligned to `/.github/instructions/AppMod-Process.instructions.md`, `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md`, and `/.github/skills/architecture-structure/Architecture-Structure.md`.
- Treat Step 9 as the explicit backend Fusion-alignment lane after Step 8 formation is stable.
- Consume `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` as the backend hardening contract instead of re-deciding backend ownership, target-state auth, or configuration shape.
- Focus on production-style backend hardening: Fusion-aligned auth or login wiring, configuration binding, logging, caching, HTTP or API seams, runtime integration stability, and the contract plus integration suites that protect the separated backend after Step 8 formation.
- Use Fusion-backed package and starter-shell patterns throughout this pass when the target app is Fusion-backed. Do not treat auth, login, caching, configuration, or logging alignment as a separate optional lane.
- Preserve the protected starter backend shell and DI/composition seams while retiring backend `Temporary bridge` behavior. Keep auth, logging, OpenAPI/Scalar, platform-owned configuration, and middleware ownership in the approved starter/Fusion-native control points instead of scattering them into feature code.
- Retire temporary legacy platform config sections for roles, policies, identity providers, logging, CORS, OpenAPI, and connection strings when the Step 7 decision artifact marked those concerns as starter/Fusion-owned final state. Keep app-specific settings outside those sections only when the concern is genuinely app-owned.
- If deployment inputs still require split database settings instead of a ready-made connection string, keep one centralized startup-bound composition seam that materializes the required `ConnectionStrings` entry. Do not duplicate raw environment-variable composition in repositories, services, or controllers.
- Keep local-run guidance aligned with the implemented seam. When Step 9 introduces or confirms the split `SqlServer__*` environment-variable path, refresh `/.modernization/.readme/HowToRun.md` so the API section contains one copy/pasteable alternative command that sets those variables in the current shell and then runs the API.
- When the modernized backend relies on a configuration-bound runtime seam (for example a legacy connection-string provider, a settings-backed external-service client, or any other component that throws at first request when its required configuration key is missing), verify the required key actually resolves in the active development configuration (`appsettings.Development.json`, user secrets, or environment bindings) for every name the seam will request (canonical name AND any legacy fallback name returned by the active options). A green `dotnet build` is NOT sufficient proof; an HTTP 500 on the first real request caused by a missing `ConnectionStrings` or settings entry must be treated as Step 9 incomplete (`startupProofStatus = Blocked`).
- **SQL Server dev connection strings using EF Core / `Microsoft.Data.SqlClient`**: `Microsoft.Data.SqlClient` (the driver used by EF Core on .NET 6+) enforces TLS certificate validation by default. On developer machines and internal staging environments where SQL Server uses a self-signed or internal-CA certificate, the connection will fail with `Win32Exception 0x80090325: The certificate chain was issued by an authority that is not trusted` - even when the same server is reachable via PowerShell `SqlConnection` (which uses the older `System.Data.SqlClient` driver that does not enforce validation). Add `TrustServerCertificate=True` to the `appsettings.Development.json` connection string for any SQL Server host that does not have a publicly trusted certificate. Do NOT add this to production or staging settings files.
- **Authorization policy registration verification**: Every `[Authorize(Policy = "X")]` attribute in a controller references a named policy that must be registered in DI. Grep controllers for `[Authorize(Policy =` and cross-check every referenced policy name against the modern API's `AddAuthorization(options => options.AddPolicy(...))` calls. A missing policy does not fail at build time - it throws `InvalidOperationException` at the first request and returns a generic 500. Verify this during startup proof, not just by reading code.
- Keep policy-based authorization only. Do not introduce or preserve Windows authentication, Negotiate, or direct role-check patterns as the Step 9 final state.
- When the app keeps app-owned current-user endpoints, security helpers, or authorization handlers, align them to the same membership source used by the protected policy path, normalize qualified versus short-name group identifiers in one place when needed, and do not leave raw-claim-only exact matching as the final state when richer profile-backed memberships exist.
- DEV verification before closing the step: ``dotnet build`` succeeds against the modern API project (this is the build-backed startup proof) and the touched control points still match the Step 7 contract. Do not run owned test suites, contract suites, integration suites, or db suites from DEV - those execution proofs are owned by ``09-QA-backend-dotnet-integration-hardening``.
- DEV verification before closing the step must also include at least one real runtime request for each newly hardened DB-backed endpoint to prove Dapper materialization succeeds under current configuration.
- When Step 9 cites current startup-proof evidence from `.modernization/portal/data/json/test-workspace-gates.json`, report whether `refreshSafePreflight` actually ran `API build` or skipped it through `skipFlags.skipApiBuild`. Do not treat skipped API-build coverage as equivalent to current backend hardening proof.
- Before closing the step, do a lightweight inline Fusion review for the touched backend auth, configuration, middleware, and bridge-removal scope using Fusion-backed docs and the starter shell as the source of truth.
- Keep numbered-flow execution state in `.modernization/portal/data/json/step-response-ledger.json` plus refreshed Step 9 evidence artifacts and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`; do not create or rely on a parallel retired Fusion-only state tracker for the numbered lane.
- Keep related hardening fixes, targeted tests, runtime proof, evidence refresh, and the mapped QA handoff inside the same Step 9 loop until a meaningful checkpoint, blocker, or step-complete proof pack exists.
- Return the exact backend changes made, refreshed validation evidence, explicit `controlPointAlignmentStatus`, `integrationProtectionStatus`, and `startupProofStatus` values, and the exact next gate.

Backend Load Smoke Gate (MANDATORY)
- Run a short load smoke (60 seconds default, configurable from Step 7 ``performanceBudgetPlan``) against the top N most-traveled modern endpoints from ``apiEndpointCatalog`` (default N = 5) using Bombardier, k6, NBomber, or hey. The tool is data-driven from ``/.modernization/ignition-artifacts/modernize/fusion-restructure/load-smoke.config.json``; if no config is present, default to Bombardier on Windows and k6 on Linux/macOS.
- For each endpoint, capture ``requestsPerSecond``, ``p50LatencyMs``, ``p95LatencyMs``, ``p99LatencyMs``, ``errorRatePercent``, and the request payload + auth scheme used. Persist to ``/.modernization/ignition-artifacts/modernize/fusion-restructure/backend-load-smoke.json`` keyed by endpoint and run timestamp.
- Fail the gate when ``requestsPerSecond`` is below ``requestsPerSecondFloor`` or ``p95LatencyMs`` exceeds ``p95LatencyCeiling`` from Step 7's per-endpoint budget. When Step 7 did not declare a budget, capture the run as the baseline and lock the numbers as the floor/ceiling for Step 17 to compare against.
- Generic across MVC controllers, Razor Pages handlers, Web API controllers, minimal APIs, Blazor server endpoints, and any other HTTP surface. Auth scheme comes from ``authIntegrationCatalog``; never invent a token shape.

## Step 9 DEV complete - next action

Step 9 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 9 QA will:** Verify Step 9 DEV retired backend bridges, hardened auth, HTTP, config, logging, and caching, and materialized the Step 9-owned integration, contract, and db test lanes against the API.
**Lanes:** Integration, Contract, Db
**Expected ETA:** 5-10 min ET

Reply with the number of your choice:
1. `QA` - run `09-QA-backend-dotnet-integration-hardening` now (recommended).
2. `next` - continue to Step 10 DEV (Frontend Foundation & Scaffold).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

## Closeout Summary

- After the step response is saved, refresh `.modernization/.readme/.StepSummary.md` with a short human-readable entry for Step 9.
- Keep the summary skimmable: when the step ran, whether the backend build passed, and the exact blocker or next gate.

You can also invoke the QA prompt directly with `/09-QA-backend-dotnet-integration-hardening`.
