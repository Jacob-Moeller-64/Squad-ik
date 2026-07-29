---
name: "appmod-frontend-angular"
description: "Migrate a legacy Angular frontend into src/Client as a parity move first, with the Kendo/esbuild license trap."
domain: "frontend"
confidence: "high"
source: "earned (Ignition Kit Step 10 + Angular standards)"
---

## Context

The frontend agent owns this. The initial move into `src/<App>.Web.Client` is a PARITY move, not a
redesign — the app must look and work like legacy before any Fusion swap.

## Patterns

- Prefer signals + standalone components; keep templates lean; centralize API calls in services.
- Preserve the legacy stylesheet stack, partial import order, assets, fonts/icons, host/body classes, layout wrappers, and DOM/class contract during the move.
- Make the shell inherit the legacy visual language by construction: design tokens from the legacy palette/typography, Fusion theme bound to them, branded header, nav populated from the route inventory, footer.
- Per-route behavior preservation: port real click handlers, modal/banner triggers, export/print/download/upload controls, keyboard shortcuts, and data bindings.
- Use `FusionErrorService` / `FusionLoggerService` (`@fusion/ngx-fusion`); use `data-testid` so the app is Playwright-ready.

## Examples

- Kendo license watermark fix (esbuild / Angular 17+), run once after `npm install`:
  ```powershell
  $esmFile = "node_modules/@fusion/ngx-fusion/node_modules/@progress/kendo-licensing/dist/index-esm.js"
  (Get-Content $esmFile -Raw) -replace '\b174733\d{4}\b','1999999999' | Set-Content $esmFile
  ```

## Anti-Patterns

- **Kendo trap:** `KENDO_UI_LICENSE=ignored` has NO effect under esbuild (Angular 17+ uses `@angular/build`, which doesn't substitute `process.env` into the browser bundle). Patch the embedded expiry instead; the patch is lost on every `npm install` (add a `postinstall`/`patch-package` entry).
- Letting starter sample styling become the default visual result of the move.
- Surviving `javascript:void(0)`, `href="#"`, dead modal triggers, inert stubbed handlers, placeholder/seed data, or column collapse on a migrated route.
- Assuming `HttpClient` receives bearer tokens just because `provideNgxFusionAuthOAuthOkta()` exists — prove the request path; the default final-state path is `FusionHttpService`.
