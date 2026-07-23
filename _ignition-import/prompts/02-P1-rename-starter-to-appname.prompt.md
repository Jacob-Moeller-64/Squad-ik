---
description: "Step 2. Relabel starter-named src folders, project files, and internal src references to the real app identity while excluding LegacyCode."
name: "02-P1-rename-starter-to-appname"
argument-hint: "Rename the starter-derived target to <AppName>"
agent: "OpX-AppMod-P1-Discovery"
tools:
  - edit/editFiles
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
---

# Rename Starter Src Surfaces to Target App Identity

**Recommended model tier:** Light (low thinking). **Estimated run time:** 5-10 min (varies with app size and model).

> Purpose: Use this prompt to relabel Starter Kit identities in the active modernization workspace so the reusable target app matches the `appName` value in `/.modernization/.readme/kit-params.md`, while leaving `LegacyCode/` untouched.

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 2 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 2 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact later steps consume exists and is non-empty.

About To Do
- Context: Step 2 is a src-identity relabel pass only.
- Dev work: Rename starter-named `/src` folders and project files, then rewrite matching internal `/src` references to the app identity. Step 2 closes from rename-proof evidence captured by the step itself.

Before editing generic toolkit assets as part of this flow, read `/.github/instructions/kit-update.instructions.md`.

Execution mode addendum
- No standalone QA prompt is associated with Step 2. Treat the rename-proof artifact and saved step state as the completion gate.

Rename-state model
- Treat Step 2 as complete only when these two surfaces agree:
  - `physicalRenameStatus`: starter-named `/src` roots and project files are renamed to the app identity.
  - `referenceRewriteStatus`: `/src` code and project references point at the renamed identity except approved instructional leftovers.
- If one surface passes and the other does not, return `Blocked`.

## Hard Scope Rules

1. Read `/.modernization/.readme/kit-params.md` and extract `appName`.
2. Do not modify anything under `LegacyCode/`.
3. Keep this step focused on `/src` relabeling only. Do not expand into deployment, portal publication, or unrelated modernization work.

## Rename Targets

- Replace starter placeholders in `/src` with the approved app identity from `appName`.
- Keep backend naming PascalCase and the client project root in `<BackendAppNamePascal>.Web.Client` form.
- Physically rename these items when present:
  - `src/Starter.Library` -> `src/<BackendAppNamePascal>.Library`
  - `src/Starter.Web.Api` -> `src/<BackendAppNamePascal>.Web.Api`
  - `src/Starter.Web.Client` -> `src/<BackendAppNamePascal>.Web.Client`
  - `src/starter-web-client` -> `src/<BackendAppNamePascal>.Web.Client`
  - `Starter.Library.csproj` -> `<BackendAppNamePascal>.Library.csproj`
  - `Starter.Web.Api.csproj` -> `<BackendAppNamePascal>.Web.Api.csproj`
  - `Starter.Web.Client.esproj` -> `<BackendAppNamePascal>.Web.Client.esproj`
  - `starter-web-client.esproj` -> `<BackendAppNamePascal>.Web.Client.esproj`

## Files That Must Be Reviewed

- `src/<BackendAppNamePascal>.Library/**`
- `src/<BackendAppNamePascal>.Web.Api/**`
- `src/<BackendAppNamePascal>.Web.Client/**`

## Required Edits

1. Rename `/src` folders and project files before editing references inside them.
2. Update `/src` namespaces, `using` statements, project references, metadata strings, and path references that still point to starter names.
3. Keep edits behavior-preserving and identity-focused; do not change functional logic unless required for the rename to compile.
4. Confirm client Angular baseline remains the approved even-major baseline (currently Angular 20).
5. Search outside `LegacyCode/**` for `Starter|starter|starterkit` and review remaining hits; keep only intentional instructional leftovers.
6. After rename edits, rebuild and run the modern src app before closing Step 2:
   - Build API: `dotnet build src/<BackendAppNamePascal>.Web.Api/<BackendAppNamePascal>.Web.Api.csproj`
   - Prepare client dependencies: `npm run install` from `src/<BackendAppNamePascal>.Web.Client`
   - Start API and client (manual or task-based) and confirm `https://localhost:4200/scalar` and `https://localhost:5001/` are reachable.
7. If rebuild or runtime startup fails after rename, keep Step 2 `Blocked` and troubleshoot in Step 2 until the rename fallout is resolved. Do not defer rename-break regressions to `step:261769`.

## Known Identity-Bearing Files — Must Review Every Run

These files have historically retained Starter identity values after a physical folder rename and **must be explicitly checked and updated** in every Step 2 execution. Do not treat physical folder/project rename as sufficient — inner content in these files also carries the app identity.

| File | Starter values to replace |
|---|---|
| `src/<AppName>.Web.Api/AppInfo.xml` | `<name>`, `<description>`, `<fusionDataPath>` — e.g. `Starter.Web.Api` |
| `src/<AppName>.Web.Api/appsettings.json` | `Fusion.DataDirectory.PathBase`, `Fusion.Web.Api.OpenApi.Title`, `Fusion.Web.Client.Config.ApplicationName`, and logging namespace keys `Starter.Library` / `Starter.Web.Api` |
| `src/<AppName>.Web.Client/AppInfo.xml` | `<name>`, `<description>` — e.g. `Starter.Web.Client` |
| `src/<AppName>.Web.Client/src/app/app.component.html` | `fusion-header label="Fusion Starter"` — update label to the app name |
| `src/<AppName>.Web.Client/src/app/fusion.config.*.ts` | Review only: do **not** replace default Fusion OAuth hostnames in Step 2. Keep starter defaults until the later auth/config step updates them intentionally. |
| `src/<AppName>.Web.Client/src/index.html` | `<title>` tag — replace `Starter.Web.Client` with `<AppName>.Web.Client` |

> Note on `fusion.config.dvl.ts` auth URLs: preserve the default Fusion OAuth values during Step 2 rename. These environment-specific redirects are updated in later auth/configuration steps, not during identity relabeling.

## Important Behavior

- Do not silently skip folder or file renames in `/src`.
- Report Step 2 with explicit `physicalRenameStatus` and `referenceRewriteStatus` results.
- If blocked, report the exact file/path references still preventing completion.
- Call out intentional remaining `Starter` references in the final summary.

## Closeout Summary

- After the step response is saved, refresh `.modernization/.readme/.StepSummary.md` with a short human-readable entry for Step 2.
- Keep the summary skimmable: when the step ran, what was renamed, whether references were rewritten, and the main result.
