---
description: Upgrade the backend from .NET Framework to the highest even .NET version available at runtime.
agent: OpX-dotnet-upgrade
tools: ['edit/editFiles', 'read/readFile', 'search/codebase', 'execute/getTerminalOutput','execute/runInTerminal','read/terminalLastCommand','read/terminalSelection']
---

# Step 7 DEV - Backend - Upgrade .NET

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 7 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 7 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 7 is the mutable upgrade lane before anything moves into `src/`. DEV owns the workspace, the upgrade, the build, and proving the app reaches a healthy URL. QA owns characterization, evidence refresh, and frontend compatibility.
- Dev work: Upgrade the backend in `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`), build clean, clear the port if already occupied, start backend, verify HTTP health. If a legacy frontend (BlockedHost) exists, start it over IIS Express. Leave the running processes for QA. For SPA-only or API-only apps (no BlockedHost), the backend alone is sufficient; QA owns frontend compatibility.
- QA plan: Use `07-QA-backend-upgrade-dotnet` immediately after DEV completes.

Purpose
- Upgrade the Step 7 backend workspace to the highest even .NET version available at runtime.
- Perform the actual backend upgrade inside the mutable Step 7 workspace. Creating the workspace folder or proving a legacy build alone is not Step 7 completion.
- Keep this step narrow: workspace check, upgrade, clean build, port clear, start, HTTP health proof, stay running.
- Characterization tests, evidence refresh, and frontend compatibility are QA responsibilities, not DEV.
- Remind the operator in closeout output to verify the current `src/` baseline is running locally so later verification compares code changes against a known-good baseline.
- This `src/` baseline check is reminder-only in Step 7 DEV. Do not run `dotnet build`, `dotnet run`, or HTTP probes against `src/` from this step.
- Step 7 runs in one declared execution mode selected from observed host topology:
  - `RunnableRuntime`: backend host can be started and probed in this step; full runtime proof is required.
  - `ConstrainedLegacyHost`: classic System.Web/MVC/WebForms host topology cannot truthfully run as net10 in-place; Step 7 still performs build/invariant/readiness evidence and hands off to Step 8 without a false runtime-failure block.
- Classify Step 7 DEV completion with these statuses:
  - `baselineIsolationStatus`: `Preserved`, `Compromised`, or `Blocked`
  - `upgradeWorkspaceStatus`: `Validated`, `Unstable`, or `Blocked`
  - `step8HandoffStatus`: `ReadyForFormation`, `NotReadyForFormation`, or `Blocked`
- In `RunnableRuntime`, DEV is not complete until the backend is running and at least one real, authenticated API route returns a real application response. An infrastructure probe alone (`/openapi/v1.json`, `/swagger`, or `/`) is necessary but NOT sufficient. A broken page, an unhandled 500, or an anonymous-only probe is a failure; fix it before declaring done.
- In `ConstrainedLegacyHost`, runtime probe requirements are explicitly `N/A` for Step 7. Completion depends on deterministic build + invariant proof + explicit Step 8 handoff evidence.

DEV completion reality check (read before you start)
- Build-green is NOT Step 7 done. A clean build only proves each project compiles against its own referenced versions; it does not prove the upgraded app runs, talks to its dependencies, or returns real data.
- A mutable workspace named `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade` is NOT evidence of an upgrade by itself. Step 7 is still incomplete if the projects inside that workspace remain non-SDK .NET Framework projects or still declare `TargetFrameworkVersion` such as `v4.8` instead of a real `net<major>.0` target for the `Direct` projects.
- You are not done until the backend is STARTED and at least one real controller route returns a real authenticated 2xx (or a legitimate domain 4xx) with a real response body. If you have only built, you are roughly half done - do not report readiness.
- The two most common "builds green, faults at runtime" traps on a major .NET jump are a split-version package (caught by the invariant gate in Execution order step 6) and a data-layer connection regression such as the SqlClient Encrypt default change (see Package compatibility rules). Both are invisible to the build and only surface when you actually start the app and hit a real route.

Read only these inputs
1. `/.modernization/portal/data/json/modernization-execution-contract.json`
2. `/.modernization/ignition-artifacts/Modernization-Phase-Assessment.md`
3. Optional: `/.github/instructions/dotnet.instructions.md`
4. Use `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` only when a concrete auth, config, API, logging, or delivery decision needs it.

Contract independence (do not depend on QA)
- The execution contract is a planning artifact owned by Step 5 `Modernization Solution Design`. It is NOT QA output and Step 7 must never assume a QA portal refresh has run.
- Treat the contract as advisory input only. If it is missing, empty, or its workspace roots do not exist on disk, Step 7 must self-heal deterministically (see Execution order step 2) instead of stopping or waiting for QA.
- Deterministic input self-heal: if `/.modernization/portal/data/json/modernization-execution-contract.json` is missing or empty, run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 7 -Mode Input -EnsureControlPlane`. This materializes a generic, app-agnostic control file (no fabricated routes) so Step 7 can proceed on a `No QA` run. The workspace root and ports still resolve from Execution order step 2 defaults.
- Never treat a value read from the contract as ground truth without confirming the referenced path exists. A contract that names `<workspace>/<AppName>.Library` style sub-paths that are not present on disk is stale; fall back to the whole-clone resolution rule below.

Fast rules
- Work only in `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`).
- Do not do Step 7 uplift in repo-root `src/<AppName>.*`.
- Do not run Step 7 build/start/probe commands against `src/`. `src/` is gate-only confirmation input.
- Do not run characterization tests, evidence refresh, or portal scripts in this step. Those are QA.
- Do not run broad QA during Step 7. No `qa-run-all-tests.ps1`.
- If the port is already in use when you try to start, stop the occupying process, do a clean rebuild, then start fresh.
- Leave both processes running when DEV completes. QA needs them alive.
- Do not declare DEV done if both probes fail, return 4xx/5xx, or show an error page. Fix it first.
- Port defaults: `step7BackendPort` = 5100 (HTTPS), `step7FrontendPort` = 5200 (HTTP). Fall back to `step9BackendPort`/`step9FrontendPort` when Step 7 aliases are not present.
- Ports 4200 and 5001 are reserved for the modernized `src/` app. No Step 7 process may bind to 4200 or 5001.
- Test-project carry-forward policy: copy existing test projects into `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`) for reference and compatibility context, but do not upgrade or execute them in Step 7 DEV. Step 8 and its mapped QA own test modernization and execution updates.

SPA host handling
- If the entry host uses `Microsoft.AspNetCore.SpaServices.Extensions` or similar SPA middleware to proxy to an Angular/React dev server, disable it during Step 7:
  - Remove the `Microsoft.AspNetCore.SpaServices.Extensions` package reference (deprecated .NET 7, removed .NET 8+).
  - Comment out or remove `services.AddSpaStaticFiles(...)`, `app.UseSpaStaticFiles()`, and the entire `app.UseSpa(...)` block in `Startup.cs` or `Program.cs`.
  - Remove or disable the `DebugEnsureNodeEnv` and `PublishRunWebpack` MSBuild targets that try to run `npm install` / `npm run build` during the .NET build.
  - The Angular/React client is not part of Step 7 backend upgrade scope. The API must be independently healthy without a frontend dev server running.
  - If the root URL (`/`) returns 404 after SPA removal, that is acceptable for Step 7 as long as the OpenAPI and API-route probes succeed.

Hard stop blockers
- No compatible even .NET SDK is installed.
- `step7UpgradeWorkspaceRoot` (or fallback `step9UpgradeWorkspaceRoot`) is required but missing.
- In `RunnableRuntime` mode only: the backend still does not build or start after the direct Step 7 remediation loop.
- In `ConstrainedLegacyHost` mode: mark runtime verification as constrained, not blocked, when the host topology is physically non-runnable for net10 in this pass.

Execution order
0. Add a reminder in closeout output (non-blocking):
   - Include this reminder text in the final report: "Reminder: verify the current source project in src is running locally on your machine before continuing downstream steps."
   - Do not require user input for this reminder and do not stop Step 7 based on reminder acknowledgment.
   - Do not execute Step 7 build or runtime verification commands in `src/`.
1. Resolve the highest even .NET SDK.
   - `dotnet --list-sdks`
2. Resolve the upgrade workspace deterministically; do not block on a missing or stale contract.
   - Read `step7UpgradeWorkspaceRoot` from the execution contract (fallback `step9UpgradeWorkspaceRoot`).
   - Normalize the value to a single clone folder. If the contract value is a per-project sub-path (for example `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade/<AppName>.Library`), use only the top-level clone folder (`.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`). The clone is the whole legacy backend solution, not invented per-project roots.
   - If the contract is missing, empty, or the resolved folder does not exist, default the workspace to `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade` where `<major>` is the resolved highest even .NET major from step 1.
   - If the resolved workspace folder does not exist, create it by copying the whole legacy backend solution from `authoritativeLegacyRoot` (the legacy solution root under `LegacyCode/`) now. Do not modify `LegacyCode/`.
   - Workspace-first guardrail: until this workspace exists, do not run Step 7 build/start/probe commands anywhere else.
   - If workspace creation fails, return `Blocked` and stop. Do not fall back to `src/` execution.
   - Classify only the projects in that workspace as `Direct` or `BlockedHost`.
3. Select execution mode from topology before runtime requirements are applied.
   - Set `executionMode=RunnableRuntime` when an entry backend host can be truthfully started and probed in this step.
   - Set `executionMode=ConstrainedLegacyHost` when topology is classic System.Web/MVC/WebForms and cannot be truthfully started as net10 in this step.
   - Record the mode and rationale in the final report and step state.
4. Upgrade in dependency order: shared libraries, backend libraries, entry host.
   - For `Direct` projects, this step is expected to make the real upgrade changes in the mutable workspace: SDK-style conversion where needed, target-framework retargeting to the resolved even .NET version, package alignment, and source fixes required to build truthfully on that target.
   - Do not treat a copied legacy project that still targets `.NET Framework` as an upgraded handoff candidate for Step 8.
   - Keep copied test projects unchanged in this step for compatibility context only; classify them and defer any test-upgrade execution to Step 8 and mapped QA.
   - Apply the package compatibility rules (below) during this step.
5. If you changed target frameworks or package management, rerun restore.
6. Clear the port if already in use (`RunnableRuntime` only).
   - Find the process occupying the backend port and validate ownership before force-stopping it.
   - Safety check pattern:
     - `netstat -ano | findstr :<port>` to resolve PID
     - `Get-Process -Id <pid> | Select-Object Id, ProcessName, Path`
     - Stop only when the process path or name matches the previous Step 7 backend host, IIS Express, or a known prior local run you are replacing.
   - `Stop-Process -Id <pid> -Force`
7. Clean build (required in both modes).
   - `dotnet build <entry-host.csproj> -nologo --verbosity minimal`
   - Zero errors required. Warnings are acceptable but should be noted.
   - Single-version invariant (hard gate): run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-upgrade-invariants.ps1 -WorkspaceRoot <step7UpgradeWorkspaceRoot>`. A clean build does NOT prove dependency consistency - NuGet compiles each project against its own referenced version, so a split-version package builds green but only the highest version ships, and the project compiled against the other version faults at runtime. `RESULT: OK` (exit 0) is required. On `RESULT: BLOCKED` (exit 2), align every flagged package to one version across the whole closure, rebuild, and re-run until OK before starting the backend. The check classifies test projects separately, so test-only carry-forward version differences are reported but do not block; product-code splits do.
   - Run-folder config determinism (check before you start): confirm the entry host's own `appsettings*.json` is what actually ships to the build/run output. A referenced library that ships its own `appsettings.json` / `appsettings.Development.json` with `CopyToOutputDirectory=Always` both breaks `dotnet publish` (NETSDK1152 "multiple publish output files with the same relative path") and can non-deterministically overwrite the host's connection string in the run folder. If a library does this, scope its settings to its own tests or stop copying them to output so the host config wins.
8. Start the backend and verify the URL (`RunnableRuntime` only).
   - Set `ASPNETCORE_URLS` and `ASPNETCORE_ENVIRONMENT=Development` before starting the exe so the correct port and OpenAPI middleware are active.
   - Use `Start-Process` (not `Start-Job`) for persistence: `$env:ASPNETCORE_URLS="https://localhost:<step7BackendPort>"; $env:ASPNETCORE_ENVIRONMENT="Development"; Start-Process -FilePath <exe> -WorkingDirectory <workDir> -WindowStyle Hidden -PassThru`
   - Probe order (required). Use curl retry flags so a slow first start does not read as a failure: `--retry 20 --retry-delay 1 --retry-connrefused --retry-all-errors`.
   - Preferred probe (.NET OpenAPI): `curl.exe -sk -o NUL -w "%{http_code}" --retry 20 --retry-delay 1 --retry-connrefused --retry-all-errors --connect-timeout 5 --max-time 25 https://localhost:<step7BackendPort>/openapi/v1.json`
   - Swashbuckle Swagger probe (many upgraded apps expose Swagger, not the .NET `/openapi` endpoint): try `https://localhost:<step7BackendPort>/swagger/v1/swagger.json` (expect 2xx) and `https://localhost:<step7BackendPort>/swagger` (expect 200 or 301/302) before concluding the infrastructure probe failed.
   - Root fallback probe: `curl.exe -sk -o NUL -w "%{http_code}" --connect-timeout 5 --max-time 15 https://localhost:<step7BackendPort>/`
   - Success rule: any one of OpenAPI 2xx, Swagger JSON 2xx, Swagger UI 200/301/302, or root 2xx/3xx satisfies the infrastructure probe. If the SPA middleware was removed, root 404 is acceptable as long as a Swagger/OpenAPI probe or the deep API probe succeeds.
   - If every infrastructure probe fails, or content shows an unhandled exception or error page, that is a failure. Fix and restart.
   - Log the probe URL that succeeded, HTTP status, and process ID.
   - Deep API probe (required): after the infrastructure probe succeeds, identify at least one real API controller route (for example the first `[ApiController]` route in the project). Probe it under an AUTHENTICATED context so the request reaches controller logic instead of being short-circuited by auth middleware: `curl.exe --negotiate -u : -sk -o "<workspace>\_deep-probe.json" -w "%{http_code}" --connect-timeout 5 --max-time 30 <url>` when the app uses Windows/Negotiate auth in Development (otherwise use the app's real auth path). An anonymous `401`/`403` only proves auth runs BEFORE the controller; it does not prove the upgraded query/handler code works, so treat an anonymous-only probe as inconclusive, not healthy.
   - Read the captured body; do NOT discard it with `-o NUL`. On any 500 the response body is the primary diagnostic: open the captured `_deep-probe.json` and inspect `Message` / `InnerMessage`. An `InnerMessage` naming a database, TLS/certificate (for example "The certificate chain was issued by an authority that is not trusted"), login, or connection failure is a REAL upgrade regression you must fix in this step - it is NOT an environmental "DB unreachable, move on." The most common cause on a 3.x -> 8 jump is the `Microsoft.Data.SqlClient` Encrypt default change; the fix is `TrustServerCertificate=True` (or `Encrypt=False` where appropriate) on the connection string (see Package compatibility rules).
   - Loaded-vs-compiled cross-check (required): once the backend is running and its assemblies are in the run/publish folder, re-run the invariant check against that folder: `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-upgrade-invariants.ps1 -WorkspaceRoot <step7UpgradeWorkspaceRoot> -PublishDir <publish-or-run-folder>`. A shipped-vs-compiled major mismatch is a runtime defect even if a probe returned 2xx.
   - Loader-exception scan (required): start the backend with its stdout/stderr redirected to a log file, then scan that log for `MissingMethodException`, `TypeLoadException`, `MissingFieldException`, `FileLoadException`, `FileNotFoundException` naming an assembly, or "Could not load file or assembly". ANY hit is a hard failure even if the HTTP status looked healthy - the app's own error handling can remap a fatal loader fault to an ordinary status (for example 422 instead of 500).
   - Result rule: the authenticated route must return a real application response (typically `200`, or a legitimate domain `4xx` that is NOT a masked loader fault) AND the loader-exception scan must be clean. A `500`, or any loader exception in the log, means the upgrade has a runtime defect that must be fixed before declaring DEV done. Do not rely solely on OpenAPI or root probes - they can succeed while every real API route fails.

8a. **Readiness Verification Gate** (`RunnableRuntime` only) — verify the backend is production-ready for QA.

After the deep API probe succeeds and loader-exception scan is clean, test cross-origin API accessibility and diagnose common HTTP seam issues:

- **Test cross-origin API access** (simulate Angular frontend on different port):
  - Open a browser to `http://localhost:4201` (the planned Angular dev port) using the integrated browser tool.
  - Make a simple API request from the browser console (for example a GET to `https://localhost:5100/api/some-endpoint`).
  - Observe: does the browser return the API response, or a CORS error in the Network tab?
  - Record the exact error message if CORS is missing (typically "No 'Access-Control-Allow-Origin' header").

- **Diagnose HTTP seams** — read the actual startup code to understand what's configured:
  - Find the backend's `Startup.cs` or `Program.cs` (check both locations in the upgrade workspace).
  - Scan for key middleware:
    - CORS middleware: Look for `services.AddCors(...)` and `app.UseCors(...)`.
    - Authentication middleware: Look for `services.AddAuthentication(...)` and `app.UseAuthentication()`.
    - Error handling middleware: Look for custom exception middleware or `app.UseExceptionHandler(...)`.
  - Read the source code, not assumptions. If CORS is missing, note the exact location where it should be added.

- **Fix common HTTP seam issues** (apply fixes intelligently based on what you find):
  - If CORS is missing AND cross-origin calls fail: edit `Startup.cs`, add CORS configuration in `ConfigureServices()` method:
    ```csharp
    services.AddCors(options =>
    {
        options.AddDefaultPolicy(builder =>
        {
            builder.AllowAnyOrigin()
                   .AllowAnyMethod()
                   .AllowAnyHeader();
        });
    });
    ```

    And in the `Configure()` method (after `app.UseRouting()`, before endpoints):
    ```csharp
    app.UseCors();
    ```

    Then rebuild and restart the backend before retesting.
  - If authentication headers are not being passed, check if the auth middleware requires specific header formats — read the auth configuration (Negotiate, Bearer, etc.) and adjust the cross-origin test request accordingly.
  - If the error message indicates a missing configuration entry (connection string, auth provider), check `appsettings.Development.json` for the required key. Add it if missing.

- **Retry and re-verify** — after each fix:
  - Rebuild: `dotnet build <entry-host.csproj> -nologo --verbosity minimal`
  - Restart the backend (kill the old process, start the new one with the same `Start-Process` command)
  - Re-test the cross-origin API call from the browser
  - Record the number of attempts, what was fixed, and the final result.

- **Record readiness status** in `.modernization/portal/data/json/step-response-ledger.json`:
  ```json
  {
    "readinessVerification": {
      "crossOriginAccessWorking": true/false,
      "corsConfigured": true/false,
      "authMiddlewareWired": true/false,
      "issuesDetected": [ "list of what was found" ],
      "issuesFixed": [ "list of what was fixed" ],
      "diagnosticAttempts": <number>,
      "finalResult": "Ready" | "Blocked"
    }
  }
  ```

- **Proceed to step 9 only when**:
  - The deep API probe from step 8 returned a real application response (not 500, not a masked loader fault).
  - The loader-exception scan from step 8 is clean.
  - Cross-origin API calls now succeed (CORS working) OR you have explicitly documented why cross-origin access is not needed in this step (for example, "SPA frontend will be integrated in Step 10, not Step 7").
  - If readiness verification revealed an unrecoverable issue (unknown error pattern, environmental blocker), document it explicitly and proceed to step 9 with `finalResult: Blocked`.

9. **If BlockedHost exists** (legacy MVC/Razor frontend), start it via IIS Express (`RunnableRuntime` only):
   - Use `Start-Process` for persistence: `Start-Process -FilePath "C:\Program Files (x86)\IIS Express\iisexpress.exe" -ArgumentList '/path:"<BlockedHost-web-root>" /port:<step7FrontendPort> /clr:v4.0' -WindowStyle Hidden -PassThru`
   - Probe: `curl.exe -sk -o NUL -w "%{http_code}" --connect-timeout 5 --max-time 30 http://localhost:<step7FrontendPort>/` - accept 200 or 302.
   - First-request latency may be up to 30 seconds if the app connects to a corporate database that is unreachable in this environment. Wait for the full timeout before declaring failure.
   - Log the confirmed URL, HTTP status, and process ID.
   - **If no BlockedHost** (SPA-only or API-only, frontend disabled per SPA host handling): skip this step. The backend API alone is sufficient for Step 7 completion; QA owns frontend compatibility testing.
10. Leave the backend running. Do not stop it (`RunnableRuntime` only). QA will use it. If a BlockedHost exists and started successfully in step 9, leave it running as well.

ConstrainedLegacyHost closeout contract (applies when `executionMode=ConstrainedLegacyHost`)
- Do not declare `Blocked` only because runtime probing is impossible for the current host topology.
- Required proof in this mode:
  - clean deterministic build evidence for all in-scope projects that can build in this lane,
  - workspace single-version invariant result (`RESULT: OK`),
  - explicit host-topology rationale for constrained runtime,
  - explicit Step 8 handoff plan identifying rehost/API-first verification ownership.
- If any `Direct` project in the Step 7 workspace still remains on legacy `.NET Framework` targeting (for example `TargetFrameworkVersion v4.8`) instead of the resolved even .NET target, Step 7 must close as `Blocked`, not `Validated`, and the closeout must tell the user that the actual Step 7 upgrade did not complete and Step 7 must be rerun or continued before Step 8 can proceed.
- Required status mapping in this mode:
  - `baselineIsolationStatus=Preserved` unless baseline contamination occurred,
  - `upgradeWorkspaceStatus=Unstable` only if unresolved build/invariant defects remain; otherwise `Validated` with constrained runtime note,
  - `step8HandoffStatus=ReadyForFormation` when Step 8 has actionable handoff evidence.

State save and readback contract (required before closeout)
- Save the latest full Step 7 response into `.modernization/portal/data/json/step-workflow-state.json`. The Step 7 output self-check validates this file's schema, so it must contain these populated fields: a TOP-LEVEL `status`, `updatedAt`, `latestFullResponse`, a `lastExecutedStep` object (`step`, `label`, `status`), a `recommendedNextStep` object (`step`, `label`), and a `stepResponses.steps[]` entry for this step (`step`, `status`, `updatedAt`, `latestFullResponse`). A nested step `status` alone is NOT enough - the top-level `status` must be present or the schema check fails.
- Read back the saved Step 7 step entry and verify populated `status`, `updatedAt`, and `latestFullResponse`.
- Read back unified state and verify populated top-level `status`, `updatedAt`, `lastExecutedStep.status`, `recommendedNextStep.step`, and `recommendedNextStep.label`.
- Also create or update `.modernization/portal/data/json/step-response-ledger.json` (top-level `status`, `updatedAt`, and a `steps[]` array mirroring the step entry). The Step 7 output self-check (`verify-step-artifacts.ps1 -Step 7 -Mode Output`) requires this ledger file to exist and be non-empty; closeout is not complete until that check returns `RESULT: OK`.

Project rules
- `Direct`: library, worker, console, or test project that can move fully to the target runtime now.
- `BlockedHost`: legacy ASP.NET MVC, Web API, or Web Forms host that cannot truthfully be called upgraded in this pass.
- Remove stale `packages.config` when converting to SDK-style `PackageReference`, unless there is a documented reason to keep it.
- Add `System.Configuration.ConfigurationManager` when modern-target code still uses `ConfigurationManager`.
- Do not replace EF6 with EF Core unless that migration is explicitly in scope.
- Fix async anti-patterns encountered during upgrade (`.Result`, `.Wait()`, `.GetAwaiter().GetResult()`). Defer broader code quality reform to Step 8.

Package compatibility rules
- When upgrading the TFM across major versions, update ALL version-coupled packages to versions compatible with the target framework. The most common families that MUST be version-matched:
  - `Microsoft.EntityFrameworkCore.*` — must match the target TFM major version. EF Core 3.x on .NET 10 will compile but crash at runtime.
  - `Microsoft.AspNetCore.Authentication.*` (Negotiate, JwtBearer, OpenIdConnect, etc.) — update to the target TFM major version or remove if now provided by the shared framework.
  - `Microsoft.Extensions.*` (Logging, Configuration, DependencyInjection, etc.) — remove explicit references that are now provided by the shared framework, or update to the target version.
- When upgrading EF Core across major versions (especially 3.x -> 5+ or 5+ -> 8+), fix known breaking API changes:
  - `SqlFunctionExpression.Create(...)` was removed in EF Core 5.0. Replace with the `HasDbFunction(...).HasTranslation(...)` lambda pattern or rely on default convention mapping when the method name matches the SQL function name.
  - Private-reflection helpers that access EF Core internals (`_relationalCommandCache`, `_selectExpression`, `_querySqlGeneratorFactory`) must be replaced with the public `IQueryable<T>.ToQueryString()` API added in EF Core 5.0.
  - `AddEntityFrameworkSqlServer()` is obsolete; use `AddDbContext<T>(o => o.UseSqlServer(...))` directly.
  - `Microsoft.Data.SqlClient` connection behavior changed across majors. SqlClient 4.0+ (pulled in transitively by EF Core 7/8) flipped the `Encrypt` connection-string default from `false` to `true`. A connection string that worked on EF Core 3.1 (SqlClient 1.x/2.x, `Encrypt=false`) with no explicit `Encrypt`/`TrustServerCertificate` now negotiates TLS and FAILS the handshake against a server presenting an internally-issued certificate, surfacing at runtime as a 500 whose `InnerMessage` is "The certificate chain was issued by an authority that is not trusted." A build never reveals this; it only appears when a real route hits the database. Restore the legacy behavior by adding `TrustServerCertificate=True` (or `Encrypt=False` where appropriate) to every affected connection string, including `appsettings.json` and `appsettings.Development.json`.
- Remove packages that were deprecated or deleted in later .NET versions:
  - `Microsoft.AspNetCore.SpaServices.Extensions` — deprecated in .NET 7, removed in .NET 8+. Remove the package AND disable `app.UseSpa(...)`, `services.AddSpaStaticFiles(...)`, and SPA-related MSBuild targets (`DebugEnsureNodeEnv`, `PublishRunWebpack`).
  - `Microsoft.VisualStudio.Web.CodeGeneration.Design` — development-time tool; remove if no compatible version exists for the target TFM.
  - `MicroElements.Swashbuckle.FluentValidation` or similar old Swagger-FluentValidation bridges — remove if they conflict with the updated FluentValidation version; also remove corresponding `c.AddFluentValidationRules()` calls.
- When removing a package that was pulling transitive dependencies (for example Newtonsoft.Json via MicroElements), add the transitive package as a direct reference if the project's code still uses it.
- If a library project references `EFCore.BulkExtensions` or similar ORM add-ons, check whether the code actually calls its extension methods. If not, remove the reference. If so, update to a version targeting the new EF Core major.
- After package changes, always `dotnet restore` and confirm zero NU1102/NU1107/NU1202 errors before attempting to build.
- Single-version rule: after all package changes, every shared package MUST resolve to exactly one version across all projects in the workspace. Move package majors atomically across the entire closure - never bump one project and leave a sibling behind. Prove it with `verify-upgrade-invariants.ps1` (Execution order step 6). This is the check that prevents a green build from shipping a runtime-fatal diamond / split-version break.

Required final report
1. Resolved SDK and target framework
2. Declared execution mode and rationale (`RunnableRuntime` or `ConstrainedLegacyHost`)
3. Project classification table (project name, SDK style, target framework, Direct/BlockedHost)
4. Test carry-forward note (which test projects were copied as reference only, and explicit note that Step 7 DEV did not upgrade or execute them)
4. Build result (errors, warnings)
5. Port: was it cleared? Previous PID and ownership check summary if applicable.
6. Backend probe URL used, HTTP status code returned, process ID left running
7. Legacy frontend URL, HTTP status code returned, process ID left running
8. Blockers and explicit status values:
   - `baselineIsolationStatus`: `Preserved` | `Compromised` | `Blocked`
   - `upgradeWorkspaceStatus`: `Validated` | `Unstable` | `Blocked`
   - `step8HandoffStatus`: `ReadyForFormation` | `NotReadyForFormation` | `Blocked`
   - When blocked, explicitly say whether the failure is due to: workspace not actually retargeted to `net<major>.0`, package or source upgrade failures, runtime proof failure, or constrained-host classification only.
   - When blocked because the workspace is not actually upgraded, explicitly say: `The Step 7 mutable workspace was created but the .NET upgrade did not complete successfully. Re-run Step 7 before Step 8.`
9. Reminder:
   - Include: "Reminder: verify the current source project in src is running locally on your machine before continuing downstream steps."

Completion bar
Report `Ready for QA handoff` only when all of these are true:
- every `Direct` project in the Step 7 mutable workspace has actually been upgraded to the resolved even .NET target and is no longer left on legacy `.NET Framework` targeting
- backend build: zero errors
- single-version invariant: `verify-upgrade-invariants.ps1` returns `RESULT: OK` for the workspace and (after start) for the run folder via `-PublishDir`
- backend probe rule satisfied (OpenAPI 2xx preferred, root 2xx/3xx fallback when OpenAPI is unavailable) when `executionMode=RunnableRuntime`; otherwise explicitly marked `N/A (ConstrainedLegacyHost)`
- deep API probe: at least one real controller route returns a real application response under an authenticated context (not 500, not a masked loader fault), and the loader-exception log scan is clean when `executionMode=RunnableRuntime`; otherwise explicitly marked `N/A (ConstrainedLegacyHost)`
- backend process is still running when `executionMode=RunnableRuntime`; otherwise explicitly marked `N/A (ConstrainedLegacyHost)`
- **If BlockedHost exists** (legacy MVC/Razor frontend over IIS Express):
  - legacy frontend URL returns HTTP 2xx or 3xx when `executionMode=RunnableRuntime`; otherwise explicitly marked `N/A (ConstrainedLegacyHost)`
  - legacy frontend process is still running when `executionMode=RunnableRuntime`; otherwise explicitly marked `N/A (ConstrainedLegacyHost)`
- **If no BlockedHost** (SPA-only or API-only, frontend disabled per SPA host handling): these items are N/A; QA owns frontend compatibility
- `LegacyCode/` was not modified
- step state save and readback checks are complete

## Step 7 DEV complete - next action

Step 7 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 7 QA will:** Confirm backend probe health on the running backend, take a screenshot, run legacy characterization against `LegacyCode/`, run modern characterization against the upgrade workspace, compare for regressions, do a coverage gap assessment, check legacy frontend compatibility, and refresh all Step 7 evidence.
**Lanes:** HTTP verify, Screenshot, Legacy characterization, Modern characterization, Coverage gap assessment, Legacy frontend compatibility, Evidence refresh
**Expected ETA:** 10-20 min ET (warm cache)

Reply with the number of your choice:
1. `QA` - run `07-QA-backend-upgrade-dotnet` now (recommended).
2. `next` - continue to Step 8 DEV (Backend Modernization Formation).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/07-QA-backend-upgrade-dotnet`.
