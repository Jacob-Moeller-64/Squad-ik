---
description: "Step 1. Validate workstation readiness, Sonatype access, and the manual src plus legacy-code-aware verification prerequisites before Discovery continues."
name: "01-P1-workstation-readiness"
argument-hint: "Check workstation readiness, report missing prerequisites, and guide the user through the manual src and legacy verification flow after the legacy app is copied into LegacyCode"
agent: "OpX-AppMod-P1-Discovery"
tools:
  - read/readFile
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
---

# Workstation Readiness

**Recommended model tier:** Light (low thinking). **Estimated run time:** 5-10 min (varies with app size and model).

This is Discovery Step 1.

> Purpose: Make sure the user has the workstation, package-source setup, and manual verification guidance needed for the rest of Discovery before numbered work continues.

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 1 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 1 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: This step verifies the local setup and manual verification prerequisites that the later Discovery work relies on.
- Dev work: Confirm the session has `SONATYPE_USERNAME` and `SONATYPE_PASSWORD`, check the local tools and package-source setup, report anything missing, and update `/.modernization/.readme/HowToRun.md` with copy/paste legacy run instructions that match the copied app already present under `LegacyCode/`. Step 1 closes from its own saved state, evidence, and manual verification guidance.

Objective
- Confirm the workstation can support the remaining Discovery steps.
- Use `/.modernization/.readme/Prerequisites.md` as the setup contract for required workstation prerequisites and setup links.
- Check for `dotnet`, `node`, `npm`, `git`, PowerShell, and the client/browser setup the workspace needs.
- Check whether the client `.npmrc` and repo NuGet configuration are present and pointing at the expected sources.
- Check whether `npm ping` succeeds, whether the HTTPS development certificate is ready, and whether the expected local runtime ports appear free or already in use.
- Prefer the VS Code browser window as the default place to verify the running app and debug page behavior; treat Edge or Chrome as secondary browsers for manual confirmation.
- Keep the Sonatype access setup visible for the user before the manual starter and legacy verification work begins.
- If `LegacyCode/` already contains a copied legacy app, inspect it and refresh `/.modernization/.readme/HowToRun.md` so the legacy copy/paste commands match the detected solution and startup project.
- If `LegacyCode/` is still empty, tell the developer to copy the legacy application first and rerun Step 1 after the folder is populated.
- Return the exact localhost URLs and manual commands the developer must use for the `src/` API and client.
- Tell the developer to use the VS Code browser window first when verifying the app and to open Edge or Chrome only as an additional browser check.
- Tell the developer to copy the legacy application into `LegacyCode/` and confirm it still builds and runs in its native form before they continue.
- Recommend `step:1fc2ba` only after the developer completes the manual starter and legacy verification work.

Execution mode
- This prompt is operational, not advisory.
- Execute Step 1 immediately once it is selected.
- Do not start the modern API, modern client, or legacy application from this step.
- Do not claim that runtime proof exists yet. State clearly that this step prepares the workstation and the manual verification flow the developer must complete before Discovery continues.
- Do not treat the legacy run instructions in HowToRun as static if `LegacyCode/` already contains a copied app; refresh them from the detected solution and startup project before you hand the step back.

Legacy run refresh template for Copilot to apply when `LegacyCode/` contains a classic ASP.NET MVC or Fusion G1 app:
- detect the solution root, startup web project, and IIS Express site name from the copied app
- remove stale `.vs` and `obj` metadata for the copied solution
- remove stale `.vs`, `bin`, and `obj` metadata for the copied solution when the old build outputs are poisoning the legacy import graph
- restore `packages.config` dependencies from the copied solution root
- build the startup web project with `DeployOnBuild=false` and `GeneratePackageOnBuild=false`
- use the installed Visual Studio MSBuild path in `HowToRun.md` so the commands are copy/pasteable even when `msbuild` is not on PATH
- if the app uses `Microsoft.Owin.Host.SystemWeb` or otherwise says it requires IIS integrated pipeline mode, keep IIS Express integrated and use `Clr4IntegratedAppPool`
- if the app uses a host page such as `Default.cshtml`, keep the default document and root URL guidance in `HowToRun.md` aligned with that host page
- write the exact app-specific commands and URL into `/.modernization/.readme/HowToRun.md` using the detected paths and ports, not placeholder template values

Required response
1. State plainly that Step 1 is the setup-and-manual-verification gate.
2. Return a clear pass or blocked list for the workstation checks, including which tools, feeds, credentials, certificates, or ports do not appear ready.
   - For each missing prerequisite, include this exact sentence pattern: `You are missing <prerequisite> per prerequisite requirements.`
   - Keep one sentence per missing prerequisite.
3. Confirm the `step-workflow-state.json` readback using this exact human-readable workflow snapshot shape and no file-path citation line:

   Workflow state updated:
   Updated At: <timestamp>
   Recorded Step: <recorded step result>
   Recommended Next Step: <recommended next step>

4. Return these exact manual `src/` commands and URLs near the bottom of the response:

   Web API

   ```powershell
   Set-Location -LiteralPath '.\src\<AppName>.Web.Api'
   dotnet run --project '<AppName>.Web.Api.csproj'
   ```

   API URL: `https://localhost:4200/scalar`

   Front End UI

   ```powershell
   Set-Location -LiteralPath '.\src\<AppName>.Web.Client'
   npm run start
   ```

   Client URL: `https://localhost:5001/`

5. Tell the developer to copy the legacy application into `LegacyCode/` before running this prompt if it is not already present, then verify that it still builds and runs before continuing.
6. End by stating the exact next numbered step after those manual checks are complete by resolving `step:1fc2ba` from `/.github/instructions/step-registry.json` to its current human label.
