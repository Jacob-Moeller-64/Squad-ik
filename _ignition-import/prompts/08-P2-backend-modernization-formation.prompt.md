---
description: Form the modernized backend structure from the approved modernization solution design and Architecture-Structure guide.
agent: OpX-AppMod-P2-Modernize
tools:
  - edit/editFiles
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
---

# Backend Modernization Formation

**Recommended model tier:** Premium reasoning (high thinking). **Estimated run time:** 20-40 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 8 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Restore-point precheck before mutating the backend shell: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 8 -Mode Verify`. If it reports that no restore point exists, run the matching `-Mode Ensure` command from the contract and do not change `src/` or `LegacyCode/` until the restore point is present.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 8 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.
> - Fusion MCP preflight gate before any Fusion-backed modernization decision: verify Fusion MCP tools are reachable by successfully calling `mcp_fusion_fusion_api_docs_entrypoints` (or the active equivalent docs/package MCP probe). If the probe fails or tools are unavailable, set Step 8 to `Blocked`, report `Fusion MCP unavailable`, and do not continue backend formation decisions that require Fusion guidance.

About To Do
- Context: Step 8 is the backend formation lane. It must prove `Library` was formed first, `Web.Api` was formed second, and the resulting backend in `src/` is strong enough for Step 9 hardening.
- Dev work: Move validated backend seams from the Step 7 workspace into the approved `src/` targets, validate each checkpoint in order, and keep leftover drift or coexistence truth explicit.
- QA plan: Use `[WORKFLOW] Backend - Modernization Formation` inside the active Step 8 loop at meaningful checkpoints and at closeout to confirm ordered formation, retained legacy-frontend coexistence, and the Step 9 backlog or readiness state.
- Model requirement: Step 8 execution must run on GPT-5.3-Codex.

## Starter Placeholder Cleanup (MANDATORY)

- On the first backend move into `src/`, remove starter sample surfaces that conflict with the app-specific backend slice.
- Explicitly remove placeholder controllers such as `MyEntitiesController` and `PublicTextController` when they are not part of the approved Step 5 backend scope.
- Remove associated placeholder models, entities, and services that are referenced only by those placeholder controllers (for example `PublicTextResponse`, `IMyService`, `IPublicTextService`, and related sample types).
- Do not leave placeholder starter endpoints active alongside modernized app endpoints.

## Naming And Evidence Rules (MANDATORY)

- Do not use page-label names such as `Home*` or abbreviated view labels such as `Pj*` for backend service names when a domain name is available.
- Name backend services and controllers by domain capability (for example `DowntimeLookup`, `DowntimeRules`, `ApplicationCatalog`, `RuleMutation`).
- When discovery artifacts are incomplete for a seam, use those artifacts first, then look back at the relevant legacy code files to complete the mapping before implementing.
- For this app family, legacy repository behavior in `LegacyCode*/**/Repository.cs` is valid source evidence for DB-backed lookup and mutation semantics.

## Production Data Access Guardrail (MANDATORY)

- Step 8 production seams in `src/<App>.Library` and `src/<App>.Web.Api` must not replace DB-backed behavior with hardcoded in-memory stores.
- In-memory data implementations are allowed only in test projects under `tests/**` and must be clearly test-scoped.
- If a temporary bridge is unavoidable in `src/`, classify it explicitly as `Temporary bridge`, keep it thin, and route mandatory replacement into Step 9 hardening.

## Architecture Placement Guardrail (MANDATORY)

- Apply `/.github/skills/architecture-structure/Architecture-Structure.md` literally for backend model placement.
- In simple architecture, DB-row or persistence-facing classes must live under `src/<AppName>.Library/Models/Entities/`.
- Do not leave persistence-facing row models directly under `src/<AppName>.Library/Models/` once their destination is known.
- API transport-only contracts used to simplify HTTP requests or responses must stay in Web.Api (`src/<AppName>.Web.Api/Models/` or `DTOs/Requests|Responses`), not in Library entities.
- If an object classification is ambiguous, classify it explicitly in the Step 8 report as `Entity`, `API transport model`, or `Temporary bridge` with rationale.

## Fusion Standards Guardrail (MANDATORY)

- For Step 8 backend formation decisions, apply `/.github/skills/fusion-feature-standards/SKILL.md` alongside `Architecture-Structure`.
- Use Fusion MCP docs/package tools before inventing custom startup, DI, logging, auth, HTTP, caching, or configuration patterns.
- If Fusion MCP is unavailable, keep the step blocked per preflight gate rather than making unverified Fusion-structure decisions.

## Backend Debuggability Baseline (MANDATORY)

- Form backend services with clear exception boundaries so Visual Studio breakpoints and exception inspection are practical during runtime debugging.
- Use `ILogger<T>` in backend services and log failures with full exception context at boundary points (for example connection open, DB execution, external call boundaries).
- Do not swallow exceptions silently. Either rethrow after logging or return a documented legacy error-signaling value where contract compatibility requires it.
- For Dapper-backed mapping code, prefer typed mapping (`Query<T>`) when practical. If dynamic rows are used, avoid direct casts for cross-type DB values (for example SQL `int` to app `string`) and use explicit conversions (`Convert.ToString`, `Convert.ToInt32`, etc.) to prevent runtime binder failures.
- Dapper typed mapping parity rule (mandatory): for constructor-bound records/classes used in `Query<T>`, constructor parameter CLR types must match SQL result column CLR types. Do not materialize SQL `int` columns into constructor parameters typed as `string`.
- If API/entity contracts require a different type than the DB row shape, use a two-step mapping: materialize into a DB-shaped row model first, then project explicitly to the final contract model.
- Before closing Step 8, execute at least one real runtime call per newly formed DB-backed lookup endpoint to prove Dapper materialization succeeds (no constructor-signature materialization exceptions).

Objective
- Form the target backend structure after `.NET upgrade` and before UI-led modernization begins.
- Move validated upgraded backend seams from the Step 7 mutable upgrade workspace into repo-root `src/` only after raw backend viability has already been proven outside `src/`.
- Apply the architecture decision already made in Modernization Solution Design.
- Apply the Step 5 numbered-lane backend decisions from `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` instead of re-deciding backend ownership during formation.
- Treat `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` as the authoritative Dominion backend acceptance standard for formation decisions and drift control.
- Use `/.github/skills/architecture-structure/Architecture-Structure.md` as the structural source of truth and `.modernization/ignition-artifacts/addendums/Architecture-Structure.md` as the app-specific execution addendum for backend project shape, dependency direction, and formation scope.
- Use `/.github/skills/fusion-feature-standards/SKILL.md` to validate Fusion-owned backend seams and avoid custom framework rewrites during formation.
- Preserve the protected starter-derived backend shell and platform control points while moving app-owned backend behavior into the approved target structure.
- Prepare the backend shell so later slices can land in the target structure without re-deciding architecture.
- Prepare the backend seams that the later frontend modernization steps depend on, including the controller, API, service, contract, and composition boundaries that Step 10 and Step 11 will build against.
- Form the repo-root `src/` backend target skeleton incrementally, starting with `Project.Library` and then `Project.Web.Api`, before later Step 10 frontend modernization begins.
- Execute the backend extraction step of the modernization sequence: remove business logic from server-rendered controllers, place reusable backend logic into the approved backend layers, and convert controller responsibilities into API-oriented contracts and endpoints.
- Classify Step 8 completion explicitly with these statuses:
  - `libraryFormationStatus`: `Validated`, `Incomplete`, or `Blocked`
  - `apiFormationStatus`: `Validated`, `Incomplete`, or `Blocked`
  - `step9HandoffStatus`: `ReadyForHardening`, `NotReadyForHardening`, or `Blocked`
- Do not report Step 8 complete by feel when `Library` and `Web.Api` were not validated in order, when retained coexistence with the legacy frontend is still unverified where required, or when validated leftovers remain but are not recorded as visible drift.

Target Architecture Profile
- Use the target architecture already chosen in Modernization Solution Design and Architecture-Structure. Do not invent a new target shape during Step 8.
- Apply the naming law during backend formation: backend, frontend, and test identities in the .NET and Angular layers use the approved application identity, with the client root expressed as `src/<AppName>.Web.Client`.

**Code Quality Standards (MANDATORY)**
Every file formed in Step 8 MUST meet these standards:
- **DI Patterns**: Use constructor injection via DI container. NO `new Service()` in production code.
- **Authorization Policy DI**: When the legacy `Startup.cs` contains `AddAuthorization(options => options.AddPolicy(...))` calls, every named policy and its `IAuthorizationHandler` registrations MUST be ported to the modern API's DI extension. Do not assume the legacy startup still runs. A missing policy throws `InvalidOperationException` at runtime and returns a generic 500 before the controller action body is reached — it will NOT appear as a missing-registration build error. Checklist: grep the legacy `Startup.cs` (and any `ConfigureServices` extension files) for `AddPolicy`, `AddAuthorization`, and `IAuthorizationHandler`; verify each one is present in the modern DI extension before marking `apiFormationStatus: Validated`.
- **HttpClient**: Use `IHttpClientFactory` or typed clients. NO `new HttpClient()`.
- **Disposables**: Implement `IDisposable` or `IAsyncDisposable` correctly. Use `using` or `await using`.
- **No Static State**: NO mutable static fields. Singletons only via DI.
- **SOLID Principles**:
  - Methods < 50 lines (excluding boilerplate)
  - Classes < 500 lines
  - Single responsibility per class
  - Depend on abstractions (interfaces), not implementations
- **Async Patterns**: NO `.Result`, `.Wait()`, `.GetAwaiter().GetResult()`
- **DTOs**: Use records for data transfer: `public record CreateItemRequest(string Name);`
- **Nullability**: Handle nulls explicitly. Use `required` modifier or null checks.
- **Magic Values**: NO hardcoded strings/numbers. Use constants or configuration.
- Code that violates these standards is incomplete Step 8 formation.

---

# UNIT TEST REQUIREMENTS (MANDATORY - Step 8 Creates This)

**Step 8 is the heaviest backend unit test growth step. Create tests AS services move to Library.**

**Unit Test Directory Structure (REQUIRED)**
Create this structure in Step 8:
```
tests/backend/unit/
+-- {AppName}.Library.Tests/
    +-- {AppName}.Library.Tests.csproj
    +-- GlobalUsings.cs
    +-- Services/
    |   +-- {ServiceName}Tests.cs    # One per service
    +-- Validators/
    |   +-- {ValidatorName}Tests.cs  # One per validator
    +-- Helpers/
        +-- {HelperName}Tests.cs     # One per helper
```

**Unit Test Project Setup (REQUIRED)**
Create `tests/backend/unit/{AppName}.Library.Tests.csproj`:
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
    <Nullable>enable</Nullable>
    <IsPackable>false</IsPackable>
    <IsTestProject>true</IsTestProject>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Microsoft.NET.Test.Sdk" Version="17.*" />
    <PackageReference Include="xunit" Version="2.*" />
    <PackageReference Include="xunit.runner.visualstudio" Version="2.*" />
    <PackageReference Include="Moq" Version="4.*" />
    <PackageReference Include="FluentAssertions" Version="6.*" />
    <PackageReference Include="coverlet.collector" Version="6.*" />
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\..\..\src\{AppName}.Library\{AppName}.Library.csproj" />
  </ItemGroup>
</Project>
```

**GlobalUsings.cs (REQUIRED)**
```csharp
global using Xunit;
global using Moq;
global using FluentAssertions;
global using System.Threading.Tasks;
```

**Test Template for Each Service (REQUIRED)**
For EACH service moved to Library, create a test class:
```csharp
// This file protects the {ServiceName} business logic for Step 8.
// This file verifies that {ServiceName} correctly handles {business capability} without external dependencies.
// This file stays in the backend unit lane so service behavior can be proven in isolation.
// This file makes the Step 8 {ServiceName} contract explicit before integration tests depend on it.

using Microsoft.Extensions.Logging;
using Moq;
using {AppName}.Library.Services;

namespace {AppName}.Backend.UnitTests.Services;

public sealed class {ServiceName}Tests
{
    [Fact]
    public void MethodName_ValidInput_ReturnsExpectedResult()
    {
        // CaseId: STEP8-{SERVICE}-001
        // Scenario: Service needs to calculate result with valid input data.
        // Description: The method should perform the calculation and return the expected value without errors.
        // Input: Valid input with all required fields populated.
        // Expected: The method returns the calculated result.

        // Given: a service instance with mocked dependencies.
        var mockDependency = new Mock<IDependency>();
        mockDependency.Setup(x => x.GetValue()).Returns(10);
        var service = new {ServiceName}(mockDependency.Object);

        // When: the method is called with valid input.
        var result = service.MethodName(validInput);

        // Then: the result matches the expected calculation.
        Assert.Equal(20, result);
    }

    [Fact]
    public void MethodName_NullInput_ThrowsArgumentNullException()
    {
        // CaseId: STEP8-{SERVICE}-002
        // Scenario: Service receives null input where input is required.
        // Description: The method should fail fast with ArgumentNullException to prevent downstream errors.
        // Input: Null input parameter.
        // Expected: ArgumentNullException with parameter name.

        // Given: a service instance with mocked dependencies.
        var mockDependency = new Mock<IDependency>();
        var service = new {ServiceName}(mockDependency.Object);

        // When: the method is called with null input.
        var action = () => service.MethodName(null);

        // Then: the method throws ArgumentNullException with the parameter name.
        var exception = Assert.Throws<ArgumentNullException>(action);
        Assert.Contains("input", exception.ParamName, StringComparison.Ordinal);
    }
}
```

**Step 8 Unit Test Exit Criteria (EXECUTION ONLY — DO NOT DERIVE):**
- [ ] QA phase announcement made after dev work complete
- [ ] One test class per Library service
- [ ] Every catalog entry from `.modernization/portal/data/json/executable-testcase-catalog.json` where `owningStep == 8` has been implemented as a test method with the planned CaseId, file, and method name
- [ ] Every implemented test file has the 4-line file-level purpose block
- [ ] Every implemented test method has CaseId/Scenario/Description/Input/Expected comments matching the catalog entry
- [ ] All tests pass (`dotnet test` exit code 0)
- [ ] `test-accumulation-tracker.json` updated with actual counts

**Step 8 Backend Formation Closeout Gate (MANDATORY):**
- When Step 8 disposition is `Execute`, closeout is blocked unless backend movement work was actually performed in this pass (move-not-copy or create-validate-delete accounting cannot be `none` when blockers are absent).
- `Backend-Modernization-Formation-Report.md` must show:
  - `libraryFormationStatus: Validated`
  - `apiFormationStatus: Validated`
  - `step9HandoffStatus: ReadyForHardening`
  - `Move-not-copy or create-validate-delete actions executed in this pass:` set to concrete executed work, not `none`, unless a concrete blocker is listed.
- If blockers remain, Step 8 must stay open with explicit blocker rows. Do not report completion while blockers are unresolved.
- Output self-check must pass: `verify-step-artifacts.ps1 -Step 8 -Mode Output`.

**Phase 2 has no derivation authority for test scenarios.** Step 8 implements what Step 6 planned. If a needed test is missing from the catalog (for example, the service was added after Step 6 closed, or Step 3 missed a branching parameter, throw guard, null-coalescing default, list method, display decorator, or delegation path), STOP. Route back to Step 3 to refresh the Service & Behavior Inventory, then to Step 6 to refresh the catalog, then resume Step 8. Do not invent scenarios here. A test added in Step 8 without a matching catalog entry will not survive the kit being reused on the next application — the intelligence must live in the plan.

**xUnit Test Requirements (MANDATORY)**
Step 8 must create test infrastructure:
- Create `tests/backend/unit/` directory structure
- Create test files for each service moved to Library, one file per service named per the catalog `testFile` field
- Use the catalog `testMethod` field as the test method name verbatim
- Use `[Fact]` for single cases, `[Theory]` for parameterized
- Tests without proper naming, structure, or a matching catalog entry are incomplete Step 8 coverage.

**Running Unit Tests (REQUIRED)**
```powershell
# Run all unit tests
dotnet test tests/backend/unit/ --verbosity normal

# Run with coverage
dotnet test tests/backend/unit/ --collect:"XPlat Code Coverage"

# Generate coverage report
reportgenerator -reports:coverage.cobertura.xml -targetdir:coveragereport
```

**Test Accumulation Tracker Update (MANDATORY)**
At end of Step 8, update `.modernization/portal/data/json/test-accumulation-tracker.json`:
```json
{
  "currentStep": 8,
  "backendCoverage": {
    "unitTestCount": {count},
    "servicesCovered": {count},
    "servicesTotal": {count},
    "coveragePercent": {percent},
    "step8Target": 60,
    "step9Target": 80,
    "status": "InProgress"
  }
}
```

- When the selected target presentation strategy is browser-led with a separate Angular or SPA client, the execution target is split frontend versus backend architecture.
- In split simple architecture, the backend target is normally `<App>.Web.Api` plus `<App>.Library`, and the frontend target is `<App>.Web.Client`.
- In split clean or CQRS architecture, the backend target is normally `<App>.Web.Api` plus the approved Application, Domain, and Infrastructure boundaries, and the frontend target is `<App>.Web.Client`.
- In this repo's naming contract, those backend examples are PascalCase .NET identities, and the Angular client root is `src/<AppName>.Web.Client`.
- For this workflow, the active Step 8 formation root for a split browser-led target is repo-root `src/`, not a retired staging `src/` clone and not a single legacy web-host project left as the primary target shape.
- The required Step 8 project ordering is `Library` first, then `Web.Api`. The client scaffold belongs to later frontend steps, not Step 8.
- `Starter` is a scaffold placeholder, not an acceptable completed Step 8 identity. Step 8 must replace starter project names, namespaces, package names, and references with the approved application name from the execution contract or deploy-values source.
- Resolve the approved application name dynamically from repo evidence such as the selected modernization solution, execution contract, or deploy-values source. Do not hardcode a specific app name into the workflow or the validation rules.
- `Library` or the inner backend layers own shared non-UI code such as business rules, application services, reusable validation, integration abstractions, repository interfaces, and reusable models that are not presentation-specific.
- `Web.Api` owns transport and orchestration concerns such as API controllers or minimal endpoints, request or response contracts, authentication, authorization, middleware, dependency injection wiring, HTTP mapping, and backend-boundary validation.
- `Web.Client` owns browser presentation concerns such as pages, components, routes, forms, state, client-side validation, HTTP services, templates, and styling.
- MVC, Razor, `.cshtml`, server-rendered layouts, and controller-returned views are legacy-source patterns when the chosen target presentation strategy uses a separate web client. They may be reverse-engineered and temporarily tolerated during transition, but they are not valid target-state patterns.
- AngularJS modules or templates, older Angular browser shells, static HTML plus JavaScript surfaces, and other legacy browser assets are likewise source-only evidence for the later frontend steps when the chosen target presentation strategy uses a separate modern web client; Step 8 must not recast them as backend target-state patterns.
- Step 8 forms only the backend side of the approved target. Step 10 and Step 11 form, wire, and harden the client side when a browser-facing target exists.

Execution mode
- Current Step 8 execution rule: treat Library formation, Web.Api formation, same-step seam extraction, focused test growth, runtime proof, and the mapped QA handoff as one continuous Step 8 loop.
- Do not stop after each small backend seam when one clear Step 8 path still exists. Batch closely related backend formation work until the lane reaches a real checkpoint, blocker, or step-complete evidence pack.
- This prompt is operational, not advisory. Execute the backend-formation pass in the modernization workspace.
- Do not redesign the architecture during this step. The architecture choice must come from Modernization Solution Design and Architecture-Structure.
- Preserve behavior. This step forms structure and seams; it does not rewrite feature behavior.
- Fail fast if the architecture choice, backend formation plan, or modernization workspace is missing.
- Use move-not-copy progression wherever practical: form the destination slice, validate it there, then remove the prior source version from the earlier location.
- When direct move is too risky, the only allowed fallback is create-validate-delete. Report any validated leftovers that remain in the prior location as visible drift.
- After Step 8 consumes Step 7 upgrade seams and the Step 8 evidence pack is written, delete the temporary Step 7 clone workspace under `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade` unless the user explicitly asked to retain it for forensics.
- Backend formation must complete before the frontend scaffold and migration steps depend on unstable backend boundaries.
- Preserve the existing baseline content in `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`; only add clarifying execution guidance when needed for this step.
- Do the formation work inside `targetSourceRoot`. For split browser-led targets, use repo-root `src/` as the active formation root during Step 8.
- Do not move frontend files, Razor views, `.cshtml` templates, layouts, or client display logic during Step 8 unless the user explicitly requests a cleanup or removal step.
- When Step 8 requires transitional coexistence with a retained legacy browser surface, do not delete or silently orphan that legacy browser surface during Step 8. Keep it explicitly classified as temporary frontend coexistence while the backend target moves to repo-root `src/`.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json`, and the saved ledger entry was read back with populated `status`, `updatedAt`, and `latestFullResponse`.

Required inputs
- `Modernization-Solution-Design.*` artifacts in `.modernization/ignition-artifacts/`
- `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`
- `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`
- `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`
- `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md`
- Any app-specific acceptance-criteria addendum explicitly provided for the current app
- Modernization-Phase-Assessment artifact in `.modernization/ignition-artifacts/`
- Modernization-Execution-Contract artifact in `.modernization/ignition-artifacts/`
- `/.github/skills/architecture-structure/Architecture-Structure.md`
- `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`
- `.NET upgrade` results and runtime evidence
- The `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`) defined by `Modernization-Execution-Contract.*` and proven by Step 7
- The `modernizationWorkspaceRoot` and `targetBackendRoot` defined by `Modernization-Execution-Contract.*`
- Legacy characterization and test-planning evidence used to protect current-slice behavior
- The executable testcase catalog and modernized test-folder contract generated by Step 6
- `.modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json` generated by Step 6 planning script
- `.modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json` generated by Step 6 planning script
- Runtime topology, integration contract, environment and secrets, data-migration, and cutover-planning artifacts produced by Step 5 and Step 7

Fail-fast gates
- Stop immediately if `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` is missing, because backend formation must stay anchored to Dominion acceptance standards.
- Stop immediately if `/.github/skills/architecture-structure/Architecture-Structure.md` is missing or does not provide enough structural guidance to form the chosen target architecture.
- Stop immediately if `.modernization/ignition-artifacts/addendums/Architecture-Structure.md` does not clearly state the chosen backend target structure.
- Stop immediately if Modernization-Phase-Assessment is missing, stale, or does not state whether Step 8 is `Skip`, `ValidateOnly`, or `Execute`.
- Stop immediately if the Modernization-Execution-Contract artifact is missing, stale, or does not clearly reconcile the authoritative modernization workspace root with the target backend root this step is supposed to form.
- Stop immediately if `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, or `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` is missing, stale, or materially inconsistent with the Step 5 development plan and execution contract.
- Stop immediately if the target application identity is unresolved, still ambiguous, or still left as the scaffold placeholder `Starter` when the actual app name is known from repo evidence.
- Stop immediately if Modernization Solution Design does not define backend formation scope, sequence, and ownership.
- Stop immediately if `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`) is missing, stale, or does not contain the validated upgraded backend that Step 7 was required to prove before formation begins.
- Stop immediately if `modernizationWorkspaceRoot` is missing or does not build from the prior handoff.
- Stop immediately if the backend formation plan cannot be traced to approved target architecture decisions.
- Stop immediately if the step would require net-new business behavior rather than structural formation.
- Stop immediately if backend formation would invalidate runtime topology, integration compatibility, environment constraints, or cutover assumptions already captured in Step 5 and Step 8.
- Stop immediately if Step 8 work would keep MVC view rendering as a target-state pattern instead of moving toward API transport plus Angular presentation.
- Stop immediately if backend formation would place Razor views, `.cshtml`, page layouts, or UI rendering responsibilities into `Library` or `Web.Api` as target-state artifacts.
- Stop immediately if backend formation would move frontend files or UI rendering assets into `src/` during Step 8; Step 8 only owns backend extraction.
- Stop immediately if `.modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json` or `.modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json` is missing; re-run Step 6 Modernization Quality Design to regenerate the required layering-gate inputs, then resume Step 8.

Required work
- Read Modernization Solution Design, Modernization-Phase-Assessment, Modernization-Execution-Contract, `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`, `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`, `/.github/skills/architecture-structure/Architecture-Structure.md`, `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`, and `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` before editing.
- Read the architecture target (justified simple, split simple, clean/CQRS, or split clean/CQRS) from Modernization Solution Design and Architecture-Structure. If the decision is missing or ambiguous, STOP and route back to Step 5; do not decide it here.
- If Modernization-Phase-Assessment marks Step 8 as `Skip`, do not reshape the backend skeleton; verify the existing modernization workspace already conforms to the required target structure, runtime gate, and integration-test expectations.
- If Modernization-Phase-Assessment marks Step 8 as `ValidateOnly`, limit work to proof, gap closure, and evidence refresh needed to confirm the target skeleton is already substantially in place.
- If the selected application does not own a backend target in the modernization execution contract, treat Step 8 as not applicable and refresh evidence rather than forcing backend formation work.
- Use `.modernization/ignition-artifacts/modernize/fusion-restructure/migration-plan.json` as the machine-readable placement contract for target roots, artifact-family handling, and step-owned move sequencing. Do not invent alternate backend destinations during formation.
- Use `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` as the protected control-point contract for backend-owned startup, route, configuration, auth, and service-provider seams that later steps must preserve.
- Form the minimum backend target structure required for the next slices inside repo-root `src/` by moving or recreating validated upgraded seams from `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`). Do not pull directly from frozen `LegacyCode/` on the normal Step 8 path.
- Establish backend project and folder boundaries that later slices must use.
- For split browser-led targets, materialize `src/<App>.Library` first and validate it, then materialize `src/<App>.Web.Api` and validate it. Do not require `src/<AppName>.Web.Client` creation in Step 8.
- Replace scaffold placeholder names such as `Starter.Library`, `Starter.Web.Api`, and `Starter.Web.Client` with the approved application identity as part of Step 8 when those placeholders are the current target scaffold.
- Preserve the protected starter-derived backend shell by default. Do not replace or regenerate `Program.cs`, starter DI or composition seams such as `DependencyInjection.cs` or builder-extension variants, protected logging/bootstrap files, starter auth wiring, or starter OpenAPI/Scalar setup unless the Step 5 decisions artifact explicitly allows a narrow rebind or a recorded temporary bridge.
- Apply the Step 5 platform-ownership decisions while forming backend seams: re-home auth, roles, policies, identity providers, logging, CORS, OpenAPI, and connection-string concerns into the approved starter or Fusion-native sections or `ConnectionStrings` rather than carrying forward legacy top-level shapes, unless the plan explicitly records a temporary bridge.
- If deployment inputs require split database settings instead of a ready-made connection string, create one centralized startup-bound composition seam that materializes the required `ConnectionStrings` entry for backend consumers; do not push raw environment-variable reads into feature services, repositories, or controllers.
- Use policy-based authorization only. Do not introduce Windows authentication, Negotiate, or direct role-check patterns as Step 8 target-state behavior.
- Do not normalize backend projects or namespaces to lowercase to match frontend conventions. Backend naming stays PascalCase and the frontend root stays aligned to `src/<AppName>.Web.Client`.
- When the chosen target is a split browser-led architecture, form backend boundaries that map to `Library` or inner-layer responsibilities plus `Web.Api`, even if temporary transitional projects exist during staging.
- Extract business logic, orchestration logic, data access coordination, and reusable backend rules out of MVC controllers and place them into backend services, `Library` classes, or approved inner backend layers.
- Move backend app-owned business logic, repositories, adapters, models, reusable validation, and integration abstractions into `Library` or the approved inner backend layers first; then move controllers, DTOs, request or response contracts, API-specific middleware, and app API composition code into `Web.Api` while keeping the protected starter host/bootstrap files as the source of truth for platform-owned behavior.
- Use `ILogger<T>` in migrated app-owned backend code, but do not rewrite the protected starter logging/bootstrap files unless the Step 5 decisions artifact explicitly requires a narrow backend formation change.
- Convert controller responsibilities from view-returning server endpoints toward API-oriented contracts and JSON or data endpoints once the logic they depend on has been extracted.
- Move files and references so the resulting codebase visibly reads as layered split architecture: `Library` for shared backend logic and `Web.Api` for HTTP transport and orchestration, while the legacy frontend remains temporarily in `LegacyCode/` until the frontend steps begin.
- Keep temporary legacy UI compatibility only as a transition aid when needed. It is acceptable for old UI surfaces to coexist briefly while new APIs are stood up behind them, but that temporary state must be explicit and must not be mistaken for the target architecture.
- When app-owned current-user endpoints, security helpers, or authorization handlers move during Step 8, keep them aligned to the starter-owned policy and membership seams and record any remaining claim-only, old-auth, or legacy-doc behavior as an explicit `Temporary bridge` for Step 9 instead of treating it as the target state.
- Create the backend test root defined by Step 6 and start materializing the Characterization and Unit suites for the active slices into that root. Capture the Step 9 contract and integration backlog explicitly instead of pulling those suites forward into Step 8 completion.
- Treat Step 8 as the heaviest backend unit and characterization growth step: expand unit coverage as logic moves into `Library`, expand characterization-backed regression as real seams move out of legacy MVC ownership, and leave Step 9 to create or refresh the contract and integration suites once the separated runtime seams are stable enough to harden.
- When logic currently embedded in `.cshtml` or other legacy presentation files is promoted into backend code, document that origin explicitly and cover the extracted logic with Step 8 unit and characterization regression.
- Apply dependency direction required by the chosen architecture.
- Create or reshape the target backend project skeleton so the modernization workspace clearly reflects the chosen end-state structure, such as `Project.Api`, `Project.Library`, `Project.Application`, `Project.Infrastructure`, and `Project.Domain` when applicable.
- Move or prepare only the backend shell, composition points, contracts, and seams needed to support later slice work.
- Move or prepare only the backend shell, composition points, contracts, and seams needed to support later slice work, using the legacy engineering map from Step 5 and the slice traceability defined in Step 8.
- Use the Step 5 destination map as the placement contract. Do not guess where controller-owned logic, page-backed scripts, render-only models, or embedded data access should land.
- Keep startup and runtime viability intact.
- Verify the formed backend runs correctly after Step 8 and run backend tests after the `Library` move and again after the `Web.Api` move before handing off the separated runtime seams to Step 9.
- After the `Library` move, run the relevant unit suites first and refresh any characterization-backed regression covering the extracted logic.
- After the `Web.Api` move, run the relevant unit and characterization-backed regression for the moved seams, then record exactly which contract and integration suites Step 9 must create, refresh, or execute.
- Refresh Step 8 characterization evidence in `tests/modernization/characterization/testcase` and the Step 8 report `tests/modernization/characterization/testResult/step-08-backend-modernization-formation.md`. Do not create new modernization-owned characterization lanes under `LegacyCode/`, new step-named folders under `tests/modernization/characterization`, or duplicate step-prefixed parity scripts.
- Verify the formed backend runs correctly from `src/<App>.Web.Api` after Step 8.
- When Step 8 requires temporary coexistence with the retained legacy frontend surface, verify that the retained legacy frontend host under `LegacyCode/` still works against the backend now running from `src/` and record whether runtime coexistence remains direct, proxied, or still pending later frontend steps.
- Use the Step 6 executable testcase catalog as the backlog source of truth. Do not invent a new backend test list during Step 8 when Step 6 already enumerated the cases.
- Verify the formed backend still aligns to Dominion acceptance criteria for API auth, policy usage, stateless structure, configuration externalization, logging, and backend testing before handing off to Step 9.
- Do not begin frontend shell or UI route formation in this step.
- Do not leave MVC controllers returning views as the completed backend target. Temporary coexistence is allowed only outside the target `src/<App>.*` shape and must be documented as transitional.
- Refresh backend-formation evidence before QA begins.
- Universal application rule: backend formation is responsible only for owned backend seams. It must not invent a backend project for UI-only targets or duplicate external platform seams that Step 8 marked as out of scope.
- Convert legacy MVC controller responsibilities by rule when the target is split browser-led architecture: request handling, auth checks, HTTP mapping, and transport contracts move to `Web.Api`; reusable business logic, orchestration services, and integration abstractions move to `Library` or the approved inner backend layers; Views, layouts, partials, and display behavior do not move during Step 8 and instead become client work in Step 10 and Step 11.
- Repositories or direct data access found in controllers must be pulled behind backend services or repository seams.
- Reporting, export, upload, download, and external integration behavior must be expressed as reusable backend seams instead of controller-local view actions where the target architecture requires API-backed behavior.
- Do not allow `Web.Api` controllers in the target state to return `ViewResult` or depend on `.cshtml` files.
- Do not allow `Library` to accumulate UI rendering concerns, HTTP transport concerns, or MVC controller concerns.

Code comment quality (clean comments)
- Every new or substantially rewritten `.cs` file in `src/<App>.Library` and `src/<App>.Web.Api` must carry an explanatory file-header comment that states what the file is, why it exists, and how it fits into the modernization slice (legacy origin if any, target seam, related interface).
- Every new public type must carry a short `<summary>` XML doc comment that explains the responsibility in plain English. Avoid restating the class name; explain the role.
- Every new public method must carry a short `<summary>` XML doc comment plus `<param>` and `<returns>` notes when the behavior is not obvious from the signature (for example, soft-delete semantics, prefix-based status flags, cascade rules, null-default columns, allow-listed dynamic SQL).
- Inline comments are required wherever Step 8 preserves a non-obvious legacy behavior (for example `INACTIVE:` description prefixes, `DTP=30.000` style null-defaults, cascade-delete-to-`pjTxCalcsNew` rules, Excel export filename patterns, Fusion PathBase stripping `/api` before route matching, allow-list table validation for dynamic-table mutations).
- Comments must explain *why*, not just *what*. Do not leave commented-out code, `TODO` without an owner, or scaffolding markers like `// generated` in committed files.
- Keep code clean and easy to maintain: no dead branches, no copy-pasted helpers, no analyzer suppressions wider than the smallest block that needs them, and no inline magic numbers that hide a Step 5 decision.
- The chat closeout must list every created or modified file as workspace-relative markdown links so reviewers can jump directly to the surfaces that received comment coverage.

Required outputs
- Refresh backend formation results in `.modernization/ignition-artifacts/`.
- Produce or refresh these exact artifact families:
- `Backend-Modernization-Formation-Report.*`
- `Modernization-Solution-Design.*`
- `Parity-and-Proof-Status-Report.*`
- `Leadership-Summary.*`
- Refresh `.modernization/ignition-artifacts/addendums/Architecture-Structure.md` only by adding clarifying execution guidance if backend formation decisions had to be made more explicit for execution. Do not replace or erase the original authored guidance.

Required artifact content
- Backend-Modernization-Formation-Report.* must include: chosen architecture, target backend project layout, dependency rules, what was formed in this pass, what remains for later slices, and current blockers.
- Backend-Modernization-Formation-Report.* must also include: runtime topology constraints honored, integration and configuration seams formed, execution roots honored from the modernization execution contract, backend runtime verification status, backend test status, integration test status, the backend test root created in this pass, which executable suites were materialized from the Step 6 catalog, any data-migration or cutover-sensitive work intentionally deferred, and acceptance-criteria alignment against Dominion backend standards.
- Backend-Modernization-Formation-Report.* must also include: how unit coverage grew around extracted backend logic, which characterization-backed cases became carry-forward regression coverage in this pass, and which backend seams still need additional contract or integration protection.
- Backend-Modernization-Formation-Report.* must also include: which validated source files or slices were removed from their prior location, which fallback create-validate-delete cases were used, and which leftovers remain as explicit visible drift.
- Backend-Modernization-Formation-Report.* must also include: which controller-owned logic was extracted, which controllers were converted from view-returning responsibilities toward API contract responsibilities, which temporary legacy UI compatibility points remain, and what still blocks full backend separation.
- Backend-Modernization-Formation-Report.* must also include: which protected starter control points were preserved, which platform-owned configuration concerns were re-homed into approved starter/Fusion-native sections or `ConnectionStrings`, which backend bridges remain explicit, and which backend decisions still need Step 9 hardening.
- Backend-Modernization-Formation-Report.* must also include: whether `src/<App>.Library` was created or refreshed first, whether `src/<App>.Web.Api` was then created or refreshed, whether `Starter` placeholder identity was fully removed from the backend target, and whether MVC remains only as a temporary coexistence surface rather than the target architecture.
- Backend-Modernization-Formation-Report.* must also include: how `<App>` was resolved without hardcoding, which validated upgraded seams were taken from `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`), whether the modernized backend was run successfully from `src/<App>.Web.Api`, whether the retained legacy frontend host in `LegacyCode/` still works when coexistence is required, and whether the old frontend is explicitly recorded as a temporary later-step frontend consumer instead of an ungoverned leftover.
- Backend-Modernization-Formation-Report.* must also include: explicit Step 7 workspace cleanup disposition (`Deleted`, `Retained by user request`, or `Blocked`) and the workspace path used for that disposition.
- Modernization-Solution-Design.* must stay aligned to the executed backend formation sequence.
- Parity-and-Proof-Status-Report.* must include whether backend formation preserved the protected current slice and what proof still remains.
- Leadership-Summary.* must reflect the backend formation milestone and the next backend/frontend steps.

Required source-evidence refresh
- During this handoff, refresh these source artifacts in this order:
- `Backend-Modernization-Formation-Report.*`
- `Modernization-Solution-Design.*`
- `Parity-and-Proof-Status-Report.*`
- `.modernization/portal/data/json/CURRENT-COMPLIANCE-REPORT.json`
- Any portal page, page-model, markdown, or HTML refresh remains manual and user-invoked only.

Quality bar
- Backend formation must be traceable to Architecture-Structure and Modernization Solution Design.
- Project and folder boundaries must be explicit and senior-developer readable.
- No hidden redesign is allowed during this handoff.
- The modernization workspace must visibly resemble the intended target backend skeleton after Step 8, not just contain isolated seam files.
- Repo-root `src/` must visibly resemble the intended backend target for split browser-led targets, with `src/<App>.Library` formed first and `src/<App>.Web.Api` formed second. A single legacy web host with extracted folders is not sufficient.
- The resulting backend shape must be stable enough for Step 10 `Frontend Foundation & Scaffold` and the later frontend migration steps to build against.
- The resulting backend shape must be stable enough for Step 10 `Frontend Foundation & Scaffold` and the later frontend migration steps to build against, including stable route, DTO, service, and policy seams, while the legacy frontend remains the temporary UI checkpoint.
- Any Architecture-Structure updates must preserve the original authored content and appear as additive clarification, not a rewrite.
- When the chosen target is split browser-led architecture, the formed backend must clearly read as backend-only structure: `Library` or inner layers for shared non-UI logic and `Web.Api` for HTTP transport or orchestration.
- The modernization workspace should move away from MVC when the chosen target is a separate client plus API model, not repackage MVC as the target.
- Step 8 is not complete if controllers still own most business logic, data access coordination, or reporting/export/upload behavior that should now live behind reusable backend seams.
- Step 8 is not complete if protected starter backend control points were broadly rewritten instead of being reused through approved seams, or if platform-owned configuration still depends on ungoverned legacy top-level shapes when the Step 5 plan marked those concerns as starter/Fusion-owned final state.
- Step 8 is not complete if the starter scaffold is still named `Starter`, if `src/<App>.Library` and `src/<App>.Web.Api` are not both formed in order, or if `Web.Api` still depends on Razor view rendering as a target-state pattern.
- Step 8 is not complete if the application identity was hardcoded instead of resolved from repo evidence, if the backend was not proven runnable from `src/<App>.Web.Api`, or if a required retained legacy frontend coexistence surface in `LegacyCode/` was left unverified and unclassified.

Execution checklist
1. Read Modernization Solution Design, Modernization-Execution-Contract, `/.github/skills/architecture-structure/Architecture-Structure.md`, and `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`.
2. Confirm backend target architecture and required boundaries.
3. Confirm `modernizationWorkspaceRoot`, `targetBackendRoot`, and prior runtime/build status.
4. Form the backend shell and dependency direction required for the next slices.
5. Verify backend runtime and execute backend and integration tests for the formed skeleton.
6. Refresh backend-formation and related evidence.
7. Hand off to QA Validate Current Slice.

Mandatory response sections
- Prerequisite status
- Architecture source of truth
- Backend target structure
- Formation work completed
- Formation readiness status
- Dependency direction status
- Build and runtime status
- Unit, contract, and integration growth status
- Parity protection status
- Artifact status
- QA handoff status
- Readiness decision for Step 9 BackEnd - .NET Integration Hardening

Response expectations
- Keep the final response concise, but include every mandatory response section.
- State exactly what backend structure was formed and what remains deferred.
- State exactly which evidence pages and reports were refreshed.
- End with one explicit line: Ready for Step 9 BackEnd - .NET Integration Hardening: Yes or No.

Layering Enforcement Gate (MANDATORY)
- Add NetArchTest (or equivalent architectural-rule library) rules that run inside the modern solution's build/test pipeline so layering violations fail the build instead of being caught only by review:
  - ``Library`` projects must not reference ``Web.Api`` projects or ASP.NET hosting types.
  - ``Web.Api`` must not reference legacy assemblies after a slice has been closed (the closed-slice list is loaded from ``/.modernization/ignition-artifacts/modernize/fusion-restructure/slice-status.json``).
  - Modern projects must not reference ``System.Web``, ``System.Web.Mvc``, ``System.Web.Http``, ``WebActivatorEx``, or any other legacy-only namespaces declared in ``/.modernization/ignition-artifacts/modernize/fusion-restructure/forbidden-references.json``.
  - Public types in ``Library`` that represent domain primitives must not depend on framework HTTP, MVC, or hosting types.
- The rule project lives at ``tests/backend/<App>.Architecture.Tests`` and runs as part of ``dotnet test`` in CI and locally.
- Generic across MVC, Razor Pages, Web Forms, Web API legacy hosts, and Blazor backends. The forbidden-namespace list is data-driven from the JSON above, not hard-coded into the test class.

## Step 8 DEV complete - next action

Step 8 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 8 QA will:** Verify Step 8 DEV moved code into the target architecture and implemented every catalog entry where owningStep == 8.
**Lanes:** Unit
**Expected ETA:** 3-5 min ET

Reply with the number of your choice:
1. `QA` - run `08-QA-backend-modernization-formation` now (recommended).
2. `next` - continue to Step 9 DEV (Backend .NET Integration Hardening).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/08-QA-backend-modernization-formation`.
