---
description: "Angular coding standards"
applyTo: "**/*.ts,**/*.html,**/*.scss,**/*.css"
---

## General

- Use #tool:angular-cli/* tool for project analysis and documentation.
- When troubleshooting breakages after upgrades, consult `patch-notes/**` first (or the MCP tools if available).
- Prefer signals.
- Prefer standalone components.
- Keep templates lean; avoid complex logic.
- Keep services small/testable; register lifetimes appropriately.
- When capturing errors, use `FusionErrorService` (Angular Service) from the `@fusion/ngx-fusion` package, which already logs and executes policies.
- Use the `FusionLoggerService` (Angular Service) from the `@fusion/ngx-fusion` package.

## Kendo UI License Handling

`@fusion/ngx-fusion` wraps Kendo UI for Angular components as peer dependencies. Kendo Angular 19+ displays a license banner at startup if not activated.

### Root Cause (Fusion + esbuild builds)
`@fusion/ngx-fusion` bundles Kendo Angular packages that have a `publishDate` timestamp in their bundle metadata. The embedded Kendo license in `@progress/kendo-licensing/dist/index-esm.js` has a `licenseExpirationDate` that may predate the `publishDate` of the bundled Kendo packages. When `publishDate > licenseExpirationDate`, the license check fails and the watermark renders — even in development.

**Note:** The `KENDO_UI_LICENSE=ignored` environment variable approach only works with the legacy webpack-based Angular builder. Angular 17+ uses esbuild (`@angular/build`), which does NOT substitute `process.env` variables into the browser bundle from the Node.js environment. Setting this env var has no effect on the watermark for esbuild builds.

### Quick Suppression (Development — esbuild/Angular 17+)
Patch the embedded license expiration date in `@progress/kendo-licensing/dist/index-esm.js` to extend past the Kendo package publish dates. Run this once after `npm install` (or after any `node_modules` reinstall):
```powershell
$esmFile = "node_modules/@fusion/ngx-fusion/node_modules/@progress/kendo-licensing/dist/index-esm.js"
$raw = [System.IO.File]::ReadAllText($esmFile)
# Replace expired date (e.g. 1747335600 = May 2025) with year-2033 date
$patched = $raw -replace '\b174733\d{4}\b', '1999999999'
[System.IO.File]::WriteAllText($esmFile, $patched)
Write-Host "Kendo license date patched — restart ng serve"
```
Then restart `npm run serve`. The patched value is baked into the esbuild output bundle.

**Important:** This patch is lost on every `npm install`. To survive reinstalls, add this as a `postinstall` npm script or commit a `patches/` entry via `patch-package`.

### Full Activation (Production/Licensing Required)
If the app uses raw Kendo Angular components directly, activate with the corporate license:
1. Get the Kendo UI license key from the Fusion team or your Telerik account
2. Save to `kendo-ui-license.txt` (single line, add to `.gitignore`)
3. Install and activate:
```powershell
npm install --save-dev @progress/kendo-licensing
npx kendo-ui-license activate
```
This writes `src/kendo-ui-license.js` which Kendo auto-loads.

### CI/CD
Set the Telerik/Kendo license key as a pipeline secret and run `npx kendo-ui-license activate` during the CI build step.

## Security

- Leverage Angular's built-in sanitization.
- Implement Content Security Policy (CSP) and Trusted Types.

## Testing
- Use #tool:angular-cli/* tool for best practices in testing Angular applications.
  - As a backup refer to Angular's site for testing information
  - Overview: [Angular Testing Guide](https://angular.dev/guide/testing).
  - Components: [Angular Component Testing](https://angular.dev/guide/testing/components-basics)
  - Directives: [Angular Directive Testing](https://angular.dev/guide/testing/directives)
  - Services: [Angular Service Testing](https://angular.dev/guide/testing/services)
  - Pipes: [Angular Pipe Testing](https://angular.dev/guide/testing/pipes)
  - Routing / Navigation: [Angular Routing Testing](https://angular.dev/guide/routing/testing)
