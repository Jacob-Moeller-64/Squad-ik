# Ignition Kit import (photo transcriptions)

Prompts from the OpX-Ignition-Kit, transcribed from screen photographs supplied by the
kit owner (work-machine transfer restrictions prevent direct file transfer).

> **⚠ IMPORTANT SCOPE NOTE (added late in the import).** The repository being
> photographed is **not a pristine Ignition Kit** — it is the owner's
> **already-merged Squad + Ignition workspace**. `.github/copilot-instructions.md`
> opens by calling it *"this Squad-based App Modernization repo"* and describes
> `.squad/`, `tools/appmod/`, and `AGENTS.md` as first-class parts of it. Files in
> this import labelled "Ignition-native" were labelled from internal evidence and
> most are; but the labels are inferences, not provenance records. Check whether a
> file references `.squad/` or `tools/appmod/` before assuming it is original
> Ignition. See the framing section below. Content is
reconstructed faithfully; per-file transcription uncertainties are listed below.
No credentials appear in these files (env-var *names* like SONATYPE_USERNAME are
references, not values).

## Index

| File | Phase/Step | Status |
|---|---|---|
| `prompts/01-P1-workstation-readiness.prompt.md` | P1 Discovery, Step 1 | transcribed from 2 photos |
| `prompts/02-P1-rename-starter-to-appname.prompt.md` | P1 Discovery, Step 2 | transcribed from 3 photos |
| `prompts/03-P1-legacy-system-analysis.prompt.md` | P1 Discovery, Step 3 | transcribed from 6 photos |
| `prompts/04-P1-baseline-acceptance-criteria-review.prompt.md` | P1 Discovery, Step 4 | transcribed from 4 photos |
| `prompts/05-P1-modernization-solution-design.prompt.md` | P1 Discovery, Step 5 | transcribed from 7 photos; 2 values redacted (see below) |
| `prompts/06-P1-modernization-quality-design.prompt.md` | P1 Discovery, Step 6 | transcribed from 13 photos |
| `prompts/07-P2-backend-upgrade-dotnet.prompt.md` | P2 Modernize, Step 7 DEV | transcribed from 7 photos |
| `prompts/08-P2-backend-modernization-formation.prompt.md` | P2 Modernize, Step 8 DEV | transcribed from 11 photos |
| `prompts/09-P2-backend-dotnet-integration-hardening.prompt.md` | P2 Modernize, Step 9 DEV | transcribed from 4 photos |
| `prompts/10-P2-frontend-foundation-and-scaffold.prompt.md` | P2 Modernize, Step 10 DEV | transcribed from 8 photos |
| `prompts/11-P2-frontend-migration.prompt.md` | P2 Modernize, Step 11 DEV | transcribed from 4 photos |
| `prompts/12-P2-frontend-platform-integration.prompt.md` | P2 Modernize, Step 12 DEV | transcribed from 9 photos |
| `prompts/13-P2-frontend-shell-stabilization.prompt.md` | P2 Modernize, Step 13 DEV | transcribed from 5 photos |
| `prompts/14-P2-frontend-ui-inventory-and-fusion-map.prompt.md` | P2 Modernize, Step 14 DEV | transcribed from 4 photos |
| `prompts/15-P2-fusion-ui-integration.prompt.md` | P2 Modernize, Step 15 DEV | transcribed from 4 photos |
| `prompts/16-P2-next-fusion-ui-upgrade-slice.prompt.md` | P2 Modernize, Step 16 DEV | transcribed from 3 photos |
| `prompts/17-P2-rewire-all-tests-and-verify.prompt.md` | P2 Modernize, Step 17 DEV | transcribed from 9 photos |
| `prompts/18-P2-deployment-and-clean-up.prompt.md` | P2 Modernize, Step 18 DEV | transcribed from 3 photos |
| `prompts/19-P3-final-fusion-restructure-review.prompt.md` | **P3 Review**, Step 19 | transcribed from 1 photo |
| `prompts/20-P3-final-verification.prompt.md` | P3 Review, Step 20 | transcribed from 2 photos |
| `prompts/21-P3-figma-review.prompt.md` | P3 Review, Step 21 | transcribed from 2 photos |
| `prompts/22-P3-final-acceptance-criteria-review.prompt.md` | P3 Review, Step 22 | transcribed from 2 photos |
| `prompts/23-P3-final-readiness-review.prompt.md` | P3 Review, Step 23 | transcribed from 2 photos |
| `prompts/24-P3-technical-review.prompt.md` | P3 Review, Step 24 | transcribed from 27 photos (5 were a re-shot of an already-captured range); complete — 16 heading line numbers spot-verified against the source |

### Instructions

| File | Role | Status |
|---|---|---|
| `instructions/tests-commenting.instructions.md` | **Ignition-native** — tutorial-level commenting rules for everything under `tests/` | transcribed from 2 photos — complete (source lines 1-90, blank to 91); 12 anchors verified |
| `instructions/ui-capture-reverse-engineering.instructions.md` | **Ignition-native** — ★ the canonical legacy-UI capture rulebook; **435 lines, the largest instruction file in the kit** | **PENDING** — photos received; lines 1-159 and 396-435 read, middle range not yet transcribed |
| `instructions/testing-design-contract.instructions.md` | **Ignition-native** — testing design contract | **PENDING** — 10 photos received, not yet read |
| `instructions/modernization-starter-boundaries.instructions.md` | **Ignition-native** — the canonical LegacyCode→src guardrail file; protected control points, editable seams, ownership model | transcribed from 4 photos — complete (source lines 1-194, blank to 203); 16 anchors verified |
| `instructions/kit-update.instructions.md` | **Ignition-native** — guardrails for editing the kit *itself* (toolkit-maintenance, not app modernization) | transcribed from 4 photos — complete (source lines 1-178, blank to 180); 18 anchors verified |
| `instructions/step-registry.json` | **Ignition-native** — ★ the stable step-identity registry; the kit's designed fix for numbering drift | transcribed from 4 photos — complete (source lines 1-205); **validates as JSON**, all 24 steps present |
| `instructions/step-confidence-contract.instructions.md` | **Ignition-native** — minimum confidence shape every numbered prompt must honor | transcribed from 2 photos — complete (source lines 1-63, blank to 64); 9 anchors verified |
| `instructions/qa-portal-reporting.instructions.md` | **Ignition-native** — the canonical portal-is-manual-only rule (referenced by 3 other files) | transcribed from 1 photo — complete (source lines 1-35 + 1 trailing blank, blank to 37) |
| `instructions/fusion-restructure.instructions.md` | **Ignition-native** — LegacyCode→src restructure handoffs, bridges, starter-shell preservation | transcribed from 2 photos — complete (source lines 1-75, blank to 76); 9 anchors verified |
| `instructions/fusion-mcp-restructure.instructions.md` | **Ignition-native** — Fusion MCP-first lookup order before inventing any Fusion-aligned solution | transcribed from 2 photos — complete (source lines 1-58, blank to 60); 8 anchors verified |
| `instructions/modernization-deep-scan-checklist.instructions.md` | **Ignition-native** — deep-scan checklist for discovery, planning, verification, cleanup | transcribed from 1 photo — complete (source lines 1-44, blank to 45) |
| `instructions/powershell-script-maintenance.instructions.md` | **Ignition-native** — advisory PSScriptAnalyzer stance for toolkit scripts | transcribed from 1 photo — complete (source lines 1-37, blank to 38) |
| `instructions/discovery-runner.instructions.md` | **Squad-side bridge, NOT Ignition-native** — the Squad-as-runner pilot that executes Ignition Discovery Steps 1-6 | transcribed from 4 photos — content complete (source is 175 lines); **hard-wrap points not reproduced**, so local line numbers differ (see uncertainties) |
| `instructions/frontend-modernization-learning.instructions.md` | **Ignition-native** — durable post-mortem rules from frontend modernization failures | transcribed from 5 photos — complete (source lines 1-170, blank to 171); 10 line numbers spot-verified |
| `instructions/dotnet.instructions.md` | **Ignition-native** — .NET coding standards, auto-applied to `**/*.cs` | transcribed from 2 photos — complete (source lines 1-75, blank to 76); 9 line numbers spot-verified |
| `instructions/copilot.instructions.md` | **Ignition-native** — task-discoverable operational supplement (`name: appmod-ignition-operations`); repo maintenance, rerun behavior, engineering standards, naming law | transcribed from 7 photos — complete (source lines 1-355, blank to 356); 51 line numbers spot-verified. **Earlier version was truncated at 272**; lines 273-355 added later |
| `instructions/AppMod-Process.instructions.md` | **Ignition-native** — the human-readable 3-phase / 24-step authority; the narrative counterpart to the artifact contract | transcribed from 6 photos — complete (source lines 1-265, blank to 266); 29 line numbers spot-verified |
| `instructions/appmod-phase-agent-contract.instructions.md` | **Ignition-native** — shared critical rules + chat contract for the three numbered phase coordinators | transcribed from 4 photos — complete (source lines 1-174 plus 3 trailing blanks, blank to 178); 16 line numbers spot-verified |
| `instructions/AppMod-Artifact-Contract.json` | **Ignition-native** — the per-step artifact input/output contract that drives the shared verifier | **PARTIAL** — see `_wip/AppMod-Artifact-Contract-partial.md`; vertically complete (lines 1-345, all 24 steps) but long lines are still cut off at the right screen edge (word wrap was off) |
| `instructions/angular.instructions.md` | **Ignition-native** — Angular coding standards, auto-applied by glob | transcribed from 2 photos — complete (source lines 1-67, blank to 68); 9 line numbers spot-verified |
| `instructions/appmod-agent-personality-baseline.instructions.md` | **Ignition-native** — shared coordinator execution baseline for the four AppMod coordinator agents | transcribed from 2 photos — complete (source lines 1-71, blank to 72); 12 line numbers spot-verified |
| `instructions/agent-toolkit-protection.instructions.md` | **Ignition-native** — the single source of truth for toolkit-edit boundaries; contains the Definitive Agent List | transcribed from 2 photos — complete (source lines 1-84, blank to 86); 23 line numbers spot-verified |
| `instructions/agent-process-conformance.instructions.md` | **Ignition-native** — minimum conformance shape for agents and router prompts | transcribed from 2 photos — complete (source lines 1-120, blank to 122); 13 line numbers spot-verified |

`_wip/agent-integrity-checks-partial-notes.md` holds structure + findings for
`agent-integrity-checks.instructions.md` (file complete at 383 lines; verbatim body not yet written).

### Governance

| File | Role | Status |
|---|---|---|
| `AGENTS.md` | **Squad-side** — ★ the thin always-on conventions file every Squad agent loads; repo root | transcribed from 2 photos — complete (source lines 1-114); 18 anchors verified |
| `copilot-instructions.md` | **★★★ MERGED Squad+Ignition** — the auto-attached repo-wide entrypoint; actual path is `.github/copilot-instructions.md` | transcribed from 3 photos — complete (source lines 1-94); 10 anchors verified |
| `Copilot-Customization-Cheat-Sheet.md` | **Ignition-native** — maintainer reference for which customization primitive to use; actual path is `.github/Copilot-Customization-Cheat-Sheet.md` | transcribed from 3 photos — complete (source lines 1-150); 15 anchors verified |
| `constitution.md` | **Ignition-native** — ★ the durable governance source; actual path is **`.github/constitution.md`**, not the repo root | transcribed from 3 photos — complete (source lines 1-146); 14 section anchors verified |

### Starter application source (`src/`)

The kit ships a starter app under `src/Starter.*` that Step 2 renames to
`<AppName>.*`. These are the **target-state reference implementations** teams
pattern-match against.

| File | Role | Status |
|---|---|---|
| `starter/Starter.Library/Entities/MyEntity.cs` | reference domain entity | transcribed from 1 photo — complete (source lines 1-28) |
| `starter/Starter.Web.Client/.vscode/{extensions,launch,tasks}.json` | stock Angular CLI scaffolding — no customisation, no findings | transcribed from 3 photos — complete (4 / 20 / 42 lines) |
| `starter/Starter.Web.Client/scripts/build.mjs` | Node build wrapper around `ng build` — pre-build hook + `obj/Debug` shim | transcribed from 1 photo — complete (13 content lines) |
| `starter/Starter.Web.Client/scripts/tools.mjs` | ★★ **the shared shell-out / npm layer for every client script** — `execute`, `npmAuth`, `npmInstall`, `npmUpdate`, `installSafePackages`, `spawn` | transcribed from 4 photos — complete (180 content lines); **1 internal hostname redacted** |
| `starter/Starter.Web.Client/scripts/pre-build.mjs` | the unconditional pre-build hook: auth → install → clean → lint | transcribed from 1 photo — complete (19 lines) |
| `starter/Starter.Web.Client/scripts/pre-start.mjs` | `preBuild(true)` + `dotnet dev-certs` trust/export | transcribed from 1 photo — complete (10 content lines) |
| `starter/Starter.Web.Client/scripts/update.mjs` | `npmAuth()` + `npmUpdate()` — the documented drift-recovery entry point | transcribed from 1 photo — complete (4 content lines) |
| `starter/Starter.Web.Client/src/app/pages/common-components/common-components.component.ts` | ★★ **confirms `@fusion/ngx-fusion`** — the Fusion UI answer-key page | transcribed from 1 photo — complete (16 content lines) |
| `starter/Starter.Web.Client/src/app/pages/common-components/common-components.component.html` | ⚠ the entire Fusion component catalogue: a grid with the word `Cell` in it | transcribed from 1 photo — complete (10 content lines) |
| `starter/.../pages/home/home.component.ts` | ★★ **the frontend answer key** — OnPush + `inject()` + `signal()`, calls the public endpoint | transcribed from 1 photo — complete (28 content lines) |
| `starter/.../pages/home/home.component.html` | Fusion grid + `fusion-button` + `@if`; `appearance`/`color` button vocabulary | transcribed from 2 photos — complete (74 content lines) |
| `starter/.../pages/home/home.component.scss` | one rule, `.sample-api-result` | transcribed from 1 photo — complete (4 content lines) |
| `starter/.../pages/my-entity/my-entity.component.ts` | reactive forms + signals CRUD page | transcribed from 2 photos — complete (69 content lines) |
| `starter/.../pages/my-entity/my-entity.component.html` | ⚠ block-grid, `fusion-textbox`, `@for`; `theme` button vocabulary | transcribed from 1 photo — complete (43 content lines) |
| `starter/.../pages/test-datastore/test-datastore.component.html` | ⚠ **contradicts the other pages**: plain fields, `[(ngModel)]`, hand-rolled layout; adds `fusion-textarea` + `[disabled]` | transcribed from 1 photo — complete (54 lines, **no trailing newline**) |
| `starter/.../pages/test-datastore/test-datastore.component.scss` | `:host` + `.panel-actions`; defines 1 of the 8 classes the template uses | transcribed from 1 photo — complete (14 content lines) |
| `starter/.../pages/test-datastore/test-datastore.component.ts` | private signals behind public getters (for `[(ngModel)]`); the only `try`/`finally` in the client | transcribed from 2 photos — complete (74 lines, **no trailing newline**) |
| `starter/.../services/my-entities/my-entities.service.ts` | ★★ **confirms `FusionHttpService`** — the only worked example of client→API calls; ⚠ cached GETs, inverted arg order | transcribed from 1 photo — complete (26 content lines) |
| `starter/.../services/my-entities/my-entities.services.spec.ts` | ⚠ **empty file** — zero-byte, no frontend testing exemplar | recorded as blank per the source |
| `starter/.../services/public-text/public-text.service.ts` | ★★ closes the **PublicText vertical slice** — controller → domain service → DTO → client service → page | transcribed from 1 photo — complete (15 content lines) |
| `starter/.../src/app/app.config.ts` | ★★ **the bootstrap** — `provideNgxFusion()`, `provideNgxFusionAuthOAuthOkta()`, `provideHttpClient` + date interceptor, `FusionUrlSerializer` | transcribed from 1 photo — complete (50 content lines) |
| `starter/.../src/app/fusion.config.base.ts` | ⚠ **2 live Okta values REDACTED**; `devMode`/`isDebug` true in base; Okta Management API scopes | transcribed from 1 photo — complete (38 content lines) |
| `starter/.../src/app/app.component.{html,ts}` | the Fusion app shell — `fusion-app` / `fusion-header` / `fusion-footer` | transcribed from 2 photos — complete (7 / 11 content lines) |
| `starter/.../src/app/app.component.spec.ts` | ⚠ `describe('Dummy')` with an assertion-free `it` — the frontend test suite is a placebo | transcribed from 1 photo — complete (11 content lines) |
| `starter/.../src/app/fusion.config.prd.ts` | ⚠⚠ **CONFIRMS production inherits `devMode: true`** and localhost redirect URIs | transcribed from 1 photo — complete (10 content lines) |
| `starter/.../src/app/fusion.config.{dvl,qa,uat}.ts`, `fusion.config.ts` | env overrides; **dvl redacted** (2 live + 4 commented identifiers) | transcribed from 4 photos — complete (52 / 9 / 9 / 9 lines) |
| `starter/.../src/app/routes.config.ts` | ★★ **confirms Kendo is a real dependency**; Fusion `menu` metadata per route | transcribed from 1 photo — complete (50 content lines) |
| `starter/.../src/app/types.ts` | `MyEntity` + `PublicTextResponse` — resolves the `setValue` caution | transcribed from 1 photo — complete (9 content lines) |
| `starter/.../src/styles.scss` | ⚠ **resolves the undefined-class question** — defines no app classes at all | transcribed from 1 photo — complete (8 content lines) |
| `starter/.../src/index.html` | ⚠ theme-bootstrap bug, CSP-hash-pinned; Kendo `k-body` classes | transcribed from 1 photo — complete (35 content lines) |
| `starter/.../src/main.ts` | standalone bootstrap | transcribed from 1 photo — complete (6 content lines) |
| `starter/.../src/web.config` | the strongest security artefact in the starter; **3 corp domains redacted** | transcribed from 3 photos — complete (156 lines, validates as XML) |
| `starter/Starter.Web.Client/tmpt/.npmrc` | ⚠⚠ **`strict-ssl=false`**; confirms `ignore-scripts=true` + the `@fusion:` scoped registry; **host redacted** | transcribed from 1 photo — complete (7 content lines) |
| `starter/Starter.Web.Client/.npmrc` | the **root** copy `npmAuth()` actually reads — no token markers; **host redacted** | transcribed from 1 photo — complete (5 content lines) |
| `starter/Starter.Web.Client/.dockerignore` | excludes `cert.pem`/`cert.key` from the image; reveals a `Dockerfile` exists | transcribed from 1 photo — complete (16 content lines) |
| `starter/Starter.Web.Client/angular.json` | ★★ resolves the `local` config + fileReplacement scheme; ⚠ warning-only budgets, CLI cache off, lint covers `src/**` only | transcribed from 5 photos — complete (234 lines, validates as JSON) |
| `starter/Starter.Web.Client/nginx.conf` | ⚠⚠ **ANSWERS the deployment question** — the live OpenShift config, with **zero** security headers | transcribed from 1 photo — complete (23 content lines) |
| `starter/Starter.Web.Client/default.conf` | vestigial stock-nginx config; cannot work as written | transcribed from 1 photo — complete (23 content lines) |
| `starter/Starter.Web.Client/package.json` | ⚠⚠ **`"latest"` on five toolchain packages**; serve is port **5001**; no `engines` field | transcribed from 1 photo — complete (58 lines, validates as JSON) |
| `starter/Starter.Web.Client/eslint.config.js` | explains the `void` prefix; a11y rules on; no Prettier integration | transcribed from 2 photos — complete (73 lines, parses under `node --check`) |
| `starter/Starter.Web.Client/tsconfig.json` | ★ the strongest config in the client — full `strict` + `strictTemplates` | transcribed from 1 photo — complete (34 content lines) |
| `starter/Starter.Web.Client/tsconfig.{app,spec}.json` | per-target tsconfigs | transcribed from 2 photos — complete (15 / 14 content lines) |
| `starter/Starter.Web.Client/AppInfo.xml` | ★ **already uses the `{Placeholder}` convention** — no redaction needed | transcribed from 2 photos — complete (77 lines, validates as XML) |
| `starter/Starter.Web.Client/Starter.Web.Client.esproj` | `ShouldRunNpmInstall=false`; maps MSBuild onto the npm scripts | transcribed from 1 photo — complete (11 content lines) |
| `scripts/parity/scan-api-dto-coverage.ps1` | ★★ **the first real gate** — legacy-anchored DTO field coverage; confirms `kit-params.md` `appName` resolution; ⚠ passes vacuously when nothing is scanned | transcribed from 4 photos — complete (222 content lines) |
| `scripts/parity/scan-backend-parity.ps1` | ★★ endpoint-level sibling; quantified postmortem (35 mutations → 0, shipped green); ⚠ same vacuous pass, ⚠ `controller\|verb` key under-counts | transcribed from 5 photos — complete (241 content lines) |
| `scripts/parity/scan-functional-parity-ledger.ps1` | ★★ the **composition** gate — cross-references the other scans; ★ has the missing-input guard the siblings lack; ⚠ evidence inputs still degrade to "clean" | transcribed from 7 photos — **complete** (376 content lines) |
| `scripts/parity/scan-scaffold-debt.ps1` | ★★ detects surviving "wired in a later step" deferral markers; **drain semantics** via `-CurrentStep` | transcribed from 4 photos — complete (221 content lines) |
| `scripts/parity/scan-ui-parity-gaps.PARTIAL.ps1` | ★★ produces `ui-parity-gap-scan.json` (the ledger's `filter` input); ★ **honesty rules**; ★ **discovery probe** — self-reporting rule-coverage gaps | **PARTIAL** — lines 1-454 of ~950+; **gap at 455-831**; do not execute |
| `scripts/parity/selftest-backend-parity.ps1` | ★★★ **the gates are tested** — runs the real gate against synthetic fixtures, 8 assertions over 6 cases | transcribed from 3 photos — complete (170 content lines) |
| `scripts/parity/selftest-functional-parity-ledger.PARTIAL.ps1` | ★★★ second self-test — confirms self-testing is the **convention**, not a one-off | **PARTIAL** — lines 1-121 + tail 284-341 (separate fragment); **gap 122-283**; file is 340 lines |
| `scripts/parity/selftest-parity-gate.PARTIAL.ps1` | ★★★★ **anti-re-blinding guards** — asserts against the scanner's own SOURCE, not just its behaviour | **PARTIAL** — lines 1-66; 1 of 5 photos read; do not execute |
| `scripts/parity/selftest-scaffold-debt.PARTIAL.ps1` | ★★★ **fourth** self-test — four of six scanners now confirmed to have paired regression tests | **PARTIAL** — lines 1-65; 1 of 3 photos read; do not execute |
| `scripts/parity/verify-gate-integrity.ps1` | ★★★★ **the meta-gate** — auto-discovers and runs every `selftest-*.ps1`; ★ **refuses to pass when it finds none** | transcribed from 2 photos — complete (86 content lines) |
| `starter/Starter.Web.Api/Program.cs` | ★★ **confirms the Fusion boot shape** — 11 lines, no middleware | transcribed from 1 photo — complete (11 lines) |
| `starter/Starter.Web.Api/Starter.Web.Api.csproj` | Web SDK, GC tuning, `Fusion.Fx.Security.Web.OAuth.Okta` | transcribed from 1 photo — complete (31 lines, validates as XML) |
| `starter/Starter.Web.Api/web.config` | IIS config — ⚠ `windowsAuthentication enabled="true"` | transcribed from 1 photo — complete (14 lines, validates as XML) |
| `starter/Starter.Web.Api/appsettings.json` | ★★ the full Fusion platform config — **heavily redacted, see the security finding** | transcribed from 4 photos — complete (206 lines, validates as JSONC) |
| `starter/Starter.Web.Api/entrypoint.sh` | container entrypoint — OpenShift `PORT` handling | transcribed from 1 photo — complete (13 lines); no redactions needed |
| `starter/Starter.Web.Api/appsettings.Development.json` | ★ empirical proof the API surface is **config-driven and Development-gated** | transcribed from 1 photo — complete (11 lines, **validates as JSON**) |
| `starter/Starter.Web.Api/AppInfo.xml` | deployment descriptor — 12 environments, Azure DevOps pipelines | transcribed from 2 photos — complete (89 lines, **validates as XML**); **2 values redacted** — see below |
| `starter/Starter.Web.Api/Models/PublicTextResponse.cs` | ✅ `sealed record`, XML `<summary>` + `<param>` | transcribed from 1 photo — complete (7 lines) |
| `starter/Starter.Web.Api/Models/MyModel.cs` | input DTO — correct `[Required]` + `required` pairing, no docs | transcribed from 1 photo — complete (11 lines) |
| `starter/Starter.Web.Api/Models/MyModelSearch.cs` | search filter DTO — all-nullable, no docs | transcribed from 1 photo — complete (8 lines) |
| `starter/Starter.Web.Api/Extensions/FusionWebBuilderExtensions.cs` | ★★ **settles the auth dispute** — contains no auth, no Swagger, no middleware at all | transcribed from 1 photo — complete (source lines 1-20) |
| `starter/Starter.Web.Api/Controllers/PublicTextController.cs` | ✅ the exemplar controller — XML docs, `sealed`, async + `CancellationToken`, `ILogger<T>` | transcribed from 1 photo — complete (source lines 1-43) |
| `starter/Starter.Web.Api/Controllers/MyEntitiesController.cs` | ⚠ the non-exemplar — no docs, not `sealed`, sync, no logger, **verb-based route** | transcribed from 1 photo — complete (source lines 1-66) |
| `starter/Starter.Library/Starter.Library.csproj` | ★ build settings + the first real Fusion package versions seen in the import | transcribed from 1 photo — complete (source lines 1-21); **validates as XML** |
| `starter/Starter.Library/Services/PublicTextService.cs` | ✅ reference service done **right** — XML docs, async + `CancellationToken`, stateless | transcribed from 1 photo — complete (source lines 1-22); 9 anchors verified |
| `starter/Starter.Library/Services/MyService.cs` | ⚠ reference service — **scores HIGH against the kit's own compliance rubric** | transcribed from 1 photo — complete (source lines 1-43); 10 anchors verified |
| `starter/Starter.Library/Options/MyOptions.cs` | reference options class | transcribed from 1 photo — complete (source lines 1-8) |
| `starter/Starter.Library/Extensions/FusionApplicationBuilderExtensions.cs` | **protected starter control point** — library DI/options composition seam | transcribed from 1 photo — complete (source lines 1-39); 11 anchors verified |

### Contracts / schemas

| File | Role | Status |
|---|---|---|
| `contracts/schemas/README.md` | **Ignition-native** — ★★ the dialect spec, authoring rules, and the kit's own registry table for all nine contracts | transcribed from 3 photos — complete (source lines 1-148 + trailing blanks); 11 anchors verified |
| `contracts/schemas/step-workflow-state.schema.json` | **Ignition-native** — ★ by far the richest schema (nested objects, `arrayOf`, four `required[]` levels) — **and it does NOT pin a status enum** | transcribed from 2 photos — complete (source lines 1-66); **validates as JSON** |
| `contracts/schemas/per-route-behavior-plan.schema.json` | **Ignition-native** — ⚠ the weakest floor in the family: **no `type` key at all**, only `notEmpty` | transcribed from 1 photo — complete (source lines 1-13); **validates as JSON** |
| `contracts/schemas/modernization-solution-design.schema.json` | **Ignition-native** — `New-ControlPlaneSkeleton` family; `required: [reportId, title]` | transcribed from 1 photo — complete (source lines 1-19); **validates as JSON** |
| `contracts/schemas/modernization-phase-assessment.schema.json` | **Ignition-native** — `New-ControlPlaneSkeleton` family; `required: [reportId, title]` | transcribed from 1 photo — complete (source lines 1-19); **validates as JSON** |
| `contracts/schemas/modernization-execution-contract.schema.json` | **Ignition-native** — ★ the only schema with a **deterministic producer** and a `required[]` array | transcribed from 1 photo — complete (source lines 1-19); **validates as JSON** |
| `contracts/schemas/fusion-migration-plan.schema.json` | **Ignition-native** — field contract for the Step 5 slice/migration ordering plan | transcribed from 1 photo — complete (source lines 1-14 + trailing blank); **validates as JSON** |
| `contracts/schemas/fusion-decisions.schema.json` | **Ignition-native** — field contract for the Step 5 migration decisions; **the first schema that asserts a real field** | transcribed from 1 photo — source lines 1-18 + trailing blank; **validates as JSON**, but the `authoringNote` string is **truncated at the right edge** |
| `contracts/schemas/fusion-control-point-inventory.schema.json` | **Ignition-native** — field contract for the Step 5 protected control-point inventory | transcribed from 1 photo — complete (source lines 1-14 + trailing blank); **validates as JSON** |
| `contracts/schemas/executable-testcase-catalog.schema.json` | **Ignition-native** — `opx-field-contract/v1` field contract for the Step 6 executable testcase catalog | transcribed from 1 photo — complete (source lines 1-14); **validates as JSON** |

### Templates

| File | Role | Status |
|---|---|---|
| `templates/COMPLIANCE-ANALYSIS-REPORT.template.md` | **Ignition-native** — ★ the fixed-category compliance report emitted at Steps 4 and 22 | transcribed from 4 photos — complete (source lines 1-181, blank to 182); 19 anchors verified |
| `templates/AMBIGUOUS-PLACEMENT-REPORT-TEMPLATE.md` | **Ignition-native** — durable review artifact for a legacy surface that does not map cleanly into the approved target structure | transcribed from 2 photos — complete (source lines 1-81); 14 anchors verified |

### Manifests

| File | Contents |
|---|---|
| `manifests/ignition-kit-file-tree.md` | **★ Full repo file tree** — transcribed from 5 photos of a generated tree view, plus a full reconciliation of what this import has and has not covered |
| `manifests/github-instructions-listing.md` | Full `.github/instructions/` listing (25 entries), `.github/templates/` (2), and the `.github/` top level — transcribed from 1 directory-tree photo |

### Skills

| File | Domain | Status |
|---|---|---|
| `skills/appmod-backend-dotnet/SKILL.md` | backend — .NET upgrade + restructure | transcribed from 1 photo — complete (source lines 1-34, blank to 35); 11 line numbers spot-verified |
| `skills/appmod-compliance-review/SKILL.md` | review — AI-judgment whole-codebase compliance review | transcribed from 2 photos — complete (source lines 1-119, blank to 120); 21 line numbers spot-verified |
| `skills/appmod-frontend-angular/SKILL.md` | frontend — legacy Angular → `src/Client` parity move | transcribed from 1 photo — complete (source lines 1-35, blank to 36); 10 line numbers spot-verified |
| `skills/appmod-fusion-target/SKILL.md` | fusion — shared target: structure, Okta/OIDC, Scalar, component swap | transcribed from 1 photo — complete (source lines 1-32, blank to 33); 13 line numbers spot-verified |
| `skills/appmod-modernization-process/SKILL.md` | modernization — the phased wave sequence and parity gates | transcribed from 1 photo — complete (source lines 1-40, blank to 41); 17 line numbers spot-verified |
| `skills/appmod-testing-and-gates/SKILL.md` | testing — characterization tests, gate scripts, frozen scorecard | transcribed from 1 photo — complete (source lines 1-42, blank to 43); 14 line numbers spot-verified |
| `skills/architecture-structure/Architecture-Structure.md` | **Ignition-native** — backend layering profiles + the canonical test workspace | transcribed from 4 photos — complete (source lines 1-215, blank to 216); 30 line numbers spot-verified |

| `skills/architecture-structure/REMAINING-POINTS.md` | **Ignition-native** — the five formation decisions still intentionally open | transcribed from 2 photos — complete (source lines 1-108, blank to 109); 31 line numbers spot-verified |
| `skills/architecture-structure/SKILL.md` | **Ignition-native** — the modernization-formation move contract (largest file in the kit) | transcribed from 9 photos — complete (source lines 1-470, blank to 472); 24 line numbers spot-verified |
| `skills/browser-source-decomposition/SKILL.md` | **Ignition-native** — classifies the legacy browser source shape and picks the decomposition contract | transcribed from 2 photos — complete (source lines 1-102, blank to 103); 22 line numbers spot-verified |
| `skills/diagnose/SKILL.md` | **Ignition-native, meta** — audits an AI workflow across 5 quality dimensions | transcribed from 2 photos — complete (source lines 1-106); 27 line numbers spot-verified |
| `skills/dominion-requirements/AppMod-Acceptance-Criteria.md` | **Ignition-native** — the canonical Dominion acceptance-criteria rubric | transcribed from 2 photos — complete (source lines 1-100); 22 line numbers spot-verified |
| `skills/dominion-requirements/SKILL.md` | **Ignition-native** — the full Dominion rubric with WHY/WHAT/HOW (largest file in the kit) | transcribed from 25 photos — complete (source lines 1-1398, blank to 1399); 100+ line numbers spot-verified |
| `skills/fusion-feature-standards/fusion-auth-standards.md` | **Ignition-native** — non-negotiable Okta/auth/secrets/CORS security standards | transcribed from 6 photos — complete (source lines 1-301); 26 line numbers spot-verified |
| `skills/fusion-g1-to-g2-modernization/references/fusion-g1-recognition.md` | **Ignition-native** — portable Fusion G1 (Knockout/RequireJS/Durandal) recognition reference | transcribed from 13 photos — complete (source lines 1-744, blank to 745); 62 line numbers spot-verified |
| `skills/fusion-g1-to-g2-modernization/references/g1-to-g2-modernization-playbook.md` | **Ignition-native** — per-slice G1→G2 conversion checklist | transcribed from 2 photos — complete (source lines 1-86); 13 line numbers spot-verified |
| `skills/fusion-g1-to-g2-modernization/references/knockout-modernization-cheatsheet.md` | **Ignition-native** — Knockout concepts and migration tips | transcribed from 1 photo — complete (source lines 1-59, blank to 60); 11 line numbers spot-verified |
| `skills/fusion-ui-component-upgrade/SKILL.md` | **Ignition-native** — route-level Fusion primitive adoption (Steps 15-16 lane) | transcribed from 5 photos — complete (source lines 1-239, blank to 244); 28 line numbers spot-verified |
| `skills/runtime-parity-checkpoint/SKILL.md` | **Ignition-native** — boot-observe-assert runtime proof against the running app | transcribed from 3 photos — complete (source lines 1-91); 23 line numbers spot-verified |
| `skills/step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md` | **Ignition-native** — the versioned schema for all seven Step 3 artifacts | transcribed from 3 photos — complete (source lines 1-143, blank to 145); 23 line numbers spot-verified |
| `skills/step3-legacy-system-analysis/SKILL.md` | **Ignition-native** — Step 3 entry point, modality detection, gate enforcement | transcribed from 2 photos — complete (source lines 1-73, blank to 75); 22 line numbers spot-verified |
| `skills/workstation-playwright-setup/SKILL.md` | **Ignition-native** — Playwright/Chromium install + capture-path troubleshooting | transcribed from 2 photos — complete (source lines 1-72, blank to 73); 21 line numbers spot-verified |
| `skills/visual-parity-gate/SKILL.md` | **Ignition-native** — dual-port legacy-visual-parity gate (Step 13 closeout) | transcribed from 4 photos — complete (source lines 1-101, blank to 102); 25 line numbers spot-verified |
| `skills/visual-parity-gate/references/fusion-client-foundation-templates/_variables.scss` | **Ignition-native** — brand/layout token template bound to the legacy visual contract | transcribed from 1 photo — complete (source lines 1-37, blank to 38) |
| `skills/visual-parity-gate/references/fusion-client-foundation-templates/_collection-grid.scss` | **Ignition-native** — collection-grid layout template | transcribed from 1 photo — complete (source lines 1-59, blank to 60) |
| `skills/visual-parity-gate/references/fusion-client-foundation-templates/_legacy-bootstrap-baseline.scss` | **Ignition-native** — Bootstrap-3/4 utility re-baseline template | transcribed from 2 photos — complete (source lines 1-101, blank to 102) |

`architecture-structure/` is a **multi-file skill**, now fully transcribed: `SKILL.md` (470 lines),
`Architecture-Structure.md` (215), `REMAINING-POINTS.md` (108).

> **The `appmod-*` skills are Squad-side, not Ignition-native — CONFIRMED.** All five live in the
> Ignition Kit's `.github/skills/` tree, but they are artifacts of *this conversion project*:
> knowledge earned from Ignition Kit runs and written up against Squad's decision ledger and
> phase model. They are before-state *evidence about what was learned*, not before-state
> *content*. See "⚠ The `appmod-*` skills are Squad-side (confirmed)" below.

### Agents

| File | Role | Status |
|---|---|---|
| `agents/OpX-AppMod-P1-Discovery.agent.md` | Phase 1 Discovery coordinator (Steps 1-6) | transcribed from 2 photos — complete (source lines 1-102, blank to 113) |
| `agents/OpX-AppMod-P2-Modernize.agent.md` | Phase 2 Modernize coordinator (Steps 7-18) | transcribed from 3 photos — complete (source lines 1-136, blank to 140) |
| `agents/OpX-AppMod-P3-Review.agent.md` | Phase 3 Review coordinator (Steps 19-24) | transcribed from 2 photos — complete (source lines 1-82, blank to 83) |
| `agents/OpX-csharp-expert.agent.md` | .NET coding-violations fixer (specialist, user-invocable) | transcribed from 8 photos — complete (source lines 1-437, blank to 439); 20 heading line numbers spot-verified |
| `agents/OpX-csharp-janitor.agent.md` | .NET cleanup / quick-wins specialist (user-invocable) | transcribed from 5 photos — complete (source lines 1-275, blank to 277); 18 heading line numbers spot-verified. **Source file is currently broken — 3 YAML errors, see findings** |
| `agents/OpX-dotnet-upgrade.agent.md` | .NET Framework → .NET 10 upgrade specialist (Step 7 lane) | transcribed from 6 photos — complete (source lines 1-287); 25 heading line numbers spot-verified |
| `agents/OpX-Frontend-Angular-Transform.agent.md` | **Archived** compatibility redirect for the retired Angular specialist lane | transcribed from 1 photo — complete (source lines 1-50, blank to 51) |
| `agents/OpX-Fusion-Reviewer.agent.md` | Fusion restructure reviewer (Step 19 lane) | transcribed from 2 photos — complete (source lines 1-90, blank to 92); 16 heading line numbers spot-verified |
| `agents/OpX-fusion-ui-component-upgrade.agent.md` | Fusion UI slice executor (Steps 15-16 lane) | transcribed from 1 photo — complete (source lines 1-57, blank to 59); 12 heading line numbers spot-verified |
| `agents/Ultimate-AppMod-Ignition.agent.md` | Top-level modernization orchestrator | transcribed from 2 photos — complete (source lines 1-95, blank to 96); 21 heading line numbers spot-verified |
| `agents/Ultimate-Ignition-edit.agent.md` | Kit-maintenance agent (edits the toolkit itself) | transcribed from 2 photos — complete (source lines 1-93, blank to 94); 26 heading line numbers spot-verified. **Frontmatter is byte-identical to `Ultimate-AppMod-Ignition` except the `name:` line — see findings** |

## Structural facts about the Ignition Kit learned from transcription

- Prompts are **VS Code Copilot prompt files** (`.github/prompts/NN-Px-name.prompt.md`)
  with frontmatter: description, name, argument-hint, **agent** (per-phase custom agents,
  e.g. `OpX-AppMod-P1-Discovery`), and a tools allowlist.
- Steps carry **per-prompt model-tier recommendations** ("Light (low thinking)") and
  estimated run times.
- The kit already has **artifact gates**: `.github/scripts/shared/verify-step-artifacts.ps1
  -Step N -Mode Input|Output` with `RESULT: OK` (exit 0) / `RESULT: BLOCKED` (exit 2) —
  input prechecks and output verification per step.
- **Step registry**: `/.github/instructions/step-registry.json` maps opaque step ids
  (e.g. `step:1fc2ba`) to human labels; prompts reference next steps by id.
- **State tracking**: `step-workflow-state.json` with a mandated human-readable readback
  block (Updated At / Recorded Step / Recommended Next Step).
- Conventions: legacy app copied to `LegacyCode/`; target is `src/<AppName>.Web.Api`
  (dotnet, **Scalar at https://localhost:4200/scalar**) + `src/<AppName>.Web.Client`
  (npm, https://localhost:5001). Docs under `/.modernization/.readme/`
  (Prerequisites.md, HowToRun.md). Package source: Sonatype (env creds + .npmrc/NuGet
  source checks). "Fusion G1" identifies a legacy Fusion generation.

## Structural facts added by prompt 02

- **The real Fusion Starter Kit layout** (corrects the reference kit's assumed
  `src/{Library,API,Client}`): `src/<App>.Library`, `src/<App>.Web.Api`,
  `src/<App>.Web.Client` — PascalCase backend naming, client as an `.esproj`
  (JS project system), scaffolded from `Starter.*` templates that Step 2 relabels.
- **Client baseline policy**: Angular even-major baseline, currently **Angular 20**.
- **Fusion specifics**: `AppInfo.xml` per project; `appsettings.json` Fusion keys
  (`Fusion.DataDirectory.PathBase`, `Fusion.Web.Api.OpenApi.Title`,
  `Fusion.Web.Client.Config.ApplicationName`); `<fusion-header label>` component;
  per-environment `fusion.config.*.ts` (e.g. `.dvl`) carrying Fusion OAuth hostnames
  that MUST NOT change during identity rename (later auth step owns them).
- **Run params**: `/.modernization/.readme/kit-params.md` holds `appName`;
  `.StepSummary.md` is a per-run human-readable step log; toolkit self-edits governed
  by `/.github/instructions/kit-update.instructions.md`.
- **Dual-surface completion model** (step 2): `physicalRenameStatus` +
  `referenceRewriteStatus` must both pass or the step reports `Blocked` — a
  two-column done-definition, not a single flag.
- Step ids observed: `step:1fc2ba`, `step:261769`.

## Structural facts added by prompt 03

- **Per-prompt model pins in frontmatter**: Step 3 carries `model: Claude Opus 4.6 (copilot)`
  directly in the prompt-file frontmatter — the kit pins specific models per step, not just
  tier hints in prose. (Step 3's prose tier is "Premium reasoning (high thinking)", 20-40 min.)
- **Schema contract versioning**: `step3ArtifactSchemaContractVersion: 1.0.1` in the prompt
  must match `.github/skills/step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md`
  — schemas are versioned artifacts owned by a *skill folder*, and prompts only keep an
  inline "minimum field floor". The kit has `.github/skills/` (screenshot-capture with
  SKILL.md + scripts/, step3-legacy-system-analysis with references/).
- **Hard Stops pattern**: numbered STOP gates inside the prompt (STOP 1 live-QA-URL
  resolution with exact priority order currentQaUrl → currentDevUrl → ask in chat → halt,
  plus a mandatory `qaUrlSource` echo; STOP 2 preflight limited to step-owned inputs, with
  non-step dependencies reported as "contract drift blockers"; STOP 2.5 modality branch;
  STOP 3 artifact completeness). STOP 2.5 classifies `detectedModality` as
  `api-only|mvc|spa|hybrid` from deterministic file-evidence criteria and everything
  downstream (artifact requiredness, response sections) branches on it.
- **Portal report system**: `.modernization/portal/data/json/` holds 9 named JSON reports
  (legacy-system-analysis, manifest-coverage, current-state-classification,
  runtime-topology, integration-contract-catalog, environment-and-secrets-map,
  data-and-cutover-risk, gap-and-exception-register, leadership-summary) seeded as
  skeletons by scripts and *enriched* by the agent; screenshots live under
  `.modernization/portal/data/images/<page>/`; portal publication is manual-only and
  never part of the done-definition. State files `step-workflow-state.json` and
  `step-response-ledger.json` also live under portal data and are written gate-authoritatively.
- **Ignition artifact layout**: structured analysis artifacts live in
  `.modernization/ignition-artifacts/discovery/` (service-behavior-inventory,
  interaction-wiring-inventory, workflow-trace-inventory) and
  `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json`
  (apiEndpointCatalog, uiControlClassification, fusionPrimitiveCoverageCensus fields).
  Every entry must carry `legacyEvidence` with a real file path + line range; no
  fabricated placeholder rows.
- **Modality applicability matrix**: a Required/Conditional/notApplicable grid per
  artifact × modality feeds STOP 3; `notApplicable` artifacts must still exist with an
  explicit `{notApplicable: true, reason}` marker — absence is never a valid encoding.
- **Screenshot progression rule**: partial capture may proceed only with (1) ≥1 image,
  (2) explicit user review, (3) explicit user approval; zero images + none user-provided
  = blocked. User evidence goes under `.modernization/.readme/user-provided-info/` and is
  referenced as `captured-user-provided` matrix rows.
- **Legacy Visual Contract Capture**: Step 3 extracts a `legacyVisualContract` block
  (palette, typography, shellChromeRegions, navRouteModel, controlAndLabelRules, per-route
  field sets with `headerLabel`+`boundField`) in two layers — static (always, from source)
  and runtime (Playwright computed styles + per-route reference screenshots when the app
  is reachable; `runtimeMeasured: false` marker when not). Step 5 consolidates it into
  `.modernization/fusion-restructure/styling-foundation.json` + `ui-visual-contract.json`;
  Step 13 uses it as the field-parity/visual-parity answer key ("column-collapse parity
  defect" is a named failure class).
- **Deterministic response shape**: 10 exact response headings in fixed order with
  placeholder vocabulary (`NotApplicable`/`NoneDetected`/`Blocked`), mandatory counts
  (`cannotLocateCount`, `unknownBacklogCount`, `blockedArtifactCount`), and a fixed
  closing sentence for the readiness decision — response format is contract, not style.
- **Gate statuses**: the step gate yields three axes (`scanCoverageStatus`,
  `traceabilityStatus`, `planningReadinessStatus`), each `Ready|Constrained|Blocked`;
  `Constrained` still allows planning to proceed, `Blocked` stops Step 4.
- **Governing Sources section**: prompts end by delegating policy to canonical
  `.github/instructions/*.instructions.md` files (AppMod-Process,
  ui-capture-reverse-engineering, testing-design-contract, fusion-restructure,
  qa-portal-reporting, appmod-phase-agent-contract) + `.github/skills/*/SKILL.md` —
  "do not re-derive the rules here".
- **Config/deployment conventions**: `connectionStringRuntimeInput` in kit-params.md;
  `OCPEnv` is the default final-state mode (alternatives `OpX`, `LocalIntegrated`/`OpEx`);
  default split SQL env var names `SqlServer__Server|Database|Username|Password|Encrypt|TrustServerCertificate`
  for the OpenShift/Kubernetes final state; Dapper row-model type hints
  (`dbParameterTypeHints[]`, `dbResultColumnTypeHints[]`) captured at discovery for
  Steps 8-9.

## ⚠ The `appmod-*` skills are Squad-side (confirmed)

The earlier inference (below) is now confirmed by three further skills. Three independent
proofs:

**1. Every decision ID matches Squad-ik's `.squad/decisions.md` — six for six, on number,
meaning, and often wording.**

| ID | `appmod-*` skill text | Squad-ik `.squad/decisions.md` |
|---|---|---|
| D-003 | "No-counterpart components are wrapped, recorded, reported" | "No-Fusion-counterpart policy: **wrap** … recorded as `no-counterpart` … reported in the run report" |
| D-004 | "preserve legacy -> flip frontend to Okta -> remove legacy path" | "**Auth strangler order.** (1) preserves legacy auth … (2) Frontend flips to Okta … (3) Legacy auth path removed" |
| D-005 | "Internal-only by default" | "**Scalar docs route is internal-only by default.**" |
| D-006 | "Fusion MCP (pinned) is the SOLE authority on structure and component counterparts" | "**Fusion MCP is the sole authority on target structure**, at the version pinned for the current kit release" |
| D-007 | "`src/<App>.Web.Api` (move-only)" / "behavior commits only" | "**Behavior commits and move commits never mix.**" |
| D-008 | "the deterministic GO/NO-GO gate" / "NEVER self-report the score" | "**Scorecard engine is frozen per run** … **never self-reported**" |

**2. The phase model is Squad's, not Ignition's.** `appmod-modernization-process` lists five
phases — **Discovery / Backend wave / Frontend wave / Fusionization / Close-out**. The Ignition
Kit's own structure, established across all 24 transcribed prompts, is three phases
(P1 Discovery 1-6, P2 Modernize 7-18, P3 Review 19-24) with 24 numbered steps. The wave model
is the Squad pipeline.

**3. The owning role is Squad's.** "**The Lead** owns this sequence." `Lead` is one of Squad's
five agent roles (`.squad/team.md`). No Ignition agent is called Lead — Ignition's owners are
`OpX-AppMod-P1-Discovery`, `-P2-Modernize`, `-P3-Review`, and the specialists.

**What this means for the import.** These five files are the **most valuable thing transcribed
so far for the actual conversion project** — they are a working draft of the Ignition→Squad
translation, written by someone who had run the kit and knew what it teaches. But they must not
be counted as Ignition Kit before-state content: doing so would double-count design decisions
that already exist on the Squad side and would misrepresent what the kit contains today.

They also reference **D-012 through D-016**, which are past the end of Squad's seeded
D-001…D-010. Squad's `decisions.md` header says run-local decisions are appended per run by the
Lead — so those five IDs exist in some run's appended ledger and are worth locating:

| ID | Meaning inferred from the skills |
|---|---|
| D-012 | Ownership classes: app-owned / Fusion-owned final state / temporary bridge / banned final state |
| D-013 | Policy-based authorization only |
| D-014 | Connection string composed at startup from split `SqlServer__*` env vars |
| D-015 | Fusion packages pinned to latest production Sonatype version, not stale sample versions |
| D-016 | Fusion MCP authority extended to component counterparts (paired with D-006) |

## ⚠ SUPERSEDED — earlier inference that the `appmod-*` skills are "probably" not Ignition-native

Both skills transcribed so far sit in the Ignition Kit's `.github/skills/` tree, but six
independent signals say they were authored **for the Squad/appmod conversion** and dropped into
the Ignition repo — not written as part of the original kit:

1. **`source:` describes derivation, not authorship.**
   `"earned (Ignition Kit Step 7 + dotnet standards)"` and
   `"earned (Ignition Kit dominion-requirements compliance report, **re-cast as AI judgment**)"`.
2. **The Ignition Kit is referred to in the third person.**
   "It restores **the Ignition Kit's** before/after compliance report, but the findings come
   from AI judgment … instead of a regex scan."
3. **"Ignition-aligned" is a stated goal, not a property.**
   `**Output location (Ignition-aligned):**` — you only say that when aligning a non-Ignition
   thing *to* Ignition.
4. **The tool paths are not Ignition's.** `tools/appmod/gates/compliance-scan.(ps1|sh)` and
   `tools/appmod/artifacts/`. Every Ignition prompt and agent transcribed uses
   `.github/scripts/…`.
5. **The `.ps1|.sh` dual-launcher convention is Squad's, not Ignition's.** Squad-ik's own
   `CLAUDE.md`: "`.squad/gates/` — every gate has `.sh` and `.ps1` launchers over shared
   Python/Node logic." Ignition invokes PowerShell directly, everywhere.
6. **Both cite Squad-ik's decision IDs with Squad-ik's meanings.**
   - Ignition skill: `src/<App>.Web.Api` (move-only, **D-007**) / "behavior commits only"
     Squad-ik `.squad/decisions.md`: **D-007** "Behavior commits and move commits never mix."
   - Ignition skill: "The scorecard (**D-008**) is the deterministic GO/NO-GO gate" and
     "**NEVER self-report** the score"
     Squad-ik: **D-008** "Scorecard engine is frozen per run … scoring is executed by
     `gates/run-scorecard.sh`, **never self-reported**."

   Two of two checked IDs match on number, meaning, *and* wording.

**Why this matters for the import.** These files are evidence of what the *conversion* should
look like, not of what the Ignition Kit currently *is*. Transcribing them as Ignition source
would pollute the before-state record and would double-count design decisions that already
exist on the Squad side. They are kept in `skills/` because they are genuinely useful (see the
structural facts below), but they should be tagged as conversion-side and excluded from any
"what does the Ignition Kit contain today" analysis.

**What would confirm or refute this**: the `source:` field of the other skills in
`.github/skills/` (the eight referenced by agents and prompts — `fusion-restructure-review`,
`dominion-requirements`, `architecture-structure`, `ignition-kit-maintenance`,
`fusion-feature-standards`, `fusion-ui-component-upgrade`, `step3-legacy-system-analysis`,
`screenshot-capture`). If those lack `source:`/`confidence:` and reference `.github/scripts/`
rather than `tools/appmod/`, the split is confirmed and the `appmod-*` prefix is the marker.

## ★ `COMPLIANCE-ANALYSIS-REPORT.template.md` — the kit's own frozen-scorecard equivalent

181 lines, no frontmatter (correct for a template). This is the artifact behind
the Step 4 baseline review and the Step 22 final review, and it contains the
strongest anti-drift mechanism found anywhere in the kit outside
`step-registry.json`.

**The Requirements Checklist is a FIXED category set.** Its own preamble, verbatim:

> This table is the FIXED category set - identical for every application that
> runs through the kit.
> Rows are never added, removed, renamed, or reordered by a review; only
> Status/Findings/Notes vary.
> `UNKNOWN` means "not yet judged" (a worksheet placeholder), never "not
> applicable".

That is functionally identical to Squad's **D-008 frozen scorecard** rule, arrived
at independently. The `UNKNOWN` clarification is the sharp part: it closes the
single most common way a compliance review quietly shrinks — reclassifying an
awkward category as "not applicable" instead of judging it. For a company-wide
hackathon where every team emits one of these, a fixed row set is what makes the
reports comparable at all.

**The 21 fixed rows**, in order: 12-factor overall; 12-factor externalized
config; backing services; logs as event stream; stateless processes; SOLID
overall; single responsibility; open/closed; liskov substitution; interface
segregation; dependency inversion; OAuth 2.0 OIDC or SAML authentication;
policy-based authorization (no Roles / `User.IsInRole`); stateless API / no
static mutable state; RESTful API endpoints; JSON responses; API Docs
(Scalar/OpenAPI) config-driven and disabled in production; Logging: 7 types +
event-stream (stdout/stderr); all I/O operations async; test coverage >= 80%;
packages approved.

**The scoring formula matches `AppMod-Acceptance-Criteria.md` exactly:**
`Score = 100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`, and the template
makes the arithmetic show its work by rendering both the formula and the
substituted values. Two files, one formula, no drift — worth noting given how
many other pairs in this kit disagree.

**Four deployment gates**, one more than previously recorded:

| Gate | Required |
|---|---|
| Compliance Score | `>= 80` |
| CRITICAL Issues | `0` |
| Test Coverage | `>= 80%` |
| **Review complete** | **`100% files + every category judged`** |

The fourth gate is new to this import and is the one that gives the fixed-row
rule teeth: a review that leaves categories at `UNKNOWN` fails the gate rather
than passing with a thinner table.

**Scan Completeness is a first-class section**, requiring repo/commit, the scan
inventory file, total files in scope, total files scanned, and a completeness
percentage — with an explicit honesty escape hatch:

> If you cannot compute counts deterministically, set them to `UNKNOWN` and point
> to the inventory file and the exact scope/excludes used.

This is the same instinct as the `discovery-runner` two-layer verification
finding (a presence check cannot tell a 14-service inventory from the ~40 that
exist): make the *coverage* of the review auditable, not just its verdict.

**Baseline vs post-modernization is one template, not two.** The Progress
Comparison section is marked "Required for post-modernization reports only", with
explicit instructions for baseline runs (set `{{BASELINE_*}}` to this report's
values, `{{CURRENT_*}}` and all `{{*_CHANGE}}` to `N/A`). That is why the
artifact contract has Step 4 and Step 22 producing differently-named outputs from
the same shape.

**Placeholder convention:** `{{UPPER_SNAKE}}`, roughly 90 distinct tokens. Note
this differs from the `<AppName>` angle-bracket convention used everywhere else in
the kit — templates use `{{...}}`, guidance files use `<...>`. Worth encoding in
the linter so it does not flag either as wrong.

**One small defect:** `{{EXCLUDED_PATHS}}` is emitted twice — once in the header
block (line 8) and again as the entire Appendix (line 181). Harmless, but a
renderer will duplicate the content.

---

## Structural facts added by `templates/AMBIGUOUS-PLACEMENT-REPORT-TEMPLATE.md`

81 lines, **no frontmatter** — it opens directly with the H1
`# LegacyCode -> <ArchitectureStyle> Gap Analysis`. That is the expected shape
for a `templates/` file (it is filled in and emitted, not loaded as guidance), and
it is the first file in this import with no `---` block at all.

This is the kit's escape hatch for the case
`modernization-starter-boundaries.instructions.md` does not cover: a legacy file,
folder, or test surface that does not map cleanly into the approved target
structure. Rather than let the agent guess, the kit makes it produce a reviewable
artifact.

**The `<ArchitectureStyle>` placeholder in the title** binds this template to the
`architectureStyle` field in `kit-params.md` — the Simple-vs-Clean selection gate
identified earlier in this import. So the report is explicitly scoped to whichever
target structure the app chose, not to a single canonical layout.

**Structure:** Purpose → Assumptions Used → Executive Summary → Detailed Findings
(5 numbered subsections) → Proposed Skill/Reference Enhancements →
Highest-Confidence Immediate Recommendations → Items That Likely Need Explicit
User Direction.

Two tables carry the actual analysis:

- **Evidence Snapshot** — six fixed evidence rows (Controller/API usage,
  Service/feature usage, Repository/persistence usage, DI or startup wiring, Test
  or call-site evidence, Naming/folder clues), each with `Observation` and
  `Placement Impact` columns. Fixing the rows means an agent cannot quietly skip
  the evidence class that would have contradicted its preferred answer.
- **Candidate Destinations** — three pre-seeded rows, each requiring
  `Why It Fits`, **`Why It Might Be Wrong`**, and a
  `High/Medium/Low` confidence. The mandatory counter-argument column is the good
  part: a single-candidate answer cannot be filed.

**Four reviewer verdicts:** `Approve`, `Approve with follow-up`,
`Needs more evidence`, `Reject`. Note this is a *fifth* distinct verdict
vocabulary in the kit, alongside the four step-status vocabularies already
recorded — though this one is scoped to a human review decision rather than
written into `step-workflow-state.json`, so it is far less likely to cause
interop breakage.

**Two sections worth porting to Squad regardless of the rest.** The template ends
by asking the agent to name (a) what skill or reference material would have
prevented the ambiguity, and (b) which items need explicit user direction. That
converts a one-off placement puzzle into a durable kit improvement and an explicit
escalation list — exactly the loop this whole import is trying to build.

---

## ✅ Gherkin settled for the third time, by the file that owns the rule

`tests-commenting.instructions.md` is the file `copilot.instructions.md` line 196
points at for everything under `tests/`. It specifies the same tag set, exactly:

- **Metadata comments** on every test case: `CaseId`, `Scenario`, `Description`,
  `Input`, `Expected`
- **Flow comments** in every test body: `Given`, `When`, `Then`
- Plus optional `And` comments "where they help a junior reader follow the sequence"

Three independent sources now specify Gherkin-*style comments* with an identical
tag list, and the file that owns `tests/**` is one of them. No `.feature` file,
no step definitions, no Cucumber runner anywhere in it. The question is closed;
prompt 24 and `tests.gherkinCoverage` are wording defects to fix.

The rest of the file is a commenting standard with unusual teeth — a "tutorial-level"
bar defined as *"a walkthrough where the developer explains the file line by
line"*, extended to helpers, config files, runner scripts, and `.csproj` files,
with a closing **No Surprise Rule**: *"Do not leave config, helper, script,
`.csproj`, or proof-of-concept files less documented than the test cases."*

---

## Partial notes on `ui-capture-reverse-engineering.instructions.md` (435 lines)

Not yet transcribed — see the honest status note at the end of this section. What
the read portions (lines 1-159, 396-435) establish:

**The Functional Parity Ledger.** Every interactive control resolves to exactly
one `effectClass`, each with a required runtime assertion:

| effectClass | What the control does | Required runtime assertion |
|---|---|---|
| `navigate` | Routes to another page/route | `route-changes-to-target` |
| `read` | Fires a GET and renders data | `real-rows-present` |
| `filter` | Applies criteria that change the visible row set | `grid-rows-change-after-apply` |
| `mutate` | Creates, updates, or deletes data (POST/PUT/DELETE/PATCH) | `api-call-fires-and-persists` |
| `export` | Downloads a file or triggers print | `file-download-response` |
| `open-dialog` | Opens a form/modal whose own controls are separately ledgered | `dialog-renders-and-own-controls-verified` |
| `ui-only` | Pure client-side toggle/collapse with no backend effect | `no-backend-proof-needed` |

**A five-state lifecycle ladder** every ledger row must climb:
`Inventoried` (Step 3) → `Mapped` (Step 6) → `Implemented` (Step 9/11/12) →
`Verified` (Step 12/13) → `Waived` (Review). All step numbers here are
**correct** — no +2 drift in this ladder.

> **Hard rule:** a row stuck below `Verified` with no `waiver` is a step blocker.
> The kit closes no step that has unverified ledger rows for in-scope controls.
> This is the mechanism that prevents "detected but never proven" from shipping
> as done.

**Three named screenshot-pipeline gate failure classes** — `Gate 1
(route-source)`, `Gate 2 (runtime-unreachable)`, `Gate 3
(playwright-unavailable)` — each to be reported with its gate label "so the
remediation action is immediately clear without re-running discovery."

**Two Step 5 catalog contracts not seen anywhere else:** `databaseSchemaCatalog`
(one entry per connection string, with `tables[]`, `views[]`,
`storedProcedures[]`, `triggers[]`, `functions[]`, `sequences[]`,
`foreignKeyEdges[]`, `orphanedTables[]`, `captureMethod`,
`captureCompletenessPercent`) and `backgroundJobCatalog` (one row per discovered
job, covering `hangfire`, `quartz`, `windows-service`, `windows-scheduled-task`,
`iis-webjob`, `azure-webjob`, `azure-function-timer`, `cron`, `polling-loop`,
`message-consumer`, `startup-task`). Both support `notPresent: true` **only with
explicit source-evidence attestation** — *"Inferred-empty without evidence is a
Step 5 gap."*

**A durable route-derivation rule** worth extracting: for SPA and hybrid apps,
derive screenshot targets from the **client-side router**, not server-side view
file paths — and Angular `path:` values are frequently identifier references to
route-name constants, so *"treating only quoted literals as routes produces a
false Gate 1 (route-source) zero-target result for apps that centralize route
names in constants."*

---

## ✅ RESOLVED: the precedence conflict was never a conflict — and `constitution.md` says so itself

The finding below records that `copilot.instructions.md` and
`modernization-starter-boundaries.instructions.md` disagree about what ranks
first. `constitution.md` settles it with one sentence at the end of its own
precedence list (line 53):

> This precedence applies only **within repo-maintained guidance**. It does not
> override higher-priority system, platform, or user instructions.

So the two lists are scoped differently, not contradictory:

- `constitution.md` and `modernization-starter-boundaries` rank **repo-authored
  files against each other**, and `constitution.md` is correctly first among those.
- `copilot.instructions.md`'s rank 1, "the current user request," sits **outside**
  that scope entirely — it is the "higher-priority user instruction" the
  Constitution explicitly defers to.

The finding below is therefore **downgraded from HIGH to a wording defect in one
file**. `copilot.instructions.md` states a five-level list that silently mixes
two different scopes and omits the Constitution altogether; the fix is to add the
Constitution at the top of its repo-guidance ranks and adopt the Constitution's
scoping sentence. That is a one-line edit, not an architectural conflict.

The Constitution's own order is now the authoritative one:

| Rank | Source |
|---|---|
| 1 | `/.github/constitution.md` — cross-cutting governance and shared principles |
| 2 | `/.github/copilot-instructions.md` — concise repo-wide attached defaults |
| 3 | `/.github/instructions/*.instructions.md` — narrower path- or purpose-scoped rules |
| 4 | `/.github/prompts/**/*.prompt.md`, `/.github/agents/*.agent.md`, `/.github/skills/<name>/SKILL.md` — task-specific execution behavior |
| 5 | package, project, or feature-level docs and code-local conventions |

Note this **also resolves the toolkit-protection ranking concern** recorded
earlier. `agent-toolkit-protection` is an `instructions/*.instructions.md` file,
so it sits at rank 3 — above every prompt, agent, and skill, which is the correct
place for a write boundary. The earlier reading (that it ranked below "the current
user request") came from `copilot.instructions.md`'s mis-scoped list, not from
the governing document.

---

## ★★★ THE KIT ALREADY SHIPS A STEP-NUMBER-DRIFT AUDITOR

The file tree reveals `.github/scripts/maintenance/` containing exactly two
scripts:

- **`audit-step-number-drift`**
- `audit-modernization-pollution`

Every numbering finding accumulated across this document — the `+2` survivors, the
half-applied ranges, the stale cross-references — may already be **detectable by a
script that ships with the kit**. Combined with `step-registry.json` (the designed
fix) and the repo-wide mandate to use `step:<stepId>` tokens, the picture is now:
the kit has the fix, the identity registry, *and* the auditor. What it appears to
lack is evidence anyone has run the auditor recently.

`audit-modernization-pollution` is presumably the enforcement arm of the
"do not encode the current validation app's routes/controllers/entities into
reusable toolkit assets" rule that `copilot.instructions.md`, `kit-update`, and
`AGENTS.md` all state.

**These two scripts are now the highest-value unread files in the kit.** They may
make the linter recommendation in this document unnecessary — or reveal why it
was needed.

---

## ★★ Full file tree transcribed — coverage reconciliation

`manifests/ignition-kit-file-tree.md` holds the tree plus a full gap analysis.
Headline coverage:

| Area | On disk | Covered by this import |
|---|---|---|
| `.github/instructions/` | 23 | 21 complete, 2 partial/pending |
| `.github/agents/` | 18 | 11 |
| `.github/skills/` | 21 folders | 12 |
| `.github/prompts/` numbered | 24 | 24 ✅ |
| `.github/prompts/` subfolders | ~32 more | 0 |
| `.github/contracts/schemas/` | 9 + README | 0 |
| `.github/templates/` | 2 | 2 ✅ |
| `.github/scripts/` | ~100+ | 0 |
| `.squad/` | large | 0 |

**Resolutions the tree provides:**

1. **The 18-agent discrepancy is now confirmed in both directions.** `.github/agents/`
   holds exactly 18 files. Against the Definitive Agent List:
   - on disk, not on the list: `OpX-Frontend-Angular-Transform`, `squad.agent.md`
   - on the list, not on disk: `modernize-dotnet`, `Microsoft-Researcher`

   So `agent-toolkit-protection.instructions.md` needs **two removals and two
   additions**. This retires a question that has been open since that file was
   transcribed.
2. **`screenshot-capture/` and `test-quality-standards/` are real** — both were
   flagged as "named but never photographed". `screenshot-capture/` ships a SKILL
   plus 3 capture scripts.
3. **Two skills nothing transcribed ever mentioned:** `ignition-kit-maintenance/`
   (SKILL + **9** references) and `legacy-local-run/` (SKILL + references +
   scripts). The first is load-bearing —
   `powershell-script-maintenance.instructions.md` and `kit-update` both defer to it.
4. **`src/` ships as `Starter.Library` / `Starter.Web.Api` / `Starter.Web.Client`**,
   confirming exactly what Step 2 renames, and `Starter.Web.Client.esproj`
   confirms the `.esproj` read from the naming law.
5. **`LegacyCode/` ships containing only `test.txt`** — an empty slot, as Step 1
   implies.
6. **`fusion.config` has five environment variants** (`.base`, `.dv1`, `.qa`,
   `.uat`, `.prd`) that no transcribed file enumerates.

---

## `Starter.Web.Client/src/` — the Angular app

### Directory tree (from the reference photo)

```
Starter.Web.Client/
├── .vscode/
├── scripts/
└── src/
    ├── app/
    │   ├── components/
    │   │   └── .gitkeep                      <- EMPTY. no shared components ship.
    │   ├── pages/
    │   │   ├── common-components/            .html .scss .spec.ts .ts
    │   │   ├── home/                         .html .scss .spec.ts .ts
    │   │   ├── my-entity/                    .html .scss .spec.ts .ts
    │   │   └── test-datastore/               (collapsed in photo)
    │   ├── services/                         (collapsed in photo)
    │   ├── app.component.html
    │   ├── app.component.scss
    │   ├── app.component.spec.ts
    │   ├── app.component.ts
    │   ├── app.config.ts
    │   ├── fusion.config.base.ts
    │   ├── fusion.config.dvl.ts
    │   ├── fusion.config.prd.ts
    │   ├── fusion.config.qa.ts
    │   ├── fusion.config.ts
    │   ├── fusion.config.uat.ts
    │   ├── routes.config.ts
    │   └── types.ts
    ├── assets/icons/
    ├── favicon.ico
    └── index.html
```

Two structural facts read straight off this tree, before any file content.

**1. Five Fusion configs, and the build default has no file.** `fusion.config.ts`
plus `.base`, `.dvl`, `.qa`, `.uat`, `.prd`. `build.mjs` selects a configuration
through its `configuration:` argv token and **defaults to `local`** — and there
is no `fusion.config.local.ts`. The natural reading is that `fusion.config.ts` is
itself the local/default file and `angular.json` `fileReplacements` swap in the
suffixed variants per environment, with `.base` holding whatever the other five
spread. That is a clean pattern and almost certainly what is happening; it needs
`angular.json` to confirm, and it is worth confirming, because if `local` is not
a declared Angular configuration then the *default* invocation of `npm run build`
fails while every named environment works. Added to the outstanding list.

**2. `app/components/` contains a single `.gitkeep`.** The starter ships **zero**
reusable components. Everything is a page. This matters more than it looks —
see the finding below.

---

### `pages/common-components/` — the Fusion component answer key, and it is nearly empty

This is the page the kit's frontend-swap steps most need to be good, because it
is the only place an agent can look to learn what Fusion UI markup is supposed to
look like. `component.ts` (16 lines) and `component.html` (10 lines) are both
transcribed; `.scss` and `.spec.ts` are outstanding.

#### CONFIRMED: the Fusion Angular package scope is `@fusion/ngx-fusion`

```ts
import {
    FusionGridCellComponent,
    FusionGridContainerComponent,
    FusionGridRowComponent,
    FusionPageBaseComponent
} from '@fusion/ngx-fusion';
```

First hard confirmation of the frontend half of the Fusion stack. Until now the
only evidence was `fusion-mcp-restructure.instructions.md` asserting
`provideNgxFusion()` / `provideNgxFusionAuthOAuthOkta()`, which — given that
`fusion-auth-standards.md` was found to describe backend code that does not
exist — was not something to take on trust. The scope is real and the naming
convention is `Fusion<Thing>Component`.

`FusionPageBaseComponent` is a **base class**, not a template dependency: it is
imported, extended, and correctly left out of the `imports:` array.

#### The grid primitives, and the mapping the kit should be encoding

```html
<fusion-grid-container>
    <fusion-grid-row>
        <fusion-grid-cell>
            <h2 class="title-banner">Commonly Used Components</h2>
        </fusion-grid-cell>
    </fusion-grid-row>
    <fusion-grid-row>
        <fusion-grid-cell>Cell</fusion-grid-cell>
    </fusion-grid-row>
</fusion-grid-container>
```

Container → row → cell is a one-to-one match for Bootstrap's
`container` → `row` → `col`, which is what both reference legacy apps use. That
is exactly the kind of deterministic mapping the `component-map` canonical
artifact exists to hold, and encoding it there would remove a whole class of
per-run agent guesswork during the UI swap. Worth doing regardless of what else
changes.

#### ⚠ HIGH — "Commonly Used Components" demonstrates one component

> **SUPERSEDED — downgraded to MEDIUM.** This finding generalised from the only
> page transcribed at the time. `home` and `my-entity` demonstrate eight Fusion
> components plus the base class, including forms and buttons, so the starter's
> UI surface is *not* three grid components. What survives is narrower: the page
> **named** for the job is a stub while the real examples live on pages whose
> names do not advertise them. Full correction in the
> `pages/home` / `pages/my-entity` section below.

The page is called `common-components`, its heading reads *"Commonly Used
Components"*, and its entire catalogue is: a grid, containing a cell, containing
the literal string `Cell`.

That is the whole file. No button, no input, no table, no date picker, no dialog,
no form field, no icon usage — nothing that a real modernization would need to
map a legacy AngularJS or MVC5 view onto. Combined with `app/components/`
containing nothing but a `.gitkeep`, the starter's total demonstrated Fusion UI
surface is **three grid components**.

Why this is a HIGH rather than a cosmetic gap: the kit's frontend steps instruct
agents to replace legacy UI with Fusion equivalents, and
`AppMod-Process.instructions.md` leans on the *answer-key principle* — the idea
that agents work from a known-good exemplar rather than inventing. For the
backend that principle is honoured well (`PublicTextController` /
`PublicTextService` are a genuinely good exemplar pair, XML docs and all). For
the frontend the exemplar is a stub. Every participant's agent will therefore
invent its own Fusion markup from the package's type signatures, and they will
each invent something slightly different. In a company-wide hackathon that is
precisely the drift outcome the kit exists to prevent, and it is concentrated in
the one file named for the job.

Fixing it is cheap relative to everything else in the backlog: filling this page
with one worked example per commonly-used Fusion component — the way
`PublicTextController` works for the API side — turns the highest-variance step
in the pipeline into a copy-the-pattern step. If only one thing on the frontend
list gets done before the hackathon, this is the one.

#### Smaller observations

- **`implements OnInit` with an empty class body.** `export class
  CommonComponentsComponent extends FusionPageBaseComponent implements OnInit {}`
  declares the interface but defines no `ngOnInit`. This only compiles if
  `FusionPageBaseComponent` already provides one, which is presumably the case —
  so the declaration is inert. Harmless, but agents pattern-matching this file
  will copy `implements OnInit` onto components that then genuinely need an
  `ngOnInit` they never write.
- **`@Component` members are alphabetised** (`imports`, `selector`, `standalone`,
  `templateUrl`, `styleUrls` — the last two are ordering-by-convention rather
  than strict alpha). Consistent with a `member-ordering` lint rule. Not stated
  anywhere in the instructions files; if it is enforced, `angular.instructions.md`
  should say so, since agents will not infer it from one file.
- **`standalone: true` is explicit** even though it has been the default since
  Angular 19. Not wrong, just redundant — and it dates the template.
- **`class="title-banner"`** is an app-level class, not a Fusion one, so the local
  SCSS defines a heading convention. Needs `common-components.component.scss` to
  know what it is; agents will otherwise drop `title-banner` onto pages with no
  matching style.
- **The editor shows 3 unresolved diagnostics** on this file, squiggled under both
  import specifiers and the decorator body — the signature of `node_modules` not
  being resolvable at the time the photo was taken. Recording it as an
  observation, not a defect in the file: it is what a tree looks like after
  `npmInstall` catches an error and deletes `node_modules`, but a machine that
  simply has not installed yet looks identical. Not attributing a cause.

---

## `pages/home/` and `pages/my-entity/` — the real frontend answer key

Five files: `home.component.{html,ts,scss}` and `my-entity.component.{html,ts}`.
`my-entity.component.scss` and both `.spec.ts` files are still outstanding.

### CORRECTED: the starter's Fusion UI surface is not three components

The previous entry rated the thin `common-components` page a **HIGH** on the
grounds that the starter's total demonstrated Fusion UI surface was three grid
components. **That was wrong, and it was wrong because it generalised from the
one page I had.** `home` and `my-entity` demonstrate:

| Component | Demonstrated in | Attributes seen |
|---|---|---|
| `FusionGridContainerComponent` | both | — |
| `FusionGridRowComponent` | both | — |
| `FusionGridCellComponent` | both | `[smallColumns]`, `[mediumColumns]` |
| `FusionBlockGridContainerComponent` | my-entity | `size="full"` |
| `FusionBlockGridRowComponent` | my-entity | `[smallColumns]`, `[mediumColumns]`, `[xPadding]`, `[yPadding]` |
| `FusionBlockGridCellComponent` | my-entity | — |
| `FusionButtonComponent` | both | `appearance`, `color`, `theme`, `label`, `type`, `(click)` |
| `FusionTextboxComponent` | my-entity | `label`, `formControlName` |
| `FusionPageBaseComponent` | all three | base class, provides `ngOnInit` |

Eight components and a base class, covering layout, forms, and actions. The
starter is in far better shape than the previous entry claimed.

**What survives, at MEDIUM rather than HIGH, is a discoverability problem.** The
page *named* `common-components`, titled *"Commonly Used Components"* — the one
place an agent told to "find the Fusion component examples" will look first — is
a stub containing a grid with the word `Cell` in it. The actual worked examples
are on two pages whose names do not advertise them. The fix is smaller than
before: either fill `common-components` in, or delete it so agents fall through
to the pages that do the job. Leaving a stub named after the thing an agent is
looking for is worse than not having the page.

Also retracted: `app/components/` being empty is not evidence of a missing UI
surface. Every page composes Fusion components directly, so there is simply
nothing app-specific to share yet. That is a reasonable state for a starter.

### `home.component.ts` is the frontend exemplar the kit needed

```ts
export class HomeComponent extends FusionPageBaseComponent {
    private readonly _publicTextService = inject(PublicTextService);

    protected readonly publicText = signal('');

    protected async loadPublicText(): Promise<void> {
        const response = await this._publicTextService.get();
        this.publicText.set(response.message);
    }
}
```

This is the frontend counterpart to `PublicTextController` / `PublicTextService`,
and it is deliberate: it calls the same public endpoint. It demonstrates
`ChangeDetectionStrategy.OnPush`, `inject()` over constructor DI, `signal()` for
template state, `protected` for template-facing members, `private readonly _`
prefix for dependencies, and `async`/`await` over manual subscription. That is a
complete, modern, opinionated Angular pattern in nine lines. The answer-key
principle **is** honoured on the frontend — just not on the page named for it.

Confirmed along the way: `FusionPageBaseComponent` defines `ngOnInit`, since
`MyEntityComponent` writes `override ngOnInit()`. That retroactively confirms the
earlier reading that `common-components`' `implements OnInit` with an empty class
body compiles.

Also filled in from the import paths: the `services/` folder (collapsed in the
tree photo) is laid out `services/<name>/<name>.service.ts` —
`services/public-text/public-text.service`, `services/my-entities/my-entities.service`
— and there is a single flat `src/app/types.ts` for shared types.

### ⚠ HIGH — `fusion-button` is used with two incompatible attribute vocabularies

```html
<!-- home.component.html -->
<fusion-button appearance="outline" color="primary" label="Call Sample API" (click)="loadPublicText()" type="button"></fusion-button>

<!-- my-entity.component.html -->
<fusion-button type="submit" theme="raised" label="Submit"></fusion-button>
```

`appearance` + `color` on one page, `theme` on the other, for the same component
in the same starter. Both look equally authoritative. Either
`@fusion/ngx-fusion` accepts both (one current, one legacy) or one of these is
already wrong and silently ignored.

This is the highest-value defect found in the client so far, and it is worth
being precise about why. The kit's whole anti-drift mechanism is *give the agent
one right answer to copy*. Here the starter gives two. An agent that reads
`home` emits `appearance`/`color`; an agent that reads `my-entity` emits `theme`;
neither can tell it chose wrong, no gate catches it, and the two styles will land
in different participants' repos in the same hackathon. That is drift generated
by the answer key itself.

The fix is cheap — pick the current API, normalise both call sites, and state it
in `angular.instructions.md`. It needs the `@fusion/ngx-fusion` component
definition to decide which one is canonical; that is the next thing worth
photographing if it is reachable.

### ⚠ MEDIUM — two grid systems with no stated rule for choosing

`fusion-grid-*` and `fusion-block-grid-*` are distinct component families, and
`my-entity` nests the second inside the first:

```html
<fusion-grid-cell [smallColumns]="5">
    <form [formGroup]="entityForm" (ngSubmit)="submitEntity()">
        <fusion-block-grid-container size="full">
            <fusion-block-grid-row [smallColumns]="1" [mediumColumns]="2" [xPadding]="true" [yPadding]="true">
```

The observable convention is *grid for page layout, block-grid for form layout* —
block-grid is the one with `[xPadding]`/`[yPadding]`/`size`. Nothing in any
transcribed instructions file mentions either family, let alone the distinction.
An agent doing a UI swap has no rule to apply and will pick by coin-flip. One
sentence in `angular.instructions.md` closes it.

### The Bootstrap → Fusion mapping is now fully mechanical

`[smallColumns]="12" [mediumColumns]="6"` is `col-12 col-md-6`. Combined with
container → row → cell, the legacy Bootstrap grid maps onto Fusion with no
judgement required:

| Bootstrap | Fusion |
|---|---|
| `.container` | `<fusion-grid-container>` |
| `.row` | `<fusion-grid-row>` |
| `.col-N` | `<fusion-grid-cell [smallColumns]="N">` |
| `.col-md-N` | `[mediumColumns]="N"` |

This strengthens the earlier recommendation: put it in the `component-map`
canonical artifact and the UI swap stops being a per-run guess. Both reference
legacy apps use Bootstrap, so it is directly exercisable against them.

Caveat worth recording: `home.component.html`'s first cell carries no column
attributes at all, so `<fusion-grid-cell>` has an undocumented default width.
And `my-entity` uses `<fusion-grid-cell [smallColumns]="2" />` — a self-closing
**empty spacer cell** — to make 5 + 2 + 5 = 12. Agents will copy that as the way
to do gutters.

### Angular 17+ built-in control flow, confirmed

```html
@if (entities().length) {
    @for (entity of entities(); track entity.id) {
```

`@if` / `@for` with a mandatory `track`, not `*ngIf` / `*ngFor`. This pins the
target Angular at ≥ 17 and gives the frontend port a hard rule: legacy
`ng-repeat` and `*ngFor` become `@for (… ; track …)`. Nothing in the transcribed
instructions says so, and an agent trained on older Angular will emit `*ngFor`,
which still compiles — so this will drift silently unless it is stated.

### Smaller observations

- **`my-entity.component.ts` imports `CommonModule` and does not need it.** With
  built-in control flow and no `ngClass`/`ngStyle`/pipes in its template, it is
  dead weight — and it appears both in the import statement and the `imports:`
  array. `home.component.ts` correctly omits it. Agents pattern-matching
  `my-entity` will carry `CommonModule` into every component they generate.
- **Two change-detection policies in one starter.** `HomeComponent` sets
  `ChangeDetectionStrategy.OnPush`; `MyEntityComponent` does not. With signals
  throughout, `OnPush` is the correct default. No rule is stated either way.
- **Two member-visibility conventions.** `Home` marks template-facing members
  `protected`; `MyEntity` leaves `entities`, `entityForm`, `edit`, `refresh`, and
  `submitEntity` public. Same inconsistency shape as the button attributes, lower
  stakes.
- **`edit()` uses `setValue`, which is strict.**
  `this.entityForm.setValue(entity)` throws at runtime unless `entity`'s keys
  match the form group exactly. The server-side `MyEntity` is
  `Id`/`Name`/`Description`, so it lines up today — but `patchValue` is the call
  that stays correct when either side gains a field, and this is an exemplar
  agents will copy onto their own entities.
- **`this.entityForm.value as MyEntity`** suppresses the fact that a typed
  `FormGroup`'s `.value` is a `Partial<>`. The `required` validator on `name`
  plus the early return make it safe here; the cast is still the pattern being
  taught.
- **No frontend error handling anywhere.** `loadPublicText`, `refresh`, and
  `submitEntity` all `await` network calls with no `try`/`catch` and no user-facing
  failure path. `dotnet.instructions.md` mandates `Fusion.Fx.IErrorService` on the
  backend; there is no stated Angular equivalent, and the starter models none.
  For a modernization kit this is a real gap — legacy apps being ported usually
  have *some* error surface, and parity work will have nowhere to put it.
- **`submitEntity` refetches the whole collection after saving** rather than using
  the save response. Fine at this scale; recording it as the demonstrated pattern
  since it will be copied onto larger lists.
- **`home.component.scss` is four lines** — a single `.sample-api-result` rule
  (`margin-top: 1rem; font-weight: 600`). Note it styles the API-result paragraph,
  **not** the `title-banner` class used by `common-components` and `my-entity`.
  `title-banner` is therefore defined globally (`styles.scss`) or by Fusion
  itself; still unresolved.

---

## `pages/test-datastore/` — the fourth page, and a third way of doing everything

`test-datastore.component.html` (54 lines) and `.scss` (14 lines) transcribed;
`.ts` and `.spec.ts` outstanding. The page is a simple read/write harness: one
panel loads a string from the server, the other posts a new one.

Two new items for the Fusion inventory, bringing it to nine components:

| Component | Attributes seen here |
|---|---|
| `fusion-textarea` | `[rows]`, `placeholder`, `[(ngModel)]` |
| `fusion-button` | `label`, `type`, `(click)`, **`[disabled]`** |

`[disabled]` is new and matters — it is the only demonstrated way to gate a
Fusion control on in-flight state.

### ⚠ HIGH — this page contradicts the other three on every axis that matters

`test-datastore` is well-built in isolation: it has loading states, disabled
bindings, `:host { display: block }`, and subtitled panel headers. None of the
other pages do. But it reaches those results by different means than every other
page in the starter, and an agent has no way to tell which set is canonical.

**State: three different exposure conventions.**

> **CORRECTED after `test-datastore.component.ts` arrived.** This subsection
> originally read "plain properties, not signals". The component in fact holds
> five private signals behind public getters, so the template reads accessors,
> not fields. See the `.ts` entry below for the corrected finding, which is
> weaker than what is written here but still real.


```html
<pre class="value">{{ displayedText }}</pre>
[disabled]="isLoading"
```

No call parentheses. `displayedText`, `isLoading`, `isSaving`, and
`payloadValue` are ordinary class fields. `home` and `my-entity` both use
`signal()` and read it as `publicText()` / `entities()`. So the starter teaches
signals on two pages and plain mutable fields on a third.

**Forms: `[(ngModel)]`, i.e. template-driven.**

```html
<fusion-textarea [rows]="6" placeholder="Enter text to persist..." [(ngModel)]="payloadValue"></fusion-textarea>
```

`my-entity` uses `ReactiveFormsModule` with a typed `FormGroup` and
`formControlName`. This page uses two-way `ngModel`. Angular has treated these as
two distinct, not-to-be-mixed strategies for a decade. The starter ships both,
with nothing stating when to use which — and `ngModel` inside a Fusion component
also implies `FusionTextareaComponent` implements `ControlValueAccessor`, which
is worth knowing but is nowhere written down.

**Inner layout: raw HTML and hand-rolled CSS, not Fusion.**

```html
<section class="panel">
    <header>
        <h2>Retrieve value</h2>
        <p class="subtitle">…</p>
    </header>
    <div class="value-wrapper">…</div>
    <div class="panel-actions">…</div>
</section>
```

`my-entity` lays out the inside of a grid cell with `fusion-block-grid-*`.
This page uses `<section>` / `<header>` / `<div>` plus custom SCSS. That is now
**three** worked answers to "how do I lay out content inside a cell" — Fusion
grid, Fusion block-grid, and plain HTML — across four pages.

Why this is HIGH rather than a style nit: the frontend swap step asks an agent to
convert a legacy view into the Fusion idiom. The starter is the answer key. On
signals-vs-fields, reactive-vs-template forms, and Fusion-vs-hand-rolled layout,
the answer key gives two or three mutually exclusive answers with equal apparent
authority, no gate distinguishing them, and no instructions file adjudicating.
Every participant's agent will pick differently. This is the same failure as the
`fusion-button` attribute split recorded above, but broader — and taken together
the two are the strongest evidence so far that the starter needs a documented
"canonical patterns" pass before the hackathon, not just more content.

The cheapest fix is not to rewrite pages. It is to state the rules — signals over
fields, reactive over template-driven, Fusion layout components over hand-rolled
CSS — in `angular.instructions.md`, and to mark whichever page violates them as
deliberately non-canonical. Agents follow instructions files; they only imitate
code when the instructions are silent.

### The SCSS defines one of the eight classes the template uses

```scss
:host {
    display: block;
}

.panel-actions {
    display: flex;
    justify-content: flex-end;
    width: 100%;
    margin-top: 1rem;
}

.panel-actions fusion-button {
    margin-left: auto;
}
```

The template uses `datastore-page`, `panel-row`, `panel`, `subtitle`,
`value-wrapper`, `value`, `loading`, and `panel-actions`. The component
stylesheet defines **only** `panel-actions`. The other seven are either global
(`src/styles.scss`, not yet transcribed), supplied by Fusion, or dead. This is
the same open question as `title-banner` on `common-components` and `my-entity`,
and it is now blocking: without `styles.scss` there is no way to tell which
class names are part of the kit's vocabulary and which are one page's leftovers.
**`src/styles.scss` is the file I would ask for next.**

Two smaller notes on the stylesheet:

- `:host { display: block; }` is correct Angular practice and this is the **only**
  page that does it. `home.component.scss` is four lines with no `:host`.
- `.panel-actions fusion-button { margin-left: auto; }` styles a third-party
  component's host element from a parent stylesheet. It works, and it is a
  legitimate technique, but it couples the page to `fusion-button`'s tag name and
  will silently stop applying if the selector is ever renamed. Worth a note in
  whatever styling guidance gets written.

### Smaller observations

- **First use of `@else`.** `@if (!isLoading) { … } @else { … }` — with the
  negated condition first, so the loading branch is the `@else`. Inverting it
  would read better, but it confirms the `@if`/`@else` block syntax for the
  frontend-port rules.
- **`fusion-button` appears here with neither `appearance`/`color` nor `theme`** —
  just `label`, `type`, `(click)`, `[disabled]`. So both decorative vocabularies
  are optional, which means the HIGH recorded above is not "one of them is
  invalid" but "three call sites, three different styling choices, no stated
  default". That is still worth normalising, and the bare form here is arguably
  the sanest baseline.
- **The file has no trailing newline.** Every other file transcribed from the
  starter ends with one; the editor gutter here stops at line 54 with content on
  it. `dotnet.instructions.md` mandates `.editorconfig` adherence and the client
  is Prettier-formatted, both of which normally enforce a final newline — so this
  file is likely escaping whatever formatter runs in `npm run lint`. Trivial in
  itself; interesting as a signal that the lint step's coverage is narrower than
  assumed (the unused `CommonModule` import in `my-entity` points the same way).
- **`<pre>` for the retrieved value** preserves server whitespace, which is
  deliberate for a datastore harness and worth keeping if this page is ever
  used as a parity fixture.

---

### `test-datastore.component.ts` (74 lines) — CORRECTS the "plain fields" finding

> **CORRECTED.** The entry above read the template's `{{ displayedText }}` and
> `[disabled]="isLoading"` — no call parentheses — as evidence that this page uses
> plain mutable fields while `home` and `my-entity` use signals. **That was wrong.**
> The component holds **five** private signals and exposes them through public
> getters, so the template reads accessors, not fields. The template was
> transcribed correctly; the inference from it was not.

```ts
private readonly _payload = signal('');
private readonly _storedText = signal<string | null>(null);
private readonly _isLoading = signal(false);
private readonly _isSaving = signal(false);

get payloadValue(): string {
    return this._payload();
}

set payloadValue(value: string) {
    this._payload.set(value);
}
```

The mechanism was wrong; the underlying observation was not. There are now
**three** conventions for exposing state to a template across four pages:

| Page | Declaration | Template reads |
|---|---|---|
| `home` | `protected readonly publicText = signal('')` | `publicText()` |
| `my-entity` | `entities = signal<MyEntity[]>([])` (public) | `entities()` |
| `test-datastore` | `private readonly _payload = signal('')` + public getter/setter | `payloadValue` |

That is a weaker finding than "one page ignores signals", and it should be
recorded as such. It is also a *deliberate* pattern rather than an oversight,
which matters for how the kit should respond.

#### Why the facade exists — and the one-line replacement

The getter/setter pair is not decoration. It is what makes this work:

```html
<fusion-textarea [(ngModel)]="payloadValue"></fusion-textarea>
```

Two-way `[(ngModel)]` needs a readable **and settable** property; a bare
`WritableSignal` field cannot be banana-boxed. So the author wrapped the signal
in an accessor pair to get two-way binding back.

Angular has shipped the purpose-built answer since 17.2: **`model()`**. The
starter is confirmed on Angular ≥ 17 (`@if` / `@for` with `track`), so
`model<string>('')` almost certainly replaces `_payload` plus both accessors —
twelve lines down to one, with `[(ngModel)]` still working. Worth verifying
against the pinned Angular minor before recommending it, but if it holds this is
the single cleanest simplification available in the client, and it removes the
reason this page looks different from the others.

The three read-only getters (`displayedText`, `isLoading`, `isSaving`) have no
such excuse — they are plain signal reads behind an accessor, and exposing the
signals directly would match `home` exactly.

#### What this page gets right, and the other three do not

- **`try` / `finally` around every network call.** `loadStoredText` and
  `saveText` both set a busy flag, `await` in a `try`, and reset the flag in
  `finally`. No `catch`, so failures still propagate — which is the correct
  choice: the spinner is cleaned up and the error is not swallowed. This is the
  **only** error-adjacent handling anywhere in the client. It is still not a
  user-facing error path, so the earlier "no frontend error convention" gap
  stands; but the busy-flag discipline here is the best model in the starter and
  is what a documented convention should be built on.
- **`override ngOnInit()` + `void this.loadStoredText()`** matches `my-entity`
  exactly. One thing that *is* consistent.
- **Read-after-write**: `saveText` clears the payload and re-runs
  `loadStoredText()` rather than trusting the response. Same conservative pattern
  as `my-entity.submitEntity`.

#### Confirmed: no `OnPush` here either

`@Component` carries `imports`, `selector`, `standalone`, `templateUrl`,
`styleUrls` — no `changeDetection`. So `HomeComponent` remains the **only** page
with `ChangeDetectionStrategy.OnPush`, out of four. With signals used throughout,
`OnPush` is the correct default everywhere, and nothing states it.

#### More style divergence, in the same file

- **The `imports:` array is not alphabetised**: `CommonModule`, `FormsModule`,
  `FusionTextareaComponent`, `FusionGridCellComponent`, `FusionGridContainerComponent`,
  `FusionGridRowComponent`, `FusionButtonComponent`. `Textarea` before `GridCell`
  breaks the ordering the other three pages follow.
- **It has a trailing comma** after the last entry; the other three do not.
- **The `@fusion/ngx-fusion` import is one flat line** (six symbols, ~190
  characters) where the other three pages use the multi-line braced form.
- **`CommonModule` is imported and unnecessary again** — same as `my-entity`,
  with built-in control flow and no `CommonModule` directives in the template.
  Two of four pages carry it needlessly.
- **No trailing newline**, matching this folder's `.html` and unlike every other
  file in the starter.

Taken together — no final newline, unused imports, unsorted arrays, inconsistent
comma style — `test-datastore` looks like it is not passing through whatever
`npm run lint` actually enforces. That is worth checking directly: if `lint`
covers `src/app/**` these would be errors, so either the rules are off or the
glob misses. `.eslintrc` / `eslint.config.js` and `.prettierrc` are the files
that would settle it, and they are more valuable than another page.

#### Net effect on the earlier HIGH

The three-axis finding above stands, with axis 1 restated:

1. **State exposure** — three conventions (`protected` signal, public signal,
   private signal behind accessors). Weaker than first recorded, still real.
2. **Forms** — `ReactiveFormsModule` + typed `FormGroup` on `my-entity` vs
   `FormsModule` + `[(ngModel)]` here. Unchanged, and now confirmed from the
   `.ts` (`FormsModule` is imported explicitly).
3. **Inner layout** — `fusion-block-grid-*` vs hand-rolled `section`/`div` + SCSS.
   Unchanged.

The recommendation is unchanged and, if anything, better supported: the fix is a
documented canonical-patterns statement in `angular.instructions.md`, not more
starter pages. Three of the four divergences here are the kind a linter should
catch and evidently does not.

---

## `src/app/services/my-entities/` — `FusionHttpService`, and two real traps

`my-entities.service.ts` is 26 lines and is the most consequential client file
after `home.component.ts`, because it is the only worked example of how a
modernized app talks to its API. The spec file beside it is **empty**.

```ts
@Injectable({
    providedIn: 'root'
})
export class MyEntitiesService {
    private readonly _fusionHttp = inject(FusionHttpService);

    async get(): Promise<MyEntity[]> {
        return (await this._fusionHttp.get<MyEntity[]>('MyEntities', { useCache: false })) ?? [];
    }
```

### CONFIRMED: HTTP goes through `FusionHttpService`, not `HttpClient`

Tenth export confirmed from `@fusion/ngx-fusion`, and structurally the most
important one. No `HttpClient`, no `provideHttpClient()`, no interceptor, no
`firstValueFrom` — the whole Angular HTTP stack is replaced by a Fusion service
with a promise-based API. Relative URLs (`'MyEntities'`) imply it resolves a base
URL from Fusion config, which is presumably what `fusion.config.*.ts` supplies
per environment.

For the modernization steps this is a hard rule that nothing currently states:
**a ported service must not inject `HttpClient`.** An agent modernizing an
AngularJS `$http` or an Angular 12 `HttpClient` service will reach for
`HttpClient` by default, and it will compile, run, and even work against a
same-origin dev server — while bypassing whatever Fusion layers on top
(base URL, auth headers, caching, `actionName` auditing). That is a silent,
functional-looking wrong answer, which is the worst category.

### ⚠ HIGH — `get` and `post`/`put` take their arguments in opposite orders

```ts
this._fusionHttp.get<MyEntity[]>('MyEntities', { useCache: false });          // url first
this._fusionHttp.put(entity, `MyEntities/${entity.id}`, { actionName });      // BODY first
this._fusionHttp.post(entity, 'MyEntities', { actionName });                  // BODY first
```

`get(url, options)` but `post(body, url, options)`. Within one service, in
adjacent methods.

This is also inverted relative to Angular's `HttpClient.post(url, body, options)`,
which every agent and every developer in the building has memorised. TypeScript
will catch the straightforward transposition — passing a string where an object
body is expected — so this is not a silent-runtime-failure class defect. It is a
friction and confidence defect: people will write it backwards, get a red
squiggle, and conclude they have misunderstood the API rather than that the API
is inconsistent.

For the kit, the mitigation is cheap and does not require changing
`@fusion/ngx-fusion`: state the signatures explicitly in
`angular.instructions.md`, with these three lines as the reference. That is
exactly the kind of thing an instructions file is for, and it is currently absent.

### ⚠ HIGH — `FusionHttpService` caches GETs by default

> **REFINED to MEDIUM** after `public-text.service.ts`. Both client services
> pass `useCache: false`, so the starter models the safe behaviour consistently
> in every GET it ships. The risk is an agent writing *new* code that omits an
> option it was never told about — not one copying a bad pattern. The
> recommendation below is unchanged; the severity is not. See the
> `services/public-text` section.

```ts
this._fusionHttp.get<MyEntity[]>('MyEntities', { useCache: false })
```

The explicit `useCache: false` only makes sense if the default is `true`. So
every GET issued through Fusion without that option is served from a cache whose
TTL and invalidation rules are not visible anywhere in the starter.

This is the finding with the most direct consequences for the pipeline, and it is
worth being precise about why. The kit's central verification mechanism is
behavioural parity: characterization tests and golden-master diffs against the
legacy app (D-001 treats them as evidence). A modernized app whose reads are
transparently cached will:

- pass a first-run parity check and fail a re-run, or vice versa;
- show stale data after a write that the legacy app showed immediately;
- produce **intermittent** golden-master diffs, which are the most expensive kind
  to debug because they look like flakiness rather than a defect.

`MyEntitiesService.get()` opts out — but `save()` is followed in the component by
another `get()`, so the author clearly hit this and worked around it locally.
Nothing propagates that knowledge to anyone porting a different service.

Two concrete recommendations, in priority order:

1. State the default in `angular.instructions.md`, and make "reads that back a
   parity assertion must pass `useCache: false`" an explicit rule.
2. Consider a gate: grep ported services for `_fusionHttp.get(` without
   `useCache`, and report it. This is mechanically checkable, unlike most of the
   frontend rules, which makes it a rare candidate for a real gate rather than
   guidance.

### `actionName` is demonstrated and then never used

`save(entity: MyEntity, actionName?: string)` threads an optional `actionName`
into both write paths. `MyEntityComponent.submitEntity()` calls
`this._myEntities.save(this.entityForm.value as MyEntity)` — **no second
argument**. So the starter defines an audit/telemetry hook, plumbs it through,
and then demonstrates calling it without.

If `actionName` feeds server-side audit logging — plausible for a utility, and
consistent with the `Fusion.Fx.Logging.Providers.FusionApi` package pinned in the
API `.csproj` — then the one worked example teaches the non-compliant call. Worth
resolving before the hackathon: either the parameter is required in practice, in
which case the exemplar should pass it and the instructions should say so, or it
is genuinely optional and that should be stated too.

Small style note in the same line: `{ actionName: actionName }` rather than the
shorthand `{ actionName }`. Another divergence a linter would normally flag
(`object-shorthand`), joining the growing list.

### ⚠ MEDIUM — the spec file is empty

`my-entities.services.spec.ts` is a **zero-byte file**. The Angular CLI generates
a working `should be created` spec for every service; this one has been emptied
rather than removed.

That matters more here than it would in an ordinary repo. `.squad/decisions.md`
D-001 makes characterization tests *evidence* — they cannot be modified without a
logged intentional-behaviour-change entry — and the pipeline has explicit testing
steps driven by `testing-design-contract.instructions.md` and
`tests-commenting.instructions.md` (the Gherkin-in-comments convention:
`CaseId` / `Scenario` / `Description` / `Input` / `Expected`, then `Given` /
`When` / `Then`). An agent asked to write frontend tests to that convention has
**no worked example on the client side at all** — the starter's only spec files
are this empty one and the three page specs, which are still untranscribed and
may well be in the same state.

An empty file is also worse than no file: it satisfies a "does a spec exist"
check while providing zero coverage, and Karma will report it as a passing suite
with zero tests.

Recommendation: one real spec here, written to the kit's own Gherkin-comment
convention, would serve as the frontend testing answer key the same way
`PublicTextService` serves for the backend. Same argument as the
`common-components` page, and cheaper.

### Smaller observations

- **`providedIn: 'root'`** — standard, correct, and worth contrasting with the
  backend: `MyService` was flagged HIGH for holding a mutable
  `Dictionary<Guid, MyEntity>` in a singleton. Root-provided is fine on the
  client because this service is stateless.
- **`?? []` on the GET** means `FusionHttpService.get<T>()` can resolve
  null/undefined. Defensive and correct; also a signal that the return type is
  nullable, which a ported service should handle the same way.
- **Upsert by `entity.id` truthiness** — PUT when present, POST when not. Lines up
  with `my-entity.component.ts`, where a new entity's form has `id: null` and
  `edit()` populates it. Coherent across the two files.
- **`save()` returns the new id** and `submitEntity()` discards it in favour of a
  full refetch. Consistent with the read-after-write pattern noted elsewhere;
  fine at starter scale, wasteful at list scale.
- **The editor shows 3 unresolved diagnostics**, same `node_modules` signature as
  the other files. Not a defect in the file.

---

## `src/app/services/public-text/` — completing the vertical slice

Fifteen lines, and it closes a loop that runs the full height of the starter.

```ts
@Injectable({
    providedIn: 'root'
})
export class PublicTextService {
    private readonly _endpoint = 'PublicText';
    private readonly _fusionHttp = inject(FusionHttpService);

    async get(): Promise<PublicTextResponse> {
        return (await this._fusionHttp.get<PublicTextResponse>(this._endpoint, { useCache: false })) ?? { message: '' };
    }
}
```

### The exemplar is a complete vertical slice, and it is the starter's best asset

The `PublicText` name now appears at four layers, each a small, clean, fully
worked example of its tier:

| Layer | File | Notes |
|---|---|---|
| API controller | `Starter.Web.Api/Controllers/PublicTextController.cs` | 43 lines, the backend exemplar |
| Domain service | `Starter.Library/Services/PublicTextService.cs` | 22 lines, full XML docs, stateless, `CancellationToken` |
| Response DTO | `Starter.Web.Api/Models/PublicTextResponse.cs` ↔ `src/app/types.ts` | same type name both sides |
| Client service | `src/app/services/public-text/public-text.service.ts` | 15 lines, this file |
| Page | `src/app/pages/home/home.component.ts` | calls it on a button click |

That is a request travelling from a Fusion page, through `FusionHttpService`, to
a Fusion-hosted controller, into a stateless domain service, and back — in about
95 lines total, with no dead code and nothing that contradicts anything else in
the slice.

This is worth stating plainly because most of the recent findings have been about
inconsistency: **this slice is the part of the starter that works as an answer
key, end to end.** If the kit's frontend instructions need one thing to point
agents at, it is this chain, named explicitly. The `My*` chain
(`MyEntitiesController` → `MyService` → `my-entities.service.ts` →
`my-entity.component.ts`) is the richer example but carries the singleton-state
HIGH on the backend and the forms/layout divergences on the front. `PublicText`
carries nothing.

### REFINED: the caching finding is a documentation gap, not an exemplar defect

Both client services pass `useCache: false`:

```ts
this._fusionHttp.get<PublicTextResponse>(this._endpoint, { useCache: false })   // public-text
this._fusionHttp.get<MyEntity[]>('MyEntities', { useCache: false })             // my-entities
```

Two for two. That raises the earlier inference — that `FusionHttpService`
defaults to caching GETs — from likely to near-certain, and it also **corrects the
tone of the earlier entry**. The starter does not model the risky behaviour; it
models the safe one, consistently, in every GET it ships.

So the finding narrows. It is not "the exemplar teaches a parity hazard". It is:

- the exemplar does the right thing **without saying why**, and
- nothing in any instructions file mentions the default, so a ported service that
  simply omits the option inherits caching silently.

That is still worth fixing, and the fix is unchanged — state the default in
`angular.instructions.md`, and add the grep gate for `_fusionHttp.get(` without
`useCache`. But the severity drops: the risk is an agent writing *new* code that
omits an option it was never told about, not an agent copying a bad pattern. Down
from HIGH to MEDIUM.

### The two services disagree on one small thing

`PublicTextService` names its route in a private field:

```ts
private readonly _endpoint = 'PublicText';
```

`MyEntitiesService` inlines the string three times (`'MyEntities'`,
`` `MyEntities/${entity.id}` ``, `'MyEntities'`). Trivial in isolation, and the
`_endpoint` version is clearly the better of the two — but it is one more entry
on the list of "the starter shows two ways and adjudicates neither", which is now
long enough to be the dominant theme of this review rather than a collection of
nits.

### Smaller observations

- **DTO names match across the language boundary.** `PublicTextResponse` is the
  C# model name and the TypeScript type name, unchanged. Same for `MyEntity`.
  This is a genuinely useful convention for the pipeline — it makes the
  `endpoint-inventory` and `component-map` artifacts able to key on a single
  identifier across both sides of the hourglass — and, like most of the good
  conventions found so far, it is nowhere written down.
- **`?? { message: '' }`** is the null-object default, matching `?? []` in
  `MyEntitiesService`. Consistent, and consistent with `FusionHttpService.get<T>()`
  being able to resolve null.
- **Both services are `providedIn: 'root'`, stateless, and hold no cache of their
  own** — the correct shape, and a useful contrast with the backend `MyService`,
  which was flagged HIGH for keeping a mutable `Dictionary<Guid, MyEntity>` in a
  singleton.
- **No spec file was mentioned for `public-text/`.** `my-entities/` has one (empty).
  Whether `public-text/` has none at all, or one that was not photographed, is
  unknown — recorded as a question, not a finding.

---

## `src/app/` root — bootstrap, providers, and the Okta config

Five files: `app.component.{html,ts,spec.ts}`, `app.config.ts`, and
`fusion.config.base.ts`. **`fusion.config.base.ts` carried live Okta
identifiers; both are redacted in the committed copy** — see the security
section below.

### RETRACTED: "no `HttpClient`, no `provideHttpClient()`, no interceptor"

> The `services/my-entities` entry above states that the Angular HTTP stack is
> replaced wholesale by `FusionHttpService`, with **"no `HttpClient`, no
> `provideHttpClient()`, no interceptor, no `firstValueFrom`"**. The first three
> are **wrong**. `app.config.ts` line 25:
>
> ```ts
> provideHttpClient(withFetch(), withInterceptors([FusionHttpFromApiDateConverterInterceptorFn])),
> ```
>
> `HttpClient` **is** provided, with the fetch backend and a Fusion interceptor.
> `FusionHttpService` wraps it rather than replacing it. I inferred the app-level
> arrangement from two service files that never mention `HttpClient`, which was
> not evidence of its absence.

What survives, and is still the useful rule: **application code goes through
`FusionHttpService`, not `HttpClient` directly.** A ported service that injects
`HttpClient` bypasses the base URL, the caching layer, the `actionName` plumbing
and the date interceptor — it just does so by skipping a wrapper, not by
reaching for something the app does not provide.

The interceptor is itself a modernization rule worth stating:
`FusionHttpFromApiDateConverterInterceptorFn` converts API dates centrally, so
**per-service date parsing in a legacy app should be deleted, not ported.** An
agent that faithfully carries across `new Date(dto.someDate)` will be
double-converting.

### CONFIRMED: `fusion-mcp-restructure.instructions.md` was right

```ts
provideNgxFusion(),
provideNgxFusionAuthOAuthOkta(),
```

Both present, exactly as that instructions file claimed, with the Okta provider
coming from a **separate package**, `@fusion/ngx-fusion-auth-oauth-okta`.

Recording this because the earlier `pages/common-components` entry said that
file's claims "were not something to take on trust", on the grounds that
`fusion-auth-standards.md` had been found describing backend code that does not
exist. That caution was reasonable about `fusion-auth-standards.md` and
**over-applied** to `fusion-mcp-restructure.instructions.md`, which is accurate.

### The app shell, and a partial answer to the "no error handling" gap

```html
<fusion-app
    [errorDisplayDuration]="5000"
    [messageDisplayDuration]="10000"
>
    <fusion-header label="Fusion Starter" />
    <fusion-footer />
</fusion-app>
```

Three more components (`FusionAppComponent`, `FusionHeaderComponent`,
`FusionFooterComponent`), taking the demonstrated inventory to **twelve**.

More importantly, `[errorDisplayDuration]` and `[messageDisplayDuration]` mean
**Fusion provides a global error/message surface at the app shell**. That
partially answers the "no frontend error convention" gap recorded earlier: the
surface exists. The gap narrows to — *no page uses it*. None of the four pages
raises an error into it, and nothing documents how. Still worth closing, but the
missing piece is a convention and one worked example, not infrastructure.

Also of note for the modernization steps:

- **`withDisabledInitialNavigation()`** — routing is deliberately deferred until
  after initialization (i.e. auth bootstrap) completes. A ported app that
  navigates or reads route state during startup will behave differently here than
  it did in the legacy app. The source comments this, which is good.
- **`UrlSerializer` is replaced by `FusionUrlSerializer`.** Any legacy code doing
  manual URL parsing or serialisation is now going through Fusion's rules.
- **`PACKAGE_INFO` is `import * as pack from '../../package.json'`**, which
  requires `resolveJsonModule` in `tsconfig` — a build setting a ported project
  must not lose.
- **`provideRouter(routes.routes, …)` alongside `useValue: routes`** means
  `routes.config.ts` exports an object with a `.routes` property, and Fusion
  consumes the *whole* object while Angular consumes only the array. So Fusion
  gets richer route metadata (nav labels, permissions?) than the router does.
  `routes.config.ts` is now high on the outstanding list.

---

### ⚠ HIGH (security) — live Okta client ID and tenant issuer in the base config

`fusion.config.base.ts` shipped a real `clientId` and a real `issuer` tenant URL.
Both are replaced with `<OKTA_CLIENT_ID>` and `<OKTA_ISSUER_URL>` in the
committed copy. The `https://localhost:5001/...` redirect and logout URLs are
localhost and were kept verbatim.

This is the **second** file to do this — `Starter.Web.Api/appsettings.json` was
flagged for the same thing (Okta ClientId, tenant URL, AD groups, corporate
domains, an OpenShift hostname, internal CIDRs). The recommendation there was
placeholders resolved from `kit-params.md` at the Step 2 rename; it now applies
to the client too, and the case is stronger because the hackathon multiplies it:

A public SPA client ID is not a secret in the cryptographic sense — it is visible
in any browser. The problem is **operational**. Every participant who clones the
starter points at the *same* Okta application. That application's allowed
redirect URIs, grant types, and scope grants are a single shared mutable
resource. One participant adding a redirect URI, or an admin tightening the app
during the event, affects every other participant simultaneously. That is a
same-day outage waiting for a room full of people, and it is invisible until it
happens.

### ⚠ HIGH — `devMode: true` and `isDebug: true` are in the *base* config

> **CONFIRMED.** `fusion.config.prd.ts` overrides `isDebug` but not `auth`, and
> the spread is shallow — so production inherits `auth.devMode: true`, the base
> client ID, and `https://localhost:5001/...` redirect URIs. `qa`, `uat` and the
> default config inherit the same. Full detail in the `fusion.config.*` section.

```ts
devMode: true,
…
isDebug: true,
```

`fusion.config.base.ts` is the file the five environment configs
(`.dvl`, `.qa`, `.uat`, `.prd`, and the unsuffixed default) spread. Unless
`fusion.config.prd.ts` explicitly overrides **both**, production ships with
Fusion's dev mode and debug output enabled.

Defaults belong at their safest value, with environments opting *up*, not down —
a `prd` config that forgets one line should degrade to secure, not to debug.
**This cannot be confirmed without `fusion.config.prd.ts`, which is now the
single highest-priority outstanding file in the client.** Recorded as a
must-check, not a confirmed defect.

### ⚠ MEDIUM (security) — Okta Management API scopes requested from a browser client

```ts
'okta.clients.read',
'okta.groups.read',
'okta.myAccount.profile.read',
'okta.profileMappings.read',
'okta.userTypes.read',
'okta.users.read',
'okta.users.read.self'
```

The first seven scopes (`openid` … `groups`) are ordinary OIDC. The `okta.*`
entries are **Okta Management API** scopes. `okta.users.read` is directory-wide
read across the tenant; `okta.groups.read`, `okta.clients.read`,
`okta.profileMappings.read` and `okta.userTypes.read` are similarly
administrative.

Requesting them does not by itself grant them — the Okta application must be
authorised for each. But a starter template requests the *minimum*, and this one
requests directory read by default, in a token delivered to a browser, in a file
every participant will clone and never revisit. If the tenant does grant them,
every modernized app in the hackathon carries tenant-wide directory read it has
no use for. `okta.users.read.self` is the only one an app like this plausibly
needs.

Recommendation: strip the `okta.*` scopes from `base`, and let any app that
genuinely needs one add it in its own config with a comment saying why.

### ⚠ MEDIUM — the frontend test suite is a placebo

```ts
describe('Dummy', () => {
    beforeEach(async () => {
        await TestBed.configureTestingModule({}).compileComponents();
    });

    it('should create', () => {
        return;
    });
});
```

That is `app.component.spec.ts` in full. It is named `Dummy`, it configures an
**empty** `TestBed`, it never instantiates `AppComponent`, and its single test
body is `return;`. It asserts nothing. Together with the zero-byte
`my-entities.services.spec.ts`, the starter's demonstrated frontend testing
practice is: **one empty file and one vacuous pass.**

This escalates the earlier MEDIUM, and it collides with the kit's own gates. The
Dominion rubric requires **coverage ≥ 80%** and *review complete = 100% of files
plus every category judged*; D-001 makes characterization tests evidence that
cannot be modified without a logged decision. So the kit needs an answer to a
question it currently does not address:

- If the coverage gate applies to `Starter.Web.Client`, **the starter fails its
  own gate** — a suite of one assertion-free test cannot reach 80%.
- If it does not apply, that exemption is nowhere stated, and every participant
  will discover it independently and draw their own conclusion about whether
  frontend tests matter.

Either answer is defensible; the silence is not. And an assertion-free test is
worse than no test, because Karma reports it as a passing suite and any
"do specs exist" check is satisfied.

The fix is the same shape as before and still cheap: one real spec — ideally on
`public-text.service.ts`, written to the kit's own Gherkin-comment convention
(`CaseId` / `Scenario` / `Description` / `Input` / `Expected`, then `Given` /
`When` / `Then`) — turns the frontend testing step from invention into imitation.

---

### ⚠ MEDIUM — an "unused" import that a linter will delete and break the build

```ts
import { FusionConfig } from '@fusion/ngx-fusion';
import {} from '@fusion/ngx-fusion-auth-oauth-okta';
```

The second import has **empty braces**. It is a module-augmentation import: it
pulls in the declaration merging that adds the `auth` property to `FusionConfig`.
Without it, the `auth: { … }` block below does not typecheck.

It also looks exactly like dead code. `no-empty-pattern`, `no-unused-vars`, and
most "organize imports" autofixes will remove it, and the failure will surface as
a confusing type error on `auth` in a different part of the file. Given that the
kit runs `npm run lint` on every build and instructs agents to satisfy analyzers
and clean up unused code, this is a live trap.

One comment line above it (`// module augmentation — do not remove`) costs
nothing and prevents an afternoon of confusion.

### Smaller observations

- **`app.component.ts` orders `styleUrls` before `templateUrl`** — strict
  alphabetical. All four page components do `templateUrl` first. The root
  component of the app disagrees with every page in it. This is now the fourth
  distinct `@Component` member-ordering variant found, and the strongest single
  argument for writing the convention down rather than hoping it propagates.
- **`AppComponent` is an empty class** (`export class AppComponent {}`) with no
  base class — unlike every page, which extends `FusionPageBaseComponent`. Correct
  (it is a shell, not a page), and worth stating so agents do not extend it.
- **`app.config.ts` puts the Okta provider import last**, after the two relative
  imports, breaking the package-imports-then-relative-imports grouping the rest of
  the file follows. Cosmetic; consistent with everything else about this codebase.
- **`createProviders()` builds an array and returns it** rather than returning the
  literal. Harmless, and gives an obvious place to add conditional providers —
  possibly the intent.
- **`api.baseUrl: ''`** in base, so the API is same-origin by default and the
  environment configs presumably override it. Consistent with the relative
  `'MyEntities'` / `'PublicText'` URLs in the two services.

---

## The five `fusion.config.*` files — CONFIRMED: production inherits `devMode: true`

All five environment configs plus `routes.config.ts` and `types.ts` are now
transcribed. Four files carried live corporate identifiers; all are redacted (see
the uncertainties section).

### ⚠ HIGH (confirmed) — `fusion.config.prd.ts` overrides `isDebug` but not `auth`

This was recorded as a must-check against `fusion.config.base.ts`. It is now
confirmed, and the mechanism is worse than the flag suggested.

```ts
export const fusionConfig: FusionConfig = {
    ...fusionConfigBase,
    api: {
        baseUrl: '/api'
    },
    isDebug: false
};
```

Ten lines. `isDebug: false` **is** overridden — so the author knew the base was
dev-shaped and remembered to fix the top-level flag. But the spread is
**shallow**, and `devMode` lives one level down, inside `auth`. Nothing replaces
`auth`, so production inherits the *entire* base auth block:

| Setting | Value production actually gets | From |
|---|---|---|
| `auth.devMode` | **`true`** | base — not overridden |
| `auth.clientId` | the base (non-prod) client ID | base |
| `auth.issuer` | the base tenant | base |
| `auth.redirectUri` | **`https://localhost:5001/login/callback`** | base |
| `auth.logoutUrl` | **`https://localhost:5001/logout/callback`** | base |
| `auth.scopes` | all seven `okta.*` Management API scopes | base |

A production build whose OAuth redirect URI is `localhost:5001` cannot complete a
sign-in against a real host. So either `prd` is not actually used, or something
outside these files rewrites `auth` at deploy time, or production authentication
is broken. All three possibilities are worth knowing, and none of them is
visible in the source.

Compare `fusion.config.dvl.ts`, which replaces the **whole** `auth` object —
`authenticateOnStart`, `clientId`, `cookies`, `devMode`, `issuer`, `logoutUrl`,
`pkce`, `redirectUri`, `scopes`, `signInAttempts`, all of it. So the pattern the
starter demonstrates *once* is "replace `auth` entirely", and the pattern it
demonstrates for **production** is "don't touch it".

`qa`, `uat` and the default `fusion.config.ts` are the same nine-line shape as
`prd` minus the `isDebug` line — they override only `api.baseUrl`, so they too
inherit `devMode: true`, the base client ID, and the localhost redirects.

**The structural fix is the finding.** Shallow-spread inheritance over a nested
config object is a footgun that will be copied into every modernized app, because
`fusion.config.*.ts` is exactly the kind of file an agent clones and edits.
Either:

1. put the *safe* values in `base` (`devMode: false`, `isDebug: false`, no
   client ID, no redirect URIs) and make every environment opt **up**; or
2. deep-merge in a helper (`mergeFusionConfig(base, overrides)`) so a nested key
   cannot be silently inherited; or
3. at minimum, have `prd` spell out the full `auth` block the way `dvl` does.

Option 1 is the cheapest and the most robust: a config file that forgets a line
should fail closed.

### `fusion.config.dvl.ts` also carries a commented-out duplicate auth block

Lines 23-32 are a commented copy of the same ten settings pointing at a different
tenant and a different internal host — a previous environment left in place. It
is dead weight in the one file an agent will read to learn how environments work,
and it doubles the number of Okta identifiers in the repo. Deleting it costs
nothing (git has the history) and removes the ambiguity about which block is
live.

Also `// const apiBaseUrl = ...` on line 5, commented, unused.

---

## `routes.config.ts` — and Kendo is confirmed as a real dependency

```ts
import { codeIcon, formElementIcon, homeIcon } from '@progress/kendo-svg-icons';
```

**This is the first hard evidence that Kendo is actually used**, not just
referenced by `angular.instructions.md`'s licence patch. `index.html` corroborates
it independently: `<body class="k-body ffx-body">` and
`<span class="k-icon k-i-loading …">` are Kendo classes, and the comment above
them reads *"These classes are necessary for correct styling, do not remove
them"*.

That closes a loop opened several batches ago. The chain is now:
`@progress/kendo-svg-icons` is a real dependency → `angular.instructions.md`
documents a `\b174733\d{4}\b` regex patch against
`node_modules/@progress/kendo-licensing` → `tools.mjs`'s `installSafePackages()`
re-runs suppressed lifecycle scripts for allow-listed packages →
`npm-safe-package-installs.mjs` holds that allow-list. **That last file is still
untranscribed and is the only thing standing between hypothesis and confirmation**
that the Kendo licence activation is automated on every install. It remains the
highest-value untranscribed file in the client.

### The Fusion route shape

```ts
export const routes: FusionRoutes = {
    routes: [
        {
            path: 'home',
            component: HomeComponent,
            menu: {
                icon: homeIcon,
                label: 'Home',
                routerLink: 'home'
            }
        },
```

This explains the `provideRouter(routes.routes, …)` / `useValue: routes` pairing
in `app.config.ts`: Angular gets the array, Fusion gets the whole object and reads
the `menu` metadata off each route to build navigation. So **adding a page to a
modernized app means adding a `menu` block, not just a route** — a rule an agent
will not infer from Angular knowledge, and one nothing states.

Two smaller things:

- **Eager and lazy routes are mixed with no rule.** `home` and
  `common-components` use `component:`; `test-datastore` and `my-entity` use
  `loadComponent: () => import(…)`. Same file, four routes, two strategies. This
  is the same shape as every other divergence recorded in this review.
- **No route guards at all.** No `canActivate` anywhere. Protection presumably
  comes from Fusion's auth layer plus `withDisabledInitialNavigation()`, but the
  starter demonstrates no way to protect a route, and `MyEntitiesController` on
  the backend carries `[Authorize(Policy = "User")]`. An agent porting a legacy
  app with per-page authorisation has no worked example to follow.
- `// This stays at the bottom` above the `**` wildcard is a good comment; the
  wildcard `redirectTo: 'home'` means unknown URLs silently land on home rather
  than showing a 404 — worth knowing for parity work, since most legacy apps do
  show something.

---

## `types.ts` — nine lines, and it resolves an earlier caution

```ts
export interface MyEntity {
    id: string | null;
    name: string | null;
    description: string | null;
}
```

The `my-entity` entry above flagged `this.entityForm.setValue(entity)` as strict
and therefore fragile. The form group is
`{ id, name, description }` all `FormControl<string | null>`, and `MyEntity` is
`{ id, name, description }` all `string | null`. **They match exactly**, so
`setValue` is correct today. The caution was appropriately hedged ("lines up
today"); recording the resolution so it is not carried forward as an open issue.
The `patchValue` recommendation still holds as the more durable choice, but it is
a preference, not a defect.

Worth noting the client type is **looser than the server's**: C# `MyEntity` has
`Id` as a non-nullable `Guid` and `Name` as `required string`, while the client
allows `null` for both. That asymmetry is correct for a form-backed model — but
it means the API can reject a payload the client type accepts, and there is no
shared contract enforcing it. For the kit, this is an argument for the
`endpoint-inventory` artifact to carry nullability, not just names.

---

## `src/styles.scss` — RESOLVES the undefined-class question, in the worst way

```scss
@use '@fusion/theme' as ffx with (
    $dark-logo-url: null,
    $light-logo-url: null
);
@use '@fusion/theme/auth-negotiate' as ffx-auth-negotiate;

@include ffx.main();
@include ffx-auth-negotiate.main();
```

Eight lines. It defines **no application classes at all** — it is purely a Fusion
theme entry point.

This has been an open question for several batches: `title-banner` (used by
`common-components` and `my-entity`), and `datastore-page`, `panel-row`, `panel`,
`subtitle`, `value-wrapper`, `value`, `loading` (used by `test-datastore`, whose
own SCSS defines only `panel-actions`). The answer is that **none of them are
defined in application code.** They are either provided by `@fusion/theme` or
they are dead selectors that style nothing.

The starter provides no way to tell which. That is the concerning part: an agent
doing a UI port will copy `class="title-banner"` onto new pages because the
exemplar does, and it will either work (Fusion theme class) or silently do
nothing (dead). Both outcomes look identical in code review.

**Recommendation:** whoever owns `@fusion/theme` can answer this in five minutes,
and the answer belongs in `angular.instructions.md` as a short list of
theme-provided class names an app may use. Until then, treat every custom class
in the starter as unverified.

A second useful fact: `@fusion/theme/auth-negotiate` is a separate theme entry
point that must be `@include`d alongside the main one. A ported app that writes
its own `styles.scss` and forgets this line will render the auth screens
unstyled — a subtle, visual-only failure that the dual-port parity gate would
catch but a code review would not.

---

## `index.html` — and a real bug in the theme bootstrap

### ⚠ MEDIUM — the light-mode branch removes the wrong class

```js
if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
    window.document.documentElement.classList.add('dark-theme');
} else {
    window.document.documentElement.classList.remove('light-theme');
}
```

The branches are asymmetric and the `else` is almost certainly wrong. In dark
mode it **adds** `dark-theme`; in light mode it **removes** `light-theme` — a
class nothing ever added. The `else` is a no-op, and `dark-theme` is never
removed.

On a fresh page load this happens to work, because the document starts with
neither class. It breaks the moment anything re-runs the logic or toggles the
system theme without a reload: `dark-theme` sticks. Given `fusion.config.base.ts`
sets `theme: 'system'`, following the OS setting is the intended behaviour, so
this is on the path that matters.

The likely intent is `remove('dark-theme')` or `add('light-theme')`. Which one
depends on how `@fusion/theme` defines its selectors, so this needs confirming
rather than patching blind.

Why it is worth flagging beyond the bug itself: the kit's **visual-parity gate**
diffs screenshots of legacy and modern apps. A theme class that can stick across
navigations is exactly the kind of thing that produces a parity diff that
reproduces on one machine and not another — the intermittent failure mode that
costs the most time to chase.

**And it is CSP-pinned.** `web.config` hashes this exact script:

```
script-src 'self' 'sha256-7daDqN4VRQh0Jed62Nemj1b+0JoyPt9aRhwwK3+CGhk='
```

So fixing the bug **breaks the Content-Security-Policy** unless the hash is
recomputed in the same commit. That is a genuine trap, and the source does
comment it (*"sha256 hash is for the script in index.html to update the theme
class"*) — but the comment is in `web.config`, and the person editing
`index.html` will not be looking there. A matching comment above the script in
`index.html` would cost one line.

### Smaller observations

- The `<base href="/">` TODO comment documents the sub-path deployment case
  (`--serve-path=/logs/`), which is real, useful, and the kind of thing a
  modernized app deployed under a path prefix will need.
- `<noscript>` message present; `Loading&hellip;` spinner uses Kendo's
  `k-i-loading` icon inside `<app-root>` so there is a pre-bootstrap loading
  state. Both good, both worth preserving in ports.

---

## `src/web.config` (156 lines) — the client's IIS configuration

Three corporate domains in the CSP `connect-src` are redacted. The file is
otherwise transcribed verbatim and validates as XML.

### The CSP is the most security-conscious artefact in the starter

`default-src 'self'` with explicit `connect-src`, `font-src`, `img-src`,
`script-src` and `style-src`, a hash-pinned inline script rather than
`'unsafe-inline'` for scripts, and `Referrer-Policy: strict-origin-when-cross-origin`.
That is a materially better posture than most internal apps ship with, and it
deserves saying plainly after a long run of findings.

Three gaps worth noting rather than treating as defects:

- **`style-src` allows `'unsafe-inline'`.** Angular injects component styles
  inline, so this is effectively required without nonce plumbing. Expected, but
  it is the one weak directive and a reviewer will ask.
- **No `frame-ancestors`,** so clickjacking protection depends on an
  `X-Frame-Options` header set elsewhere (not in this file).
- **No `object-src 'none'`** and no `base-uri 'self'`; both are cheap additions
  that CSP linters flag.

### `<location path="firebase">` is vestigial

Under *"Disable cache on non-hashed files"*, alongside `index.html`,
`manifest.webmanifest`, `ngsw-worker.js`, `ngsw.json`, `safety-worker.js` and
`worker-basic.min.js` — all Angular service-worker artefacts — sits a
`firebase` path. Nothing else in the starter references Firebase. It is almost
certainly carried over from an older template. Harmless, but it is the kind of
thing an agent asked to "modernize the deployment config" will spend time
reasoning about.

Note also that the six service-worker paths are configured while nothing
transcribed so far enables `@angular/service-worker`. Either the PWA setup is
elsewhere (`angular.json`, `package.json`) or these rules are aspirational.

### Smaller observations

- **`anonymousAuthentication enabled="true"`** here, versus
  `windowsAuthentication enabled="true"` in the **API's** `web.config` (flagged
  earlier). That combination is coherent — the SPA is served anonymously and the
  API authenticates — and it retroactively softens the earlier concern about the
  API's Windows auth: the two files are describing different tiers, not
  contradicting each other.
- The commented rewrite condition contains a literal `{REPLACE WITH CLIENT URL}`
  placeholder. It is inside a comment so it cannot break a build, but it is
  another instance of a value the kit should be resolving from `kit-params.md`.
- Cache policy is sensible: a day on `assets` and `favicon.ico`, `no-store` on
  every non-hashed file.

---

## `Starter.Web.Client/tmpt/.npmrc` — seven lines, and the worst line in the kit

```
; begin auth token
registry=https://<SONATYPE-NPM-HOST>/repository/npm-org/
@fusion:registry=https://<SONATYPE-NPM-HOST>/repository/fusion-npm/
engine-strict=true
ignore-scripts=true
strict-ssl=false
; end auth token
```

The Sonatype host is redacted (same placeholder as `tools.mjs`). **No token is
present in the file** — the `; begin auth token` / `; end auth token` markers
delimit a region something else populates, and what sits between them here is
plain configuration.

### ⚠ HIGH (security) — `strict-ssl=false` disables TLS verification for every install

This is the single most serious line found in the kit so far, and it deserves to
be stated plainly.

`strict-ssl=false` turns off certificate validation for **all** npm traffic. Every
package tarball, every metadata request, every `npm ci` on every developer
machine and every CI agent is fetched over a connection whose peer is not
verified. Anything able to intercept that traffic can substitute package
contents, and npm will install them without complaint.

What makes it worth escalating rather than noting:

1. **It is in a starter that every hackathon participant clones.** One bad
   default replicated across a few hundred repositories, each running `npm ci` on
   a corporate network, is a materially different risk from one team's local
   workaround.
2. **It directly undercuts the file's own security posture.** `ignore-scripts=true`
   two lines above is a deliberate, well-judged supply-chain control — lifecycle
   scripts off by default, re-enabled one allow-listed package at a time through
   `installSafePackages()`. That control assumes you received the package you
   asked for. `strict-ssl=false` removes exactly that assurance. The file hardens
   against a malicious `postinstall` while disabling the check that the tarball
   came from Sonatype at all.
3. **The usual cause has a correct fix.** `strict-ssl=false` is almost always
   added because a TLS-inspecting corporate proxy presents a certificate Node
   does not trust. The supported remedies are `cafile=<path to corporate CA
   bundle>` in `.npmrc`, or `NODE_EXTRA_CA_CERTS` in the environment. Both keep
   verification on. Neither is more than a one-line change, and whoever
   administers the Sonatype proxy will already have the CA bundle.

Recommendation: replace `strict-ssl=false` with `cafile=`, and if that cannot be
arranged before the hackathon, at minimum move the line out of the template and
into a documented per-machine opt-out so it is a deliberate act rather than an
inherited default.

### CONFIRMED: `ignore-scripts=true`, and the `installSafePackages` inference was right

The `services`-era entry on `tools.mjs` reasoned that
`installSafePackages()`'s per-package `--ignore-scripts false` "only makes sense
if `ignore-scripts=true` is set globally in `.npmrc`", and called that a good
supply-chain posture the kit documents nowhere. **Both halves are confirmed.**
The global setting is here, and it is still documented nowhere.

That also sharpens the remaining Kendo question. The mechanism is now fully
traced except for one file:

```
.npmrc: ignore-scripts=true          <- confirmed here
   -> tools.mjs installSafePackages() runs `npm run <script> --ignore-scripts false`
        for each key in safePackageInstalls
      -> npm-safe-package-installs.mjs holds that map   <- STILL UNTRANSCRIBED
```

If `@progress/kendo-licensing` is a key in that map, the licence patch from
`angular.instructions.md` is automated on every install and update. Everything
except that one file now points that way.

### CONFIRMED: two registries, and `@fusion/*` needs its own line

```
registry=…/repository/npm-org/
@fusion:registry=…/repository/fusion-npm/
```

Public packages proxy through `npm-org`; the `@fusion/*` scope resolves from a
separate `fusion-npm` repository. A modernized app that carries over only the
default `registry=` line will fail to install `@fusion/ngx-fusion`,
`@fusion/theme`, and `@fusion/ngx-fusion-auth-oauth-okta` — with a 404 that looks
like a typo rather than a missing scoped-registry line. Worth one sentence in
`angular.instructions.md`; it is the kind of thing that costs a participant an
hour on day one.

### `engine-strict=true` — the Node version *is* pinned after all

The `scripts/` entry noted that `getFullPath` relies on `entry.parentPath`
(Node ≥ 20.12 / ≥ 21.4) and recorded this as "an undeclared minimum-Node
constraint" that `pins.json` does not cover. `engine-strict=true` means npm
**enforces** whatever `engines` range `package.json` declares — installs hard-fail
on a mismatched Node rather than warning.

So the constraint is very likely declared and enforced; it simply is not visible
in anything transcribed so far. `package.json` settles it, and this raises that
file's priority: it now carries the Node/npm range, the `@fusion/*` versions, and
the script definitions that `pre-build.mjs` shells into.

### Where this file sits, and why that matters for the ENOENT finding

The breadcrumb reads `src > Starter.Web.Client > tmpt > .npmrc` — so this is
**not** at the client root. `tools.mjs`'s `npmAuth()` reads
`path.join(projectDirectory, '.npmrc')` with `projectDirectory` defaulting to
`'./'`, and every call site invokes `npmAuth()` with no arguments. It therefore
looks for `.npmrc` at the **client root**, not in `tmpt/`.

The natural reading — `tmpt` being a template directory whose contents are copied
or rendered into place, with the `; begin auth token` / `; end auth token`
markers marking where a token gets spliced in — supports the earlier HIGH:

> `npmAuth` reads `.npmrc` with an unguarded `readFile`. No `.npmrc` means an
> unhandled `ENOENT` on the first statement of `npm start`.

If the root `.npmrc` is generated from this template, then a fresh clone that has
not yet run whatever does the generating has no root `.npmrc`, and `npm start`
dies with a missing-file stack trace pointing at the wrong problem. That is now a
plausible *mechanism* rather than a hypothetical.

**Not asserted:** a root `.npmrc` may well exist and simply not have been
photographed — hidden files did not appear in the file-tree image. What would
settle it is a listing of `Starter.Web.Client/` including dotfiles, or the
`.gitignore`. Both are worth having.

---

## Client root `.npmrc` and `.dockerignore` — two open questions closed, one opened

### RESOLVED (downgrade) — the root `.npmrc` exists, so the ENOENT path is much narrower

```
registry=https://<SONATYPE-NPM-HOST>/repository/npm-org/
@fusion:registry=https://<SONATYPE-NPM-HOST>/repository/fusion-npm/
engine-strict=true
ignore-scripts=true
strict-ssl=false
```

Five lines at `Starter.Web.Client/.npmrc` — **the exact path
`npmAuth()` reads** (`path.join('./', '.npmrc')`). The earlier HIGH:

> `npmAuth` reads `.npmrc` with an unguarded `readFile`. No `.npmrc` means an
> unhandled `ENOENT` on the first statement of `npm start`.

**is downgraded to MEDIUM.** The file is present at the client root, so the
common case — clone and run `npm start` — works. I recorded that risk before
seeing this file and after seeing only the `tmpt/` copy, and the inference that
the root file might be generated rather than committed was wrong.

What survives is narrower and still worth fixing: the `readFile` is unguarded, so
the failure mode exists for anyone whose `.npmrc` is absent — and `.npmrc` is a
conventionally-gitignored filename, so a participant who copies the starter into
a repo with a stock Node `.gitignore` will lose it and get an ENOENT stack trace
pointing at the wrong problem. A three-line `existsSync` guard still closes it,
but this is a robustness improvement, not a broken first run.

**The two `.npmrc` files differ, which explains `tmpt/`.** The root copy has no
`; begin auth token` / `; end auth token` markers and no token; the `tmpt/` copy
has the markers wrapping the same five settings. The natural reading is that
`tmpt/` is the template a build step renders with credentials spliced into the
marked region, while the root file is the credential-free version committed for
local development. That is a sensible split and worth stating, because an agent
that "tidies up the duplicate `.npmrc`" would break the credentialed build path.

`strict-ssl=false` appears in **both** copies. The HIGH recorded against it is
unaffected — if anything it is reinforced, since the setting is present in the
committed developer config *and* in whatever the build renders.

### CONFIRMED — `cert.pem` and `cert.key` are known about, but only by Docker

`.dockerignore` (16 lines) lists them explicitly:

```
dist
coverage
cert.pem
cert.key
Dockerfile
.dockerignore
```

The `pre-start.mjs` entry flagged that
`dotnet dev-certs https --export-path ./cert.pem --format Pem --no-password`
writes an **unencrypted private key** into the client working tree on every
`npm start`, and asked whether `.gitignore` covers it.

This is **not** that answer. `.dockerignore` keeps the key out of the Docker build
context — a genuinely good call, and evidence that someone knew these files get
produced — but it has no bearing on what git tracks. **The `.gitignore` question
is still open**, and it is now the more interesting of the two, because we know
the risk was recognised in one place. If it was handled in both, the finding
closes entirely; if only here, then the person who thought about it stopped one
file short.

### NEW — the client has a second, containerised deployment path

Two artefacts point at it:

- `.dockerignore` line 15 excludes a **`Dockerfile`**, so one exists.
- A path tooltip in the same screenshot reads
  `…\src\Starter.Web.Client\default.conf` — the conventional filename for an
  **nginx** server block.

So the client is deployed at least two ways: IIS via `src/web.config`, and a
container serving through nginx. The `fusion.config.dvl.ts` callback hosts
(OpenShift `ocp.` subdomains, before redaction) and the API's already-transcribed
`entrypoint.sh` both suggest the **container path is the real one** for deployed
environments, with `web.config` covering IIS or local hosting.

That has a direct consequence for something recorded two sections ago. The
`web.config` entry called its Content-Security-Policy *"the most
security-conscious artefact in the starter"* — `default-src 'self'`, a
hash-pinned inline script, `Referrer-Policy`. **All of that lives in the IIS
config.** If deployed environments serve through nginx, those headers apply only
if `default.conf` sets them too, and nothing transcribed so far shows that it
does.

I am not claiming the container path is unprotected — I have not seen
`default.conf`. But the question is now concrete and worth answering before the
hackathon: *do the CSP and `Referrer-Policy` headers exist on the path production
actually uses, or only on the one it does not?* A starter that ships a strong
policy on the unused path and nothing on the used one is worse than either
alone, because a reviewer reading `web.config` will conclude the app is covered.

**`default.conf` and the client `Dockerfile` are now the two files I would ask
for next**, ahead of `package.json` — they decide whether a real security control
is in force.

### Smaller observations

- `.dockerignore` excludes `**/bin` and `**/obj` — the MSBuild directories, in a
  *client* project. Consistent with `build.mjs` hand-creating `obj/Debug`: the
  .NET and Angular builds share this directory tree, and the container build
  correctly refuses to copy the .NET leftovers.
- It also excludes `dist` and `coverage`, so the image is built from source
  inside the container rather than from a host-side `ng build` output. That is
  the right choice and means the container build runs `npm ci` itself — which
  puts it squarely behind the `strict-ssl=false` and `ignore-scripts` settings
  above.
- No `.env`, `*.pem` wildcard, or `.npmrc` entry in `.dockerignore`. The `.npmrc`
  omission is presumably deliberate — the container build needs the registry
  configuration — but it does mean that if the token-bearing rendered `.npmrc`
  ever lands at the client root, it goes into the image layer. Worth a line in
  whatever documents the container build.

---

## `angular.json` (234 lines) — resolves three open questions, corrects one of mine

Validates as JSON, and every anchor line matches the photographed gutters
(44 `configurations`, 56 `fileReplacements`, 73 `qa`, 129 `dvl`, 158 `local`,
167 `serve`, 213 `lint`, 225 `cli`, 234 closing brace).

### RESOLVED — `local` is a real configuration, and the fileReplacement scheme is confirmed

The `build.mjs` entry flagged that its `configuration:` token defaults to `local`
while no `fusion.config.local.ts` exists, and warned that *"if `local` is not a
declared Angular configuration then the default invocation of `npm run build`
fails while every named environment works."*

It is declared, in both `build` and `serve`, and it is the
`defaultConfiguration` for both. The default build works.

The mechanism is exactly as inferred. Four configurations do a file replacement:

```json
"fileReplacements": [
    {
        "replace": "src/app/fusion.config.ts",
        "with": "src/app/fusion.config.prd.ts"
    }
]
```

…and **`local` has no `fileReplacements` at all**, so it uses the unsuffixed
`fusion.config.ts` — the one whose `baseUrl` is `https://localhost:4200/`. That
is a clean design and it is now fully evidenced.

It also confirms `fusion.config.prd.ts` is genuinely wired into the `prd` build,
which means the `devMode: true` inheritance recorded against it is live, not
theoretical.

### CORRECTED — lint covers `src/**`; it does not cover `scripts/**`

```json
"lint": {
    "builder": "@angular-eslint/builder:lint",
    "options": {
        "lintFilePatterns": [
            "src/**/*.ts",
            "src/**/*.html"
        ]
    }
}
```

Several earlier entries reasoned from style divergences that *"either lint does
not cover `src/app/**` or the rules are off"*, and treated the accumulation as
evidence that `npm run lint`'s reach was narrower than assumed. **That inference
was half right and half wrong, and the wrong half matters.**

- **Right:** `scripts/` is a *sibling* of `src/`, so `update.mjs`'s unused
  `npmInstall` import is genuinely never linted. Nothing in the build harness is.
- **Wrong:** `src/**/*.ts` **is** covered. So the divergences inside `src/app/`
  are not explained by lint not looking.

Taking the three cases precisely, now that the patterns are known:

1. **`CommonModule` in `my-entity` and `test-datastore`** — this would *not* be
   caught by `no-unused-vars`, because the symbol **is** referenced: it appears in
   the `imports:` array. It is unnecessary in the Angular sense, not unused in the
   TypeScript sense. The rule that catches it is
   **`@angular-eslint/no-unused-standalone-imports`**. My earlier "a linter would
   normally flag this" was loose; the specific rule is the actionable version, and
   enabling it is a one-line change to the ESLint config.
2. **Missing trailing newlines** (`test-datastore.component.{ts,html}`,
   `angular.json` itself) — that is Prettier's `insert-final-newline` territory,
   and `preBuild` runs `npm run clean` then `npm run lint`. There is **no format
   check in the build path at all**. That is the real gap, and it explains every
   whitespace and ordering divergence in one stroke.
3. **Unsorted `imports:` arrays and inconsistent `@Component` member order** —
   also formatting/convention, also ungated.

So the corrected conclusion is sharper than the original: the client has a
**linter but no formatter gate**, and the linter is missing the one Angular rule
that would catch the most-repeated defect. `.eslintrc` / `eslint.config.js` and
`.prettierrc` remain worth having, but the diagnosis no longer depends on them.

### ⚠ MEDIUM — bundle budgets can never fail a build

Every budget in all four deployed configurations is a **warning**:

```json
{ "type": "initial",            "maximumWarning": "1mb" },
{ "type": "anyComponentStyle",  "maximumWarning": "4kb" }
```

There is no `maximumError` anywhere in the file. A build that doubles the initial
bundle prints a warning and exits 0.

For a kit whose first principle is *"gates are scripts, not opinions"* and whose
convention is `RESULT: OK` (exit 0) / `RESULT: BLOCKED` (exit 2), a budget that
cannot block is a gate that is not one. It is also the single cheapest real gate
available on the frontend: adding `"maximumError": "2mb"` alongside the warning
turns bundle growth into a hard stop, which matters when a few hundred people are
each adding Fusion components to a starter they did not write.

Worth pairing with the observation that `local` — the default configuration — has
**no budgets at all**, so the everyday build never even warns.

### ⚠ MEDIUM (efficiency) — the Angular CLI disk cache is disabled

```json
"cli": {
    "analytics": false,
    "cache": {
        "enabled": false
    },
```

`analytics: false` is correct and welcome. `cache.enabled: false` turns off
Angular's persistent build cache, so **every build recompiles from scratch**.

This is worth calling out because efficiency was raised directly as a concern for
the hackathon. Stacked with what the build harness already does, the loop is slow
by configuration rather than by necessity:

| Setting | Effect |
|---|---|
| `cli.cache.enabled: false` | no incremental compilation between builds |
| `npmInstall`'s `existsSync && !force` early return | dependencies never refresh, so the fix is a manual delete |
| `exec` buffering in `tools.mjs` | no streaming output, so a slow build looks like a hang |
| `preBuild` running `clean` + `lint` on every build | full lint pass before every `ng build` |

Disabling the CLI cache is almost always a workaround for one stale-cache
incident. The supported remedy is `ng cache clean` when it misbehaves, not
switching it off permanently. Re-enabling it is a one-line change and is likely
the largest single wall-clock win available to a participant.

### zone.js is present — the app is not zoneless

```json
"polyfills": [
    "@angular/localize/init",
    "zone.js"
]
```

Change detection is zone-based throughout. That makes the earlier
`ChangeDetectionStrategy.OnPush` finding **more** significant, not less: with
signals used on three of four pages and only `HomeComponent` marked `OnPush`,
every other page runs full zone-triggered change detection and re-evaluates
`test-datastore`'s four getters on each pass. Not a performance problem at this
scale; a bad pattern to propagate at hackathon scale.

`@angular/localize/init` is also loaded on every build and there **is** an
`extract-i18n` target — but no `i18n` block in the project and no locale files
anywhere in the transcribed tree. So localization is paid for in bundle weight
and never used. Either wire it up or drop the polyfill.

### The `test` target has no coverage configuration

```json
"test": {
    "builder": "@angular-devkit/build-angular:karma",
    "options": {
        "polyfills": ["zone.js", "zone.js/testing"],
        "tsConfig": "tsconfig.spec.json",
```

No `codeCoverage`, no `codeCoverageExclude`, no reporters configured. Combined
with the placebo specs recorded earlier — one zero-byte file and one
`describe('Dummy')` whose body is `return;` — the Dominion rubric's
**coverage ≥ 80%** gate has *no wiring on the client at all*. Not a low number: no
mechanism to produce a number.

This is the third time the same gap has surfaced from a different direction
(empty spec → dummy spec → no coverage config). It is the most consistently
evidenced hole in the kit's frontend story, and unlike most of the others it is a
gate the rubric already claims to enforce.

### `src/web.config` is copied into `dist/`

```json
"assets": [
    "src/favicon.ico",
    "src/assets",
    "src/web.config",
```

Directly relevant to the deployment question opened by `.dockerignore` and
`default.conf`. The IIS configuration — including the Content-Security-Policy
this review called the starter's strongest security artefact — **ships inside the
build output**. If the container serves that output through nginx, the file is
present and inert: nginx does not read `web.config`.

That makes the question sharper rather than answering it. A reviewer who finds
`web.config` in `dist/` will reasonably conclude the headers are deployed.
`default.conf` remains the file that decides whether they actually are.

### Smaller observations

- **`@angular-devkit/build-angular:application`** is the modern esbuild-based
  builder, not the legacy `:browser` one. Good, and worth stating as the target an
  agent should produce when it writes an `angular.json` for a ported app.
- **`node_modules/@fusion/theme/assets` → `/assets`** is a glob asset entry. A
  ported app that hand-writes `angular.json` and omits it will build cleanly and
  render with missing Fusion icons and fonts — a silent visual-only failure, and
  another candidate for the `component-map` / instructions treatment.
- **`dvl` is the only configuration shipping `sourceMap: true`** alongside
  `outputHashing: "all"`, so source maps reach that deployed environment. Probably
  deliberate for a dev tier; worth a conscious decision rather than an inherited
  one.
- **Five near-identical 28-line configuration blocks (~115 lines of the 234).**
  `angular.json` has no inheritance mechanism, so the duplication is unavoidable —
  but it means every budget or optimization change is a five-place edit, and drift
  between the blocks is exactly what has already happened (`sourceMap` on `dvl`
  only). Any kit guidance about editing `angular.json` should say "change all
  five".
- **`schematics.@schematics/angular:component.style: "scss"`** and
  `inlineStyleLanguage: "scss"` — consistent with every component transcribed.
- **`angular.json` itself has no trailing newline**, matching `test-datastore`'s
  files and reinforcing the no-formatter-gate finding above.

---

## Client root configs — the deployment question answered, and the drift mechanism found

Nine files: `AppInfo.xml`, `default.conf`, `nginx.conf`, `eslint.config.js`,
`package.json`, `Starter.Web.Client.esproj`, `tsconfig.json`,
`tsconfig.app.json`, `tsconfig.spec.json`. **No redaction was needed** — the
client `AppInfo.xml` uses placeholder tokens throughout and neither nginx config
contains a hostname.

---

### ⚠ HIGH (security) — ANSWERED: the container path serves no security headers

The `.dockerignore` entry opened this question and called it the thing to settle
before the hackathon. It is settled, and the answer is the bad one.

**`nginx.conf`** (23 lines) is the live OpenShift config — `listen 8080`,
`root /opt/app-root/src`, and five `*_temp_path` directives redirected under
`/tmp`, which is the standard pattern for OpenShift's read-only root filesystem
and arbitrary-UID containers:

```nginx
events {}

http {
    include mime.types;

    client_body_temp_path /tmp/nginx/client_temp;
    ...
    server {
        listen 8080;
        server_name _;

        root /opt/app-root/src;
        index index.html;

        location / {
            try_files $uri $uri/ /index.html;
        }
    }
}
```

That is the entire file. **No `add_header` anywhere.** No
`Content-Security-Policy`, no `Referrer-Policy`, no `X-Frame-Options`, no
`X-Content-Type-Options`, and no cache-control directives.

So the position recorded earlier is confirmed: the careful CSP in
`src/web.config` — `default-src 'self'`, a hash-pinned inline script, an explicit
`connect-src` allow-list, `Referrer-Policy: strict-origin-when-cross-origin` —
applies **only to the IIS path**. And because `angular.json` copies
`src/web.config` into `dist/`, that file is physically present in the container
image while being completely inert there. A reviewer who greps the deployed
artefact for `Content-Security-Policy` finds it and concludes the app is
protected.

**The cache policy is lost too, and that one bites operationally.** `web.config`
sets `no-cache, no-store, must-revalidate` on `index.html`,
`manifest.webmanifest`, and the four service-worker files, with a one-day
`max-age` on `assets` and `favicon.ico`. nginx sets none of it. With
`outputHashing: "all"` the hashed bundles are safe to cache forever, but
`index.html` — the file that *names* those hashes — can be held by any
intermediary. That is the classic SPA stale-shell deployment failure: users keep
loading an old `index.html` that references bundles no longer on disk, and the
app fails with chunk-load errors after a deploy.

Both are cheap to fix in the same block:

```nginx
add_header Content-Security-Policy "..." always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header X-Content-Type-Options "nosniff" always;

location = /index.html {
    add_header Cache-Control "no-cache, no-store, must-revalidate" always;
}
```

Given the hackathon multiplies this across every participating app, and given the
kit already *has* the correct policy written down one file over, porting it into
`nginx.conf` is probably the single highest-value security change available.

**`default.conf` is vestigial and cannot work as written.** It is the other
23-line file, with `listen 80`, `root /usr/share/nginx/html` (the stock nginx
image path, not the OpenShift one), and everything structural commented out —
including `events { }` and `include /etc/nginx/mime.types`. As a main config it
fails to start (nginx requires an `events` section); as a `conf.d/` snippet its
`http { }` wrapper is a syntax error. It is a leftover from a different base
image. Deleting it removes a file that an agent asked to "update the nginx
config" has a fifty-fifty chance of editing instead of the real one.

---

### ⚠ HIGH — `"latest"` on four toolchain packages is the drift mechanism

```json
"@typescript-eslint/eslint-plugin": "latest",
"@typescript-eslint/parser": "latest",
"eslint": "latest",
"prettier": "latest",
"typescript-eslint": "latest"
```

`"latest"` is a **dist-tag, not a version range**. It resolves to whatever is
newest at install time, with no upper bound — not even a major one.

This is the most direct drift generator found anywhere in the kit, and it is
worth being explicit about why it matters more here than in an ordinary repo:

- **It contradicts the kit's own stated law.** `CLAUDE.md` says *"Version pins
  are preconditions"* and `.squad/gates/check-pins` must pass before
  structure/swap steps, with placeholders in `pins.json` meaning *halt, not
  improvise*. Five dependencies in the starter every participant clones are
  unpinned by construction.
- **It breaks the build, not just the output.** `preBuild` runs `npm run lint`
  on **every** build. A major bump in `eslint` or `typescript-eslint` changes
  rule names and config schema; the flat config here calls
  `tseslint.config(...)` and spreads `tseslint.configs.*`, all of which have
  moved between majors. The failure mode is "lint worked yesterday, fails today,
  nobody changed anything."
- **The documented recovery step makes it worse.** `npm run update` →
  `update.mjs` → `npmUpdate()` → `npm update`, which re-resolves `latest` to
  whatever shipped since. The kit's own drift-recovery instruction is also a
  drift-*introduction* instruction for these five packages.
- **Two participants who clone on different days get different linters**, and
  therefore different verdicts on identical code. For an event whose purpose is a
  consistent modernization outcome, that is the failure mode in miniature.

The rest of the file is pinned sensibly by comparison — `@fusion/*` at exactly
`2026.3.5` (five packages now, `@fusion/icons` being new), `@angular/*` at `"20"`,
`@playwright/test` at `^1.59.1`. Bringing the five `latest` entries in line with
that is a five-line change and, of everything in this review, it is the one most
directly aimed at the drift concern.

---

### CORRECTED (twice) — there is **no** `engines` field

The `tmpt/.npmrc` entry reasoned that `engine-strict=true` means npm enforces a
declared `engines` range, and concluded that the earlier *"undeclared
minimum-Node constraint"* observation against `getFullPath`'s `entry.parentPath`
was *"likely wrong — the constraint is probably declared and enforced."*

**`package.json` has no `engines` field.** `engine-strict=true` has nothing to
enforce. So:

- the **original** observation was right — the Node floor implied by
  `entry.parentPath` (≥ 20.12 / ≥ 21.4) is genuinely undeclared;
- the **correction** was wrong, and is withdrawn.

I inferred the existence of a field from a setting that governs it, without
seeing the field. Recording it plainly because the net effect is a real gap:
`engine-strict=true` reads like a guardrail and currently is not one. Adding
`"engines": { "node": ">=20.12" }` makes it one, and turns a silent
`undefined/<name>` on Node 18 into a refused install.

---

### CORRECTED — the dev server runs on port **5001**, not 4200

```json
"serve": "ng serve --port 5001 --ssl --ssl-cert cert.pem --ssl-key cert.key",
"start": "node ./scripts/pre-start.mjs && npm run serve",
```

The `.vscode/` entry read `launch.json`'s `http://localhost:4200/` and stated
that *"4200 is the modern side of that pair"* for the dual-port visual-parity
gate. **That is wrong.** 4200 is stock Angular CLI scaffolding in a `launch.json`
that does not match the project's actual serve script. The real port is **5001**,
over HTTPS.

Three things fall out of this, all useful:

1. **`pre-start.mjs`'s certificate export is load-bearing, not incidental.** The
   earlier entry flagged `dotnet dev-certs https --export-path ./cert.pem --format
   Pem --no-password` as writing an unencrypted key into the working tree. It does
   — and now the reason is clear: `ng serve --ssl --ssl-cert cert.pem --ssl-key
   cert.key` requires exactly those two files at exactly those paths. The security
   observation stands; the "why is this here" question is answered, and any fix
   has to keep the dev server working.
2. **`fusion.config.base.ts`'s `redirectUri: 'https://localhost:5001/login/callback'`
   now makes sense.** The base config is the *local development* config. Which
   sharpens the `fusion.config.prd.ts` finding rather than softening it:
   production inherits a redirect URI that was written for a developer's laptop.
3. **`launch.json` is stale.** Debugging via the VS Code launch config attaches to
   a port nothing is listening on.

### NEW — the local Fusion config points at the wrong port

```ts
// fusion.config.ts (used by the default `local` configuration)
api: {
    baseUrl: 'https://localhost:4200/'
}
```

The app is served from **5001**; the local API base URL points at **4200**. Every
other environment config uses the relative `'/api'`. There is no `proxy.conf.json`
in the transcribed tree. So a default `npm start` issues API calls to a port
nothing serves — almost certainly a stale value left behind when the serve port
changed, and exactly the kind of thing a participant hits in their first ten
minutes.

---

### RESOLVED — the `void` prefix is required, not stylistic

```js
'@typescript-eslint/no-floating-promises': 'error'
```

`my-entity.component.ts`'s `void this.refresh();` and `test-datastore`'s
`void this.loadStoredText();` were recorded without explanation. This is the
explanation: `void` is the sanctioned way to satisfy `no-floating-promises`, and
the rule is set to `error`. Worth stating in `angular.instructions.md`, because an
agent that writes `this.refresh();` in `ngOnInit` will fail lint and may not know
why.

`@typescript-eslint/await-thenable` and `require-await` are also `error`, and all
three require **type-aware** linting — which is configured
(`parserOptions.project: 'tsconfig.json'`). That is a deliberate, good setup.

### CONFIRMED — no formatter gate, and the missing Angular rule

Two predictions from the `angular.json` entry both hold:

1. **`prettier` is a devDependency** — and there is no `format` script, no
   `eslint-config-prettier`, and no `eslint-plugin-prettier` in the flat config.
   Prettier is installed and **never executed by anything**. That is the direct
   evidence for the "linter but no formatter gate" conclusion, and it explains
   every trailing-newline, member-ordering and import-sorting divergence recorded
   across six files in one stroke. A `"format": "prettier --write ."` plus a
   `--check` in `preBuild` closes the whole category.
2. **`@angular-eslint/no-unused-standalone-imports` is not enabled.** The `rules`
   block overrides only the two selector rules and the three promise rules;
   nothing else is added on top of `angular.configs.tsRecommended`. So the
   unnecessary `CommonModule` in two components is genuinely unreported.

### Strengths worth stating plainly

After a long run of findings, three parts of this batch are genuinely good:

- **`tsconfig.json` is the strongest config in the client.** `strict: true`,
  `noImplicitOverride`, `noPropertyAccessFromIndexSignature`, `noImplicitReturns`,
  `noFallthroughCasesInSwitch`, plus `strictTemplates`,
  `strictInjectionParameters` and `strictInputAccessModifiers` in
  `angularCompilerOptions`. That is a stricter posture than most production
  Angular apps run, and it is the right thing to tell agents to preserve when
  porting. (`resolveJsonModule: true` also confirms the requirement noted against
  `app.config.ts`'s `import * as pack from '../../package.json'`.)
- **Accessibility linting is on.** `angular.configs.templateAccessibility` is
  extended for `**/*.html`. For a modernization kit whose output is internal
  line-of-business apps, shipping a11y rules by default in the starter is a real
  and uncommon strength.
- **`AppInfo.xml` already uses the placeholder convention.**
  `{TeamEmail}`, `{TeamSupportGroup}`, `{TeamADGroup}`, `{TeamADGroupDomain}`,
  `{ApplicationInfoUrl}`, `{ApplicationRepoUrl}` — and the API's `AppInfo.xml`
  uses the same tokens. **This upgrades the recommendation made against
  `appsettings.json` and `fusion.config.base.ts` from "adopt a placeholder
  mechanism" to "apply the mechanism you already have, consistently."** The kit
  invented the right answer for one file type and did not carry it to the two
  that ship live credentials. That is a much easier argument to win internally.

### Smaller observations

- **Playwright is installed and never invoked.** `@playwright/test` and
  `playwright` at `^1.59.1` are devDependencies; there is **no `e2e` script**.
  Given the kit's dual-port visual-parity gate and `.squad/tools/visual`, E2E
  infrastructure exists in the starter with nothing wired to it. Either the wiring
  lives in the kit rather than the starter, or this is another
  installed-but-unused dependency alongside Prettier.
- **`"install"` is an npm lifecycle script name.** `"install": "node
  ./scripts/install.mjs"` means `npm install` would invoke it as a lifecycle hook.
  `ignore-scripts=true` in `.npmrc` currently suppresses that, so it is dormant —
  but anyone running with `--ignore-scripts=false` (which
  `installSafePackages()` does per-package) gets `npm install` calling a script
  that itself installs. Worth renaming to `install:deps` to remove the hazard
  entirely.
- **`Starter.Web.Client.esproj` sets `ShouldRunNpmInstall=false`**, which is why
  dependency installation is owned entirely by the `.mjs` harness rather than by
  Visual Studio. It also maps `BuildCommand`/`CleanCommand`/`StartupCommand` onto
  the npm scripts, so MSBuild and npm agree — a tidy seam, and the reason
  `build.mjs` hand-creates `obj/Debug`.
- **`@fusion/icons` is a fifth Fusion package**, pinned at the same `2026.3.5`
  CalVer as the other four. The CalVer pinning is consistent and correct.
- **`tsconfig.spec.json` includes only `src/**/*.spec.ts`**, and `types: ["jasmine"]`
  — so the spec tsconfig is wired correctly. The problem with the frontend tests
  has never been configuration; it is that the two specs that exist assert
  nothing.

---

# `.github/scripts/` — the enforcement layer

First file transcribed from this tree. Nothing else under `.github/scripts/` has
been imported yet; the tree lists roughly **91 scripts** across `parity/`,
`P1-Discovery/`, `P2-Modernize/`, `QA/`, `shared/`, `maintenance/`, `step0/` and
`Workspace/`.

**Caveat that applies to everything in this directory:** `pwsh` is not installed
in this environment, and unlike `.squad/gates/` (which ships `.sh` + `.ps1`
launchers over shared logic) `.github/scripts/` appears to be PowerShell-only.
These can be read and reviewed but **not executed** here, so every statement
about them is a code reading, not a test result.

---

## `parity/scan-api-dto-coverage.ps1` (222 lines) — a genuinely good gate

This is the first real gate seen end to end, and it deserves saying plainly: it
is **well designed**, it is written from a real incident, and its central insight
is better than most of what the instructions files contain.

### It was written from a postmortem

```
THE FAILURE MODE THIS EXISTS TO CATCH
A developer writes a modern DTO with fewer fields than the legacy View it replaces:
  Legacy:  FileLogView { DrawingNo, DocumentType, Title, FileName, PublicationDate, ... }
  Modern:  FileLogResponse(Directory, DrawingNo, Description) - only 3 of 10 fields
The TypeScript type may match the narrow modern DTO (so TS compiles), the column headers
are declared with the right labels, the grid renders with real rows - but 7 columns are
permanently empty because the server never sends those fields. No gate caught this because
every gate checked "what exists in modern is wired" without checking "everything in legacy
was carried forward".
```

That last sentence is the most valuable line of design thinking found anywhere in
the kit so far. Every other gate reviewed to date is *modern-anchored* — it
verifies that what exists in the new code is correct. This one is
**legacy-anchored**: it verifies that nothing from the old code was silently
lost. Those catch disjoint failure classes, and the second is the one that
produces "it looks fine and the data is wrong."

Two more things it gets right:

- **Deterministic and content-only.** No running app, no screenshots, no
  network. It walks C# files and compares property-name sets. That makes it fast,
  reproducible, and usable in CI — the opposite of the visual-parity gate's
  failure modes.
- **Waivers are visible, not silent.** Intentional drops go in
  `api-dto-coverage-registry.json` under `acceptedDrops[]` *with a reason*, and
  the count is echoed into the output artefact. That is exactly the right shape
  for D-001-style evidence discipline: you can drop a field, but the drop is a
  recorded decision rather than an absence.

Exit codes are `0` / `2`, matching the kit's `RESULT: OK` / `RESULT: BLOCKED`
convention.

### CONFIRMED — `kit-params.md` `appName` resolution already exists

```powershell
$kitParams = Join-Path (Get-Location) '.modernization\.readme\kit-params.md'
if (Test-Path $kitParams) {
    $appNameMatch = Select-String -Path $kitParams -Pattern '^appName:\s*(.+)$' | Select-Object -First 1
    if ($appNameMatch) {
        $appName = $appNameMatch.Matches[0].Groups[1].Value.Trim()
        $candidate = Join-Path (Get-Location) ("src\{0}.Web.Api" -f $appName)
```

This matters well beyond this script. Several earlier entries recommended
resolving hard-coded values — the Okta client ID and issuer in
`appsettings.json` and `fusion.config.base.ts`, the Sonatype registry host in
`.npmrc` — **from `kit-params.md` at the Step 2 rename**, and the `AppInfo.xml`
entry noted that the `{Placeholder}` convention already exists for those files.

Now the *resolver* is confirmed too. `kit-params.md` is a real, parsed file with
at least an `appName` key, and at least one script already reads it. So the
recommendation collapses further, from *"apply the placeholder convention you
already have"* to **"add two keys to a file that is already being parsed, and
extend the substitution step that already runs."** That is a materially easier
sell, and `P1-Discovery/replace-deploy-values` (still untranscribed) is very
likely the step that already does the substituting.

Also confirmed: the Step 2 rename must produce **`src/{appName}.Web.Api`**
exactly. That naming is load-bearing for at least this gate, and probably others.

### ⚠ HIGH — the gate cannot distinguish "no gaps" from "nothing scanned"

```powershell
$legacyFiles = @(Get-ChildItem -Path (Join-Path $LegacyRoot '*') -Recurse -Filter '*View.cs' ...)
...
if ($gaps.Count -gt 0) { exit 2 } else { exit 0 }
```

Legacy discovery is anchored on the filename filter **`*View.cs`**. If a legacy
app does not name its DTOs that way — and MVC5/WebForms apps frequently use
`*Model.cs`, `*Item.cs`, `*Row.cs`, `*Info.cs`, or nothing systematic —
`$legacyFiles` is empty, `$legacyDtos` is empty, no pairs are matched, `$gaps` is
empty, and the script **exits 0 and reports success**:

```
  Missing fields: 0 (all modern DTOs cover their legacy counterparts)
```

printed in green. The gate reports PASS on an application it was structurally
unable to analyse.

This is the most consequential finding in the file, and it is exactly the class
of problem the script's own header warns about — a gate that checks a thing and
concludes safety without checking that it *could* check the thing. For a
hackathon where every participant brings a differently-shaped legacy app, the
expected outcome is that this gate passes vacuously for most of them.

The data needed to catch it is **already in the output artefact**:

```powershell
legacyViewsScanned   = $legacyDtos.Count
modernDtosMatched    = $checkedPairs.Count
```

The exit code just ignores both. A three-line fix restores the guarantee:

```powershell
if ($legacyDtos.Count -eq 0) {
    Write-Host "  No legacy View classes found under $LegacyRoot - gate cannot run." -ForegroundColor Yellow
    exit 2   # or a distinct 'inconclusive' code, but NOT 0
}
```

The same reasoning applies to `modernDtosMatched -eq 0`: every modern DTO
unmatched means the concept-matching found nothing to compare.

Worth pairing with a `-LegacyDtoFilter` parameter so an app with different
naming can point the gate at its own convention rather than silently passing.

### ⚠ MEDIUM — two places where the header documents behaviour the code does not implement

**1. There is no fuzzy matching.** The `.DESCRIPTION` says:

> *"Falls back to fuzzy name matching when exact mapping is not present."*

The matching loop is an exact, case-insensitive comparison of the stripped domain
concept and nothing else:

```powershell
foreach ($lName in $legacyDtos.Keys) {
    $lConcept = Get-DomainConcept $lName
    if ($lConcept -ieq $concept) { $legacyMatch = $lName; break }
}
if (-not $legacyMatch) { continue }
```

No Levenshtein, no substring, no token overlap, no fallback of any kind — an
unmatched DTO is simply skipped. Since skipping is silent and the header promises
a fallback, a reviewer reading the docs will over-trust the coverage. Either
implement the fallback or delete the sentence; the sentence is currently the more
dangerous of the two.

**2. Field declarations are documented but not matched.** The helper's comment
reads:

```
# Handles: "public string Foo { get; set; }", "public sealed record Foo(string Bar, ...)", "public int Id;".
```

but the auto-property regex requires an opening brace:

```powershell
'(?im)^\s*public\s+[\w<>\[\]\?]+\s+(\w+)\s*\{'
```

`public int Id;` never matches. Legacy View classes written with public *fields*
rather than properties — common in older code, which is precisely what
`LegacyCode/` contains — contribute **zero** properties, and if a whole class is
fields-only it is dropped by `if ($props.Count -gt 0)` and never enters
`$legacyDtos` at all. That is a silent under-count feeding a gate whose entire
purpose is to catch under-counting.

### ⚠ MEDIUM — the property regex misses common C# shapes

`[\w<>\[\]\?]+` for the type has no `,` and no space, so any generic with more
than one type argument fails to match:

| Declaration | Matched? |
|---|---|
| `public string Foo { get; set; }` | yes |
| `public List<string> Foo { get; set; }` | yes |
| `public Dictionary<string, int> Foo { get; set; }` | **no** (comma + space) |
| `public string Foo => _foo;` (expression-bodied) | **no** (no `{`) |
| `public int Id;` (field) | **no** (no `{`) |
| `public required string Name { get; set; }` | **no** (`required` modifier) |

That last row matters directly: the starter's own `MyEntity.cs` declares
`public required string Name { get; set; }`, and the `required` keyword sits
between `public` and the type, which the anchored `^\s*public\s+<type>\s+<name>`
pattern does not allow. Any modernized code following the starter's own idiom is
partly invisible to this scanner.

All of these fail **toward false negatives** — properties that exist but are not
seen. On the legacy side that under-counts what must be carried forward (gate too
lenient); on the modern side it over-reports gaps (gate too noisy). Both erode
trust in the same output.

### ⚠ MEDIUM — properties are extracted per *file*, not per *class*

```powershell
foreach ($cm in [regex]::Matches($text, '...(?:class|record)\s+(\w+)')) {
    $modernName = $cm.Groups[1].Value
    ...
    $modernProps = Get-CSharpProperties $text     # <- whole file, every time
```

`Get-CSharpProperties` is handed `$text` — the entire file — inside a loop over
*every class in that file*. So when one file declares two types, each is credited
with the union of both types' properties. A `FooResponse` that is missing three
legacy fields passes if a `FooRequest` in the same file happens to declare them.

The same applies on the legacy side, which only ever takes the **first** class
match per file (`[regex]::Match`, not `Matches`) and then attributes the whole
file's properties to it.

This is survivable in practice for exactly one reason, and it is worth naming:
`dotnet.instructions.md` mandates *"Types should be in separate files unless they
are private nested types or very small related types"*. The gate is correct only
because the kit's own coding standard keeps files single-type. That is a real
coupling between a style rule and a correctness guarantee, and it is written down
in neither place. Legacy code — which predates the standard by definition —
has no such protection.

### Smaller observations

- **`$InternalPropNames` is a good touch.** Ten audit/identity property names
  (`id`, `createdby`, `createdat`, `rowversion`, `concurrencytoken`, …) are
  exempt by default and the list is an overridable parameter. That prevents the
  most obvious class of false positive without hard-coding it.
- **The interface/base skip is a prefix heuristic**: `^(I[A-Z]|Abstract|Base)`.
  It will also skip a legitimately-named `IdentityResponse` — `I` followed by
  `d`… no, `[A-Z]` requires an uppercase second character, so `IdentityResponse`
  is safe. `IOResponse` would be skipped. Narrow enough to be fine.
- **The modern-file filter matches on `FullName`**, not just the leaf name:
  `$_.FullName -match '(?i)Response|Dto|Model|Request'`. Any file under a
  directory called `Models/` therefore qualifies — which is how the starter is
  laid out (`Starter.Web.Api/Models/`). Probably intentional, and worth knowing,
  because it means a project that renames that folder changes what the gate sees.
- **`-Depth 6` on `ConvertTo-Json`** is sufficient for the emitted shape
  (`checkedPairs[].missing[]` is depth 4).
- The `.EXAMPLE` invokes `powershell` (Windows PowerShell 5.1), not `pwsh`. That
  is consistent with the kit's PowerShell 5.1 constraint recorded earlier — the
  same constraint that forced the custom `opx-field-contract/v1` schema dialect
  because 5.1 lacks `Test-Json -Schema`.

### What this one file implies about the other ~90

If `scan-api-dto-coverage.ps1` is representative, the scripts layer is **the
strongest part of the kit** — better reasoned than the instructions files and
noticeably better than the starter. The defects found here are not sloppiness;
they are the ordinary edges of regex-based static analysis, plus one exit-code
gap that matters a lot.

That last one is the pattern worth checking for across every other gate as they
arrive: **does this script distinguish "I checked and found nothing wrong" from
"I could not check"?** On the evidence of this file, that question is the highest
-yield thing to ask of the remaining `parity/`, `P2-Modernize/verify-*` and
`shared/verify-*` scripts.

---

## `parity/scan-backend-parity.ps1` (241 lines) — the sibling gate, and the pattern generalises

The second `parity/` gate, and the stronger of the two. Same legacy-anchored
philosophy, same `kit-params.md` resolution, same waiver registry, same `0`/`2`
exit contract — applied to **endpoints** rather than DTO fields. Together the pair
covers the two ways a modernization loses functionality silently:

| Gate | Question |
|---|---|
| `scan-api-dto-coverage` | did the *fields* survive? |
| `scan-backend-parity` | did the *endpoints* survive? |

That is a coherent design, and both are anchored on the legacy side. Whoever
wrote these understood the problem properly.

### The postmortem is quantified, and it names three gates that passed

```
A modernization can rebuild the READ path (queries, grids, search) perfectly and render live
data, while quietly dropping the entire WRITE path (Add / Edit / Delete / Link / Export). The
UI still shows the buttons - they open placeholder modals - so the UI parity scanner (which
checks the label is present and the click handler is non-empty) reports green. The UI->API
wiring gate also passes, because the modern client only calls the GET endpoints that remain,
so there are no "broken" calls. Nothing was comparing the LEGACY backend surface to the MODERN
backend surface, so a real regression (e.g. 35 legacy mutation endpoints -> 0 modern) shipped
green.
```

**35 mutation endpoints to zero, shipped green.** An entire write path deleted,
with the UI still rendering its buttons, and the existing gates all passing —
each for a defensible reason that the header spells out. This is the single best
argument in the kit for why legacy-anchored verification is necessary, and it is
sitting in a script header rather than in `AppMod-Process.instructions.md` where
agents would read it.

**Recommendation:** lift this paragraph into the instructions layer. It is the
most persuasive thing in the repository and currently only reaches whoever opens
this file.

### The severity model is well calibrated, and explained

```powershell
$severity = if ($e.isMutation) { 'Major' } elseif ($StrictReads) { 'Major' } else { 'Minor' }
```

Mutations block (exit 2); missing GETs are reported as Minor but do not block,
*because reads are legitimately consolidated during modernization while writes
are not*. `-StrictReads` promotes them when an app wants strict read parity. The
reasoning is in the header rather than implicit.

Route shape is deliberately excluded from the match: *"route-template shape is
reported but not required to match, because modern routes are often reshaped - a
missing verb on a controller is the real defect."* That avoids a large class of
false positives from `/api/foo/{id}` becoming `/api/foos/{id}`.

Two thoughtful extras: `droppedControllers` surfaces controllers absent from
modern **entirely** as a separate aggregate (printed in yellow), and the console
summary reports legacy/modern endpoint and mutation counts side by side.

---

### ⚠ HIGH — the vacuous-pass gap is a *pattern*, not a one-file bug

The `scan-api-dto-coverage` entry recorded that the gate cannot distinguish "no
gaps" from "nothing scanned", and recommended surfacing `legacyViewsScanned` in
the exit decision. This gate is **better instrumented** and still has the same
hole:

```powershell
if ($majorGaps.Count -gt 0) { exit 2 } else { exit 0 }
```

`Get-Endpoints` finds nothing → `$legacy` empty → `$gaps` empty → **exit 0**. The
counts that would reveal it (`legacyEndpointCount`, `legacyMutationCount`) are
computed, written to the artefact, and printed — but the exit code ignores all of
them, exactly as before.

**And the documented invocation makes it silent.** The `.EXAMPLE` is:

```
powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-backend-parity.ps1 -Quiet
```

`-Quiet` suppresses the entire summary block, including
`Legacy endpoints : 0 (0 mutations)` — the one signal a human would catch. So in
the invocation the script itself documents, a gate that scanned nothing is
indistinguishable from a gate that found nothing wrong.

Since this now appears in **both** parity gates, it should be treated as a
systemic property of the layer rather than a defect in either file. The fix is
the same three lines in each, and belongs in `shared/`:

```powershell
if ($legacy.Count -eq 0) {
    Write-Host "  No legacy endpoints found under $LegacyRoot - gate could not run." -ForegroundColor Yellow
    exit 2
}
```

**This is the question worth asking of every remaining gate as it arrives**, and
two for two so far the answer has been no.

### ⚠ HIGH — the coverage key is `controller|verb`, which under-counts badly

```powershell
foreach ($e in $modern) { [void]$modernCoverage.Add(("{0}|{1}" -f $e.controller, $e.verb)) }
...
$key = "{0}|{1}" -f $e.controller, $e.verb
if ($modernCoverage.Contains($key)) { continue }
```

Coverage is keyed on **controller + HTTP verb only** — not the action. So a legacy
`OrdersController` with five POST actions (`Create`, `Approve`, `Reject`,
`Submit`, `Archive`) is fully "covered" by a **single** modern POST on
`OrdersController`. Four dropped write endpoints, gate green.

This directly limits the gate against the failure it was built for. The header's
own example — 35 mutations to **0** — is caught, because zero modern POSTs means
no key match. But 35 mutations to **5** is not, and a partial write-path drop is
the more likely real-world shape: teams port the obvious CRUD and quietly skip
`Approve`, `Bulk-Import` and `Export`.

The endpoint records already carry `method`, so the data is present. Options in
increasing strictness:

1. Report a per-controller verb-count delta (`legacy POSTs: 5, modern POSTs: 1`)
   as a Minor gap — cheap, no false positives.
2. Key on `controller|verb|method` with a name-similarity fallback, since method
   names usually survive a port.

Option 1 alone would have caught a 35→5 regression while staying quiet on
legitimate consolidation.

### ⚠ MEDIUM — attribute-driven extraction misses conventional MVC5 routing

```powershell
foreach ($m in [regex]::Matches($text, '(?im)\[\s*Http(Get|Post|Put|Delete|Patch)\b')) {
```

Endpoint discovery requires an explicit `[Http*]` attribute. The header is honest
about this (*"extraction is attribute-driven ([Route], [Http*])"*), but the
consequence deserves stating: **ASP.NET MVC5 controllers using convention-based
routing have no such attribute** — a public method on a controller is an action by
default, and GET actions in particular are almost never decorated.

That matters here specifically because MVC5 is one of the kit's two reference
legacy shapes (`mini-mvc5-angularjs`, `rehearsal-mvc5-angularjs`). For those apps
the legacy surface is under-counted, and every under-count makes the gate more
lenient, never stricter. `[HttpPost]` is conventionally applied even in MVC5, so
mutations mostly survive discovery — but the legacy/modern endpoint totals
printed in the summary will be misleadingly low, which also weakens the manual
check that would otherwise catch the vacuous pass above.

### ⚠ MEDIUM — `authPolicy` and `route` are looked for in the wrong direction

```powershell
$tail = $text.Substring($m.Index, [Math]::Min(600, $text.Length - $m.Index))
$authMatch = [regex]::Match($tail, '(?i)\[\s*Authorize[^\]]*Policy\s*=\s*"([^"]+)"')
```

The window starts **at** the `[Http*]` attribute and looks 600 characters
**forward**. But in idiomatic C#, `[Authorize]` and class-level `[Route]` appear
**before** the verb attribute — including in this kit's own starter, where
`MyEntitiesController` carries `[Authorize(Policy = "User")]` above the class.

Consequences:

- A class-level `[Authorize]` or `[Route]` is **never** seen, so `authPolicy` and
  `route` come back empty for every endpoint in a conventionally-written
  controller.
- Worse, the 600-character window can overshoot into the *next* action, so an
  endpoint can be attributed the following action's `[Authorize]` policy or route.

`authPolicy` and `route` do not participate in the gap decision, so this does not
change pass/fail — it is a **data-quality** defect in `backend-parity-scan.json`.
That still matters: the artefact is the durable evidence, and anything downstream
reasoning about authorisation coverage from it would be reading noise. Scanning a
window *around* the attribute block (say 400 characters back and 600 forward, or
better, splitting on method boundaries first) fixes both.

### ⚠ LOW — one controller per file assumed, again

```powershell
$classMatch = [regex]::Match($text, '(?im)class\s+([A-Za-z0-9_]+?)Controller\b')
```

`Match`, not `Matches` — only the **first** controller class in a file is named,
and every `[Http*]` attribute in that file is attributed to it. Same structural
assumption recorded against the sibling gate, and survivable for the same reason:
`dotnet.instructions.md` mandates one type per file. Legacy code, again, has no
such guarantee — and partial classes split across files will each be scanned
independently, which is fine, but a file with two small controllers will
mis-attribute.

### The two gates duplicate ~60 lines that `shared/` exists to hold

`scan-api-dto-coverage.ps1` and `scan-backend-parity.ps1` contain near-identical
copies of:

- the `kit-params.md` → `appName` → `src\{app}.Web.Api` resolution (~19 lines),
- the registry load with its `try`/`catch` (~12 lines),
- `Test-DropAccepted` (~10 lines, differing only in the fields compared),
- the output-directory creation and `ConvertTo-Json -Depth 6` write (~4 lines).

The tree already lists a `.github/scripts/shared/` directory holding
`field-contract`, `Invoke-StepReconciliation`, `verify-step-artifacts` and
`verify-upgrade-invariants` — so the pattern of factoring shared logic exists and
these two did not use it.

That is worth more than a tidiness note, because of the finding above: **the
vacuous-pass guard now has to be written twice, and will have to be written N
times across the remaining ~89 scripts.** A single `shared/Gate-Common.ps1`
exposing `Resolve-ModernApiRoot`, `Import-DropRegistry`, `Test-DropAccepted` and
an `Exit-Gate` helper that refuses to return 0 on an empty input set would fix
the whole class in one place. That is the structural recommendation, and it gets
cheaper the earlier it happens.

---

## `parity/scan-functional-parity-ledger.ps1` (lines 1-282 of N) — PARTIAL

Third `parity/` gate, and the first **composition** gate seen: it does not scan
source directly so much as cross-reference the other scanners' artefacts against
a control census. Committed as `scan-functional-parity-ledger.PARTIAL.ps1` with a
clearly delimited trailing note — the transcription stops mid-`switch` at line
282 and the file **is deliberately syntactically incomplete and must not be
executed**.

It consumes five inputs:

| Input | Produced by | Used for |
|---|---|---|
| `interaction-wiring-inventory.json` | Step 3 (`03-P1-generate-manifest.ps1`) | the control census itself |
| `backend-parity-scan.json` | `scan-backend-parity.ps1` | `mutate` / `read` status |
| `ui-parity-gap-scan.json` | a UI gate not yet transcribed | `filter` status |
| `functional-parity-registry.json` | humans | waivers |
| `src/**/routes.config.ts`, `src/**/*Controller.cs` | live | `navigate` / `export` status |

### ★ RESOLVED — the missing-input guard I said was absent **exists**, here

```powershell
if (-not (Test-Path -LiteralPath $ledgerPath)) {
    Write-Host "BLOCKED: interaction-wiring-inventory.json not found. Run Step 3 (03-P1-generate-manifest.ps1) first." -ForegroundColor Red
    exit 2
}
```

Both sibling entries recorded that the parity gates *"cannot distinguish 'no
gaps' from 'nothing scanned'"* and recommended a guard that refuses to exit 0 on
an empty input. **This gate already implements it** — and better than the version
I proposed, because the message names the exact remediation step
(`03-P1-generate-manifest.ps1`) rather than just reporting the absence.

That materially changes the finding. It is not that nobody thought of the
pattern; **the correct pattern lives in the same directory and was not applied
consistently.** The fix for `scan-api-dto-coverage.ps1` and
`scan-backend-parity.ps1` is therefore a copy-paste consistency exercise, not a
design change — which is a much easier thing to land before a hackathon.

Same story with `-Quiet`. This script's documented contract is:

```
.PARAMETER Quiet
    Suppress per-gap detail lines. Still emits the RESULT: line and exit code.
```

That is exactly right, and it is exactly what `scan-backend-parity.ps1` does
**not** do — there, `-Quiet` (the documented `.EXAMPLE` invocation) suppresses the
whole summary including the `Legacy endpoints : 0` line. So the better contract
also already exists and simply was not propagated.

### ★ `open-dialog` is the model for how a gate should handle what it can't prove

```powershell
'open-dialog' {
    # Cannot be verified statically. Must reach Verified at the Step 12/13 runtime
    # checkpoint by observing the dialog render and confirming its own controls are
    # ledgered. Reported as a Minor gap (not blocking) until that checkpoint runs.
    $false
}
```

The gate **declares its own blind spot**, refuses to claim success, classifies it
Minor so it does not block, and names the later step where real verification
happens. That is the precise discipline whose absence produced the vacuous-pass
findings against the two sibling gates — present here, in the same file, from
presumably the same author.

The `effectClass` taxonomy generally is good design: seven families, each with a
verification strategy matched to what is actually provable statically —
`ui-only` needs no backend proof and says so; `navigate` checks
`routes.config.ts`; `mutate`/`read` defer to `backend-parity-scan.json`; `filter`
keys off the UI scan's `PlaceholderAction` count.

### ★ The failure messages are remediation instructions

```powershell
'mutate' { "backend-parity-scan reports $missingMutCount missing mutation endpoint(s). Port the missing POST/PUT/DELETE/PATCH methods and re-run scan-backend-parity.ps1 to clear this." }
'filter' { "ui-parity-gap-scan detected $placeholderActionCount PlaceholderAction control(s): filter/search buttons open placeholder modals instead of calling real query endpoints." }
```

Each names the upstream artefact, interpolates the actual count, explains the
symptom in user-facing terms, and states the action that clears it. This is the
best gate output in the kit — it is written for an agent that has to *fix* the
problem, not just be told one exists.

---

### ⚠ HIGH — the guard protects the census but not the evidence

Only `$ledgerPath` blocks. The three evidence inputs each degrade to their
*"everything is fine"* value:

```powershell
$missingMutCount   = 0
$missingQueryCount = 0
if (Test-Path -LiteralPath $backendScanPath) { try { ... } catch { } }

$placeholderActionCount = 0
if (Test-Path -LiteralPath $uiScanPath) { try { ... } catch { } }
```

So if `backend-parity-scan.json` was never generated, `$missingMutCount` stays
`0` — the same value it holds when the backend scan ran and found nothing wrong.
`mutate` is then judged implemented on the strength of `$modernMutationCount > 0`
alone. Identically, a missing `ui-parity-gap-scan.json` leaves
`$placeholderActionCount = 0`, and every `filter` entry is marked implemented.

This is the vacuous-pass family again, one level up, and it is **worse here than
in the siblings** because aggregation is the entire purpose of the file: a
composition gate that treats absent evidence as favourable evidence inverts its
own contract. A scanner that never ran cannot vouch for anything.

The fix is small and matches what the script already does for the ledger:

```powershell
if (-not (Test-Path -LiteralPath $backendScanPath)) {
    Write-Host "BLOCKED: backend-parity-scan.json not found. Run scan-backend-parity.ps1 first." -ForegroundColor Red
    exit 2
}
```

Worth pairing with a staleness check — `$backendScanAge` is already read from
`generatedUtc` and carried, so comparing it against the ledger's own timestamp
would catch the other half of the problem: evidence that exists but predates the
code it is vouching for.

### ⚠ MEDIUM — three empty `catch { }` blocks

```powershell
} catch { }
```

Appears at the registry load, the backend-scan load and the UI-scan load. A
**malformed** artefact is therefore indistinguishable from a **missing** one, and
both resolve to zero problems. Given these files are machine-generated by other
scripts in the same pipeline, a truncated write (interrupted run, full disk) is a
realistic way to get invalid JSON — and it would silently unblock the gate.
`Write-Verbose` at minimum; ideally the same BLOCKED treatment as above.

### ⚠ HIGH — the mutation/query regex misses the kit's own starter idiom

```powershell
foreach ($m in [regex]::Matches($text, '(?i)\[Http(?:Post|Put|Delete|Patch)\]')) {
foreach ($m in [regex]::Matches($text, '(?i)\[HttpGet\]')) {
```

Both patterns require a `]` **immediately** after the verb, so they match
`[HttpPost]` but **not** `[HttpPost("Search")]`.

The starter's own `MyEntitiesController.cs` — already transcribed in this import —
uses `[HttpPost("Search")]`. Attribute-routed controllers with route templates
are the modern idiom and are what the kit itself ships as the exemplar.

Two things follow, and the second is the sharper one:

1. **This gate fails closed, not open.** `$modernMutationCount` comes back `0`,
   the `mutate` branch requires `$modernMutationCount -gt 0`, so every `mutate`
   entry is judged unimplemented and blocks. Safer than the siblings' failure
   direction, but it means a **correctly modernized app gets BLOCKED**, and under
   the kit's own law (*"never soften or overrule a gate result"*) the only escape
   is a waiver in `functional-parity-registry.json` — polluting the waiver
   registry with entries that exist to work around a regex.
2. **The sibling gate uses a different, correct pattern for the same job.**
   `scan-backend-parity.ps1` matches `'(?im)\[\s*Http(Get|Post|Put|Delete|Patch)\b'`
   — a `\b` boundary, which handles both forms. So two gates in one directory
   disagree about how to detect an HTTP verb attribute, and the composition gate
   is the one that is wrong. Aligning on the `\b` form is a one-character-class
   change.

### ⚠ MEDIUM — `export` detection can barely fail

```powershell
if ($text -match '(?i)export|download|FileContentResult|FileStreamResult|\.csv\b|\.xlsx\b|pdf') {
    $hasExportEndpoint = $true
}
```

Matched against the **entire file text**, case-insensitively, with no word
boundary on `pdf` and none on `export`/`download`. Any controller containing the
substring `pdf` anywhere — an identifier like `pdfService`, a `using` line, a
comment, the word "exported" in a doc comment — flips the flag true for the whole
repository.

`export` gaps are Minor and non-blocking, so the blast radius is small. But as
written this is a check that essentially cannot fail, which is worth knowing
before anyone cites it as evidence.

### ⚠ MEDIUM — `mutate` and `read` verdicts are global, not per-entry

```powershell
'mutate' { ($missingMutCount -eq 0 -and $modernMutationCount -gt 0) }
'read'   { ($missingQueryCount -eq 0 -and $modernQueryCount -gt 0) }
```

Neither branch references `$entry`. Every `mutate` entry in the ledger therefore
receives the **same** verdict, and the same generic `$reason` string.

For a file whose stated purpose is that *"every interactive legacy control starts
at Inventoried (Step 3) and must reach Verified before a step can close"*, that
is a real limitation: the ledger cannot say *which* control is still missing, only
that the mutation surface as a whole is incomplete. One missing legacy POST marks
all N mutate controls unimplemented; fixing it flips all N at once. The
per-control granularity the ledger promises is not delivered for the two most
important classes.

The data to do better exists — `backend-parity-scan.json`'s `gaps[]` carries
`controller`, `verb`, `method` and `route` per gap — so matching a ledger entry's
`resolvedTarget`/`label` against those would localise it. That is a genuine
enhancement rather than a bug fix, and it is the thing that would make this file
live up to its own description.

### ⚠ MEDIUM — a pre-Phase-1 ledger silently disables the whole gate

```powershell
# Detect whether the ledger was generated with the Phase 1 effectClass schema.
# If not, the scanner degrades gracefully: treats all entries as ui-only and warns.
$hasEffectClassSchema = ($entries.Count -gt 0 -and ...)
```

…and `ui-only` always evaluates `$true`. So a ledger written before the
`effectClass` field existed produces: every entry `ui-only` → every entry
implemented → zero blocking gaps → **exit 0**.

The degradation is deliberate, documented in the comment, and surfaced in the
console line `Ledger : {0} entries (Phase-1 schema: {1})`. That is honest. But
the consequence is that a **stale Step-3 artefact turns the gate off entirely**,
and the only signal is a `False` in a status line that `-Quiet` suppresses. Given
the kit's `+2` step-numbering history and its unfinished `step-registry.json`
migration, stale artefacts from an earlier kit version are a realistic scenario.

Emitting `WARNING:` on `$hasEffectClassSchema -eq $false` regardless of `-Quiet`
would cost one line and preserve the graceful degradation.

---

### What the three parity gates look like together

| | dto-coverage | backend-parity | functional-ledger |
|---|---|---|---|
| Legacy-anchored | ✅ | ✅ | ✅ (via the Step-3 census) |
| Blocks on missing primary input | ❌ exit 0 | ❌ exit 0 | ✅ exit 2 |
| Blocks on missing evidence input | n/a | n/a | ❌ treats as clean |
| `-Quiet` keeps a result line | ❌ | ❌ | ✅ |
| Declares its own blind spots | ❌ | partial (`-StrictReads`) | ✅ (`open-dialog`) |
| Verb-attribute regex | n/a | `\b` (correct) | `\]` (misses templates) |
| Waiver registry | ✅ | ✅ | ✅ (+ entry-level `waiver`) |

The pattern is consistent and encouraging: **every good practice needed to fix
these gates already exists in one of them.** The recommendation is therefore not
"redesign the parity layer" but "normalise it against its own best example", and
the `shared/` helper proposed in the `scan-backend-parity` entry is the natural
vehicle — `Assert-InputArtifact`, `Exit-Gate`, and a single agreed
`$HttpVerbAttributePattern` would close most of what has been found across all
three.

---

### COMPLETED — `scan-functional-parity-ledger.ps1` (376 lines)

The remaining 94 lines close the `$reason` switch, build `$blockingGaps`,
de-duplicate, assemble `$result`, and exit. Three things worth adding to the
entry above.

**⚠ CORRECTION — the `-Quiet` praise was premature.** The previous entry
contrasted this file's documented contract (*"Suppress per-gap detail lines.
Still emits the RESULT: line and exit code"*) favourably against
`scan-backend-parity.ps1`. The **implementation does not honour it**:

```powershell
if ($majorGaps -gt 0) {
    if (-not $Quiet) {
        Write-Host ("RESULT: BLOCKED ({0} major gap(s) ...)" -f $majorGaps) -ForegroundColor Red
    }
    exit 2
}
if (-not $Quiet) {
    Write-Host "RESULT: OK" -ForegroundColor Green
}
exit 0
```

Both `RESULT:` lines are inside `if (-not $Quiet)`. Only the exit code survives,
which is exactly what the parameter documentation promises it will not do. So the
better contract exists **on paper only**, and the doc/code mismatch is the finding
rather than the good example I reported. Fixing it is moving two `Write-Host`
calls outside their guards.

**★ Sensible de-duplication, with honest counts.** `$blockingGaps` keeps every
gap for counting, and a separate `$deduped` list keeps only the **first three per
effectClass** for the artefact — because *"most entries of the same class share
the same root cause"*. `$majorGaps`/`$minorGaps` are computed from the **full**
list, so the counts stay accurate while the payload stays readable. That is the
right way to truncate, and it is the opposite of the silent-cap pattern.

**The `RESULT: BLOCKED` / `RESULT: OK` strings are confirmed here**, matching the
kit's stated convention exactly — first direct sighting of both in a gate.

---

## `parity/scan-scaffold-debt.ps1` (221 lines) — the best-designed gate so far

Detects **modernization deferral markers** that survive into shipped code: the
`"Handlers call empty stub methods; Step 11 wires real behavior"` breadcrumbs
that a scaffolded page leaves behind. Its own framing:

> *"The dead-shell failure mode is a page migrated as a from-memory SCAFFOLD
> whose controls, forms, and handlers are stubbed and whose real behavior is
> deferred to 'a later step'. Those scaffolds routinely ANNOUNCE their own debt in
> the code... No parity/runtime gate scanned for these surviving markers, so the
> debt shipped silently."*

Third postmortem-driven gate in the same directory.

### ★★ Drain semantics — the single best idea in the kit's gate layer

```powershell
} elseif ($CurrentStep -gt 0 -and $null -ne $impliedStep -and $impliedStep -le $CurrentStep) {
    $severity = 'overdue'    # owning step reached/passed but debt survives -> block
} elseif ($Strict) {
    $severity = 'overdue'    # closeout strictness: any surviving marker blocks
}
```

The gate parses the **owning step number out of the marker text**
(`step\s+(\d+)`) and compares it against `-CurrentStep`. A note saying
*"Step 11 wires this"* is **tracked** (non-blocking) through Steps 3-10 and
becomes **overdue** (blocking) the moment Step 11 is reached.

That solves a problem no other gate in the kit addresses: scaffolding is
legitimate *during* a migration and a defect *after* it, and a binary gate can
only pick one. This one is time-aware. `-Strict` promotes everything at Phase-2
close, so untimed markers are caught too.

It is also the answer to a question raised repeatedly in this review — how to
gate something that is acceptable now and unacceptable later — and it is
reusable well beyond scaffold comments.

### ★ The rule set documents its own false-positive history

```
# The word 'placeholder' is deliberately NOT a trigger: it is
# a real input feature and appears in correct code, so matching it produced false positives on
# known-good wrappers.
```

Nine regex rules, each described as *"unambiguous modernization-scaffold
LANGUAGE, not app terms"*, with an explicit note about a rule that was tried and
removed. `ScaffoldPlaceholder` (the literal CSS class `scaffold-placeholder`) is
carved out as always-blocking regardless of step, with the reasoning stated: a
rendered placeholder *is* shipped debt at any step.

### ⚠ MEDIUM — the vacuous-pass shape persists, but this one fails better

```powershell
if ($overdue.Count -gt 0) { exit 2 } else { exit 0 }
```

Same terminal pattern. If `$files` comes back empty — wrong client root, a client
that is not Angular, a `src/` that does not exist — there are no findings and the
gate exits 0.

**But it is the best-guarded of the four.** Unlike the two `scan-*-parity`
scripts it `throw`s when the client root cannot be resolved at all:

```powershell
throw "Could not determine ModernClientRoot. Pass -ModernClientRoot or populate .modernization/.readme/kit-params.md with appName."
```

So the common misconfiguration is caught. What is not caught is a root that
resolves but contains nothing matching `*.ts,*.html` — and `filesScanned` is
already in the artefact, so the same three-line guard applies.

### Smaller observations

- **`break` after the first matching rule per line** — one finding per line, so
  rule order in `$MarkerRules` determines which `Kind` is reported. `StepDeferral`
  is first, which is the most specific, so the ordering is deliberate and correct.
- **Text is truncated to 200 characters** before being recorded, which keeps the
  artefact readable. Reasonable, and unlike a silent cap it cannot hide a finding.
- **`.spec.ts` is excluded** from the scan. Defensible (test scaffolding is
  expected), but worth knowing: a deferral marker parked in a spec file is
  invisible to this gate, and the kit's specs are already the weakest part of the
  starter.
- **The accepted-marker registry matches on substrings** (`-like '*...*'` on both
  file and text), which is looser than the parity gates' exact comparisons. A
  broad `textContains` waiver could silence more than intended.

---

## `parity/scan-ui-parity-gaps.ps1` (lines 1-290 of N) — PARTIAL

The UI-side sibling, and it closes the artefact chain: this produces
`ui-parity-gap-scan.json`, which `scan-functional-parity-ledger.ps1` reads for
its `filter` verdict. Committed as `.PARTIAL.ps1` with a delimited trailing note;
everything from `$ParityDimensions` / `Scan-File` onward is unphotographed and the
file **must not be executed**.

Seven gap kinds: `MissingControl`, `MissingColumn`, `InertControl`,
`MissingIcon`, `IconMismatch`, `LowControlCoverage`, plus `passiveLabelDrops`
which are *"reported, never silently zeroed"*.

### ★★ The honesty rules — a waiver system that cannot hide what it waives

```
# Honesty rules for the deferral list (the previous failure mode was an
# app-specific hardcoded allowlist that permanently blinded the inert gate):
#   1. A suppressed handler is STILL counted and listed in deferredInertControls[],
#      so inertControlCount = 0 can never hide N parked stubs.
#   2. When -CurrentStep is passed and a deferral's owner step is reached or passed
#      (ownerStep <= CurrentStep), the deferral is STALE and is re-flagged as a Major
#      InertControl (the drain gate) instead of being suppressed.
```

This is the strongest governance design found anywhere in the kit, and it
directly answers a concern raised twice in this review — that waivers accumulate
and quietly become permanent blindness.

Rule 1 means a waiver **suppresses the block but not the visibility**: the
suppressed handler still appears in `deferredInertControls[]`, so nobody can read
`inertControlCount: 0` as "no parked stubs". Rule 2 applies the same
**drain semantics** as `scan-scaffold-debt.ps1` — a deferral with an owner step
expires the moment that step is reached, and re-arms as a Major.

Together they make a waiver a *dated loan* rather than a pardon. That is the
pattern the other gates' `acceptedDrops[]` registries should adopt: today those
are permanent and invisible once written.

The comment also names the failure mode it replaced — *"an app-specific hardcoded
allowlist that permanently blinded the inert gate"* — which is the fourth
postmortem-driven design decision found in `parity/`.

### ★★ "A gate that fails a control that is actually present is as dishonest as one that passes a missing control"

```
# it sees native <button> and <fusion-button>; otherwise it is blind to every wrapped
# control and reports FALSE MissingControl gaps after a wrapper-swap pass (a gate that fails
# a control that is actually present is as dishonest as one that passes a missing control).
```

Stated explicitly, in the source. **False blocking and false passing are treated
as equally serious.**

That principle is exactly what the `scan-functional-parity-ledger.ps1` finding
violates — its `\[Http(?:Post|Put|Delete|Patch)\]` regex misses
`[HttpPost("Search")]` and therefore blocks correctly-modernized apps. The kit
**has** the right principle written down; it simply is not applied uniformly. As
with the missing-input guard, the fix is consistency, not invention.

### ★ App-agnosticism is enforced by derivation, not by convention

```powershell
$script:AppComponentPrefix = ($appNameForPrefix -replace '[^A-Za-z0-9]', '').ToLowerInvariant()
```

The app's own wrapper components (`<filelog-command-button>` for app "FileLog")
are recognised by a prefix **derived** from `kit-params.md` `appName`, with a
fallback to the `<App>.Web.Client` folder name — *"so no app identity is
hard-coded here."* The registry comment repeats it: *"this reusable script
carries no app identity (no app-shaped labels, handler names, or feature
names)."*

This is the discipline that makes the kit survive a few hundred participants:
every app fact lives in per-app JSON, every rule lives in the shared script. It
is applied more rigorously here than in any other file reviewed.

### ⚠ MEDIUM — `LowControlCoverage` is off by default

```powershell
# default so early foundation passes are not blocked while coverage is legitimately low.
[double]$CoverageFloor = 0,
```

The check that would catch the bluntest failure of all — *modern has 3
interactive controls where legacy had 200* — **never fires unless a caller passes
`-CoverageFloor`**. The rationale is sound (early passes shouldn't be blocked),
and it mirrors `scan-scaffold-debt`'s `-Strict`. But it means the safety net
depends entirely on some closeout step remembering to pass the flag, and nothing
in the transcribed material shows which step does. Worth confirming against the
prompts: if no caller sets it, this check is dead code.

### ⚠ MEDIUM — interpolated modern labels normalize to empty

```powershell
$t = $t -replace '\{\{[^}]*\}\}', ' '
...
return $t.Trim().ToLowerInvariant().TrimEnd(':').Trim()
```

`Normalize-Label` strips Angular interpolations to a space. A modern control
whose label is entirely `{{ item.name }}` or `{{ 'buttons.save' | translate }}`
therefore normalizes to the **empty string** and can match no legacy label.

Legacy `.cshtml` labels are usually static text; modern Angular labels are
frequently interpolated or translated. If label matching is the only join key,
that produces **false `MissingControl` gaps** — precisely the dishonesty the file
elsewhere warns against.

The `testId="..."` / `data-testid="..."` extraction mentioned in the header is the
obvious mitigation (match by test id when the label is dynamic), and the matcher
itself is in the unphotographed remainder. **Recorded as a risk to confirm, not a
confirmed defect** — the rest of the file may already handle it.

### Smaller observations

- **`'lock'` and `'unlock'` both map to `fa-edit`** in `$SemanticIconMap`, so the
  two are indistinguishable to `IconMismatch`. Presumably faithful to the app's
  wrapper; worth a comment in the source so it does not read as a copy-paste slip.
- **`Resolve-IconTokens` drops unknown `semantic:*` markers** rather than
  reporting them, *"treated as 'has icon, unknown glyph'... so they no longer
  create false IconMismatch noise."* Correct call, and another instance of the
  false-positive discipline.
- **FA4 alias normalization** (`fa-save` ↔ `fa-floppy-o`, `fa-edit` ↔
  `fa-pencil-square-o`) removes mismatch noise *"that has no visual impact at
  runtime"* — the right level of abstraction for a parity check.
- **`MissingColumn` reads `<th>`, ag-grid `headerName`, ColDef titles and
  Fusion/Kendo grid-column titles.** The Fusion/Kendo branch ties directly to the
  grid components found in the starter, and the described defect — *"a grid loads
  real data in fewer or more generic columns than legacy"* — is the same
  column-collapse family as `scan-api-dto-coverage`'s `FileLogResponse`
  postmortem, caught from the UI side instead of the DTO side.
- **`throw` on an unresolvable client root**, matching `scan-scaffold-debt.ps1`
  and unlike the two `scan-*-parity` scripts.

---

### Extended to line 394 — the discovery probe

Two more design ideas worth recording, both from the 291-394 range.

#### ★★ The discovery probe — a gate that reports its own blind spots

```
# The discovery probe is the answer to "future mysteries": after every known
# rule pack runs, we walk every legacy <a>/<button>/<li> block and collect the
# attribute names + AngularJS directives + class-token families that NO rule
# pack consumed. The output ranks them by frequency so the next app's first
# parity defect immediately tells you which rule pack to add next. Coverage
# converges to 100% as the registry grows.
```

`Probe-LegacyControl` harvests every attribute and class token the scanner did
**not** understand, tallies them, and emits them ranked by frequency. Two
allow-lists (`$KnownLegacyAttributes`, ~60 entries including the full AngularJS
`ng-*` set; `$KnownLegacyClassPrefixes`, the Bootstrap-3 vocabulary) define
"understood"; everything else is surfaced as unexplained.

This is the structural answer to the single most repeated finding in this review.
Every other gate silently ignores what it cannot parse — the `*View.cs` filename
filter, the `[HttpPost]`-without-template regex, the attribute-only endpoint
discovery. **This one measures its own ignorance and hands you a prioritised
worklist.** Applied to a hackathon it is worth more than any individual rule:
each participant's unusual legacy app makes the shared rule packs better instead
of silently passing.

If one idea from `parity/` should be generalised across the kit, it is this one.

#### ★ The wrapper-suffix heuristic, and why containers are excluded

```
# IMPORTANT: only match button-action-shaped wrappers (names ending in -button/-btn/-link/
# -action/-cmd). Container-shaped wrappers like <filelog-modal>, <filelog-data-grid>,
# <filelog-dropdown> must NOT be included here: the block regex is non-overlapping, so
# if a container wrapper is matched as one block its inner <filelog-command-button> children
# are swallowed and never seen as separate records - producing false MissingControl gaps for
# the Cancel/Submit buttons inside the modal.
```

A precise, hard-won constraint: because `[regex]::Matches` is non-overlapping,
matching a container wrapper hides every control inside it. The fix is a generic
suffix heuristic (`*-button`, `*-btn`, `*-link`, `*-action`, `*-cmd`) rather than
an app-specific list — *"any app that names its button wrapper ... is covered."*
Third instance in this file of app-agnosticism achieved by derivation.

Also worth noting: `Scan-File` strips **both** `<!--...-->` and Razor `@*...*@`
comments before scanning, *"so commented-out legacy markup is not treated as live
UI"* — a false-positive source that would otherwise inflate the legacy control
count and make the modern side look worse than it is.

---

### Extended to 454 — the interactivity test

`Scan-File`'s control record is where the `MissingControl` severity is actually
decided, and the breadth of the interactivity test is the point:

```powershell
$interactive = ($tag -eq 'button') -or (-not [string]::IsNullOrWhiteSpace($handler)) -or $hasRealHref -or $hasRouterLink -or $hasSubmit -or $hasTrigger -or ($iconList.Count -gt 0)
```

with the reasoning stated above it:

```
# Interactivity: is this control's absence a real parity defect? This
# captures far more than the click handler alone so navigation links,
# routerLinks, form submits, and modal/dropdown triggers are never
# silently dropped the way a routerLink-only nav link used to be.
```

Seven independent signals — tag, click handler, a **real** href (`#` and
`javascript:void` explicitly excluded), `routerLink`, `type="submit"` /
`(ngSubmit)`, Bootstrap/ngb trigger attributes, and the presence of an icon. A
control only has to satisfy one. That breadth is deliberate: the named
regression was *"a routerLink-only nav link"* that had no click handler and was
therefore invisible to a handler-only check.

Two smaller notes:

- **The discovery probe runs on the legacy side only** (`if ($kind -eq 'legacy'
  -and $script:DiscoveryBag)`), which is right — the point is to learn what
  legacy vocabulary the rule packs do not yet cover.
- **A control with no label is still recorded** when it has a `testId` or a
  handler (`if (IsNullOrWhiteSpace($label) -and -not $testId -and -not $handler)
  { continue }`). That partially mitigates the `Normalize-Label` interpolation
  risk flagged earlier: an icon-only or `{{...}}`-labelled button survives into
  the record set as long as it carries a test id or a handler. Whether the
  *matcher* can then pair it with a legacy control is decided in the untranscribed
  455-831 range, so the risk is reduced but not yet closed.

---

## `parity/selftest-backend-parity.ps1` (170 lines) — the gates have tests

This is the most important discovery in `.github/scripts/` so far, and it revises
the tone of several earlier entries. **The kit tests its own gates.**

```
.SYNOPSIS
    App-agnostic self-test for the legacy-anchored backend functionality-parity gate
    (scan-backend-parity.ps1). Proves the gate HONESTLY catches dropped mutation endpoints and
    cannot be silently re-blinded.
```

*"Cannot be silently re-blinded"* is the operative phrase. This exists because a
gate that was working can be quietly broken by a later edit — a widened
allow-list, a loosened regex, a mishandled empty case — and nothing would notice.
That is a category of risk this review has raised repeatedly, and the kit already
has the standard answer to it: an executable regression test.

### How it works

`Invoke-BackendCase` writes **synthetic legacy and modern controller trees** into
a temp directory, runs the **real** `scan-backend-parity.ps1` as a child process,
and reads the JSON artefact back:

```powershell
$null = & powershell @psArgs 2>&1
$code = $LASTEXITCODE
...
if (Test-Path -LiteralPath $out) { $json = Get-Content -LiteralPath $out -Raw | ConvertFrom-Json }
return [pscustomobject]@{ Result = $json; ExitCode = $code }
```

Three details worth calling out:

- **It runs the gate as a separate process**, with the reason stated in a
  comment: *"so `exit` is the reliable process exit code; assertions read the JSON
  output file, never stdout."* That is exactly right — testing a gate means
  testing its **exit code**, and an in-process dot-source would swallow it.
- **`finally { Remove-Item ... }`** cleans the temp tree on every path, so a
  failing assertion cannot leave fixtures behind.
- **The fixtures are minimal but realistic** — a legacy `FileKeysController` with
  GET/POST/PUT/DELETE, a read-only modern port (the failure mode), and a
  full-parity modern port (the control case).

### The six cases are exactly the right six

| # | Asserts |
|---|---|
| 1 | 3 dropped mutations are counted (`missingMutationCount = 3`) |
| 2 | dropped mutations **block** (exit 2) |
| 3 | the *covered* GET is **not** falsely flagged (`missingQueryCount = 0`) |
| 4 | full parity yields zero gaps and exit 0 |
| 5 | an `acceptedDrops` registry entry downgrades an intentional drop, exit 0 |
| 6 | `-StrictReads` escalates a missing GET to blocking |
| 7 | an entirely-dropped controller is surfaced in `droppedControllers[]` |

Case 3 is the one that matters most and is the easiest to omit: it tests for a
**false positive**, not a false negative. That is the same
*"a gate that fails a control that is actually present is as dishonest as one
that passes a missing control"* principle found in `scan-ui-parity-gaps.ps1`,
here enforced executably rather than stated in a comment.

Case 5 is the second-best: it proves the waiver mechanism actually works, which
means a team can trust `acceptedDrops` without reading the gate's source.

### ⚠ What the self-test does **not** cover — the vacuous pass

None of the seven assertions exercises the empty-input path. There is no case
that runs the gate against a legacy tree containing **no** matching controllers
and asserts the outcome.

That is the gap recorded against `scan-backend-parity.ps1` — an app whose
controllers do not match `*Controller*.cs`, or that uses convention-based MVC5
routing, produces an empty legacy set, zero gaps, and **exit 0**. The self-test
would pass unchanged if that behaviour were correct or incorrect, because it
never asks.

The fix is now much smaller than previously described. The harness already
exists; it is one more `Invoke-BackendCase` call:

```powershell
# --- Test 7: an empty legacy tree must NOT be reported as clean ---
$t7 = Invoke-BackendCase -LegacyControllers @{} -ModernControllers @{ 'FileKeysController.cs' = $modernFileKeysFull }
Assert-That 'T7 an unscannable legacy tree does not exit 0' ($t7.ExitCode -ne 0) ("exit {0}" -f $t7.ExitCode)
```

Written today that assertion **fails** — which is the point. Adding it first, then
fixing the gate to satisfy it, is the correct order and takes under an hour.

### What this changes about the earlier findings

Several entries in this review have described gate defects as if nobody had
thought about gate quality. That framing was too harsh, and this file is the
evidence. The kit's authors clearly understand that gates need regression tests,
false-positive coverage, process-level exit-code assertions, and cleanup — and
implemented all of it here.

The consistent pattern across `.github/scripts/parity/` is now unmistakable and
worth stating as the single most useful conclusion of this whole review:

> **Every practice needed to make these gates trustworthy already exists somewhere
> in this directory. None of them exists everywhere.**

Missing-input guards (in the ledger), honest waivers (in the UI gate), drain
semantics (in scaffold-debt and the UI gate), self-reported blind spots (the
discovery probe), false-positive discipline (stated in the UI gate, enforced
here), and executable regression tests (here). Six good ideas, each present in one
or two of six files.

The highest-value work before the hackathon is therefore **not** writing new
gates. It is a normalisation pass: extract the shared helpers into
`.github/scripts/shared/`, and write a `selftest-*.ps1` for each remaining gate
modelled on this one — starting with the empty-input case that all of them
currently get wrong.

Whether the other gates have self-tests is unknown; the file tree lists
`parity/` as *"11 scan-*/selftest-*/verify-gate-integrity scripts"*, so at least
one more `selftest-*` and a `verify-gate-integrity` exist. **Those are now the
files worth photographing next** — `verify-gate-integrity` in particular sounds
like the meta-gate that would run these self-tests in CI.

---

## `parity/selftest-functional-parity-ledger.ps1` (lines 1-121 of N) — PARTIAL

A **second** self-test, and that matters more than its contents: one self-test is
a good instinct, two is a **convention**. `.github/scripts/parity/` is listed in
the file tree as *"11 scan-*/selftest-*/verify-gate-integrity scripts"*, so on
this evidence most or all of the scanners have paired regression tests.

Structurally it mirrors `selftest-backend-parity.ps1` closely — `Assert-That`,
an `Invoke-*Case` harness that builds a synthetic tree, runs the real scanner
out-of-process, reads the JSON artefact, and cleans up in `finally`. The fixtures
are richer because the ledger is a composition gate: `Invoke-LedgerCase` writes
**four** discovery artefacts plus a synthetic `routes.config.ts` and an optional
controller, all under a temp `src/TestApp.Web.Client` / `src/TestApp.Web.Api`
tree.

### ★ It uses neutral fixture identity

```powershell
$clientDir = Join-Path $root 'src/TestApp.Web.Client/src/app'
$apiDir    = Join-Path $root 'src/TestApp.Web.Api/Controllers'
```

`TestApp`, not the real application name — so the self-test exercises the
kit's app-agnostic path derivation rather than accidentally depending on one
app's identity. Consistent with the discipline recorded against
`scan-ui-parity-gaps.ps1`.

### CONFIRMED — the degraded-mode exit 0 is deliberate and locked in by a test

Assertion 1 in the header:

> *1. A ledger with NO effectClass schema (old format) -> scanner exits 0 but sets
> hasEffectClassSchema: false (degraded mode, not blocking, warns operator).*

The `scan-functional-parity-ledger.ps1` entry recorded that a pre-Phase-1 ledger
marks every entry `ui-only`, which always evaluates true, so a **stale Step-3
artefact silently disables the gate**. That is now confirmed as **intentional**,
and there is a regression test asserting it.

That changes the framing but not the recommendation. It is a deliberate
backward-compatibility tradeoff, not an oversight — so it should be argued with
rather than "fixed". The argument: the operator warning is the only signal, and
it is suppressed by `-Quiet`, which is how the gate is invoked in the documented
examples. Emitting `WARNING:` unconditionally would preserve the intended
non-blocking degradation while removing the silence. One line, no behaviour
change to the exit code, and the existing assertion still passes.

### The six cases, and what is still missing

Cases 2-6 cover blocking mutate gaps, passing mutate gaps, blocking filter gaps
via `PlaceholderAction`, waiver respect, and `navigate` gaps staying Minor. That
is thorough — including case 3 and case 6, both of which assert a **non**-block,
which is the false-positive direction.

As with the backend self-test, **no case exercises a missing evidence artefact.**
Every fixture supplies all four discovery JSON files, with `$BackendScanJson` and
`$UiScanJson` defaulting to well-formed "everything is clean" content. The
finding recorded against the scanner — that an absent `backend-parity-scan.json`
is indistinguishable from a clean one — is therefore untested in exactly the same
way the empty-legacy-tree case is untested for the backend gate.

The harness makes the fix trivial: `Invoke-LedgerCase` would need a switch to
*skip* writing one of the artefacts, then an assertion that the run does not exit
0. Same one-hour shape as the backend suggestion, and the two together would
close the vacuous-pass family across the whole `parity/` directory.

---

### The tail (284-341) — six cases confirmed, and the summary

The last photo covers the final four case blocks and the summary. Held as
`selftest-functional-parity-ledger.TAIL-284-341.ps1` rather than spliced into the
partial, because **lines 122-283 are still missing** and a file with an invented
gap would be worse than two honest fragments. The source is **340 content lines**.

Cases 3-6 as written:

| Case | Fixture | Asserts |
|---|---|---|
| 3 | mutate entry, backend fully ported | exit 0, `mutate.implemented = 1`, `majorGaps = 0` |
| 4 | filter entry, UI scan has `PlaceholderAction` | exit **2**, `filter.unimplemented = 1`, `majorGaps ≥ 1` |
| 5 | mutate entry blocked **+ registry waiver** | exit 0, `mutate.waived = 1`, `majorGaps = 0` |
| 6 | navigate entry, route absent from `routes.config.ts` | exit 0, `navigate.unimplemented = 1`, `majorGaps = 0`, **`minorGaps = 1`** |

Two things stand out.

**Case 6 asserts the Minor/Major boundary in both directions.** It checks
`majorGaps -eq 0` *and* `minorGaps -eq 1` — so a future change that promoted
`navigate` to blocking would fail the suite, and so would one that dropped the
gap entirely. Most test suites assert only the direction they care about; this
one pins both sides. That is the same false-positive discipline seen in
`selftest-backend-parity.ps1`'s case 3, applied to severity rather than presence.

**Case 5 asserts the waiver is *counted*, not just tolerated** —
`byEffectClass.mutate.waived -eq 1`, not merely `exit 0`. That is the executable
form of the honesty rule stated in `scan-ui-parity-gaps.ps1`: a waiver must
remain visible in the output. Two files apart, principle and enforcement.

The summary reports `$script:passCount` on success — so a green run states **how
many** assertions passed, which makes a silently-shrinking suite detectable.

### Net position on the two self-tests

Between them, `selftest-backend-parity.ps1` (complete, 170 lines) and this one
(340 lines) establish that the kit's gate layer is regression-tested to a
standard most internal tooling never reaches: real scanner invoked
out-of-process, exit codes asserted, artefact contents asserted, both severity
directions pinned, waiver accounting verified, temp fixtures cleaned up, and
neutral app identity throughout.

The single gap remains the same in both, and is now precisely stated:

> **Neither self-test constructs a case where an input the gate depends on is
> absent.** Every fixture writes every artefact; every legacy tree contains
> matching files.

That is the one test that would catch the vacuous-pass family, and both harnesses
are one parameter away from being able to express it.

---

## `parity/selftest-parity-gate.ps1` (lines 1-66 of N) — PARTIAL

The **third** self-test, and its header contains the most sophisticated idea in
`.github/scripts/` — enough that the 66 lines transcribed are worth more than
most complete files in this import.

### The origin story, stated plainly

```
The original modernization failure mode was a parity gate that reported majorGaps=0 while
the app was missing half its controls, because an app-specific allowlist hard-coded into the
reusable scanner permanently suppressed the inert-control signal.
```

**A gate reported zero gaps while half the app was missing.** Not because the
logic was wrong, but because an allow-list added to fix one app's noise became
permanent blindness for every app after it. That is the precise failure this
review has been circling from the outside — and the kit not only found it, it
wrote a test to prevent its return.

### ★★★★ Static anti-re-blinding guards — tests that read the gate's source

Assertions 1-5 are behavioural (synthetic fixtures, real scanner, exit codes).
Assertions **6-8 are different in kind**:

```
Static anti-re-blinding guards (regression locks on the reusable assets):
  6. scan-ui-parity-gaps.ps1 ships an EMPTY inert allowlist default and carries no known
     app-specific handler/label/feature tokens.
  7. scan-ui-parity-gaps.ps1 still emits deferredInertControls and accepts -CurrentStep.
  8. verify-step-artifacts.ps1 still contains the Step 11/12 parity + deferral-drain gate.
```

These do not run the gate. They **inspect the gate's own source text** and assert
structural properties of it:

- that the shipped allow-list is still *empty* — i.e. nobody has quietly
  re-hard-coded an app's handler names into the reusable script;
- that the honesty mechanism (`deferredInertControls`) and the drain mechanism
  (`-CurrentStep`) still *exist*;
- that a **different file entirely** (`shared/verify-step-artifacts.ps1`) still
  contains the Step 11/12 enforcement.

This is a regression lock against a class of change that behavioural tests
cannot catch. A behavioural test passes if the gate correctly blocks the fixture
you gave it; it says nothing about whether someone added
`$inertControlAllowlist['SaveInvoice'] = '...'` to the shared scanner last
Tuesday. Assertion 6 catches exactly that.

Three things follow, and they matter for the hackathon:

1. **This is the answer to "the kit will drift when 200 people edit it."** The
   concern raised at the start of this work was that a shared kit degrades as
   teams patch it for their own apps. Assertion 6 is a mechanical, executable
   defence against the single most likely form of that degradation.
2. **It generalises.** The same technique — a self-test that greps the reusable
   asset for tokens that should never appear in it — applies to every shared
   script in the kit, not just this one. It is cheap to write and it fails loudly.
3. **It reaches across directories.** Assertion 8 asserts on
   `shared/verify-step-artifacts.ps1`, which the partial confirms is resolved as
   `$PSScriptRoot/../shared/verify-step-artifacts.ps1`. So the parity self-test
   is also a guard on the artifact verifier — the first hard evidence of what
   lives in `shared/`, and the first cross-directory coupling seen.

### Note on the harness — this one runs in-process

```
# The scanner is invoked in-process with the call operator; its `exit` sets $LASTEXITCODE and
# returns control here. Assertions read the JSON output file, never stdout, so console
# truncation is irrelevant.
```

This differs from `selftest-backend-parity.ps1`, which deliberately shells out
*"so `exit` is the reliable process exit code"*. Both files explain their choice;
they simply disagree. In-process `& $scanner` does set `$LASTEXITCODE` in
PowerShell, so the claim here is defensible — but the backend self-test's
reasoning is the safer one, because an in-process `exit` inside a script invoked
with `&` terminates *that script* and can behave differently under
`-ExecutionPolicy`/dot-sourcing variations. **A third inconsistency between
sibling files**, consistent with the pattern recorded throughout this review.

### Position

`parity/` now shows **three** self-tests plus a `verify-gate-integrity` script
still unseen. The gate layer is not merely tested; it is tested against its own
regression history, with the specific past failures named in the source. That is
a materially stronger engineering posture than anything else in this import, and
it deserves to be said clearly after a long sequence of defect findings.

The outstanding recommendation is unchanged and now has a proven template:
**add one empty-input case to each self-test.** Assertions 6-8 here prove the
authors are willing to write unusual, high-value tests; the vacuous-pass case is
ordinary by comparison.

---

## `parity/selftest-scaffold-debt.ps1` (lines 1-65 of N) — PARTIAL

A **fourth** self-test. That is now four paired regression suites across the six
`scan-*` gates transcribed, which settles the question raised earlier: the file
tree's *"11 scan-\*/selftest-\*/verify-gate-integrity scripts"* is almost
certainly **~5 scanners + ~5 self-tests + the integrity checker**. Self-testing is
not a habit some author had once; it is how this directory is built.

### It tests the false-positive direction explicitly, again

```
proves the scaffold-debt detector flags
surviving deferral markers, extracts owning steps, drains overdue markers, honors -Strict and
the accepted-marker registry, and does NOT false-flag real code (HTML placeholder attributes
or comments describing an improvement over an old placeholder).
```

That final clause is the one worth noting. `scan-scaffold-debt.ps1`'s own rule
set documents a rule that was tried and removed — matching the bare word
`placeholder` produced false positives on known-good wrappers. **The self-test
locks that removal in.** A future contributor who "improves" the detector by
re-adding a `placeholder` pattern fails this suite immediately.

That is the same anti-re-blinding intent as `selftest-parity-gate.ps1`'s static
guards, expressed behaviourally: the rule set's documented history is not just a
comment, it is an executable constraint. Two different mechanisms, same
discipline.

Note also the specific false-positive fixture described: *"comments describing an
improvement over an old placeholder"*. That is a genuinely subtle case — a
comment saying "replaced the old placeholder grid with a real data grid" contains
the trigger vocabulary while describing the **opposite** of debt. Testing for it
shows the author thought about how their own detector reads English.

### CORRECTED — the harness convention is out-of-process; `selftest-parity-gate` is the outlier

```
# Run the scaffold-debt scanner against a synthetic modern tree. Child-process invocation keeps
# the exit code reliable; assertions read the JSON output file, never stdout.
```

The `selftest-parity-gate.ps1` entry recorded an inconsistency between siblings —
one running the scanner in-process, one out-of-process — and treated it as an
even split. With this file the tally is **3 out-of-process
(`backend-parity`, `functional-parity-ledger`, `scaffold-debt`) vs 1 in-process
(`parity-gate`)**.

So there **is** a house convention, and it is the safer one. `selftest-parity-gate.ps1`
is the single outlier, and aligning it is a small, unambiguous cleanup rather than
a judgement call between two defensible styles. Recording the correction because
the previous framing implied a genuine disagreement; it is closer to one file
drifting.

### The harness handles nested fixture paths

```powershell
$fp = Join-Path $mod $name
$dir = Split-Path $fp -Parent
if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
```

Fixture keys may be relative paths (`pages/home/home.component.ts`), and the
harness creates intermediate directories. That matters for this particular gate,
because `scan-scaffold-debt.ps1` excludes `.spec.ts` and walks `*.ts,*.html`
recursively — so testing the exclusion logic requires fixtures at realistic
depths, not a flat directory.

### Position after four self-tests

The recommendation stands unchanged and is now the only substantive item left
open against the gate layer: **none of the four self-tests constructs a case
where an input the gate depends on is absent.** Every fixture writes every file.

Everything else this review flagged in `parity/` — inconsistent guards,
inconsistent `-Quiet` contracts, divergent verb regexes, permanent waivers — is
either already solved in a sibling file or already locked down by one of these
suites. The gap is singular, well-defined, and each harness is one parameter away
from closing it.

---

## `parity/verify-gate-integrity.ps1` (86 lines) — the meta-gate, and it closes the loop

The file this review has been asking for since the first gate. It is short, and
it resolves the standing recommendation outright.

### ★★★★ RESOLVED — the vacuous-pass guard exists, at the top of the stack

```powershell
if ($selfTests.Count -eq 0) {
    Write-Host "  No gate self-tests found - nothing to verify (expected selftest-*.ps1)." -ForegroundColor Red
    exit 2
}
```

…and it is documented in `.OUTPUTS`:

> *Exit 0 when every discovered self-test passes; exit 2 when any self-test fails
> **or none are found**.*

**The runner refuses to report success when it had nothing to check.** That is
precisely the guard recorded as missing from `scan-api-dto-coverage.ps1`,
`scan-backend-parity.ps1`, `scan-ui-parity-gaps.ps1` and `scan-scaffold-debt.ps1`
— present here, deliberate, and documented.

So the finding sharpens one final time. It was never "nobody thought of this."
The pattern now appears in **two** places (`scan-functional-parity-ledger.ps1`'s
missing-ledger BLOCKED, and this runner's zero-self-tests exit 2), and is absent
from four. The recommendation reduces to: **propagate a pattern the kit already
uses twice.** That is a strictly mechanical change with a working reference
implementation in the same directory.

### ★ Auto-discovery with no registration step

```powershell
# Root to search for selftest-*.ps1. Defaults to .github/scripts so every gate self-test
# anywhere in the kit is auto-included as it is added - no registration step to forget.
$selfTests = @(Get-ChildItem -Path $ScriptsRoot -Recurse -Filter 'selftest-*.ps1' ...)
```

It searches **all of `.github/scripts`**, not just `parity/`. Adding
`selftest-<anything>.ps1` anywhere in the kit enrols it automatically. The comment
names the failure being designed out — *"no registration step to forget"* — which
is the same class of problem as the hard-coded allow-list: a manual step that
silently degrades.

This matters for the normalisation work recommended throughout this review. Any
self-test written for the four unguarded scanners is picked up by this runner
**for free**, with no manifest to update.

### ★ It declares its own limits

```
This verifies gate LOGIC. It does not, and cannot, prove a specific app is behaviorally correct
at runtime; that is the runtime interact-and-assert checkpoint's job.
```

Third instance of a script in this directory stating what it cannot prove and
naming the mechanism that covers the remainder — after `open-dialog` in the
ledger and the static-vs-runtime split in `scan-scaffold-debt.ps1`. Consistent
enough now to call it a house style rather than a coincidence.

### ★ Why gate self-tests are mandatory, stated in one sentence

> *A failing self-test means the gate no longer discriminates correctly - either a
> real defect would ship (false negative) or correct code would be blocked (false
> positive) - so the edit must not land until the self-test is green.*

Both directions, again, and an explicit merge-blocking policy. This is the
sentence to put in `CLAUDE.md` / `AGENTS.md`: it converts "run the self-tests"
from advice into a rule with a stated reason.

### The `-Quiet` question is answered, and my earlier concern shrinks

```powershell
# Do NOT forward -Quiet: the runner needs the child's [PASS]/[FAIL] lines to count assertions;
# -Quiet controls only the runner's own summary verbosity, captured output is not displayed
# unless the self-test fails.
```

Two earlier entries flagged `-Quiet` inconsistencies in the self-tests and gates
— notably that `scan-functional-parity-ledger.ps1` suppresses its own `RESULT:`
line despite documenting otherwise. **The runner never forwards `-Quiet` to a
child**, so within the sanctioned invocation path those inconsistencies do not
bite: every self-test runs verbose, its `[PASS]`/`[FAIL]` lines are counted, and
failures are echoed.

The gate-level `-Quiet` defects still matter for direct/CI invocation of the
scanners themselves, which is how the pipeline steps call them. But the
*self-test* `-Quiet` inconsistency is effectively dead code. Recording the
narrowing.

Small note: assertion counting is done by grepping child stdout for `\[PASS\]`
/ `\[FAIL\]`, so the `Assert-That` output format is a load-bearing contract
across five files. Worth a comment in each `Assert-That`, since a cosmetic tweak
to that string would silently zero the counts while every exit code stayed green.

---

### Closing position on `.github/scripts/parity/`

Eight files transcribed (five scanners, four self-tests, this runner — some
partial). The picture is now settled and worth stating once, plainly:

**This is the strongest part of the kit.** It is postmortem-driven (five separate
documented incidents), legacy-anchored, deterministic, waiver-honest,
time-aware via drain semantics, self-reporting about its own blind spots,
regression-tested against synthetic fixtures, guarded against re-blinding by
static source assertions, and wired into a single auto-discovering runner that
fails closed when it finds nothing.

The defects found are real but almost all of one kind: **a good practice present
in one file and absent from its siblings.** With `verify-gate-integrity.ps1` in
hand, the remediation is fully specified and small:

1. Add the zero-input guard to the four scanners that lack it — copy from this
   file or from the ledger.
2. Add one empty-input case to each `selftest-*.ps1` — the harnesses already
   exist; the assertion fails today, which is the point.
3. Align `selftest-parity-gate.ps1` to child-process invocation (3-to-1 house
   convention).
4. Unify the HTTP-verb attribute regex (`\b` form, per `scan-backend-parity.ps1`).
5. Extract the duplicated resolution/registry/waiver scaffolding into
   `.github/scripts/shared/`.

Every one of those has a working reference implementation already in the
directory. None of it requires new design.

---

## `Starter.Web.Client/scripts/` — the Node build harness

The client is not driven through raw `ng` commands or through `dotnet build`. It
is driven through a set of hand-written ESM scripts under
`src/Starter.Web.Client/scripts/`, and `tools.mjs` is the single module every one
of them shells out through. Five of the nine files in the folder are now
transcribed; `clean.mjs`, `install.mjs`, `npm-clean.mjs`, and
`npm-safe-package-installs.mjs` are still outstanding.

### The call graph

```
pre-start.mjs          build.mjs              update.mjs
  preBuild(true)         preBuild(false)        npmAuth()
  dotnet dev-certs       mkdir obj/Debug        npmUpdate()
                         ng build --configuration <x>
         \                   /                      |
          `-- pre-build.mjs -'                      |
               npmAuth()   (start only)             |
               npmInstall()                         |
               npm run clean                        |
               npm run lint                         |
                         |                          |
                         `-------- tools.mjs -------'
                                    execute / executeWithResult / spawn
                                    npmAuth / npmInstall / npmUpdate
                                    installSafePackages / removePath
                                    listFiles / listFolders / getFullPath
                                    appendLine
                                         |
                            npm-safe-package-installs.mjs   (NOT TRANSCRIBED)
                                    safePackageInstalls
```

### RESOLVED: the Kendo licence patch is **not** in `pre-build.mjs`

Recorded earlier against `build.mjs` as an unconfirmed risk — that
`await preBuild(false)` might be where the `\b174733\d{4}\b` `node_modules`
rewrite from `angular.instructions.md` had been automated. **It is not.**
`preBuild` is nineteen lines and does exactly four things: `npmAuth()` when
`start` is truthy, `npmInstall()`, `npm run clean`, `npm run lint`. No Kendo
handling, no `node_modules` mutation, no regex.

The risk does not disappear, it **moves one file over**. `tools.mjs` exports
`installSafePackages()`, a general-purpose mechanism for running a script *inside
an already-installed package* with `--ignore-scripts` turned back off:

```js
for (const safePackage in safePackageInstalls) {
    const packagePath = path.join(nodeModulesPath, safePackage);
    if (fs.existsSync(packagePath)) {
        console.log(`installing safe package - ${safePackage}`);
        await execute(`npm run ${safePackageInstalls[safePackage]} --ignore-scripts false`, packagePath);
    }
}
```

`installSafePackages` is called from **both** `npmInstall` and `npmUpdate`, i.e.
on every install and every update. The package → script map lives in
`npm-safe-package-installs.mjs`, which is the one file in this folder that is
both untranscribed and load-bearing. `@progress/kendo-licensing` ships a
`postinstall` that runs `kendo-ui-license activate` — a package whose install
script is suppressed globally and then re-run deliberately is precisely the shape
this mechanism exists for. **Strong hypothesis, not confirmed.**
`npm-safe-package-installs.mjs` settles it, and is now the highest-priority file
in the folder.

Note what this implies about the surrounding npm config: running with
`--ignore-scripts false` per-package only makes sense if `ignore-scripts=true` is
set globally in `.npmrc`. That is a *good* supply-chain posture — lifecycle
scripts off by default, allow-listed back on one package at a time — and worth
calling out as a strength, because the kit does not document it anywhere.

### CONFIRMED: Sonatype, and `npmAuth` is now a no-op

`copilot.instructions.md`'s "treat Sonatype as the required npm source" is
implemented here, though not the way the prose suggests. `npmAuth` reads
`.npmrc`, and if it contains the Sonatype host it logs two lines and returns:

```js
const npmrcPath = path.join(projectDirectory, '.npmrc');
const npmrc = await fsPromises.readFile(npmrcPath, 'utf8');

if (npmrc.includes('<SONATYPE-NPM-HOST>')) {
    console.log('using Sonatype npm registry configuration from .npmrc');
    console.log('npmAuth is a no-op for Sonatype-backed installs; provide auth through user or environment npm config when needed.');
    return;
}
```

The Azure Artifacts auth flow it replaced has been removed, and the `win32`
branch now only logs *"legacy npm auth flow detected, but Azure Artifacts auth is
no longer used by this workspace."* The `installVsts` parameter on the signature
is vestigial — never read. So is `projectDirectory` in practice: every call site
(`pre-build.mjs`, `update.mjs`) invokes `npmAuth()` with no arguments.

**The hostname was redacted on transcription** — the literal is replaced with
`<SONATYPE-NPM-HOST>` in the committed copy. It is a real internal registry
hostname and falls under the standing no-internal-hostnames rule. Flagged for the
same restore-or-placeholder decision still pending on `AppInfo.xml` and
`appsettings.json`. If the kit adopts the placeholder approach recommended there,
this string should resolve from `kit-params.md` too — a starter that hard-codes
one company's registry host cannot be handed to anyone else.

### ⚠ HIGH — `npmAuth` throws ENOENT on a missing `.npmrc`, killing first run

> **DOWNGRADED to MEDIUM.** The root `Starter.Web.Client/.npmrc` exists — the
> exact path `npmAuth()` reads — so clone-and-`npm start` works. This was
> recorded after seeing only the `tmpt/` copy, and the inference that the root
> file might be generated rather than committed was wrong. The unguarded
> `readFile` is still worth a guard, since `.npmrc` is a conventionally
> gitignored filename. See the client-root `.npmrc` section.

```js
const npmrc = await fsPromises.readFile(npmrcPath, 'utf8');
```

Unguarded. No `existsSync`, no `try`/`catch`, no default. If
`src/Starter.Web.Client/.npmrc` is absent — a fresh clone where `.npmrc` is
gitignored, a CI agent that provisions the registry through environment config
rather than a file, a developer who cleaned their tree — this rejects with
`ENOENT`, and because it is awaited at the top of `preBuild(true)` with no
handler above it, `npm start` dies immediately with a stack trace about a missing
file rather than anything resembling "configure your npm registry".

`npmAuth()` is the **first statement executed** by `pre-start.mjs` and by
`update.mjs`. For a hackathon where several hundred people clone the starter and
run `npm start`, this is the most likely first-contact failure in the whole
client, and its error message points at the wrong problem. A three-line guard
(`if (!fs.existsSync(npmrcPath)) { console.log('no .npmrc found...'); return; }`)
removes it.

The softer sibling: if `.npmrc` exists but does not mention Sonatype, `npmAuth`
logs *"manual npm authentication is required for non-Sonatype registries."* and
**returns normally**. The install then proceeds against whatever registry is
configured and fails on 401s, several steps removed from the log line that
explained why.

### ⚠ HIGH — install failure is caught, `node_modules` is deleted, and the run continues

Both `npmInstall` and `npmUpdate` end the same way:

```js
} catch (error) {
    console.error(`Error installing packages: ${error.message}`);

    // Attempt to remove node_modules
    ...
    await removePath(nodeModulesPath);
}
```

The catch logs, deletes `node_modules`, and **does not rethrow and does not set a
non-zero exit code**. Control returns to `preBuild`, which proceeds to
`npm run clean`, then `npm run lint`, then `build.mjs` runs `ng build` — all
against a tree whose `node_modules` was just removed. What the developer sees is
a downstream module-resolution error; the real cause scrolled past several
commands earlier.

This is also the explanation for the drift-recovery order the kit documents
(`npm run update` → `npm run install` → `npm run start`). That sequence is not a
convention, it is a **workaround for this exact behaviour**: because a failed
install silently destroys `node_modules` and keeps going, recovery has to be
driven by hand, one command at a time, checking output between each. Fixing the
error handling would make most of the documented dance unnecessary.

For a kit whose first principle is *"gates are scripts, not opinions"* and whose
convention is `RESULT: OK` (exit 0) / `RESULT: BLOCKED` (exit 2), a build harness
that exits 0 after a failed dependency install is the sharpest internal
inconsistency found in the starter so far.

### ⚠ MEDIUM — `npmInstall` can never re-install, and `force` is unreachable

```js
if (fs.existsSync(nodeModulesPath) && !force) {
    console.log('node_modules already exists, skipping install...');
    return;
}
```

`preBuild` calls `npmInstall()` with no arguments, so `force` is `undefined`.
Once `node_modules` exists, **`npm ci` / `npm install` never runs again** — a
changed `package.json` or `package-lock.json` is simply not picked up by
`npm start` or `npm run build`. And `preBuild(start)` accepts only `start`, so
there is no path from `pre-start.mjs` or `build.mjs` to set `force` at all. The
only file that could pass it is `install.mjs`, still untranscribed.

Combined with the previous finding, that is the whole drift story in two lines of
code: stale dependencies are never refreshed automatically, and when a refresh is
forced and fails, the tree is deleted without stopping the build.

### ⚠ MEDIUM — `exec` buffering will fail real builds

`execute` and `executeWithResult` are both built on
`util.promisify(child_process.exec)`, which **buffers the child's entire stdout
in memory** and rejects with `ERR_CHILD_PROCESS_STDIO_MAXBUFFER` past Node's
1 MiB default. `npm ci` on an Angular workspace and a full `ng build` both emit
well over 1 MiB. When it trips, the failure reported is a truncation error, not
the build error — and per the finding above, `npmInstall` will then delete
`node_modules` and carry on.

The same choice costs all streaming output: nothing prints until the command
completes, so a multi-minute `npm ci` looks like a hang. `spawn` with inherited
stdio is the usual answer; `tools.mjs` already exports a `spawn`, but it is
configured for the opposite purpose (below).

### ⚠ MEDIUM — `executeWithResult` treats any stderr as failure

```js
if (stderr) {
    throw new Error(`${stderr}`);
}
```

stderr is not an error channel for most of the tools in this stack. `npm`, `ng`,
`git`, and `dotnet` all write warnings, deprecation notices, and progress to
stderr on **successful** exit-0 runs. `executeWithResult` throws on all of them,
discarding the stdout it was called to return. Any gate or script built on it
will report BLOCKED for a command that succeeded — a false-negative generator
inside a kit that treats gate output as ground truth. The correct test is the
exit code, which `exec` already surfaces by rejecting.

`executeWithResult` is not called by any transcribed file; its callers are
presumably among the four outstanding scripts.

### ⚠ MEDIUM — `pre-start.mjs` writes an unencrypted dev private key into the source tree

```js
await execute(`dotnet dev-certs https --trust`);
await execute(`dotnet dev-certs https --export-path ./cert.pem --format Pem --no-password`);
```

Three problems, ascending:

1. `--trust` runs on **every** `npm start`. On Windows it is idempotent and
   quiet; on macOS and Linux it prompts for credentials, which in a CI or
   container context is an interactive hang rather than a clean failure.
2. `--format Pem` makes `dotnet dev-certs` write **two** files — `cert.pem` and
   `cert.key` — and `--no-password` means the key file is **unencrypted**. Both
   land in `./`, which for `pre-start.mjs` is the client project directory, i.e.
   inside the repository working tree.
3. Nothing transcribed so far shows `cert.pem` / `cert.key` being gitignored.
   **Needs checking against the client `.gitignore`** (not yet transcribed). If it
   is not covered, every participant who commits after an `npm start` commits a
   private key. It is only a localhost development key, so the blast radius is
   small — but "a `.key` file committed by default" is the kind of thing that
   trips org-wide secret scanning and costs a day.

Recorded as a to-verify rather than a confirmed defect, since `.gitignore` may
well cover it.

### `spawn()` is fire-and-forget and cannot be gated on

```js
export function spawn(command, args, workingDir) {
    const child = child_process.spawn(command, args, {
        cwd: workingDir,
        detached: true,
        env: process.env,
        shell: true,
        stdio: 'ignore'
    });
    child.unref();
}
```

`detached: true` + `stdio: 'ignore'` + `unref()` means the caller gets no output,
no exit code, and no completion signal — the child deliberately outlives the
parent. That is the right shape for "start a dev server and let it run", and the
wrong shape for anything a gate must observe. No transcribed file calls it yet.
`shell: true` with uninterpolated `command`/`args` is also a shell-metacharacter
surface; low risk in a build script, but arguments must never come from file
contents or CI variables without quoting.

### Smaller observations

- **`update.mjs` imports `npmInstall` and never uses it.** Four lines of code, one
  of them dead. `preBuild` runs `npm run lint` on every build, so either lint does
  not cover `scripts/**` or `no-unused-vars` is off — a small piece of evidence
  about the real lint scope, which matters because the pipeline leans on lint as a
  quality signal.
- **`getFullPath` uses `entry.parentPath`**, which is Node ≥ 20.12 / ≥ 21.4
  (`dirent.path` before that). An undeclared minimum-Node constraint: the kit pins
  package versions in `pins.json`, but nothing transcribed so far pins the Node
  major, and on Node 18 this returns `undefined/<name>` silently rather than
  throwing.
- **Ordering.** `preBuild` runs `npm run clean` *after* install and *before* lint;
  `build.mjs` then re-creates `obj/Debug`. That ordering is why the `mkdir` in
  `build.mjs` exists at all — `clean` removes the directory the .NET side expects
  to be present.
- **`appendLine`, `listFiles`, `listFolders`, `getFullPath`** have no callers among
  the transcribed files. They are a utility surface for the four outstanding
  scripts (most likely `clean.mjs` and `npm-clean.mjs`, which would need directory
  walking).
- **No top-level error handling anywhere.** None of `build.mjs`, `pre-start.mjs`,
  or `update.mjs` wraps its top-level `await`s. An unhandled rejection in an ESM
  entry point exits non-zero with a stack trace, which is at least honest — but it
  means the *only* place failures are swallowed is the one place where it matters
  most: dependency install.

---

## `Starter.Web.Client/.vscode/` — unmodified Angular CLI output

Three files, all stock `ng new` scaffolding, identifiable by their standard
fwlink IDs (`827846`, `830387`, `733558`). No Fusion customisation, no kit
additions, nothing sensitive, and no findings worth the name. Recording them for
completeness and for two small operational facts:

**Ports.** `launch.json` pins `ng serve` to `http://localhost:4200/` and
`ng test` to `http://localhost:9876/debug.html` (Karma default). The 4200 figure
matters because the **dual-port visual-parity gate** in
`frontend-modernization-learning.instructions.md` boots the modern app alongside
the legacy one and diffs matching routes — 4200 is the modern side of that pair,
and `copilot.instructions.md`'s port-freeing helper needs it.

**A small task-definition ambiguity.** This is a *nested* `.vscode/` under
`src/Starter.Web.Client/`, and the repo root has its own `.vscode/` as well.
`copilot.instructions.md` says *"If you need task definitions, read
`/.vscode/tasks.json` first"* — the root one — while `launch.json` here
references `"npm: start"` / `"npm: test"` resolved from *this* file. Both are
legitimate (nested `.vscode` is normal Angular CLI output), but an agent told to
read the root file will not see these two tasks. Worth one clarifying clause in
the instruction, since the kit's documented client run flow (`npm run update` →
`npm run install` → `npm run start`) is a third set of commands defined in
neither `tasks.json` — it lives in the client's `package.json` scripts.

Trivial inconsistency, noted only so a cleanup pass does not "discover" it:
`ng serve` uses `"type": "pwa-chrome"` while `ng test` uses `"type": "chrome"`.
That is exactly what the Angular CLI generates; both work.

---

## ★★ `Program.cs` — the Fusion boot shape confirmed, in 11 lines

The last unverified load-bearing claim from `fusion-mcp-restructure.instructions.md`
is now checked against source. The entire file:

```csharp
using Fusion.Fx.App;
using Fusion.Fx.App.Web;

var builder = FusionWebBuilder.CreateBuilder(
    args,
    new FusionWebBuilderOptions() { Configure = AppConfiguration.Configure }
);

builder.AddMyApplication();

await builder.BuildAndRunAsync();
```

`fusion-mcp-restructure` said: *"compose the host with
`FusionWebBuilder.CreateBuilder(...)` + `await builder.BuildAndRunAsync()`."*
Exactly right, including the `await`. There is **no** `WebApplication.CreateBuilder`,
no `app.Use*` middleware chain, no `MapControllers`, no `Run()`. Fusion owns the
entire pipeline; the app contributes one line of its own registration.

This closes the platform-ownership case completely:

| Claim | Verified by |
|---|---|
| Host composed via `FusionWebBuilder.CreateBuilder` + `BuildAndRunAsync` | **`Program.cs`** ✅ |
| No hand-written auth/middleware in the extension seams | `FusionWebBuilderExtensions.cs`, `FusionApplicationBuilderExtensions.cs` (grep = 0) ✅ |
| API/docs surface enabled by appsettings, not code | `appsettings.json` + `.Development.json` ✅ |
| Okta arrives as a **package**, not code | `Fusion.Fx.Security.Web.OAuth.Okta` in the `.csproj` ✅ |

`copilot.instructions.md`'s rule — *"Prefer minimal hosting in `Program.cs`"* — is
satisfied about as completely as it can be.

### ⚠ Fair correction: `AppConfiguration` is load-bearing, not stray

I flagged `FusionApplicationBuilderExtensions.cs` for declaring a second public
class (`AppConfiguration`) as a `dotnet.instructions.md` violation. `Program.cs`
shows why it exists: it is passed as the `Configure` delegate into
`FusionWebBuilderOptions`. So it is **deliberate and functional**, not leftover.

The file-organisation rule still applies (it is a non-trivial public type in a
file named after something else, and `AppConfiguration.cs` would be the correct
home) — but "someone left a class lying around" was the wrong characterisation
and I am withdrawing it. It is a wiring type with a real consumer.

---

## Structural facts from `Starter.Web.Api.csproj`

**`Fusion.Fx.Security.Web.OAuth.Okta` 2026.3.5** — the package that actually
delivers Okta. Third independent confirmation that auth is package + config, and
the final nail in the `fusion-auth-standards.md` code blocks.

Full package set (all Fusion at CalVer `2026.3.5`):
`Fusion.Fx.App.Web`, `Fusion.Fx.Logging.Providers.FusionApi`,
`Fusion.Fx.Security.Web.OAuth.Okta`, `OpenTelemetry.Api` 1.15.3,
`OpenTelemetry.Exporter.OpenTelemetryProtocol` 1.15.3, plus a `ProjectReference`
to `Starter.Library`.

Note `Fusion.Fx.Logging.Providers.FusionApi` — that is the package behind the
commented-out `Logging:FusionApi:Queue` block in `appsettings.json`. The queue
sink is referenced but disabled, so switching it on is configuration-only.

**Deliberate GC tuning**, with the reason stated:

```xml
<!-- Turn off Server GC for when on shared server -->
<ConcurrentGarbageCollection>false</ConcurrentGarbageCollection>
<ServerGarbageCollection>false</ServerGarbageCollection>
```

Workstation GC for shared/containerised hosts — a real, correct decision for
memory-constrained OpenShift pods, and one a modernization agent must not
"optimise" away.

**One narrowing of an earlier flag:** this project does **not** reference
`Microsoft.Extensions.Configuration.Json`. That 9.0.0-against-net10.0 pin exists
only in `Starter.Library.csproj`, so the `check-pins` question is scoped to one
project, not the solution.

---

## ⚠ `web.config` enables Windows Authentication on an Okta bearer-token API

14 lines, and one element worth a decision:

```xml
<security>
  <authentication>
    <anonymousAuthentication enabled="true" />
    <windowsAuthentication enabled="true" />
  </authentication>
</security>
```

**Stating this precisely, because the severity depends on framing:**

- This is **IIS server configuration**, not application code. The kit's
  deterministic CRITICAL patterns are C# —
  `AddAuthentication(IISDefaults.AuthenticationScheme)` and
  `NegotiateDefaults` — and neither appears anywhere in the starter. So a
  compliance scan searching for the code pattern **will not flag this**.
- Anonymous is *also* enabled, so Windows auth is not being forced; IIS will
  allow unauthenticated requests through to the app, which is what a bearer-token
  API needs.
- The app authenticates via Okta bearer tokens validated by Fusion, and is
  deployed to **OpenShift via `entrypoint.sh`** — on that path `web.config` is
  not read at all.

So this is not the CRITICAL violation the rubric describes. **But it is
unexplained**, and it is the kind of thing a security review will stop on:
Windows Authentication enabled on an application whose entire identity model is
OAuth. `AppMod-Acceptance-Criteria.md` does list *"Windows/role-centric
authorization patterns instead of OAuth/OIDC"* under **High**, and a human
reviewer reading this file has no way to tell whether it is vestigial or load-bearing.

**Recommended:** either remove `windowsAuthentication` if the IIS path is
legacy/unused, or add a one-line comment stating why it is required (e.g. an
IIS-hosted deployment lane that still needs it). The existing comment explains
the `<location>`/Feature Delegation mechanics but says nothing about *why
Windows auth*.

**And a gap this exposes in the review lane:** the kit's Windows-auth detection is
code-pattern-based, so a modernized app that carries Windows auth forward **in
`web.config`** passes the scan. Given the kit explicitly targets legacy .NET
Framework apps — where `web.config` Windows auth is the norm — that is a realistic
miss. Worth adding a `web.config` check to `compliance-scan` alongside the C#
patterns.

---

## 🔒🔒 SECURITY FINDING: the starter ships live corporate identifiers into every clone

`appsettings.json` is the first file in this import that contains material the
standing rule names **explicitly** as never-commit. Redacted before committing:

| Value | Count | Why |
|---|---|---|
| Okta **ClientId** (`0oa…`) | 1 | the standing rule names "Okta tenant IDs/client IDs" verbatim |
| Okta tenant URL | 5 | same rule |
| AD group identifiers (`DOMAIN\\Group`) | 5 | internal identity topology |
| Corporate DNS domains | 10 | internal hostnames |
| OpenShift cluster hostname | 1 | internal hostname |
| Internal CIDR ranges (`10.x.x.x/24`) | 6 | internal network topology |

**Structure, key names, and all non-sensitive values are intact** — the config
*shape* is what matters for kit analysis, and none of it is lost. The one
remaining match on a sensitive-looking pattern is the Fusion config **key**
`DominionEnergyDomains`, which is a key name rather than a value (same category
as env-var names, which the rule permits).

### Why this matters beyond my transcription

This is not just a transcription problem — **it is a real exposure in the kit
itself**, and it is directly on-point for a company-wide hackathon:

1. **The starter is cloned by every participant.** These values ship in
   `src/Starter.Web.Api/appsettings.json` to every team, in a file nobody is told
   to sanitize.
2. **A live Okta ClientId is committed.** It is commented `// Fusion Prototype`,
   so it is plausibly a non-production app registration — but it is a real client
   identifier in a template, and Step 2's rename does not touch it. `AppInfo.xml`
   shows the discipline that *should* apply here: `{ServiceAccount}`,
   `{TeamADGroup}`, `{ApplicationRepoUrl}` are all placeholders. `appsettings.json`
   uses none.
3. **The kit's own rubric would flag parts of this.**
   `AppMod-Acceptance-Criteria.md` lists *"Hardcoded connection strings, API URLs,
   or environment-specific endpoints"* as **High**, and `fusion-auth-standards.md`
   requires client secrets to come from Key Vault or environment variables. No
   secret is present here — but the Okta tenant, ClientId, and six internal CIDRs
   are exactly "environment-specific endpoints" hardcoded into a reusable asset.
4. **The blast radius is a public push.** A hackathon participant who pushes their
   modernized app to a personal or public repo exposes the Okta tenant, the client
   ID, the corporate DNS estate, and the internal network ranges in one commit.

**Recommended fix, matching the discipline `AppInfo.xml` already uses:**
replace each with a placeholder (`{OktaDomain}`, `{OktaClientId}`,
`{AdminGroup}`, `{CorpDomains}`, `{KnownNetworks}`) resolved from
`kit-params.md` at Step 2 rename time, exactly as `appName` already is. That is
consistent with the naming law (*"Store app identity only in
`kit-params.md`"*), costs one rename-script change, and removes the exposure
entirely. **I would put this above the auth-standards rewrite on the pre-hackathon
list** — it is smaller, and its downside is unbounded in a way a bad code pattern
is not.

Say the word if you want the real values restored in this repo; they are your
identifiers and it is your call, but the default here is redaction.

---

## Structural facts added by `appsettings.json` — the Fusion platform config surface

206 lines, and the single most informative file about how a Fusion app is actually
configured. It closes several loops.

**Config-gating confirmed end to end.** Base settings carry
`Fusion:Web:Api:EnableApi = true` and an `OpenApi.Title` — but **no
`EnableOpenApi` key**. That flag exists only in `appsettings.Development.json`.
So the API is always on; the *documentation surface* is Development-only, by
configuration, with no code involved. That is precisely the behaviour
`fusion-auth-standards.md`'s "Swagger: Development Only" rule wants, achieved by
a mechanism its code blocks never mention.

**The full Okta identity model, in two halves:**

- `Fusion:Security:Principal:IdentityProviders` — `Type: "OktaOpenId"`, with
  `UserInfoUrl`, `UserProfileUrl`, an `IdentifierClaimIssuer`, and
  `UserIdClaimType` set to the SOAP `nameidentifier` claim URI. Plus
  `CachePrincipalTransforms`, `CacheUserProfiles`, and `TransformClaims`, all
  `true`.
- `Fusion:Web:Security:IdentityProviders` — `Type: "OAuth.OktaWebApi"` with
  `Audience`, `ClientId`, `OktaDomain`, and a notable
  `"AuthorizationServerId": null, // so that the issuer is just the OktaDomain`.

Two providers, two layers: principal/profile resolution and web API token
validation. This is the concrete shape of the thing
`fusion-auth-standards.md` tries to hand-write.

**The role and policy model resolves the earlier user-input-gate finding.**
`modernization-starter-boundaries` said an agent must ask the user for the
authoritative group identifiers for `User`, `Admin`, and app-specific roles like
`TestAdmin`. This file shows exactly where they go — five `Fusion:Security:Roles`
mappings (group → role), and three
`Fusion:Web:Security:Authorization:Policies` entries (`TestAdmin`, `Admin`,
`User`), each `RequiresAuthenticatedUser: true` with a `Roles` array. Plus a
`DefaultPolicy` requiring an authenticated user. That is the full chain from AD
group to `[Authorize(Policy = "User")]` on `MyEntitiesController`.

**Platform features not documented anywhere else in the import:**

- **`MaliciousInput`** — an enabled input filter with **17 blocked patterns**
  (`<script`, `<iframe`, `javascript:`, `.write(`, `.addEventListener`, …). A
  Fusion-owned XSS guard. Worth knowing before an agent adds its own sanitizer.
- **`MaintenanceMode`** — with `IgnoreEndpoints` for
  `/Fusion/CanBypassMaintenanceMode` and `/Fusion/MaintenanceMode`, and
  `IgnoreRoles: ["Admin"]`.
- **`RequestBodyBuffer`**, **`ForwardedHeaders`** (proxy/ingress trust),
  **`Cors.AllowedDomains`** including `capacitor://localhost` for iOS web views.
- **`PathBase: "/api"`** — so the controllers' `[Route("[controller]")]` resolve
  as `/api/MyEntities`. That reconciles the `ToAbsoluteUrl($"MyEntities/{id}")`
  call seen in the controller.
- **A commented-out `Logging:FusionApi:Queue` block** — a queue-backed log sink
  with circuit-breaker delay, file-share persistence, and poison handling. Not
  active, but it shows the production logging path exists.
- **Per-assembly log levels** with `Starter.Library` and `Starter.Web.Api` at
  `Trace`, everything else at `Warning`/`Information`. A modernization agent must
  rename those two keys during Step 2, or the app silently loses its own logging.

**`Fusion:Application:Id` is a placeholder with a TODO:**
`"00000000-0000-0000-0000-000000000000"` with
`// TODO: Replace with ID from Fusion App Management`. Good practice — and a
useful contrast with the identifiers that were *not* left as placeholders.

---

## `entrypoint.sh` — 13 lines, clean

```sh
#!/usr/bin/env sh
set -eu
# OpenShift patterns often provide PORT. Prefer explicit ASPNETCORE_URLS if set.
```

`set -eu` (fail fast on error and undefined variable), `${VAR:-}` guards so the
`set -u` does not trip on unset optionals, precedence given to an explicit
`ASPNETCORE_URLS`, fallback to `PORT`, then to `8080`, and `exec` so .NET becomes
PID 1 and receives container signals directly. That is a correct, idiomatic
container entrypoint — no findings, and it confirms OpenShift as the deployment
target alongside `AppInfo.xml`'s Azure DevOps pipelines.

---

## ★ Third leg of the proof: the API surface is turned on by config, in Development only

`appsettings.Development.json` is 11 lines and contains exactly one setting:

```json
{
  "Fusion": {
    "Web": {
      "Api": {
        "OpenApi": {
          "EnableOpenApi": true
        }
      }
    }
  }
}
```

This completes the empirical case that **Fusion owns the web platform**:

| Evidence | Source |
|---|---|
| No auth wiring in either Fusion extension file | `FusionWebBuilderExtensions.cs`, `FusionApplicationBuilderExtensions.cs` — grep returned 0 |
| No Swagger/Scalar wiring in code | same two files |
| **The API surface is enabled by an appsettings key instead** | **this file** |

So `fusion-mcp-restructure.instructions.md` was accurate: the OpenAPI/Scalar
surface is *"driven by the appsettings config blocks"* rather than by
`AddScalar`/`MapScalar` calls. The exact key path is
`Fusion:Web:Api:OpenApi:EnableOpenApi` — slightly more nested than the
instruction file's shorthand (`Fusion.Web.Api.EnableApi` and `OpenApi`), so that
shorthand is directionally right but imprecise. Worth correcting to the literal
path, since an agent searching appsettings for `EnableApi` will not find this key.

**It also splits `fusion-auth-standards.md` cleanly in two**, which sharpens the
earlier recommendation:

- Its **rules** are correct. *"Swagger: Development Only"* is exactly what this
  file implements — enabled in the Development override, absent from base
  `appsettings.json`, so production never exposes it. Same for policy-based
  authz, secrets handling, PII, CORS, and the severity table.
- Its **code blocks** describe an app-owned implementation that does not exist and
  must not be written.

That is a much easier fix than "rewrite the file": **keep every rule, delete the
two `csharp` blocks under "Fusion pattern (use this)", and replace them with the
config keys.** The behavioural intent survives intact; only the mechanism changes
from hand-rolled middleware to Fusion configuration.

**One structural note for the modernization agents:** because the surface is
config-gated rather than code-gated, an agent verifying "is OpenAPI correctly
Development-only?" must inspect `appsettings*.json`, not search for
`app.UseSwagger()`. A compliance scan looking only for the code pattern would
report a false pass on a Fusion app that had `EnableOpenApi: true` in its base
settings — the actual production-exposure risk. Worth a targeted check in the
review lane.

---

## 🔒 REDACTION APPLIED: `AppInfo.xml` (2 values)

This is the first transcribed file containing real internal infrastructure
identifiers rather than placeholders. Per the standing rule for this import
(*never commit real secrets, credentials, tenant IDs, or internal
infrastructure identifiers*), two values were replaced:

| Element | Committed as | What it was |
|---|---|---|
| `<serviceAccountDomain>` | `[REDACTED-AD-DOMAIN]` | the real Active Directory domain for service accounts |
| `<serviceAccountPasswordSource>` | `[REDACTED-VAULT]` | the real credential-vault identifier |

Both appear four times (once per active environment). **Nothing analytically
useful is lost** — the structure, element names, and deployment model are intact,
and it is the *shape* that matters for kit analysis.

**Say the word if you want them verbatim** and I will restore them; they are not
secrets in the password sense, just infrastructure names, so it is your call
rather than a hard block. Everything else in the file is committed exactly as
photographed.

Worth noting in the kit's favour: every genuinely app-specific value is already
templated — `{TeamEmail}`, `{TeamSupportGroup}`, `{TeamADGroup}`,
`{TeamADGroupDomain}`, `{ApplicationInfoUrl}`, `{ApplicationRepoUrl}`,
`{ServiceAccount}`. That is exactly the discipline `kit-update.instructions.md`
demands ("do not hard-code the current app… use placeholders"). The two redacted
values are the only literals, and they are org-wide rather than app-specific,
which is presumably why they were left concrete.

---

## Structural facts added by `AppInfo.xml`

The first deployment-topology file in the import. 89 lines, validates as XML.

**Twelve environments, four active:**

| Environment | Active | Has service account |
|---|---|---|
| `00-DEVLOR_DEVL` | N | — |
| `00-DEVLOR_QUAL` | N | — |
| **`1-DEVL`** | **Y** | ✅ |
| **`2-UAT`** | **Y** | ✅ |
| `2-UATQA` | N | — |
| `3-RELEASE` | N | — |
| **`4-STAGING`** | **Y** | ✅ |
| `4-STAGING-INTERNAL` | N | — |
| `4-STAGING-EZONE` | N | — |
| `5-TRAINING` | N | — |
| `6-PREPROD` | N | — |
| **`6-PRODUCTION`** | **Y** | ✅ |

Only active environments carry `serviceAccount` / `webApp` blocks — a clean
pattern, and one a modernization agent must preserve when renaming the starter.

**Azure DevOps, not GitHub Actions**, for the app pipeline:
`azure-pipelines.yml` and `azure-pipelines.verify-build.yml`. **Neither file
appears in the transcribed repo tree**, so they are either app-supplied at
onboarding or live somewhere the tree summary collapsed. Given
`copilot.instructions.md` mentions "current DevOps or CI location" and
`modernization-deep-scan-checklist` mentions "ADO CI/CD planning", this is the
first concrete confirmation that the CI target is Azure DevOps. (Note the kit's
own `.squad/workflows/` holds 11 GitHub Actions — those are kit-maintenance
workflows, a different thing from the app pipeline.)

**⚠ A health-endpoint mismatch worth resolving.** This file declares the
deployment health check as:

```xml
<healthCheckUrl>fusion/health</healthCheckUrl>
```

…but `copilot.instructions.md` says:

> If the app exposes `GET /health`, preserve its response shape; prefer
> `{ "status": "ok" }` when establishing a new baseline.

…and instructs agents to open *"the primary smoke endpoint(s) (at minimum
`GET /health`)"* after any local start. So the **platform** health endpoint is
`fusion/health` (Fusion-owned, consistent with Fusion owning the middleware
pipeline as `FusionWebBuilderExtensions.cs` proved), while the **instructions**
point agents at `/health`. An agent following the operational rule will probe a
path the deployment descriptor does not use, get a 404, and may "fix" it by
hand-adding a `/health` endpoint — introducing exactly the kind of parallel
app-owned implementation of a Fusion-owned concern that
`modernization-starter-boundaries` forbids.

Cheap fix: change `copilot.instructions.md` to say `fusion/health` for
Fusion-backed apps, or state that `/health` applies only to non-Fusion legacy
baselines. This is the same failure shape as the `fusion-auth-standards.md`
finding — an instruction file describing an app-owned implementation of something
Fusion already owns — just much smaller.

---

## The three model DTOs — pattern confirmed a fifth time, plus two genuinely good details

`PublicTextResponse.cs` carries XML `<summary>` **and** `<param>` documentation
and is a `sealed record`; `MyModel.cs` and `MyModelSearch.cs` carry no
documentation and are `sealed class`. That is the fifth consecutive
`PublicText*` / `My*` pair to split the same way. No new analysis needed — it
simply confirms the finding is systemic across every layer of the starter
(service, controller, DTO).

Two details worth recording on their own merits:

**1. `MyModel` gets input validation exactly right.** It carries *both*
annotations, which is the correct belt-and-braces for an API input model and a
distinction agents frequently get wrong:

```csharp
[Required]
public required string Name { get; set; }
```

`[Required]` (DataAnnotations) drives **runtime** model-binding validation and
the automatic 400 + `ProblemDetails` response that `[ApiController]` produces —
which is what makes `MyEntitiesController`'s
`[ProducesResponseType<ProblemDetails>(400)]` declarations truthful. `required`
(C# 11) is a **compile-time** guarantee for any code constructing the model
directly. They solve different problems; using only one leaves a real gap. This
is a good pattern for the kit to teach explicitly.

**2. `MyModelSearch` is correctly all-nullable.** Both `Name` and `Description`
are `string?`, matching `DefaultMyService.GetEntities(string? name, string?
description)` where absent means "no filter." The contrast with `MyModel`'s
`required string Name` is deliberate and correct — an input model demands a name,
a search filter must not.

**One shape difference that is not a defect:** `PublicTextResponse` is a
positional `record` while the `My*` models are classes. For an immutable
*response* payload a record is the better modern idiom; for a mutable *input*
model bound by MVC, a class with settable properties is the conventional choice.
So this particular split is defensible rather than another instance of the
two-tier problem — worth noting so the cleanup pass does not "fix" it by
converting the input models to records.

---

## ★★★ SETTLED EMPIRICALLY: `fusion-auth-standards.md` describes code that does not exist

`fusion-auth-standards.md` names two files and prescribes exactly what to put in
them:

> **Wire in `FusionWebBuilderExtensions.cs`:**
> ```csharp
> public static WebApplication UseFusionWebMiddleware(this WebApplication app)
> {
>     if (app.Environment.IsDevelopment()) { app.UseSwagger(); app.UseSwaggerUI(); }
>     app.UseHttpsRedirection();
>     app.UseAuthentication();
>     app.UseAuthorization();
>     return app;
> }
> ```
> **Wire in `FusionApplicationBuilderExtensions.cs` or `Program.cs`:**
> ```csharp
> builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
>     .AddJwtBearer(options => { ... });
> ```

**Both files are now transcribed. Neither contains any of it.** A grep across the
two for `AddAuthentication`, `AddJwtBearer`, `UseAuthentication`,
`UseAuthorization`, `Swagger`, and `Scalar` returns **zero matches in both files**.

Here is the entirety of `FusionWebBuilderExtensions.cs`:

```csharp
public static IFusionWebBuilder AddMyApplication(this IFusionWebBuilder fusionWebBuilder)
{
    fusionWebBuilder.AddMyLibrary();
    return fusionWebBuilder;
}
```

That is the whole file — one call, one return. No middleware pipeline, no
`UseFusionWebMiddleware` method, no Swagger block. And its Library counterpart is
`Configure<MyOptions>` plus two `AddSingleton` registrations, nothing more.

**So authentication, authorization, OpenAPI, and Scalar all come from Fusion
itself** — via `FusionWebBuilder.CreateBuilder(...)` and the appsettings config
blocks (`Fusion.Web.Api.EnableApi`, `Fusion.Web.Security.IdentityProviders`,
`Fusion.Security.Principal`), exactly as `fusion-mcp-restructure.instructions.md`
describes and exactly as `dominion-requirements` implies when it forbids *"a
parallel generic `AddJwtBearer` stack."*

**This moves the finding from "outlier opinion" to "documented behavior that
contradicts the shipped code."** The tally is now:

| Position | Sources |
|---|---|
| Fusion owns auth; do not hand-roll | `appmod-fusion-target`, `g1-to-g2-playbook`, `fusion-g1-to-g2-modernization/SKILL.md`, `dominion-requirements`, `copilot.instructions.md`, `modernization-starter-boundaries`, **and now the starter source itself** |
| Hand-write `AddJwtBearer` in these two files | `fusion-auth-standards.md` alone |

**Recommendation, upgraded from "rewrite" to "rewrite urgently."** This is the
single most dangerous file in the kit for the hackathon: it tells an agent to add
a parallel authentication stack into a **protected starter control point**, in a
file whose real contents are three lines. An agent that follows it will produce
precisely the *"parallel generic `AddJwtBearer` stack"* that
`dominion-requirements` marks as a violation — and it will do so while believing
it is following the Fusion standard. Everything else in
`fusion-auth-standards.md` (policy-based authz, secrets, PII, CORS, token
validation, the severity table) is sound and worth keeping; only the two
"Fusion pattern (use this)" code blocks need to go, replaced with a pointer to
the Fusion config blocks.

---

## ⚠ A doc comment that describes a database the kit does not have

Line 13:

> `/// Wires up the application services, including the **PostgreSQL-backed entity repositories**.`

There is no PostgreSQL anywhere in the starter. `AddMyLibrary()` registers
`DefaultMyService` — an in-memory `Dictionary<Guid, MyEntity>` — and
`DefaultPublicTextService`, which returns a hard-coded string.
`Starter.Library.csproj` has no Npgsql or EF Core package. The
`modernization-starter-boundaries` configuration guidance is written entirely
around **SQL Server** (`SqlServer__Server`, `SqlServer__Database`, …), and
`dotnet.instructions.md`'s data-access sections are `SqlClient` and Dapper.

So this is a stale comment, almost certainly copied from a different project. It
is small, but it is the *worst* kind of small for this kit specifically:

- `copilot.instructions.md` instructs agents to **use `src/` as the working
  reference**. An agent reading this comment while planning Step 8 data access
  could reasonably conclude the target stack is PostgreSQL and wire Npgsql —
  contradicting every SQL Server reference in the boundaries file.
- It is exactly the failure mode the Evidence Contract exists to prevent:
  documentation asserting a capability that no code provides. The kit forbids
  agents from doing this; the starter does it.

One-line fix: `/// Wires up the application services.`

---

## Also worth noting

**Same namespace idiom, one level up.** `namespace Fusion.Fx.App.Web;` in a file
under `Starter.Web.Api/Extensions/` — the Web-tier twin of the Library file's
`namespace Fusion.Fx.App;`. Consistent, deliberate, and the same linter
carve-out applies.

**`using System;` on line 1 is redundant** under `ImplicitUsings=enable`. Trivial
on its own, but a small irony given `AnalysisLevel=latest-all` +
`TreatWarningsAsErrors=True`: unnecessary-using is exactly the class of
suggestion that combination is designed to surface. Worth checking whether the
starter actually builds clean under its own analyzer settings — another item for
the "point the kit's gates at the kit" pass.

**Documentation quality is on the good tier here** — XML `<summary>` on both the
class and the method, matching `PublicText*` rather than `MyEntities*`. The
content is wrong, but the form is right.

---

## ★★ The two-tier pattern is systemic: `PublicText*` is the exemplar, `MyEntities*` is not

The controllers repeat the services split **exactly**, which converts a
two-file observation into a confirmed structural pattern across the whole starter.

| Rule (kit's own source) | `PublicTextController` | `MyEntitiesController` |
|---|---|---|
| XML documentation (`AGENTS.md`) | ✅ class, ctor, and action | ✗ none |
| `sealed` | ✅ | ✗ |
| Async + `CancellationToken` (`dotnet.instructions.md`) | ✅ `async Task<ActionResult<T>>` | ✗ all `IActionResult`, sync |
| Inject `ILogger<T>` (`dotnet.instructions.md`) | ✅ | ✗ absent |
| Policy-based authz, no `Roles=` | ✅ `[AllowAnonymous]` | ✅ `[Authorize(Policy = "User")]` |
| `[ProducesResponseType]` on every action | ✅ | ✅ |
| RESTful routes | ✅ | ✗ **`[HttpPost("Search")]`** |

So it is now **four files in a matched pair** — `PublicTextService` /
`MyService`, `PublicTextController` / `MyEntitiesController` — where the
`PublicText*` half satisfies the kit's standards and the `MyEntities*` half does
not. The `MyEntities*` half is the larger, CRUD-complete, obviously-reusable one.

**This is good news, not bad.** It means the fix is not authorship, it is
*consistency*: the correct template for every gap already exists in the same
folder, written by the same hand. Bringing `MyEntities*` up to `PublicText*`
standard is mechanical.

---

## ⚠ Second self-scored violation: a verb-based route in the starter

`MyEntitiesController` line 61:

```csharp
[HttpPost("Search")]
```

`AppMod-Acceptance-Criteria.md` line 46 lists **"Verb-based API routes"** under
Medium, `dominion-requirements/SKILL.md` line 726 shows `// BAD - Verb-based URLs`,
and line 1347 grades it:

> | Verb-based URLs | **MEDIUM** |

**Running total against the kit's own rubric, for the starter as shipped:**

| Finding | File | Severity | Points |
|---|---|---|---|
| Instance state in singleton | `MyService.cs` + its `AddSingleton` registration | **HIGH** | −5 |
| Verb-based URL | `MyEntitiesController.cs` (`POST /MyEntities/Search`) | **MEDIUM** | −2 |

**Baseline compliance score for the starter ≈ 93/100** by `Score = 100 -
(CRITICAL × 10) - (HIGH × 5) - (MEDIUM × 2)`. That is above the ≥ 80 deployment
gate, so nothing blocks — but every team's Step 4 baseline report will open with
two findings they did not write, in code the kit told them to treat as the
reference.

*In fairness on the route:* `POST /resource/Search` is a widely accepted REST
pragmatism when filter payloads outgrow query strings, and this endpoint takes a
`MyModelSearch` body. The kit's criteria list it flatly as a violation with no
carve-out, so by its own rubric it counts — but the honest fix is a **rubric
decision**, not necessarily a code change: either add a documented exception for
POST-with-body search, or move it to `GET /MyEntities?name=…&description=…`.
Deciding that once, centrally, is worth more than either edit.

---

## Two useful things `MyEntitiesController` does get right

**Policy-based authorization, exactly as mandated.** `[Authorize(Policy = "User")]`
— not `[Authorize(Roles = ...)]`, not `User.IsInRole()`. Both
`fusion-restructure.instructions.md` and `modernization-starter-boundaries` require
this, `AppMod-Acceptance-Criteria` lists role-centric authz as HIGH, and the
starter complies. It also confirms `"User"` as a real policy name — matching the
two named user-input gates (`User` and `Admin` group identifiers) in
`modernization-starter-boundaries`.

**A complete OpenAPI/Scalar surface.** Every action carries
`[ProducesResponseType<T>(...)]` including the `ProblemDetails` 400 shape. That is
the concrete backing for the Scalar-serves-at-`/scalar` claim in
`fusion-mcp-restructure` — the response types are what make that documentation
surface useful rather than empty.

**One Fusion helper worth noting:** `this.ToAbsoluteUrl($"MyEntities/{entity.Id}")`
in the `Created(...)` response. It is not a standard ASP.NET Core `ControllerBase`
member, so it comes from Fusion — the first Fusion extension method observed in
actual use, and a small proof that the starter really is composed on the Fusion
base rather than plain ASP.NET Core.

---

## ★ First hard facts about the build: .NET 10, `latest-all` analyzers, warnings-as-errors

`Starter.Library.csproj` is the first project file transcribed and it pins down
several things this import had only inferred:

| Setting | Value | What it confirms |
|---|---|---|
| `TargetFramework` | **`net10.0`** | the "highest **even** .NET major" rule resolves to 10 |
| `ImplicitUsings` | `enable` | why `MyEntity.cs` has no `using System;` |
| `Nullable` | `enable` | why `string? Description` is the idiom |
| `AnalysisLevel` | **`latest-all`** | *every* .NET analyzer rule is on |
| `TreatWarningsAsErrors` | **`True`** | …and every one of them fails the build |
| `Company` | `Dominion Energy` | inherited by every modernized app |
| `Version` | `1.0.0` | |

**First real Fusion package versions in the entire import:**

- `Fusion.Fx.App.Abstractions` **2026.3.5**
- `Fusion.Fx.Caching.Memory` **2026.3.5**
- `Microsoft.Extensions.Configuration.Json` **9.0.0**
- `OpenTelemetry.Api` **1.15.3**

The Fusion versioning scheme is calendar-based (`2026.3.5`), which matters for the
*"use the latest production version available in Sonatype feeds"* rule — a
CalVer package cannot be compared to a pinned example by semver intuition, so
"latest" has to be resolved from the feed, exactly as `fusion-mcp-restructure`
instructs.

Also worth noting: `OpenTelemetry.Api` is a direct dependency of the **Library**
project, which is the concrete backing for `dotnet.instructions.md`'s *"Prefer
OpenTelemetry where available."*

---

## ⚠ `latest-all` + `TreatWarningsAsErrors` is the most likely hackathon stall

This combination turns **every** .NET analyzer suggestion — including the
opinionated style and design rules that `latest-all` enables — into a build
failure. Then `dotnet.instructions.md` closes the escape hatches:

> - Ensure suggestions satisfy **ALL** .NET analyzers.
> - **Avoid suppressing warnings or errors**; prefer fixing the underlying issue.
> - Avoid `#nullable disable` unless absolutely necessary.

For the starter itself this is fine — it is 100 lines of clean, purpose-written
code. **The risk is Step 8**, where legacy code moves into `src/<AppName>.Library`.
Real legacy .NET Framework code ported into a `net10.0` project with
`latest-all` + warnings-as-errors + `Nullable=enable` will produce a very large
wall of build errors (CA-series design rules, nullability warnings on every
un-annotated reference type, IDE style rules), and the standing guidance says do
not suppress them.

This is not a defect — it is a deliberate quality bar, and a defensible one. But
it is a **predictable, high-volume failure mode at a known step**, and I found no
transcribed file that prepares a team for it or gives a sanctioned staging path.
Worth one of:

- a documented, time-boxed suppression policy for the Step 7/8 move window
  (e.g. `<AnalysisLevel>latest-recommended</AnalysisLevel>` until the move
  closes, then restore) — with the relaxation itself recorded as a gate-visible
  decision so it cannot be forgotten;
- or an explicit note in the Step 8 prompt that a large analyzer backlog is
  expected and how to work it down;
- or confirmation that `Directory.Build.props` (present at the repo root,
  untranscribed) already relaxes this for moved code.

**`Directory.Build.props` is now worth photographing** — it sits at the repo root
and can override every one of these properties solution-wide, so it may already
answer this.

---

## ⚠ A framework package one major version behind the target framework

`TargetFramework` is `net10.0` but `Microsoft.Extensions.Configuration.Json` is
pinned at **`9.0.0`**. That package works fine on net10.0 (it targets
netstandard2.0 / net8.0+), so nothing is broken — but a Microsoft framework
package sitting one major behind its host framework is the textbook signature of
a pin that was not carried forward during a TFM bump.

This is exactly what `tools/appmod/gates/check-pins` and `tools/appmod/pins.json`
exist to catch, and what `OpX-dotnet-upgrade.agent.md`'s **single-version package
invariant** is about. I cannot verify it from photographs — `pins.json` is not
transcribed and may deliberately pin 9.0.0. **Running `check-pins` against the
kit's own starter would settle it in seconds**, and it belongs on the same
"point the kit's gates at the kit" pass recommended earlier.

---

## ✅ MAJOR CORRECTION: the starter *does* have a properly documented reference — and it sits next to the bad one

`PublicTextService.cs` lives in the same folder as `MyService.cs` and is
**materially better on every axis the kit cares about**. This substantially
retracts the "the starter does not follow its own commenting standard" thread
running below.

```csharp
/// <summary>
/// Provides sample text for an anonymous API endpoint.
/// </summary>
public interface IPublicTextService
{
    /// <summary>
    /// Gets the sample text payload.
    /// </summary>
    Task<string> GetTextAsync(CancellationToken cancellationToken = default);
}
```

Point by point against the kit's own rules:

| Rule (source) | `PublicTextService.cs` | `MyService.cs` |
|---|---|---|
| Documented for a junior reader (`AGENTS.md`) | ✅ XML `<summary>` on interface, method, and class; `/// <inheritdoc />` on the impl | ✗ no comments |
| *"Prefer async/await following TAP"* (`dotnet.instructions.md`) | ✅ `Task<string>` | ✗ synchronous |
| *"Use `CancellationToken`"* | ✅ `CancellationToken cancellationToken = default` | ✗ absent |
| *"Name async methods with the `Async` suffix"* | ✅ `GetTextAsync` | n/a |
| Factor VI — stateless processes (`dominion-requirements`) | ✅ no instance state | ✗ **HIGH** — mutable `Dictionary` in a singleton |
| `sealed` on the implementation | ✅ | ✅ |

**So the accurate finding is not "the starter is undocumented."** It is:

> **The starter contains two adjacent reference services demonstrating opposite
> standards, with nothing marking which one to copy.**

That is a sharper and more actionable problem than the one recorded below.
`MyService.cs` is the larger, more feature-complete file (CRUD, filtering,
overloads) and is therefore the more likely template for a team building their
first real service — and it is the one that violates the rubric. The correct,
fully-compliant example is the smaller, less obviously reusable one.

**Revised recommendation, cheaper than before:** rather than writing new headers
from scratch, **make `MyService.cs` look like `PublicTextService.cs`** — add the
XML docs, make the interface async with `CancellationToken`, and either use
`ConcurrentDictionary` or add the header saying the in-memory store is an
intentional placeholder. The template for all of that already exists twenty lines
away in the same folder.

**Amendments to earlier sections, applied honestly:**

- "No starter file transcribed so far carries the mandated file header" — still
  literally true (these are type-level XML docs, not a file banner), but the
  *intent* of the rule is plainly met here. I am withdrawing this as a finding; it
  was over-read.
- The "starter has no comments" claim is now fully retracted. Two of five starter
  files carry comments; one carries proper XML documentation throughout.

**What does survive unchanged:** the two-public-types-per-file issue, which this
file also has (`IPublicTextService` + `DefaultPublicTextService`, in
`PublicTextService.cs` which matches neither name) — third instance. And the
`MyService.cs` HIGH compliance finding, which this file makes *worse* by proving
the kit knows how to do it correctly.

---

## ⚠⚠ The starter's reference service is a HIGH violation under the kit's own rubric

`MyService.cs` defines `DefaultMyService`, registered by the protected composition
seam as a **singleton**:

```csharp
// FusionApplicationBuilderExtensions.cs, line 21
fusionApplicationBuilder.Services.AddSingleton<IMyService, DefaultMyService>();
```

…and that singleton holds mutable instance state:

```csharp
// MyService.cs, line 16
private readonly Dictionary<Guid, MyEntity> _repo = [];
```

`dominion-requirements/SKILL.md` — the kit's own compliance rubric — lists this
exact shape as a Factor VI (stateless processes) violation, at lines 192-193:

> ```csharp
> // BAD - Instance state in singleton
> public class CacheService { private Dictionary<string, object> _cache = new(); }
> ```

…and grades it in its severity table at line 1285:

> | Instance state in singleton | **HIGH** |

Under the scoring formula in `COMPLIANCE-ANALYSIS-REPORT.template.md` and
`AppMod-Acceptance-Criteria.md` (`Score = 100 - (CRITICAL × 10) - (HIGH × 5) -
(MEDIUM × 2)`), **the starter ships with a −5 already on the board** for the
baseline review at Step 4 — before a team writes a line of their own code.

**To be fair to the design:** this is obviously a demo stub. An in-memory
`Dictionary` lets the starter build and run with no database, which is the right
call for a kit that must clone-and-go. The code itself is otherwise good — C# 12
collection expression `[]`, `TryGetValue` over double-lookup,
`StringComparison.OrdinalIgnoreCase`, and correct null handling
(`p.Description?.Contains(...) ?? false`).

**But three consequences follow, and none of them are hypothetical:**

1. **The compliance scanner will flag it.** Step 4's baseline review runs the
   `dominion-requirements` rubric across the workspace. Unless `src/` is excluded
   from the scan scope, every team starts at 95/100 with a HIGH finding they did
   not create, and has to work out that it is the kit's own placeholder.
2. **It is also a concurrency bug in waiting.** A singleton in ASP.NET Core serves
   concurrent requests; `Dictionary<K,V>` is not thread-safe for writes.
   `SaveEntity`/`DeleteEntity` from two simultaneous requests can corrupt it or
   throw. `ConcurrentDictionary` would fix that with a one-word change and would
   *still* be a Factor VI violation — worth doing anyway.
3. **Teams pattern-match the starter.** `copilot.instructions.md` says to *"use
   the starter projects in `src/` as the working reference."* A team wiring their
   first real service will copy this shape — singleton, sync, in-memory — into
   something that should be scoped and async against a database.

**Cheapest fix, and it costs nothing architecturally:** a file header comment
saying *"Placeholder in-memory implementation so the starter runs without a
database. Not a reference pattern — replace with a scoped, async, persistence-backed
service. Known Factor VI (stateless processes) violation, intentional."* That
converts a silent trap into a documented one, and it is exactly the file-header
the kit already mandates and this file (like the other three starter files) omits.

---

## ⚠ Two public types in one file — second instance, and this time the filename matches neither

`MyService.cs` declares `IMyService` (line 5) and `DefaultMyService` (line 14).
`dotnet.instructions.md` (which `applyTo`s `**/*.cs`) says:

> - **File names should match the primary type defined within.**
> - Non-trivial types should be in their own files.

Here the filename matches **neither type** — there is no `MyService` in the file.
That is a step worse than `FusionApplicationBuilderExtensions.cs`, where at least
the primary type matched.

Running tally of the kit's own artifacts failing the kit's own rules: **six**
(triple rerun rule, `kit-update` formatting defects, `constitution.md` duplicate
line, missing starter file headers ×4, two-public-types ×2, and now the HIGH
compliance finding above). The pattern is consistent enough to be worth one
deliberate pass: **run the kit's own gates and compliance review against the kit's
own repo.** `audit-modernization-pollution` and `compliance-scan` already exist;
nothing in the import suggests they have been pointed inward.

---

## `MyOptions.cs` — small, correct, and it closes a cross-reference

8 lines. The standard .NET options-pattern shape:

```csharp
public const string ConfigSection = "MyApp";
public string MyOption1 { get; set; } = string.Empty;
```

**It confirms the binding chain end to end.** `FusionApplicationBuilderExtensions.cs`
line 17 reads `MyOptions.ConfigSection`; this file defines it as `"MyApp"`. So the
demonstrated pattern is: *the config section name lives as a `const` on the options
type, never as a string literal at the registration site.* That is the concrete
form of `copilot.instructions.md`'s *"Prefer strongly typed options and named
sections over scattered ad hoc config lookups"* and `dotnet.instructions.md`'s
*"Bind settings from named configuration sections and inject them via
`IOptions<T>`"*. Worth naming explicitly as the pattern teams should copy.

`"MyApp"` is correctly a generic placeholder, not the validation app's name —
consistent with the naming law's prohibition on encoding the current app into
reusable assets.

Two very minor observations, neither worth acting on alone:

- **Not `sealed`**, where `MyEntity` is. For an options class that is arguably
  correct (binders and test doubles occasionally subclass), so this reads as
  deliberate rather than inconsistent.
- **No file header comment**, consistent with the other two starter files. Three
  for three now on that specific gap.

`const` over `static readonly` is fine — `AppMod-Acceptance-Criteria.md` lists
*"static readonly and const values"* explicitly under **Non-Violations**.

---

## ⚠ CORRECTED + NEW: the starter comments, but breaks a different one of its own rules

**Correction first.** The section below says the starter's code carries no
comments, generalising from `MyEntity.cs`. `FusionApplicationBuilderExtensions.cs`
**does** carry inline comments (`// Add Options to services`,
`// Add Library services`, `// Set this last to override all other sources`). So
the accurate statement is narrower: **neither file has the mandated file *header*
comment**, but inline commenting is present in the composition seam and absent in
the entity. The blanket claim below is too strong and is marked accordingly.

**New finding, and this one is a clean rule violation.** This file declares **two
public classes**: `FusionApplicationBuilderExtensions` (line 9) and
`AppConfiguration` (line 31). `dotnet.instructions.md` — which `applyTo`s
`**/*.cs`, so it binds this file — states:

> - **File names should match the primary type defined within.**
> - Types should be in separate files unless they are private nested types or very
>   small related types (e.g., enums, delegates).
>   - **Non-trivial types should be in their own files** for clarity and
>     maintainability.

`AppConfiguration` is a public static class with a public method that registers a
configuration source. It is not a nested type, not an enum, not a delegate. It
belongs in `AppConfiguration.cs`.

That makes this the **fifth** recorded instance of the kit's own artifacts failing
the kit's own rules — and the most consequential so far, because
`modernization-starter-boundaries.instructions.md` designates this exact file a
**protected starter control point** ("Library platform composition seam") that
agents may only edit within five narrow allowances. Agents are told to preserve
and pattern-match this file. They will therefore reproduce the two-public-types
pattern while a path-scoped instruction tells them not to.

---

## Structural facts added by `FusionApplicationBuilderExtensions.cs`

39 lines. This is the Library-side half of the Fusion composition pair
(`FusionWebBuilderExtensions.cs` in `Starter.Web.Api` is the other).

**The namespace is deliberately not the folder path.** The file lives at
`src/Starter.Library/Extensions/` but declares `namespace Fusion.Fx.App;` — the
Fusion framework's own namespace. That is the standard C# extension-method
discovery idiom: it makes `AddMyLibrary()` appear on `IFusionApplicationBuilder`
without callers adding a `Starter.Library.Extensions` using. Compare
`MyEntity.cs`, which uses the folder-matching `namespace Starter.Library.Entities;`.

**This is worth flagging to the linter as a deliberate exception**, not drift. A
naive "namespace must match folder" check would fire on it, and "fixing" it would
silently break every call site that relies on the extension being in scope.

**The registration pattern teams will copy:**

```csharp
public static IFusionApplicationBuilder AddMyLibrary(
    this IFusionApplicationBuilder fusionApplicationBuilder
)
```

…options bound via `Services.Configure<MyOptions>(Configuration.GetSection(MyOptions.ConfigSection))`
— note `MyOptions.ConfigSection` is a static member on the options type, so the
section name lives with the type rather than as a literal at the call site. Then
`AddSingleton<IMyService, DefaultMyService>()` and
`AddSingleton<IPublicTextService, DefaultPublicTextService>()`, and the builder is
returned for chaining.

This is the concrete shape behind the abstract rule in `copilot.instructions.md`:
*"Move DI registration into the existing Fusion application builder extensions."*

**A config file not in the file tree:** `appsettings.Override.json`, registered
via `AddJsonFile(..., true)` (optional) and commented *"Set this last to override
all other sources."* It appears in no transcribed instruction file and is not in
the `.github` tree manifest — worth knowing it exists, since it is the documented
last-write-wins configuration layer.

**Formatting confirms CSharpier is actually in use** — trailing `)` on its own
line, generic argument lists broken across lines when long. `dotnet.instructions.md`
names CSharpier as the formatter; this file demonstrates it, which is a small
point in the kit's favour (a stated tool that is visibly applied).

---

## ⚠ The starter's own code does not follow the kit's commenting standard

`MyEntity.cs` is the first `src/` file transcribed, and it is a clean, modern C#
reference: file-scoped namespace, `sealed`, nullable reference types
(`string? Description`), the C# 11 `required` modifier with matching
`[SetsRequiredMembers]` on both constructors, and a get-only `Guid Id` assigned in
the constructor. No `using System;` — implicit usings are enabled. As a
demonstration of the target-state idiom it is good.

**But it has no comments at all** — no file header, no member documentation.
*(SCOPE NARROWED: see the correction above — `FusionApplicationBuilderExtensions.cs`
does carry inline comments. The claim that survives is that **no starter file
transcribed so far carries the mandated file header**.)* That contradicts the
standard the kit mandates for every modernized file, in three separate always-on
places:

`AGENTS.md` (loaded by every Squad agent, every session):

> - Be more aggressive with comments than a typical production repo.
> - **Every new or modified source, test, and important configuration file should
>   contain enough comments for a junior developer and QA reviewer to understand
>   the file quickly.**
> - Important files should start with a short header comment explaining the file
>   purpose, the main behavior or responsibility, key dependencies or
>   collaborators, and any notable safety or parity constraints.

`copilot.instructions.md` says the same thing verbatim (it is the migration
source), and `tests-commenting.instructions.md` extends it to everything under
`tests/`.

**Why this matters more than a normal style nit:** `src/Starter.*` is not
incidental code. `modernization-starter-boundaries.instructions.md` names it as
*"the implementation source of truth for Fusion-owned platform behavior"*, and
`copilot.instructions.md` says to *"use the starter projects in `src/` as the
working reference for Fusion-aligned hosting, configuration, logging, and frontend
structure."* Agents are told to pattern-match against these files.

So the kit tells every agent "comment aggressively," then hands them a reference
implementation with zero comments. In a hackathon, the demonstrated pattern will
beat the written rule — agents copy what they see. Either the starter files get
the header comments the standard requires, or the standard should exempt
starter/reference code explicitly.

This is the same class of defect as the duplicated rerun rule and the
`kit-update.instructions.md` formatting errors: **the kit's own artifacts do not
pass the kit's own rules.** It is now the fourth instance recorded, and the first
one in shipped source code rather than documentation.

*(Caveat: this is one file of the starter. Other `src/` files may well carry
headers. Worth a spot-check across `Program.cs`,
`FusionWebBuilderExtensions.cs`, and a service or controller before treating it as
systemic.)*

---

## ★★ The schemas README validates the analysis above — and makes the enum fix trivial

`contracts/schemas/README.md` is the spec for the whole family, and it confirms
independently almost everything derived by inspection in the sections below.

**1. `enum` is a first-class key in the dialect — and the README's own example
uses it on a `status` field.** The dialect reference lists eight keys (`type`,
`required`, `fields`, `notEmpty`, **`enum`**, `minItems`, `arrayOf`, `rootPath`),
and the Minimal example shows exactly the shape recommended earlier:

```json
"status": { "type": "string", "notEmpty": true, "enum": ["Ready", "Blocked"] }
```

So the status-enum fix is not a feature request — **the mechanism exists, is
documented, and is demonstrated on a field literally named `status`.** Adding
`"enum": [...]` to `step-workflow-state.schema.json` is a supported one-key edit.

**2. Why a custom dialect at all** — a genuinely good constraint I had not seen
stated: *"The kit must run on **Windows PowerShell 5.1**, where `Test-Json
-Schema` is not available (it needs PowerShell 7+). Rather than add a dependency
or require a newer shell from every developer who receives the kit, the verifier
uses a tiny, dependency-free dialect."* Implemented in
`.github/scripts/shared/field-contract.ps1`.

**3. The gate semantics are precise**, and they matter for reading every finding
above:

| Situation | Effect |
|---|---|
| `hardStop` input or produced output **present but invalid** | blocks, exit code 2 |
| `advisory` / `conditional` input present but invalid | warning, does not block |
| contract file itself missing or corrupt | loud `SchemaError`; never silently passes, never hard-blocks |

*"This is the line between 'the file exists' and 'the file is actually usable by
the next step'."*

**4. The two grounding situations are the kit's own words for the pattern derived
above.** Section `## Floor strength: ground it, do not guess it` names exactly the
split found by inspection — deterministic producer (ground the floor in the
writer's guaranteed fields) versus agent-authored with no sample (stay
conservative). It even names the same three high-fan-out artifacts:
`decisions.json`, `migration-plan.json`, `control-point-inventory.json`.

**5. The `## Current registry` table is the kit's own summary of all nine
contracts**, and it matches the tally assembled independently in this document
row for row. Worth reading as the authoritative version.

**6. Three principles worth carrying into Squad verbatim:**

> A field contract MUST pass on a **legitimately initialized** artifact.

> A contract that is too strict is worse than no contract, **because it blocks
> valid runs and trains developers to ignore the gate.**

> Never invent fields that no producer emits.

That middle one is the best articulation in either kit of why over-strict gates
fail — and it reframes the conservative floors below as a deliberate anti-pattern
defence rather than laziness.

---

## ⚠ SOFTENED: the "hollow gate" findings are less damning than stated — but the fix still stands

Two sections below characterise `control-point-inventory.json` and
`per-route-behavior-plan.json` as effectively unvalidated. The README supplies
context that makes the kit's choice defensible, and one fact that materially
changes the picture:

**Schemas are only one of two layers, by design.** Section `## Shape vs. truth`:

> A field contract proves an artifact is well **formed**. It cannot prove the
> artifact is **true** against the rest of the workspace — a catalog entry can be
> perfectly valid JSON yet name a test file that was never created. That second
> failure mode (**hallucinated-but-believable content**) is caught by the
> **reconciliation engine** at `Invoke-StepReconciliation.ps1`.

- **Schema** = does the file have the right shape and required fields?
- **Reconciliation** = does the file's content agree with the source tree and the
  other artifacts?

So a thin `control-point-inventory.json` is not meant to be caught by the schema;
it is meant to be caught by reconciliation. **The honest restatement of the
earlier finding is therefore:** those artifacts are unprotected *at the schema
layer*, and whether they are protected at all depends on whether a reconciliation
rule exists for them.

**And here is the part that keeps the finding alive:** the README states that
**reconciliation rules are registered per step, and the *first* rule runs at Step
17** — the executable-testcase-catalog / test-file-exists rule. That is the only
rule described. If Step 17 carries the first rule, then Steps 8-14 — every step
that `hardStop`s on `control-point-inventory.json`, and Steps 11-12 which tick off
`per-route-behavior-plan.json` — run with **neither** a meaningful schema floor
**nor** a reconciliation rule.

Revised recommendation, more precise than before: **add reconciliation rules for
`control-point-inventory.json` and `per-route-behavior-plan.json` at their first
consuming steps (8 and 11).** The engine, the registration pattern, and the
developer-guiding remediation format all already exist — the Step 17 rule is the
template. That is a better fix than tightening the schemas, and it is the one the
kit's own architecture points to.

---

## ✅ ALL NINE `.github/contracts/schemas/` FILES TRANSCRIBED — and the status-enum question is settled

`step-workflow-state.schema.json` completes the set. It is **by far the richest
contract in the family** — 66 lines, three levels of nested objects, an `arrayOf`
construct, and `required[]` arrays at four different depths. It is the only one
that looks like a real schema rather than a floor.

**But it does not pin a status enum.** The one field this import most wanted
constrained is declared as:

```json
"status": { "type": "string", "notEmpty": true }
```

…at the top level, and the same at `lastExecutedStep.status`, and weaker still at
`stepResponses.steps[].status` (`{ "type": "string" }`, no `notEmpty`).

So **the four competing status vocabularies recorded earlier in this document are
all schema-valid**:

| Source | Terminal statuses | Passes this schema? |
|---|---|---|
| `copilot.instructions.md` | `Completed`, `Blocked`, `Failed` | ✅ |
| `appmod-phase-agent-contract` | `Completed`, `Blocked`, `Partial` | ✅ |
| `AppMod-Process` | `Pass`, `Partial`, `Blocked`, `Fail` | ✅ |
| `discovery-runner` | `Pass`, `Partial`, `Blocked`, `Fail` | ✅ |

Nothing anywhere in the kit rejects `Failed` where another file expects `Fail`, or
`Completed` where another expects `Pass`. The recommendation stands and is now
precisely located: **add an `enum` to `status` in
`.github/contracts/schemas/step-workflow-state.schema.json`** (three places), and
pick one vocabulary. This is a ~5-line edit to a file that already exists and is
already wired into the verifier.

**Why the floor is low here is at least principled**, unlike some of the others:

> **Required floor only.** This contract MUST pass on a **freshly reset state
> file**, where `updatedAt` and `latestFullResponse` are empty strings,
> `lastExecutedStep.step` is `0`, and `stepResponses.steps` is an empty array.
> Only fields that are non-empty **even at init** use `notEmpty` (`status`,
> `lastExecutedStep.status`, `recommendedNextStep.label`).

That is a genuinely careful piece of contract design — the floor is set by what
`reset-step-zero-state.ps1` emits, so a reset workspace validates. An `enum` on
`status` would not break that, because `status` is non-empty at init by design.

**Five required top-level fields:** `status`, `updatedAt`, `lastExecutedStep`,
`recommendedNextStep`, `stepResponses`. The nested shapes fill in several field
names this import had only seen referenced in prose:

- `lastExecutedStep`: `step` (number), `status`, `label`, `promptPath`, `ranAt`, `reason`
- `recommendedNextStep`: `step` (number), `label`, `promptPath`
- `stepResponses.steps[]`: `step` (number), `status`, `updatedAt`, `latestFullResponse`

Note `promptPath` on both step objects — that is the natural place a
`step:<stepId>` token would live once the registry migration finishes, and it is
currently an unconstrained string.

---

## Final tally: what the nine `opx-field-contract/v1` schemas actually assert

| Schema | Deterministic producer | Required fields | Floor |
|---|---|---|---|
| `step-workflow-state` | ✅ `reset-step-zero-state.ps1` | **5 + nested** | rich |
| `modernization-execution-contract` | ✅ `New-ControlPlaneSkeleton` | 2 | identity |
| `modernization-phase-assessment` | ✅ `New-ControlPlaneSkeleton` | 2 | identity |
| `modernization-solution-design` | ✅ `New-ControlPlaneSkeleton` | 2 | identity |
| `fusion-decisions` | ✗ | 0 (1 field typed) | presence |
| `executable-testcase-catalog` | ✗ (2 divergent) | 0 | presence |
| `fusion-control-point-inventory` | ✗ | 0 | presence |
| `fusion-migration-plan` | ✗ | 0 | presence |
| `per-route-behavior-plan` | ✗ | 0 | **`notEmpty` only** |

**The correlation is perfect: every schema with a deterministic producer asserts
required fields; every schema without one asserts none.** That is the single
clearest actionable pattern in this entire import.

Four of the five unprotected artifacts are Step 5/6 planning outputs that later
steps `hardStop` on. The fix for all four is the same and the kit already owns the
mechanism: **point `New-ControlPlaneSkeleton` at `decisions.json`,
`migration-plan.json`, `control-point-inventory.json`, and
`per-route-behavior-plan.json`**, then promote each schema's named candidate
fields to `required`. Every one of those four `authoringNote`s already names its
promotion target.

---

## ⚠⚠ The weakest contract in the kit guards the artifact that stops "dead shell" shipping

`per-route-behavior-plan.schema.json` has **no `type` key at all** — the only
schema in the family that omits it. Its entire assertion is:

```json
"notEmpty": true
```

The reason is a **fourth** distinct cause, different from the three catalogued
earlier: the root *container shape* itself is unproven.

> Agent-authored at Step 6 with NO deterministic producer and NO committed
> sample, so **the exact ROOT container is not proven** - it may be a bare array
> of route entries **or** an object wrapping a routes array. The floor therefore
> **omits `type`** and only asserts `notEmpty`, which accepts a non-empty array
> OR a non-empty object.

Complete taxonomy across seven schemas, now four causes:

| Cause | Schema | Floor |
|---|---|---|
| Producer divergence (root key) | `executable-testcase-catalog` | `type`+`notEmpty` |
| No consumer at all | `fusion-control-point-inventory` | `type`+`notEmpty` |
| Defensive consumers | `fusion-migration-plan` | `type`+`notEmpty` |
| **Root container unproven** | **`per-route-behavior-plan`** | **`notEmpty` only** |

**Why this one matters more than its size suggests.** `per-route-behavior-plan.json`
is the artifact the entire "page renders is not page works" doctrine rests on.
From `frontend-modernization-learning.instructions.md`:

> Step 6 owns the per-route behavior plan … Routes whose interactive controls or
> data calls are not enumerated at Step 6 are a **Step 6 blocker**, not a Step 11
> or Step 12 discovery item — **this is the only way to keep the kit repeatable on
> the next application without rediscovering the same dead-shell failure mode.**

And the `groundedBy[]` here confirms the consumers:
`AppMod-Step-Contract.json` — *"Steps 11 and 12 tick off route entries"*.

So: Steps 11 and 12 tick entries off a plan whose only validation is "this file
is not empty." A plan listing one route with no behavior fields passes. The
`ownerStep` drain gate, the `perRouteBehaviorList`, the `no button is dead` rule
— all of it downstream of a contract that cannot tell a complete route inventory
from a stub.

This is the same shape as the `control-point-inventory` finding, and it lands on
the other half of the kit's parity story: control points guard the backend/platform
seams, per-route behavior guards the frontend behavior seams. **Both are
agent-authored, both have no deterministic producer, and both are effectively
unvalidated.**

**The fix is the same and the note already names it:** *"TIGHTEN ONLY after
observing a real produced file: pin the root (array vs `object+routes[]`) and
promote the four behavior fields to required per entry."* One committed sample
from a completed run resolves the root-shape question, and the four behavior
fields (`primaryDataCalls`, `interactiveElements`, `modalsAndBanners`,
`placeholderDataPolicy`) are already named as the promotion targets.

**Also useful:** this schema documents the full Step 6 entry shape, which no
other transcribed file gives in one place — `route`, `legacyRoute`,
`primaryDataCalls`, `interactiveElements`, `modalsAndBanners`,
`placeholderDataPolicy`. Six fields; the last four are the behavior contract.

And it independently confirms **Step 6** as the owner, which settles the +2 drift
recorded earlier where `frontend-modernization-learning` said "route back to
Step 8" one line after saying Step 6 owns it. Step 6 is correct.

---

## ★ `New-ControlPlaneSkeleton` already covers three artifacts — the fix is even cheaper than stated

`modernization-phase-assessment` and `modernization-solution-design` are
near-identical twins of `modernization-execution-contract`: same two producers,
same identity-only floor, same `required: ["reportId", "title"]`, same two
`fields` definitions. Only the operational-array name differs
(`phases` vs `sections` vs `orderedSlices`).

So **`New-ControlPlaneSkeleton` is already a multi-artifact writer** — it emits at
least three control-plane files with a guaranteed `reportId` + `title` shape.
That makes the recommendation from the previous batch cheaper than I stated: the
function does not need to be generalised, only **pointed at three more targets**
(`control-point-inventory.json`, `migration-plan.json`, `decisions.json`). Every
one of those three currently has zero required fields and, in the control-point
case, nine hollow `hardStop` gates.

The three schemas it already covers are the only ones in the family with a
`required[]` array. That correlation is the whole argument.

---

## ⚠ The "machine form" JSON artifacts are effectively write-only

A detail repeated across all three skeleton-backed schemas, easy to miss and
important:

| Schema | Who actually reads the content |
|---|---|
| `modernization-phase-assessment` | *"Steps 7 and 8 read the **markdown** Phase-Assessment report by exact path and treat this JSON defensively"* |
| `modernization-solution-design` | *"Step 8 reads the **markdown** Solution-Design report by exact path and treats this JSON defensively"* |
| `modernization-execution-contract` | *"Step 7 reads this as an **advisory** input with a deterministic fallback"* |

So for all three, the real consumers read the **Markdown twin**
(`Modernization-Phase-Assessment.md`, `Modernization-Solution-Design.md`,
`Modernization-Execution-Contract.md` under `.modernization/ignition-artifacts/`),
and the JSON "machine form" is treated defensively or advisorily.

Two consequences worth stating plainly:

1. **It explains why the identity-only floor is defensible.** Nothing depends on
   the JSON's operational content, so requiring it would add risk without adding
   protection. The kit's reasoning holds.
2. **But it means the machine-readable half of the control plane is not actually
   driving anything.** The portal JSONs exist, are validated for identity, and are
   read defensively — while the decisions that matter flow through prose Markdown
   parsed *"by exact path."* For a kit whose whole thesis is deterministic,
   machine-checkable evidence, that is an inversion worth being deliberate about.
   Either the JSON should become the source of truth (and the Markdown rendered
   from it), or the JSON's status as a rendering artifact should be stated so
   nobody mistakes a passing schema check for a validated plan.

This also retro-explains the artifact-contract finding recorded much earlier:
Step 5 produces both a `.md` and a portal `.json` for each of these three
concepts. They are not redundant — the `.md` is the live input and the `.json` is
the machine mirror. Nothing transcribed said so until now.

---

## ★★ `New-ControlPlaneSkeleton` — the mechanism that fixes the nine-hollow-gates problem

`modernization-execution-contract.schema.json` is the strongest schema in the
family, and the reason is one line in its `groundedBy[]`:

> `.github/scripts/shared/verify-step-artifacts.ps1 :: **New-ControlPlaneSkeleton**`
> (deterministic No-QA writer; **authoritative minimum shape**)

**A script already writes control-plane artifacts deterministically.** That is
exactly the missing piece identified in the `fusion-control-point-inventory`
finding above. The kit does not lack the capability — it has a named function,
inside a script every step already runs, whose stated job is to emit an
authoritative minimum shape.

And the payoff is visible in the same file: this is the **only** schema so far
with a `required[]` array:

```json
"required": ["reportId", "title"],
"fields": {
  "reportId": { "type": "string", "notEmpty": true },
  "title":    { "type": "string", "notEmpty": true }
}
```

The note explains the logic precisely:

> Two legitimate producers write this file: the deterministic No-QA skeleton
> (`New-ControlPlaneSkeleton`, which always writes `reportId` + `title`) and the
> Step 5 agent (enriched, derived from real inventory). **This contract MUST pass
> on the skeleton, so the required floor is intentionally identity-only.**

So the rule generalises: **a deterministic producer guaranteeing a field is what
makes that field requirable.** Consumer-proof (the `fusion-decisions` route) is
one path; producer-guarantee is the other, and it is stronger because it does not
depend on anyone having written a consumer yet.

**Concrete recommendation, now specific rather than general:** extend
`New-ControlPlaneSkeleton` to emit an identity floor for
`control-point-inventory.json` (and `migration-plan.json`, and `decisions.json`).
Each then gets a guaranteed minimum shape, each schema can promote those keys to
`required`, and the nine hollow `hardStop` gates on the control-point inventory
start asserting something. The function, the script, and the pattern all already
exist — this is wiring, not invention.

---

## The three reasons a schema stays at "presence only" — now complete

`fusion-migration-plan.schema.json` supplies a **third** distinct cause, different
from the first two:

> Every observed script consumer accesses fields **defensively**
> (`step7UpgradeWorkspaceRoot`, `step9UpgradeWorkspaceRoot`,
> `launchContracts.upgradedRuntime.verificationUrls` are all read behind
> `-contains` guards or `try/catch`), so **NONE are safe to mark required without
> risking a false block.**

The full taxonomy across five schemas:

| Cause | Schema | Why no field can be required |
|---|---|---|
| **Producer divergence** | `executable-testcase-catalog` | two producers, different root keys (`entries[]` vs `testCases[]`) |
| **No consumer at all** | `fusion-control-point-inventory` | only `Test-Path`; nothing reads a field |
| **Defensive consumers** | `fusion-migration-plan` | every read is guarded, so absence is already tolerated |
| *(resolved)* consumer-proven | `fusion-decisions` | 3 consumers read `browserSurfaceApplicability` → 1 field asserted |
| *(resolved)* producer-guaranteed | `modernization-execution-contract` | `New-ControlPlaneSkeleton` always writes `reportId` + `title` → 2 fields required |

That third cause is subtly the most interesting: **defensive coding in consumers
is what prevents the contract from tightening.** Guards were presumably added to
stop crashes on missing fields, and the side effect is that the field can never be
made mandatory. It is a real engineering trade-off, correctly identified, and
worth naming explicitly when the kit decides which fields to pin.

**Bonus cross-reference:** this schema confirms that **both**
`step7UpgradeWorkspaceRoot` and `step9UpgradeWorkspaceRoot` are read by
`03-P1-build-verify-legacy-runtime.ps1`. That is independent confirmation of the
deliberate compatibility shim first spotted in `OpX-dotnet-upgrade.agent.md` —
the `step9` name is a live alias, not a stale typo, and renaming it would break
this script.

---

## ✅ ANSWERED: yes, a schema *can* assert a field — and the mechanism is consumer-proof

`fusion-decisions.schema.json` is the first of the nine to carry a `fields` block:

```json
"fields": {
  "browserSurfaceApplicability": { "type": "string", "notEmpty": true }
}
```

And `groundedBy[]` shows exactly why this one could when the previous two could
not — **three independent consumers read that field**:

| Consumer | How it reads it |
|---|---|
| `21-P3-figma-review.prompt.md` | reads `browserSurfaceApplicability`, "and Steps 10/11/22/23 (frontend-lane gate)" |
| `qa-refresh-portal.ps1` | reads `browserSurfaceApplicability` with `-contains` guards; presence-based otherwise |
| `05-P1-modernization-solution-design.prompt.md` | authors it (Step 5) |

This confirms the rule stated in the `fusion-control-point-inventory` note as a
working principle, not an excuse: **a field becomes assertable exactly when a real
consumer proves it is needed.** No consumer → no required field → the schema
degrades to a presence check. One consumer that actually reads a key → that key
can be promoted.

That is a genuinely good design principle, and it makes the earlier finding
sharper rather than softer: `control-point-inventory.json` has no asserted field
**because nothing reads one**, which is the same reason its nine `hardStop` gates
are hollow. The fix for both is identical — make a script read a field.

Revised pattern across the three schemas transcribed so far:

| Schema | Producers | Consumers reading fields | Asserted fields |
|---|---|---|---|
| `executable-testcase-catalog` | 2, diverging root keys | reconciliation engine only | none (`type`+`notEmpty`) |
| `fusion-control-point-inventory` | 1 (agent), no sample | **none** — `Test-Path` only | none (`type`+`notEmpty`) |
| `fusion-decisions` | 1 (agent), no sample | **3**, all reading `browserSurfaceApplicability` | **1** ✅ |

So `.github/contracts/schemas/` is not uniformly a presence layer — it is a
presence layer *wherever no consumer has proven a field*, which is a much more
defensible position and one the kit arrived at deliberately.

`browserSurfaceApplicability` also turns out to be the single most load-bearing
field in the kit: it gates the entire frontend lane (Steps 10, 11, 13-16 via
`Required` / `NotApplicable`) plus the Step 21 visual review, and appears
throughout `AppMod-Process.instructions.md`'s exit criteria. It is fitting that it
is the one field with a contract.

---

## ⚠⚠ HIGHEST-SEVERITY FINDING YET: nine `hardStop` gates guard a file nothing validates

`fusion-control-point-inventory.schema.json` covers
`control-point-inventory.json`. Its `authoringNote` is blunt:

> **CONSERVATIVE FLOOR.** Agent-authored at Step 5 with **NO deterministic
> producer and NO committed sample**. **No script reads any specific field from
> this file — every consumer is presence-based** — so there is no consumer-proven
> field to require. The floor only asserts a non-empty object … TIGHTEN ONLY after
> observing a real produced `control-point-inventory.json`.

And `groundedBy[]` names the only script that touches it:

> `.github/scripts/QA/qa-refresh-portal.ps1` (consumes this **PRESENCE-only via
> `Test-Path`**; **no deterministic field access found in any script**)

Now cross-reference `AppMod-Artifact-Contract.json`, transcribed earlier in this
import. `control-point-inventory.json` is a **`hardStop` required input for nine
steps: 8, 9, 10, 11, 12, 13, 14, 18, and 19.** More than a third of the pipeline
refuses to start without it.

**What that combination means in practice:**

- The file is produced by an agent writing prose-derived JSON at Step 5. No script
  generates it, and no committed sample exists to compare against.
- The only validation anywhere in the kit is "is it a non-empty object."
- The only script consumer checks `Test-Path` — i.e. *does the file exist*.
- Therefore an agent that writes `{"note":"tbd"}` at Step 5 satisfies **all nine
  `hardStop` gates**, and every downstream step that claims to consume "control
  points" proceeds on content nothing has checked.

This is the exact failure mode `discovery-runner.instructions.md` warned about in
different words — *"presence-only checks cannot tell a 14-service inventory from
the ~40 services that actually exist"* — but here it is structural rather than
incidental, and it sits under the single most-depended-on artifact in the
pipeline.

**It is also the strongest possible argument for the two-layer verification model
the kit already designed.** Layer 1 (presence) is all this artifact has. Layer 2
(independent AI completeness review against real ground truth) is the only thing
that could catch a thin control-point inventory — and the runner applies Layer 2
only to Discovery Steps 1-6 today. Steps 8-19 consume this file with Layer 1 alone.

**Concrete fixes, cheapest first:**

1. **Commit a real sample.** The note says the blocker is "NO committed sample."
   One good `control-point-inventory.json` from a completed run unblocks
   tightening the schema — the note even names the target
   (`controlPoints[]` → `required` + `minItems`).
2. **Extend the reviewer completeness gate past Step 6.** Steps 8-14 consume this
   file; that is where a thin inventory does damage.
3. **Give it a `groundedBy` script consumer.** As long as no script reads a field,
   no field can ever be proven required — the note is explicit that this is what
   keeps the floor low.

---

## ★ The `opx-field-contract/v1` dialect, and a defect the kit documents instead of fixing

`executable-testcase-catalog.schema.json` is the first of the nine
`.github/contracts/schemas/` files transcribed, and it reveals the dialect that
`AppMod-Artifact-Contract.json`'s `schemaNote` referred to without explaining.

**Two distinct schema directories now confirmed** — do not conflate them:

| Directory | Dialect | Count | Purpose |
|---|---|---|---|
| `.github/contracts/schemas/` | `opx-field-contract/v1` | 9 + README | per-step artifact **field contracts**, referenced by `AppMod-Artifact-Contract.json`'s `schema` key |
| `tools/appmod/schemas/` | JSON Schema | 5 + examples + README | the **canonical hourglass artifacts** (`app-profile`, `component-map`, `endpoint-inventory`, `scorecard`, `ui-inventory`) |

**The `opx-field-contract/v1` shape**, from this example: `dialect`,
`contractId`, `title`, `appliesTo` (the artifact path it validates), `rootPath`,
`groundedBy[]` (the real producers, each described), `authoringNote`, then the
assertions themselves (`type`, `notEmpty`). It is deliberately lightweight —
`AppMod-Artifact-Contract.json` called it *"a lightweight opx-field-contract/v1
file"* and that is accurate: this one asserts only `type: object` and
`notEmpty: true`.

**And the `authoringNote` is the most candid thing in the entire kit.** It
documents a real, unresolved defect and explains why the schema deliberately
declines to catch it:

> **CONSERVATIVE FLOOR + KNOWN PRODUCER DIVERGENCE.** This artifact has TWO real
> producers that wrap their case array under **DIFFERENT root keys**: the
> deterministic generator writes `entries[]`, while the Step 6 prompt example
> writes `testCases[]`. Because of that divergence the floor only asserts a
> non-empty object … and does **NOT** require either array key (requiring one
> would false-block the other producer). … **TIGHTEN ONLY after the kit reconciles
> the two producers to a single canonical root key**; then promote that key to
> required + minItems here.

Three things worth drawing out:

1. **This is a genuine producer divergence, named and located.**
   `.github/scripts/QA/generate-characterization-catalog.ps1` and
   `.github/prompts/06-P1-modernization-quality-design.prompt.md` disagree about
   the root key of the same artifact. It is exactly the class of defect this import
   has been cataloguing — except here the kit found it first and wrote it down.
2. **The mitigation is honest but weak.** The schema degrades to "is it a
   non-empty object" — which, as the note says, catches empty `{}`, `[]`, blank,
   and truncated content, and nothing else. Real validation is deferred to
   `Invoke-StepReconciliation.ps1`, *"which probes BOTH root keys."* So the
   contract layer knowingly under-asserts and relies on a downstream script.
3. **It records the exit condition.** "Tighten only after the kit reconciles the
   two producers to a single canonical root key." That is a concrete, closeable
   task with a named acceptance test — the best kind of TODO. **Reconciling
   `entries[]` vs `testCases[]` is a small, high-value fix to land before the
   hackathon**, because until it lands, the executable testcase catalog is
   effectively unvalidated at the schema layer.

The `groundedBy[]` field is itself a good design: it names every real producer of
the artifact and summarises each one's actual output shape. If the other eight
schemas carry it, that array is a ready-made producer/consumer cross-check —
and would have answered several questions raised earlier in this document.

---

## ★★★ THE 5 CANONICAL JSON ARTIFACTS ARE IDENTIFIED

`AGENTS.md`'s hourglass says every legacy stack funnels through *"the 5 canonical
JSON artifacts (`tools/appmod/schemas/`)"* without naming them. The final tree
photo does:

| # | Schema |
|---|---|
| 1 | `app-profile.schema.json` |
| 2 | `component-map.schema.json` |
| 3 | `endpoint-inventory.schema.json` |
| 4 | `scorecard.schema.json` |
| 5 | `ui-inventory.schema.json` |

Plus `examples/` (matching `*.json` samples) and a `README.md`.

These are the pivot point of the whole architecture — everything upstream is
stack-specific, everything downstream is shared. That was the #2 item on the
backlog and it is now closed at the name level; the schemas themselves are still
untranscribed and are worth having, because they define the contract every
adapter must satisfy.

**The full `tools/appmod/` layout:**

- `pins.json`, `verify-kit.ps1` / `verify-kit.sh`
- `gates/` — seven gates, each shipping both `.ps1` and `.sh`:
  **`check-auth-removed`**, `check-pins`, `check-structure`, `run-scorecard`,
  `validate-artifacts`, `verify-goldens`, `visual-diff` — plus `README.md` and a
  Python `lib/` (`_common.py`, `_schema.py`, `check_*.py`, `run_scorecard.py`,
  `validate_artifacts.py`, `verify_goldens.py`, `visual_diff.py`) with **7
  pytest-style test modules**
- `schemas/` — the five above
- `scorecard/` — `rubric.md`, `VERSION`, and `engine/` (`engine.py`, `README.md`,
  `tests/test_engine.py`)

**Reported total for the repo: 680 files.**

---

## ⚠ CORRECTION: `tools/appmod/` is present, and `check-auth-removed` exists

Two things I got wrong, both now fixed in the manifest:

1. **I wrote that `tools/appmod/` was absent from the tree.** It is not — it is
   the final branch, and I said so before the last tree photo arrived. That claim
   was unsupported and is withdrawn.
2. **`check-auth-removed` exists.** Early in this import I listed *"`check-auth-removed`
   gate documented but nonexistent in `.squad/gates/`"* among the five
   highest-risk hackathon defects. It ships in `tools/appmod/gates/` as both
   `.ps1` and `.sh`. I was looking in the wrong directory — the gates live under
   `tools/appmod/`, not `.squad/`. **That finding is retracted.**

Given I was wrong about `tools/appmod/`, the remaining apparent absences from the
tree (`discovery-runner.instructions.md`, `step-registry.json`) should be read as
a likely **rendering or scroll gap in the generated tree**, not as evidence of a
different snapshot. Both files were photographed directly, so both exist. The
manifest now says so.

**`manifests/ignition-kit-file-tree.md` is still best read as a high-quality
inventory rather than a byte-exact listing** — it collapses branches into
parenthesised counts throughout — but the "different snapshot" theory is
withdrawn.

---

## ⚠ `.squad/` in that repo is a much larger distribution than the one here

The tree's `.squad/` carries `casting/`, `fact-checker/`, `identity/`, `memory/`,
`rai/`, 11 `squad-*.yml` GitHub Actions workflows, 30+ templates, and **50+
template skills** (agent-conduct, git-workflow, humanizer, model-selection,
`ralph-*`, reflect, secret-handling). Its agent roster includes `Rai`, `ralph`,
`scribe`, `docs`, `fact-checker`, and `security` alongside lead/frontend/backend/
reviewer/tester.

That is a substantially bigger Squad than the one in this workspace, and it
explains the `D-001..D-016` decision count. The six unknown decisions
(D-011..D-016) most likely belong to that larger distribution.

Also worth noting: `OpXUtil/notes/sql-param-type-drift` exists — the provenance
for the `AddWithValue`/`SqlDbType` section in `dotnet.instructions.md`. That
section was written from a real incident, and the note is still on disk.

---

## ★★ `AGENTS.md` — the merge is documented from the inside, including what was deliberately left out

114 lines at the repo root. This is the file `copilot-instructions.md` cites four
times, and it turns out to be the clearest artifact of the merge itself.

**It states its own migration provenance in a blockquote** (lines 6-13):

> Phase 2: the always-true engineering conventions below are **migrated verbatim
> from the legacy kit** (`.github/instructions/copilot.instructions.md`,
> `appmod-agent-personality-baseline.instructions.md`,
> `.github/copilot-instructions.md`), **preserving their exact wording**.
> Ignition-specific operational plumbing (QA portal, numbered-step state files,
> `.modernization` paths) is **intentionally NOT restated here** - it stays in the
> Ignition process files … which Squad executes as its runner. Stack-specific
> standards (.NET / Angular / naming) live in `.github/skills/appmod-*`, not here.

That is a merge note written *into the merged file*: what was copied, from where,
what was deliberately excluded, and why. It answers a question this import kept
raising — whether duplicated wording between files was drift or intent. Here it is
**intent, and labelled**.

The verbatim claim checks out. The Readability, Comments, Testing, Configuration,
Accessibility, and Git-hygiene bullets match
`.github/instructions/copilot.instructions.md` almost word for word, and the
Execution-posture section matches `appmod-agent-personality-baseline`. This is the
one place in the import where duplication is provably deliberate rather than
accidental.

**The hourglass** (lines 17-19) is the single-paragraph statement of the whole
architecture, and it did not appear anywhere else:

> Many legacy stacks flow **in** -> stack-specific **adapters** normalize
> everything into the **5 canonical JSON artifacts** (`tools/appmod/schemas/`) ->
> **one shared target-side implementation** flows **out**. Downstream of the
> artifacts, nothing is stack-specific.

`tools/appmod/schemas/` and the "5 canonical JSON artifacts" are new — the schemas
directory is named nowhere else in this import, and it is the pivot point of the
design.

**A sorting rule for where a new rule belongs**, which is exactly the governance
tool this kit has been missing:

> - **Plain convention / style, no real trade-off** -> here in `AGENTS.md` (keep it short).
> - **Deliberate decision with a rationale** (something an agent must not override
>   on a whim) -> `.squad/decisions.md` as a `D-00x` entry.

**Six non-negotiables**, two of which are new information:

- *"Gates are scripts, not opinions. An agent never self-declares a step done.
  Done means the step's gate script exited `0`."*
- *"**One active step at a time.** Fan-out (parallelism) is allowed only inside a
  step explicitly flagged `fan-out` in
  `.github/skills/appmod-modernization-process/SKILL.md`."* — a `fan-out` flag
  named nowhere else.
- *"Never mix content moves with content changes in one commit"* (D-007).
- *"The scorecard is frozen infrastructure"* (D-008) with the `VERSION` bump rule.
- *"**Unknown stack = halt** with 'unsupported profile'. Never improvise
  (**D-009**)."* — **the first decision ID in the D-011..D-016 range problem that I
  can now attach content to.** D-009 = unknown stack halts.
- *"Never copy secrets. Use env-var references; flag any secret you find."*

---

## ✅ Gherkin, fourth confirmation — and it is now an always-on rule for every agent

`AGENTS.md` is loaded by **every Squad agent, every session**, and its Testing
section carries the same tag list a fourth time:

> - Required test header comments: `CaseId`, `Scenario`, `Description`, `Input`, `Expected`.
> - Required test body flow comments: `Given`, `When`, `Then`.

Four independent sources, identical tags, no `.feature` file anywhere. The two
outliers (prompt 24's `.feature` requirement and `tests.gherkinCoverage`'s
"features with a feature file") are now conclusively the defects. This is as
settled as anything in the kit gets.

---

## ⚠ Findings in `AGENTS.md`

**1. It quietly contradicts `copilot.instructions.md` on `_debug`/`_tmp`/`_bak`.**
Both forbid them, but `AGENTS.md` line 93 folds the rule into "Files and tooling"
while `copilot-instructions.md` states it separately in Working Defaults *and*
Editing Policies. Three statements of one rule across two always-on files — minor,
but it is the same duplication pattern flagged repeatedly elsewhere, and this file
explicitly exists to prevent it.

**2. `.squad/decisions.md` D-010 through D-016 remain unknown.** `AGENTS.md`
identifies D-007, D-008, and D-009 by content. The Squad repo this import lives in
has D-001..D-010. So the genuinely new territory is **D-011..D-016 — six standing
policies with rationale that no transcribed file describes.** They remain the top
of the backlog.

**3. `tools/appmod/schemas/` and the "5 canonical JSON artifacts" are undefined
here.** The hourglass says everything funnels through five artifacts and names the
directory, but not the five. Given the whole architecture pivots on them, that
directory is now second on the backlog behind the decisions file.

---

## ★★★ MAJOR REFRAMING: the photographed repo is the MERGED Squad + Ignition workspace

`.github/copilot-instructions.md` — the file the Constitution and the cheat sheet
both name as the auto-attached entrypoint — opens like this:

> Purpose: This is the repository-wide custom instructions file for **this
> Squad-based App Modernization repo.**

It then describes, as first-class parts of the repo:

- `.squad/` — *"the authoritative team definition: roster (`team.md`), routing
  (`routing.md`), standing decisions (`decisions.md`, **D-001..D-016**), and
  agent charters"*
- `.github/agents/squad.agent.md` — *"the Copilot coordinator entry point
  (`/agent squad` in an active session, or `copilot --agent squad` to launch one)"*
- `tools/appmod/` — *"the deterministic gate scripts and the frozen scorecard
  engine that prove a step is actually done - never self-declared"*
- `AGENTS.md` at the repo root — *"the thin, always-on engineering-conventions
  file every Squad agent loads"*

**This is not a pristine Ignition Kit.** The merge has already happened, and the
merged design is documented. Several things follow:

1. **My "Ignition-native" labels are inferences, not provenance.** They were
   assigned from internal evidence (does the file reference `.squad/`?) and most
   are probably right, but they were never authoritative. The index and the top of
   this README now say so. The reliable test remains: a file that references
   `.squad/` or `tools/appmod/` is Squad-side.
2. **`discovery-runner.instructions.md` was not an outlier.** I flagged it as "your
   own Squad bridge" and treated it as the exception. It is the *pattern* — this
   file names it as the wiring for Discovery and says *"later phases follow the
   same runner pattern."*
3. **`.squad/decisions.md` has grown from D-001..D-010 to D-001..D-016.** Six
   standing decisions exist that are not in the Squad repo this import lives in.
   They are named only in aggregate here (*"the auth-strangler order, Fusion MCP as
   sole structure authority, the frozen-scorecard rule, and more"*), so D-011
   through D-016 are unknown. **This is now the top of the backlog** — they are
   standing policy, and six of them are invisible to me.

---

## ★ The Process/Execution split, stated by the merged repo itself

Section `## Process Model And Execution Layer` is the clearest statement of the
integration design anywhere in either kit:

> The modernization **PROCESS** is the original Ignition Kit design: the 24
> numbered prompts, the machine-artifact homes, and the per-step
> producer/consumer contract … **Stay as close to that design as possible.**
>
> Squad is the **EXECUTION LAYER, not a replacement process.** Its value is token
> efficiency: the coordinator runs the numbered steps in order, dispatches each to
> a subagent scoped to only that step's contract inputs, keeps just summaries in
> its own context, and **STOPS between steps for developer review.**

And it declares exactly one intentional divergence, in a bullet literally titled
*"Deliberate deviation from Ignition methodology"*: the compliance report is
AI-only (review manifest for the file set, fixed template for shape, AI judgment
for the review), replacing Ignition's deterministic `04-P1-generate-report.ps1`.
*"The rest of each prompt runs as written."*

One deliberate deviation, named and justified. That is the right shape for a
merge, and it matches the Step 4 override already recorded in
`discovery-runner.instructions.md`.

**It also settles the status of the old agent roster:**

> The pre-Squad `.github/agents/*.agent.md` roster (everything except
> `squad.agent.md`) is **historical** - Squad agents execute the prompts instead.

That reframes eleven agent files transcribed early in this import. They are not
the live execution surface; `squad.agent.md` is. The `Ultimate-Ignition-edit` /
`Ultimate-AppMod-Ignition` identical-twin risk recorded earlier is therefore
**lower than stated** — those agents are historical. Worth confirming they are
actually unreachable rather than merely described as historical, since a file in
`.github/agents/` is still invocable.

---

## ✅ The `stepId` migration is enforced at the repo-wide level

Two of the four hits for `step-registry.json` in this file are *mandates*, not
descriptions:

> Use `step:<stepId>` tokens (e.g., `step:26b4e1`) in all cross-references between
> prompts, instructions, agents, and scripts **instead of hard-coding step numbers
> or names.**

> When adding a cross-reference to a numbered step in any toolkit file, look up the
> step in `.github/instructions/step-registry.json` and use its `stepId` token.
> **If the step does not yet have a registered ID, add one before writing the
> reference** (generate with `[System.Convert]::ToHexString(...)` and verify
> uniqueness against the registry).

So the fix for the +2 drift is not only designed — it is mandated in the
always-on instruction file, with the ID generator inline. Every surviving bare
`Step <N>` cross-reference recorded in this document is a violation of a rule the
repo already states. That makes the linter recommendation concrete: **flag bare
step references against `step-registry.json`.**

---

## Structural facts added by `copilot-instructions.md`

94 lines. Short by design — the Constitution and the cheat sheet both say this
file must stay concise.

**The artifact-home split is explained, and it is deliberate:**

> `.modernization/ignition-artifacts/` is **human-facing evidence and planning**,
> `tools/appmod/artifacts/` is **deterministic tool input/output**.

That is the missing rationale behind the artifact roots catalogued throughout this
README. It also names `tools/appmod/artifacts/` as the home for score inputs —
`security-scan.json`, `dependency-eol.json`, `coverage.cobertura.xml`,
`endpoint-inventory.json` goldens — none of which appear in
`AppMod-Artifact-Contract.json`, consistent with them being tool I/O rather than
step artifacts.

**New assets named here and nowhere else in the import:**
`AGENTS.md` (repo root), `tools/appmod/pins.json`,
`tools/appmod/scorecard/rubric.md`, `tools/appmod/scorecard/VERSION`,
`tools/appmod/verify-kit.ps1`, `tools/appmod/gates/lib/tests/run_tests.py`,
`.github/skills/appmod-modernization-process/SKILL.md`,
`tools/appmod/gates/compliance-scan.*`.

**D-008 is quoted directly:** the frozen scoring rubric is *"read-only to
executing agents, changes require a `tools/appmod/scorecard/VERSION` bump"* —
identical to the Squad rule.

**VS Code tasks named:** `src: start api + client`, `legacy: run app`, and
`workspace: start legacy + src (hard rule)`.

**npm dependency-drift order is fixed:** `npm run update`, then
`npm run install`, then `npm run start`.

---

## ⚠ Findings in `copilot-instructions.md`

**1. A repo hook exists — which partly contradicts the cheat sheet.** Line 90:
*"If the repo hook blocks a change because of mojibake or encoding issues, fix the
file encoding and restage."* The cheat sheet grades Copilot hooks as
`Not evident`. These are probably different things (a **git** pre-commit hook vs a
**Copilot lifecycle** hook), and both statements can be true — but the kit has
demonstrated it is willing to enforce at commit time, which strengthens the case
for the Copilot stop-hook recommended above.

**2. It still omits the Constitution from its own precedence list.** This file has
no precedence section at all — the five-level list recorded earlier lives in
`.github/instructions/copilot.instructions.md` (the dotted file), not here. So the
two similarly-named files split the job: this one carries repo facts, the dotted
one carries operational rules and the mis-scoped precedence list. Worth noting
that the Constitution instructs *this* file to *"point back to this file instead
of duplicating it"* — and it does not reference `constitution.md` even once.
A one-line pointer would close the loop the Constitution describes.

**3. `AGENTS.md` is cited four times and has never been photographed.** It is
described as *"the thin, always-on engineering-conventions file **every** Squad
agent loads"* and as *"the detailed engineering standard"* for nine named
concerns. An always-on file loaded by every agent, cited four times, is a
significant gap.

---

## ★ NEW PRIMITIVE: `.github/hooks/*.json` — a seventh customization surface

`Copilot-Customization-Cheat-Sheet.md` names a surface that appears **nowhere
else** in this entire import:

> **Hooks** — `/.github/hooks/*.json` — Use it when: *"You need deterministic
> lifecycle behavior such as blocking a tool, auto-formatting, or injecting
> context before or after tool use."* Avoid it when: *"A normal instruction is
> enough and you do not need shell-enforced behavior."*

And the reason it matters, stated plainly:

> Hooks are **stronger than instructions** because they can run commands and
> **block or modify workflow at lifecycle boundaries**.

This is directly relevant to the biggest structural weakness recorded across this
import — that every rule in the kit is advisory prose an agent may or may not
honor. A hook is the one surface that is *enforced by the environment* rather
than by the model's cooperation.

The kit's own assessment of its hook usage is **"Not evident"** on both hook rows
(Hooks, Agent-scoped hooks) — documented as available, unused in practice. Its own
"Best Opportunities" list names the fix:

> Evaluate agent-scoped hooks for mandatory guardrails such as **artifact
> freshness checks, required validation before stopping, or tool restrictions**.

Those three are precisely the failure modes this import has documented over and
over: stale artifacts passing gates, steps reporting `Completed` without proof,
and agents writing outside their allowed zone. **If one structural change goes
into the kit before the hackathon, a stop-hook that refuses to let a step close
without its verification artifact is the highest-leverage candidate.**

Caveat the file states honestly: hooks are `Supported but preview`.

---

## ⚠ A candid capability audit — the kit grades its own feature usage

The `Supported Handoff And Routing Features` table is unusual: 12 rows, each with
an honest `Current Kit Usage` column. The kit's self-assessment:

| Usage level | Capabilities |
|---|---|
| **Yes** | custom-agent `handoffs`, prompt-file `agent:` binding, slash prompts |
| **Partial** | Skills |
| **Limited** | `handoffs.send: true`, Subagents, Custom agents as subagents |
| **Weakly used** | Allowed-subagent list (`agents`) |
| **Not evident** | Hooks, Agent-scoped hooks, Hidden/worker-only agents, Cloud handoff |

Two of these connect directly to findings recorded earlier in this document:

- **`Allowed-subagent list (agents)` — "Weakly used"**, with the gap noted as
  *"Current broad allow-lists could be tightened where appropriate."* That is the
  same defect recorded against `Ultimate-AppMod-Ignition.agent.md`, whose
  frontmatter declares `agents: ["*"]`. The kit already knows.
- **Hidden or worker-only agents — "Not evident"**, described as *"Keep helper
  agents from being directly user-invoked."* That is the missing control for the
  `Ultimate-Ignition-edit` / `Ultimate-AppMod-Ignition` identical-twin problem:
  the toolkit editor should be worker-only, not directly user-invocable.

---

## ✅ The `send: false` handoff pattern is explained (and is not a defect)

An earlier finding noted that `OpX-AppMod-P3-Review.agent.md`'s six numbered
handoffs all carry `send: false`, and treated it as notable. This file explains
the design:

> There is **no confirmed official Microsoft frontmatter field** for an automatic
> `on completion` or `return to another agent when finished` route in the current
> VS Code custom-agent and prompt-file docs used for this repo.

The four closest supported patterns are then listed: `handoffs` shown after an
agent finishes; `handoffs.send: true` for immediate submit; subagents (which
return automatically); and hooks (which can enforce behavior around stop, *"but
are not documented as agent-routing features"*).

So `send: false` is the deliberate default — a visible next-step button the
operator clicks — and `send: true` is the selective exception. Retracting the
implication that it was a defect.

---

## Structural facts added by `Copilot-Customization-Cheat-Sheet.md`

150 lines at `.github/Copilot-Customization-Cheat-Sheet.md`. Explicitly
maintainer-facing, and explicitly **not** an authority:

> Do not treat this cheat sheet as a second process specification.

It then defers to `AppMod-Process.instructions.md` (human-readable authority),
`AppMod-Step-Contract.json` (machine-readable authority), and the three phase
agents — consistent with everything else transcribed.

**It confirms the Constitution/copilot-instructions split from the other side**,
in a two-row table with a `Key Constraint` column: the Constitution is *"Not the
repo's auto-attached Copilot instruction primitive by itself"*;
`copilot-instructions.md` *"Must stay concise and should point to the Constitution
instead of duplicating it broadly."* Two files, written independently, agreeing
exactly. That is the cleanest pair in the kit.

**The seven-row Primitive Matrix** (Constitution, repo-wide instructions, file
instructions, prompts, agents, skills, hooks) gives each surface both a
*Use It When* and an **Avoid It When** column. The "avoid" column is what makes it
usable — most such matrices only say what each surface is for.

**Five named pitfalls**, two of which are recurring themes in this import:
*"Do not put a repo-wide policy into a prompt just because it was discovered
during one task"* and *"Do not duplicate the same contract across the
Constitution, instructions, prompts, and agents when one shared source plus one
attached surface can carry it."*

**One dangling reference:** `/.modernization/OpXUtil/.conversation/Step-0-Extension-Paused-Status.md`,
a paused "Step 0 extension experiment" the file says is *not* part of the active
workflow surface, with an explicit instruction not to depend on
extension-specific buttons or pause cards in active prompts. Worth knowing it
exists so nobody revives it by accident.

---

## ⚠ Findings in `Copilot-Customization-Cheat-Sheet.md`

**1. Quick Selection Test item 4 is garbled.** Line 69 reads *"Use prompts for
repeatable tasks or another agent intentionally runs."* A word or clause is
missing — most likely intended as "…tasks a user or another agent intentionally
runs." Transcribed faithfully; it is a source defect, not a photo artifact (the
line is short and fully legible).

**2. It documents hooks but the kit has none.** Both hook rows read
`Not evident`. Nothing is wrong with documenting an unused capability, but a
hackathon reader could reasonably assume `.github/hooks/` exists. Worth a
one-line "not currently used in this kit" note — or actually adding the stop-hook
described above.

---

## ★★★ `constitution.md` transcribed — and it is a governance charter, not a rulebook

146 lines at **`.github/constitution.md`** (the editor breadcrumb reads
`.github > constitution.md`, so despite being described as "root of the repo" it
lives inside `.github/`, exactly as every cross-reference in the kit spells it).

**It knows it is not auto-attached**, and says so in its own opening block:

> In this repo it is treated as a governance primitive for documentation and
> maintenance decisions, but **it is not the repo's auto-attached Copilot
> instruction primitive by itself.** The supported repo-wide Copilot entrypoint
> remains `/.github/copilot-instructions.md`, which should point back to this file
> instead of duplicating it.

This is the most self-aware file in the kit. It has no `applyTo`, and rather than
pretending otherwise it names the mechanism that actually loads and instructs
maintainers to wire behavior through the attached surfaces:

> If a future change needs Copilot to automatically use a shared governance rule,
> wire that behavior through the supported attached instruction surfaces rather
> than assuming the Constitution will be auto-attached by itself.

**It is deliberately a boundary document, not a content document.** Section 1
lists what does *not* belong in it (language standards, framework recipes,
step-by-step execution logic, agent chat contracts, code examples, version-pin
catalogs), and Section 10 — *"What Should Move Out Of The Constitution"* — names
five content types with their correct destinations. A governance file that
actively tries to stay small is unusual and worth preserving.

**Section 6 is the cleanest statement of the kit's architecture** anywhere in the
import — one line per customization primitive:

| Surface | Owns |
|---|---|
| `constitution.md` | shared governance and source-of-truth boundaries |
| `copilot-instructions.md` | concise repo-wide attached defaults that operationalize the Constitution |
| `instructions/*.instructions.md` | language-specific, path-scoped, or purpose-scoped rules |
| `prompts/**/*.prompt.md` | reusable task contracts and numbered step entrypoints |
| `agents/*.agent.md` | personas, handoff lanes, tool-boundary execution roles |
| `skills/<name>/SKILL.md` | bundled workflows, references, deeper support material |

…closing with the anti-duplication rule this whole import keeps running into:
*"Avoid repeating shared guidance across all of these surfaces when a single
constitutional rule plus one attached instruction surface is enough."*

**Section 7 explains the personality-baseline design** and confirms the earlier
reading: the Constitution owns the *rule* that shared baseline behavior is
centralized and overridable; the dedicated baseline instruction file owns the
*text*. Narrower contracts may override when they own a more specific execution
context — which is exactly what `appmod-phase-agent-contract` does.

**Section 5 restates the process authority** as the 3-phase, 24-step model in
`AppMod-Process.instructions.md` + `AppMod-Step-Contract.json`, with global step
numbers and QA after each completed step. No numbering drift anywhere in this
file.

**Section 12 adds a maintenance rule not seen elsewhere:** exactly one canonical
Constitution file, and when it is materially rewritten the previous version is
archived under
`/.modernization/OpXUtil/archive/.github-archive/github.archive/` before being
replaced.

---

## ⚠ Findings in `constitution.md`

**1. Lines 99 and 100 are a duplicated bullet with a spelling split.** Both read
*"The Constitution owns the rule that shared baseline behavior should be
centralized and …"* — line 99 ends `overrideable`, line 100 ends `overridable`.
Almost certainly an edit that was appended instead of replaced. Transcribed
faithfully; delete one. (Third duplicate-line defect found in the kit, after
`kit-update.instructions.md` lines 177/178 and the triple-stated rerun rule in
`copilot.instructions.md`.)

**2. It does not mention readiness scoring, and `copilot.instructions.md` says it
governs it.** `copilot.instructions.md` line 355 states *"Readiness scoring and
tiers are governed by AppMod-Ignition (constitution + gate/policy catalogs)."*
Nothing in these 146 lines defines a score, a tier, or a gate/policy catalog.
Either the scoring lives in the "gate/policy catalogs" half of that sentence
(untranscribed, and not named anywhere else), or the reference is aspirational.
**This is now the most important open question in the kit**, because it is the
one place a stated authority has no locatable content — and for a hackathon,
readiness tiers are what teams will be judged on.

**3. Section 8 references `Architecture-Structure.md` at a path one level up from
where it was transcribed.** The Constitution says
`/.github/skills/architecture-structure/Architecture-Structure.md`; that matches
the transcribed skill folder, so this one is consistent — noted only because it
is the sole architecture source the Constitution names, making it more
load-bearing than its size suggests.

**4. It never mentions `step-registry.json`.** The Constitution names
`AppMod-Process.instructions.md` and `AppMod-Step-Contract.json` as the process
authority (Sections 5 and 11) but not the registry that owns step *identity*.
Given the registry is the designed fix for the numbering drift, adding it to
Section 11's canonical-sources list would be a cheap, high-value edit.

---

## ⚠ HIGH: the kit's two top-level precedence lists disagree about what ranks first

`modernization-starter-boundaries.instructions.md` calls itself *"the canonical
guardrail file for restructure"* and opens with its own `## Source of truth`
ordering:

| Rank | `modernization-starter-boundaries` | `copilot.instructions.md` |
|---|---|---|
| 1 | **`constitution.md`** | The current user request |
| 2 | `.github/copilot-instructions.md` | `.github/copilot-instructions.md` |
| 3 | this file (starter-boundaries) | `AppMod-Process` + `AppMod-Step-Contract.json` |
| 4 | the active starter-derived files under `src/` | `copilot.instructions.md` itself |
| 5 | workflow-specific prompts, skills, and agents | targeted/path-scoped instruction files |

They agree only on rank 2. Otherwise:

- **`constitution.md` is rank 1 here and absent entirely from the other list.**
  This is the third independent signal that `constitution.md` is load-bearing
  (after the change-capture rule and the readiness-scoring rule) — and the first
  that puts it at the *top* of a precedence order.
- **"The current user request" is rank 1 there and absent entirely here.** So one
  file says the user outranks everything; the other says a checked-in
  constitution does.
- `modernization-starter-boundaries` puts *itself* at rank 3, above `src/` and
  above all prompts/skills/agents. Under `copilot.instructions.md`'s ordering it
  is a path-scoped instruction file and lands at rank 5.

Two files, each calling itself canonical, each ranking the other's top entry
differently. An agent that reads one and not the other resolves conflicts the
opposite way. This is a bigger interop problem than the artifact-root fork was,
because precedence decides which rule wins *every* time two rules touch.

**`constitution.md` is now unambiguously the top of the transcription backlog** —
it is rank 1 in the only ordering that names it, it governs readiness scoring,
and it is a documented write target.

---

## Structural facts added by `modernization-starter-boundaries.instructions.md`

194 lines. The single most operationally specific file transcribed: it names
exact file paths for the protected starter shell rather than describing roles in
the abstract.

**Six protected starter control points** (protected *by role*, "even when names
vary across starter versions"):

| Role | Path |
|---|---|
| API host entry point | `src/<AppName>.Web.Api/Program.cs` |
| API platform composition seam | `src/<AppName>.Web.Api/Extensions/FusionWebBuilderExtensions.cs` |
| Library platform composition seam | `src/<AppName>.Library/Extensions/FusionApplicationBuilderExtensions.cs` or `src/<AppName>.Library/DependencyInjection.cs` |
| Client bootstrap entry point | `src/<AppName>.Web.Client/src/main.ts` |
| Client provider and auth shell | `src/<AppName>.Web.Client/src/app/app.config.ts` |
| Client Fusion environment config | `src/<AppName>.Web.Client/src/app/fusion.config*.ts` |

Exactly **five allowed narrow edits** in those files (app identity rebinding;
base URL / environment value rebinding; centralized DI registration for newly
moved app-owned services; one approved connection-string composition seam;
starter-version-aligned config value replacement already recorded in the
migration plan). Anything that would "replace or duplicate the starter's
provider graph, auth wiring, middleware order, logging bootstrap, or client
bootstrap contract" requires stopping and recording an exception first.

**Eleven editable app-owned seams** and **four guarded files** (`appsettings*.json`,
`angular.json`, `package.json`, and the app `Dockerfile`/`nginx.conf`/`default.conf`)
are enumerated by exact path.

**Auth stance — now six-to-one against `fusion-auth-standards.md`.** This file
states it flatly: *"Do not author new `AddAuthentication(...)`, `AddJwtBearer(...)`,
custom Swagger bootstrapping, or ad hoc auth middleware from memory when the
starter shell already owns that concern."* That is the exact pattern
`fusion-auth-standards.md` presents as "Fusion pattern (use this)". The
single-file rewrite recommendation is now very well supported.

**Backend consumer-parity rules** — a genuinely useful failure mode: *"Do not
treat a controller family as migrated if only the detail-by-id route exists while
the migrated frontend or other consumers still call collection or list routes."*
A non-404 live proof per consumer-used route family is required even when
authenticated business data cannot be exercised.

**Two named user-input gates** that the kit will otherwise guess at:
the authoritative connection string / split DB inputs, and the authoritative
Okta/AD group identifiers for at least `User` and `Admin` plus app-specific
policy roles such as `TestAdmin`. Both say: ask the user rather than infer from
sample apps, stale defaults, or unrelated legacy environments. A 403 with a valid
bearer token is to be treated as a role-mapping input gap, not a code bug.

---

## ⚠ Findings in `modernization-starter-boundaries.instructions.md`

**1. Windows backslash paths, only in this file.** Lines 187-189 write
`.modernization\ignition-artifacts\modernize\fusion-restructure\ui-inventory.json`
and `Push-Location src\<AppName>.Web.Client`. Every other transcribed file uses
forward slashes. A linter matching on `.modernization/` will miss these three
rules entirely, and they are the ones gating Fusion-swap completion.

**2. `ui-component-map.json` and `ui-verification-report.json` are new artifacts**
that appear in no other file and are **not** in `AppMod-Artifact-Contract.json`.
The contract's Step 14 produces `ui-inventory`, `ui-visual-contract`,
`ui-fusion-map`, `ui-migration-order` — not these two. So two artifacts required
by a validation gate have no producer in the contract and cannot be verified.

**3. `npm run verify:fusion-ui` and `verify:fusion-ui:complete` are undocumented
scripts.** Both are required by validation gates; neither appears in any other
transcribed file. Add them to the pre-flight existence check alongside the eight
PowerShell scripts.

---

## ⚠ Findings in `kit-update.instructions.md`

**1. A stray hyphen breaks a heading.** Line 33 is `-## Canonical Context Paths`
— it renders as a list item containing `## Canonical Context Paths`, not as a
heading. Reproduced faithfully; it is a source defect.

**2. Duplicate list numbering in Change Strategy.** There are two items numbered
`4.` (lines 121-123 and line 124), so the section runs 1, 2, 3, 4, 4, 5, 6, 7, 8
and renders with the wrong numbers from there down.

**3. A path rule that moves a file to itself.** Line 137: *"If an existing
generated family is moved from `/.modernization/ignition-artifacts/**` to
`/.modernization/ignition-artifacts/**`, propagate every path reference in the
same change."* Source and destination are identical. Given the `generated/` fork
recorded earlier, one side was probably meant to be `/.modernization/artifacts/**`.

**4. The final line is duplicated verbatim.** Lines 177 and 178 are both
*"Batch clarification questions into one concise review note whenever practical."*

**5. Missing blank line before `## Editing Guardrails`** (line 40 follows line 39
directly).

None of these are dangerous on their own, but this is the file that governs how
the kit edits *itself* — five formatting/logic defects in a maintenance rulebook
is a signal that nothing lints the kit today.

---

## ★ `step-registry.json` transcribed in full — the fix is real, and it is complete

The registry is captured verbatim (205 lines, **validates as JSON**, all 24 steps).
It confirms the design end-to-end and adds the pieces `discovery-runner` only
summarized.

`resolutionConvention` — five named rules, verbatim:

| Key | Rule |
|---|---|
| `tokenFormat` | `step:<stepId>` |
| `inMarkdown` | Write cross-references as `step:<stepId>`. Copilot resolves these to the human label before producing any output. |
| `inScripts` | Pass `-StepId '<stepId>'` instead of `-Step <n>` for scripts updated to support this registry. **Scripts not yet migrated still use `-Step <n>`; migrate them as each step's prompt is updated.** |
| `inOutput` | Always translate a stepId to its human label. **Never surface raw stepId tokens to a user.** |
| `addingNewStep` | Generate a new 6-char lowercase hex ID with `[System.Convert]::ToHexString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(3)).ToLower()`. Verify it does not already appear in this file before commit. |

Each of the 24 entries carries `stepId`, `step`, `label`, `phase`,
`promptPath`, `scriptPrefix`. The full ID table:

| Step | ID | Step | ID | Step | ID |
|---|---|---|---|---|---|
| 1 | `7be409` | 9 | `2dbd04` | 17 | `0576c8` |
| 2 | `1fc2ba` | 10 | `a417e0` | 18 | `be24f9` |
| 3 | `26b4e1` | 11 | `6cd2a2` | 19 | `22f169` |
| 4 | `261769` | 12 | `24a83e` | 20 | `cec9a1` |
| 5 | `d847e7` | 13 | `278613` | 21 | `e30c80` |
| 6 | `6c50db` | 14 | `f746b9` | 22 | `57c6af` |
| 7 | `476ced` | 15 | `2d136c` | 23 | `9710dc` |
| 8 | `300dfa` | 16 | `fe0270` | 24 | `9bd419` |

**Every `promptPath` and `scriptPrefix` in the registry is correct** — no +2
drift anywhere in this file. It is the one place in the kit whose step
identities are entirely trustworthy, which is exactly what a registry is for.

That makes it the natural authority for the linter: any bare `Step <N>`
cross-reference in a prompt/instruction/agent can be validated against this
table, and any `promptPath` mismatch is a hard error.

---

## ★★★ THE DRIFT PROBLEM IS ALREADY SOLVED — the fix is `step-registry.json`, and the migration is just unfinished

This reframes every numbering finding in this document.

`discovery-runner.instructions.md` documents a mechanism no previously transcribed
file mentioned:

> **Step identity (`stepId`).** Each step has a stable `stepId` in
> `.github/instructions/step-registry.json`. Cross-references between toolkit
> files use `step:<stepId>` tokens **so renumbering only touches the registry,
> not every reference.**

The six Discovery `stepId` values, verbatim:

| Step | `stepId` | Label |
|---|---|---|
| 1 | `7be409` | Workstation Readiness |
| 2 | `1fc2ba` | Rename Starter To `<AppName>` |
| 3 | `26b4e1` | Legacy System Analysis |
| 4 | `261769` | Baseline Acceptance-Criteria Review |
| 5 | `d847e7` | Modernization Solution Design |
| 6 | `6c50db` | Modernization Quality Design |

Two hard rules are stated as coming *from* `step-registry.json`:

1. **ALWAYS** translate a `stepId` to its human label in every developer-facing
   stop (`step:26b4e1` -> `Step 3 - Legacy System Analysis`).
2. **NEVER** surface a raw `stepId` to the developer.

And the migration status is stated explicitly: the registry-migrated shared
scripts (`verify-step-artifacts.ps1`, `Invoke-StepReconciliation.ps1`) accept
`-StepId '<stepId>'`; **"scripts not yet migrated still take `-Step <N>`."**

**What this means for everything above.** The +2 drift is not an unsolved design
flaw — it is the *symptom of a half-finished migration to a fix that already
exists*. The correct remediation is therefore **not** "renumber every reference"
(which this document has been building toward). It is:

- finish migrating references to `step:<stepId>` tokens,
- finish migrating the scripts to `-StepId`,
- and lint for any surviving bare `Step <N>` cross-reference.

That is a smaller, safer, and permanent fix. It also explains why
`step9UpgradeWorkspaceRoot` and the `step19-`/`step20-` filenames were
deliberately frozen: they are pre-registry identifiers that renumbering would
break, exactly as the registry design predicts.

`step-registry.json` was listed in `manifests/github-instructions-listing.md`
from the very first directory photo and I had no idea what it was. It is now,
with `AppMod-Step-Contract.json`, the top of the transcription backlog.

---

## ⚠ IMPORTANT SCOPE CORRECTION: not everything in `.github/instructions/` is Ignition-native

`discovery-runner.instructions.md` is **your own Squad-side bridge**, not part of
the original Ignition Kit. It references `.squad/agents/lead/charter.md`,
`.squad/agents/reviewer/charter.md`, `.squad/agents/tester/charter.md`,
`.squad/routing.md`, `.github/agents/squad.agent.md`, and
`tools/appmod/gates/compliance-scan.*` — all Squad-side assets.

I have been labelling files in this directory "Ignition-native" by default. That
was too broad. The `.github/instructions/` folder now demonstrably contains
**both** original Ignition files and Squad integration files. The index above has
been corrected for this file; the safest read of any remaining file is to check
whether it references `.squad/` before assuming provenance.

This also means part of the Ignition→Squad bridge already exists and works. It
is worth reading as a design precedent rather than starting the integration from
scratch.

---

## ★ The two-layer verification insight — the most transferable idea in the kit

`discovery-runner.instructions.md` states, from observed experience, exactly why
a presence-check gate is not a completeness gate:

> **Layer 1 — deterministic presence** (`verify-step-artifacts.ps1`). Cheap,
> fast, always run … **This is a floor, not proof of completeness** — a thin,
> shallow artifact can still pass this check.
>
> **Layer 2 — independent AI completeness review.** … Presence-only checks
> cannot tell **a 14-service inventory from the ~40 services that actually exist
> in `LegacyCode/`** — both are "present and non-empty." Only reading the
> artifact against real ground truth catches that gap. Never skip Layer 2 to
> save a dispatch.

That 14-vs-40 example is a real, measured failure, and it generalizes past this
kit. It pairs with the `scan-ui-parity-gaps.ps1` rule in
`frontend-modernization-learning.instructions.md`:

> If a scan ever reports zero gaps while the running app is clearly missing
> controls, **fix the scanner's harvesters before trusting the gate again — a
> gate that manufactures false confidence is worse than no gate.**

The runner also solves the self-grading problem structurally: the reviewer is a
**separate subagent**, explicitly "not the producing agent grading its own work,"
and "a bare 'looks fine' is not an acceptable verdict."

The `[START]` determination rule is the sharpest expression of the idea: a step
marked `Completed` is only trusted at face value for Steps 1-2 (procedural —
a rename either built or it didn't). For Steps 3-6 (analytical), a `Completed`
recorded before the reviewer gate existed "has NEVER been checked for depth at
all" and must be re-run.

---

## ⚠ Another +2 survivor, again inside one bullet pair

`frontend-modernization-learning.instructions.md`, consecutive bullets:

> - **Step 6** owns the per-route behavior plan at
>   `.modernization/portal/data/json/per-route-behavior-plan.json` … Routes whose
>   interactive controls or data calls are not enumerated at **Step 6** are a
>   **Step 6** blocker…
> - Phase-discipline rule: when Phase 2 finds a route with dropped behavior or
>   missing data wiring that **Step 8** did not list, the loop is stop Phase 2 ->
>   route back to **Step 8** -> refresh the per-route behavior plan…

Step 6 owns it; the very next line routes back to Step 8. 6 + 2 = 8. A third
bullet later in the same file ("**Step 6** per-route behavior plan is the gate")
agrees with 6, and the artifact contract confirms Step 6 produces
`per-route-behavior-plan.json` — so the Phase-discipline bullet is the outlier.
Same class as the `appmod-phase-agent-contract` rule 22 finding: a stale range
sitting next to correct ones, invisible to a uniform-offset check, and exactly
what `step:<stepId>` tokens are designed to prevent.

---

## ⚠ A sixth file uses the short artifact root

`frontend-modernization-learning.instructions.md` writes to
`.modernization/fusion-restructure/styling-foundation.json` and
`.modernization/fusion-restructure/visual-parity-report.json` — the **short**
form, which `agent-toolkit-protection` does not permit and the artifact contract
never uses. Add it to the rewrite list alongside `visual-parity-gate`,
`architecture-structure`, prompt 21, `runtime-parity-checkpoint`, and
`_variables.scss`.

---

## Structural facts added by `frontend-modernization-learning.instructions.md`

170 lines, and structurally unlike anything else in the kit: **every section
opens by naming the specific failure that caused it to exist.** It is a
post-mortem log promoted to policy. For hackathon risk this is the single most
useful file transcribed, because it enumerates the precise ways a modernization
looks finished and is not.

The failures it documents, in its own words:

- *"cosmetic restoration repeatedly slipped past closeout while the route was
  functionally dead (visible HTML, broken data path)"*
- *"a modernized frontend shipped unrecognizable and missing features (empty
  shell nav, admin 'Add Row' hidden behind an unwired flag, a grid re-created
  thinner than legacy) while every static gate passed"*
- *"a modernized frontend reached the end of frontend migration looking nothing
  like the legacy app … even though the legacy visual language was fully
  derivable from legacy source"*
- *"extracted the legacy palette, typography, and sizing correctly … yet still
  rendered a dark, unbranded shell … Extraction succeeded; binding failed"*
- *"reported `visual-parity-report.json` and `runtime-parity-checkpoint.json` as
  `pass` while the running app rendered in the wrong color scheme … Every static
  gate was green. The rules and gates to catch this already existed; the failure
  was substituting proxies for an actual render."*

Rules worth lifting verbatim into Squad:

- **Move-first default.** *"The default migration verb is MOVE the real legacy
  component (template, styles, logic), get it building, then swap individual
  controls for Fusion primitives. Parity is the starting state you preserve, not
  a percentage you climb toward."*
- **"Page renders" is not "page works."** and **"Present-but-hidden is missing."**
- **A deferral must name an owner step and be drained there.** The
  `ui-deferral-registry.json` design — `{ handler, ownerStep, reason }`, always
  emitted as `deferredInertControls[]` so a zero inert count can never be
  mistaken for zero deferred behavior, drained by `-CurrentStep <n>`, and
  "a behavioral deferral may never ride forward to the final review un-drained."
- **Allowlists are app evidence, not script code.** The named failure is that a
  hard-coded suppression list let a shipped `exportToExcel`/`addRows`/
  `deleteSelected` stub set report `inertControlCount = 0` while the buttons
  were dead — *and* it embedded app-specific handler names in a reusable script.
- **When the scanner and the running app disagree, the running app wins.**

**New scripts and artifacts named here:**
`.github/scripts/parity/scan-ui-parity-gaps.ps1`,
`.github/scripts/parity/scan-styling-foundation.ps1`,
`ui-deferral-registry.json`, `route-contract-diff.generated.json`,
`MVC-To-Browser-Client-Decomposition-Contract.generated.json` (+ `.md`),
`Angular-To-Browser-Client-Decomposition-Contract.generated.json` (+ `.md`).

---

## Structural facts added by `dotnet.instructions.md`

75 lines, `applyTo: "**/*.cs"`. Mostly conventional .NET guidance, with two
Fusion-specific mandates (`Fusion.Fx.IErrorService` for error capture; **do NOT**
write argument null checks because nullability annotations and analyzers cover
them) and two sections of genuinely hard-won production debugging knowledge:

**ADO.NET / SqlClient parameter typing.** `AddWithValue` infers `SqlDbType.Int`;
if the column is `SMALLINT`/`TINYINT`/`BIT`/`DECIMAL`/`VARCHAR(n)`, SQL Server
applies implicit conversions that *"silently return zero rows"* while the API
still answers HTTP 200 with an empty array. The stated symptom signature —
*"legacy worked, modern controller responds 200 OK with `[]`, frontend shows 'no
results' for valid keys, no exception is logged"* — is the kind of thing teams
lose a day to. It also gives the load-bearing evidence rule: a legacy explicit
cast (`Convert.ToInt16`) *is* the column-type evidence, so preserve it.

**Dapper typed materialization parity.** Constructor-bound mapping requires CLR
types to match SQL result column types; the fix is a two-stage materialization
(DB-shape row type, then project to the API contract). The exception signature
*"A parameterless default constructor or one matching signature (...) is
required"* is called a hard blocker.

Both sections deserve to survive the port. They are the only place in the kit
that documents a silent-wrong-answer failure mode rather than a loud one.

---

## Structural facts added by `copilot.instructions.md` lines 273-355

The earlier transcription stopped at 272; the file actually runs to 355. The
missing 83 lines contain:

**A second `constitution` reference, and this one makes it authoritative.**
Line 355: *"Readiness scoring and tiers are governed by AppMod-Ignition
(**constitution** + gate/policy catalogs). Keep `STATUS_REPORT.md` aligned to
those definitions."* So `constitution.md` is not just a writable policy surface
(the change-capture rule) — it **governs the readiness scoring rubric**. That is
a direct analogue of Squad's frozen scorecard, and it moves `constitution.md` up
the backlog again.

**A sixth precedence statement — and it matches Squad's core principle.**
Lines 310-312, `## Scoring precedence`:

> When scoring readiness/compliance, **gates and policies are canonical.**
> Prompts are procedural helpers; if a prompt conflicts with a gate/policy,
> follow the gate/policy and record the conflict.

That is almost word-for-word Squad's *"Gates are scripts, not opinions. Never
soften or overrule a gate result."* The two kits already agree on the most
important rule; it just is not stated in the file that carries the *global*
precedence list (which, as recorded above, ranks path-scoped files last).

**A `STATUS_REPORT.md` contract** — nine required summary sections, one page max,
readable by non-technical and technical audiences, updated after any build, run,
parity, or auth/DB work.

**Operational specifics:** the `dotnet restore/build/test/run` CLI-as-source-of-
truth rule (VS Code and Visual Studio must be interchangeable); auto-opening
`http://localhost:<port>` and `GET /health` in Simple Browser after any local
start; a PowerShell port-freeing helper; `{ "status": "ok" }` as the preferred
`GET /health` baseline shape; Docker required; and the instruction that a
workstation-policy block (`E_ACCESSDENIED 0x80070005`) must be *recorded*, not
"fixed" in code.

---

## ⚠ A fourth step-status vocabulary

`discovery-runner.instructions.md` uses `Pass` / `Partial` / `Blocked` / `Fail`
for step stops (matching `AppMod-Process`) and `Pass` / `Partial` / `Fail` for
reviewer verdicts. Running tally of terminal-status vocabularies across the kit:

| Source | Terminal statuses |
|---|---|
| `copilot.instructions.md` | `Completed`, `Blocked`, `Failed` |
| `appmod-phase-agent-contract` | `Completed`, `Blocked`, `Partial` |
| `AppMod-Process` | `Pass`, `Partial`, `Blocked`, `Fail` |
| `discovery-runner` | `Pass`, `Partial`, `Blocked`, `Fail` (+ reviewer `Pass`/`Partial`/`Fail`) |

Two files say `Completed`/`Failed`, two say `Pass`/`Fail`. The enum in
`step-workflow-state.schema.json` remains the cheapest fix.

---

## ⚠ CORRECTED: `constitution.md` IS referenced from inside the kit

I have said several times across this import that nothing transcribed references
`.github/constitution.md`, and used that to argue it was the highest-value
unknown. That was wrong. `copilot.instructions.md` line 188 references it
directly, in the Change-capture rule:

> If the user says something that should be recorded into
> **prompts/instructions/agents/constitution**, call it out explicitly and ask:
> "Add it? (y/n)".

So `constitution` is named as one of four durable homes for user-supplied rules,
alongside prompts, instructions, and agents. That makes it a live, writable
policy surface — not a vestigial file. It does not change the current priority
order (`AppMod-Step-Contract.json` is still first, because it is load-bearing
for routing *today*), but it does mean `constitution.md` is worth capturing for
a concrete reason rather than as a shot in the dark.

Also now confirmed rather than inferred: `.github/copilot-instructions.md` (root,
hyphenated) is real and distinct from `.github/instructions/copilot.instructions.md`
(dotted). This file names the root one explicitly as *"the concise always-on
repository entrypoint"* and ranks it above itself in precedence. The manifest's
earlier inference from a partially-cut-off directory listing was correct.

---

## ⚠ HIGH: the toolkit-protection boundary is ranked LAST in the only global precedence list

`copilot.instructions.md` lines 16-22 give the kit's only top-level, five-level
precedence order:

| Rank | Source |
|---|---|
| 1 | The current user request and active AppMod-Ignition guidance in the workspace |
| 2 | `.github/copilot-instructions.md` — concise always-on repository guidance |
| 3 | `.github/instructions/AppMod-Process.instructions.md` **and** `.github/instructions/AppMod-Step-Contract.json` — process sequence and route authority |
| 4 | This file — detailed AppMod-Ignition operational guidance |
| 5 | **Targeted language, security, and path-scoped instruction files for the files they cover** |

`agent-toolkit-protection.instructions.md` is a path-scoped instruction file
(`applyTo: ".github/agents/*.agent.md"`). Under this list it sits at rank 5 —
**below** ordinary operational guidance, and below "the current user request" at
rank 1.

That is the wrong shape for a boundary rule. `agent-toolkit-protection` is the
file that says only `Ultimate-Ignition-edit` may mutate toolkit assets and
enumerates the allowed write zones. A precedence list that puts it last means a
user request at rank 1 nominally outranks it — which is exactly the situation a
write boundary exists to prevent. Compare how the kit handles its *other*
precedence rules: `appmod-phase-agent-contract` explicitly declares it beats the
personality baseline, and `agent-process-conformance` has "narrower wins". Only
this list is global, and only this list inverts the security ordering.

Note also what is **absent** from the list entirely: `agent-toolkit-protection`,
`appmod-phase-agent-contract`, and `appmod-agent-personality-baseline` are never
named. They fall into the unnamed rank-5 bucket by inference.

**Recommended fix:** promote boundary/security instruction files to their own
rank above the user request, or state explicitly that write boundaries are not
subject to this ordering. This is a cheap edit with a large blast radius, and it
is the kind of thing that will bite during a hackathon when someone says "just
edit the agent file for me."

---

## ✅ RESOLVED (again, and properly): Gherkin means comments, not `.feature` files

Last turn I said the `.feature`-file question needed reopening because
`tests.gherkinCoverage` made Gherkin coverage a standing Phase 2 metric.
`copilot.instructions.md` settles it, because it is the only file that gives the
actual required shape:

> Generated or updated tests must be **Gherkin-style with explicit comments and
> metadata**.
> Required test **header comments**: `CaseId`, `Scenario`, `Description`,
> `Input`, `Expected`
> Required test **body flow comments**: `Given`, `When`, `Then`

Those are comment tags inside ordinary test files. No `.feature` file, no step
definitions, no Cucumber runner. That matches `appmod-testing-and-gates`
exactly, and it matches the canonical test workspace having no `features/` or
`steps/` directory.

Final tally: three sources specify Gherkin-*style comments*
(`copilot.instructions.md` — with the exact tag list, `appmod-testing-and-gates`,
and the absence of any feature-file scaffolding); two use feature-file language
(prompt 24, and `tests.gherkinCoverage`'s "features with a feature file"); two
steps forbid feature files outright (12 and 17).

**Verdict: comments win.** The two outliers are wording defects, not a competing
design. Concrete fixes: reword `tests.gherkinCoverage` to "count of user-facing
features with a Gherkin-tagged test vs total features", and rewrite prompt 24's
§6 and Playwright Checklist as previously recommended.

---

## ⚠ HIGH: three different step-status vocabularies, all written to the same JSON

`step-workflow-state.json` is machine-read — the next-step runner, the portal,
and the verifier all consume it. Three Ignition-native files disagree about what
may be written into it:

| Source | Terminal statuses |
|---|---|
| `copilot.instructions.md` line 77 | `Completed`, `Blocked`, `Failed` (starting from `InProgress`) |
| `appmod-phase-agent-contract` rule 21 | `Completed`, `Blocked`, `Partial` |
| `AppMod-Process.instructions.md` line 48 | `Pass`, `Partial`, `Blocked`, `Fail` |
| `AppMod-Process.instructions.md` line 201 (Review lane) | `Pass`, `Blocked`, `Fail` |

The collisions:

- **`Completed` vs `Pass`** — same concept, two spellings.
- **`Failed` vs `Fail`** — same concept, two spellings, differing by one letter.
  This is the worst of the three, because a string comparison silently misses.
- **`Partial`** is required by the phase-agent contract and by
  `AppMod-Process`, but is **not** in `copilot.instructions.md`'s terminal set —
  which says "Do not stop with the saved step status still `InProgress`. End the
  step as `Completed`, `Blocked`, or `Failed`." An agent following that file has
  nowhere to put a `Partial`.

`AppMod-Process` line 48 even makes distinctness a rule — *"Keep `Pass`,
`Partial`, `Blocked`, and `Fail` distinct"* — while using a vocabulary the other
two files do not share. A one-line enum in
`.github/contracts/schemas/step-workflow-state.schema.json` would settle this;
that schema already exists and is referenced by the artifact contract.

---

## Structural facts added by `copilot.instructions.md`

272 lines. Frontmatter is `name: appmod-ignition-operations` + `description`,
with **no `applyTo`** — the file calls itself *"task-discoverable"*, so like
`AppMod-Process.instructions.md` it is not auto-attached. That is now two of the
kit's most substantive instruction files relying on being pulled in by name.

Despite the filename, this is not a Copilot-conventions file — it is the
operational rulebook: rerun behavior, artifact hygiene, engineering standards,
ownership boundaries, feed policy, naming law, and modernization patterns.

**Autonomous remediation contract** — the step lifecycle in full. On start,
immediately write `InProgress` and maintain six live fields: `startedAt`,
`heartbeatAt`, `percentComplete`, `estimatedMinutesRemaining`,
`estimatedCompletionAt`, `currentActivity`. Five explicit escalation triggers
(destructive/hard-to-reverse; needs user intent or product judgment; depends on
credentials or external systems; would cross into a different numbered step;
first remediation disproved the hypothesis). *"The portal is a derived view and
must not override that saved state."*

**Naming law** — the clearest statement of project naming in the kit:

- Golden Rule: never mix naming styles inside the same layer.
- .NET/C# projects: PascalCase for solutions, projects, folders, namespaces, `.csproj`.
- Angular client root: `src/<AppName>.Web.Client` and `<AppName>.Web.Client.esproj`.
- Inside that client root, Angular-appropriate kebab-case continues to apply.
- Cross-layer references preserve each layer's native style — no shared casing scheme.

This is the first sighting of `<AppName>.Web.Client` / `.esproj`. The artifact
contract names `src/<AppName>.Library` and `src/<AppName>.Web.Api` but never the
client project.

**Modernization priority order** (six ranks): security/auth → breaking or
deprecated runtime patterns → Fusion wiring and hosting/config → logging →
Angular/frontend patterns → style-only cleanup.

**Database runtime configuration default** — OpenShift/Kubernetes split SQL
environment variables composed once at startup into `ConnectionStrings`. The
variable *names* are `SqlServer__Server`, `SqlServer__Database`,
`SqlServer__Username`, `SqlServer__Password`, `SqlServer__Encrypt`,
`SqlServer__TrustServerCertificate`. (Names only — no values appear in the
source, and none are recorded here.)

**Auth stance matches the majority, not the outlier.** Lines 258-260: *"Okta is
the required final authentication model. Legacy auth may be retained temporarily
only to preserve parity during modernization, but it must not be treated as the
final target state."* No `AddJwtBearer` hand-rolled stack is described. That
makes it **five-to-one** against `fusion-auth-standards.md`, strengthening the
earlier recommendation to rewrite that single file.

**Two new artifact locations**, both inside already-allowed write zones:
`.modernization/ignition-artifacts/status/<AppName>/STATUS_REPORT.md` (plus an
`_artifacts/` subfolder for short-lived logs) and
`.modernization/portal/data/parity/parity.json`.

**New toolkit roots named:** `.vscode/` and `starter-deploy/` join `.github/`
and `.modernization/` in the "do not encode the validation app's specifics"
rule.

**New instruction file referenced:** `.github/instructions/tests-commenting.instructions.md`,
required for every file under `tests/`.

---

## ⚠ Findings in `copilot.instructions.md`

**1. The rerun-approval rule is stated three times in one file.** Lines 33, 65,
and 72 each say, in slightly different words, that rerunning a completed
numbered step needs explicit approval, that a direct button click/slash
command/named-step request counts as that approval, and that you must warn the
rerun can change recorded status. Three copies is exactly what
`agent-process-conformance` forbids ("Do not copy the same generic step-state
boilerplate…"), and the copies have already begun to diverge: line 33 says "do
not ask twice", line 65 adds "and you should still warn", line 72 frames it as
"implicit housekeeping". Collapse to one.

**2. `.modernization/portal/data/parity/parity.json` forks the portal data root.**
Everywhere else portal JSON lives under `.modernization/portal/data/json/`. This
one file sits in a sibling `parity/` directory. It is inside the allowed write
zone so it is not a permissions problem, but it is a fourth root-shaped
inconsistency and the parity artifacts are already the most forked family in the
kit (see the `generated/` finding below).

**3. `Partial` has no home in this file's status model.** See the vocabulary
finding above.

**4. Line 55 is good and should be generalized.** *"Do not assume `rg` or
ripgrep is installed in the current shell. Check availability first."* This is
the only tool-availability check in any transcribed file, and the kit depends on
at least eight PowerShell scripts whose existence is never checked. Worth
lifting into a general rule — it pairs directly with the pre-flight
script-existence check recommended earlier.

**5. Rank 1 of the precedence list is "the current user request."** Combined
with finding above, and with the personality baseline's "Never ask for
confirmation to continue routine execution", the kit's default posture is
strongly biased toward doing what it is told. That is fine for velocity and bad
for a company-wide hackathon where the person giving instructions may not know
the kit's invariants. The Evidence Contract in `appmod-phase-agent-contract` is
the main counterweight and it only binds three agents.

---

## ⚠ PARTIAL CORRECTION to the artifact-root finding below

The section immediately below says the artifact-root fork is decided. That
remains true **for the fusion-restructure root**, which was the fork in
question. But `AppMod-Process.instructions.md` has since surfaced a *second,
separate* root fork that the artifact contract does not share — so "the root
question is settled" would be too strong a reading. Details in the
`AppMod-Process` findings section below (`generated/` artifacts).

---

## ⚠ NEW FINDING: the two authorities disagree about what Step 20 produces

The kit names two authorities and says they must stay aligned:

- `AppMod-Artifact-Contract.json` — machine-readable, drives the verifier
- `AppMod-Process.instructions.md` — "the durable human-readable authority"

They contradict each other on Step 20 ("Final Verification"):

| Source | Says |
|---|---|
| Artifact contract, step 20 | `"producedOutputs": []` |
| Process file, Review Exit Criteria | *"Step 20 final verification evidence **exists** for build, suites, runtime, and control-point alignment."* |
| Process file, Review Entry Discipline | Steps 21, 22, 23 all *"require current Step 20 final verification evidence"* |

So three downstream steps are told to require an artifact that the verifier
contract says is never produced. There is no path for the verifier to check it,
and no `selfHeal` string can regenerate a file no step owns. Under a strict
reading, Steps 21-23 can never satisfy their own stated entry discipline.

This is the second empty-output step (step 16 is the other), but it is worse
than step 16: step 16 at least has no downstream consumer asserting the artifact
exists. Recommended fix: give step 20 a concrete `producedOutputs` entry —
`.modernization/ignition-artifacts/reviews/final-verification.json` would match
the naming of every other Review-phase output.

---

## ✅ The cleanest single-file proof of the +2 drift yet

`appmod-phase-agent-contract.instructions.md` contradicts itself **within 24
lines**, and the contradiction is exactly +2 in both directions.

Line 39 (Shared Critical Rule 22):

> Every numbered-step response in **Phase 2 (Step 9 through Step 20)** must
> include concrete counts and percentages … Discovery steps
> (**Step 5 through Step 8**) must populate the underlying totals.

Lines 45-47 (Shared Phase Discipline), in the same file:

> **Discovery (Steps 1 through 6)** … **Modernize (Steps 7 through 18)** …
> **Review (Steps 19 through 24)**

Apply −2 to rule 22 and it lands exactly on the Phase Discipline block:
9→7, 20→18, 5→3, 8→6. Both ranges in one sentence, both stale, both by the same
offset, in a file whose *own next section* has the corrected numbers. This is
the tightest evidence in the whole import that the renumber was done per-line
and this line was missed.

`AppMod-Process.instructions.md` has one of the same class, though only the
start of the range drifted. Line 54:

> Re-architect the browser surface into `src/` using the Fusion starter
> standards (**Steps 8 through 13**).

Re-architecting the browser surface is Steps 10-13; Steps 8-9 are backend
formation and hardening, per this file's own Phase 2 table 70 lines later. The
end of the range (13) was updated and the start (8) was not — a half-applied
edit rather than a clean +2, which is if anything more dangerous, because the
range still looks plausible.

**Linter rule this justifies:** any prose range of the form "Steps N through M"
must be checked against the phase map in `AppMod-Process.instructions.md`, not
just against a global +2 rule. Neither of these two would be caught by a
uniform-offset check.

---

## Structural facts added by `AppMod-Process.instructions.md`

265 lines. Frontmatter is `name` + `description` only — **no `applyTo`**, so
unlike every other instruction file transcribed, this one does not auto-attach
to anything. It is referenced by name instead (five times across the two files
transcribed today). Worth knowing: an agent only reads this if something tells
it to.

It opens by stating its own job in a way no other file does:

> Use this file to answer these questions before acting: 1. Which phase is
> active … 5. What is the next numbered step when the current step succeeds?
> If the current request conflicts with this sequence, surface the conflict
> instead of inventing a new path.

**Full step table, all 24 steps, with QA workflow mapping.** Discovery steps 1-5
all map to QA prompt `None`; Steps 7-24 each map to a `[WORKFLOW] <step name>`
QA workflow named after the step. Step 6 is the exception — it is the *Required
Discovery Companion Gate*, has no standalone QA handoff, and instead reuses
`[WORKFLOW] Modernization Solution Design` then
`[WORKFLOW] Modern Build Planned QA Tests` inside itself.

**The legacy-parity contract, stated in full for the first time.** Section
`### Frontend Parity Gate (before Step 14)` defines three named roll-ups that no
previously transcribed file names:

- `fieldParity` — every legacy grid column/field rendered (**no column
  collapse**) and every filter/action control wired to a real handler (**no
  inert stubbed-handler control**)
- `filterEffectParity` — every filter actually changes the visible row set; *"a
  filter that returns identical rows before and after is a dead filter, not a
  working one"*
- `siblingListDistinctnessOverall` — routes with multiple sibling list sections
  must return distinct data per section; identical rows across tabs indicates a
  wrong discriminator

Ownership is split precisely: Step 13 **owns** visual parity and only
**confirms** field parity, whose content work belongs to Step 11 (control/column
presence) and Step 12 (live data). A `fieldParity` failure surfaced at 13 is
explicitly *"a Step 11/12 regression to fix at its source, not new Step 13
work."* That is the clearest ownership statement in the kit.

**The answer-key principle** (line 59) is the strongest anti-drift rule in the
kit and deserves to survive the port to Squad verbatim:

> the visual-parity reference is always the **legacy application in
> `LegacyCode/`** plus the extracted legacy visual contract, never a finished
> modern reference … so "the modern app does not resemble the legacy app" is a
> gate failure, not an accepted default.

**Other new facts:**

- `LegacyCode/` is immutable after Step 1, with exactly one allowed exception:
  `LegacyCode/<LegacyTestProject>/Characterization/Baseline`.
- Step 7 backend uplift happens in a separate mutable workspace named
  `LegacyCode_NETXX_Upgrade`, where `XX` is *"the approved highest **even** .NET
  major version"* — the even-major policy, previously seen only in prompt 02,
  restated here.
- Step 7 declares a topology mode: `RunnableRuntime` or `ConstrainedLegacyHost`
  (for a legacy System.Web host that cannot run net10 in-place). Constrained
  topology is an explicitly valid completion path. This is new — no transcribed
  prompt mentions it.
- Step 24's issue disposition ledger uses exactly four verdicts: `Resolved`,
  `Deferred`, `Blocked`, `AcceptedRisk`.
- Required Evidence Pack lists 11 `reports/*` deliverables, eight of which
  (`Manifest-Coverage-Report`, `Current-State-Classification-Report`,
  `Enterprise-Target-State-Report`, `App-Target-Delta-Report`,
  `Modernization-Distance-Assessment`, `Lane-Recommendation-Report`,
  `Gap-and-Exception-Register`, `Leadership-Summary`) appear **nowhere** in the
  artifact contract and are produced by no numbered step in it.

---

## ⚠ Findings in `AppMod-Process.instructions.md`

**1. A second artifact-root fork, on the `generated/` family.** Three paths here
disagree with the artifact contract:

| Artifact | Process file says | Artifact contract says |
|---|---|---|
| `testing-ownership-matrix.generated.json` | `.modernization/artifacts/generated/` (line 88) | `.modernization/ignition-artifacts/discovery/` |
| `frontend-parity-status.generated.json` | `.modernization/ignition-artifacts/generated/` (line 241) | `.modernization/portal/data/json/` |
| `parity-report.generated.json` | `.modernization/ignition-artifacts/generated/` (line 240) | not present anywhere |

Note the first row is a *different root prefix entirely* —
`.modernization/artifacts/` with no `ignition-` — which appears exactly once in
everything transcribed and is in neither the contract nor
`agent-toolkit-protection`'s allowed write zone. Three different opinions about
where generated parity artifacts live is worse than the fusion-restructure fork
was, because these are the files the visual/field parity gates read.

**2. Eleven `reports/*` deliverables with no producer.** The Required Evidence
Pack demands them "at minimum" when the flow completes, but no step in the
artifact contract produces them and the verifier therefore cannot check them.
Either the list is aspirational (and should say so) or the contract is missing
eleven outputs. For a hackathon this reads as a checklist teams will be judged
against and cannot satisfy.

**3. `characterization-test-planning.json` resolved — in the process file's
favor.** Line 88 puts it at `.modernization/portal/data/json/`. That settles the
one genuinely ambiguous read in the artifact contract photos.

**4. No `applyTo`.** Nothing auto-loads this file. Given it is called "the
durable human-readable authority" and is named as the phase authority by the
phase-agent contract, relying on prose cross-references to get it into context
is fragile. Adding `applyTo` (or having the phase agents load it explicitly)
would be cheap insurance.

---

## Structural facts added by `appmod-phase-agent-contract.instructions.md`

174 content lines plus 3 trailing blanks. Binds **three** agents by name:
`OpX-AppMod-P1-Discovery`, `-P2-Modernize`, `-P3-Review`. Note the contrast with
`appmod-agent-personality-baseline`, which binds those same three **plus**
`Ultimate-AppMod-Ignition`.

**The precedence chain is now explicit and three deep.** Line 13:

> When this contract and
> `/.github/instructions/appmod-agent-personality-baseline.instructions.md` both
> apply to a phase agent, **this contract wins** for chat shape, QA routing,
> numbered-step execution behavior, and state persistence rules.

Combined with the baseline's own "narrower instruction wins" rule, the resolved
order for a phase agent is: phase-agent-contract > personality-baseline >
agent-process-conformance's shared contract.

**The Evidence Contract (rule 20) is the best thing in the kit.** It is a
genuine anti-hallucination clause with a closed list of accepted proofs:

> (a) the file path plus the exact line range that proves the change; (b) the
> exact command and its actual exit code from the most recent run; (c) the
> artifact path plus its current `lastUpdatedUtc` or file mtime; (d) the
> screenshot path that was actually produced.

…and a closed list of forbidden phrases without evidence: *"I verified", "I
tested", "I ran", "I confirmed", "should now work", "is complete", "is wired",
"is fully covered"*. When proof cannot be produced the agent must state
`UnverifiedClaim` and stop the substep. Rule 21 adds a mandatory re-read
self-check before any step may report `Completed`. **Port these to Squad
verbatim.** They are directly on point for the drift risk that motivated this
whole exercise.

**Rule 15 is the counterweight** and is equally worth keeping: an explicit
invocation ("run Step 5", "rerun Step 12") means *full fresh execution* — never
a "validation-only reconciliation" — because *"the user may have added new code,
changed the environment, or be deliberately hunting for what you missed."*

**Required Chat Shape** — six mandatory sections in fixed order: `Step Status`,
`Modernization Added`, `Modernization Progress`, `Returned Data`, `QA Summary`,
`Step Execution State`; plus three optional: `Evidence Links`,
`Change Summary Needed`, `Reply Shortcut`.

**Modernization Progress Metric** — 13 named counters (`backend.movedFiles`,
`backend.endpointsHardened`, `frontend.routesMigrated`,
`frontend.componentsClassified`, `frontend.componentsMigrated`,
`frontend.subPatternsClosed`, `frontend.screenshotsCaptured`,
`frontend.fusionPrimitiveCoverage`, `tests.pomCoverage`,
`tests.gherkinCoverage`, `tests.ariaCoverage`, `tests.testIdCoverage`,
`tests.backendUnitCoveragePercent`) plus three rollups, all in
`done / remaining / total (percent%)` form, persisted under
`modernizationProgress` in `step-workflow-state.json`.

**New script and artifact:** `.github/scripts/shared/Invoke-StepReconciliation.ps1 -Step <N>`,
which regenerates `.modernization/.readme/.StepSummary.md` from saved state.

**The Quality Portal is manual-only, emphatically.** No numbered step, helper
lane, agent, or QA workflow may auto-run `qa-refresh-portal.ps1` *"regardless of
the OPX_ENABLE_QA_PORTAL_REFRESH shell flag"* — a documented environment flag
that the rule explicitly overrides.

---

## ⚠ Findings in `appmod-phase-agent-contract.instructions.md`

**1. `tests.gherkinCoverage` re-opens the `.feature`-file conflict.** Rule 22's
metric list requires counting *"user-facing features with a feature file vs
total features."* That is a `.feature` file by any reading, and it is now a
**mandatory reported metric on every Phase 2 step response**. The earlier
finding recorded that only prompt 24 wanted `.feature` files, that Steps 12/17
forbid them, and that the canonical test workspace has no `features/` directory.
That resolution needs revisiting: this file makes Gherkin coverage a standing
obligation, not a one-prompt quirk. Either the metric should be redefined
against Gherkin-style headers inside ordinary test files (matching
`appmod-testing-and-gates`), or the kit needs to decide it really does want
`.feature` files and fix Steps 12/17.

**2. `Ultimate-AppMod-Ignition` is outside this contract.** The three phase
agents get the Evidence Contract, the self-check rule, and the Required Chat
Shape. The top-level coordinator does not. Combined with the earlier finding
that `Ultimate-Ignition-edit` is outside the personality baseline, the pattern
is consistent and backwards: **the two most privileged agents in the kit carry
the least behavioral scaffolding.**

**3. Rule 22's Phase 2 range is stale (+2).** See the drift section above.

**4. Rule 1 forbids creating scripts; the kit references scripts that may not
exist.** *"Do not create new scripts. All scripts already exist in
`.github/scripts/`."* Combined with rule 12 ("do not invent … return `Blocked`"),
an agent that hits a missing script has exactly one legal move: block. That is
correct behavior, but it means every referenced script path is a potential hard
stop. The scripts named across today's files —
`Invoke-StepReconciliation.ps1`, `Invoke-StepRestorePoint.ps1`,
`backup-src-and-legacy-baseline.ps1`, `restore-src-and-legacy-baseline.ps1`,
`verify-step-artifacts.ps1`, `generate-manifest.ps1`, `generate-ui-api-map.ps1`,
`qa-refresh-portal.ps1` — should be existence-checked before the hackathon.
This is a cheap, high-value pre-flight script.

**5. Markdown structure defects.** Missing blank line before three headings
(`## Shared Chat Contract` at 52, `### Required Chat Shape` at 139,
`### Quality Portal Rule` at 160) and a double blank at 167-168. Some Markdown
renderers will fold those headings into the preceding list. Cosmetic, but this
file is meant to be read by both agents and humans.

**6. A blank line splits the numbered Shared Critical Rules list** (line 36,
between rule 19 and rule 20). Most Markdown renderers restart or break the
ordered list there, so rules 20-22 may render as a new list starting at 1.

---

## ⚠ `AppMod-Step-Contract.json` is now the highest-value un-transcribed file

It is named as **the routing authority** five times across the two files
transcribed today, and it is the only stated source for:

- the exact step-to-workflow mapping
- the machine-checkable **Discovery-to-Modernize gate between Steps 6 and 7**
- the `InLoopCheckpoint` step classification that decides when QA runs inside
  the step loop versus after it

Nothing transcribed so far contains any of that. It has now overtaken
`constitution.md` on my list — `constitution.md` is an unknown quantity, whereas
this file is a known, load-bearing dependency of the agents' routing behavior.

Second priority alongside it: `qa-portal-reporting.instructions.md`, named as
*"the canonical rule"* for portal reporting.

---

## ✅ RESOLVED: the artifact-root fork — `AppMod-Artifact-Contract.json` uses the long form, exclusively

This was the largest open inconsistency in the kit, and the contract settles it.

Across all 291 transcribed lines — roughly 90 `"path"` entries spanning steps 1
through 19 — the fusion-restructure root appears **only** as:

```
.modernization/ignition-artifacts/modernize/fusion-restructure/…
```

The short form `.modernization/fusion-restructure/…` appears **zero times**.

This agrees exactly with the Allowed Runtime Artifact Areas list in
`agent-toolkit-protection.instructions.md`. Two independent Ignition-native
control files now say the same thing, so the fork is decided:

- **Canonical:** `.modernization/ignition-artifacts/modernize/fusion-restructure/**`
- **Wrong:** `.modernization/fusion-restructure/**`

The five transcribed files that use the short form are therefore **defects**, not
an alternative convention: `visual-parity-gate/SKILL.md`,
`architecture-structure/SKILL.md`, `prompts/21-P3-figma-review.prompt.md`,
`runtime-parity-checkpoint/SKILL.md`, and the `_variables.scss` template. Each
needs a path rewrite. This is the single highest-value mechanical fix available
before a hackathon: it is unambiguous, machine-checkable, and a wrong root means
a downstream step's `hardStop` gate fires on a file that was actually written.

Two other roots are confirmed canonical by the same evidence:

- `.modernization/ignition-artifacts/discovery/…` — Discovery artifacts
- `.modernization/portal/data/json/…` — portal/control-plane artifacts

And the identity file resolves as `agent-toolkit-protection` requires:
`"appNameSource": ".modernization/.readme/kit-params.md"` — the long, non-retired form.

---

## ✅ RESOLVED: the +2 drift is *deliberately preserved* in artifact filenames

`agent-integrity-checks.instructions.md` proved the +2 drift was applied
per-line. The artifact contract proves something stronger: in at least three
places the drift is **intentional and documented**, not a mistake.

Step 17 ("Rewire All Tests & Verify") produces:

```json
{ "path": ".modernization/portal/data/json/step19-gate-results.json", …
  "note": "Comprehensive quality-gate results. Filename retains the l[egacy step number…]" }
```

Step 18 ("Deployment & Clean Up") produces:

```json
{ "path": ".modernization/portal/data/json/step20-rollback-dryrun.json", …
  "note": "Rollback dry-run record. Filename retains the legacy st[ep number…]" }
{ "path": ".modernization/portal/data/json/step20-perf-verification.json", … }
```

`step19-` produced by step 17, `step20-` produced by step 18 — exactly +2, and
the `note` field says so in words: *"Filename retains the legacy step number."*

**Implication for the linter:** filenames matching `^step\d+-` must be
**excluded** from any +2 renumbering sweep. They are frozen on purpose, presumably
because renaming them would break every consumer that globs for them. This is the
same class of deliberate shim as `step9UpgradeWorkspaceRoot` in
`OpX-dotnet-upgrade.agent.md`. Two confirmed intentional shims now — the
"fix all the numbers" instinct would break both.

---

## ⚠ NEW FINDING: `e2e-spec` is an undeclared producer (contract self-violation)

The contract opens with a `producerLegend` that defines exactly four producers:

| Producer | Meaning |
|---|---|
| `dev-agent` | authored directly by the step's owning agent; always produced on a normal run, **including No QA runs** |
| `dev-script` | produced by the step's own helper script under `.github/scripts/`; independent of QA |
| `qa-script` | historically produced by `.github/scripts/QA/qa-refresh-portal.ps1`; **only runs when QA runs** |
| `tool` | produced by a parity/test runner (`parity-score.mjs`, `run-visual-parity.mjs`, `dotnet/npm test`) |

The `tool` entry carries an explicit rule:

> Any control-plane file here MUST also have a dev-agent or dev-script owner so No QA runs are not blocked.

Step 12 then declares a producer that is not in the legend at all:

```json
{ "path": ".modernization/ignition-artifacts/discovery/behavioral-parity-checkpoint.json",
  "producer": "e2e-spec", "noQaSafe": false, "consumedBySteps": [], … }
```

Two problems, and they compound:

1. **`e2e-spec` is undefined.** Nothing in the legend says what produces it, when
   it runs, or what to do when it is absent. An agent reading this contract has
   no rule to apply.
2. **It is the only `"noQaSafe": false` entry in all 19 transcribed steps.**
   Every other output is `true`. So on a No-QA run this one artifact is not
   produced — and the legend's stated purpose for the `noQaSafe`/dual-owner
   machinery is precisely to stop that from blocking a run. It has no second
   owner.

For the hackathon this is a live stall risk: a team running without the e2e lane
gets a missing `behavioral-parity-checkpoint.json` and no documented recovery.
Fix is one of: add `e2e-spec` to the legend with a self-heal, or give the entry a
`dev-agent` co-owner. Recommend the latter — it matches the rule the contract
already states for `tool`.

Also worth noting: `qa-script` is **declared but never used** in steps 1-19. Its
description is already written in the past tense ("Historically produced by…"),
so it may be a dead legend entry. Steps 20-24 may still use it.

---

## Structural facts added by `AppMod-Artifact-Contract.json` (lines 1-291)

This is the machine-readable spine of the pipeline — the file the shared verifier
reads to decide whether a step may start and whether it finished.

**Header block (lines 1-29).**

- `"schemaVersion": "1.0"`.
- `"purpose"` names it a *"Per-step artifact input/output contract for the
  **24-step** modernization workflow"* and says it drives
  `.github/scripts/shared/verify-step-artifacts.ps1` **and the per-step
  self-check wording in each** prompt. That second clause matters: prompt
  self-check text is supposed to be *generated from* this contract, which means
  any prompt whose self-check disagrees with this file is drifted by definition.
- `"appNamePlaceholder": "<AppName>"`, `"appNameSource": ".modernization/.readme/kit-params.md"`.
- `producerLegend` (4 entries) and `gateLegend` (3 entries) — tabulated above and below.
- `"verifyNote"`: entries with `verify=false` are source-tree or glob outputs the
  verifier does not presence-check. It *"only asserts presence and non-emptiness
  of concrete JSON and Markdown artifacts."*
- `"schemaNote"`: an entry may declare an optional `schema` pointing to a
  lightweight **`opx-field-contract/v1`** file under `.github/contracts/schemas/`.
  This is the first sighting of that contract format name.

**The three gate kinds.**

| Gate | Behavior |
|---|---|
| `hardStop` | required upstream input; if missing/empty the step must self-heal via its `selfHeal` command or report **Blocked** |
| `advisory` | read when present; if missing, self-heal deterministically and continue without QA |
| `conditional` | required only when the matching condition holds (e.g. a browser surface exists, or MVC/Angular source is detected) |

Note `conditional` is **declared but unused** in steps 1-19 — same status as
`qa-script`. Steps 20-24 may use it.

**`restorePointPolicy` (lines 19-29) — new subsystem, not seen in any prompt yet.**

- `"invariant": "A"`.
- Purpose: *"Isolation and reversibility for mutating steps. Before a step that
  changes `src/` or `LegacyCode/` runs, a workspace baseline must exist so the
  repository can be restored to the last known-good state…"*
- Manifest: `.modernization/OpXUtil/Backup/WorkspaceBaseline/workspace-baseline.manifest.json`
  — **`.modernization/OpXUtil/` is a sixth artifact root**, and it is *not* in
  `agent-toolkit-protection`'s Allowed Runtime Artifact Areas list. See finding below.
- Five commands, all `powershell -NoProfile -ExecutionPolicy Bypass -File …`:
  - `.github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step <N> -Mode Ensure`
  - same script `-Mode Verify`
  - same script `-Mode Recover`
  - `.github/scripts/Workspace/backup-src-and-legacy-baseline.ps1 -Target All`
  - `.github/scripts/Workspace/restore-src-and-legacy-baseline.ps1 -Target All`
- `"note"`: Mode Ensure creates the baseline if absent and is non-destructive;
  **Mode Verify blocks with exit code 2** when no baseline exists. Exit code 2
  matches the Squad gate convention (`RESULT: BLOCKED` = exit 2).

**The 8 steps carrying `"restorePoint": { "required": true, "invariant": "A" }`:**
8, 9, 11, 12, 13, 15, 16, 18 — and *not* 7, 10, 14, 17. Steps 1-6 and 19-24 have none.

**Canonical step names 1-19, straight from `readableName`:**

| # | readableName |
|---|---|
| 1 | Workstation Readiness |
| 2 | Rename Starter To `<AppName>` |
| 3 | Legacy System Analysis |
| 4 | Baseline Acceptance-Criteria Review |
| 5 | Modernization Solution Design |
| 6 | Modernization Quality Design |
| 7 | Backend - Upgrade .NET |
| 8 | Backend - Modernization Formation |
| 9 | Backend - .NET Integration Hardening |
| 10 | Frontend Foundation & Scaffold |
| 11 | Frontend Migration |
| 12 | Frontend Platform Integration |
| 13 | Frontend Shell Stabilization |
| 14 | Frontend UI Inventory & Fusion Map |
| 15 | Fusion UI Integration |
| 16 | Next Fusion UI Upgrade Slice |
| 17 | Rewire All Tests & Verify |
| 18 | Deployment & Clean Up |
| 19 | Final Fusion Restructure Review |

These match the 24 prompt filenames one-for-one with **no offset**. The contract's
`"step"` numbers are the *new* (correct) numbering throughout — including inside
`selfHeal` strings ("Re-run Step 5.", "Re-run Step 14."). So this file is on the
correct side of the +2 drift everywhere except the deliberately-frozen
`step19-`/`step20-` filenames.

**Schemas referenced under `.github/contracts/schemas/` (9 distinct, all new names):**
`step-workflow-state.schema.json`, `fusion-decisions.schema.json`,
`fusion-migration-plan.schema.json`, `fusion-control-point-inventory.schema.json`,
`modernization-execution-contract.schema.json`,
`modernization-phase-assessment.schema.json`,
`modernization-solution-design.schema.json`,
`executable-testcase-catalog.schema.json`, `per-route-behavior-plan.schema.json`.

**Helper scripts named (4 distinct):**
`.github/scripts/P1-Discovery/generate-manifest.ps1` (with
`-RepoPath ./LegacyCode -LegacySystemAnalysis`),
`.github/scripts/shared/verify-step-artifacts.ps1`,
`generate-ui-api-map.ps1`, and the two `Workspace/` baseline scripts above.

**Source-tree outputs with `"verify": false`** (step 8 only, so far):
`src/<AppName>.Library`, `src/<AppName>.Web.Api`. Step 8 also produces a real
project file: `tests/backend/unit/<AppName>.Library.Tests/<AppName>.Library.Tests.csproj`.

---

## ⚠ Findings in `AppMod-Artifact-Contract.json` (lines 1-291)

**1. `.modernization/OpXUtil/**` is written but not in the allowed write zone.**
`restorePointPolicy.manifest` points at
`.modernization/OpXUtil/Backup/WorkspaceBaseline/workspace-baseline.manifest.json`,
and the backup scripts necessarily write beside it. But
`agent-toolkit-protection.instructions.md`'s Allowed Runtime Artifact Areas list
is exactly five globs, and `OpXUtil` is not among them. Same class of gap as the
short-root problem, only here the *contract* is the thing outside the boundary,
so the fix belongs in `agent-toolkit-protection` (add `/.modernization/OpXUtil/**`),
not in the contract.

**2. Step 4 has a `selfHeal` that re-runs a Discovery script for an input it does
not own.** Step 4's `review-manifest.json` input self-heals by invoking
`.github/scripts/P1-Discovery/generate-manifest.ps1` — the same script step 3
uses as its `selfHealCommand`. Not wrong, but it means two steps can regenerate
the same artifact with different flags, and only step 3's invocation is fully
visible in these photos (the step 4 and step 5 copies are cut off before their
flags). Worth confirming the flags match on re-shoot; if they differ, running
step 4's heal after step 3 could silently overwrite a richer manifest with a
thinner one.

**3. `qa-test-plan.json` is consumed by six steps and produced by one.**
Step 6 produces it with `consumedBySteps: [8,11,12,13,14,17]`. It is the
widest-fanout artifact in the contract and it is `dev-agent`-authored, i.e. free
prose from a model rather than script output. If a team's step 6 produces a thin
plan, six later steps degrade at once with no gate to catch it. There is no
`schema` on this entry — unlike `executable-testcase-catalog.json` right below
it, which does have one. Recommend adding a schema.

**4. Step 16 produces nothing.** `"producedOutputs": []` for "Next Fusion UI
Upgrade Slice". It consumes `ui-migration-order.json` and `ui-fusion-map.json`
and emits no artifact at all, so there is nothing for the verifier to assert and
no way to tell a completed slice from a skipped one. Step 1 is also empty on both
sides, which is fine for a readiness check — but step 16 is a *mutating* step
(it carries `restorePoint.required: true`). A mutating step with no output is
un-auditable. This is a real hackathon risk: step 16 is the loop step teams will
run repeatedly.

**5. `characterization-test-planning.json` root is ambiguous in the photo.**
Recorded in `_wip/` as `.modernization/ignition-artifacts/…` but the adjacent row
reads `.modernization/portal/data/json/…`. Needs the re-shoot to settle.

---

## Structural facts added by `appmod-agent-personality-baseline.instructions.md`

An 71-line shared behavior file bound by `applyTo` to exactly four agents:
`Ultimate-AppMod-Ignition`, `OpX-AppMod-P1-Discovery`, `OpX-AppMod-P2-Modernize`,
`OpX-AppMod-P3-Review`. It opens by telling the reader how to interpret it:

> Interpret second-person directives below as inheritable behavior rules, not as
> a standalone agent definition.

That framing is the answer to a question raised earlier in this import — why
several agent files carry near-identical posture text. This file is where it is
*supposed* to live. Sections: Core Posture, Communication Contract, Execution
Contract, Web Research Contract, Obstacle Handling, Completion Gate, Precedence Rule.

Concrete rules worth pulling out:

- **A mandated reasoning block.** At major decisions the agent must emit a
  fenced `text` block with exactly four labels: `Analyzing:`, `Approach:`,
  `Risks:`, `Verification:`.
- **Resume vocabulary is fixed:** `resume`, `continue`, `try again` all mean
  "continue from the last incomplete todo item."
- **"When you say you will run a tool call, run it in the same turn."** A direct
  countermeasure to the announce-then-stall failure mode.
- **A four-step obstacle ladder:** state the blocker → attempt an in-scope
  deterministic remediation → re-verify → escalate only with concrete evidence.
- **A five-item Completion Gate** that must pass before the agent closes.
- **Precedence Rule:** when this baseline and a narrower instruction both apply,
  the narrower or more specific instruction wins.

The Precedence Rule is the second such rule in the instruction layer
(`agent-process-conformance` has its own), and the two agree.

---

## ⚠ Findings in `appmod-agent-personality-baseline.instructions.md`

**1. It binds four agents by name — and the fourth is one of the two identical twins.**
`applyTo` lists `Ultimate-AppMod-Ignition.agent.md` but **not**
`Ultimate-Ignition-edit.agent.md`. Given that those two files have byte-identical
frontmatter apart from `name:`, and that `Ultimate-Ignition-edit` is the *only*
agent permitted to rewrite `.github/`, the toolkit editor is the one coordinator
running **without** the shared Completion Gate and Obstacle Handling ladder. That
is backwards from a safety standpoint: the most privileged agent has the least
behavioral scaffolding. Either intentional and undocumented, or an oversight.

**2. "Never ask for confirmation to continue routine execution" has no carve-out
for destructive steps.** Read literally alongside the artifact contract's
`restorePoint` policy, an agent at step 8/11/18 would proceed through a mutating
step without pause. The restore-point machinery exists precisely because those
steps are dangerous. The baseline should exempt steps with
`restorePoint.required: true` from the no-confirmation rule, or at minimum
require the Ensure command to have succeeded first.

**3. Frontmatter uses `name:` — `angular.instructions.md` does not.** See the
cross-file finding below.

---

## Structural facts added by `angular.instructions.md`

67 lines, `applyTo: "**/*.ts,**/*.html,**/*.scss,**/*.css"` — so it auto-applies
to every TypeScript, template, and stylesheet in a modernized app. Four sections:
General, Kendo UI License Handling, Security, Testing.

**General** is short and mostly conventional (prefer signals, prefer standalone
components, keep templates lean), with two Fusion-specific mandates:

- capture errors with `FusionErrorService` from `@fusion/ngx-fusion`, *"which
  already logs and executes policies"*
- use `FusionLoggerService` from the same package

It also tells agents to consult `patch-notes/**` first when troubleshooting
post-upgrade breakage — a directory not referenced by anything else transcribed
so far.

**Kendo UI License Handling** is over half the file (lines 17-52) and is the most
detailed root-cause writeup in any instruction file so far. The mechanism:
`@fusion/ngx-fusion` bundles Kendo Angular packages carrying a `publishDate`; the
embedded license in `@progress/kendo-licensing/dist/index-esm.js` carries a
`licenseExpirationDate`; when `publishDate > licenseExpirationDate` the check
fails and the watermark renders even in development. It then explicitly kills the
folk remedy:

> The `KENDO_UI_LICENSE=ignored` environment variable approach only works with
> the legacy webpack-based Angular builder. Angular 17+ uses esbuild
> (`@angular/build`), which does NOT substitute `process.env` variables into the
> browser bundle from the Node.js environment.

Three escalating remedies are given: a dev-only regex patch of the vendored
licensing bundle, full activation via `npx kendo-ui-license activate`, and a CI/CD
path using a pipeline secret.

**Security** is two lines (built-in sanitization; CSP and Trusted Types).
**Testing** is a link list to `angular.dev` guides plus `#tool:angular-cli/*`.

---

## ⚠ Findings in `angular.instructions.md`

**1. The Kendo license patch is a self-inflicted wound waiting to happen.**
The documented "Quick Suppression" rewrites a file inside `node_modules` belonging
to Progress's licensing module:

```powershell
$patched = $raw -replace '\b174733\d{4}\b', '1999999999'
```

Three separate problems, in ascending order of seriousness:

- The regex `\b174733\d{4}\b` is pinned to Unix timestamps beginning `174733`,
  i.e. a narrow window in May 2025. When Fusion ships a bundle with any other
  expiration date, the patch silently matches nothing, the watermark returns, and
  the operator has no signal that the "fix" no-opped. Nothing in the file says to
  verify the replacement happened.
- The file already admits the patch is lost on every `npm install` and suggests
  making it a `postinstall` script — which converts a one-time manual hack into
  something that runs automatically on every developer machine and every CI agent.
- It is a modification to a vendor's licensing enforcement. Whatever the intent,
  a `postinstall` hook that rewrites Progress's license-expiry check and commits
  it via `patch-package` is not something to standardize across a company-wide
  hackathon without legal sign-off. The "Full Activation" section immediately
  below describes the licensed path and should be the default, with the patch
  removed or clearly marked as unsupported.

This is the same finding previously logged against the kit's Kendo licensing
patch; this file is where it actually lives, so it is now located, not just suspected.

**2. Frontmatter shape disagrees with every other instruction file.**
`angular.instructions.md` has only `description` and `applyTo` — **no `name`**.
`appmod-agent-personality-baseline`, `agent-toolkit-protection`, and
`agent-process-conformance` all carry `name`. Whether `name` is required is
unknown (VS Code's instructions frontmatter treats `applyTo` as the only
meaningful key), but three-against-one is a lint rule waiting to be written, and
it hints `angular.instructions.md` was authored earlier or by a different hand
than the `appmod-*` files.

**3. `applyTo` glob will attach this file to the legacy app too.**
`**/*.ts,**/*.html,**/*.scss,**/*.css` has no exclusion for `LegacyCode/`. During
Discovery, an agent reading legacy AngularJS or Knockout templates gets "prefer
signals, prefer standalone components" injected into its context. That is exactly
the instruction least applicable to a G1 legacy file and it arrives with no
phase gating. Compare `agent-toolkit-protection`, which scopes tightly to
`.github/agents/*.agent.md`. Recommend narrowing to the modernized client root.

**4. Angular version floor is stated as 17+, not 20.** Lines 24 and 26 anchor on
"Angular 17+ uses esbuild". That does not contradict the Angular-20 target
(20 > 17), but it is a fifth distinct version number in the kit's Angular
discussion (17+, 19+ for the Kendo banner, 19+, 20, 21+). Only 20 is a *target*;
the others are floors. Worth stating that distinction once, centrally, so the
linter does not flag them all as conflicts.

---

## Structural facts added by `agent-toolkit-protection.instructions.md`

84 lines, and the highest-leverage instruction file transcribed so far. It resolves three open
findings and introduces one new one.

- **The Definitive Agent List — 18 agents.** The complete roster, finally stated in one place:
  `Ultimate-Ignition-edit` (the sole toolkit editor), plus `Ultimate-AppMod-Ignition`,
  `OpX-AppMod-P1-Discovery`, `-P2-Modernize`, `-P3-Review`, **`OpX-Fusion-Transform`**,
  `OpX-csharp-expert`, `OpX-csharp-janitor`, `OpX-dotnet-upgrade`,
  **`OpX-Pre-Modernization-Test-Generator`**, `OpX-QA-Hub`, **`OpX-QA-Create`**, `OpX-QA-Run`,
  `OpX-Code-Reviewer`, `OpX-Fusion-Reviewer`, `OpX-fusion-ui-component-upgrade`,
  **`modernize-dotnet`**, **`Microsoft-Researcher`**. Four are new; `OpX-Fusion-Transform` was
  previously flagged as unverified.
- **`OpX-Frontend-Angular-Transform` is absent from the list** — consistent with its archived
  status, and confirmation that the roster is maintained. The file is still installed in
  `.github/agents/`, so the list and the directory disagree.
- **A canonical-path rule with a named retired location**:
  > The canonical app identity file is always `.modernization/.readme/kit-params.md` … The path
  > `.readme/kit-params.md` (without the `.modernization/` prefix) is a **retired location and
  > MUST NOT be used**. If a script or prompt currently reads from it … treat that as a **defect**.
- **The "even when" clause** — the part that makes the boundary hold under pressure. A non-edit
  agent must refuse *even when* the user says "just fix it quickly," the change looks trivial, the
  request arrived inside a step prompt, or the target is a PowerShell script under
  `.github/scripts/`.
- **A precise allowed/denied split inside `.modernization/`**: writes are allowed to
  `portal/**`, `coverage/**`, `ignition-artifacts/**` (generated evidence and reports only),
  `ignition-artifacts/discovery/**` (generated analysis only), and
  `ignition-artifacts/modernize/fusion-restructure/**` (generated planning only) — while
  `.modernization/.readme/` is explicitly **not** in the allowed zone "even though it sits under
  `.modernization/`."
- **A Routing Rule that forbids silent recovery**: "Do not auto-handoff, auto-route, or silently
  continue in another agent lane. Tell the user to manually switch … The message to the user MUST
  name the **exact file and the exact change** that requires toolkit access."
- **A worked allowed case** so the rule is not over-applied: `qa-refresh-test-plan.ps1` and similar
  QA scripts that write only to `portal/**` or `ignition-artifacts/**` are allowed for any agent.

## ⚠ Findings for `agent-toolkit-protection.instructions.md`

**1. NEW — the short artifact root is not an approved write area.**
The Allowed Runtime Artifact Areas list contains only the **long** form:
`/.modernization/ignition-artifacts/modernize/fusion-restructure/**`. The **short** form
`.modernization/fusion-restructure/**` does not appear anywhere in the allowed zone.

That matters because five transcribed files write to the short path:
`visual-parity-gate/SKILL.md` (its `visual-parity-report.json` output),
`architecture-structure/SKILL.md`, prompt 21 (`figma-review.json`), `runtime-parity-checkpoint`
(`runtime-parity-checkpoint.json`), and the `_variables.scss` template. Under a literal reading of
this file, **those writes are outside the permitted zone** — not toolkit-protected, but not
explicitly allowed either.

This converts the long-running artifact-root fork from a documentation inconsistency into a
**permissions question**, and it tips the balance: the long form is the one the protection
contract sanctions. Recommend standardising on
`.modernization/ignition-artifacts/modernize/fusion-restructure/` and fixing the five short-form
consumers.

**2. The roster and the directory disagree by one file.** `OpX-Frontend-Angular-Transform` is
installed but not listed. Either it should be deleted (per `Ultimate-Ignition-edit`'s own
no-stale-files rule) or the list should name it as retired. Right now an agent picker shows a
twelfth agent that the governing document does not acknowledge.

**3. Four agents in the list have no transcribed file**: `OpX-Pre-Modernization-Test-Generator`,
`OpX-QA-Create`, `modernize-dotnet`, `Microsoft-Researcher`. Together with `OpX-QA-Hub`,
`OpX-QA-Run` and `OpX-Fusion-Transform`, **seven of the eighteen agents are still unseen.**
`Microsoft-Researcher` and `modernize-dotnet` are notable for breaking the `OpX-`/`Ultimate-`
naming convention entirely.

## Structural facts added by `agent-process-conformance.instructions.md`

The conformance spec for the agent layer — 120 lines, and **the fifth file in the kit with correct
step numbering throughout** ("Discovery steps 1 through 6", "active numbered steps 7 through 24",
"[Step 9] Backend - .NET Integration Hardening").

- **A six-part minimum agent shape**: frontmatter (`name`, `description`, tool list), a body
  heading naming the role, `Scope`, `Core Rules`, `Response Contract`, and handoffs mapping to
  readable process steps. This is the spec the eleven transcribed agents should be measured
  against — and `OpX-Fusion-Reviewer` (no handoffs) and the three coordinators (no opening `---`)
  visibly fail it.
- **Two approved route-wording patterns, and when to use each**:
  `Route via .github/prompts/<path>.prompt.md :: <section>.` when the prompt has multiple named
  sections; `Use .github/prompts/<path>.prompt.md and execute it in full.` when it is
  single-purpose. Everything transcribed uses the second form.
- **An eight-clause Numbered Step Execution Contract** — the strictest closure rule in the kit.
  A step is incomplete until step work, mapped QA (or explicit blocker reporting), ledger save,
  **and ledger readback** are all done, with named field checks: `status`, `updatedAt`,
  `latestFullResponse`, plus `lastExecutedStep.step/.status` and
  `recommendedNextStep.step/.label`. It also requires
  `Invoke-StepReconciliation.ps1 -Step <N>` after the save and a readback proving
  `.StepSummary.md` regenerated **without appending a duplicate historical block**.
- **An explicit anti-duplication rule**: "Do not copy the same generic step-state boilerplate into
  every numbered prompt when the shared contract already covers it. Add prompt-local text only
  when a specific prompt has unique delta behavior." That is the kit telling itself not to do the
  thing that produced most of the drift found in this transcription.
- **A plain-language reporting contract for non-specialists**: every step must open with exactly
  three bullets in order — `Context`, `Dev work`, `QA after` — one short sentence each, and
  `QA Summary` "must also use simple wording."
- **Runtime checks are opt-in, not default**: for Steps 7-24 a live Angular runtime continuity
  check is explicitly *not* part of the default preflight; only when the user asks for build/run
  proof, the QA workflow needs a running app, or evidence says the runtime is down.
- **An Evidence Link Contract** that bans citing internal scripts as proof: prefer runtime URLs,
  step-state JSON, generated proof JSON, HTML reports. Specifically —
  "The Quality Portal is manual-only; numbered steps never auto-run portal refresh and never
  depend on portal pages as proof."
- **Shared Personality Layering with a stated precedence**: put shared personality in a
  path-scoped `.instructions.md` rather than copying into each `.agent.md`; the phase-agent
  contract overrides the baseline; **the more specific local rule wins**. This is the mechanism
  behind the three-layer inheritance the coordinators declare.
- **A seven-item Conformance Checks list** for reviewing any agent or prompt.

## ⚠ Findings for `agent-process-conformance.instructions.md`

**1. A fifth unnumbered prompt, and it confirms the `Route via … :: <section>` form is real.**
`.github/prompts/P2-Modernize/integration-hardening-routing.prompt.md`, cited as
`:: [Step 9] Backend - .NET Integration Hardening.` The `P2-Modernize/` folder now holds five known
files: `cleanup`, `fix-violations`, `mvc-to-browser-client`, `angular-to-browser-client`, and this
routing prompt. Note the routing prompt is a *sectioned* file — the only evidence so far of the
multi-section prompt shape the route-wording rule exists for.

**2. It documents the exact failure this transcription kept finding, and blames copying.**
The anti-duplication rule ("do not copy the same generic step-state boilerplate into every
numbered prompt") is the correct diagnosis of how 24 prompts came to carry near-identical
Step Artifact Self-Check blocks with drifting step numbers. The rule exists; it was not followed.

**3. Its own conformance checks would fail several shipped agents.** Check 1 requires the step
label to match `AppMod-Step-Contract.json`; checks 6 and 7 require an explicit next-step contract
and no stale maintainer notes. Against the eleven transcribed agents:
`OpX-Frontend-Angular-Transform` (archived but installed, stale Core Rules),
`OpX-Fusion-Reviewer` (no handoffs, so no next-step contract), and
`OpX-csharp-janitor` (three YAML errors) would all fail. **Running this file's own seven checks
across `.github/agents/` is a concrete, cheap pre-hackathon task.**

## Transcription uncertainties (`discovery-runner`, `frontend-modernization-learning`, `dotnet`, `copilot` part 2)

**`discovery-runner.instructions.md` — line numbers do NOT match the source.**
This is the one real caveat in this batch. The source file is **hard-wrapped**
at roughly 100-110 characters: its prose paragraphs are split across many short
source lines, so the file is 175 lines. My transcription preserves the text
verbatim at the sentence level but reflows it into long single lines, giving 88.
**The content is complete and accurate; the line breaks are not the source's.**
I chose this over guessing wrap columns from an angled photo, which would have
produced false precision. If line-for-line fidelity matters for this file, it
needs a re-shoot I can measure against — but for reading and for porting the
design into Squad, the current version is faithful.

The other three files are soft-wrapped (long single source lines, wrapped only
for display), so their line numbers do match:

- **`frontend-modernization-learning.instructions.md`** — 170 lines, 10 anchors
  verified. The multi-blank-line gaps before four headings (`Slice Parity`,
  `Live-Wire Click-Through`, `Runtime Parity And Move-First`, `Legacy Visual
  Parity`) are faithful to the source; the arithmetic only closes at 170 if they
  are reproduced. This file is very dense small text and is the batch's
  highest-effort read; if any single passage matters operationally, spot-check it
  against the photo before acting on it.
- **`dotnet.instructions.md`** — 75 lines, 9 anchors verified. Note the double
  blank line before `## Data Access (ADO.NET / SqlClient parameter typing)` at
  line 55-56; that is in the source.
- **`copilot.instructions.md`** — now 355 lines, 51 anchors verified across both
  batches. **My earlier report that this file was complete at 272 was wrong** —
  it was the end of the photo range, not the end of the file. Lines 273-355 have
  been appended and the index corrected.

## Transcription uncertainties (`contracts/schemas/*`)

**`fusion-decisions.schema.json` — the `authoringNote` is incomplete.** The photo
was taken with word wrap off and the string runs off the right screen edge at
*"…and most o"*. The captured file carries an explicit
`[TRUNCATED IN PHOTO - ...]` marker inside the string so the gap cannot be
mistaken for the real text, and the file still validates as JSON.

Everything else in that file is fully legible: the `fields` block, all three
`groundedBy` entries, and the assertions. **A re-shoot with `Alt+Z` (word wrap)
would recover the missing note text** — worth doing, since the other two
`authoringNote`s in this family turned out to be the most informative content in
their files.

The other two schemas (`executable-testcase-catalog`,
`fusion-control-point-inventory`) were captured complete — their notes wrapped on
screen and no text was lost.

## Transcription uncertainties (`copilot.instructions.md`)

None of substance. Word wrap was on for all five photos, so no text was lost off
the right edge; 39 heading and rule line numbers were spot-verified and the file
closes at 272 (editor shows 273). Two notes:

1. **Environment-variable names only.** The database-configuration section names
   six variables (`SqlServer__Server` … `SqlServer__TrustServerCertificate`).
   These are names appearing in the source, not values — no credential,
   hostname, or tenant identifier appears anywhere in this file, and none has
   been recorded.
2. **`.esproj`** in the naming law is read as the Visual Studio JavaScript
   project extension (`<AppName>.Web.Client.esproj`). The photo is legible and
   the extension is a real one, so this is not a guess, but it is the only
   unfamiliar file extension in the file and worth a glance on any future
   re-shoot.

## Transcription uncertainties (`AppMod-Process.instructions.md`, `appmod-phase-agent-contract.instructions.md`, `AppMod-Artifact-Contract.json` part 2)

**`AppMod-Process.instructions.md`** — none of substance. Word wrap was on for
all six photos, so nothing was lost off the right edge. 29 heading line numbers
were spot-verified and the file closes at 265. One reconstructed pairing: in the
Required Evidence Pack, the qualifiers *"when `browserSurfaceApplicability` is
`Required`"* and *"(the Step 13 visual-parity gate output)"* appeared one visual
row below their bullets because of camera keystone; they are recorded on lines
241 and 242 respectively, which is the only semantically coherent assignment (a
`Legacy-System-Analysis-Report` does not gate on browser applicability).

**`appmod-phase-agent-contract.instructions.md`** — none of substance. 16
anchors verified, content closes at 174 with three trailing blank lines (the
editor shows 178). The missing blank lines before headings at 52/139/160 and the
double blank at 167-168 are **faithful to the source**, not transcription slips
— the line-number arithmetic only closes at 174 if they are reproduced exactly.
Same for the blank line at 36 that splits the numbered rules list.

**`AppMod-Artifact-Contract.json`** — the vertical gap is closed (1-345, all 24
steps) but **the horizontal truncation is unchanged**. The last photo was shot
the same way as the first five, with word wrap off, so roughly 30 entries still
end in `[CUT]`. The `Alt+Z` re-shoot request stands; it is the only way to
recover the missing `consumedBySteps` and `note` tails. Steps 20-24 happen to be
mostly short lines, so the newly-captured range is largely intact — the losses
are concentrated in steps 3-14.

## Transcription uncertainties (`angular.instructions.md`, `appmod-agent-personality-baseline.instructions.md`, `AppMod-Artifact-Contract.json`)

**`angular.instructions.md`** — none of substance. Both photos were legible end
to end and the file closes at source line 67 (editor shows a blank 68). Nine
heading/fence line numbers were spot-verified. One formatting note: this file
places prose immediately adjacent to code fences with no blank line between them
(lines 27/28, 35/36, 44/45, 48/49). That is unusual but consistent throughout, and
the line-number arithmetic only closes at 67 if it is reproduced, so it is
transcribed as-is rather than normalized.

**`appmod-agent-personality-baseline.instructions.md`** — none. Twelve anchors
verified, file closes at 71. Note that lines 37-38, 44-45 and 46-47 are
hard-wrapped bullets (a 2-space continuation indent), not soft wraps; the gutter
numbering in the photos confirms they are separate source lines.

**`AppMod-Artifact-Contract.json`** — substantial, and structural rather than
incidental:

1. **Right-edge truncation.** The file was photographed with word wrap **off**.
   It is JSON with very long lines, so on most `{ "path": … }` entries the tail
   runs off the screen and is gone. Roughly 30 of the ~90 entries transcribed are
   cut. What is lost is usually the end of `consumedBySteps` and/or the end of
   `note`. Every affected line carries a `[CUT]` marker in
   `_wip/AppMod-Artifact-Contract-partial.md`.
   **Requested:** re-shoot with `Alt+Z` (Toggle Word Wrap) enabled.
2. **Keystone row-shift.** The photos were taken at an angle steep enough that
   the right half of each row appears offset by about one row from its left half.
   Path↔note pairings were therefore reconstructed *semantically* (e.g.
   `decisions.json` ↔ `fusion-decisions.schema.json`). Every pairing came out
   self-consistent, so confidence is high — but it is inference, not a direct read.
3. **Vertical incompleteness.** Lines 1-291 captured; the file continues (step
   19's `producedOutputs` array is still open at 291). Steps 20-24 are not yet
   photographed.
4. **One genuinely ambiguous path** — `characterization-test-planning.json`,
   recorded under `ignition-artifacts/` but possibly `portal/data/json/`.

## Transcription uncertainties (`agent-process-conformance.instructions.md`)

- Line alignment verified at 13 anchors — 46, 59, 61, 70, 74, 82, 88, 91, 98, 104, 110, 114, 120 —
  all matching. Content ends at 120; the editor shows blank lines through 122.
- **Source lines 71-73 are three consecutive blank lines** before `## Next-Step Contract`, where
  every other section break uses one. Preserved as photographed.
- Lines 48-57 and 61-70 are long single logical lines wrapping across several editor rows;
  reconstructed from wrap positions.
- No mojibake in this file.

## Structural facts added by `workstation-playwright-setup/SKILL.md`

A small, practical setup skill — 72 lines, and **the fourth file in the kit with correct step
numbering throughout** (Step 1 readiness, Step 3 legacy screenshot capture).

- **Scoped to the app client workspace**, not global: install Playwright into
  `src/<AppName>.Web.Client`, then install Chromium with the **workspace-local CLI**
  (`node .\node_modules\playwright\cli.js install chromium`) rather than `npx`.
- **The `npx` trap is documented with its cause**: "npx playwright install downloads a revision
  different from the runtime package … Cause: multiple Playwright versions in dependency tree."
  That is a genuinely common and hard-to-diagnose failure.
- **An optional probe** that validates the whole capture path end-to-end before Step 3 — headless
  Chromium, 1920×1080 viewport, `domcontentloaded`, full-page screenshot into
  `.modernization/portal/data/images/legacy-system-analysis/`, and a `PLAYWRIGHT_PROBE_OK`
  sentinel on success. The output path matches the legacy-reference location
  `visual-parity-gate` reads from.
- **A three-line Capture Policy Reminder** consistent with `screenshot-capture`'s stated
  mechanics: desktop viewport baselines, include modal/dialog states that belong to user
  workflows, suppress duplicates when two routes render equivalent visual output.

## ⚠ Findings in `workstation-playwright-setup/SKILL.md`

**1. The TLS workaround disables certificate validation entirely.**

```powershell
$env:NODE_TLS_REJECT_UNAUTHORIZED='0'
node .\node_modules\playwright\cli.js install chromium
Remove-Item Env:\NODE_TLS_REJECT_UNAUTHORIZED -ErrorAction SilentlyContinue
```

The file scopes it honestly ("Fix (process-local only)") and removes the variable immediately
afterwards, which is better than most write-ups. But `NODE_TLS_REJECT_UNAUTHORIZED=0` turns off
**all** certificate verification for that Node process, and the thing being downloaded during that
window is an executable browser binary from a CDN. On a single developer machine that is a
contained risk; distributed to a large group as the documented fix, it is a supply-chain exposure
repeated across every workstation.

The stated cause — "enterprise TLS chain blocks CDN download" — has a targeted fix that does not
weaken verification: point Node at the corporate root CA instead, e.g.
`$env:NODE_EXTRA_CA_CERTS='<path-to-corporate-ca.pem>'`, or configure the Playwright download
host/proxy. Worth changing before the kit is handed to a wide audience, and worth pairing with
whoever owns the corporate CA bundle so the path can be stated concretely.

**2. App-specific leakage — sixth instance.** The probe hard-codes
`http://localhost:56383/#table-details`, a port and route from one specific application, inside a
skill whose stated purpose is reusable workstation setup. Prior instances: prompt 17's
`LegacyConnectionStringProviderTests.cs`, the `EquipmentService .cs` filenames in
`REMAINING-POINTS.md`, `GetAutoCardEnrollEligible`/`PaymentsWebApi` in `fusion-g1-recognition.md`,
the five Spec Book types in `runtime-parity-checkpoint`, and the Kendo example set. A
`<AppName>`-style placeholder is used correctly elsewhere in this same file, so the fix is
mechanical.

**3. It is the third skill that assumes PowerShell without saying so** — every fenced block is
` ```powershell ` with `Push-Location`/`Pop-Location`/`$env:`/`Remove-Item`. Here that is
defensible (it is explicitly a Windows workstation setup skill), unlike
`fusion-ui-component-upgrade`, which uses PowerShell cmdlets in an otherwise portable validation
baseline.

## Transcription uncertainties (`workstation-playwright-setup/SKILL.md`)

- Line alignment verified at 21 anchors — 5, 7, 9, 11, 18, 20, 22, 24, 29, 31, 36, 38, 40, 46, 48,
  52, 56, 64, 68, 70, 72 — all matching. Content ends at 72; the editor shows line 73 blank.
- **Source line 42 is a single very long line** — the whole `node -e "…"` probe on one physical
  line, wrapping across four editor rows. Reconstructed from wrap positions; the port `56383` and
  the relative path `../../.modernization/portal/data/images/legacy-system-analysis/` are the
  least certain tokens.
- The first fenced block (source lines 24-27) closes without a `Pop-Location`, which is supplied
  at the end of the second block (line 33). Transcribed as photographed — the two blocks are one
  logical sequence.
- No mojibake in this file.

## Structural facts added by `visual-parity-gate/SKILL.md`

The Step 13 closeout gate — 101 lines, and **the third file in the kit with zero numbering
defects** (after `OpX-AppMod-P3-Review` and `step3-legacy-system-analysis/SKILL.md`). Every step
reference is correct under current numbering: Step 10 (apply), Step 13 (stabilize and gate),
Step 14 (entry discipline), and the Step 7 `LegacyCode_NETXX_Upgrade` workspace.

- **It composes rather than duplicates**, and says so:
  > This skill does not invent its own boot or capture machinery. It **composes** the two existing
  > skills … Keep this separation. Do not add a parallel boot path or a parallel screenshot path
  > here.

  It reuses `runtime-parity-checkpoint` for boot-observe-assert and `screenshot-capture` for
  capture mechanics. **This is the first evidence that `runtime-parity-checkpoint` is not an
  orphan** — a skill explicitly loads it.
- **It names the SCSS templates**, resolving the open question from the previous entry: the
  copy-start bundle "materializes the structure for all of the above … so Step 10 binds the
  extracted legacy values into a known structure instead of authoring it from scratch."
- **A stated definition of "done" for the foundation** that inverts the usual instinct:
  > "Looks like a clean modern app" is **not** the foundation target; "looks like the legacy app"
  > is.

  Five verified dimensions: pinned color scheme (independent of OS `prefers-color-scheme`),
  branded header/footer chrome, constrained inline filter/form controls, branded data grids at
  legacy density with the full column set, and preserved legacy navigation affordances (a side nav
  stays a side nav, "not a single dropdown").
- **The same evidence-integrity rule as `runtime-parity-checkpoint`**, applied to appearance: a
  report "written from build/scanner/HTTP signals, or from a prior session's screenshots restamped
  as current, is invalid evidence, not a pass." Colour scheme, header/footer background, primary
  button colour and form-control sizing are **enforced computed-style dimensions, not eyeball
  checks**.
- **Visual parity and field parity are explicitly separated**, and Step 13 requires both:
  > a route can pass palette/typography/chrome while a grid has silently dropped columns or a
  > control's handler is stubbed. Step 13 requires **both** — this visual gate `pass` **and** the
  > runtime-parity-checkpoint `fieldParity` roll-up `pass` — before Step 14 begins.
- **A practical dual-port answer to a real toolchain problem**: legacy and modern clients need
  different Node majors and `nvm` switches one active version per shell, so the file gives three
  workarounds (version-pinned Node per dev server, build the legacy client once and serve the
  static output, or containers) and then removes the need entirely — "the enforced comparison runs
  against the **legacy answer key captured during Discovery**, so the legacy app does not need to
  be running at gate time."
- **A fallback chain for the legacy reference**: live QA URL → verified local legacy runtime →
  the Step 7 `LegacyCode_NETXX_Upgrade` workspace ("its browser client is the same legacy UI, so it
  is a faithful side-by-side answer key") → captured reference screenshots + static contract values.
- **Two more concrete surfaces**: the static gate
  `/.github/scripts/parity/scan-styling-foundation.ps1` (colour scheme, style include paths, shared
  partials, grid column widths) and the canonical comparator
  `tests/frontend/visualParity/run-visual-parity.mjs` — with an explicit instruction to reuse it
  "rather than inventing a second comparator".
- **A three-value route verdict** (`pass` / `partial` / `fail`) with `partial` precisely defined —
  chrome and nav present and the screen recognizably legacy, but lower-priority style dimensions
  still drift.

## ⚠ Findings in `visual-parity-gate/SKILL.md`

**1. It uses the short artifact root throughout — consistent with its own templates.**
All contract, inventory and output paths are `.modernization/fusion-restructure/…`
(`ui-visual-contract.json`, `styling-foundation.json`, `inventory.json`, `ui-inventory.json`,
`visual-parity-report.json`). That matches `_variables.scss`, `architecture-structure/SKILL.md`
and prompt 21, and conflicts with `OpX-Fusion-Reviewer` and `browser-source-decomposition`. The
**short form now has five independent sources and a runnable consumer**, which makes it the
stronger candidate if the fork is resolved by majority rather than by decree.

**2. `screenshot-capture/SKILL.md` is named as a required composition target but has not been
transcribed.** It is one of two skills this gate depends on. Worth capturing, since a
"reuse the existing capture path" instruction is only enforceable if that path is documented.

**3. No defects found in the step numbering, the internal cross-references, or the artifact
schema.** Recorded explicitly because it is rare: this is a clean file.

## Transcription uncertainties (`visual-parity-gate/SKILL.md`)

- Line alignment verified at 25 anchors — 5, 7, 9, 11, 16, 18, 20, 22, 24, 26, 28, 30, 36, 38, 40,
  48, 58, 65, 67, 81, 83, 92, 94, 99, 101 — all matching. Content ends at 101; the editor shows
  line 102 blank.
- Source line 95 is one very long logical line spanning many editor rows; a clause was initially
  dropped in transcription and has been restored ("…is distinct from **field parity (does it
  expose the same fields, columns, and controls as legacy): a route can pass palette/typography/
  chrome while a grid has silently dropped columns or a** control's handler is stubbed").
  Verify this line against source if precision matters.
- The `description` frontmatter spans four editor rows; reconstructed from wrap positions.
- No mojibake in this file.

## Structural facts added by `visual-parity-gate/references/fusion-client-foundation-templates/`

Three SCSS **copy-start templates** — the concrete mechanism behind a rule asserted repeatedly
across the kit but never previously shown: *"the modern shell must inherit the legacy visual
language **by construction**."* Until now that was a principle; these are the files that
implement it.

- **`_variables.scss` (37 lines)** — the single binding point for the legacy palette, with an
  explicit instruction to replace the defaults:
  > BIND THESE to the Step 3/5 legacy visual contract:
  > `.modernization/fusion-restructure/styling-foundation.json`
  > `themePalette.headerBg / brandPrimary => $brand-primary`
  > `themePalette.neutral.text / .border => $text-color / $border-color`
  > The default below is the **Fusion DE blue**; REPLACE it with the legacy value when the legacy
  > brand differs.

  Tokens: `$brand-primary: #0072ce` (+ hover `#0664b8`, active `#004d8a`), `$header-bg/$header-fg`,
  `$text-color: #555f67`, `$border-color: #b1bdc9`, `$grid-header-bg/-fg`,
  `$filter-bar-bg: #f5f6f6`, and a compact field scale `$field-width: 240px` /
  `$field-width-narrow: 140px` "so filter controls are not full-bleed".
  **Note the step numbers are correct** — "Step 3/5 legacy visual contract" matches Legacy System
  Analysis (3) and Modernization Solution Design (5) under current numbering.
- **`_collection-grid.scss` (59 lines)** — layout for filterable data-grid pages, with a stated
  load-order rule: "**Layout only** - no Fusion-theme overrides here, so it is safe to load
  **before** the theme. Brand/theme overrides … live in `styles.scss` **AFTER** the theme include
  where override order is correct." Constrains `fusion-textbox`, `fusion-dropdown`, `.k-textbox`,
  `.k-dropdownlist`, `input`, `select` to the legacy field widths.
- **`_legacy-bootstrap-baseline.scss` (101 lines)** — the diagnosis is the valuable part:
  > `@fusion/theme` does **NOT** provide these classes, so without this baseline the ported markup
  > renders as **unstyled stacked blocks** and the Fusion form controls **stretch full-bleed**
  > across the page.

  Re-baselines the Bootstrap-3/4 subset legacy templates actually emit — `.row`, `.col-*`,
  `.mr-*`/`.ml-*`/`.mb-*`, `.text-right`, `.align-self-end`, `.collection-filter-area`,
  `.form-group` (with a `.short-field` variant), `.grid-filter` / `.inline-labels`, and
  `.btn.btn-link`. With a scope rule: extend it "with any additional legacy utility classes the
  templates actually emit (**harvest them from the markup**), not a full Bootstrap import", and a
  kit-level rule that "**any route that re-emits legacy Bootstrap utility classes must
  re-baseline them here**."
- All three are wired through **`angular.json` `stylePreprocessorOptions.includePaths`**
  (`src/assets/scss`) and consumed globally from `styles.scss` via `@use`, "so the legacy palette
  is bound once and consumed everywhere instead of being re-hard-coded per file."

### New surfaces revealed by the directory listing

The file-tree photo shows `.github/skills/` contents not previously known:

| Path | Status |
|---|---|
| `skills/test-quality-standards/SKILL.md` | **new skill**, not transcribed |
| `skills/workstation-playwright-setup/` | **new skill**, not transcribed |
| `skills/visual-parity-gate/SKILL.md` | not transcribed (references now done) |
| `.github/templates/` | confirms the folder `appmod-compliance-review` and `architecture-structure` both reference |
| `.github/constitution.md` | **new top-level file** — *(this note is SUPERSEDED: constitution.md is now transcribed and is referenced by `copilot.instructions.md`, `modernization-starter-boundaries`, and the cheat sheet)* |
| `.github/Copilot-Customization-Cheat-Sheet.md` | **new top-level file** |

`constitution.md` is the notable one: a root-level document with a name implying kit-wide
governing rules, which **no prompt, agent, or skill transcribed so far mentions**.

## ⚠ Findings in the `fusion-client-foundation-templates`

**1. They bind to the short artifact root.** `_variables.scss` points at
`.modernization/fusion-restructure/styling-foundation.json` — no `ignition-artifacts/modernize/`
prefix. That matches `architecture-structure/SKILL.md` and prompt 21, and conflicts with
`OpX-Fusion-Reviewer` and `browser-source-decomposition`, which use the long form for the same
artifact. These templates are *executable* (a developer copies them and follows the path), so the
fork now has a concrete consumer rather than just prose.

**2. A default brand colour ships in a template that says to replace it.** `$brand-primary: #0072ce`
is the Fusion DE blue, and the comment does say REPLACE. But a copy-start file with a working
default is exactly the kind of thing that survives to production unchanged — the same failure mode
as the starter-sample-styling anti-pattern the kit warns about elsewhere. Worth a gate check that
`$brand-primary` no longer equals the shipped default when `styling-foundation.json` records a
different legacy brand.

**3. Nothing transcribed so far references `visual-parity-gate`'s templates by path.**
`architecture-structure/SKILL.md` names `/.github/skills/visual-parity-gate/SKILL.md` as the gate
the modern shell must pass, but no file points at
`references/fusion-client-foundation-templates/*.scss`.
> **RESOLVED by `visual-parity-gate/SKILL.md`.** Its source line 38 names the bundle directly:
> "the copy-start bundle at `references/fusion-client-foundation-templates/` (in this skill)
> materializes the structure for all of the above — scheme pin, `includePaths`, the shared
> partials, the header-chrome override, and grid sizing — so Step 10 binds the extracted legacy
> values into a known structure instead of authoring it from scratch." Not orphaned.

## Transcription uncertainties (`fusion-client-foundation-templates`)

- Line counts match the source exactly: `_variables.scss` 37 (blank to 38), `_collection-grid.scss`
  59 (blank to 60), `_legacy-bootstrap-baseline.scss` 101 (blank to 102).
- Hex colours were read at magnification and are legible, but `#0664b8`, `#004d8a`, `#555f67`,
  `#b1bdc9` and `#f5f6f6` are the least certain tokens; the VS Code colour swatches confirm they
  parse as valid colours but not their exact digits.
- The `&.short-field` selector list in `_legacy-bootstrap-baseline.scss` spans source lines 63-65;
  reconstructed across a photo boundary (photo 1 ends at 64, photo 2 begins at 46).
- No mojibake in any of the three files.

## Structural facts added by `step3-legacy-system-analysis/SKILL.md`

**The best-structured skill in the kit** — 73 lines, and it demonstrates the split every oversized
skill should copy: a short entry point that delegates all detail to `references/`.

- **A stated ownership rule that keeps prompts thin**:
  > This skill owns the contract; **do not re-expand schema inline in prompts.**
  Combined with the schema contract's own "Keep the prompt thin and deterministic", this is the
  kit's own answer to its context-cost problem, applied in exactly one place.
- **Three entry points named together**: the prompt
  (`03-P1-legacy-system-analysis.prompt.md`), the agent (`OpX-AppMod-P1-Discovery`), and the gate
  script (`.github/scripts/P1-Discovery/03-P1-legacy-system-analysis-gate.ps1`). No other skill
  names its whole triad.
- **Deterministic modality detection** before any artifact enforcement, keyed on source markers
  (`.cshtml`, `angular.json`, `package.json`, API-only controllers): `api-only`, `mvc`, `spa`,
  `hybrid`.
- **A 7×4 applicability matrix** so `api-only` apps are not failed for missing browser artifacts —
  Artifacts 2, 3, 5, 6 and 7 are `X` for `api-only` and required everywhere else.
- **Four gate validations** and **three mandatory gate statuses**: `scanCoverageStatus`,
  `traceabilityStatus`, `planningReadinessStatus`. "A `Blocked` status prevents progression to
  **Step 4**" — correct under current numbering.
- **Confirms the pipeline length again**: `AppMod-Process.instructions.md` is described as
  "**24-step** workflow context".
- **Names `AppMod-Step-Contract.json`** as "QA workflow mapping and step ownership" — the
  clearest statement yet of what that routing file contains.
- **A fourth skill-identity convention**: no frontmatter at all, with `**Skill ID:**` declared in
  the body instead. (The others: `appmod-*` full frontmatter with `source`/`confidence`;
  `architecture-structure`/`browser-source-decomposition` with `name`/`description` frontmatter;
  `dominion-requirements` with `version`.)

## ⚠ Findings in `step3-legacy-system-analysis/SKILL.md`

**1. The modality values and the matrix columns do not match.**
Modality Detection defines four values — `api-only`, **`mvc`**, `spa`, `hybrid`. The Applicability
Matrix columns are — `browser-led`, `api-only`, `spa`, `hybrid`. **`mvc` and `browser-led` are
used for the same thing but never equated anywhere in the file.**

This matters because the matrix is the enforcement table: a gate that detects modality `mvc` and
then looks up its column finds no match, and a model reading the file has to infer that
`browser-led` means `mvc`. Either rename the column to `mvc` or state the alias. Small edit,
but it sits directly on the path between deterministic detection and deterministic enforcement.

**2. It is one of only two skills in the kit whose prompt, agent, and gate script are all named
in one place** — and the only one where that triad is a first-class section. Worth propagating:
the recurring difficulty in this transcription has been working out which prompt owns which agent
owns which script, and this file answers all three in five lines.

## Transcription uncertainties (`step3-legacy-system-analysis/SKILL.md`)

- Line alignment verified at 22 anchors — 1, 3, 5, 7, 9, 13, 15, 17, 25, 27, 36, 39, 45, 47, 53,
  55, 57, 59, 61, 69, 71, 73 — all matching. Content ends at 73; the editor shows blank lines
  through 75.
- The applicability matrix uses `✓` and `X` (a capital letter X, not `✗`); transcribed as
  photographed.
- Markdown link targets are relative (`../../prompts/…`, `../../instructions/…`,
  `references/…`); preserved exactly.
- The title and several bullets use em dashes (`—`); genuine characters, no escape sequences in
  this file.
- No mojibake in this file.

## Structural facts added by `step3-legacy-system-analysis/references/Step3-Artifact-Schema-Contract.md`

The versioned schema behind Step 3, referenced by prompt 03's frontmatter. 143 lines, and the
**second versioned artifact in the kit** after `dominion-requirements` (`version: "2.0"`).

- **`step3ArtifactSchemaContractVersion: 1.0.1`**, with an explicit pairing rule: "This version
  must match `.github/prompts/03-P1-legacy-system-analysis.prompt.md`." Prompt 03 carries the same
  string, so the two are pinned to each other — the only two-sided version pin found in the kit.
- **Stated purpose is prompt slimming**: "Single owned schema reference … Keep
  `03-P1-legacy-system-analysis.prompt.md` **thin and deterministic**." That is the extraction
  pattern the oversized skills (`dominion-requirements` ~1,500 lines, `architecture-structure`
  ~800) should follow.
- **Seven artifacts defined**, three as standalone files and four as sections embedded in other
  files:
  | # | Artifact | Location |
  |---|---|---|
  | 1 | `service-behavior-inventory.json` | standalone |
  | 2 | `interaction-wiring-inventory.json` | standalone |
  | 3 | `workflow-trace-inventory.json` | standalone |
  | 4 | `apiEndpointCatalog` | in `inventory.json` |
  | 5 | `uiControlClassification` | in `inventory.json` |
  | 6 | `screenshotCoverageMatrix` | in `legacy-system-analysis-report.json` |
  | 7 | `fusionPrimitiveCoverageCensus` | in `inventory.json` |
- **An anti-pollution mechanism with a named failure mode.** Every entry in Artifacts 1-3 needs a
  `legacyEvidence` object whose `filePath` must resolve to a real file under `LegacyCode/` or
  `src/`. Evidence pointing at `coverage/`, `node_modules/`, `bin/`, `obj/`, or `dist/` "will
  cause the gate to classify the inventory as **polluted**". Unresolvable evidence must be marked
  `wiringStatus: cannot-locate` rather than omitted — so a gap is recorded, never silently
  dropped.
- **A backward-compatibility rule that refuses to be ambiguous**: `file` "may be included for
  backward compatibility but **DOES NOT substitute for** `filePath`."
- **DB typing hints that exist to prevent a specific downstream bug**: `dbParameterTypeHints[]`
  and `dbResultColumnTypeHints[]` (with `sqlTypeHint`, `targetClrTypeHint`, `evidence`), whose
  stated purpose is "so Step 8 and Step 9 do not infer incorrect row model types" and to "reduce
  **Dapper constructor materialization failures** caused by SQL/CLR type mismatches." That is the
  exact failure `appmod-backend-dotnet` lists as an anti-pattern — Step 3 is being asked to
  capture the evidence that prevents it six steps later.
- **`effectClass` and `wiringStatus` finally have a home.** `runtime-parity-checkpoint` asserts
  against `interaction-wiring-inventory.json`; this contract is what defines its shape
  (`controlId`, `surface`, `label`, `controlKind`, `triggerEvent`, `wiringKind`, `target`,
  `sideEffects`, `authGate`, `legacyEvidence`, `wiringStatus`).
- **Eight screenshot states enumerated**: `idle`, `populated`, `empty`, `validationError`,
  `postAction`, `dialogOpen`, `focus`, `authStateVariant` — with four capture statuses and a
  mandatory `blockerReason` when not captured.
- **A Fusion gap census with four states**: `covered`, `needsWrapperExtension`,
  `needsFusionFeatureRequest`, `noFusionEquivalent`, each stamped `mcpVerifiedUtc`. This is the
  Discovery-side input to D-003's wrap policy.
- **A new script path family**: `.github/scripts/P1-Discovery/03-P1-legacy-system-analysis-gate.ps1`
  named as "the executable enforcement path", with this file as "the canonical human-readable
  schema contract". Clean separation of executable gate from readable spec.

## ⚠ Findings in `Step3-Artifact-Schema-Contract.md`

**1. It resolves a long-standing prompt 03 uncertainty — and it was not a defect.**
Prompt 03's Required Artifacts table has 10 rows while its prose says "each of the 7 artifacts".
This contract defines exactly seven (`## Artifact 1` … `## Artifact 7`), so the prose is correct
and refers to the schema-contract grouping; the 10-row table is a different, larger enumeration
of Step 3 outputs. The earlier note is marked resolved.

**2. Four consecutive blank lines inside the document** (source lines 14-17, between the Scope
bullets and `## Shared field definitions`). Every other section break in the file uses one.
Cosmetic, preserved as photographed, but it reads like a deleted section.

**3. This is the model the rest of the kit should copy — and only one other file does.**
Two versioned artifacts exist in the whole kit (this and `dominion-requirements`), and this is the
only one with a *two-sided* pin ("this version must match the prompt"). Given that the hackathon
risk is 40 divergent copies of the kit, a version field plus a stated pairing rule is the cheapest
drift detector available, and six of the seven skill families have neither.

## Transcription uncertainties (`Step3-Artifact-Schema-Contract.md`)

- Line alignment verified at 23 anchors — 1, 3, 7, 11, 18, 20, 23, 33, 39, 54, 61, 65, 79, 81,
  100, 102, 111, 113, 123, 130, 132, 141, 143 — all matching. Content ends at 143; the editor
  shows blank lines through 145.
- The top-level section labels (`Schema Contract Version`, `Purpose`, `Scope`,
  `Validation expectation`) are plain text, not markdown headings — only the artifact sections use
  `##`. Preserved as photographed.
- Line 21 wraps across three editor rows; reconstructed from wrap positions.
- No mojibake in this file.

## Structural facts added by `runtime-parity-checkpoint/SKILL.md`

**The strongest anti-false-pass doctrine in the kit.** 91 lines, reusable across steps, and the
only skill that exists purely to stop a step being marked done on evidence that never observed
the running app.

- **Ten named failure modes that static scans cannot see**, each with the reason a normal check
  passes anyway:
  *configured but not rendering* · *present but hidden* · *rendered but collapsed* (fewer or more
  generic columns than legacy) · *present but inert* (handler is an empty body / `TODO` /
  permanently `disabled`) · *filter wired but ineffective* (row set identical before and after) ·
  *sibling lists return identical data* · *mutate fires a modal but no API call follows* (the
  "placeholder-modal pattern") · *same label, different control type* (legacy dropdown re-created
  as free-text) · *verified by proxy, not by render* · *deferred instead of driven* on
  parameterized detail routes.
- **A hard rule against status proxies**, stated as its own section:
  > a clean client build, a parity-scanner `majorGaps=0`, an SPA route returning HTTP 200, or a
  > `curl`/unauthenticated probe returning `401`/`404`/`500` … are necessary but never sufficient
  > and must never be recorded as a `pass` on their own.

  An unauthenticated `401` "proves only that the route is **registered and protected**". Every
  data-binding verdict must come from an **authenticated session** observing **real rows in the
  DOM** while the backend log is watched. If that is impossible, record `blocked`/`unverified`
  and keep the step open — "do not write `pass` from assumption."
- **`effectClass`-typed behavioral assertions** read from `interaction-wiring-inventory.json`:
  `filter` (assert `rowsChanged`), `distinct-data` (assert no two sibling sections share a first
  row), `mutate` (assert a real POST/PUT/DELETE/PATCH is observed on the network tab or backend
  log — explicitly *without* submitting destructive operations, using preflight/OPTIONS or the
  incoming-request log entry).
- **Both sides of the request are watched**: integrated browser as primary (console errors, failed
  requests, DOM presence *and visibility*), backend log stream as secondary (unhandled exceptions
  and 500s the browser only sees as an opaque error).
- **A guard-redirect audit**: any `canActivate` denial redirect pointing at an undeclared route
  causes "a silent fallthrough to the wildcard route — typically the app home — which hides the
  access-denied condition entirely."
- **A detailed evidence schema** (`runtime-parity-checkpoint.json`) with per-route entries, eight
  roll-up parities, and `waivers[]` requiring `{ item, reason, owningStep }`. `overall` is `pass`
  only when every parity passes, every filter shows `rowsChanged: true`, every mutate shows
  `networkCallObserved: true`, and error counts are zero or explicitly waived.
- **Two new scripts**: `.github/skills/runtime-parity-checkpoint/scripts/Start-SrcRuntime.ps1`
  (starts API + client with combined stdout/stderr to a timestamped log, writes
  `runtime-endpoints.json`) and `Stop-SrcRuntime.ps1`. Second skill with a `scripts/` subfolder.
- **A named VS Code task**: `src: start api + client`.
- It supplies the honest-pending vocabulary other steps use — e.g. Step 12's
  `liveDataRenderStatus: UnverifiedPendingAuth`.

## ⚠ Findings in `runtime-parity-checkpoint/SKILL.md`

**1. The Procedure has two step 5s.** Source lines 67 and 68 both begin `5.` — "Drive
parameterized and detail routes with a real record" and "Guard redirect target audit" — followed
by `6.` and `7.`. So the numbered procedure runs 1, 2, 3, 4, 5, 5, 6, 7. An agent asked to "run
step 5" has two different jobs to choose from.

**2. A literal `\u2014` escape sequence leaked into the prose.** Source line 82 reads
"…carried-forward prior observation is invalid `\u2014` set that route…". A JSON-escaped em dash
was written into markdown and never decoded. Preserved verbatim in the transcription.

**3. Three different artifact roots in one file.**
`.modernization/fusion-restructure/…` (inventory and the checkpoint output — short form, no
`ignition-artifacts/modernize/` prefix), `.modernization/legacy-analysis/interaction-wiring-inventory.json`
(**a root not seen in any other file**), and `.modernization/artifacts/runtime-logs/`. Elsewhere
the interaction-wiring inventory lives under `.modernization/ignition-artifacts/discovery/`. This
is now the widest artifact-root spread found in a single file.

**4. App-specific leakage — fifth instance.** "five Spec Book types: Foundation, Pole Calc, Rehab,
Transmission, Antenna" is real domain data from one utility application, used as the worked
example for sibling-list distinctness. The rule is general; the example is not.

**5. Nothing transcribed so far references this skill.** No prompt and no agent names
`runtime-parity-checkpoint`, yet it describes itself as "the standard way to secure a visible
checkpoint" and is written to be invoked by any step that changes `src/`. If skills load only by
explicit reference rather than by convention, the kit's strongest verification gate is never
reached. Third possible orphan after `appmod-backend-dotnet` and `diagnose`.

## Transcription uncertainties (`runtime-parity-checkpoint/SKILL.md`)

- Line alignment verified at 23 anchors — 5, 7, 9, 11, 13, 24, 26, 33, 35, 37, 46, 48, 59, 61,
  67, 68, 72, 74, 81, 83, 88, 90, 91 — all matching. Content ends at 91.
- The file is heavily hard-wrapped with very long logical lines; the `routesChecked` schema (line
  77) and the `overall` rule (line 81) each span many editor rows and were reconstructed from
  wrap positions.
- Em dashes are genuine `—` characters throughout **except** the one literal `\u2014` at line 82,
  preserved as-is.
- No mojibake in this file.

## Structural facts added by `fusion-ui-component-upgrade/SKILL.md`

The method behind `OpX-fusion-ui-component-upgrade.agent.md` — 239 lines, the deliberate
primitive-adoption phase that runs after the frontend move, platform integration, and shell
stabilization are already done.

- **A tight scope fence.** Five explicit exclusions: the initial `LegacyCode/` → `src/` move,
  client bootstrap (`main.ts` / `app.config.ts` / `fusion.config*.ts`) and auth ownership,
  protected API transport and bearer-token wiring, shell stabilization and CSS rescue, and broad
  design/Figma polish. Plus six trigger phrases for when it *does* apply.
- **A seven-step slice model with validation wired into the loop**: choose one route → classify
  by primitive family → read the local Fusion contract before editing → smallest route-local
  change → **immediately run the client build** → repair only the same slice if it fails →
  update artifacts *only after* the build passes. "Do not batch unrelated routes into one edit
  cycle."
- **Deterministic task selection, no operator prompt**: "Do not ask the operator to choose the
  next route when `ui-fusion-map.json` is current." Six-step derivation from `completedTaskIds`,
  `taskGraph`, `automationPhases`, and `dependencies` — plus "Do not hardcode task IDs from prior
  runs or app-specific examples."
- **Within-route risk ordering** (lower-risk first): read-heavy grid → route-local filters and
  actions → inline/dialog editors → high-risk selection/bulk/split-workspace → layout and panel
  cleanup last.
- **Seven primitive-family rules with named components**: `FusionDataGridBasicComponent`,
  `FusionTextboxComponent`, `FusionDropdownComponent`, `FusionNumberComponent`,
  `FusionCheckboxComponent`, `FusionDatePickerComponent`, `FusionSuggestionTextboxComponent`,
  `FusionAutocompleteComponent`, `FusionButtonToggleGroupComponent`. The suggestion-vs-autocomplete
  distinction is stated precisely: suggestion for "free typing with suggestion assistance",
  autocomplete "only when the route is better expressed as a structured lookup choice".
- **Two npm verification scripts not seen elsewhere**: `npm run verify:fusion-ui` (refreshes the
  component-level swap report from current source) and `npm run verify:fusion-ui:complete`
  (closure check).
- **A green build is explicitly not sufficient**: "If a route throws a browser-console error
  during this smoke, do not mark the UI slice complete even if `npm run build` is green." Any
  route still using a temporary bridge family is a *mandatory* runtime smoke candidate.
- **A shell-drift escape hatch**: if a route's page title, mode toggle row, top action bar, or
  first filter band is hidden by fixed-header overlap or shell spacing drift, **stop** and route
  the work back through `Stabilize Frontend In Fusion Shell` rather than continuing.
- **An eight-point Done Definition**, including "no unrelated route was changed as part of the
  slice" and closure that "explicitly records any remaining temporary bridges instead of silently
  counting them as done".
- Names a new source root for API confirmation:
  `Framework/src/node/angular/projects/ngx-fusion/**`.

## ⚠ Findings in `fusion-ui-component-upgrade/SKILL.md`

**1. The skill and its own agent disagree about which step they are — and the skill disagrees
with itself.**
`OpX-fusion-ui-component-upgrade.agent.md` is on **current** numbering throughout ("Runs the
Step 15 Fusion UI Integration and Step 16 Next Fusion UI Upgrade Slice lane", "the step-14 UI
inventory"). This SKILL.md mixes both:

| Line | Text | Verdict |
|---|---|---|
| 16 | "executing restructure **Step 17**, `Apply Fusion UI Integration`" | **stale** (+2) — Fusion UI Integration is Step 15 |
| 89 | "report that **step-15** work is exhausted and the restructure workflow should move to **Step 17**" | **correct** |
| 218 | "record that **step-17** work is exhausted and **Step 19** is the next workflow gate" | **stale** (+2) |
| 239 | "**step-15** closure uses `npm run verify:fusion-ui:complete`" | **correct** |

Lines 89 and 218 describe **the same condition** — no eligible tasks remain — with step numbers
two apart. So the file contradicts itself about both its own step number and its successor, and
the agent that loads it is on the other numbering again. This is the same per-line update pattern
seen in prompt 21 and `OpX-AppMod-P2-Modernize`, and here it is unusually consequential: an agent
reading line 218 will hand off to Step 19 (Final Fusion Restructure Review) and skip Steps 17 and
18 entirely.

**2. The `description` frontmatter repeats the stale Step 17 reference**, so the wrong number is
also what a skill-picker surfaces.

**3. A PowerShell-only validation baseline in an otherwise portable skill.**
`Push-Location 'src/<AppName>.Web.Client'; npm run build; Pop-Location` — `Push-Location`/`Pop-Location`
are PowerShell cmdlets. Every other validation instruction in the file is a bare `npm run …`.
Minor, but it is the fourth file in the kit to assume PowerShell without saying so.

## Transcription uncertainties (`fusion-ui-component-upgrade/SKILL.md`)

- Line alignment verified at 28 anchors — 6, 12, 16, 31, 43, 67, 78, 89, 93, 99, 115, 129, 135,
  137, 144, 150, 156, 161, 166, 171, 177, 195, 205, 218, 220, 229, 239 — all matching. Content
  ends at 239; the editor shows blank lines through 244.
- The `description` is a quoted YAML string spanning four editor rows; reconstructed from wrap
  positions.
- No mojibake in this file.

## Structural facts added by the two remaining `fusion-g1-to-g2-modernization` references

`g1-to-g2-modernization-playbook.md` (86 lines) is the per-slice conversion checklist;
`knockout-modernization-cheatsheet.md` (59 lines) is the Knockout-concepts primer.

### `g1-to-g2-modernization-playbook.md`

- **A six-stage page-slice checklist**: Capture The Legacy Surface → Model The Destination
  Structure → Translate Control Families → Replace Service Globals → Preserve Parity-Critical
  Behavior → Harden The Slice.
- **An eight-item parity-critical list that must survive before a slice is "complete"**:
  busy-state transitions, validation and save blocking, conditional visibility and enablement,
  default values and prepopulation, route/query parameter behavior, modal or drawer open/close,
  table filtering/sorting/paging/selection, and role- or auth-based visibility. This is the most
  concrete definition of "parity" anywhere in the kit.
- **Service-global replacement map**: `$data` → typed Angular services, `$navigation` → Angular
  router-driven flows, `$dialog` → Fusion dialog services, `$toastr` → Fusion messaging,
  `$event` → explicit component/service boundaries.
- **`## Escalate As Unknown Instead Of Guessing`** — five named triggers for recording
  `unknown` rather than inventing: no confirmed replacement control, unclear `$data` payload or
  caching semantics, hidden `$event`/global-helper behavior, third-party widget behavior wrapped
  inside a Fusion control, and unclear ownership between component / shared service / app shell.
  Third anti-hallucination surface in this one skill.
- **Capture includes hidden state**: "tabs, drawers, expanders, validation errors, and
  confirmation paths" — the states a screenshot-based inventory misses.

### `knockout-modernization-cheatsheet.md`

- A compact Knockout primer: observables, bindings, view models, computed observables, binding
  context; the common binding list; Knockout-Validation usage
  (`myField.extend({ required: true, minLength: 3 })`, `validationMessage`, `ko.validation.init`).
- Six modernization tips, including "**Dispose**: Clean up subscriptions in modern component
  lifecycles."

## ⚠ Findings in the two references

**1. The playbook settles the Okta wiring conflict — 3 to 1 against `fusion-auth-standards.md`.**
Its `## Confirmed Current G2 Starter Signals` section names the actual destination:

```
- Angular 20
- `@fusion/ngx-fusion`
- `@fusion/ngx-fusion-auth-oauth-okta`
- `provideNgxFusion()`
- `provideNgxFusionAuthOAuthOkta()`
- Fusion config and route tokens registered in `app.config.ts`
```

plus "Prefer `provideNgxFusionAuthOAuthOkta()` for final-state auth wiring", "ensure config comes
from `FusionConfig`", and "ensure HTTP traffic follows the starter's provider and interceptor
model". That is **identical to `appmod-fusion-target`** and directly contradicts
`fusion-auth-standards.md`, which presents a hand-written `AddAuthentication(...).AddJwtBearer(...)`
backend stack plus an `OktaAuthGuard` and a hand-rolled bearer `HttpInterceptor` as "Fusion
pattern (use this)".

Tally across the kit:
- **provider-based Fusion Okta**: `appmod-fusion-target`, this playbook (and
  `dominion-requirements/SKILL.md` forbids "a parallel generic `AddJwtBearer` stack") — **3**
- **hand-written `AddJwtBearer` + custom guard/interceptor**: `fusion-auth-standards.md` — **1**

`fusion-auth-standards.md` is the outlier and should be rewritten to the provider model. That
converts the kit's most dangerous open conflict into a single-file edit.

**2. Angular 20 confirmed again — the odd-major references are now clearly the errors.**
`- Angular 20` appears in the playbook's confirmed-starter-signals list. Running tally:
**20** in prompt 02, `fusion-g1-recognition.md`, and this playbook; **20+** in prompt 24;
**19+** in `Ultimate-AppMod-Ignition`; **21+** in `dominion-requirements/SKILL.md`. Three
independent files state 20, and prompt 02's even-major policy rules out both 19 and 21.

**3. The Knockout cheatsheet's only worked example targets React, not Angular.**
`## Example Migration (Knockout → React)` shows `useState` hooks and JSX. The Modernization Tips
lead with "state hooks (React), refs (Vue), or **services (Angular)**" — Angular listed third —
and the validation tip names "Formik, Vuelidate, etc.", both React/Vue libraries, with no Angular
Reactive Forms mention (which `fusion-g1-recognition.md` *does* name correctly).

The Ignition Kit has exactly one client target: Angular 20. A G1 migration agent that loads this
reference gets React idioms as its only concrete before/after. The prose is generic enough to be
defensible; the worked example is not, and worked examples anchor behavior more strongly than
prose. Rewriting the example as Knockout → Angular 20 signals is a contained fix.

## Transcription uncertainties (the two references)

- Playbook: 13 anchors verified (1, 5, 13, 15, 22, 30, 37, 45, 58, 65, 69, 78, 86), all matching;
  content ends at 86.
- Cheatsheet: 11 anchors verified (1, 5, 8, 15, 19, 25, 33, 38, 45, 54, 59), all matching;
  content ends at 59, editor shows line 60 blank.
- The cheatsheet's heading and one bullet use Unicode arrows (`Knockout → React`,
  `Bindings → JSX/Template Syntax`); transcribed as the arrow character, matching the source.
- The cheatsheet has **no blank line** between the closing fence of one code block and the opening
  of the next (source lines 38/39 and 45/46); preserved as photographed.
- No mojibake in either file.

## Structural facts added by `fusion-g1-to-g2-modernization/references/fusion-g1-recognition.md`

The Fusion G1 recognition reference — 744 lines, and the only file in the kit **deliberately
written to be portable**: "so it can be copied into other solutions **without assuming access to
any specific repo folder structure or internal documentation site**."

- **A `references/` subfolder pattern.** `fusion-g1-to-g2-modernization/` holds `SKILL.md` plus
  `references/` with three files (`fusion-g1-recognition.md`,
  `g1-to-g2-modernization-playbook.md`, `knockout-modernization-cheatsheet.md`). Second skill
  with this shape after `step3-legacy-system-analysis`.
- **A hallucination guard as the file's headline rule**:
  > ## Non-negotiable rule
  > **Do not invent Fusion APIs.** … If you can't confirm a Fusion control/service/method in the
  > target solution (via its own docs, code, or shipped client bundles), treat it as **unknown**
  > and ask for developer context.
- **Fusion G1 defined precisely**: KnockoutJS bindings, RequireJS (AMD) modules, Durandal-style
  lifecycle hooks, and **jQuery Deferred rather than native Promises**. Plus the third-party
  stack: jQuery + jQuery UI, KnockoutJS, RequireJS, Durandal, **Kendo UI**, DataTables,
  moment.js, toastr, SignalR v2, ArcGIS JavaScript API.
- **27 `<fusion-*>` controls catalogued A-Z**, each with an HTML example and matching KO
  view-model code: alertbox, appleheader, chart, chartjs, checkbox, checkboxgroup, container,
  currency, datatable, datepicker, dropdown, esrimap, expander, kendogrid, linkexpander, list,
  mfa-verify, radioexpander, radiogroup, slideout, stepindicator, textarea, textbox, timepicker,
  toggle, toolbar, upload — plus six child elements. This is what makes the "don't invent APIs"
  rule enforceable.
- **11 `$` services documented A-Z**: `$cache`, `$config`, `$data`, `$dialog`, `$event`, `$log`,
  `$navigation`, `$perfLogScope`, `$signalR`, `$toastr`, `$utility` — with signatures.
- **The attribute-syntax convention**, which is easy to get wrong: string literals are
  double-wrapped (`labelText="'Name'"`), observables are bare symbol names (`value="m.name"`),
  booleans are bare (`true`/`false`), and complex objects should reference a view-model property.
- **Five practical modernization rules**, led by "**Stop the bleeding first:** replace jQuery
  Deferred with native Promise wrappers at module boundaries."
- **KO teardown is called out explicitly**: legacy pages rely on screen lifetime, modern
  components need `sub.dispose()`.
- **Binding-context rules to preserve**: `$root`, `$parent`, `$parents[n]`, `$data`, `$index`
  "can materially affect behavior in nested templates."
- Confirms the Angular target as **20** ("typically to **Angular 20 + .NET 10**").

## ⚠ Findings in `fusion-g1-recognition.md`

**1. The file breaks its own non-negotiable rule five times — its examples call methods it never
documents.**
This is the file that says "Do not invent Fusion APIs… treat it as unknown." Yet:

| Service | Documented methods | Method used in the example |
|---|---|---|
| `$cache` | `resetCache()` | `$cache.reset()` |
| `$toastr` | warning, success, error, remove, clear | `$toastr.info("Heads up")` |
| `$utility` | `tryParseBool` | `$utility.tryParseInt("42")` |
| `$utility` | (not listed) | `$utility.combineUrl("/api", "users")` |
| `$utility` | (not listed) | `$utility.focusNextInput()` |

An agent copying the examples — which is exactly what a copy/paste-friendly reference invites —
emits calls the same file says are unconfirmed. Since this reference is the *authority* the rule
points at, these five entries actively manufacture the failure mode the rule exists to prevent.
Either add them to the lists or fix the examples.

**2. A real bug in the `$data` GET example.**
```js
$data.get("APIFunctionName", "MyFusionWebApi")
  .then(function (result) {
    if (result2) {          // <- undefined; should be `result`
      m.myResult(result);
    }
  })
```
`result2` is never defined. Copied verbatim it throws a `ReferenceError` at runtime.

**3. The same example mixes Promise and jQuery Deferred idioms.**
`.then(...).fail(...)` — `.fail()` is jQuery Deferred, `.then()` is the Promise-style method.
It works on a jQuery Deferred but teaches a hybrid that breaks the moment the "Stop the bleeding
first" advice is followed and the call is wrapped in a native Promise (which has no `.fail()`).
The Promise-wrapping example three lines later has the same shape.

**4. App-specific names leaked into a file whose selling point is portability.**
`$data.get("GetAutoCardEnrollEligible", "PaymentsWebApi")` — a real endpoint and web API from a
specific application, inside the document explicitly written to be copied into other solutions.
Fourth instance of app-specific leakage in the kit (after prompt 17's
`LegacyConnectionStringProviderTests.cs` and the `EquipmentService .cs` filenames in
`REMAINING-POINTS.md`).

**5. `<fusion-mfa-verify>` has no counterpart in the auth migration story.**
MFA is a G1 *UI control* (`numberOfCodeDigits`, `isValueReady`, `clearCode`).
`fusion-auth-standards.md` and `appmod-fusion-target` describe the Okta cutover in detail but
never mention MFA, so nothing says whether this control's flow survives, becomes an Okta-native
factor challenge, or needs a G2 equivalent. Any G1 app using it hits an undefined migration path.

**6. The high-risk widget list finally has concrete names.** Prompts 23 and 24 require explicit
parity evidence for "grids, charts, heavily customized tables, and composite forms" without
saying what those are in a G1 app. They are `<fusion-kendogrid>`, `<fusion-datatable>`,
`<fusion-chart>`, `<fusion-chartjs>`, and `<fusion-esrimap>` — and `<fusion-kendogrid>` explains
why the Kendo licensing patch in `appmod-frontend-angular` is unavoidable rather than incidental.

## Transcription uncertainties (`fusion-g1-recognition.md`)

- Line alignment verified at 62 anchors across all 13 photos, all matching. Content ends at 744;
  the editor shows line 745 blank.
- The section heading at source line 738 uses a Unicode arrow
  (`Fusion G1 → Angular/.NET`); transcribed as `->` for ASCII-safety, as were the `->` arrows in
  the KO-concepts mapping list (those are ASCII in the source).
- `esriApiVersion="'4.24'"` and `m.maxFileSize = 10 * 1024 * 1024` were read at magnification and
  are legible, but the ArcGIS version is the least certain numeric token in the file.
- No mojibake in this file.

## Structural facts added by `fusion-feature-standards/fusion-auth-standards.md`

The security half of `fusion-feature-standards` (the skill named by `OpX-AppMod-P2-Modernize`).
301 lines, no frontmatter, Ignition-native. Twelve sections, each in a
`NOT acceptable` / `Fusion pattern` pair, closing with a Quick Reference severity table.

- **The temporary-legacy-auth allowance is the most carefully bounded passage in the kit.**
  A legacy app already using Windows/Forms auth "may temporarily retain that existing scheme
  as an intermediate state", under four explicit conditions: it must already exist, be retained
  only for parity, be documented as temporary and scheduled for replacement, and never be
  treated as final or deployment-ready. Plus: "Do not introduce new legacy auth into
  applications that do not already use it, and do not expand legacy auth to new features or
  endpoints unless required strictly for parity." This is D-004's strangler order written out
  as a reviewable rule.
- **Concrete Okta config shape** (field names only; the values in the source are `your-org`,
  `your-app-id`, `your-client-id` placeholders): `Okta:Issuer`, `Okta:Audience`, `Okta:ClientId`,
  with `RequireHttpsMetadata` true in production and `ClockSkew = TimeSpan.FromMinutes(2)`.
- **Five token-validation flags that MUST be true**: `ValidateIssuer`, `ValidateAudience`,
  `ValidateLifetime`, `RequireExpirationTime`, and `RequireHttpsMetadata` outside development.
- **Five CRITICAL secret patterns, written as greppable rules**: `Password=`/`Pwd=` with a
  non-empty literal, connection strings with credentials in `appsettings.json`, API keys as
  32+-character literals, JWT signing keys as literals, and `Bearer ` followed by a token string.
- **A PII section with a genuinely useful before/after**: `X-User-Id: user.Name` →
  `X-Correlation-Id: correlationId`; `LogInformation("User {Email}…", user.Email)` →
  `("User {UserId}…", user.Id)`; `BadRequest(new { error = $"User {user.Email} is not
  authorized" })` → `Forbid()`.
- **CORS**: `AllowAnyOrigin().AllowCredentials()` is called out as a browser security violation,
  with the correct pattern reading origins from `Cors:AllowedOrigins`.
- **A dev-only-endpoint pattern** gated twice — by `IsDevelopment()` *and* by a
  `DevAuth:Enabled` config flag.

## ⚠ Findings in `fusion-feature-standards/fusion-auth-standards.md`

**1. Its "Fusion pattern (use this)" is the exact stack two other files forbid.**
This file presents as the recommended pattern:

```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => { … });
```

`dominion-requirements/SKILL.md` says the opposite, in its own Correct Implementation block:

> Keep auth in the repo's approved starter/Fusion control points … **instead of introducing a
> parallel generic `AddJwtBearer` stack.**

And `appmod-fusion-target` describes a third model again: `FusionWebBuilder.CreateBuilder(...)`
with Okta driven by appsettings config blocks and the `Fusion.Fx.Security.Web.OAuth.Okta`
package — i.e. provisioned by construction, no hand-written `AddAuthentication` at all. The
client side diverges the same way: this file hand-writes an `OktaAuthGuard` route guard and a
bearer-token `HttpInterceptor`, while `appmod-fusion-target` specifies
`provideNgxFusionAuthOAuthOkta()` with `FusionAuthenticatedGuard`/`FusionRoleGuard`.

**Three files, three incompatible Okta wirings, all presented as correct.** For a hackathon this
is more damaging than any numbering drift: auth is the one thing every participant must get
right, and whichever file their agent loads first determines what they build. This needs a
single decision, not a linter.

**2. Same problem with API docs: this file hand-writes Swagger.**
Its Fusion pattern is `app.UseSwagger(); app.UseSwaggerUI(c => c.SwaggerEndpoint(...))` inside an
`IsDevelopment()` guard. But `appmod-fusion-target` states Scalar/OpenAPI "serves at `/scalar`
transitively via `Fusion.Fx.App.Web`; do **NOT** hand-write `AddScalar`/`MapScalar`", and the
whole kit targets Scalar (prompt 02 pins `https://localhost:4200/scalar`). This file never
mentions Scalar at all — it is written entirely against Swagger.

**3. Severity conflict on an identical finding.**
`Token in localStorage` is **HIGH** in this file's Quick Reference. It is **CRITICAL** in
`dominion-requirements/SKILL.md` ("Tokens in localStorage | XSS can steal tokens") and appears
under Critical in `AppMod-Acceptance-Criteria.md`. Since Dominion is the scoring rubric, this
file's table will under-rate a Critical finding by two bands.

Related: this file treats Windows/IIS/Negotiate auth as CRITICAL, while Dominion scores
`Forms Authentication` as HIGH — two legacy auth schemes that this file's own prose treats as
equivalent ("Windows Authentication, Forms Authentication, or another legacy scheme").

**4. `sessionStorage` is not a fix for the `localStorage` XSS risk.**
> Tokens NEVER in `localStorage` (XSS vulnerable) - use `sessionStorage` or in-memory

`sessionStorage` is readable by any script in the same origin, exactly like `localStorage`; it
differs only in lifetime. Only the in-memory option in that sentence actually mitigates XSS
token theft. In a document whose stated purpose is "non-negotiable security requirements", this
should say in-memory (or httpOnly cookie), not offer `sessionStorage` as an equal alternative.

## Transcription uncertainties (`fusion-feature-standards/fusion-auth-standards.md`)

- Line alignment verified at 26 anchors — 1, 7, 22, 35, 47, 49, 70, 90, 104, 120, 126, 135, 155,
  164, 176, 188, 206, 216, 231, 242, 252, 261, 274, 287, 289, 301 — all matching. Content ends
  at 301.
- The Okta values in the `appsettings.json` example (`https://your-org.okta.com/oauth2/default`,
  `api://your-app-id`, `your-client-id`) are placeholders in the source; **no real tenant,
  issuer, audience or client ID appears in the file and none was inferred.**
- Line 3 wraps across three editor rows; reconstructed from wrap positions.
- No mojibake in this file.

## Structural facts added by `dominion-requirements/SKILL.md`

**1,398 lines — the largest file in the kit**, ahead of `architecture-structure/SKILL.md` (470)
and prompt 06 (567). It is the WHY/WHAT/HOW expansion of the Dominion rubric, and it is the
only file in the kit carrying a `version:` field.

- **`version: "2.0"`** — the first and only versioned artifact anywhere in the kit. Nothing
  else (prompt, agent, or skill) declares a version. This is the natural pin target for a
  multi-participant run and the pattern the rest of the kit should copy.
- **Per-requirement DET/AI tagging, and many requirements are both**, e.g. Factor III:
  "DET for hardcoded strings … AI for judging whether a value should be externalized vs. is
  acceptable as a constant." Finer-grained than the two-bucket split in the criteria file.
- **The rubric declares its own boundaries**: "We check **6 of the 12** factors that are
  detectable from code review", then names the six excluded (I, V, VII, VIII, X, XII) with the
  reason. Arithmetic verified: 6 checked (II, III, IV, VI, IX, XI) + 6 excluded = 12.
- **A `What Qualifies as Config` table** (Externalize vs Can Hardcode) — connection strings,
  API endpoints, credentials, feature flags, timeouts, batch sizes vs internal routes, math
  constants, HTTP status codes, enum values. This is what stops "magic numbers" generating noise.
- **Dominion Logging Standards — 7 Log Types Required**: Performance, Debug, Trace, Error,
  Warning, Info, Audit. A company-specific standard that appears nowhere else in the kit.
- **Nine numbered sections**, ending with a `# 9. Severity Classification Guide` that contains
  a four-question **Decision Matrix**, per-severity tables with concrete examples, a
  **Category-Specific Reference** (7 tables mapping ~70 named violations to severities), and
  **Edge Cases**.
- **Edge Cases is the most operationally useful part** and has no equivalent anywhere else:
  - *Upgrade*: multiple MEDIUM in one file → consider HIGH for the file; pattern repeated across
    codebase → upgrade one level; security-critical code path → upgrade one level.
  - *Downgrade*: test-code-only → may downgrade; generated code → may skip or LOW; compensating
    control → may downgrade; legacy being replaced soon → document but may downgrade.
  - *What's NOT a Violation*: five explicit false-positive exclusions.
- **A `## Finding Format` JSON schema**: `line`, `severity`, `category`, `rule`, `message`,
  `code`, `recommendation`.
- **Passing Criteria**: `Score >= 80`, `CRITICAL = 0`, `Test Coverage >= 80%` — matching
  `appmod-compliance-review`'s deploy gates exactly (that skill adds a fourth, "review complete").
- **The auth guidance names the anti-pattern to avoid**: keep auth in the approved
  starter/Fusion control points "instead of introducing a parallel generic `AddJwtBearer` stack."
- Deliverables are scored: README.md (Prerequisites / Getting started / Build / Running tests /
  Debugging guide) and pipeline config (`azure-pipelines.yml`, `pipeline.yaml`, or GitHub Actions
  workflow files).

## ⚠ Findings in `dominion-requirements/SKILL.md`

**1. The Category-Specific Reference matches the criteria file exactly — the thresholds are a
detect-vs-score pair, not drift.** Verified row by row:

| Metric | `SKILL.md` DET trigger | `SKILL.md` Category Reference | `AppMod-Acceptance-Criteria.md` |
|---|---|---|---|
| Class lines | > 300 | 300-500 MEDIUM · 500+ HIGH | 300-500 Medium · > 500 High |
| Interface methods | > 7 | 8-15 MEDIUM · 15+ HIGH | 8-15 Medium · > 15 High |
| Constructor params | > 5 | 5-7 MEDIUM · 8+ HIGH | 5-7 Medium · > 7 High |

All three agree. **One off-by-one**: the constructor-params DET scan triggers at `>5` (i.e. 6+),
but 5 is already MEDIUM in both severity tables — so a 5-parameter constructor is scoreable yet
undetectable. One-character fix.

**2. Prompt 24's worked example is one severity band low, now confirmed against three sources.**
Prompt 24 lists `TransformerService.cs | 650 lines, needs split` as **P3**. This file says
`God class (500+ lines) | **HIGH**` and the criteria file says `> 500 lines is High`. With
P1-P4 mapping 1:1 onto CRITICAL/HIGH/MEDIUM/LOW, a 650-line class is **P2**. Worked examples
anchor model scoring harder than prose, so this should be fixed in prompt 24.

**3. The Angular section contradicts itself within 30 lines.**
Heading: `## Modern Angular Patterns (21+)`. The code inside it is commented
`// Signal-based inputs (Angular 20)` and `// Signal-based outputs (Angular 20)`. So the kit now
states **four** Angular targets — 19+ (`Ultimate-AppMod-Ignition`), 20 (prompt 02, even-major
policy), 20+ (prompt 24), 21+ (this heading) — and this file disagrees with itself. Because
"Angular" is a scored judgment area, a reviewer applying the 21+ heading to an app scaffolded on
Angular 20 per prompt 02 will flag it. **19 and 21 are both odd majors**, contradicting prompt
02's stated even-major baseline.

**4. `Test coverage < 80%` is scored MEDIUM (-2) but is also a hard pass gate.**
Passing Criteria requires `Test Coverage >= 80%`; the Testing Violations table scores falling
short at **MEDIUM**. So an app can lose only 2 points for a condition that independently blocks
passing. Not wrong, but the two mechanisms should be reconciled or the gate stated as
non-scoring.

**5. Two redundant rows in SOLID Violations.** `God class (500+ lines) | **HIGH**` and
`Very large class (800+ lines) | **HIGH**` carry the same severity, so the 800+ row changes
nothing. Either 800+ should escalate (it does not — CRITICAL is security-only) or the row should
be merged.

**6. "Environment checks" appear as both a MEDIUM violation and a non-violation.**
Line 1213: `Environment check in code | if (env == "Production") | Config should vary, not code`
→ MEDIUM. Line 1398: `Environment checks for feature flags -> OK (but config is better)`.
Reconcilable by purpose, but a model scanning for `if (env ==` has no way to tell which case it
is looking at without reading intent — and nothing tells it to.

**7. Token cost: this single file is 1,398 lines.** With `AppMod-Acceptance-Criteria.md` (100),
the `dominion-requirements` skill is ~1,500 lines. It is referenced by `OpX-csharp-expert`,
prompt 04, prompt 22 and `appmod-compliance-review` — i.e. loaded on most review passes. Together
with `architecture-structure` (~800) that is ~2,300 lines of rubric before any application code
is read. Sections 1-7 (the WHY/WHAT/HOW teaching material) and section 9 (the classification
tables) are separable: a reviewer scoring findings needs section 9 and the criteria file, not the
worked C# examples.

## Transcription uncertainties (`dominion-requirements/SKILL.md`)

- Line alignment verified at 100+ anchors across all 25 photos, including 5, 40, 48, 78, 132,
  171, 217, 266, 306, 320, 324, 398, 443, 479, 523, 579, 583, 619, 654, 690, 711, 715, 749, 775,
  779, 817, 849, 879, 952, 977, 1007, 1034, 1058, 1081, 1097, 1121, 1140, 1196, 1255, 1274, 1294,
  1311, 1328, 1343, 1354, 1365, 1377, 1392, 1398 — all matching. Content ends at 1398.
- **Source line 914 shows a stray `What a` immediately before the `// Signal-based outputs
  (Angular 20)` comment.** Transcribed as the comment alone, since the surrounding TypeScript
  makes the prefix syntactically impossible and it reads as editor ghost-text rather than file
  content. Worth confirming against the real file.
- All emoji (the DET/AI review-method markers and the `[BAD]` cross marks in code comments) are
  mojibake in the source and are recorded as `<MOJIBAKE: emoji>` placeholders.
- `>=` in the Passing Criteria is rendered as `≥` in the source; transcribed as `>=` for
  ASCII-safety. The `x` in the score formula is a literal lowercase `x`, not `*` or `×`.
- Example credentials in BAD blocks (`"P@ssw0rd"`, `"sk-123..."`, `?apiKey=secret123`,
  `Password=secret`) are illustrative placeholders in the source, not real values.

## Structural facts added by `dominion-requirements/AppMod-Acceptance-Criteria.md`

**The Dominion rubric itself** — the document every compliance score in the kit ultimately
resolves to. Referenced by `OpX-csharp-expert`, prompt 04, prompt 22 and
`appmod-compliance-review`; this is the first time its contents are visible. 100 lines, no
frontmatter (Ignition-native).

- **A two-tier review model, stated structurally**: `## Deterministic Patterns` (findable by
  scan) versus `## Judgment-Based Review Areas` (require reasoning). That split is exactly what
  `appmod-compliance-review` operationalises when it says "the reviewer owns the JUDGMENT; the
  tool owns the MATH".
- **27 deterministic patterns across three severities**: 5 Critical, 10 High, 12 Medium — each
  one a concrete, greppable pattern rather than a principle.
  - *Critical* is entirely security: hardcoded secrets, interpolated SQL, tokens in
    localStorage/sessionStorage, unsanitized `innerHTML`, sensitive data in logs.
  - *High* mixes platform and correctness: Forms/Windows-role auth instead of OAuth/OIDC +
    policy authorization, `.Result`/`.Wait()`/`GetAwaiter().GetResult()`, `async void` outside
    true event handlers, direct instantiation of services or `HttpClient`, service locator,
    hardcoded connection strings, mutable static or ASP.NET session state, file-based logging as
    application state, `NotImplementedException` in active paths, direct DOM/jQuery in Angular.
  - *Medium* is hygiene and framework discipline, including `Missing ChangeDetectionStrategy.OnPush`,
    `Observable subscriptions without cleanup`, `Verb-based API routes`, and
    `Swagger enabled outside development-only guards`.
- **Five judgment areas** — SOLID (all five principles named), Security, Twelve-Factor, API
  Design, Angular.
- **File-Level Heuristics give hard numbers**, which is what makes "too big" reviewable:
  | Metric | High | Medium |
  |---|---|---|
  | Class line count | > 500 | 300-500 |
  | Constructor parameters | > 7 | 5-7 |
  | Interface methods | > 15 | 8-15 |
- **A `## Non-Violations` section** — four things a reviewer must *not* flag: `new` for DTOs or
  collections, `static readonly` and `const`, `IMemoryCache` for performance caching, and `new`
  inside test setup. Very few rubrics bother to enumerate their own false positives; this is the
  single cheapest defence against a review that cries wolf. It is also internally consistent —
  *mutable* static state is High, `static readonly` is explicitly fine.
- **The scoring formula**: `Score = 100 - (Critical x 10) - (High x 5) - (Medium x 2)`.

## ⚠ Findings for `dominion-requirements/AppMod-Acceptance-Criteria.md`

**1. It corroborates `appmod-compliance-review` precisely — including the two tool-owned rows.**
That skill listed twelve dominion categories: 12-Factor, SOLID, OAuth/OIDC, policy authorization,
stateless, RESTful, JSON, API-docs gating, logging, async, coverage, packages. All ten judgment
categories map cleanly onto this file. **`coverage` and `packages` are the only two absent** —
and `appmod-compliance-review` explains why: "Two rows are tool-owned and computed
deterministically — `Test coverage >= 80%` and `Packages approved`. Do not write them; your
opinion on them is discarded." The rubric and its implementation agree, and the omission is
deliberate. The scoring formula matches to the digit as well.

**2. There are now three severity ladders, and the canonical one has only three levels.**

> **CORRECTED by `dominion-requirements/SKILL.md`.** The claim that the canonical rubric has
> only three levels was based on this criteria file alone. `SKILL.md` — the same skill,
> `version: "2.0"` — defines a **four**-level table including `LOW | Style, documentation gap |
> 0 | NICE TO FIX`, plus a full `## LOW (0 points)` section with ten worked examples. So:
> `appmod-compliance-review`'s `LOW 0` is correct and faithfully derived, and prompt 24's
> `P1-P4` maps **1:1** onto CRITICAL/HIGH/MEDIUM/LOW rather than being an orphan ladder.
> **The real defect is that the two dominion files disagree with each other**: the scoreable
> checklist omits LOW entirely while the guidance file defines it, so a LOW finding has a
> definition but nowhere to land. The table below is kept as written for the record.

| Source | Levels |
|---|---|
| **Dominion (this file, canonical)** | Critical / High / Medium — **3** |
| `appmod-compliance-review` | CRITICAL / HIGH / MEDIUM / **LOW 0** — 4 |
| prompt 24 | P1 / P2 / P3 / P4 — 4 |
| `OpX-csharp-expert` | CRITICAL / HIGH / MEDIUM — 3 (matches Dominion) |

`LOW` and `P4` have no home in the canonical rubric. `appmod-compliance-review` at least scores
LOW at 0, so it is inert. Prompt 24's P4 ("Polish — comments, formatting, minor cleanup") has no
Dominion equivalent at all, and prompt 24 never states a P-to-severity mapping. This supersedes
the earlier "two severity vocabularies" note under `OpX-csharp-expert`.

**3. Prompt 24's own worked example mis-scores against this rubric.**
Prompt 24's issue-list example contains:
```
| 9 | P3 | Code | TransformerService.cs | 650 lines, needs split | 45m |
```
This file's File-Level Heuristics say a class over 500 lines is **High**. Under any sane P-mapping
(P1=Critical, P2=High), a 650-line class is P2 — not P3. So the calibration example that Step 24
gives the model to anchor on is two severity bands off the canonical rubric for the one finding
where the rubric gives an exact number. Worth fixing in prompt 24, since worked examples
anchor scoring more strongly than prose does.

**4. The formula has no floor here; the clamp is added downstream.**
`Score = 100 - (Critical x 10) - (High x 5) - (Medium x 2)` can go deeply negative —
`appmod-compliance-review`'s own worked example (2 Critical, 142 High) computes to **-630**.
That skill adds `score = max(0, 100 - weighted)`. The clamp is therefore an implementation
decision, not part of the canonical rubric. Worth pushing into this file so every consumer
clamps the same way.

**5. Nothing here covers parity, functionality, or accessibility — by design, and worth
remembering.** Prompt 24 scores nine categories weighted to 100, of which Parity (20%),
Functionality (18%) and part of Testing sit entirely outside Dominion. Dominion is a *code
compliance* rubric, not a *modernization success* rubric. Conflating the two would let an app
score well on Dominion while having lost half its routes.

## Transcription uncertainties (`dominion-requirements/AppMod-Acceptance-Criteria.md`)

- Line alignment verified at 22 anchors — 1, 3, 5, 11, 13, 15, 21, 23, 34, 36, 49, 51, 59, 66, 74,
  79, 85, 87, 91, 93, 98, 100 — all matching. Content ends at line 100.
- The scoring line uses a plain `x` for multiplication (`Critical x 10`), not `*` or `×`;
  transcribed as photographed.
- Method and property names in the bullets are unquoted prose in the source (e.g. `async void`,
  `.Result`, `innerHTML` appear without backticks); preserved as plain text rather than
  code-formatted.
- No mojibake in this file.

## Structural facts added by `diagnose/SKILL.md`

**A meta-skill.** The first transcribed file that has nothing to do with .NET, Fusion, or
modernization: it audits *AI workflows themselves*. 106 lines.

- **Five scored dimensions, 1-5 each, 25 total**: Prompt Quality, Context Efficiency, Tool
  Health, Architecture Fitness, Safety & Reliability.
- **A scoring guide with an action per band**: 5 production-excellent (no action) → 4 polish
  prompt clarity or output schema → 3 add error handling or reduce complexity → 2 immediate
  attention, add retries/guards → 1 rebuild from scratch.
- **An ASCII dashboard report format** with per-dimension bars, an overall score, three CRITICAL
  FINDINGS ranked by severity, and three RECOMMENDED ACTIONS mapped one-to-one to those findings.
- **Concrete numeric thresholds**, which is what makes it usable rather than vibes:
  **"Tool count (3-7 ideal, 13+ problematic)"**.
- **Two calibration rules that stop it producing noise** — both worth copying:
  - *Scope attribution*: "Distinguish project-configured tools (custom scripts, project MCP
    servers) from agent-level tools (built-in IDE tools, global MCP servers). **Only flag tool
    overhead for tools the project can actually control.**"
  - *Contextual output filtering*: "data between a user's own frontend and backend is lower risk
    than data exposed to external services."
- **Context Efficiency names attention-gradient awareness explicitly** — "critical info at
  start/end" — alongside context budget allocation, window utilization, state management, and
  memory strategy.
- **Cost appears twice**: `Cost awareness (budgeted vs. unbounded)` under Architecture Fitness and
  `Cost controls (ceilings set vs. unbounded)` under Safety & Reliability.
- **Evaluation strategy is scored**: "golden tests vs. 'it seems to work'".

## ⚠ Findings for `diagnose/SKILL.md`

**1. The kit fails its own Tool Health rubric, and the numbers are not close.**
This skill sets 3-7 tools as ideal and **13+ as problematic**. Counting declared tools across the
eleven transcribed agents:

| Agent | Declared tools | Verdict by this rubric |
|---|---:|---|
| `Ultimate-Ignition-edit` | 26 | 2× the problematic threshold |
| `Ultimate-AppMod-Ignition` | 26 | 2× the problematic threshold |
| `OpX-AppMod-P2-Modernize` | 24 | problematic |
| `OpX-AppMod-P1-Discovery` | 18 | problematic |
| `OpX-AppMod-P3-Review` | 8 | above ideal |
| `OpX-fusion-ui-component-upgrade` | 7 | ideal |
| `OpX-dotnet-upgrade` | 7 | ideal |
| `OpX-csharp-janitor` | 7 | ideal |
| `OpX-csharp-expert` | 7 | ideal |
| `OpX-Fusion-Reviewer` | 6 | ideal |
| `OpX-Frontend-Angular-Transform` | 6 | ideal |

The split is clean and informative: **every specialist sits inside the ideal band; every
coordinator and both orchestrators blow past the problematic threshold.** And the skill's own
scope-attribution caveat does not excuse it — these are `.github/agents/*.agent.md` tool lists,
which are exactly the "project-configured" surface the project controls.

`OpX-AppMod-P2-Modernize` is the worst case in kind rather than count: nine of its 24 entries are
fine-grained forms already covered by coarse grants it also declares (`edit`, `vscode`, `browser`,
`agent`), so a third of its tool surface is decorative.

**2. The kit ships its own audit tool and, on the evidence so far, has never been pointed at
itself.** Running `diagnose` against the Ignition Kit before the hackathon is close to free and
would surface, in the kit's own vocabulary:
- *Tool Health* — the table above.
- *Context Efficiency* — `architecture-structure` loads ~800 lines eagerly before any app code is
  read (see that skill's findings).
- *Safety & Reliability / cost controls* — the "continue / proceed / resume / keep going"
  autonomy rule in `architecture-structure/SKILL.md` has **no ceiling**, which is precisely
  `Cost controls (ceilings set vs. unbounded)` scoring low.
- *Architecture Fitness / observability* — this one should score well: decisions are logged, the
  handoff protocol is structured, and step ownership is explicit.

**3. Nothing transcribed so far references this skill.**
No agent and no prompt names `diagnose`. Same situation as `appmod-backend-dotnet`. Either skills
are discovered by convention from `.github/skills/**`, or this is a second orphan — and unlike the
others, `diagnose` is generic enough that it would be useful invoked directly by a developer.

## Transcription uncertainties (`diagnose/SKILL.md`)

- Line alignment verified at 27 anchors — 4, 6, 8, 10, 14, 20, 24, 30, 34, 39, 41, 45, 51, 55, 61,
  63, 65, 73, 76, 81, 85, 87, 89, 97, 99, 101, 106 — all matching. Content ends at 106.
- **The dashboard's bar glyphs are approximate.** The photo shows filled and unfilled blocks whose
  exact characters are not resolvable; transcribed as `█`/`░`, and the column padding inside the
  box is reconstructed rather than measured. The scores themselves (4/5, 3/5, 2/5, 4/5, 2/5,
  15/25) are legible and exact.
- The box-drawing frame is transcribed as UTF-8 box characters (`┌ ─ ┐ │ ├ ┤ └ ┘`); at photo
  resolution a pure-ASCII original (`+---+`, `|`) cannot be fully excluded.
- Hyphens in prose (e.g. "5 quality dimensions - prompt quality") are transcribed as plain hyphens;
  some may be en/em dashes in the source.
- No mojibake in this file.

## Structural facts added by `browser-source-decomposition/SKILL.md`

The router that decides *how* a legacy browser surface maps to the target client. 102 lines,
Ignition-native (no `source:`/`confidence:` frontmatter).

- **An eleventh skill: `/.github/skills/fusion-g1-to-g2-modernization/SKILL.md`**, loaded whenever
  Fusion G1 recognition signals appear.
- **Two more unnumbered prompts**, bringing `.github/prompts/P2-Modernize/` to four known files:
  `mvc-to-browser-client.prompt.md`, `angular-to-browser-client.prompt.md`, `cleanup.prompt.md`,
  `fix-violations.prompt.md`.
- **Exactly two decomposition contracts, and a hard rule against inventing a third**: "Do not
  invent a new stack-specific frontend lane beyond the approved MVC-to-browser-client path,
  Angular-to-browser-client path, or an explicit validate-only or proof-only posture."
- **A seven-row Source-Shape Decision Matrix** covering server-rendered, browser-led SPA,
  Fusion G1, mixed/hybrid, static document flow, already-modern shell, and browser-not-applicable
  — each with recognition signals, required contract posture, and a note.
- **Fusion G1 is finally defined by its recognition signals**: Knockout, RequireJS or AMD,
  Durandal patterns, legacy `<fusion-*>` controls, Fusion G1 services. It classifies as a
  browser-led SPA path "with stricter translation and verification rules".
- **The classification never routes on file extension**: "Choose based on route ownership and
  where behavior actually lives, not on file extension alone", and for ambiguous cases "choose
  the primary path by runtime ownership".
- **Mixed/hybrid apps get both contracts, not a custom lane** — run whichever contract prompts
  cover the active families, "then reconcile them into one returned-data summary instead of
  creating a custom third lane".
- **A ten-field returned-data contract**: `browserSurfaceApplicability`, `browserSourceFamilies`,
  `primaryDecompositionPath`, `secondaryDecompositionPaths`, `requiredContracts`,
  `contractRefreshActions`, `approvedBrowserRoot`, `validateOnlyReason`,
  `unsupportedSecondaryEdges`, `exactNextStep`.
- **`NotApplicable` still owes proof, not silence**: "return a lightweight proof decision instead
  of pretending browser decomposition still owns hidden work" — and the matrix note repeats it:
  "still return lightweight proof, not silence."
- **An already-modern shell is preserved, not regenerated**: "Preserve current shell structure and
  close the highest-value scaffold gaps instead of regenerating from scratch."
- Uses the **long** artifact root (`.modernization/ignition-artifacts/modernize/fusion-restructure/`)
  — a vote against the short form used in `architecture-structure/SKILL.md` and prompt 21.

## ⚠ Findings in `browser-source-decomposition/SKILL.md`

**1. The entire file is on the old numbering — uniformly — and the wrong numbers are all valid
current step numbers.**

Unlike `OpX-AppMod-P2-Modernize` (mixed, some lines correct) or the archived Angular agent (prose
stale, handoffs correct), **every step reference in this file is +2**:

| File says | Actually is |
|---|---|
| "the current **Step 5** legacy-system-analysis evidence" | Step 3 — Legacy System Analysis |
| "the current **Step 7** modernization solution design and migration plan" | Step 5 — Modernization Solution Design |
| "Confirm `browserSurfaceApplicability` from **Step 7**" | Step 5 (owns `decisions.json`) |
| "**Step 12** owns source classification … styling foundation, shell formation" | Step 10 — Frontend Foundation & Scaffold |
| "**Step 13** owns route-family and shared-client migration" | Step 11 — Frontend Migration |
| "**Step 13** through **Step 15** browser lanes" | Steps 11 through 13 |

**This is the most dangerous drift instance found so far, and the reason is subtle.** Every other
stale reference has been either obviously wrong or harmlessly vague. Here, "Step 12" and "Step 13"
are *real, current, adjacent steps with different jobs*:

- An agent reads "Step 12 owns source classification and shell formation" and attaches browser
  decomposition to **Step 12 = Frontend Platform Integration** (auth, HTTP wiring, config).
- It reads "Step 13 owns route-family migration" and attaches feature migration to
  **Step 13 = Frontend Shell Stabilization**.
- Meanwhile the actual owners — Step 10 (Foundation & Scaffold) and Step 11 (Frontend Migration) —
  get no decomposition guidance at all.

Nothing errors. The Step Ownership Guardrail at the end of the file, whose entire purpose is to
stop work landing in the wrong step, is itself pointing at the wrong steps. **A whole-file `-2`
is the correct fix**, and it is safe here precisely because the file is internally consistent.

**2. One line does not fit the +2 reading.**
Matrix row 7: "Steps **10 through 13** still return lightweight proof, not silence." Under a
uniform +2 that maps to current Steps 8-11 — but Steps 8 and 9 are backend formation and backend
integration hardening, which have no browser proof to return. Under current numbering, 10-13 is
exactly the frontend block and reads correctly. So this single line appears to already be on the
new numbering while the rest of the file is on the old, which is the same per-line update pattern
seen in prompt 21 and `OpX-AppMod-P2-Modernize`. **Do not blind-shift this line with the others.**

**3. Ninth vote in the artifact-root ledger.**
This file uses `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` and
`control-point-inventory.json`. `architecture-structure/SKILL.md` and prompt 21 use the short
`.modernization/fusion-restructure/…` form for the same artifacts. The long form now leads, but
both forms appear in Ignition-native files, so this is a real fork rather than one file's typo.

## Transcription uncertainties (`browser-source-decomposition/SKILL.md`)

- Line alignment verified at 22 anchors — 4, 6, 8, 12, 16, 23, 27, 29, 40, 42, 52, 56, 63, 65, 67,
  73, 75, 83, 87, 98, 100, 102 — all matching. Content ends at 102; the editor shows line 103
  blank.
- The Source-Shape Decision Matrix is a seven-row markdown table whose cells wrap heavily across
  editor rows; cell boundaries were reconstructed from the `|` positions and verified against the
  gutter numbering (one source line per row).
- No mojibake in this file.

## Structural facts added by `architecture-structure/SKILL.md`

**The largest file in the kit at 470 lines** — larger than prompt 06 (567 lines is the only
bigger prompt) and loaded by two agents. It is the actual move contract for modernization
formation.

- **The architecture selection is a recorded run parameter, not a judgement call**:
  > Do not make the architecture selection inside this skill. Read `architectureStyle` from
  > `/.modernization/.readme/kit-params.md`. If `architectureStyle` is missing, assume `simple`.
  > Use `clean` only when it is explicitly selected.

  And the two profiles are reconciled rather than presented as rivals: "treat the simple
  architecture as a **collapsed form of clean architecture** — domain, application, and
  infrastructure concerns are still present conceptually, but organized into a single
  `*.Library` project."
- **A new skill: `/.github/skills/visual-parity-gate/SKILL.md`** — the gate the modern shell must
  pass before deliberate Fusion primitive replacement begins. Tenth skill identified.
- **A second template: `/.github/templates/AMBIGUOUS-PLACEMENT-REPORT-TEMPLATE.md`** — the format
  for durable review of ambiguous placement decisions, "so the evidence and decision can be
  checked outside the chat".
- **The six protected starter-shell files, named exactly**: `Web.Api/Program.cs`,
  `Web.Api/Extensions/FusionWebBuilderExtensions.cs` (or `Web.Api/DependencyInjection.cs`),
  `Library/Extensions/FusionApplicationBuilderExtensions.cs` (or
  `Library/DependencyInjection.cs`), `Web.Client/src/main.ts`,
  `Web.Client/src/app/app.config.ts`, `Web.Client/src/app/fusion.config*.ts`. This is the
  concrete file list behind `OpX-Fusion-Reviewer`'s six abstract "control points".
- **A ~30-row backend file-mapping table** with simple-vs-clean destinations for every category,
  and a **frontend mapping** (`src/app/pages/`, `src/app/components/`, `src/app/services/`).
- **Two full reference trees** (Simple Web App Target, Clean Architecture Target) rendered as
  box-drawing diagrams — the only place the complete target shape appears in one view.
- **Runtime proving checks per bridge family** — the most operationally useful list in the kit:
  AG Grid (module-registration / row-model errors), ng-bootstrap popovers/dialogs/date pickers
  (runtime DI or template errors), auth/HTTP bridges (protected route + expected request),
  startup bootstrap calls (first API call resolves, shell renders past the loading gate),
  fixed-header layouts (title/action row/filter band render below the header instead of clipped).
  With the rule: **"A green compile is not enough to prove the bridge actually instantiates
  inside the migrated shell."**
- **A precise auth diagnostic**: "If a bearer token produces `403` instead of `401` during
  verification, assume authentication may be working while **role mapping** is still unresolved."
- **The kit asks for missing inputs instead of guessing**: required role-group identifiers and
  authoritative connection strings are "an explicit project input" — ask the user and record the
  answer rather than inferring from `SimpleArchitectureExample` or unrelated apps.
- **An autonomy rule, stated twice**: user directions such as `continue`, `proceed`, `resume`, or
  `keep going` are approval to keep advancing through eligible slices and handoffs "until a real
  blocker, failed gate, required user decision, or workflow completion is reached" — and when a
  handoff completes cleanly and another is eligible, continue directly "instead of waiting for
  another prompt".
- **`Framework/` is reference-only**: four `Framework/docs/*` inputs are supplemental, and moving
  or transplanting files out of `Framework/` into `src/` is forbidden unless the task explicitly
  targets framework internals.
- **A backend sign-off rule that catches a real failure mode**: sign-off is blocked "when only
  detail-by-id routes were moved but the migrated frontend or other consumers still depend on
  collection or list routes for the same feature family."

## ⚠ Findings in `architecture-structure/SKILL.md`

**1. The two files in this skill folder disagree about the test tree.**
`Architecture-Structure.md` specifies:
```
tests/modernization/characterization/{testcase, testResult}/
```
Both reference trees in `SKILL.md` specify:
```
tests/modernization/
└── characterization/
    └── reports/
```
`testcase/` and `testResult/` versus `reports/` — same skill folder, same directory, two answers.
`Architecture-Structure.md` is the more specific and more recently reasoned of the two (it
carries the "do not create step-named folders" rule that depends on the testcase/testResult
split), so `SKILL.md`'s trees are most likely stale. One-line fix, but an agent reading the
reference tree will create the wrong folder.

**2. The Source of Truth list numbers `6` twice.**
Items 1-6 are listed, then after the `Framework/` paragraph the list resumes at **6, 7, 8, 9**.
So there are two item 6s and the `Framework/` inputs are numbered as if they continued the
required list when they are explicitly "supplemental reference-only inputs". Cosmetic in
isolation, but this is a list an agent is told to "read first" — the ambiguity is about whether
items 6-9 are required.

**3. Another `.modernization/fusion-restructure/` path without the `ignition-artifacts/modernize/`
prefix.**
Line 95 cites `.modernization/fusion-restructure/styling-foundation.json` and
`ui-visual-contract.json`. `OpX-Fusion-Reviewer` reads the same artifacts at
`.modernization/ignition-artifacts/modernize/fusion-restructure/…`; prompt 21 uses the short
form. The short form now has two independent sources, so this is not a one-off typo — it is a
genuine fork in the artifact-root convention that needs one decision.

**4. Token cost: this file is 470 lines and is loaded by two agents.**
`OpX-Fusion-Reviewer` and `Ultimate-Ignition-edit` both load `architecture-structure`, and
`SKILL.md` is its entry point. Combined with `Architecture-Structure.md` (215) and
`REMAINING-POINTS.md` (108), fully loading this skill is ~800 lines of context before any app
code is read. Given the stated Copilot budget concern, this is the strongest candidate in the
kit for the lazy-loading treatment that `Ultimate-Ignition-edit` already uses — the Reference
Trees, Future Considerations, and File Mapping Guidance sections are reference material that
most slices do not need in context.

**5. The autonomy rule will produce long unattended runs.**
"Continue directly into that next handoff instead of waiting for another prompt" plus
"`continue`/`proceed`/`resume`/`keep going` … until a real blocker, failed gate, required user
decision, or workflow completion is reached" means one approval can chain many slices. That is
the right design for an experienced operator and a liability for 40 simultaneous first-time
users — worth pairing with a slice-count or token ceiling for the hackathon specifically.

## Transcription uncertainties (`architecture-structure/SKILL.md`)

- Line alignment verified at 24 anchors — 4, 6, 12, 37, 50, 67, 104, 127, 140, 157, 159, 189,
  235, 254, 280, 306, 342, 356, 367, 371, 373, 423, 425, 470 — all matching. Content ends at 470;
  the editor shows blank lines through 472.
- The file is **hard-wrapped**; most bullets are single logical lines spanning several editor
  rows. Break points are not preserved as physical newlines because the source lines are single
  lines — verified against the gutter numbering at every anchor.
- The two reference trees use box-drawing characters (`├──`, `└──`, `│`) rendered cleanly in the
  photos; transcribed as UTF-8 box-drawing, not ASCII approximations.
- No mojibake in this file.

## Structural facts added by `architecture-structure/REMAINING-POINTS.md`

A companion file whose entire job is to say **what the kit has deliberately not decided yet**.
108 lines, no frontmatter (Ignition-native).

- **The stated principle is the best governance sentence in the kit**:
  > keep the unresolved points explicit instead of silently hard-coding premature answers into
  > the skill
- **Export Guidance** — the skill is explicitly designed to be lifted into "a reusable template
  repository": copy `SKILL.md`, and copy this file too "if you want downstream teams to see what
  is still intentionally unresolved". That is directly the Squad conversion's use case.
- **Five named open formation decisions**, each with a "Current likely direction" that is
  explicitly *not* a rule:
  1. **Legacy Angular feature modules** — how `modules/<feature>/` becomes starter-derived
     structure. Likely: map each feature to `src/app/pages/<feature>/`; split module-local
     shared pieces into colocated page-support folders or shared `components/`; do **not** move
     NgModule-era folders wholesale as `modules/`.
  2. **Legacy Angular core/bootstrap files** — `app.module.ts`, `app-routing.module.ts`,
     `APP_INITIALIZER`, custom route-reuse behavior, and `core/{services,guards,interceptors,models,util}/`.
     Likely: translate bootstrap concerns into the starter's existing bootstrap/config files;
     split `core/` by responsibility rather than preserving it as one destination folder.
  3. **Shared shell components** — `nav-menu`, help modal/page, not-found pages,
     layout-participating shell widgets. Likely: shell/navigation → layout-level or shared
     `components/`; not-found → `pages/`; help → page or shared modal depending on runtime
     behavior.
  4. **Host-era static assets and web-host leftovers** — `wwwroot/`, `Pages/`, `libman.json`.
     Likely: keep real API endpoints such as `StaticFileController` in the API project; review
     `wwwroot` assets one-by-one; do not assume Razor-era files move unchanged.
  5. **Filename hygiene as a formal formation rule** — "still open as a formal policy decision".
- **`src/app/pages/<feature>/`** is the concrete client target structure — stated nowhere else
  in the transcribed material.
- **A well-argued filename-hygiene case**, grounded in real observed defects: three source files
  with a **trailing space before `.cs`**. Why it matters is enumerated — scripted moves mismatch
  visible name vs actual path, patches fail when the path is not typed exactly, Linux/container
  tooling is less forgiving, reviewers miss visually subtle path defects, and a move script may
  treat a malformed path as a separate file rather than the intended target.
- **A naming-intent rule**: legacy `Input` / `View` / `Manager` should become `Request` /
  `Response` / `Validator` / `Service`, and a `*View.cs` that is really an API response DTO
  should be renamed — but only as a **move-slice concern**, never broad rename-only churn.

## ⚠ Findings in `architecture-structure/REMAINING-POINTS.md`

**1. This file is the fix for the open questions I flagged in `Architecture-Structure.md` — the
mechanism already exists.**
Yesterday's finding was that `Architecture-Structure.md` carries four unresolved questions inline
(`Middleware/ // What does this do??`, `References: none? (Project.Application?)`, and two more).
This companion file establishes the team's own practice for exactly that situation: open points
live in a named companion, explicitly marked, with a "current likely direction" that is not
mistaken for a rule. **The correct fix is to move those four inline `??` comments into this
file**, not to invent a new mechanism and not to leave them in the normative document. The
governing sentence is already written: "keep the unresolved points explicit instead of silently
hard-coding premature answers into the skill."

**2. All five open decisions are frontend, and all five land inside Steps 10-13.**
Step 10 (Frontend Foundation & Scaffold) and Step 11 (Frontend Migration) execute against rules
that this file says do not exist yet: how to convert `modules/<feature>/`, how to translate
`app.module.ts` / `APP_INITIALIZER` / `core/`, where shell components go, and how to triage
`wwwroot/`. "Current likely direction" is guidance, not a gate.

For a 40-person hackathon this is the **largest single source of divergence identified so far**.
Every participant's Step 11 will resolve four undefined conversions independently, all of them
defensibly, and the resulting `src/app/` trees will not resemble each other. Unlike the
numbering drift (mechanical, linter-fixable) or the `.feature` conflict (one file to rewrite),
this needs four actual decisions made by a human before the event. The "current likely
directions" are good and could be promoted to rules largely as written.

**3. App-specific leakage — third instance.**
`EquipmentService .cs`, `LineService .cs`, `EquipmentLinkView .cs` are real filenames from a
specific application. Prompt 17 hard-codes `LegacyConnectionStringProviderTests.cs`; the same
pattern appears here. It is more defensible in this file (they are cited as *observed evidence*
for why the rule is needed, not as a template), but a kit exported to other teams will carry one
app's file names in its architecture standard.

**4. The trailing-space defect is real and is worth a gate, not a guideline.**
A filename ending in `<space>.cs` is exactly the class of problem a five-line check catches
deterministically and a human reviewer misses — the file itself says "reviewers can miss path
defects because the problem is visually subtle". Given that the kit already has a gate
convention with `.sh`/`.ps1` launchers, this belongs in `check-structure` rather than in prose.

## Transcription uncertainties (`architecture-structure/REMAINING-POINTS.md`)

- Line alignment verified at 31 anchors — 1, 3, 5, 7, 10, 12, 20, 22, 30, 35, 44, 50, 52, 59,
  65, 67, 69, 71, 73, 75, 79, 81, 89, 91, 96, 98, 100, 102, 104, 106, 108 — all matching.
  Content ends at 108; the editor shows line 109 blank.
- **Source lines 8 and 9 are both blank** (a double blank line before `### 1.`), unlike every
  other section break in the file, which uses one. Preserved as photographed.
- **The trailing spaces inside `` `EquipmentService .cs` `` and its two siblings are
  intentional and preserved** — they are the defect being documented. Verified byte-wise after
  writing.
- No mojibake in this file.

## Structural facts added by `architecture-structure/Architecture-Structure.md`

The first **Ignition-native** skill file transcribed — and the discriminator between the two
skill families is now unambiguous.

- **Ignition-native skills have no frontmatter at all.** This file opens directly with
  `# App Mod Architecture Standards`. Every `appmod-*` skill opens with a `---` block carrying
  `name`/`description`/`domain`/`confidence`/`source`. That is a clean, mechanical test for
  sorting the two families during the conversion.
- **Skills can be multi-file.** `architecture-structure/` holds `SKILL.md`,
  `Architecture-Structure.md`, and `REMAINING-POINTS.md` — so `SKILL.md` is an entry point, not
  the whole skill. This is also the first skill referenced by name from an *agent*
  (`OpX-Fusion-Reviewer` and `Ultimate-Ignition-edit` both load it), confirming Ignition-native
  status independently.
- **Two named architecture profiles, selected by a blunt ownership question**:
  - *Simple Web App* — **"No one relies on me"**. Explicitly **no CQRS**. Two projects:
    `Project.Api` + `Project.Library`, where the Library "combines the complicated app's Domain,
    Application, and Infrastructure projects."
  - *Complicated Application* — **"Other apps currently or will rely on me"**. **Uses CQRS.**
    Four layers: `Project.Api` -> `Project.Application` -> `Project.Domain`, plus
    `Project.Infrastructure` implementing Domain's interfaces, with `DependencyInjection.cs` in
    both Application and Infrastructure.
- **The canonical test workspace**, which prompts 17 and 24 both reference but never define:

  ```
  LegacyCode/<App>.Data.Tests/Characterization/Baseline/
  tests/backend/{unit, contractApi, integrationBackend}/
  tests/frontend/{angularUnitComponent, integrationFrontend, smoke, e2e/{journeys, accessibility}, visualParity}/
  tests/modernization/characterization/{testcase, testResult}/
  ```

  Organised "by execution surface first, then by test type", with a one-line ownership rule for
  each folder.
- **A precise definition of `integrationFrontend`** — browser-driven component-to-API proof that
  "navigates to a real route, triggers the owning UI control, captures the matched network
  request or response plus response code, and asserts the resulting UI state." That is the
  tightest definition of an integration test anywhere in the kit.
- **An anti-drift rule earned from a real problem**: "Do not create new step-named folders or
  duplicate step-prefixed parity files under `tests/modernization/characterization`. Use
  testcase metadata, stable ids, and per-step Markdown reports to track phase ownership
  instead." Someone clearly ended up with `step12-*`, `step13-*` parity files.
- Solution-level files are named: `Dockerfile`, `.dockerignore`, `*.yaml`.
- A short DDD appendix, including a genuinely useful **Entity vs Value Object** heuristic:
  "removing the ID breaks it" vs "removing the ID makes it better".

## ⚠ Findings in `architecture-structure/Architecture-Structure.md`

**1. This is the third independent source siding AGAINST `.feature` files — and it is the
canonical layout.**
The e2e tree is `tests/frontend/e2e/{journeys, accessibility}`. There is **no `features/`
directory and no `steps/` directory** anywhere in the workspace contract. Prompt 24's Playwright
Checklist explicitly scores "Feature files in `features/` directory" and "Step definitions in
`steps/` directory"; Steps 12 and 17 forbid `.feature` files.

Tally so far: Steps 12 and 17 forbid them, this canonical structure has no place for them, and
`appmod-testing-and-gates` asks only for Gherkin-*style* headers inside ordinary test files.
**Only prompt 24 requires them.** That makes prompt 24 the outlier, and the fix is to rewrite
its §6 and Playwright Checklist rather than to change three other files.

**2. A standards document with unanswered questions in it will produce 40 different answers.**
Four open questions are marked in the source and left unresolved:

```csharp
Middleware/     // What does this do??
- **References:** none? (`Project.Application`?)
Project.Application/        // Separate folders by object type / feature worked with?
MyAppObject1Query.cs    // List + handler in one? Query returns data (object or list of objects)
```

The Infrastructure layer's `References:` line is the serious one — "none? (`Project.Application`?)"
is a load-bearing architectural dependency left as a question mark in the document that agents
are told to follow. In Clean Architecture, Infrastructure referencing Application is a real
decision with real consequences, and right now the kit does not state it. For a hackathon, every
participant's agent will resolve these four differently and all of them will be able to cite the
standard.

**3. A colleague's name is embedded in the standard.**
`// Dion thinks handler + definition in one; command returns success/failure`. Transcribed
verbatim per the standing rule. Worth a decision before this content is distributed more widely:
attributing an unresolved design opinion to a named individual inside a normative document is
both a personnel-sensitivity question and a signal that the line is a note, not a rule.

**4. `Step 9` in the test-workspace rules is ambiguous.**
"Modernization Quality Design should establish the phased characterization ladder before later
phases begin adding modernization proof, and **Step 9** should preserve the workspace contract
as real tests grow." Modernization Quality Design is Step 6, which is correct. Step 9 is backend
integration hardening — plausible as the last backend gate, but Step 17 ("Rewire All Tests &
Verify") is the step that actually grows the test suite. Under the +2 offset, "Step 9" would map
to Step 7. Recorded as ambiguous rather than assigned an offset.

**5. The two profiles have no selection gate.**
"No one relies on me" vs "Other apps currently or will rely on me" is the entire decision
procedure for choosing between a 2-project and a 4-project backend. No step owns that choice, no
artifact records it, and no gate checks it. Step 5 (Modernization Solution Design) is the
natural owner — worth confirming it actually asks.

> **SUPERSEDED by `architecture-structure/SKILL.md`.** There *is* a selection mechanism, and it
> is explicit: "Do not make the architecture selection inside this skill. Read
> `architectureStyle` from `/.modernization/.readme/kit-params.md`. If `architectureStyle` is
> missing, assume `simple`. Use `clean` only when it is explicitly selected." So the choice is a
> recorded run parameter with a safe default, not an unowned decision. What remains open is
> narrower: nothing transcribed so far shows *which step sets* `architectureStyle`, or any gate
> that validates it against the app's actual downstream-consumer situation.

## Transcription uncertainties (`architecture-structure/Architecture-Structure.md`)

- Line alignment verified at 30 anchors — 1, 3, 7, 13, 17, 24, 34, 41, 62, 64, 68, 74, 81, 90,
  92, 99, 108, 115, 127, 134, 152, 156, 161, 180, 193, 195, 203, 205, 210, 215 — all matching.
  Content ends at 215; the editor shows line 216 blank.
- Heading numbering is inconsistent in the source and preserved as-is: the Simple Web App
  sections use `#### 1.` / `#### 2.` (with periods) while the Complicated Application sections
  use `#### 1` … `#### 5` (without).
- In-code comment alignment (column position of `//`) is approximate.
- Lines 181, 182 and 189 hard-wrap across editor rows; break positions reconstructed.
- No mojibake in this file.

## Structural facts added by skill `appmod-testing-and-gates`

The sixth and last `appmod-*` skill, and the one that removes any remaining doubt about
provenance: it describes **this repository's own gate architecture**, under an older root path.

- **"Gates are scripts, not opinions: a step is done only when its gate script exits `0`."**
  Near-verbatim the rule in Squad-ik's `CLAUDE.md` ("Gates are scripts, not opinions. A pipeline
  step is done when its gate exits 0").
- **Exit-code contract**: `0` pass / `1` usage / `2` fail.
- **Seven gates named**, with their semantics:
  `validate-artifacts <name>|all` (a missing schema **FAILS**, never degrades to a syntax check),
  `verify-goldens <url>` (TYPE-STRICT compare — `true != 1`, `int != float` — normalized fields
  masked, do NOT follow redirects), `visual-diff <url> [--capture]` (re-baseline only with
  `--capture` **plus a logged decision**), `check-structure [--phase backend|full]`
  (`full` also asserts the legacy app is gone), `check-pins` (fail while any pin is a
  placeholder), `check-auth-removed`, `run-scorecard <before|after>`.
- **`run-scorecard` after-mode enforces four conditions**: no critical/high CVEs, coverage
  threshold, total >= target, and **NO dimension below its before score**.
- **Characterization tests are evidence (D-001)** — pin CURRENT behavior, bugs included, aimed
  at the riskiest logic, before modernization; changeable only with a logged
  intentional-behavior-change entry.
- **A pending scorecard dimension scores `0`, not a pass.** "no evidence" is not "fine".
- **Test readability contract**: `CaseId` / `Scenario` / `Description` / `Input` / `Expected`
  headers with `Given` / `When` / `Then` bodies.

## ⚠ Findings for skill `appmod-testing-and-gates`

**1. `check-auth-removed` is documented but does not exist in this repository.**
Checked directly: `.squad/gates/` contains `check-consistency`, `check-pins`, `check-structure`,
`run-scorecard`, `validate-artifacts`, `verify-goldens`, `visual-diff` — each as a `.sh`/`.ps1`
pair. **There is no `check-auth-removed`**, and the string appears nowhere in the repo outside
`_ignition-import/`.

That matters because it is the enforcement mechanism for a mandatory policy. D-004 states the
legacy auth path removal is "mandatory, never skipped", and `appmod-fusion-target` says the
removal is "gated by `check-auth-removed`". **The gate that makes D-004 non-optional is
missing**, so today nothing fails when a legacy auth path survives into the final state. Either
the gate needs writing or D-004's enforcement claim needs amending.

**2. Six of seven gate names match `.squad/gates/` exactly; the seventh is unaccounted for in
the other direction.** `check-consistency` exists in `.squad/gates/` but is not documented in
this skill. So the skill and the implementation have drifted apart in both directions — one
documented-but-missing, one implemented-but-undocumented.

**3. Every path in the `appmod-*` skills uses an older root and would be wrong if copied
forward.** The mapping is consistent and mechanical:

| Skill path | This repository |
|---|---|
| `tools/appmod/gates/` | `.squad/gates/` |
| `tools/appmod/scorecard/engine/engine.py` | `.squad/scorecard/engine/engine.py` (verified present) |
| `tools/appmod/scorecard/VERSION` | `.squad/scorecard/VERSION` |
| `tools/appmod/verify-kit.ps1` | `verify-kit.ps1` (repo root) |
| `tools/appmod/artifacts/` | (referenced by `appmod-compliance-review`; no match found) |

The architecture is identical — stdlib-Python gate logic behind `.sh`/`.ps1` launcher pairs,
a scorecard engine with a `VERSION`, a `verify-kit` self-test. Only the root was renamed
`tools/appmod/` → `.squad/`, with `verify-kit` promoted to the repo root. **These skills predate
that rename**, which independently dates them relative to the current kit.

**4. "Gherkin-style" here means test *naming*, not `.feature` files.** Worth stating explicitly
because of the unresolved Ignition conflict (Step 24 requires `.feature` files; Steps 12 and 17
forbid them). This skill asks for Gherkin-shaped headers and `Given`/`When`/`Then` bodies inside
ordinary test files — which is the option that satisfies both sides of that conflict, and is
therefore a candidate resolution for it.

## Transcription uncertainties (skill `appmod-testing-and-gates`)

- Line alignment verified at 14 anchors — 11, 13, 15, 18, 20, 21, 22, 28, 29, 31, 33, 37, 39, 42
  — all matching. Content ends at 42; the editor shows line 43 blank.
- The gate bullets (lines 22-28) are nested one level under line 21 and hard-wrap; indentation
  is reproduced as photographed.
- A "Configure Tools…" UI affordance appears between `source:` and `tools:` in the photo; that
  is editor chrome, not file content, and is not transcribed.
- No mojibake in this file.

## Structural facts added by skills `appmod-frontend-angular`, `appmod-fusion-target`, `appmod-modernization-process`

Three short skills (35 / 32 / 40 lines) that between them answer the integration questions the
prompts and agents only gestured at.

### `appmod-fusion-target` — the concrete Okta + Scalar + Fusion wiring

The single most useful file transcribed for "how do Scalar, Okta, and Fusion actually get
wired?" Everything is named:

- **Backend** (`src/<App>.Web.Api`): `FusionWebBuilder.CreateBuilder(...)` +
  `await builder.BuildAndRunAsync()`. Okta, Scalar, OpenAPI, caching and CORS are all driven by
  **appsettings config blocks**, not code. Packages: `Fusion.Fx.App.Web`,
  `Fusion.Fx.Security.Web.OAuth.Okta`.
- **Client** (`src/<App>.Web.Client`): `provideNgxFusionAuthOAuthOkta()` plus the
  `fusion.config` `auth` block — issuer, clientId, redirectUri, logoutUrl, scopes,
  **`pkce: true`**, **`authenticateOnStart: false`**. Route protection via
  `FusionAuthenticatedGuard` / `FusionRoleGuard`. Package:
  `@fusion/ngx-fusion-auth-oauth-okta`. (Field names only — no tenant values appear in the
  source and none were inferred.)
- **Scalar** serves at `/scalar` **transitively** via `Fusion.Fx.App.Web`; hand-writing
  `AddScalar`/`MapScalar` is an anti-pattern. Internal-only by default.
- **Component swap**: one primitive family at a time, **one component per commit**. Named
  counterparts: standard grid = `FusionDataGridBasicComponent`, free-text+suggest =
  `FusionSuggestionTextboxComponent`.
- **The auth strangler has a removal gate**: `check-auth-removed`. The legacy path is not
  optional cleanup — it is gated.
- **Completeness is provisioning, not compilation**: "A restructured `src/` missing
  Scalar/OpenAPI, the Okta config blocks, or the client auth provider is INCOMPLETE
  provisioning **even if it compiles**."
- **A runtime proof requirement for Fusion**: "A route counted 'Fusion-complete' just because
  `<fusion-...>` tags exist — runtime smoke must prove the Fusion theme is actually applied."

### `appmod-modernization-process` — the wave sequence and the parity gate

- **Discovery reverse-engineers the legacy app *while it is RUNNING*** — routes, endpoints with
  **live golden request/response pairs**, UI controls, workflows, high-risk seams, baseline
  screenshots per route/state. Inventories land in
  `.modernization/ignition-artifacts/discovery/`: `service-behavior-inventory.json`,
  `interaction-wiring-inventory.json`, `workflow-trace-inventory.json`, `review-manifest.json`,
  plus an explicit **cannot-locate backlog**.
- **The answer-key principle**: "the parity reference is ALWAYS the legacy app in `LegacyCode/`
  + its extracted visual contract, **never a finished modern reference**."
- **A two-part frontend parity gate that must pass before any Fusion swap**:
  - *Field parity* — every legacy grid column/field, filter and control present **AND wired**
    (no column collapse, no inert stubbed handler, no dead filter, distinct data per sibling
    list).
  - *Visual parity* — palette, typography, header/nav/footer chrome, nav route model, layout
    density.
- **The backend-wave milestone is a real integration checkpoint**: "the legacy frontend runs
  against the new backend."
- **Close-out requires no dimension below the before score** plus closed-loop reconciliation
  against the discovery inventory.

### `appmod-frontend-angular` — parity-first migration and the Kendo trap

- **The move is a parity move, not a redesign.** What must survive the move is enumerated:
  legacy stylesheet stack, **partial import order**, assets, fonts/icons, host/body classes,
  layout wrappers, and the DOM/class contract.
- **The shell inherits the legacy visual language by construction**: design tokens from the
  legacy palette/typography, Fusion theme bound to them, branded header, nav populated from the
  route inventory, footer.
- **Per-route behavior preservation** names the things that usually get dropped: real click
  handlers, modal/banner triggers, export/print/download/upload controls, keyboard shortcuts,
  data bindings.
- `FusionErrorService` / `FusionLoggerService` from `@fusion/ngx-fusion`; `data-testid`
  everywhere so the app is Playwright-ready.
- **A precise auth-plumbing warning**: "Assuming `HttpClient` receives bearer tokens just
  because `provideNgxFusionAuthOAuthOkta()` exists — prove the request path; the default
  final-state path is **`FusionHttpService`**."

## ⚠ Findings for the three skills

**1. The Kendo license patch needs a licensing decision before any hackathon.**
`appmod-frontend-angular` ships a PowerShell one-liner that rewrites the embedded expiry inside
Progress's Kendo licensing module (`@progress/kendo-licensing/dist/index-esm.js`), replacing a
matched date-like token with `1999999999`, to suppress the trial watermark. Transcribed verbatim
because it is what the file says.

Two separate issues, neither of them stylistic:
- **Licensing.** This modifies a commercial vendor's licensing code. Whether that is acceptable
  is a question for whoever owns the Kendo/Progress agreement — not something the kit should
  decide by default, and not something to discover after 40 people have run it.
- **Durability.** The skill itself notes the patch "is lost on every `npm install`". A fix that
  silently reverts is a fix that will be re-applied by 40 people at unpredictable times.

The underlying diagnosis is correct and worth keeping either way: `KENDO_UI_LICENSE=ignored` has
no effect under esbuild because Angular 17+ uses `@angular/build`, which does not substitute
`process.env` into the browser bundle. The right fix is a real license key in CI/dev
provisioning, not a patched module.

**2. `appmod-fusion-target` is the only place `pkce: true` and `authenticateOnStart: false` are
stated.** Nothing in the 24 prompts or 11 agents names either setting, yet both materially
change the Okta flow. If the `appmod-*` skills are Squad-side, then **the Ignition Kit itself
never tells a developer what the Okta config block should contain** — it only says auth must be
wired. That is a gap in the kit, not in the skill.

**3. `D-016` is paired with `D-006` everywhere it appears** (`appmod-fusion-target` line 12,
`appmod-modernization-process` line 32), always as "structure **and component counterparts**".
It reads as an extension of D-006 rather than an independent policy — worth confirming when the
appended ledger is located, since a merged D-006 may be cleaner than two IDs.

## Transcription uncertainties (the three skills)

- Line alignment verified at 10 / 13 / 17 anchors respectively, all matching. Content ends at
  35 / 32 / 40; editors show one trailing blank line each.
- All three are **hard-wrapped** — physical line breaks mid-paragraph, preserved as photographed.
- `appmod-modernization-process` items 1 and 5 are single logical list items spanning many
  editor rows; the internal break points are reconstructed from wrap positions.
- In the Kendo patch, the regex `'\b174733\d{4}\b'` was read carefully at magnification but the
  literal digits `174733` and the `\d{4}` quantifier are the least legible tokens in the three
  photos. Verify against source before relying on it.
- Okta config **field names** only are recorded (issuer, clientId, redirectUri, logoutUrl,
  scopes); no tenant, domain, or client-ID values appear in the source and none were inferred.
- No mojibake in any of the three files.

## Structural facts added by skill `appmod-compliance-review`

Regardless of provenance, this is the most sophisticated evaluation design in either kit. 119
lines.

- **A `tools:` catalog in skill frontmatter** — a new schema element. Four entries, each with
  `name` (the literal CLI invocation), `description` (what it computes), and `when` (the
  sequencing rule). This is a *tool manual* embedded in the skill, not a model-tool allowlist.
- **The core design: split judgment from arithmetic.**
  > The reviewer owns the JUDGMENT; the tool owns the MATH.
  > You supply findings + per-category judgments; `compliance-scan assemble` computes the score,
  > the gate table, and the before->after comparison. You do not compute or self-report the score.
- **The manifest is a coverage proof, not a checklist.** `manifest` enumerates every in-scope
  file with `reviewed: false`; the reviewer must flip each to `true`; `assemble --enforce`
  **fails the review** if any row is still false. That is a mechanical guarantee against
  sampling — the thing most AI review passes silently do.
- **The category rubric is pre-seeded and parsed from a template.** `requirements[]` arrives
  pre-named and pre-ordered, every row at `"status": "UNKNOWN"`, generated from
  `/.github/templates/COMPLIANCE-ANALYSIS-REPORT.template.md`. The stated reason is the best
  anti-drift sentence in either kit:
  > Nothing restates the category list in code, so the two can never drift apart.
- **`UNKNOWN` is defined as a worksheet placeholder, not a verdict** — "not yet judged", never
  "not applicable". `--enforce` blocks on any remaining `UNKNOWN` and prints exactly which.
- **Two rows are tool-owned**: `Test coverage >= 80%` and `Packages approved` — "Do not write
  them; your opinion on them is discarded."
- **App-specific categories are appended, not merged**, and surfaced under
  `requirementsUnmapped` "so it is visible rather than silently merged".
- **Fixed scoring**: CRITICAL -10, HIGH -5, MEDIUM -2, LOW 0; `score = max(0, 100 - weighted)`.
  Deploy gates: score >= 80, zero CRITICAL, coverage >= 80%, review complete.
- **The review gate has a stated rationale**: "a report with no findings would otherwise score
  100/100 — an unreviewed manifest can never read READY."
- **Same rubric both runs**, described as "the AI analog of *the same judge scores both
  phases*" — before over `LegacyCode/`, after over `src/`.
- **A worked improvement example**: before `score 0` (2 CRITICAL, 142 HIGH) -> after `score 88`
  (0 CRITICAL, 4 HIGH), `compare` reporting `scoreChange +88`, `criticalChange -2`.
- **The dominion rubric's twelve categories are finally enumerated**: 12-Factor, SOLID,
  OAuth/OIDC, policy authorization, stateless, RESTful, JSON, API-docs gating, logging, async,
  coverage, packages.
- **A new template surface**: `/.github/templates/COMPLIANCE-ANALYSIS-REPORT.template.md`.
  First `.github/templates/` reference anywhere.

## ⚠ Findings for skill `appmod-compliance-review`

**1. Two artifact roots in one paragraph — and this one is self-aware about it.**
Compliance artifacts are written to `.modernization/ignition-artifacts/compliance/`, but "the
tool still reads the coverage input from `tools/appmod/artifacts/`". The word *still* marks it
as a known, deliberate seam rather than an accident — but it means the compliance lane spans
two artifact trees, and only one of them is the Ignition-aligned one.

**2. It documents a real past failure in its own anti-patterns.**
> paraphrasing `RESTful API endpoints` into `RESTful API design` **used to leave** the canonical
> row UNKNOWN and append a duplicate.

Past tense. This is a bug that happened, got diagnosed, and got written into the skill as a
guard. Worth noting because it is the strongest evidence anywhere that the skills layer is
genuinely "earned" rather than aspirational.

**3. The `.ps1|.sh` notation is not a real filename.**
`compliance-scan.(ps1|sh)` is shorthand for a pair of launchers. Harmless to a human; a model
told to run `tools/appmod/gates/compliance-scan.(ps1|sh) manifest before` verbatim will fail.
Every other invocation in the kit names a concrete file.

## Transcription uncertainties (skill `appmod-compliance-review`)

- Line alignment verified at 21 anchors — 20, 22, 24, 28, 31, 35, 40, 42, 49, 53, 64, 75, 80,
  82, 89, 91, 96, 98, 105, 107, 118 — all matching. Content ends at 119; the editor shows line
  120 blank.
- The file is **hard-wrapped**, not soft-wrapped: most prose paragraphs are physical multi-line
  blocks with the break points visible in the gutter. Break positions are preserved as
  photographed.
- The fenced block at lines 81-89 uses trailing `#` comments aligned in a column; column
  alignment is approximate.
- No mojibake anywhere in this file.

## Structural facts added by skill `appmod-backend-dotnet`

First skill transcribed, and it is a **third artifact type** — not a prompt (procedure) and not
an agent (identity + routing), but a distilled knowledge card. 34 lines, and the highest
signal-per-line of anything in the kit.

- **A completely different frontmatter schema**: `name`, `description`, `domain`, `confidence`,
  `source` — all quoted strings, opening `---` at line 1. No `tools`, no `handoffs`, no
  `agents`, no `user-invocable`.
- **`confidence: "high"` and `source: "earned (Ignition Kit Step 7 + dotnet standards)"`.**
  "Earned" is doing real work here: this is knowledge distilled from actual runs, tagged with
  where it came from and how much to trust it. **No other artifact type in the kit carries
  provenance or confidence metadata.** If the Squad conversion keeps one idea from the skills
  layer, this is the one.
- **A four-section shape**: Context / Patterns / Examples / Anti-Patterns. The Anti-Patterns
  section is the largest, and it is written as failure modes with their exact symptoms.
- **The direct answer to "how does Scalar get wired?"**:
  > Scalar/OpenAPI is provisioned by construction via `Fusion.Fx.App.Web` (config blocks
  > `Fusion.Web.Api.EnableApi` + `OpenApi`); **do NOT hand-write `AddScalar`/`MapScalar`**.
  > The published endpoint set must EXACTLY match the inventory.

  This is the first place the mechanism is named rather than the outcome. `Fusion.Fx.App.Web`
  is a new package name.
- **The connection-string contract (D-014)**: compose once at startup from split env vars
  `SqlServer__Server` / `Database` / `Username` / `Password` / `Encrypt` /
  `TrustServerCertificate` into `ConnectionStrings`. (Names only — no values, consistent with
  the no-secrets rule for this import.)
- **"Consumer-complete route parity"** with the family list spelled out:
  list / detail / create / update / delete / export / current-user — each must exist on the
  target or be a recorded temporary bridge.
- **Four runtime traps a green build hides**, each with its observable symptom:
  - `AddWithValue` infers the wrong `SqlDbType` → **SQL silently returns zero rows; the API
    answers HTTP 200 with `[]` and no exception.** The nastiest one in the kit: no build error,
    no test failure, no log line — just an empty grid that looks like "no data".
  - Split-version package trap → builds green, only the highest version ships, sibling faults
    at runtime.
  - SqlClient `Encrypt` default flipped true → 500 at first DB hit, `InnerMessage` = "The
    certificate chain was issued by an authority that is not trusted."
  - Dapper materialization mismatch (SQL `int` → `string` ctor param) → "a parameterless
    default constructor or one matching signature ... is required."
  - Plus: `Microsoft.AspNetCore.SpaServices.Extensions` removed in .NET 8+.
- **"Build-green is NOT done"** stated as a headline anti-pattern: "You are done only when the
  backend STARTS and a real authenticated route returns real data." Same doctrine as
  `OpX-dotnet-upgrade`'s penetration proof, compressed to one line.

## ⚠ Findings for skill `appmod-backend-dotnet`

**1. Decision-ID collision risk for the Squad conversion — worth resolving before importing
anything.**

> **SUPERSEDED by `appmod-compliance-review`.** The framing below — that Ignition and Squad
> have independent decision ledgers which "only happen to agree at 007" — is wrong.
> `appmod-compliance-review` cites **D-008** with the same meaning *and the same phrasing*
> as Squad-ik's D-008 ("never self-report" the score). Two of two checked IDs match in ID,
> meaning, and wording. These are not independent ledgers that collided; they are the same
> ledger. The real finding is the provenance one below — these `appmod-*` skills are almost
> certainly conversion-side artifacts, which is why they cite Squad's decision IDs. The
> paragraphs below are kept as written for the record.

This skill cites two decision IDs: **D-007** (`src/<App>.Web.Api` is *move-only*) and **D-014**
(connection-string composition). Squad-ik's own `.squad/decisions.md` seeds **D-001…D-010**,
and its **D-007** reads:

> **D-007** · Behavior commits and move commits never mix.

The Ignition Kit's D-007 and Squad-ik's D-007 **mean the same thing** — move-only vs behavior
commits. That is a lucky alignment, not a guarantee. The Ignition Kit's ledger runs to at least
**D-014**, past the end of Squad's seeded range, so the two ledgers are independent and only
happen to agree at 007.

**The hazard is the ones that don't agree.** If Ignition's D-003 means something different from
Squad's D-003, importing Ignition prompts into Squad format produces cross-references that
resolve to the wrong policy — silently, because the citation still looks valid. Before
converting, the two decision ledgers need to be diffed ID by ID and either merged with a
namespace (e.g. `IGN-D-014`) or renumbered.

**2. The Ignition Kit's own decisions file has not been located yet.**
D-007 and D-014 are cited with no path. None of the 24 prompts or 11 agents transcribed so far
names a decisions ledger. It exists — worth photographing.

**3. Nothing transcribed so far references this skill.**
Agents and prompts have named eight skills — `fusion-restructure-review`,
`architecture-structure`, `dominion-requirements`, `ignition-kit-maintenance`,
`fusion-feature-standards`, `fusion-ui-component-upgrade`, `step3-legacy-system-analysis`,
`screenshot-capture`. **`appmod-backend-dotnet` is not among them.** Either a loader picks up
`.github/skills/**` by convention, or this skill is orphaned and never loads. Given that it
contains the `AddWithValue` trap — a silent data-loss failure — an orphaned skill would be an
expensive thing to leave unwired. Needs a directory listing of `.github/skills/` plus a check
of how skills are discovered.

**4. Knowledge is duplicated between the skill and the agent, with no stated source of truth.**
The SqlClient `Encrypt` regression, the split-version trap, and the build-green-is-not-done
doctrine all appear in **both** this skill and `OpX-dotnet-upgrade.agent.md`, in different
words. That is defensible (skill = distilled recall, agent = procedural lane), but neither file
points at the other, so the two will drift. The skill's `source:` field is the natural place to
declare which one is canonical.

## Transcription uncertainties (skill `appmod-backend-dotnet`)

- Line alignment verified at 11 anchors — 7, 9, 11, 14, 16, 17, 22, 24, 27, 29, 34 — all
  matching. Content ends at 34; the editor shows line 35 blank.
- **Source lines 11-12 are a hard-wrapped paragraph, not a single wrapped line** — line 11 ends
  at "behavior" and line 12 begins "commits only". Preserved as two physical lines.
- Lines 16, 18, 19, 20, 29, 31 wrap in the editor; reconstructed from wrap positions.
- Env-var **names** only are recorded (`SqlServer__Server`, `…__Password`, etc.); no values
  appear in the source and none were inferred.
- No mojibake anywhere in this file.

## Structural facts added by agent `Ultimate-Ignition-edit`

The kit-maintenance agent — the only identity permitted to modify toolkit files, named as the
escalation target by `OpX-AppMod-P1-Discovery`. 93 lines.

- **Its Primary Role is the inverse of every other agent's**: "making changes directly to the
  Ignition Kit itself — prompts, agents, scripts, instructions, skills, and modernization
  guidance files under `.github/` and `.modernization/`." Every other agent is forbidden from
  exactly this.
- **A two-tier reference-loading contract.** *Always load*:
  `.github/instructions/kit-update.instructions.md` (kit structure, reusable asset boundaries,
  naming, validation) and `.github/skills/ignition-kit-maintenance/SKILL.md`. *Load on demand*,
  four more, each gated on what the user asked for.
- **Keyword-triggered lazy loading**, spelled out with the literal trigger phrases:
  | Reference | Triggers |
  |---|---|
  | AppMod-Process | "edit step", "change workflow", "update 24-step", "new phase", "routing" |
  | Architecture-Structure | "restructure", "formation", "move to src", "LegacyCode-to-src" |
  | PowerShell-Maintenance | ".ps1", "script", "powershell" |
  | Branch-Integration | "sync", "merge", "branch", "integrate", "propagate" |

  With the rationale stated: "This prevents unnecessary context loading when the task doesn't
  actually require those domains." This is the most token-conscious design in the kit and the
  pattern worth copying elsewhere.
- **"update 24-step"** as a literal trigger phrase confirms 24 is the current, intended step
  count.
- **A Branch Sync Policy**: syncing a non-main validation branch into `main` or `main-dev`
  defaults to **toolkit-only integration**, excluding `LegacyCode/**`, `src/**`, and
  local-only runtime or generated folders under `/.modernization/**`. So the kit is developed
  on validation branches against a real app and only the toolkit is merged back — which is
  exactly the workflow this transcription effort is reconstructing.
- **Three more instruction files**: `kit-update.instructions.md`,
  `AppMod-Process.instructions.md`, `powershell-script-maintenance.instructions.md`. **Two
  more skill surfaces**: `ignition-kit-maintenance/SKILL.md` and its
  `references/branch-integration-policy.md`.

## ⚠ Findings in `Ultimate-Ignition-edit.agent.md`

**1. HIGHEST RISK FOR THE HACKATHON — this agent is indistinguishable from the orchestrator in
an agent picker.**

Lines 1-32 of `Ultimate-Ignition-edit.agent.md` and `Ultimate-AppMod-Ignition.agent.md` are
**byte-identical except for the `name:` line** (verified by diff). Both declare:

```
description: Ultimate agent for application modernization using the DE App Mod process with Fusion
argument-hint: Outline the goal or problem to research
```

…and the same 26 tools, including `edit`, `web/fetch`, `vscode/installExtension`, and
`vscode/newWorkspace`.

The kit-maintenance agent's description was copied from the orchestrator and never updated. It
describes a job this agent does not do. In any UI that lists agents by name + description, a
developer sees two entries whose descriptions are identical, one of which **rewrites the
toolkit itself**. The body (line 36) is correct — but by then the agent has already been
selected.

For a hackathon with 40 participants sharing one kit, this is the defect most likely to cause
real damage: a participant picks `Ultimate-Ignition-edit` expecting to modernize their app,
and instead gets an agent whose stated primary job is editing `.github/`. Every other agent in
the kit has a Write Boundary specifically to prevent that; this one is the exception, and its
description hides it. **A one-line description fix removes the entire risk class.**

**2. The kit violates its own maintenance contract — in three places, all already documented
above.**

> **Consistency Rule**: Any change to modernization processes, steps, agents, prompts, or file
> structure **must be propagated across all files** … Remove all stale references to old
> processes, retired steps, or former file locations … **every file in the repo must stay
> consistent**.
> **Consistency Enforcement**: If a file path was renamed, update all references and delete the
> old location (**no redirect shims**).

Against that standard, the kit currently contains:

| Violation | Evidence |
|---|---|
| Stale references to retired steps | The +2 drift in prompts 12-16, 19-21, `OpX-AppMod-P2-Modernize` line 113, and `OpX-Frontend-Angular-Transform`'s entire Core Rules block |
| A retired file not deleted | `OpX-Frontend-Angular-Transform.agent.md`, archived but still installed in `.github/agents/` |
| A redirect shim | `step9UpgradeWorkspaceRoot` as fallback for `step7UpgradeWorkspaceRoot`, four times in `OpX-dotnet-upgrade` |

This is useful rather than merely ironic: **the kit already contains the written standard the
cleanup should be measured against.** The fix list does not need to be invented — it needs to
be enforced. Note the redirect-shim rule and the `step9` fallback are in genuine conflict, so
that one needs a human decision (keep the shim and amend the rule, or drop the shim and
migrate the artifacts).

**3. The Consistency Rule and Consistency Enforcement disagree about scope.**
Line 58 says changes must propagate across `.github/` and `.modernization/`. Line 80 says to
verify propagation across `.github/` and `.modernization/OpXUtil/**`. The second is a strict
subset of the first, in the same file, describing the same obligation.

**4. A seventh frontmatter variant** — no opening `---`, `argument-hint` present, no
`handoffs`, no `agents`. Identical in shape to `Ultimate-AppMod-Ignition`, which is the point
of finding 1.

## Transcription uncertainties (agent `Ultimate-Ignition-edit`)

- Line alignment verified at 26 anchors — 30, 32, 34, 36, 38, 40, 42, 44, 47, 49, 54, 56, 58,
  60, 62, 64, 66, 70, 72, 74, 76, 78, 84, 86, 88, 93 — all matching. Content ends at 93; the
  editor shows line 94 blank.
- **Source line 31 is blank before the closing `---` at line 32**, matching
  `Ultimate-AppMod-Ignition` exactly.
- Lines 36-37, 58-59 and 64-65 wrap in the editor; reconstructed from wrap positions.
- The frontmatter was verified against `Ultimate-AppMod-Ignition` by direct diff rather than by
  eye; the two are identical on lines 2-32.
- No mojibake anywhere in this file.

## Structural facts added by agent `Ultimate-AppMod-Ignition`

The top-level orchestrator — the identity `OpX-Frontend-Angular-Transform` hands back to via
"Back To Orchestrator". 95 lines, and structurally unlike every other agent in the kit.

- **`OpX` = `OpEx`.** Line 36 spells it out: "the **OpEx** Ignition Kit". The agent-name prefix
  is Operational Excellence.
- **A new process name: "the DE App Mod process"** (in the `description`). Not defined
  anywhere else transcribed so far.
- **The target stack is named explicitly**: "the **Fusion Generation 2** stack
  (**Angular 19+ / .NET 10**)". This is the first place the Fusion generation is stated for
  the *target* rather than the legacy source — prompt 01 mentioned "Fusion G1" as a legacy
  generation.
- **26 declared tools — by far the largest allowlist in the kit**, and the only one with
  outbound and workspace-mutating powers: `web/fetch`, `web/githubRepo`,
  `microsoftdocs/mcp/*`, `vscode/installExtension`, `vscode/newWorkspace`,
  `vscode/getProjectSetupInfo`, `execute/createAndRunTask`, `execute/runNotebookCell`,
  `read/getNotebookSummary`, `execute/testFailure`, `read/problems`, `search/changes`,
  `search/usages`, `vscode/extensions`, `ms-azuretools.vscode-containers/containerToolsConfig`,
  plus coarse `edit`, `search`, `todo`, `agent`.
- **`argument-hint: Outline the goal or problem to research`** — a frontmatter field seen on
  prompt files but on no other agent.
- **A File Protection Policy written as MAY / MUST NOT lists plus a rule of thumb**:
  > If a file defines *how the kit works*, do not touch it. If a file is *generated output or
  > evidence from the modernization process*, you may edit it.
  > When in doubt, **read but do not edit**.

  This is the clearest statement of the kit-protection intent anywhere, and it is the only
  place that explains *why* the boundary sits where it does.
- **Four generic problem-solving phases** layered on the shared baseline: Analyze & Plan,
  **Adversarial Review** (challenge assumptions, identify failure points, consider
  alternatives, stress-test edge cases), Implement & Validate, Verify & Complete — plus a
  four-item Modernization-Specific Checklist.
- **The shared baseline contract has five named sections**: Communication, Execution, Web
  Research, Obstacle Handling, Completion Gate — all living in
  `appmod-agent-personality-baseline.instructions.md`.

## ⚠ Findings in `Ultimate-AppMod-Ignition.agent.md`

**1. The orchestrator has no knowledge of the 24-step pipeline, and no way to route into it.**
This file contains **zero references to any numbered step**, no `handoffs:` block, and no
`agents:` key. Yet `OpX-Frontend-Angular-Transform` sends users here with
"Back To Orchestrator" and "Build & Run Modern App". A developer returning to "the main
workflow" lands in an agent that has never heard of Step 10, cannot present a step menu, and
cannot hand off to `OpX-AppMod-P1-Discovery` / `-P2-Modernize` / `-P3-Review`. It is a
general-purpose modernization agent wearing the orchestrator's name — the routing layer lives
entirely in the three phase coordinators, which this file does not mention.

**2. Angular version conflict across three files.**

| File | Stated target |
|---|---|
| `Ultimate-AppMod-Ignition` | Fusion Generation 2, **Angular 19+** |
| prompt 02 (rename starter) | "Angular even-major baseline, currently **Angular 20**" |
| prompt 24 (technical review) | "**Angular 20+**" |

"Angular 19+" is technically satisfied by 20, but 19 is an *odd* major and prompt 02 states
the baseline policy is **even-major**. So the orchestrator's floor contradicts the kit's own
stated versioning policy. One of these is the source of truth; right now a model can justify
either.

**3. The kit-maintenance agent is referenced generically, not by name.**
> If a task requires changes to kit infrastructure, tell the user to use **the kit-maintenance
> agent** instead.

`OpX-AppMod-P1-Discovery` names it precisely — "tell the user to switch to
`Ultimate-Ignition-edit`". Here the model has to guess which agent that is. Two files
describing the same escalation, one with an identifier and one without.

**4. The `.modernization/` boundary is stated by intent, not by path — and it is the one
boundary that actually needs paths.**
The MAY list permits "QA portal pages and generated reports under `.modernization/`"; the
MUST NOT list forbids "Kit infrastructure files under `.modernization/`". Both are the same
directory, separated only by a judgement call about what counts as infrastructure.
`OpX-AppMod-P1-Discovery` does this correctly with globs
(`/.modernization/.readme/**`, `/.modernization/OpXUtil/**`). The rule of thumb here is a good
*explanation*, but it is not machine-checkable and it is the boundary a model is most likely
to get wrong under pressure.

**5. A sixth frontmatter variant.** No opening `---` (coordinator-style), but also no
`handoffs`, no `agents`, and a unique `argument-hint` field. Across ten agent files the
frontmatter now varies on five independent axes.

## Transcription uncertainties (agent `Ultimate-AppMod-Ignition`)

- Line alignment verified at 21 anchors — 30, 32, 34, 36, 38, 40, 42, 44, 50, 54, 56, 58, 60,
  66, 73, 79, 84, 88, 90, 92, 95 — all matching. Content ends at 95; the editor shows line 96
  blank.
- **Source line 31 is blank, immediately before the closing `---` at line 32.** Transcribed as
  photographed. `OpX-Frontend-Angular-Transform` shows the same blank-before-close pattern.
- Lines 36-37 and 51-53 wrap in the editor; reconstructed from wrap positions.
- The em dash in "application code — the actual modernization work" is transcribed as an em
  dash; at photo resolution it could be a double hyphen.
- No mojibake anywhere in this file.

## Structural facts added by agent `OpX-fusion-ui-component-upgrade`

The Steps 15-16 Fusion UI execution lane. 57 lines, and the densest file in the kit for
concrete Fusion facts.

- **The real Fusion Angular package name: `@fusion/ngx-fusion`.** First time the actual npm
  scope and package appear anywhere in the transcribed material.
- **The slice loop is a real task graph, not prose.** `ui-fusion-map.json` carries a
  `taskGraph` and a `completedTaskIds` list; the agent derives "the next eligible task" from
  those plus dependency order. That is what makes Step 16 ("Next Fusion UI Upgrade Slice")
  re-runnable — it is a worklist drain, and the artifact is the cursor.
- **A companion markdown artifact**: `ui-fusion-task-list.md`, alongside the JSON map. One of
  very few `.md` artifacts in a mostly-JSON artifact set (the other is Step 24's
  `technical-review-report.md`).
- **One slice per run, enforced**: "Execute exactly one route-local or shell-local slice."
- **Validation is the real client build**: `npm run build`, run as "the first validation
  action after the first substantive edit" — before any artifact reconciliation. Artifacts
  update *only after* validation passes.
- **Target surface named precisely**: `src/<AppName>.Web.Client/src/app/**`.
- **A fourteenth named surface: `OpX-Fusion-Transform`** — the sole handoff target
  ("Back To Restructure Workflow"). Distinct from the archived
  `OpX-Frontend-Angular-Transform`.
- **A new skill**: `.github/skills/fusion-ui-component-upgrade/SKILL.md`, loaded "before
  selecting or editing any route surface" — same skill-owns-method / agent-owns-execution
  split as `OpX-Fusion-Reviewer`.
- **Third file to guard the retired Fusion-only state tracker**: "Do not create or rely on a
  retired parallel Fusion-only state tracker as numbered-step state; the numbered workflow
  artifacts remain authoritative." (`OpX-Fusion-Reviewer` and `OpX-AppMod-P2-Modernize` carry
  the same rule.)
- **Its step numbers are correct.** The description names Steps 15 and 16 and they match
  `15-P2-fusion-ui-integration` and `16-P2-next-fusion-ui-upgrade-slice`; the execution
  contract's "step-14 UI inventory and Fusion map artifacts" matches
  `14-P2-frontend-ui-inventory-and-fusion-map`. No drift in this file.
- **The reporting contract names the exact button to click** (`Back To Restructure Workflow`)
  rather than describing it — the only agent that closes the loop that precisely.

## ⚠ Findings in `OpX-fusion-ui-component-upgrade.agent.md`

**1. Its only handoff points at an agent not yet seen — `OpX-Fusion-Transform`.**

> **RESOLVED by `agent-toolkit-protection.instructions.md`.** Its Definitive Agent List names
> `OpX-Fusion-Transform` explicitly. The agent is real and the handoff is not a dead end.
This is the agent's sole exit, and the Reporting Contract instructs the model to tell the user
to click it by name. If `OpX-Fusion-Transform` does not exist in `.github/agents/`, this lane
is a dead end and the closing instruction is unfollowable. Note the kit already contains an
*archived* `OpX-Frontend-Angular-Transform` whose job was to redirect away from a retired
frontend lane — so a stale reference here is plausible. **Needs a directory listing of
`.github/agents/` to confirm; flagged, not assumed.**

**2. The description covers Steps 15 *and* 16; the Mission covers only Step 16.**

> `description:` "Runs the **Step 15** Fusion UI Integration **and Step 16** Next Fusion UI
> Upgrade Slice lane…"
> `## Mission` — "Execute exactly one artifact-driven Fusion UI slice during restructure
> **Step 16**."

Step 15 is the initial Fusion UI integration; Step 16 is the repeatable next-slice drain.
They are different jobs, and the Mission — the part the model actually acts on — only claims
one of them. Either Step 15 has no execution lane of its own, or the Mission is under-scoped.

**3. `description` is a quoted YAML string; every other agent's is unquoted.** Harmless, but
it is the fifth distinct frontmatter convention observed across nine agent files
(opening-`---` or not, `user-invocable` or not, `handoffs` or not, `agents` or not, quoted
`description` or not).

## Transcription uncertainties (agent `OpX-fusion-ui-component-upgrade`)

- Line alignment verified at 12 anchors — 17, 19, 21, 23, 25, 28, 30, 37, 39, 47, 49, 51 —
  all matching.
- **The exact end line is approximate.** The seven Reporting Contract bullets are transcribed
  consecutively as lines 51-57, which is consistent with every verified anchor above them and
  with the editor showing blanks at 58-59. The photo's gutter in that region was not legible
  enough to rule out a blank line between the last two bullets, which would shift the final
  line to 58.
- Line 3 (`description`) wraps across three editor rows; reconstructed from wrap positions.
- No mojibake anywhere in this file.

## Structural facts added by agent `OpX-Fusion-Reviewer`

The Step 19 review lane, and the first agent with a genuinely clean separation between
*method* and *execution*. 90 lines, zero numbering defects, zero mojibake.

- **A fourth frontmatter variant**: opens with `---`, but has **no `user-invocable`, no
  `handoffs:`, and no `agents:` key** — only `name`, `description`, `tools`. It is the
  minimal agent shape in the kit.
- **Explicit skill/agent separation**, stated as a contract:
  > - the **skill** owns the review method
  > - this **agent** executes the review as a named restructure checkpoint
  > - when the caller asks for fixes, only apply the skill's safe-remediation rules

  This is the cleanest division of responsibility anywhere in the kit — the rubric lives in
  `.github/skills/fusion-restructure-review/SKILL.md` and is versioned independently of the
  lane that runs it.
- **A documented evidence precedence order**, in the description: Fusion MCP docs first, then
  the current starter shell, then `Original_Starter_kit` or `SimpleArchitectureExample` as
  **reference-only comparators**. Two more named reference surfaces.
- **Two more skills**: `.github/skills/fusion-restructure-review/SKILL.md` and
  `.github/skills/architecture-structure/SKILL.md`. One more instructions file:
  `.github/instructions/modernization-starter-boundaries.instructions.md`.
- **Seven required inputs and nine optional ones**, all named explicitly — the most precise
  input contract of any agent so far.
- **A required platform-status report covering exactly the integrations that matter for the
  hackathon**: Okta / auth, Scalar / OpenAPI, Fusion logging, Fusion config / appsettings,
  startup / DI composition, protected HTTP transport. This is the single place in the kit
  where "did Scalar and Okta actually land correctly?" is a mandatory reported field.
- **Six named protected control points**: `Program.cs`, the API Fusion composition seam, the
  Library Fusion composition seam, `main.ts`, `app.config.ts`, `fusion.config*.ts`. These are
  the seams the whole starter-shell-preservation contract is defined against.
- **A twelve-part output contract** ending in a three-way bridge disposition
  (keep / retire / safe remediation candidates), plus an explicit instruction that a clean
  review must *still* include the platform-status section rather than returning "no issues".
- **Every artifact path uses the `.modernization/ignition-artifacts/modernize/fusion-restructure/`
  root**, with no competing form anywhere in the file — a third vote for `ignition-artifacts`
  in the two-roots conflict.

## ⚠ Findings in `OpX-Fusion-Reviewer.agent.md`

**1. It is told to apply fixes but has no `edit` tool.**
Six tools: `read/readFile`, `search/codebase`, `execute/runInTerminal`,
`execute/getTerminalOutput`, `read/terminalLastCommand`, `read/terminalSelection`. Yet the
Review Method says *"when the caller asks for fixes, only apply the skill's safe-remediation
rules"* and the output contract ends with **Safe remediation candidates**. Applying a
remediation requires writing a file. This is the **fourth** agent with this defect
(`OpX-AppMod-P1-Discovery`, `OpX-AppMod-P3-Review`, `OpX-dotnet-upgrade`'s missing question
tool, and now this one) and the pattern is consistent enough to be worth a single sweep:
**diff every agent's declared tools against the verbs in its own body.**

**2. It is a dead end — the only agent with no handoffs at all.**
`OpX-AppMod-P3-Review` dispatches Step 19 here, but this file declares no `handoffs:` block,
so there is no "Back To Phase 3 Workflow" button and no route onward to Step 20. Every other
agent transcribed so far offers at least one exit. A developer who enters the Step 19 review
has no in-kit way back to the numbered flow; they have to re-select the coordinator manually.

**3. Line 59 is unterminated.** The bullet ending "…instead of requiring a retired parallel
Fusion-only state tracker" has no closing period, unlike every other bullet in the file.
Cosmetic, but it is also the longest and most important rule in the section (it tells the
agent to trust numbered-lane state over the retired Fusion-only tracker), so it reads as
truncated rather than merely unpunctuated.

**4. Another entry for the path-inconsistency ledger.**
This agent reads
`.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`. Prompt 21
(`21-P3-figma-review`) reads the same file as `.modernization/fusion-restructure/decisions.json`
— no `ignition-artifacts/modernize/` prefix. Two different absolute paths for one artifact,
in two files that run 40 minutes apart in the same phase.

## Transcription uncertainties (agent `OpX-Fusion-Reviewer`)

- Line alignment verified at 16 anchors — 11, 13, 17, 19, 27, 31, 39, 41, 50, 52, 61, 63, 65,
  75, 82, 90 — all matching. Content ends at 90; the editor shows blank lines through 92.
- Lines 3, 15 and 59 wrap in the editor; reconstructed from wrap positions.
- No mojibake anywhere in this file; nothing was placeholder-substituted.

## Structural facts added by agent `OpX-Frontend-Angular-Transform`

An **archived, retired** agent still sitting in `.github/agents/`. 50 lines. Its entire job is
to tell the caller it no longer has a job.

- `description`: "Archived compatibility redirect for the retired Angular specialist lane.
  Retained only for historical reference."
- **No `user-invocable`, no `edit` tool** — six read/terminal tools only. Three handoffs, all
  `send: false`.
- **A twelfth named surface: `Ultimate-AppMod-Ignition`**, the target of two of its three
  handoffs ("Back To Orchestrator", "Build & Run Modern App"). This appears to be the
  top-level orchestrator identity, and it is distinct from `Ultimate-Ignition-edit` (the
  toolkit-edit identity named in `OpX-AppMod-P1-Discovery`).
- **Documents a real architectural decision**: there used to be an "Angular specialist
  slice-loop" execution lane, and it was merged away into the numbered browser steps. Both
  `OpX-AppMod-P2-Modernize` ("Do not revive the retired browser-specialist slice-loop lane as
  a second frontend execution surface") and this file guard the same retirement from
  opposite ends.
- Mentions a **"manual Path A helper"** for planning-only MVC or Razor browser decomposition —
  a surface not seen anywhere else so far.

## ⚠ Findings in `OpX-Frontend-Angular-Transform.agent.md`

**1. Its Core Rules are entirely on the old numbering — while its own handoffs are on the new
one. Inside 30 lines.**

| Core Rule says | Actual step | Offset |
|---|---|---|
| "Route shell and scaffold work to **Step 12**" | Step 10 (`10-P2-frontend-foundation-and-scaffold`) | +2 |
| "Route browser migration work to **Step 13**" | Step 11 (`11-P2-frontend-migration`) | +2 |
| "platform integration, shell stabilization, and UI-planning work to **Steps 14 through 16**" | Steps 12, 13, 14 | +2 |

And the file's own handoff two lines earlier routes "Build & Run Modern App" to
`.github/prompts/10-P2-frontend-foundation-and-scaffold.prompt.md` — i.e. **Step 10**, the
thing Core Rule 2 calls Step 12. The handoff block was renumbered; the prose was not.

This is the single cleanest demonstration of the +2 drift in the whole kit: same file, same
screen, one surface correct and one surface stale, with the mapping unambiguous because the
prompt filenames are right there.

The Scope line ("the numbered **Step 12 through Step 16** prompts") is the one ambiguous case
— `OpX-AppMod-P2-Modernize` states the active browser path is **Step 10 through Step 16**, so
the lower bound is +2 but the upper bound matches. Recorded as ambiguous rather than assigned
an offset.

**2. A retired agent is still installed, and it is indistinguishable from a live one in an
agent picker.**
Nothing in the filename or the agent's `name:` marks it as archived — only the `description`
does. It sits in the same `.github/agents/` directory as the eleven live agents. For a
hackathon with 40 participants browsing an agent list, "OpX-Frontend-Angular-Transform" reads
exactly like a legitimate frontend agent. If the goal is historical reference, it belongs in
an `archive/` subfolder or outside `.github/agents/` entirely.

**3. Emoji inconsistency within a three-item handoff list.** Handoffs 1 and 2
("Back To Orchestrator", "Build & Run Modern App") carry no emoji at all; handoff 3
("Step 11 Frontend Migration") carries a mojibake emoji. Same list, same file.

## Transcription uncertainties (agent `OpX-Frontend-Angular-Transform`)

- Line alignment verified at 10 anchors — 25, 27, 29, 31, 33, 37, 39, 46, 48, 50 — all
  matching. Content ends at 50; the editor shows line 51 blank.
- **Source line 24 appears to be blank *inside* the frontmatter**, immediately before the
  closing `---` at line 25. Transcribed as photographed; harmless in YAML but unusual, and no
  other agent file shows it.
- The handoff-3 emoji is mojibake and is recorded as a `<MOJIBAKE: emoji>` placeholder.

## Structural facts added by agent `OpX-dotnet-upgrade`

The most rigorously engineered file in the kit, and the only one that encodes hard-won
runtime-failure knowledge rather than style rules. 287 lines.

- **A third frontmatter variant**: opens with `---` like the other specialists, but has **no
  `user-invocable` field** (the two csharp specialists do). Same seven-tool list as those two.
- **All five handoffs are `send: true`** — the csharp specialists are all `send: false`, the
  P3 coordinator is all `send: false` for numbered steps, and P1/P2 are `send: true`. Four
  files, three different policies, none documented.
- **An eleventh agent: `OpX-QA-Run`** (backend-only test runner). Plus a **third unnumbered
  prompt directory**: `.github/prompts/qaTestPrompts/qa-hub-routing.prompt.md`, routed with a
  `::`-delimited workflow selector (`… :: [WORKFLOW] Backend - Upgrade .NET`).
- **Two orthogonal mode contracts** must be declared per run:
  - *Upgrade Mode* — `Retarget` (default, behavior-preserving, hold every package version
    constant) or `Modernize` (opt-in, operator-requested).
  - *Topology Execution Mode* — `RunnableRuntime` (host can be started and probed) or
    `ConstrainedLegacyHost` (classic System.Web/MVC/WebForms; cannot run as net10 in-place,
    and explicitly **must not** be called blocked just because probing is impossible).
- **`step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`)** — the Step 7 uplift
  happens in a separate mutable workspace defined by `Modernization-Execution-Contract.*`,
  never in place inside `LegacyCode/` and never in `src/`.
- **The single-version package consistency gate** is the standout piece of engineering:
  `verify-upgrade-invariants.ps1 -WorkspaceRoot … [-PublishDir …]`, `RESULT: OK` (exit 0)
  required to proceed, `RESULT: BLOCKED` (exit 2) on a split. Its rationale is written out:
  NuGet builds green when two projects reference different versions of one package, only the
  highest version ships to the run folder, and the other project then throws
  `MissingMethodException`/`TypeLoadException` at runtime — which the app's own error handling
  can disguise as an ordinary error status. Structural fix proposed: central package
  management via `Directory.Packages.props`.
- **The penetration-proof requirement**: an anonymous probe returning 401 proves auth is
  wired, not that upgraded code runs, because middleware rejects before controller logic.
  At least one real business route must be exercised under an authenticated context.
  Startup/request logs must be scanned for loader-class exceptions
  (`MissingMethodException`, `TypeLoadException`, `MissingFieldException`, `FileLoadException`,
  `FileNotFoundException`, "Could not load file or assembly") — any of which is a hard failure
  even on a healthy HTTP status. On a 500, read the response **body**, not the status.
- **A named, diagnosed regression**: on a 3.x → 8 jump, `Microsoft.Data.SqlClient` flips its
  `Encrypt` default from false to true (SqlClient 4.0+ arrives transitively via EF Core 7/8);
  restore with `TrustServerCertificate=True` on every affected connection string including
  `appsettings.Development.json`. This is real institutional knowledge, not generic advice.
- **A question-tool gate**: the first Step 7 action must confirm with the operator, via a
  strict clickable `Yes`/`No` question tool, that the current `src/` baseline builds locally.
  The `src/` gate is **attestation-only** — this lane must not run `dotnet build`,
  `dotnet run`, or HTTP probes against `src/`.
- A breaking-changes mapping table (`HttpContext.Current` → `IHttpContextAccessor`,
  `ConfigurationManager` → `IConfiguration`, `System.Web.Mvc`/`System.Web.Http` →
  `Microsoft.AspNetCore.Mvc`, `Global.asax` → `Program.cs`/`Startup.cs`, `Web.config` →
  `appsettings.json`), a 10-item Verification checklist, and a fixed `.NET UPGRADE COMPLETE`
  report template.

## ⚠ Findings in `OpX-dotnet-upgrade.agent.md`

**1. The mandatory question-tool gate is not in the declared tool list.**
The file says the *first* Step 7 action "must be a question-tool invocation … with strict
clickable `Yes`/`No` options (no freeform answer)", and that asking it as plain markdown is
"non-compliant". The seven declared tools are `edit/editFiles`, `read/readFile`,
`search/codebase`, `execute/runInTerminal`, `execute/getTerminalOutput`,
`read/terminalLastCommand`, `read/terminalSelection`. **No question tool.** The file already
contains a fallback for "if the host cannot render the question tool" — framing a missing
grant as an environment limitation. Same capability-gap class as P1 Discovery and P3 Review,
but this one is self-aware.

**2. `## Upgrade Mode Contract` is an empty shell; its subsections live under the wrong
parent.**
Line 46 `## Upgrade Mode Contract` contains one sentence ("Every run operates in exactly one
declared mode. Default to Retarget.") and no subsections. Line 50
`## Topology Execution Mode (required)` then owns **four** `###` subsections:
`RunnableRuntime`, `ConstrainedLegacyHost`, `Retarget (default)`, and `Modernize`. The last
two are upgrade modes, not topology modes. Any model reading structurally concludes Retarget
is a topology mode — and the two contracts are genuinely orthogonal, so conflating them is a
real comprehension hazard.

**3. PowerShell inside ` ```bash ` fences — third file with this pattern.**
`Get-ChildItem -Recurse -Filter "*.csproj" | Select-Object FullName` and
`./.github/scripts/QA/qa-run-dotnet-tests.ps1 -ProjectPath … -NoBuild` are both in bash
fences, while the adjacent SDK-instructions block correctly uses ` ```powershell `. Same
defect appears in `OpX-csharp-expert` and `OpX-csharp-janitor`.

**4. `step9UpgradeWorkspaceRoot` — the +2 drift baked into a variable name, but as a
*deliberate* shim.**
The pairing `step7UpgradeWorkspaceRoot` (fallback `step9UpgradeWorkspaceRoot`) appears four
times. Old Step 9 = new Step 7 under the +2 offset, so this is a backwards-compatibility
fallback someone wrote on purpose for artifacts produced under the old numbering. **This is
the first hard evidence that the kit authors knew about the renumbering** — which strengthens
the case that every *other* +2 reference is an unintentional leftover rather than a second
live numbering system. Do not "fix" this one; it is load-bearing.

## Structural facts added by agent `OpX-csharp-janitor`

Sibling specialist to `OpX-csharp-expert`, same shape, narrower job: safe, behavior-preserving
cleanup rather than violation remediation.

- **Same specialist frontmatter shape as `OpX-csharp-expert`**: opening `---` at line 1, a
  YAML comment (`# For the .NET cleanup step.`), `user-invocable: true`, and the identical
  seven-tool list (`edit/editFiles`, `read/readFile`, `search/codebase`,
  `execute/runInTerminal`, `execute/getTerminalOutput`, `read/terminalLastCommand`,
  `read/terminalSelection`). This confirms a genuine two-tier agent convention:
  coordinators (no opening `---`, browser tools, `agents: ["*"]`) vs specialists
  (opening `---`, `user-invocable`, edit + terminal only, no `agents` key).
- **Four handoffs, all `send: false`**, including a self-handoff (`Run Tests` →
  `OpX-csharp-janitor`) exactly mirroring the expert's. The specialists form a triangle:
  janitor → `OpX-csharp-expert` (Fix Code Violations), expert → `OpX-csharp-janitor`
  (Run Cleanup), and both → `OpX-AppMod-P2-Modernize` (Back To Phase 2 Workflow).
- **A second unnumbered prompt**: `.github/prompts/P2-Modernize/fix-violations.prompt.md`
  (the expert revealed `.github/prompts/P2-Modernize/cleanup.prompt.md`). The
  `P2-Modernize/` prompt folder therefore holds at least two prompts outside the numbered 24,
  and each is owned by the *other* specialist — the janitor routes to `fix-violations`, the
  expert routes to `cleanup`.
- **It also routes into the numbered pipeline**: `Upgrade .NET` →
  `OpX-dotnet-upgrade` running `07-P2-backend-upgrade-dotnet.prompt.md`.
- **Thirteen numbered cleanup tasks**, each a `[BAD]`/`[GOOD]` pair: remove unused usings
  (IDE0005), sort usings (System first then alphabetical), remove unused variables (CS0219),
  remove unused private members (IDE0051), simplify null checks (`?.`/`??`), expression-body
  members, object initializers, collection expressions (C# 12+), pattern matching (including
  switch expressions), string interpolation, `nameof()`, remove commented-out code, remove
  empty regions.
- **Emoji-free and mojibake-free**, like `OpX-csharp-expert`. Both specialists use literal
  `[BAD]`/`[GOOD]` markers.

## ⚠ Findings in `OpX-csharp-janitor.agent.md`

**1. The file is currently broken. VS Code reports three errors in it.**
This is the first transcribed file with objective evidence of being invalid rather than
merely inconsistent: the editor tab reads `OpX-csharp-janitor.agent.md 3` and the status bar
shows `⊗ 3  ⚠ 0`. The three errors correspond to three YAML indentation faults in the
`handoffs:` block, at source lines 16, 18 and 20:

```yaml
handoffs:
  - label: "Back To Phase 2 Workflow"
        agent: OpX-AppMod-P2-Modernize          # line 16 — over-indented
      prompt: "Cleanup complete. Continue the Phase 2 workflow from the next required step."
  send: false                                    # line 18 — under-indented, escapes the mapping
  - label: "Run Tests"
        agent: OpX-csharp-janitor                # line 20 — over-indented
    prompt: "Run ./.github/scripts/QA/qa-run-all-tests.ps1."
    send: false
```

The last two handoffs (`Upgrade .NET`, `Fix Code Violations`) are correctly indented. If the
frontmatter fails to parse, this agent has no tool allowlist and no handoff menu at runtime.
**This one is not a judgement call and not a style preference — it is a broken file sitting in
`.github/agents/`, and it should be fixed before anyone runs the kit.**

**2. The mission places the janitor before modernization; every route into it arrives after.**

> **Your Mission** — Clean up the codebase **before major modernization work**.

But `OpX-AppMod-P2-Modernize` states that `Optional Run Cleanup` "never replaces any numbered
modernization or review step, and **Step 24 owns cleanup** once review reaches the technical
gate", and `OpX-csharp-expert` reaches the janitor via its `Run Cleanup` handoff *after*
fixing violations. So the agent's self-description says "before" while the kit's routing puts
it at the end. Its own `Upgrade .NET` handoff (to Step 7) is the only thing consistent with
"before".

**3. Section 13 does not do what its title says.**
The heading is `### 13. Remove Empty Regions`, but the `[BAD]` example includes a region that
is *not* empty, and the `[GOOD]` fix is captioned "Just remove regions entirely":

```csharp
#region Properties
public string Name { get; set; }     // not an empty region
#endregion
```

Removing all `#region` markers is a defensible house style, but it is a different, broader
change than "remove empty regions" — and it is the kind of edit a developer will be surprised
by in a diff. The title and the rule need to agree.

**4. No `## Workflow` and no `## Output` section — unlike its sibling.**
`OpX-csharp-expert` ends with a Workflow (read finding → find file → apply fix → run tests →
pass/fail branch), an `After Each Fix` regression-test step, and a fixed `CODE VIOLATIONS
FIXED` report template. The janitor has none of the three. It has a `Run Tests` handoff but no
instruction to use it, no completion report, and no definition of done. Two sibling
specialists with the same frontmatter and opposite levels of procedural rigour.

**5. `Select-String` invoked inside a ` ```bash ` fence** — the same bash/PowerShell confusion
found in `OpX-csharp-expert`:

```bash
dotnet build --no-incremental 2>&1 | Select-String "IDE0005"
```

## Transcription uncertainties (agent `OpX-csharp-janitor`)

- Line alignment was spot-verified against the source at 18 anchors — 33, 37, 41, 43, 60, 67,
  80, 99, 118, 135, 158, 176, 188, 213, 224, 236, 262, 275 — all matching. Content ends at
  275; the editor shows blank lines through 277.
- **The exact indentation on source lines 16, 18 and 20 is approximate.** Column positions
  were read from glyph offsets in the photo, so the reproduced space counts may be off by a
  character or two. What is *not* approximate is that those three lines are misaligned
  relative to their siblings and that the editor reports exactly three errors — the count
  matches the three anomalies one-for-one.
- No mojibake anywhere in this file; nothing was placeholder-substituted.
- The file was open with unsaved changes (dot on the tab) when photographed, so it may differ
  from the committed version in the kit repo.

## Structural facts added by agent `OpX-csharp-expert`

First **specialist** agent transcribed (the previous three are phase coordinators), and the
first file that reveals a second tier of kit structure.

- **Different file shape from the coordinators.** It opens with `---` at line 1, carries a
  YAML **comment** in the frontmatter (`# For the .NET coding-violations step.`), and
  declares `user-invocable: true` — a field none of the three coordinators has.
- **Seven tools**, and it is a *worker*: `edit/editFiles`, `read/readFile`,
  `search/codebase`, `execute/runInTerminal`, `execute/getTerminalOutput`,
  `read/terminalLastCommand`, `read/terminalSelection`. No `agent`, no `todo`, no `browser`.
- **Four handoffs, all `send: false`**, one of which is a **self-handoff** (`Run Tests` →
  `OpX-csharp-expert`). Exits are: back to `OpX-AppMod-P2-Modernize`, run tests, run
  Step 22 via `OpX-Code-Reviewer`, or run cleanup via `OpX-csharp-janitor`.
- **Two new agents named**: this file (`OpX-csharp-expert`) and `OpX-csharp-janitor`.
  Ten named agent surfaces are now known: the three phase coordinators,
  `OpX-dotnet-upgrade`, `OpX-Fusion-Reviewer`, `OpX-Code-Reviewer`, `OpX-QA-Hub`,
  `Ultimate-Ignition-edit`, `OpX-csharp-expert`, `OpX-csharp-janitor`.
- **There is an unnumbered prompt tree.** The cleanup handoff routes to
  `.github/prompts/P2-Modernize/cleanup.prompt.md` — a **subdirectory** under
  `.github/prompts/`, which breaks the flat `NN-Px-name.prompt.md` convention the 24
  numbered prompts follow. The kit therefore contains prompts outside the numbered
  pipeline, organised by phase folder.
- **New script**: `.github/scripts/QA/qa-run-all-tests.ps1`.
- **Six worked violation classes**, each as a `**Problem**` / `**Fix**` pair with `// [BAD]`
  and `// [GOOD]` markers and the matching `Program.cs` registration:
  DI violations → constructor injection; `.Result`/`.Wait()`/`async void` → async all the
  way; `new HttpClient()` → `IHttpClientFactory`; static mutable state →
  `IDistributedCache`; `User.IsInRole()`/`[Authorize(Roles=…)]` → policy-based
  authorization; `Console.WriteLine` → `ILogger` structured logging. Plus magic numbers →
  `IOptions<T>` + `appsettings.json`, and empty catch blocks → typed catch with
  `OperationCanceledException` re-throw.
- **A fixed report template** at the end (`CODE VIOLATIONS FIXED`, counts by severity with
  per-class breakdown, `Tests:` / `Build:` lines, `Ready for final acceptance review.`).
- **This file is completely free of emoji and of mojibake.** It uses literal `[BAD]`,
  `[GOOD]` text markers where other kit files use corrupted emoji. It is the cleanest file
  transcribed so far and a good model for de-emojifying the rest.

## ⚠ Findings in `OpX-csharp-expert.agent.md`

**1. The missing frontmatter delimiter in the three coordinators is now confirmed as a real
inconsistency, not a rendering artifact.**
This file's line 1 is `---`. `OpX-AppMod-P1-Discovery`, `-P2-Modernize` and `-P3-Review` all
begin bare at `name:`. Same directory, same editor, same photo session. Under a strict
frontmatter parser the three coordinators have no frontmatter at all — their `name`,
`description`, `tools`, `handoffs` and `agents` would be read as body text, which would mean
their tool allowlists and handoff menus never take effect. This supersedes the "possibly a
VS Code artifact" note recorded three times above.

**2. The mission contradicts its own priority list.**

> **Your Mission** — Fix **HIGH and MEDIUM** code violations from the baseline compliance review.
> **3. Prioritize fixes:** — CRITICAL first (security issues) / HIGH second (architectural
> violations) / **MEDIUM if time permits**

`CRITICAL` is outside the stated mission scope but is first in the priority list *and*
appears in the mandatory report template (`CRITICAL Fixed: 0`). And "MEDIUM if time permits"
walks back the mission's commitment to fix MEDIUM. A model reading the mission statement and
a model reading the checklist get two different jobs.

**3. Two severity vocabularies exist in the kit with no mapping between them.**

> **SUPERSEDED by `dominion-requirements/AppMod-Acceptance-Criteria.md`.** There are **three**
> ladders, and the canonical Dominion rubric has only three levels (Critical / High / Medium).
> This agent matches Dominion exactly; `appmod-compliance-review` adds an inert `LOW 0`; prompt
> 24's `P1-P4` adds a `P4` with no Dominion equivalent and never states a P-to-severity mapping.
> See the findings under the Dominion rubric.

This agent works in `CRITICAL / HIGH / MEDIUM`. Prompt 24 — the step that *invokes* violation
remediation — scores in `P1 / P2 / P3 / P4`. Nothing translates one to the other, so a P1
finding handed to this agent has no defined severity here, and this agent's `CRITICAL Fixed`
count has no slot in Step 24's report.

**4. Two different test commands for the same purpose, 12 lines apart.**
Workflow step 4 says run `./.github/scripts/QA/qa-run-all-tests.ps1`; the very next section,
`## After Each Fix`, says "Run tests to ensure no regressions:" → `dotnet test`. Both are
"run the tests after a fix". One is the kit's QA harness, the other is raw dotnet — and
`dotnet test` would skip the frontend suites entirely.

**5. A PowerShell script is invoked inside a ` ```bash ` fence.**

```bash
./.github/scripts/QA/qa-run-all-tests.ps1
```

Cosmetic on a dev box with pwsh on PATH, but it is the same class of error as the
`.feature` conflict: the prompt tells the model one thing and the runtime expects another.
The `Run Tests` handoff phrases it a third way ("Run ./.github/scripts/QA/qa-run-all-tests.ps1.").

**6. The Dominion skill path disagrees with the one referenced elsewhere.**
Here: `.github/skills/dominion-requirements/SKILL.md`. Elsewhere in the kit:
`/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md`. Both may exist, but
the agent is told to read "the Dominion requirements" and pointed at only one of them.

**7. It resolves the two-artifact-roots conflict — in favour of `ignition-artifacts`.**
It reads `.modernization/ignition-artifacts/discovery/baseline-review.json`, matching
prompt 04's header block rather than prompt 04's closure contract
(`.modernization/artifacts/reviews/baseline-review.json`). A useful vote when the single-root
decision gets made.

## Transcription uncertainties (agent `OpX-csharp-expert`)

- Line alignment was spot-verified against the source at 20 anchors — 33, 37, 41, 53, 58,
  60, 114, 164, 206, 246, 285, 303, 360, 396, 408, 415, 418, 419, 436, 437 — all matching.
  Content ends at 437; the editor shows blank lines through 439.
- **The fence block at source lines 49-52 is the one structurally odd spot.** It reads as
  an opening ` ``` ` at 49, a blank line at 50, the skill path at 51, and a closing ` ``` `
  at 52, with no blank line before `3. Prioritize fixes:` at 53 (unlike the item-1 block,
  which has one). The line numbers are forced by the verified anchors either side, but the
  blank-line-inside-the-fence reading is inferred from glyph positions rather than read
  cleanly. Note the item-1 block uses ` ```bash ` with a `cat` command while this one uses a
  bare fence with only a path — two different ways of saying "read this file".
- No mojibake anywhere in this file; nothing was placeholder-substituted.

## Structural facts added by agent `OpX-AppMod-P3-Review`

Third and shortest agent (82 lines vs 136 and 102). With all three phase coordinators in
hand, the set can be compared as a whole.

- **Every numbered step number in this file is correct.** The six handoff labels carry
  their step numbers as keycap emoji (19-24) and all six match their prompt filenames.
  After the +2 drift in P2 and prompt 24's five Step-23 self-references, this is the first
  file in the kit with zero numbering defects.
- **All six numbered review handoffs are `send: false`** — the exact inverse of P1 and P2,
  where every numbered step is `send: true`. Only the two QA helpers auto-send. This reads
  as deliberate: review gates require a human to pull the trigger, implementation steps do
  not. Worth confirming, because if it *is* deliberate it is a good pattern and should be
  stated somewhere rather than left implicit in three files.
- **Review steps fan out to three different specialist agents**, so the coordinator is a
  router rather than an executor: Step 19 → `OpX-Fusion-Reviewer`, Steps 20/21/23 → itself,
  Steps 22/24 → `OpX-Code-Reviewer`.
- **Step 20 is named the "technical falsification gate"** — it must run before visual,
  acceptance and readiness review continue. That gives Phase 3 an explicit fail-fast
  ordering rather than six equal-weight reviews.
- **Step 24 absorbed the optional helper lanes**: "the final technical quality and
  remediation gate, including bounded cleanup and code-violation fixes that were previously
  handled through optional helper lanes." This matches P2's statement that
  `Optional Run Cleanup` and `Optional Fix Code Violations` hand ownership to Step 24, and
  explains why prompt 24 both fixes and reports.
- **Sign-off framing**: "Treat final review outputs as sign-off evidence, not as exploratory
  analysis or a substitute for missing Phase 2 implementation work." Phase 3 cannot be used
  to finish Phase 2's job.

## ⚠ Findings in `OpX-AppMod-P3-Review.agent.md`

**1. Capability gap, and it is the worst of the three: no `edit`, and no `browser` either.**
Declared tools are exactly eight: `read/readFile`, `search/codebase`, `vscode/runCommand`,
`execute/runInTerminal`, `execute/getTerminalOutput`, `read/terminalLastCommand`,
`read/terminalSelection`, `agent`. But:

- Steps 19-24 must **write** durable JSON artifacts (`figma-review.json`,
  `final-review.json`, `deployment-readiness-review.json`, `FINAL-COMPLIANCE-REPORT.json`)
  and update `step-response-ledger.json` and `step-workflow-state.json`. No `edit` tool.
- **Step 21 is a browser-led visual review gate.** Prompt 21 declares `browser` and
  `figma/*` in its own frontmatter and requires screenshot evidence per route. The
  coordinator agent that runs it declares no browser tool at all.

Combined with the same finding in P1 Discovery, **two of the three phase coordinators
cannot write files, and the one that owns the screenshot gate cannot open a browser.**
Only P2 declares `edit`. This is now the highest-priority defect class in the kit — it is
not a numbering nit, it is agents lacking the capability to do their stated job.

**2. `QA Portal Full Refresh` hands Phase 3 control to the Phase 2 coordinator.**

```yaml
  - label: "<emoji> QA Portal Full Refresh"
    agent: OpX-AppMod-P2-Modernize      # <- in the Phase 3 agent
```

In P1 this handoff points at `OpX-AppMod-P1-Discovery`; in P2 at
`OpX-AppMod-P2-Modernize`. P3's copy also points at `OpX-AppMod-P2-Modernize` — it was
copied from the P2 file and the `agent:` line was not updated. A developer refreshing the
QA portal during final review is silently switched to the Phase 2 coordinator, which is
the agent whose own rules say Phase 2 is execution-only.

**3. Still no Write Boundary section.** Only `OpX-AppMod-P1-Discovery` has one. Two of
three coordinators say nothing about protected toolkit roots. (For P3 the practical risk is
lower, since it has no `edit` — but that is finding 1, not a mitigation.)

**4. Two rules are stated twice inside this one file.**
Line 68 and line 78 are both "return the full shared chat contract response shape for
numbered-step replies, including short completion follow-ups" (the second prefixed
"Always"). Line 63 and line 82 both say "Treat final review outputs as sign-off evidence,
not as exploratory analysis" — the second is a truncated copy that drops the "or a
substitute for missing Phase 2 implementation work" clause. The entire `Phase-Specific
Notes` section is that one duplicated bullet. Duplicated rules that differ slightly are how
contradictions start.

## Transcription uncertainties (agent `OpX-AppMod-P3-Review`)

- Same as P1 and P2: **no opening `---` frontmatter delimiter** — line 1 is
  `name: OpX-AppMod-P3-Review`, closing `---` at line 46. All three coordinators show this.
  > **SUPERSEDED by `OpX-csharp-expert`**: that file, in the same directory and the same
  > photo session, *does* open with `---` at line 1. So this is a real inconsistency
  > between coordinator and specialist agents, not a kit-wide convention and not a VS Code
  > rendering artifact. See the findings under `OpX-csharp-expert`.
- Handoff labels contain both a leading pictographic emoji and a two-digit keycap sequence
  (e.g. `1️⃣9️⃣`); both are mojibake in the photo and are recorded as
  `<MOJIBAKE: emoji>` / `<MOJIBAKE: keycap NN>` placeholders. The keycap digits were
  legible enough to confirm every step number.
- File content ends at line 82; the editor shows line 83 blank.

## Structural facts added by agent `OpX-AppMod-P2-Modernize`

Second agent transcribed. Same file shape as P1 Discovery, but the differences between the
two are more informative than either file alone.

- **`tools` is a YAML block list here, not the inline array P1 Discovery uses** — same
  field, two different syntaxes across two files in the same directory.
- **P2 has `edit`; P1 Discovery has no editing tool at all** (see the finding below).
  P2 also declares coarse-grained `vscode`, `browser`, `agent` entries *alongside* their
  fine-grained forms (`vscode/runCommand`, `browser/readPage`, `agent/runSubagent`) —
  redundant, and it means the broad grants are what actually apply.
- **15 handoffs**: a `Refresh Discovery Planning Gate` recovery route, the twelve numbered
  Steps 7-18, `QA Portal Full Refresh`, and `QA Test Hub`.
- **`Refresh Discovery Planning Gate` is the only handoff in either agent with `send: false`**,
  and the only one that dispatches *backwards across a phase boundary* — to
  `OpX-AppMod-P1-Discovery` running prompt 06. Not auto-sending a cross-phase rollback is
  the right call; it makes re-opening Discovery a deliberate human act.
- **A hard backend-before-frontend gate**: "Treat Step 7 through Step 9 as the required
  backend gate before Step 10 through Step 18. Do not route frontend formation or
  migration until backend upgrade, backend formation in `src/`, and backend integration
  hardening are truthfully complete or the blocker is explicit."
- **Phase 2 is declared execution-only**: "implement against Discovery-owned inventories,
  plans, and catalogs; do not derive new legacy scenarios in this phase." This is the
  counterpart to P1's ownership-reclamation rule and it names the exact upstream owner for
  each missing-input class — Step 3/4 for baseline or inventory evidence, Step 5/6 for
  planning or QA-design derivation.
- **Generic browser-source decomposition**: MVC/Razor decomposition prompt for
  server-rendered sources, Angular/browser-client decomposition prompt for SPA sources,
  and mixed/hybrid/already-modern surfaces treated as validation or consolidation cases —
  explicitly "instead of inventing a second frontend lane."
- **Two more instruction surfaces named**:
  `/.github/instructions/fusion-mcp-restructure.instructions.md` and
  `/.github/skills/fusion-feature-standards/SKILL.md`, both required before "inventing
  custom platform code" for Fusion-owned platform, startup, auth, HTTP, or UI decisions.
- **Named optional lanes**: `Optional Run Cleanup`, `Optional Fix Code Violations`,
  `QA Portal Full Refresh`, plus a "retired browser-specialist slice-loop lane" that must
  not be revived as a second frontend execution surface.
- **Step 24 is referenced correctly twice** ("Step 24 owns cleanup once review reaches the
  technical gate", "Step 24 owns violation remediation…"). Independent corroboration that
  prompt 24 — which calls itself Step 23 five times — is the stale file, not this one.

## ⚠ Findings in `OpX-AppMod-P2-Modernize.agent.md`

**1. Smoking-gun drift pair: the same three artifacts cited with a +2 difference, in the
same file.**

> Line 113: "If **Step 6, Step 7**, or `Modernization Quality Design` artifacts are missing,
> stale, or contradictory, route back to Discovery…"

> Line 131: "`Refresh Discovery Planning Gate` is the recovery route when **Step 4, Step 5**,
> or `Modernization Quality Design` inputs are no longer trustworthy enough…"

Both sentences name the same set — the baseline-acceptance artifact, the solution-design
artifact, and the Quality Design pack — as the Discovery inputs Phase 2 depends on. Under
current numbering those are Steps 4, 5 and 6, so **line 131 is correct and line 113 is +2**.
This is the same adjacent-reference proof found in prompt 21, and it confirms the
renumbering was applied per-line rather than per-file.

Two more lines carry the +2 form: line 112 cites "the **Step 7** execution-contract and
control-point decisions" (the target-state contract is Step 5's output — and prompt 22
repeats this same "Step 7 target-state contract" phrasing, so the error is consistent
across files), and line 116 drives the browser lane from "the current **Step 5 and Step 7**
evidence" (legacy analysis is Step 3, solution design is Step 5). Meanwhile lines 114, 115,
117, 118, 119, 131-136 are all correct under current numbering. Roughly a quarter of this
file's step references are stale.

**2. P1 Discovery declares no file-editing tool, yet its own text says it writes artifacts.**
This is a cross-file finding, visible only now that a second agent exists for comparison.
`OpX-AppMod-P2-Modernize` declares `edit`. `OpX-AppMod-P1-Discovery` declares no `edit`
entry of any kind — yet its Write Boundary section states that
"`.modernization/portal/**`, `.modernization/ignition-artifacts/**` … **are still writable
by this agent as needed by the active step**", and Discovery steps 1-6 are required to
produce inventory, baseline and planning artifacts. Either P1 is silently relying on
`execute/runInTerminal` to write files — which would make its own "do NOT use `Set-Content`
/`Out-File`/`Add-Content`" prohibition the *only* write path it has, aimed at the wrong
target — or the `edit` grant was dropped by accident. This is a hard blocker for Phase 1,
not a lint nit.

**3. Phase 2 has no Write Boundary section at all.**

> **CORRECTED by `agent-toolkit-protection.instructions.md`.** That file carries
> `applyTo: ".github/agents/*.agent.md"`, so the toolkit-edit boundary auto-applies to **every**
> agent, P2 and P3 included. They are not unprotected. The real defect runs the other way:
> `OpX-AppMod-P1-Discovery` **duplicates** the shared rule inline, which is exactly what
> `agent-process-conformance` forbids ("do not copy the same generic boilerplate … when the
> shared contract already covers it"). The duplicate has already drifted — P1's inline copy lists
> `.modernization/ignition-artifacts/**` twice, a defect the shared file does not have.
P1 Discovery devotes 18 lines to protected toolkit roots and the all-mechanisms
prohibition. P2 Modernize — the phase that actually rewrites the application, has `edit`,
and runs twelve steps — has **no equivalent section**. The agent most able to damage
`.github/**` is the one with no rule against it. Whatever the shared
`appmod-phase-agent-contract.instructions.md` says, the asymmetry between the two files is
itself the risk: a reader of either file draws opposite conclusions about what is protected.

**4. `QA Test Hub` here *does* carry `send: true` — so P1's missing one is an oversight.**
The same handoff in `OpX-AppMod-P1-Discovery` omits `send: true`; here it is present. The
prompt text also differs between the two ("Open QA Hub and route through the current
workflow catalog." vs "Open the QA Hub"). Two copies of one handoff, diverging in both
fields. Resolves finding 3 in the P1 section: it is drift, not intent.

**5. Coarse and fine tool grants are both declared.**
`edit`, `todo`, `vscode`, `browser`, `agent` appear as bare entries *and* as
`vscode/runCommand`, `browser/openBrowserPage`, `agent/runSubagent`, etc. The bare grants
supersede, making nine of the fine-grained entries decorative — and making the file read as
more restricted than it is.

## Transcription uncertainties (agent `OpX-AppMod-P2-Modernize`)

- Same as P1: **no opening `---` frontmatter delimiter** — line 1 is
  `name: OpX-AppMod-P2-Modernize`, closing `---` at line 90. Transcribed as photographed.
  Two agent files now show this, which makes a VS Code rendering artifact less likely and a
  real convention (or a real defect) more likely.
- Handoff label emoji are mojibake; recorded as `<MOJIBAKE: emoji>` placeholders.
- Lines 112-121 and 131-136 wrap in the editor; reconstructed from wrap positions.
- File content ends at line 136; the editor shows blank lines through 140.

## Structural facts added by agent `OpX-AppMod-P1-Discovery`

First agent file transcribed. Agents are a **different file shape** from prompts and carry
routing behavior the prompts do not.

- **Location**: `.github/agents/<Name>.agent.md`. Frontmatter fields observed:
  `name`, `description`, `tools` (single-line JSON-ish array, not the YAML block list the
  prompt files use), `handoffs`, `agents`.
- **`tools` is a flat inline array of 18 entries** — a *superset* of what any single P1
  prompt declares: `vscode/runCommand`, `execute/getTerminalOutput`, `execute/runInTerminal`,
  `read/readFile`, `read/terminalSelection`, `read/terminalLastCommand`, `agent/runSubagent`,
  `search/codebase`, and the full browser family (`openBrowserPage`, `readPage`,
  `screenshotPage`, `navigatePage`, `clickElement`, `dragElement`, `hoverElement`,
  `typeInPage`, `runPlaywrightCode`, `handleDialog`).
- **`handoffs` is the UI menu** the coordinator renders: 8 entries, each with
  `label` (emoji + step title), `agent`, `prompt` (a literal "Use .github/prompts/NN-….prompt.md
  and execute it in full." sentence), and `send: true`. This is how a step is launched —
  the coordinator does not contain step logic, it dispatches to the numbered prompt file.
- **Handoff prompt strings are the canonical filename list**, and they match the 6 P1
  prompt filenames exactly as transcribed (`01-P1-workstation-readiness` …
  `06-P1-modernization-quality-design`).
- **Two non-numbered handoffs** exist alongside the six steps:
  `QA Portal Full Refresh` → `run .\.github\scripts\QA\qa-refresh-portal.ps1 -AutoRefresh`,
  and `QA Test Hub` → agent `OpX-QA-Hub`.
- **A seventh agent exists**: `OpX-QA-Hub` (previously unseen; the six known were
  `OpX-AppMod-P1-Discovery`, `OpX-dotnet-upgrade`, `OpX-AppMod-P2-Modernize`,
  `OpX-Fusion-Reviewer`, `OpX-AppMod-P3-Review`, `OpX-Code-Reviewer`).
- **An eighth named surface exists**: `Ultimate-Ignition-edit` — the *only* identity
  permitted to modify toolkit files. Referenced as the escalation target when a phase
  agent must refuse a protected write.
- **`agents: ["*"]`** — this coordinator may delegate to any agent.
- **The Write Boundary is a first-class contract**, and it is enforced against *mechanisms*,
  not just file edits: no `Set-Content`/`Out-File`/`Add-Content`/`tee` into `/.github/**`,
  no invoking a script that writes there as a side effect, no `git` staging of toolkit files.
  Protected roots: `/.github/**`, `/.modernization/.readme/**`, `/.modernization/OpXUtil/**`,
  `/.vscode/**`. This is the strongest anti-drift control seen in the kit so far and it
  lives in the agent, not the prompts.
- **Two routing authorities are named**: `/.github/instructions/AppMod-Step-Contract.json`
  (machine routing) and `/.github/instructions/AppMod-Process.instructions.md`
  (human-readable phase authority). Note this is a *different* path family from the
  `.github/contracts/schemas/` referenced by the prompts.
- **Three-layer instruction inheritance, with explicit precedence**:
  `appmod-agent-personality-baseline.instructions.md` (baseline) →
  `appmod-phase-agent-contract.instructions.md` (overrides baseline for numbered-step
  behavior, QA flow, response shape) → local agent rule / routed prompt / narrower
  instruction file (overrides when more specific).
- **Discovery is explicitly a proof-and-planning phase, not a code-fix phase**: no edits to
  `LegacyCode/` or `src/`, and no rewriting `.github/` "just to make a Discovery step pass."
  Blocked-with-exact-file is the required response instead.
- **Ownership reclamation rule**: if a later phase reports a missing inventory fact, baseline
  input, planning decision, or catalog rule, the fix routes *back* to the owning Discovery
  step rather than being patched into Phase 2/3. This is the mechanism that makes
  "one concern per step" hold across phases.
- **Step 6 is the named Discovery completion gate** before Step 7 backend execution, and it
  is the canonical owner of the QA planning pack (reading `qa-core-master.prompt.md`, then
  reusing `[WORKFLOW] Modernization Solution Design` and
  `[WORKFLOW] Modern Build Planned QA Tests`) without reassigning QA ownership back to Step 5.
- **Retired numbered runtime steps**: manual starter verification and copied-legacy
  verification now happen *before Step 2* rather than as standalone numbered prompts;
  Step 1 owns the workstation/manual verification gate.

## ⚠ Findings in `OpX-AppMod-P1-Discovery.agent.md`

Three defects, one of them the same +2 drift signature found across the prompts.

**1. +2 numbering drift — seventh confirmed instance, and the first one found in an agent file.**
Line 83, Response Contract:

> When `Modernization Quality Design` is the required follow-up, say that plainly instead of
> implying **Step 9** can start directly from **Step 7**.

`Modernization Quality Design` is Step 6. It sits between Step 5 and Step 7. The sentence is
only coherent as *"instead of implying Step 7 can start directly from Step 5."* Both numbers
are exactly +2. This is the same offset proven in prompts 12-16, 19, 20, 21 and acknowledged
in prose by prompt 22 — so the renumbering missed the agent files as well as the prompt
bodies. The linter must sweep `.github/agents/**`, not just `.github/prompts/**`.

**2. A duplicated path in the writable-areas allowlist.**
Line 77 lists `.modernization/ignition-artifacts/**` **twice**:

```
(`.modernization/portal/**`, `.modernization/ignition-artifacts/**`,
 `.modernization/ignition-artifacts/**`, `.modernization/ignition-artifacts/discovery/**`,
 `.modernization/ignition-artifacts/modernize/fusion-restructure/**`)
```

Harmless at runtime (the broad glob already covers the two narrower ones), but it is a
tell: the list was hand-edited during the artifact-root migration and one entry was meant
to be a different root. Given that prompts 04 and 22 each name *two different roots for the
same file* (`.modernization/ignition-artifacts/…` vs `.modernization/artifacts/…`), the
likely intent was for one of these to be `.modernization/artifacts/**`. Worth resolving as
part of the single-artifact-root decision rather than just deduping.

**3. The `QA Test Hub` handoff is missing `send: true`.**
Every other handoff in the file — all six numbered steps and `QA Portal Full Refresh` —
ends with `send: true`. The eighth and last one does not:

```yaml
  - label: "<emoji> QA Test Hub"
    agent: OpX-QA-Hub
    prompt: "Open QA Hub and route through the current workflow catalog."
agents: ["*"]
```

It is also the only handoff that dispatches to a *different* agent, so it may be
deliberate (hand off without auto-sending). Flagged rather than corrected — needs a
one-line answer from the kit owner.

> **RESOLVED by `OpX-AppMod-P2-Modernize`**: the same `QA Test Hub` handoff in the P2 agent
> *does* carry `send: true`, and its prompt text differs too ("Open the QA Hub" vs
> "Open QA Hub and route through the current workflow catalog."). Two copies of one
> handoff, diverging in both fields — so this is drift, not intent.

## Transcription uncertainties (agent `OpX-AppMod-P1-Discovery`)

- **No opening `---` frontmatter delimiter.** Line 1 of the file is `name: OpX-AppMod-P1-Discovery`
  and the closing `---` is at line 37. Every prompt file transcribed so far opens with `---`
  at line 1. Transcribed exactly as photographed (no opening delimiter) rather than
  "corrected", per the standing rule — but this is worth verifying on the real file, since
  it is equally likely to be a VS Code rendering artifact.
- **Handoff label emoji are mojibake in the photo** and are recorded as
  `<MOJIBAKE: emoji>` placeholders, the same convention used in the prompt transcriptions.
  Best-guess readings from glyph shape: Step 1 monitor, Step 3 magnifier, Step 4 green
  check, Step 5 ruler/triangle, Step 6 grid, QA Test Hub pencil. Not asserted.
- Line 3 (`tools:`) wraps in the editor; the array order was reconstructed across the wrap
  boundary (`…browser/screenshotPage,` → `browser/navigatePage,…`).
- Line 77 wraps; reconstructed from wrap position.
- File content ends at line 102; the editor shows blank lines through 113.

## Structural facts added by prompt 24

Step 24 `Technical Review - S-Tier Quality Gate` is the largest prompt in the kit
(1251 source lines vs ~570 for the next largest) and the only one that is a **scored
rubric** rather than a gated procedure.

- **Agent**: `OpX-Code-Reviewer`. **Tier**: Premium reasoning (high thinking), 15-30 min.
- **Nine weighted categories summing to exactly 100%**: Parity 20, Functionality 18,
  Dominion/Fusion Compliance 15, Code Quality 12, Security 12, Testing 10, Architecture 5,
  OCP Cloud & DevOps 5, Production Readiness 3.
- **GO/NO-GO thresholds**: 90-100 GO, 80-89 "Close", <80 "Work needed".
- **Step 24 Remediation Contract** with a disposition ledger of `Resolved` / `Deferred` /
  `Blocked` / `AcceptedRisk` — the only step that both *fixes* and *reports*.
- **Scope fence**: "PROJECT CODE ONLY" (`src/<AppName>.Library`, `.Web.Api`, `.Web.Client`,
  `tests/backend`, `tests/frontend`) vs "DO NOT TOUCH" kit infrastructure.
- **Emoji Integrity Check (Tooling)** — an embedded PowerShell repair that reads a file as
  Latin1, re-decodes as UTF-8, and rewrites it when the round-trip differs. See the
  finding below: it is scoped to the wrong directory.
- **Step Verification Matrix** — a 14-row artifact-existence table spanning the whole
  pipeline, used as a cross-step completeness check at the end of the run.
- **Testing section is Playwright + Gherkin/BDD**, with a Page Object Model contract
  (`BasePage.ts`, `<Feature>Page.ts`, no raw locators in test files), a STRICT locator
  policy (`getByRole` preferred, `getByTestId` **required on every testable element**,
  no CSS selectors, no XPath, no `nth-child`), and a mandate that every Angular button,
  input, link, custom component, and dialog carry **both** `aria-label` and `data-testid`.
- **xUnit backend contract**: `tests/backend/{unit,contractApi,integrationBackend}/`,
  BDD naming (`Given_When_Then` or `Method_Scenario_Result`), `[Fact]`/`[Theory]`,
  Moq or NSubstitute, FluentAssertions, >80% coverage on business logic.
- **Durable output is markdown, not JSON** — the only step in the kit that writes one:
  `.modernization/ignition-artifacts/technical-review-report.md`, with **append-history
  semantics** ("don't overwrite previous runs, add to history table"), ISO timestamps,
  raw scan output in a collapsed `<details>` block, and per-category deltas.
- **Recheck Mode** — a second run reads the previous report, re-scans, and reports
  Resolved / Remaining / New Issues plus an updated recommendation. No other step has a
  re-entrant mode.
- **Issue-to-Step Mapping Reference** — a 16-row table mapping each defect class to the
  numbered step that owns the fix, with a one-line rationale per row. This is the single
  most useful anti-drift artifact found anywhere in the kit: it converts "here is a defect"
  into "re-run step N", which is exactly the routing a hackathon participant needs.
  Its step numbers are **correct** under current numbering (7, 8, 9, 10, 11, 12, 13, 15,
  17, 18) — notably the only place in prompt 24 where they are.
- **ROI Calculation** — an explicit prioritization formula:
  `ROI Score = (P1 fixed × 5 + P2 fixed × 3 + P3 fixed × 1) / estimated minutes`,
  with the rule "always recommend the step with the highest ROI Score first." Remediation
  ordering is therefore deterministic rather than model judgement.
- **Severity ladder P1-P4** with worked definitions (P1 Blocker: security gaps, async
  anti-patterns, missing Fusion, no health checks → P4 Polish: comments, formatting).
- **Two worked example outputs** — a 15-issue "72/100 NO-GO" case and a 3-issue
  "96/100 GO" case — so the model has calibration anchors for the score, not just a rubric.
- **Accessibility Coverage is a reported metric**, targeting **100%** of interactive
  elements carrying both `aria-label` and `data-testid`.
- **`**Pick fixes**` interaction contract** — the report ends by inviting a natural-language
  fix selection ("Fix #1, #5, #12" / "Fix all P1" / "Fix #1-8").

## ⚠ Findings in prompt 24

**1. The `.feature` file contradiction — the worst conflict found in the kit, and it is
structural, not a stray sentence.**
Step 24 requires Gherkin in two independent places. §6 requires `.feature` files plus a
`steps/` directory of Cucumber definitions, and the Playwright Checklist independently
scores:

```
- [ ] Feature files in `features/` directory
- [ ] Step definitions in `steps/` directory
- [ ] Every user-facing feature has a `.feature` file
- [ ] Scenarios use Given/When/Then syntax
- [ ] Tags: `@smoke`, `@regression`, `@journey`, `@critical`
- [ ] Step definitions match feature file steps
```

Steps 12 and 17 (Gate 9) explicitly forbid `.feature` files ("NO .feature files").
**No repository state satisfies both.** Because Gherkin is load-bearing in a *scored*
category (Testing, 10%), every participant who follows Steps 12/17 correctly will take an
unavoidable deduction at Step 24. This needs a human decision — either Step 17 stops
forbidding `.feature` files, or Step 24's §6 and checklist are rewritten to score
Playwright-without-Gherkin. A linter cannot resolve it.

**2. Prompt 24 refers to itself as Step 23 — five times, and one of them dates the file.**

```
**If NO-GO**: Fix issues in priority order, then rerun Step 23.
**If CLOSE**: Fix P1s only, then rerun Step 23.
**If GO**: Proceed to Step 23/23 sign-off.
*This report can be referenced before rerunning Step 23 to track progress.*
When user says "recheck" or runs Step 23 again:
```

These are **-1** self-references, a different signature from the +2 drift elsewhere, and
they are operationally live: both the What's-Next block and Recheck Mode instruct the agent
to re-run "Step 23", which is *Final Readiness Review* — a different prompt, a different
agent, and a different artifact. A NO-GO verdict therefore routes the developer to the
wrong step.

**`Proceed to Step 23/23 sign-off` is the most informative line in the file.** `23/23` is
an "N of N" progress indicator, so **the pipeline had exactly 23 steps when this prompt was
written, and this prompt was the last of them.** That dates the file and explains the
self-references: it was Step 23 of 23, a step was later added ahead of it, and the title
and frontmatter were updated while every internal reference was left behind.

Note this runs *opposite* to the +2 drift in the frontend block (where old numbers are
higher than new) and to the +1 drift in this same file's Step Verification Matrix. At least
two independent renumberings, in opposite directions, are visible — which is why the linter
must compare against the **declared** step number of each file rather than assume a single
global offset.

**3. A second, distinct +1 drift confined to the Step Verification Matrix's Discovery rows.**
The matrix reads `3 | Rename complete`, `4 | Legacy analysis`, `6 | Solution design` —
but those are Steps 2, 3 and 5. Every row from 7 onward is correct. Two separate
compressions are therefore visible in one file.

**4. The kit's own emoji-repair script is pointed at the wrong directory.**
The Emoji Integrity Check does exactly the right Latin1→UTF-8 round-trip repair, but:

```powershell
$agentFiles = Get-ChildItem .github/agents -Filter *.agent.md -File -ErrorAction SilentlyContinue
```

It only scans `.github/agents`. The corruption is in `.github/prompts` — which is precisely
why every prompt file transcribed here still shows mojibake. One-line fix:
`Get-ChildItem -Path .github/prompts,.github/agents -Filter *.md -File -Recurse`.

**5. Capability gap: the frontmatter cannot run what the body demands.**
Declared tools are `agent`, `browser`, `edit/editFiles`, `todo`, `vscode/vscodeAPI`,
`fusion/copilot-docs/*`. The body is almost entirely PowerShell scans and requires reading
source files — yet `execute/runInTerminal`, `read/readFile`, and `search/codebase` are all
absent. This is the most severe capability gap in the kit (prompt 23 is missing
`read/readFile` + `search/codebase`; prompt 24 is missing those *plus* terminal execution).

**6. The durable report escapes the `reviews/` convention.**
Every other review artifact lands in `.modernization/ignition-artifacts/reviews/`.
Step 24 writes `.modernization/ignition-artifacts/technical-review-report.md` — bare, at
the artifacts root, and in markdown rather than JSON.

**7. Sub-step numbering collides with pipeline-step numbering.**
Within prompt 24 the internal procedure is labelled "Step 2: Create Persistent Report File"
and "Step 3: Recheck Mode". These are sub-steps of prompt 24 itself, but they share a
namespace with pipeline Steps 2 and 3 (rename starter / legacy analysis). Given the file
already misnumbers itself, this is a live ambiguity for an agent reading it.

**8. Loose step-range references.** `**Backend Architecture** (Steps 5-9)` — backend
formation spans 7-9; Step 5 is solution design. Similar loose ranges appear as
`Frontend Architecture (Steps 10-14)`, `OCP Cloud Checklist (Steps 18, 23)`,
`Production Checklist (Steps 18, 20, 23)`, `xUnit Backend Checklist (Steps 7-9, 17)`.

**9. Nested triple-backtick fences will truncate the report template.**
The Report File Template opens a fence at source line 1125:

```
1125  ```markdown          <- outer fence opens
1137  ```                  <- ASCII scorecard fence — CLOSES the outer block
1147  ```                  <- intended to close the scorecard, actually REOPENS
```

Because both fences are three backticks, the outer ```markdown block terminates at 1137
rather than at its intended end. Any model or renderer parsing this prompt sees the
Summary Dashboard onward as *outside* the template. The fix is to make the outer fence
four backticks (or use `~~~` for the inner one). This is a live parsing defect in the
mandatory report schema, not a cosmetic issue.

**10. Gherkin is required in a third independent place — and attributed to Step 10.**
The Issue-to-Step Mapping Reference routes missing Playwright tests to Step 10 with the
rationale **"Foundation creates POM/Gherkin scaffold."** So Step 24 now asserts Gherkin
in §6, in the Playwright Checklist, *and* as a Step 10 deliverable — against Steps 12 and
17, which forbid `.feature` files outright. Whatever decision is made about finding 1 has
to be applied in three places in this file plus Step 10's description of its own scaffold.

**11. The category weights are stated three times in one file.**
Once in the nine scored section headers (`## 1. Parity (20%)` …), once in the
`## Category Weights` table at line 992, and once in the `## Category Breakdown` report
template at line 1034. Three copies of the same numbers is three chances to drift; one
should be the source and the others should be generated or removed.

## Transcription uncertainties (prompt 24)

- **Complete.** Line alignment was spot-verified against the source at 16 headings —
  860, 862, 864, 906, 917, 992, 1008, 1050, 1094, 1107, 1121, 1135, 1157, 1182, 1196,
  1240 — all matching. Transcribed content ends at 1247; the source shows blank lines
  through 1251.
- Lines 571-863 were photographed twice; the second batch was diffed against the first
  transcription and matched line-for-line with zero corrections.
- **Source line 879 is transcribed as `...` (an ellipsis marking omitted table rows), not
  as a closing code fence.** At photo resolution the two are indistinguishable, but the
  reading is forced by fence balance: line 864 opens ```` ```markdown ```` and line 884
  closes it, and the same `...` convention appears unambiguously at line 1056 in the
  Issue List template. It is also consistent with the block's own heading
  ("Found: 15 issues" above a 10-row table).
- Emoji throughout are mojibake in the source itself (UTF-8 read as Windows-1252) and are
  recorded as `<MOJIBAKE: emoji>` placeholders. The mojibake marker inside the Emoji
  Integrity Check's own `-match` pattern was replaced with `<MOJIBAKE MARKER>` rather than
  transcribed literally, to avoid propagating the corrupted byte sequence into this repo.
- Scope bullets render their leading glyph as `?` in the photos (e.g. `? src/<AppName>.Library/`);
  preserved as photographed.
- The History table's Delta cell shows a mojibake glyph before `X`
  (`| Previous | [date] | [X] | [X] | [<MOJIBAKE: emoji>X] |`).
- Recheck-example delta cells likewise contain mojibake arrows/checks
  (`| Score | 72 | 86 | <MOJIBAKE: emoji> +14 |`).
- File content ends at source line 1251.

## Structural facts added by prompt 23

- **The release-decision gate.** Back to `OpX-AppMod-P3-Review`. Balanced tier, 10-20 min,
  72 lines. H1 is `# Final Readiness Review` (no step-number prefix, as in 21-22).
- **No handoff status — it terminates the chain.** Every prior step declared a
  `step<N+1>HandoffStatus`; Step 23 instead declares **`releaseDecisionStatus`:
  `Pass` | `Blocked` | `Fail`**. Plus `readinessEvidenceStatus` (Current|Partial|Blocked)
  and `bridgeAndCleanupStatus` (Explicit|Partial|Blocked). This is the terminal decision of
  the numbered pipeline — notable given Step 5 referenced a "Step 24 Technical Review",
  which must therefore sit outside this handoff chain.
- **It re-grounds on four prerequisites at once**: Step 17 verification proof, Step 18
  cleanup disposition, Step 20 final verification evidence, and the Step 22 final
  acceptance artifact — "If any prerequisite is stale or missing, return `Blocked` with the
  exact prerequisite **instead of rebuilding readiness from drift**." The readiness pack
  must be "grounded in the current [Step 17/18/20/22] prerequisite proofs **rather than
  silently reusing stale readiness inputs**."
- **Anti-false-completion rule on the swap claim** — the sharpest line in the prompt:
  confirm `ui-component-map.json` and `ui-verification-report.json` "agree with the real
  current source **instead of claiming families were swapped when legacy selectors or
  bridges still remain**." A direct check against a modernization that *reports* done.
- **High-risk widget carve-out**: grids, charts, heavily customized tables, and composite
  forms need "explicit parity evidence **before any legacy version is treated as
  retired**."
- **Release artifact**: `.modernization/ignition-artifacts/reviews/deployment-readiness-review.json`,
  recording packaging/build proof, deployment-readiness proof, final compliance posture,
  remaining blockers, starter-shell preservation, control-point conformance, remaining
  bridge status, cleanup disposition for leftovers outside the final target roots, and the
  single explicit release decision.
- **"Dominion" reappears** at the end of the pipeline: the readiness pass must align "to
  the acceptance criteria and to the latest **Dominion compliance review output**" —
  bookending its first appearance in Step 4.
- **Numbering is CLEAN in this prompt.** Every step reference is correct: "Reuse current
  Step 17, Step 18, Step 20, and Step 22 prerequisite proof", "the **Step 5** ownership
  contract", "the accepted **Step 22** final-acceptance posture", and the Closure contract
  lists exactly the three statuses the Objective declared. First clean Phase 3 prompt.

## ⚠ Missing file-reading tools in prompt 23's frontmatter

The `tools:` list omits **`read/readFile`** and **`search/codebase`** — every other prompt
in the kit (1-22) includes both, and this prompt's list starts straight at
`execute/runInTerminal`. Yet its Readiness core instructs: "**Read**
`.../decisions.json`, `.../control-point-inventory.json`, and `.../migration-plan.json`
before closing readiness", and it must inspect `ui-fusion-map.json`,
`ui-component-map.json`, and `ui-verification-report.json`.

An agent bound to this tool list cannot perform its own required reads. This is a
different defect class from the numbering drift — a **capability gap** — and it would
surface at the hackathon as a Step 23 that either fails immediately or silently substitutes
terminal commands for file reads. Worth verifying at source (a wrapped line could in
principle hide the entries, though the visible indentation shows `tools:` on line 4 with
`execute/runInTerminal` on line 5).

A mechanical sweep of all 23 transcribed prompts confirms Step 23 is the anomaly:

| Prompt | `read/readFile` | `search/codebase` | note |
|---|---|---|---|
| 1 | yes | **no** | legitimate — workstation readiness needs no codebase search |
| 9 | **no** | **no** | declares **no `tools:` block at all** (uses the
  `description`/`name`/`argument-hint`/`agent` frontmatter style) — inherits agent defaults |
| **23** | **no** | **no** | **has a `tools:` block but omits both**, while instructing "Read …" |
| all others (2-8, 10-22) | yes | yes | |

So 23 is the only prompt that declares a tool list and leaves out the reading tools it
needs. Prompt 9's omission is a different (probably benign) style difference worth
confirming separately.

## Transcription uncertainties (prompt 23)

- The missing `read/readFile` / `search/codebase` entries are recorded as photographed;
  confirm against the source file before treating it as a real defect.
- Artifact paths are consistently under `.modernization/ignition-artifacts/…` in this
  prompt (no `.modernization/artifacts/…` variant), unlike prompts 21-22.
- No mojibake present.
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 33-59
  across the two photos.
- File ends at line 72.

## Structural facts added by prompt 22

- **A sixth agent**: `agent: OpX-Code-Reviewer`. Full roster: `OpX-AppMod-P1-Discovery`,
  `OpX-dotnet-upgrade`, `OpX-AppMod-P2-Modernize`, `OpX-Fusion-Reviewer`,
  `OpX-AppMod-P3-Review`, `OpX-Code-Reviewer`. Balanced tier, 10-20 min, 74 lines.
  H1 is `# FINAL ACCEPTANCE-CRITERIA REVIEW` with no step-number prefix (same as prompt 21).
- **This closes the Step 4 → Step 22 scorecard loop** — the before/after acceptance
  comparison the kit has been building toward since Discovery. The header block names all
  four artifacts explicitly:
  - **Review Type:** Final acceptance (after modernization)
  - **Manifest:** `discovery/review-manifest.json` (same manifest Step 4 used)
  - **Output:** `reviews/final-review.json`
  - **Final Gate Artifact:** `portal/data/json/FINAL-COMPLIANCE-REPORT.json`
  - **Compare Against:** `discovery/baseline-review.json` ← **Step 4's output**
  So `BASELINE-COMPLIANCE-REPORT.json` (Step 4) and `FINAL-COMPLIANCE-REPORT.json`
  (Step 22) are the bookends, with per-criterion `improvementDelta` computed between them
  exactly as prompt 04 promised.
- **"Validate the final app against the acceptance criteria AND the [Step 5] target-state
  contract together, not as separate unrelated checks"** — acceptance is not just "does it
  score well" but "does it score well *and* match the architecture we approved."
- **Three statuses**: `acceptanceMatrixStatus` (**DecisionGrade**|Partial|Blocked),
  `controlPointAcceptanceStatus` (Aligned|DriftDetected|Blocked), `step23HandoffStatus`
  (ReadyForReadinessReview|NotReadyForReadinessReview|Blocked). The completion bar is
  explicitly about *usefulness to the next step*: "Do not treat Step 22 as complete when
  acceptance findings exist but the artifact **still cannot tell Step 23 whether the final
  acceptance state is decision-grade**."
- **Four named final-acceptance blockers** (not "post-review polish"): unresolved
  control-point drift, unapproved `Temporary bridge` carry-forward, a regressed
  protected-browser-API ownership contract, and a browser surface no longer aligned to the
  Step 14 UI contract artifacts without a recorded defer reason.
- **Protected starter shell preservation is an acceptance criterion**: confirm platform-owned
  backend and browser concerns still live in the starter shell "instead of reintroducing a
  parallel custom platform surface" — the anti-fork rule enforced one last time at the gate.
- **Same chat-vs-artifact discipline as Step 21**: criterion-by-criterion deltas, bridge
  detail, and browser-surface contract detail stay in the artifacts "instead of replaying
  them in chat."
- **Step 23's name implied**: `ReadyForReadinessReview` → Step 23 is the **Readiness
  Review**.

## ⚠ Prompt 22 contains an explicit acknowledgement of the renumbering

This is the most important drift finding so far, because it shows the problem was **known
and worked around in prose rather than fixed**:

> "Use the same review contract and outputs as the prior final acceptance review lane,
> **but treat this as Step 22 in the current numbered process.**"

That line only makes sense if the author knew the surrounding content carried old step
numbers and chose to patch it with an instruction to the model instead of correcting the
references. It also explains why the drift is per-line rather than per-file: nobody swept
the bodies, they added a disclaimer.

Prompt 22's own instances (seventh handoff mismatch):
- Declares **`step23HandoffStatus`** (correct: 22 → 23); Closure contract requires
  **`step25HandoffStatus`** — never defined.
- "as the exhaustive **Step 24** proof artifacts" (should be 22); "If **Step 24** is blocked
  by stale prerequisites…" (should be 22).
- "the **Step 7** target-state contract" — target-state decisions are Step 5's.
- **Correct** in Operator focus ("the three **Step 22** status fields", "in the **Step 22**
  artifacts"), in the completion bar ("Do not treat **Step 22** as complete… tell **Step
  23**…"), and in all prerequisite citations ("**Step 20** final verification evidence and
  **Step 21** visual-review", "Reuse current **Step 20** and **Step 21** prerequisite
  proof"). The Objective/Operator/Review sections were updated; the Artifact and Closure
  contracts were not.

Running tally of the declared-vs-required handoff-field mismatch: **13, 15, 16, 19, 20, 21,
22** affected; **7, 8, 10, 11, 14, 17, 18** clean; 1-6, 9, 12 declare no handoff field.
Every Phase 3 prompt so far (19-22) is affected.

## Transcription uncertainties (prompt 22)

- **Path inconsistency within the same prompt**: the header block gives
  **Output:** `.modernization/ignition-artifacts/reviews/final-review.json` while the
  Artifact contract says "Keep those details in
  `.modernization/artifacts/reviews/final-review.json`" — same filename, different root.
  Both transcribed as shown; worth resolving at source since a script reading one and
  writing the other would silently diverge.
- No mojibake in this prompt (no emoji or non-ASCII symbols present).
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 47-60
  across the two photos.
- File ends at line 74.

## Structural facts added by prompt 21

- **First Figma MCP integration**: tools gain **`figma/*`** alongside `fusion/*` and
  `fusion/copilot-docs/*`. Same `OpX-AppMod-P3-Review` agent as Step 20. Balanced tier,
  10-20 min, 70 lines.
- **The H1 is just `# FIGMA REVIEW`** — no "Step 21" prefix, unlike every other prompt
  (`# Step NN Title`). Minor, but it means a header-based step-number extractor would fail
  on this file.
- **"Not a cosmetic-only pass" is the whole point**: "Step 21 is the visual review gate,
  but **it only counts when the reviewed UI scope is both visually aligned AND functionally
  complete enough for review**" and "It is blocked when critical feature completeness is
  still missing **even if the screenshots look good**." A design-comparison gate that
  refuses to be fooled by a pretty screenshot.
- **"Critical visible-but-unwired controls" is the named failure class** and blocks by
  default. Defined explicitly as: primary workflows, data-changing controls, exports, print
  actions, and secondary admin controls — "unless the evidence pack records an explicit
  approved defer reason." When blocked, the response must name "the exact route or screen,
  the exact blocked control, why it is critical, and the clearest remediation path."
- **Three statuses, all with a `NotApplicable` arm**: `visualReviewStatus`
  (Aligned|DriftOpen|NotApplicable), `criticalControlStatus` (Clear|Blocked|NotApplicable),
  `step22HandoffStatus` (ReadyForAcceptance|NotReadyForAcceptance|Blocked).
- **`browserSurfaceApplicability: NotApplicable` is a first-class path**, resolved from
  `decisions.json` *before* any review decision: "do not force a browser screenshot or
  Figma comparison pass. Record the explicit not-applicable reason … confirm no managed
  browser-surface visual-contract obligation remains hidden in the final review state, and
  return a truthful lightweight proof decision." API-only apps get an honest lightweight
  pass rather than a fabricated visual review.
- **Operator focus / chat-vs-artifact split** — a token-discipline pattern worth stealing:
  "Keep the numbered-step response **tight**: reviewed scope, review decision, top blockers
  …, refreshed artifact status, and the three status fields. Keep route-by-route screenshot
  comparisons, drift-by-severity detail, and reviewed-screen evidence in
  `figma-review.json` **instead of replaying them in chat**." Explicitly separates the
  durable artifact from the conversational summary.
- **New artifact path variant**: `.modernization/**artifacts**/reviews/figma-review.json`
  — a third root alongside `.modernization/ignition-artifacts/reviews/` (Step 19) and
  `.modernization/fusion-restructure/` (Steps 19-20).
- **Step 22's name implied**: "Ready**ForAcceptance**" / "final acceptance review" — Step
  22 is the acceptance review gate.

## ⚠ +2 drift in prompt 21 (sixth handoff-field mismatch, now with adjacent-line proof)

Prompt 21 makes six prompts with the declared-vs-required handoff mismatch (13, 15, 16, 19,
20, 21):

- Objective declares **`step22HandoffStatus`** (correct: 21 → 22); Closure contract requires
  the response to include **`step24HandoffStatus`** — never defined in the prompt.
- "Classify **Step 23** completion explicitly with these statuses" — this step is 21.
- "the three **Step 23** status fields" (Operator focus); "before making a **Step 23**
  decision" and "as **Step 23** blockers by default" (Review core); "the exhaustive
  **Step 23** proof artifact" (Artifact contract).
- "return a truthful lightweight proof decision for **Step 24**" — under the +2 offset that
  is Step 22, the acceptance gate.

**The tightest evidence yet that the update was applied per-line, not per-file:** two
adjacent bullets in Review core disagree —

```
- Treat unresolved critical visible-but-unwired controls as Step 23 blockers by default.   <- old (+2)
...
- When Step 21 is blocked by an unresolved control, return the exact route or screen ...   <- new (correct)
```

Prerequisite citations are correct throughout ("Reuse current **Step 20** verification
proof", "confirm current **Step 20** final verification evidence"), so the drift is
concentrated in self-referential statements about *this* step's own number.

Running tally of the declared-vs-required mismatch: **13, 15, 16, 19, 20, 21** affected;
**7, 8, 10, 11, 14, 17, 18** clean; 1-6, 9, 12 declare no handoff field.

## Transcription uncertainties (prompt 21)

- No mojibake step-reference string appears in this prompt (its Closure contract uses
  `Pass`/`Blocked` rather than a "keep the exact next step on `…`" line), consistent with
  Phase 3 prompts having a different closeout shape.
- Artifact path recorded as `.modernization/artifacts/reviews/figma-review.json` exactly as
  shown — note this differs from Step 19's `.modernization/ignition-artifacts/reviews/`.
  Whether these are genuinely different directories or a typo is worth checking at source.
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 29-59
  across the two photos.
- File ends at line 70.

## Structural facts added by prompt 20

- **A fifth agent**: `agent: OpX-AppMod-P3-Review` — distinct from Step 19's
  `OpX-Fusion-Reviewer`. So Phase 3 uses at least two agents: a Fusion specialist for the
  restructure review and a general P3 reviewer for verification. Full agent roster so far:
  `OpX-AppMod-P1-Discovery`, `OpX-dotnet-upgrade`, `OpX-AppMod-P2-Modernize`,
  `OpX-Fusion-Reviewer`, `OpX-AppMod-P3-Review`.
- **Same broad tool grant as Step 19** (`fusion/*` + `fusion/copilot-docs/*`). Balanced
  tier, 15-30 min, 73 lines. **No closing DEV/QA menu** — confirming that as the Phase 3
  shape rather than a one-off in prompt 19.
- **Three statuses**: `verificationEvidenceStatus` (Current|Partial|Blocked),
  `controlPointConformanceStatus` (Aligned|DriftDetected|Blocked), `step21HandoffStatus`
  (ReadyForVisualReview|NotReadyForVisualReview|Blocked).
- **Target-shape flexibility with proof obligation** — a good generalization rule: "When
  the selected target is the standard simple browser-led shape, final verification should
  prove `src/<AppName>.Library`, `src/<AppName>.Web.Api`, and `src/<AppName>.Web.Client`.
  When [Step 5] approved another valid target shape, **prove that approved shape instead of
  forcing the simple layout**." The gate verifies against the *approved* architecture, not
  a hard-coded one.
- **Backend runtime proof is a 5-item list**, notable for going beyond happy-path: API
  startup + health endpoint; **at least one unauthenticated protected endpoint returns the
  expected auth challenge**; **at least one mapped-role success case AND one
  insufficient-role rejection case**; current-user/policy-handler membership resolution
  "from the same evaluator and membership source used by protected endpoints"; and
  platform-owned config resolving from approved final-state sections plus "exercise one
  database-backed path when the app depends on database runtime proof." Negative-path auth
  testing as a first-class gate item.
- **Frontend runtime proof** covers canonical routes/landing/callback/logout, protected
  client API paths using the approved protected-request mechanism, client provider and
  service ownership "rather than an untracked bridge path", and — the sharp one — "confirm
  the preserved visual contract is still usable **before and after** any deliberate
  primitive-family replacement, including styling foundation, layout framing, widths,
  gutters, control heights, grid or table density, dialog sizing, and breakpoint behavior."
- **Anti-prose-summary rule, stated twice**: any failing verification family and any
  remaining `Temporary bridge` behavior must be "explicit in the returned data and
  refreshed evidence **instead of hiding it behind a prose-only summary**." A direct
  countermeasure to a model narrating success.
- **Step 21's name confirmed: "Figma Review"** — a design-comparison gate, the first
  reference to Figma anywhere in the kit.

## ⚠ +2 drift continues in prompt 20 (fifth handoff-field mismatch)

Prompt 20 has the same declared-vs-required mismatch, making it **five prompts** with this
defect (13, 15, 16, 19, 20):

- Objective declares **`step21HandoffStatus`** (correct: 20 → 21); Completion gate requires
  the response to include **`step23HandoffStatus`** — never defined in the prompt.
- QA plan says "handoff to **Step 23**" where the declared handoff is Step 21.
- Required behavior: "confirm the current **Step 21** Fusion review artifact exists … and
  that **Step 19** verification proof plus **Step 20** cleanup disposition are still the
  active prerequisites" — under current numbering those are Steps **19, 17, 18**
  respectively (and must be, since Step 20 *is* the verification step).
- "Use the **Step 7** and restructure decisions to confirm the approved target roots …
  When **Step 7** approved another valid target shape" — target-shape decisions are Step 5's
  (`decisions.json`), and the same prompt correctly cites "the **Step 5** control-point
  contract" twice in the frontend-proof section.
- **Same per-section split as prompt 19**: Execution mode uses correct new numbering
  ("Reuse current Step 19 review findings and Step 17 plus Step 18 prerequisites") while
  Required behavior ten lines later uses old numbering for the same prerequisites.
- Completion-gate "keep the exact next step on `…`" is mojibake again.

Running tally of the declared-vs-required handoff-field mismatch — the most directly
executable defect, since the agent is ordered to emit a field the prompt never defines:

| Prompt | Declares | Completion gate requires |
|---|---|---|
| 13 | `step14HandoffStatus` | `step16HandoffStatus` |
| 15 | `step16HandoffStatus` | `step18HandoffStatus` |
| 16 | `step17HandoffStatus` | `step19HandoffStatus` |
| 19 | `step20HandoffStatus` | `step22HandoffStatus` |
| 20 | `step21HandoffStatus` | `step23HandoffStatus` |

Clean: 7, 8, 10, 11, 14, 17, 18 (and 1-6, 9, 12 declare no handoff field). The defect is
**non-contiguous and spans both Phase 2 and Phase 3**, so the linter must sweep all 24.

## Transcription uncertainties (prompt 20)

- The mojibake step-reference on the Completion gate line is recorded as a placeholder;
  the decoded value is presumably old-numbering `2️⃣2️⃣`, inferred from the consistent +2
  offset rather than read.
- Artifact paths use `.modernization/fusion-restructure/…` throughout (no
  `ignition-artifacts/` prefix), matching prompt 19's Required-behavior paths.
- Window title reads `OpX-Ignition-Kit [Administrator]` as in prompt 19, with the same
  extra tabs open.
- Long wrapped lines reconstructed from wrap positions; overlap verified at lines 36-59
  across the two photos.
- File ends at line 73.

## Structural facts added by prompt 19

- **First Phase 3 prompt, and a new specialist agent**: `agent: OpX-Fusion-Reviewer` —
  the fourth agent seen (after `OpX-AppMod-P1-Discovery`, `OpX-dotnet-upgrade`,
  `OpX-AppMod-P2-Modernize`). Filename prefix changes from `P2` to **`P3`**. Premium
  reasoning (high thinking), 15-30 min.
- **Tools gain `fusion/*`** in addition to `fusion/copilot-docs/*` — the broadest Fusion
  MCP surface granted to any prompt, fitting a reviewer that must discover packages.
- **New skill**: `/.github/skills/fusion-final-restructure-review/SKILL.md` (the review
  rubric).
- **Shortest prompt in Phase 2/3 at 59 lines**, and notably **it has no closing DEV/QA
  choice menu** — no "## Step 19 DEV complete - next action", no numbered QA/next/stop
  options, no "list every file created or modified" line. Every prompt from 7-18 had one.
  Phase 3 review steps appear to use a different closeout shape.
- **Three statuses**: `fusionAlignmentStatus` (Aligned|**DriftDetected**|Blocked),
  `bridgeDispositionStatus` (Explicit|Partial|Blocked — same "explicit or it doesn't
  count" model as Step 18's cleanup disposition), `step20HandoffStatus`
  (ReadyForFinalVerification|NotReadyForFinalVerification|Blocked).
- **Anti-stale-review rule**: "Before running the review, confirm current [Step 17]
  verification proof and [Step 18] cleanup disposition exist **for the same source state
  under review**. If either prerequisite is stale or missing, return `Blocked` with the
  exact prerequisite **instead of reviewing against drift**." A review of stale evidence is
  treated as worse than no review.
- **Selective evidence invalidation**: "Refresh the Step 19 review artifact and **only the
  prerequisite evidence families that the current review actually invalidates**" — avoids
  the cascade where one review finding forces a full re-verification sweep.
- **MCP-first discovery ordering**: "Use Fusion MCP package or docs discovery **first**,
  then compare against the current starter shell under `src/`" — look up what Fusion
  offers before judging custom code, not after.
- **Review artifact**: `.modernization/ignition-artifacts/reviews/final-fusion-restructure-review.json`
  (new `reviews/` directory), carrying prioritized findings with explicit severity plus
  identified "safe remediation candidates."
- **Closing gate**: `Ready for Step 20 Final Verification: Yes` only when critical findings
  are "resolved, explicitly accepted, or recorded as real blockers **instead of being left
  implicit**." Step 20's name confirmed: **"Final Verification"**.

## ⚠ CORRECTION: the +2 drift is NOT confined to prompts 12-16 — prompt 19 has it too

Recorded under prompts 17 and 18 was the conclusion that the +2 numbering drift was
"confined to the frontend block (prompts 12-16)", because 17 and 18 are clean. **Prompt 19
breaks that conclusion.** The drift recurs after two clean prompts, so it is not a
contiguous block and cannot be fixed by scoping repairs to 12-16.

Prompt 19's instances, all +2:
- The Objective declares **`step20HandoffStatus`** (correct: 19 hands off to 20), but the
  Completion gate requires the response to include **`step22HandoffStatus`** — a field the
  prompt never defines. This is the **fourth** prompt with the declared-vs-required
  handoff-field mismatch (after 13, 15, 16).
- The prerequisite rule reads "confirm current **Step 19** verification proof and **Step
  20** cleanup disposition exist" — those are Steps 17 and 18 under current numbering
  (and semantically must be, since Step 19 *is* the reviewing step).
- **Internal inconsistency in the same prompt**: Execution mode says "Reuse current **Step
  17 and Step 18** prerequisite proof" (new numbering, correct) while Required behavior
  says "**Step 19** verification proof and **Step 20** cleanup disposition" (old numbering)
  — two lines describing the same two prerequisites with different numbers. A clean
  demonstration that the update was applied per-section, not per-file.
- The Completion gate's "keep the exact next step on `…`" string is mojibake again (emoji
  + keycap digits), consistent with the corrupted step-reference strings in prompts 15-16.

**Revised scope for the linter**: run it across **all 24 prompts**, not a range. The
observed pattern (12,13,14,15,16 drifted / 17,18 clean / 19 drifted) means clean prompts
prove nothing about their neighbours.

## Transcription uncertainties (prompt 19)

- The file ends at line 59 with no closing menu. Since only one photo covers this prompt
  and the editor showed no further content, this is recorded as complete — but worth a
  quick scroll-check at the source to confirm nothing follows.
- The mojibake step-reference on the Completion gate line is recorded as a
  `<MOJIBAKE: emoji + keycap digits>` placeholder; the decoded value is presumably the
  old-numbering `2️⃣1️⃣` given the consistent +2 offset, but that is inferred, not read.
- Artifact paths in Required behavior use `.modernization/fusion-restructure/…` while the
  review artifact uses `.modernization/ignition-artifacts/reviews/…`; both as shown (same
  split noted in prompts 13-16).
- The window title reads `OpX-Ignition-Kit [Administrator]` here rather than
  `IgnitionKit1.2` as in prompts 12-18, and other tabs are open
  (`ORIGINAL-BASELINE-COMPLIANCE-REPORT.md`, an "Execute Discovery Steps Review" Copilot
  tab) — possibly a different workspace or a later session.
- Long wrapped lines reconstructed from wrap positions.

## Structural facts added by prompt 18

- **The pre-review cleanup lane and the last Phase 2 step** (Balanced tier, 10-20 min,
  129 lines — one of the shortest). Exists so "review" does not have to discover cleanup
  drift. Three statuses: `deploymentReferenceStatus` (Aligned|Partial|Blocked),
  `cleanupDispositionStatus` (**Explicit**|Partial|Blocked), `step19HandoffStatus`
  (ReadyForReview|NotReadyForReview|Blocked).
- **`cleanupDispositionStatus: Explicit` is the interesting value** — the gate is not "all
  leftovers removed" but "every retained leftover is *explicit with rationale*." Retention
  is allowed; silent retention is not.
- **Five MANDATORY pre-review verification blocks**, each closing with the same formula
  ("Cleanup without X verification is incomplete Step 18 coverage"):
  - **Production-Ready Cleanup**: no TODO/FIXME/HACK in production code (move to backlog),
    no `console.log`/`debugger`/test-only code, no dead imports/variables/functions/
    components, formatters run (Prettier, `dotnet format`), README updated with current
    architecture and run instructions.
  - **Test Coverage**: backend >80% on Library business logic, Playwright coverage for all
    routes, POMs current with latest selectors, Gherkin scenarios runnable, "no skipped or
    ignored tests without documented reason."
  - **Accessibility**: `aria-label`/`aria-labelledby` on all interactive elements,
    `data-testid` on all testable elements, full keyboard navigation, no a11y warnings in
    build output.
  - **Deployment Readiness**: health check endpoints respond, env-specific config
    externalized, **no secrets in source code**, Dockerfile builds and runs, OpenShift
    manifests reference correct image/paths.
  - **Cutover And Rollback Verification**: verify the Step 5 `cutoverAndRollbackPlan` is
    "real and executable — **Phase 2 cannot ship without it**"; feature flag named/owned/
    switchable; rollback documented with steps, owner, and max time-to-rollback; and
    **execute a dry-run of the rollback against a non-prod environment**, recording
    `{env, executedAt, durationSec, success, evidencePath}` in
    `step18-rollback-dryrun.json`. Explicitly generic across OpenShift, Kubernetes, App
    Service, IIS, ECS, and on-prem.
- **Performance And Bundle Verification (MANDATORY when browser-surface is in scope)** —
  re-runs the perf measurement **against the deployed artifact, "not just the dev build"**,
  re-measures gzipped initial bundle and lazy chunks per route, and fails the step if any
  Step 5 budget regresses without a recorded deferral (`step18-perf-verification.json`).
- **Cleanup ordering rule worth stealing**: "Remove UI bridge wrappers **only when** the
  corresponding Fusion component family has already been verified and recorded as final
  state" — bridges outlive their slice until that slice is provably done.
- **Stale-alias sweep**: retired portal aliases, dead selected-page tokens, retired
  step-surface names, and outdated workflow references must be removed or explicitly
  retained "when they still point at obsolete modernization outputs" — the kit cleaning up
  after its own renamed surfaces (e.g. the `frontend-modernization-parity` → 
  `frontend-foundation-and-scaffold` rename from prompt 10).
- **Secrets rule stated twice**: "No secrets in source code" and "raw secret values must
  not appear in any committed file"; `environmentConfigPlan.environments[]` values get
  promoted into deployment config with secrets resolving from the planned secret store.
- **Numbering is CLEAN** (`step19HandoffStatus`, "Ready for Step 19 Final Fusion
  Restructure Review", "continue to Step 19 (Phase 3 Review)"), reconfirming the +2 drift
  was confined to prompts 12-16.
- **Step 19's name confirmed**: "Final Fusion Restructure Review", and it is **Phase 3** —
  so Phase 2 Modernize spans Steps 7-18 and Phase 3 Review begins at Step 19.

## Transcription uncertainties (prompt 18)

- The Completion gate's "Otherwise keep the exact next step on `18-P2-deployment-and-clean-up`"
  uses the **filename** where every other prompt uses the human step name ("Step NN Title");
  transcribed as shown.
- Double-backtick identifier styling in the Cutover/Rollback and Performance/Bundle
  sections preserved as shown.
- No mojibake observed in this prompt (no emoji or `>=` symbols present), consistent with
  corruption affecting only non-ASCII characters.
- Long wrapped lines reconstructed from wrap positions; overlaps verified at 49-58 and
  104-110.
- File ends at line 129.

## Structural facts added by prompt 17

- **The S-TIER verification gate Step 6 has been planning toward since the start** — and the
  largest prompt in the kit at 446 lines. Balanced tier, 15-30 min. Validates ALL
  accumulated test work from Steps 6-16.
- **Three self-checks including a second content reconciliation**:
  `Invoke-StepReconciliation.ps1 -Step 17` proves "every non-deferred testcase in
  `executable-testcase-catalog.json` points to a test file that **actually exists**" —
  explicitly because "a shape check cannot catch a catalog entry that names a test file
  which was never created." Fix path: implement the test, or mark `Deferred` with a
  `deferralId` and re-run Step 6.
- **THE 12 QUALITY GATES**, each with Criteria checklist / Validation command /
  Remediation steps: (1) Characterization 100%, (2) Unit ≥95% line, (3) Contract 100% API,
  (4) Integration ≥95% critical path, (5) Database 100% table, (6) Angular 100% component
  (Karma/Jasmine ≥90%), (7) Visual Parity ≥85% (90% stretch), (8) Smoke 100% pass,
  (9) E2E 100% journey, (10) Test Quality Standards 100% compliance, (11) Page Object
  Models 100%, (12) Test Documentation 100%.
- **Plus 11 MORE "Discovery-Backed Verification Gates" (MANDATORY)** tied to Step 6
  `progressDenominators` and Step 5 `decisions.json`: Visual Parity Floor
  (`routeStateParity >= 90`), Performance Baseline (FCP/LCP/TTI/apiCallCount/payloadBytes
  within budget), Bundle Size (gzipped, per route), Accessibility Audit (Lighthouse ≥90,
  zero critical/serious axe violations), Error State Coverage, Export Surface Coverage,
  Realtime And Push Coverage, Localization, Flake Budget, **Progress Denominator
  Verification** ("Estimated percentages are forbidden"), and Cutover Readiness Pre-Check.
  Results land in `step17-gate-results.json` as `{gateId, status, evidencePath, deferralId?}`.
- **Mutation Testing Gate (MANDATORY)** — the strongest test-quality idea in the kit:
  `Stryker.NET` (backend Library + Web.Api) and `StrykerJS` (client) run "to prove the
  tests actually catch behavior breaks instead of just executing covered lines." Emits
  `mutation-score.json` with `mutationScorePercent`/`mutantsKilled`/`mutantsSurvived`/
  `mutantsTimedOut`/`survivedMutants[]` (location, mutator, snippet). Thresholds:
  **full-scope ≥60%, critical-path ≥80%**; surviving mutants on critical-path classes are
  blockers — "either add the test that kills the mutant or amend the `criticalPathInventory`
  with reviewer-approved justification." Scoped first to the Step 8 critical-path
  inventory, then expanded.
- **4-phase execution flow**: Validation (run all gates) → Remediation (fix all failures,
  repeat until pass) → Final Verification (rerun ALL gates from start, 100% pass) →
  Documentation Sweep (spot-check 5 random test files for comment-style deviations).
- **A worked completion-gate JSON** with all 12 gates PASS, per-lane test counts
  (characterization 45 / unit 212 / contract 28 / integration 56 / database 24 /
  angular 87 / e2e 32 / smoke 12 / **total 496**) and coverage metrics — a concrete shape
  the agent fills rather than invents.
- **Four returned values**: `step17Status` (Complete|InProgress|Blocked),
  `qualityGateStatus` (per-gate pass/fail), `testDocumentationCompliance`
  (100%|Partial|Incomplete), `step18HandoffStatus`
  (ReadyForCleanup|NotReadyForCleanup|Blocked).
- **Numbering is CLEAN in this prompt** — `step17Status`, `step18HandoffStatus`, "Step 18
  Deployment & Clean Up" all correct. This confirms the +2 drift was confined to the
  frontend block (prompts 12-16). Only two minor suspects: "+10% of **Step 5**
  `performanceBaseline`" (prompt 06 attributes `performanceBaseline` to Step 3) and
  "amend **Step 7's** `criticalPathInventory`" (surrounding text says Step 8 twice).
- **Step 18's name confirmed**: "Deployment & Clean Up". QA twin
  `17-QA-rewire-all-tests-and-verify` runs every lane (Unit, Integration, Contract,
  Browser-contract, E2E, Legacy characterization; 15-30 min) — "the full Phase 2 quality
  gate before **Phase 3** review", first explicit reference to a Phase 3.

## ⚠ Internal contradiction in prompt 17: does Step 17 author tests or not? (HIGH fork-risk)

The prompt states both positions in load-bearing places:

**"Step 17 does the work":**
- frontmatter description: *"ALL TESTING IS DONE HERE. Steps are NEVER validation-only.
  Dev work is ALWAYS done."*
- CORE PRINCIPLE banner: *"Step 17 makes testing PERFECT… ALL TEST WORK WILL BE DONE HERE.
  WE WILL COMPLETE EVERYTHING."*
- Dev work bullet: *"Complete any missing tests…"*
- Gates 1, 3, 4, 5, 6, 9, 11, 12 remediation: *"Create missing … tests with full
  documentation"*
- Phase 2 of the execution flow: *"Add missing tests with full documentation"*

**"Step 17 must NOT author tests":**
- Gate 2 remediation: *"Step 17 does not derive new scenarios… Route back to that step
  (Step 8/9/12/etc.)… then to Step 6 to extend the catalog… **Do not author tests directly
  inside Step 17. Step 17 verifies; it does not plan and does not derive.**"*

Gate 2 is the position consistent with the rest of the kit (Step 6's "Phase 2 has no
derivation authority", Step 14's "any field it has to invent is an upstream gap"), and its
routing loop is precisely correct. But it is one bullet against the title, the description,
the all-caps banner, and eight other gates. Under time pressure a developer follows the
banner, authors tests locally, and silently breaks the catalog-is-the-work-order contract
the whole kit depends on — the catalog then no longer describes the test suite, and the
Step 17 reconciliation that is supposed to catch exactly that will pass because the files
now exist.

## ⚠ App-specific leakage into a generic kit (prompt 17)

Gate 10 and Phase 4 both hard-code a specific app's test file as the style oracle:
*"Comment style matches **`LegacyConnectionStringProviderTests.cs`** exactly"* and
*"Spot-check 5 random test files against `LegacyConnectionStringProviderTests.cs`"*. That
file will not exist in any other application, so both instructions are unsatisfiable at a
hackathon. The kit's own pattern elsewhere (data-driven from `componentCensus`,
`progressDenominators`, registries) shows the intended fix: name the style contract, not a
file from one app.

## Transcription uncertainties (prompt 17)

- **Encoding corruption is confirmed widespread, not just in step-reference strings.** `≥`
  renders as `â‰¥` throughout the gate headings ("Unit Tests (â‰¥95% Line Coverage)"), `✅`
  renders as `âœ…` in the "Do NOT close Step 17 until" checklist, and all four section
  emoji are mojibake. Transcribed with ASCII equivalents (`>=`, `[x]`) and
  `<MOJIBAKE: emoji>` placeholders rather than reproducing corrupted bytes.
- Gate 1 remediation says "Find all CaseIds with `owningStep < 10`" — likely intended as a
  characterization-owning-step bound (Step 6 assigns characterization to owningStep 7);
  transcribed as shown.
- The completion-gate JSON's `completedAt` is a literal example timestamp
  (`2026-05-28T10:00:00Z`), not a placeholder token; preserved as shown.
- Double-backtick identifier styling throughout the Discovery-Backed and Mutation Testing
  sections preserved as shown.
- Long wrapped lines reconstructed from wrap positions; overlaps verified at 51-61,
  101-115, 149-165, 195-215, 265-272, and 405-410.
- File ends at line 446.

## Structural facts added by prompt 16

- **The continuation lane**: picks the next eligible family/sub-pattern from the Step 14
  order and runs **Step 15's prompt in full** for that one slice
  (`.github/prompts/15-P2-fusion-ui-integration.prompt.md`) — the first prompt in the kit
  that invokes another numbered prompt as its executor. "It runs Step 15's replacement
  contract for that one slice - it does not invent a different process."
- **Or proves the lane exhausted.** `nextEligibleFamilyStatus`:
  `Advanced` | `Exhausted` | `Blocked`; plus `artifactReconciliationStatus`
  (Current|Partial|Blocked) and `step17HandoffStatus`
  (ReadyForVerification | **ContinueUiLane** | Blocked) — the `ContinueUiLane` value makes
  "loop back to me" a first-class status rather than an implicit outcome.
- **Eligibility Predicate (MANDATORY)** — the anti-guessing core, four conjunctive
  conditions: `migrationEligible` is not `false`; `bindingShape` is supported by the
  wrapper/target "without a binding-shape refactor in the same pass"; every
  `requiresWrapperCapability` entry is present in the current wrapper; and the slice was
  not already advanced in a prior pass (checked against `ui-fusion-map.json` map keys).
  "If no remaining slice is eligible under this predicate, classify
  `nextEligibleFamilyStatus: Exhausted` and proceed to Step 17. **Do not improvise
  eligibility outside this predicate.**" Exhaustion claims must cite the predicate rows.
- **Sub-Pattern Progress (MANDATORY)**: exactly one sub-pattern per pass — "do not chain
  two sub-patterns even when they belong to the same family"; read `subPatternProgress`
  before selecting; follow `suggestedPassOrder`; skip-with-reason when a wrapper capability
  is unsatisfied (choice is "close the wrapper-capability gap first or move to the
  next-eligible sub-pattern"); close as `familyRetirementStatus: Partial` with a named
  `followUpSlice` while sub-patterns remain, `Complete` only when all are migrated or
  deferred.
- **Sibling Slice Regression Gate (MANDATORY)** — genuinely new and the sharpest idea in
  this prompt: after the primary slice lands, **rerun the verification suite (visual
  parity, E2E click-through, accessibility scan, console-error watch) for the 2-3 nearest
  sibling slices**. Siblings are data-driven from `slice-graph.json` — slices sharing a
  route ancestor, a parent module/feature folder, or a common wrapper from
  `wrapper-versions.json`. Emits `sibling-regression/<sliceId>.json` with
  `primarySliceId`/`siblingSlicesChecked[]`/`regressionFindings[]`
  (`siblingSliceId`, `check` ∈ visual-parity|e2e|a11y|console-errors, `status` ∈
  pass|warn|fail, `evidencePath`). **Any sibling `fail` blocks the primary slice from
  closing.** This is blast-radius verification — catching the case where swapping one
  family silently breaks its neighbours through a shared wrapper.
- **Inherits Step 15's economics**: same ROI-First scoring
  (`(visibilityScore + interactionScore) - riskScore`, first three passes must be visible
  on the running app), same 5-10pp parity gain floor, same repeat-run recommendation — but
  with its own diff path `parity-diffs/step16-pass-{passId}/`.
- **Step 17's name confirmed**: "Rewire All Tests & Verify".

## ✅ Numbering drift SOLVED: a clean +2 offset, confirmed by decoding the mojibake

Prompt 16 resolves the drift question definitively, and **corrects the "messy mixed drift"
characterization recorded under prompt 14.**

Two lines in prompt 16's Completion gate render as mojibake in the editor:

```
- Keep the exact next step on `ðY"ß 1ï.ßâfE8ï.ßâf£ Next Fusion UI Upgrade Slice`
- Hand off to `ðY§ª 1ï.ßâf£9ï.ßâf£ Rewire All Tests & Verify`
```

`ðŸ` is the classic signature of UTF-8 bytes decoded as Windows-1252, and `1ï¸â£` is
exactly how the emoji keycap `1️⃣` mis-decodes. So those strings are really:

- `🔷 1️⃣8️⃣ Next Fusion UI Upgrade Slice`  → **Step 18**
- `🧪 1️⃣9️⃣ Rewire All Tests & Verify` → **Step 19**

…inside the prompt whose filename, header, and Objective all say **Step 16**. Every
mis-numbered reference across the frontend block is exactly **+2**:

| Prompt (declared) | Objective declares | Completion gate requires | Old-number self-refs |
|---|---|---|---|
| 12 | — | — | "Step 14" ×9 |
| 13 | `step14HandoffStatus` ✓ | `step16HandoffStatus` | "Step 15 Self-Audit" |
| 14 | `step15HandoffStatus` ✓ | — | "Step 15 coverage" ×3 (+1, the one partial fit) |
| 15 | `step16HandoffStatus` ✓ | `step18HandoffStatus` | "Step 17 pass", `step17-pass-{passId}/` |
| 16 | `step17HandoffStatus` ✓ | `step19HandoffStatus` | "Step 18 pass", "Step 17 `wrapper-versions.json`" |

**Mechanism:** the pipeline was renumbered **down by two** (old 14→12, 15→13, 16→14,
17→15, 18→16, 19→17). Frontmatter, headers, and **Objective** blocks were updated;
**Completion gates, Self-Audit blocks, and several MANDATORY sections were not.** Prompt 16
is internally split down the middle — its "If You Hit A Blocker" section uses correct new
numbering ("Only advance to Step 17…", "keep the exact next step on `Step 16 Next Fusion UI
Upgrade Slice`") while its Completion gate ten lines earlier uses old numbering with
corrupted emoji.

**Two independent defects, both mechanically fixable:**
1. **Numbering:** a linter comparing each prompt's declared step against every `Step N` /
   `step<N>HandoffStatus` / `-CurrentStep N` / `stepNN-pass-` reference catches all of it.
   Every prompt 13/15/16 orders the agent to emit a `step<N>HandoffStatus` it never
   defines.
2. **Encoding:** the emoji in step-reference strings are corrupted UTF-8-as-Windows-1252.
   These appear inside "keep the exact next step on `…`" instructions, so an agent
   following them literally emits garbage. Detect with a grep for `ðŸ` / `ï¸â£` across the
   kit and re-save the affected files as UTF-8. (Prompt 15 showed the same corruption; its
   status bar reads "UTF-8 **with BOM**" where earlier prompts read plain UTF-8.)

## Transcription uncertainties (prompt 16)

- The two mojibake strings in the Completion gate are recorded in the transcription as
  `<MOJIBAKE: emoji + keycap digits …>` placeholders rather than reproducing the corrupted
  bytes, since the corruption is the finding and reproducing it would risk propagating it.
  The decoded intent (`🔷 1️⃣8️⃣` / `🧪 1️⃣9️⃣`) is inferred from the standard
  UTF-8→Windows-1252 mapping, not read directly — verify against the source file.
- Double-backtick identifier styling in the ROI-First, Per-Slice, and Sibling Regression
  sections preserved as shown.
- Artifact paths again split between `…/ignition-artifacts/modernize/fusion-restructure/…`
  (Required behavior) and `.modernization/fusion-restructure/…` (gates); both as shown.
- Long wrapped lines reconstructed from wrap positions; overlaps verified at 51-59 and
  95-101.
- File ends at line 138.

## Structural facts added by prompt 15

- **The one-family-per-pass swap lane** (Premium reasoning / high thinking, **15-30 min
  _per primitive family_** — the first per-unit estimate in the kit). Advances exactly ONE
  primitive family to its mapped Fusion target. "One family per pass keeps each change
  small, reviewable, and reversible."
- **New skill**: `/.github/skills/fusion-ui-component-upgrade/SKILL.md`, loaded and
  followed "before selecting or editing the family surface."
- **The Steps 10-13 baseline is named the "reference oracle"** every swap is proven
  against — and if a swap reveals the baseline was wrong, "that is an upstream regression
  to fix at its owner step," not Step 15 work. Batching families is explicitly out of
  scope: "one family only - the next family is Step 16."
- **Wrapper-Extension Preflight (MANDATORY)** — do the wrapper work *once*, up front: read
  both the wrapper's current input surface AND the underlying Fusion primitive's surface
  **via Fusion MCP** ("do not infer the primitive's input surface from prior
  conversations"), then add every input the family will need in one pass (`placeholder`,
  `min`, `max`, `step`, `decimals`, `rows`, `valuePrimitive`, `readOnly`, `disabled`,
  `elementId`, `testId`, generic `options`) "so later sub-pattern passes do not need to
  extend the wrapper mid-stream." Generic-primitive wrappers (e.g. `fusion-dropdown`) must
  keep `options` permissive (`Record<string, unknown>`); form-field wrappers need both
  `readOnly` and `disabled` with a derived `controlDisabled = readOnly || disabled`; and
  `elementId`/`testId` must forward so `<label for=…>` and `data-testid` keep resolving.
  **"A first swap that requires a wrapper extension after the swap is incomplete Step 15
  coverage and must be retried with the preflight applied."**
- **Wrapper API Stability Gate (MANDATORY)** — genuinely new, and the most
  library-engineering idea in the kit: once a wrapper has shipped a pass, its public
  surface is **frozen** — every `@Input`, `@Output`, `ContentChild`, exposed template
  variable, exposed CSS custom property, and exposed slot becomes "the wrapper's published
  contract." Later passes may add **additive** inputs only when the wrapper-capability plan
  is amended, the change is backwards compatible (defaults preserve behavior), and the
  version is bumped in `wrapper-versions.json`. Breaking changes (rename, remove,
  type-narrow, default-shift) require **a new wrapper name plus a planned
  consumer-migration row** — "legacy callers cannot be silently rewritten."
  `wrapper-api-snapshots/<wrapperName>.<version>.json` is emitted every pass and the
  snapshot diff becomes review evidence.
- **Parity Gain Floor (MANDATORY)**: each pass must raise touched-family parity by ≥5
  percentage points (target 5-10) unless already above 95%. A pass with `parityGain < 5`
  and pre-pass parity `< 95` must rework the slice, split it into a smaller higher-impact
  slice, or be classified `Partial` with the exact blocker recorded.
- **ROI-First Slice Selection (MANDATORY)**: score candidates
  `{visibilityScore 1-5, interactionScore 1-5, riskScore 1-5, parityGainEstimate}` and take
  the highest `(visibility + interaction) - risk`; record the score in the pass entry "so
  the choice is reviewable." The first three passes on a new surface must produce "a
  noticeable change on the live application" — interactive controls and primary action
  buttons before "low-visibility passive containers or background scaffolding."
- **Repeat-Run Recommendation (MANDATORY)**: every non-exhausting pass must explicitly
  recommend rerunning with the expected `+5 to +10` point gain and name the next-eligible
  slice with its visibility/interaction score.
- **Per-Slice Visual Parity Diff (MANDATORY)**: before/after for the touched
  `{routeId, stateId}` rows only — "not the whole app" — with pixel and structural diff
  artifacts, recorded into `ui-fusion-map.json` as
  `{passId, sliceId, parityBefore, parityAfter, parityGain, diffArtifacts[]}`.
- **Fusion accessibility + POM mandates**: preserve-or-improve ARIA, `data-testid` pattern
  `fusion-{family}-{purpose}` (e.g. `fusion-button-submit`), keyboard navigation identical
  to legacy; POM selectors and Gherkin steps updated with the swap.
  `npm run verify:fusion-ui` refreshes the component-level verification report.
- **Blocker framing worth stealing**: "A half-swapped family — a `fusion-*` primitive
  rendering with the wrong variant, width, or a broken binding — is **worse than the legacy
  control it replaced**, so finish or cleanly revert the one family here rather than moving
  on." Named likely causes: missing wrapper input, or `valuePrimitive` not set so the bound
  value broke.
- **Closing menu**: QA twin `15-QA-fusion-ui-integration` (Lanes: Browser-contract, Visual
  parity, Accessibility smoke; ETA 3-5 min) / `next` → Step 16 DEV / `stop`. Step 16's name
  confirmed: "Next Fusion UI Upgrade Slice".

## ⚠ Cross-step numbering drift found in prompt 15 (HIGH — includes a self-contradiction)

Same class as prompts 12-14, and this one contradicts itself on a status field name:

- **Declared vs. required status field disagree.** The Objective declares
  **`step16HandoffStatus`** (`ReadyForNextSlice` | `NotReadyForNextSlice` | `Blocked`) —
  correct for Step 15 handing off to Step 16. But the Completion gate requires the response
  to "include explicit `primitiveFamilyExecutionStatus`, `componentVerificationStatus`, and
  **`step18HandoffStatus`** values." `step18HandoffStatus` is never defined anywhere in the
  prompt.
- **Step 17 used for this step's own coverage and artifacts**: "A pass that did not produce
  a per-slice diff is incomplete **Step 17** coverage and cannot close"; diff artifacts are
  written to `parity-diffs/**step17**-pass-{passId}/`; "Once a Fusion wrapper has shipped
  one **Step 17** pass, its public surface is frozen." (By contrast "part of the **Step 17**
  review evidence" is plausibly correct — Step 17 is the S-TIER verification gate per
  prompt 06.)
- **Wrong producer step for the wrapper plan**: "only when **Step 7's**
  `wrapperCapabilityPlan` is amended" — `wrapperCapabilityPlan` is a Step 5 deliverable per
  prompt 05 (and prompt 14 correctly cites Step 5 for the same artifact).

Running tally of the drift pattern (prompts 12-15): every frontend Phase 2 prompt carries
step-number references that disagree with its own declared number, in mutually
inconsistent directions (12→14, 13→15/16, 14→15, 15→17/18). Prompts 13 and 15 both
reference a `step<N>HandoffStatus` they never define, which is the most directly executable
failure — an agent asked to emit an undefined field must either error or invent it.

## Transcription uncertainties (prompt 15)

- Completion-gate line 137 shows apparent mojibake where the step name belongs — rendered
  as emoji/box glyphs before "Fusion UI Integration" rather than the expected "Step 15".
  Transcribed as `Step 15 Fusion UI Integration`; flag for re-read against the source since
  it may be a real encoding corruption in the file (the file is saved as UTF-8 **with BOM**
  per the status bar, unlike earlier prompts).
- Double-backtick identifier styling in the Per-Slice Diff, Parity Gain Floor, ROI-First,
  and Wrapper API Stability sections preserved as shown.
- Artifact paths again split between
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` (Required behavior)
  and `.modernization/fusion-restructure/…` (gates); both transcribed as shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  51-61, 104-112, and 125-133.
- File ends at line 170.

## Structural facts added by prompt 14

- **Planning-only lane — the first Phase 2 step that changes no code.** "It is planning
  only: no `src/` behavior changes here." Balanced tier, 15-30 min. Produces the four
  artifacts Steps 15-16 execute against: `ui-inventory.json` (per-control classification),
  `ui-visual-contract.json` (the measurable visual answer key),
  `ui-fusion-map.json` (Fusion-owned / wrapper / bridge / keep), and
  `ui-migration-order.json` (dependency-safe order).
- **Entry discipline is a hard gate on the previous step's artifact**: Step 14 "begins the
  Fusion map-and-swap block, so do not start it until the Step 13 visual-parity gate
  passed" — requires a current `visual-parity-report.json` with `overall: pass`; missing,
  stale, or `fail` routes back to Step 13 "instead of mapping and swapping over a shell
  that does not yet resemble the legacy app."
- **"Upstream Source Of Truth (MANDATORY)" — the cleanest anti-absorption rule in the
  kit**: "Step 14 is a refresh, not a discovery." Per-control classification originates in
  Step 3 `uiControlClassification`; wrapper-capability requirements in Step 5
  `decisions.json.wrapperCapabilityPlan`; sub-pattern order in Step 5
  `ui-migration-order.json`. **"Any field Step 14 has to invent from raw source is an
  upstream gap and must route back to Step 3 or Step 5 instead of being absorbed here."**
- **Seven mandatory per-control classification fields**, each tied to a concrete downstream
  swap hazard: `bindingShape` (twoWayNgModel | oneWayNgModel | uncontrolledValueEvent |
  reactiveFormControl | uncontrolledNoModel), `optionsAreLiteralModelValues` (`<option>`
  with no `value` attribute → replacement arrays must satisfy `label === value` and bind
  `valuePrimitive=true`), `migrationEligible` (`false` for parity-scaffold /
  reverse-engineering capture controls — "must never surface as Step 15 or Step 16
  candidates"), `compositeGroupId` (visually paired controls forming one semantic unit —
  swapped as a unit or explicitly deferred), `dynamicId` (template-interpolated ids like
  `id="lrSum-{{i}}"` require a documented `testIdFn` before swap),
  `requiresWrapperCapability` (Step 16 must skip slices whose capability is absent), and
  `dialogContext` (dialog controls belong to a dialog family, not the main-shell family).
- **Sub-Pattern Cataloging (MANDATORY)**: group by binding shape, value type
  (boolean/numeric/string-literal/lookup-object), and wrapper-capability requirement;
  record `{subPatternId, description, controls[], requiresWrapperCapability[],
  suggestedPassOrder}`; a family with 3+ sub-patterns must declare a dependency-safe
  `suggestedPassOrder` "so Step 16 selection is deterministic."
- **Component Reuse Analysis (MANDATORY)** — new technique: cluster components *across
  routes* by shape signature (input props, emitted events, content slots, control
  composition, layout role), via normalized template-AST hashing, `@Input`/`@Output`
  similarity, or visual signature comparison of captured screenshots. Emits
  `component-reuse-clusters.json` with `clusterId`/`signatureSummary`/`members[]`/
  `similarityScore` (0..1)/`recommendation` (unify-now | unify-at-step-15 | keep-distinct |
  needs-review)/`recommendationReason`. **≥ 0.85 similarity defaults to
  `unify-at-step-15`** "so Step 15 wrapper work consolidates the duplicate surfaces into a
  single Fusion-backed wrapper instead of shipping N near-identical wrappers." Signature
  extraction is data-driven from `componentCensus` + `uiControlClassification`, "not from
  hard-coded component names."
- **Accessibility Inventory + Playwright Test Inventory** per primitive family (current
  ARIA/`data-testid`/keyboard/screen-reader status and required remediation; existing POM
  and Gherkin coverage or gaps). Grids, charts, heavily customized tables, and composite
  forms are flagged high-risk families requiring explicit test plans.
- **Three status axes**: `inventoryCoverageStatus` (DecisionGrade|Partial|Blocked),
  `visualContractStatus` (Measured|Partial|Blocked), `step15HandoffStatus`
  (ReadyForUIReplacement|NotReadyForUIReplacement|Blocked). Fixed closing gate:
  `Ready for Step 15 Fusion UI Integration: Yes`.
- **The lightest QA twin in the kit**: `14-QA-frontend-ui-inventory-and-fusion-map` —
  "Artifact schema validation only (no test execution)", "Under 1 min ET. Chainable /
  auto-runnable." Because Step 14 changes no code, its QA is pure schema validation and is
  explicitly safe to auto-chain. Step 15's name confirmed: "Fusion UI Integration".

## ⚠ Cross-step numbering drift found in prompt 14 (MEDIUM — milder than 12/13)

Prompt 14 is largely self-consistent (`step15HandoffStatus` and "Ready for Step 15 Fusion
UI Integration" are correct for a Step 14 prompt handing off to Step 15), but three
coverage statements describe **this** step's own completeness using the wrong number:

- "Inventory without accessibility gaps documented is incomplete **Step 15** coverage."
- "Inventory without test gap analysis is incomplete **Step 15** coverage."
- "Inventory without these per-control fields populated is incomplete **Step 15** coverage
  and **Step 16** must not advance."

All three describe the inventory — Step 14's own deliverable — so they should read
Step 14 (and, in the third, likely Step 15 rather than Step 16). Notably the parallel line
in the Sub-Pattern section gets it right: "families without sub-pattern cataloging are
incomplete **Step 14** coverage."

**SUPERSEDED — see "Numbering drift SOLVED" under prompt 16.** This section originally
concluded that no single renumbering hypothesis fit prompts 12-14. Prompt 16's decoded
mojibake (`1️⃣8️⃣`/`1️⃣9️⃣` inside the Step 16 prompt) established a clean **+2 offset**
across the whole frontend block: the pipeline was renumbered down by two, and Objective
blocks were updated while Completion gates and Self-Audit blocks were not. Prompt 14's
three "incomplete Step 15 coverage" lines remain the one +1 outlier, most likely
copy-pasted boilerplate from the neighbouring prompt.

## Transcription uncertainties (prompt 14)

- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  53-61, 104-116, and 123-133.
- Double-backtick identifier styling in the Component Reuse Analysis section preserved as
  shown.
- The Required-behavior artifact paths use
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` while the
  visual-parity and visual-contract references use `.modernization/fusion-restructure/…`;
  both transcribed as shown (same divergence noted in prompt 13).
- File ends at line 164.

## Structural facts added by prompt 13

- **The last shell-level gate before UI planning** (same agent + browser tools; Balanced
  tier, 10-25 min). Owns visual, layout, navigation, and responsive parity of the
  stabilized shell. Four status axes: `shellParityStatus` (Stable|Drifting|Blocked),
  `shellGuardStatus` (Aligned|Stale|Blocked), `fieldParityStatus`
  (Reconciled|Drifting|Blocked), `step14HandoffStatus`
  (ReadyForUIPlanning|NotReadyForUIPlanning|Blocked).
- **"Regression guard, not re-derivation"** — the cleanest ownership statement in the kit:
  Step 13 CONSUMES Step 11's control/column verdict and Step 12's live-data verdict. If a
  dropped column or unfilled grid shows up here, it is "a **Step 11/12 regression** to
  route back to its owner and fix at the source, **not new Step 13 work**." Same for the
  styling foundation (Step 10). Three adjacent steps, three non-overlapping jobs, with the
  routing rule stated explicitly.
- **Visual Parity Gate** (`/.github/skills/visual-parity-gate/SKILL.md`) — composes the
  runtime-parity-checkpoint and screenshot-capture skills, **boots the modern app AND the
  legacy app on a second port when runnable**, captures matching routes, and diffs
  computed styles + screenshots against `ui-visual-contract.json` +
  `styling-foundation.json`. Per-route `pass`/`partial`/`fail` across palette, typography,
  header/nav/footer presence, nav route model, layout density. `overall: pass` only when
  every route passes or every non-pass route is in `acceptedResidualGaps[]` with a real
  reason and owner — "do not silently downgrade a `fail` route to an accepted gap."
- **Field & Control Parity Reconciliation Gate** — side-by-side comparison in the
  integrated browser, booting the modern app and the runnable legacy app
  (`LegacyCode_NETXX_Upgrade` when the original `LegacyCode/` host is not runnable) on
  separate ports, comparing "column-for-column and control-for-control". Records
  `fieldParity` roll-up plus `columnsMissing[]` / `inertControls[]` per route.
- **Two behavioral gates carried from Step 12's assertion families** now as binary
  completion gates: `filterEffectParity = pass` ("a filter that does nothing is a
  `filterEffect: fail` regardless of whether the API call returns 200") and
  `siblingListDistinctnessOverall = pass` (two tab/accordion sections showing identical
  rows "indicate a wrong discriminator or shared endpoint bug").
- **Responsive Breakpoint Parity Gate (MANDATORY)** — new dimension: capture every route
  at 375/768/1440 (overridable via `responsive-breakpoints.json`), emit
  `responsive-parity/<routeId>.json` with `breakpointPx`, legacy/modern screenshot paths,
  `pixelDiffPercent`, `layoutShifts[]`, `overflowEvents[]`, `horizontalScrollDetected`,
  `parityState` (pass|warn|fail). Legacy breakpoints reverse-engineered from
  `componentCensus` media-query evidence and "may add to (not replace) the default trio."
- **Self-Audit Checklist (MANDATORY)** — a genuinely new pattern: before closeout the
  agent must emit a self-attestation block answering every checklist row with `YES` + a
  one-line evidence pointer (file path, test id, command output line, artifact field),
  `NO` + deferral rationale + a carry-forward entry, or `N/A` + rationale. Nine rows
  covering artifact reads, style entry points, framework class-hook resolution, shell
  a11y, shell POM extraction, Gherkin scenarios, visual-regression baseline commit,
  layout/breakpoint/z-index audit, and temporary-UI-bridge classification with
  `retirementStep`. Backed by an **Agent Contract Rule (HARD GATE)** that invalidates the
  ready status when any row is `NO` without both artifacts.
- **Shell accessibility mandate** with a sharp anti-false-green clause: the `<nav>`
  landmark must render every link in the route menu metadata and each must navigate — "a
  present-but-empty `<nav>` landmark (the element and its test id exist but no links
  render) passes the landmark check yet is a navigation parity defect."
- **Unbacked framework class hooks** restated as a shell-level check (Bootstrap
  `nav-tabs`/`panel`/`dropdown`/`btn-*`/`col-*`): they "render as bare DOM (bullet lists
  where tabs are expected, always-open dropdowns, stacked blocks where grid columns are
  expected) and silently defeat visual parity."
- **Closing menu**: QA twin `13-QA-frontend-shell-stabilization` (Lanes: Browser-contract
  regression, Navigation smoke; ETA 3-5 min) / `next` → Step 14 DEV / `stop`. Step 14's
  name confirmed: "Frontend UI Inventory & Fusion Map".

## ⚠ Cross-step numbering drift found in prompt 13 (HIGH fork-risk — same class as prompt 12)

Transcribed **as photographed**, not corrected. This is the second prompt in a row with
renumbering drift, which makes it a systemic pattern rather than a one-off:

- **The Self-Audit `Agent Contract Rule (HARD GATE)` references a status field the prompt
  never defines.** The prompt declares `step14HandoffStatus`, but the hard gate says
  "`step16HandoffStatus: ReadyForUIPlanning` is INVALID when…", "an explicit **Step 16**
  carry-forward entry", and "the agent MUST downgrade **`step16HandoffStatus`** to
  `NotReadyForUIPlanning`". An agent following this literally must either error or invent
  a field.
- **The Self-Audit section contradicts itself on its own block name.** Its opening line
  requires "a `Step 13 Self-Audit` block in the chat reply"; its closing line requires
  "the literal **`Step 15 Self-Audit`** heading… A closeout without this block is treated
  as a skipped **Step 15** and must be re-run." Both cannot be satisfied.
- **The Responsive Breakpoint Parity Gate is written against Step 15**: "every **Step 15**
  stabilized route", "`fail` at any breakpoint blocks **Step 15** closeout", "a documented
  variance row in the **Step 15** stabilization report" — inside the Step 13 prompt.
- **Mixed carry-forward targets**: the Self-Audit `NO` branch says "a **Step 14**
  carry-forward entry" while checklist row 8 says "**Step 17** carry-forward" and the hard
  gate says "**Step 16** carry-forward".
- Path divergence for the same artifacts: the Required-behavior section reads them from
  `.modernization/ignition-artifacts/modernize/fusion-restructure/…` while the checklist
  and the runtime/visual gates write to `.modernization/fusion-restructure/…`.

Combined with prompt 12's 9 × "Step 14" references, this strongly suggests the frontend
block was renumbered (platform integration 14→12, stabilization 15→13, and the UI
inventory/upgrade lanes shifted with it) without the prompt bodies being updated. Every
one of these is a fork point where different developers' models will resolve the
contradiction differently, and the `-CurrentStep <n>` drain gates depend on step numbers
being literal.

## Transcription uncertainties (prompt 13)

- The drift references above are transcribed exactly as photographed and are the highest
  priority items to re-read against the source before acting.
- Window title reads `IgnitionKit1.2` (as in prompt 12's later photos) while the
  breadcrumb still reads `OpX-Ignition-Kit`.
- Double-backtick identifier styling in the Responsive Breakpoint Parity Gate preserved as
  shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  53-59, 105-110, 154-161, and 177-192.
- File ends at line 220.

## Structural facts added by prompt 12

- **The authoritative live-data + auth gate of record** for the whole app (same
  `OpX-AppMod-P2-Modernize` agent + browser tools; Premium reasoning *medium-high*
  thinking, 15-30 min). Steps 11 and 13 explicitly defer to it.
- **The two-verdict model** — the kit's strongest anti-false-green design:
  - `routeContractStatus` = the deterministic, **auth-free GATE OF RECORD** from
    `generate-ui-api-map.ps1 -FailOnBrokenCalls`. Proves every client call resolves to a
    real controller action+verb with no credentials. `brokenCallCount = 0` → `Clean`
    (required to close); `> 0` → `BrokenCalls` (closure-blocking, "a guaranteed runtime
    failure"); method-built/dynamic URLs → `UnresolvedOnly` (advisory).
  - `liveDataRenderStatus` = the authenticated render confirmation, **"never faked"**.
    `Verified` only when a route is *observed* rendering real rows under a real session.
    Explicitly NOT `Verified`: a `401`, a scanner result, a `200`, or a carried-forward
    prior observation. No usable auth session → `UnverifiedPendingAuth` (honest Partial),
    "never infer `live` from a protected `401`."
  - **Closure requires `Clean` AND `Verified`.** `Clean` + `UnverifiedPendingAuth` keeps
    the step Partial. Canonical render path: operator completes the real sign-in in the
    shared integrated-browser page, then each route's live render is observed.
- **Five status axes total**: the two above plus `protectedApiOwnershipStatus`
  (Aligned|DriftDetected|Blocked), `authRuntimeStatus` (Verified|403GapOpen|Blocked),
  `perRouteApiWiringStatus` (LiveAllInScope|PartialPerRouteList|Blocked — `LiveAllInScope`
  only when `liveDataRenderStatus: Verified`).
- **Two more MANDATORY self-check scanners** (now 6 total on this step):
  `scan-backend-parity.ps1` (dropped-mutation detection — "the UI still shows
  Add/Edit/Delete buttons over placeholder modals while no backend endpoint exists";
  waivers in `backend-parity-registry.json` `acceptedDrops[]`) and
  **`scan-functional-parity-ledger.ps1`** — new: answers "are ALL legacy behaviors
  implemented?" across Step 3 `effectClass` (mutate/filter/navigate/export/dialog), not
  just endpoints and fields. Catches "missing buttons, dead filters, or filter controls
  that show identical rows before and after applying"; waivers in
  `functional-parity-registry.json`.
- **Runtime-checkpoint assertion families** (new, behavioral not structural):
  `filterAssertions[]` must show `rowsChanged: true` per filter control (identical rows
  before/after = `filterEffect: fail`); `siblingListDistinctness[]` must confirm sibling
  list sections backed by separate calls return distinct first-row content;
  `mutateWiringAssertions[]` must show `networkCallObserved: true` ("a modal that opens
  but never fires a write call is a `mutateWiring: fail`").
- **Full Playwright auth infrastructure shipped inline**: `LoginPage` / `CallbackPage` /
  `UnauthorizedPage` POMs plus a 4-case `auth.journey.spec.ts` (sign-in, sign-out,
  unauthorized redirect, 403-insufficient-permissions) with `STEP12-E2E-AUTH-00N` CaseIds
  in JSDoc and Given/When/Then comments. Explicit rule: **"NO .feature files"** — all
  scenarios live inline as comments, no step definitions. (Note this contradicts Step 6's
  Gherkin `.feature`-per-journey planning; see uncertainties.)
- **Angular 20+ code-quality mandate**: standalone components with `imports: []` (no
  NgModules), signals (`signal()`/`computed()`/`effect()`), `@let`, `inject()` over
  `@Inject()`, `@if`/`@for`/`@switch`, `DestroyRef` + `takeUntilDestroyed()`. "Platform
  code with NgModules or legacy patterns is incomplete Step 12 coverage."
- **A11y & testability mandate**: `aria-label`/`aria-labelledby`, `data-testid`, `role`
  when semantic HTML is insufficient, focus management for auth flows/callbacks, error
  messages linked via `aria-describedby`.
- **API Smoke re-run before any integration work**: re-run the Step-8-planned
  `tests/backend/smoke/` probes at 100% pass against `progressDenominators.totalApiEndpoints`
  — "the cheapest signal that the backend process actually loaded the current build
  (a stale-DLL / stale-process regression …)". Honors the T1-T5 safety tiers; sub-100%
  must be a tracked `deferralId`, "not a silent skip."
- **Deferral-drain gate — "Step 12 owns 'no button is dead'"**: `scan-ui-parity-gaps.ps1
  -CurrentStep 12` re-flags any deferral whose `ownerStep <= 12` as a Major InertControl;
  `deferredInertControlCount` for Step-12-or-earlier owners must reach 0. "A
  `majorGaps = 0` with parked stubs still owed here is not a pass."
- **Per-Route HAR Diff Gate (MANDATORY)** — new proof technique: record a HAR for the same
  scripted journey against BOTH legacy and modern runtimes, diff into
  `route-har-diff/<routeId>.json` (`apiCallSequenceLegacy/Modern[]`, `extraCallsInModern`,
  `missingCallsInModern`, `reorderedCalls`, `payloadShapeDeltas`, `authHeaderDeltas`,
  byte/count totals). Any extra/missing/reordered call or auth-header drift blocks the
  route unless approved as an intentional plan delta. Journey script comes from
  `screenshotCoverageMatrix` + a new `userJourneyCatalog`, "not from hand-written per-app
  scripts."
- **Workflow Trace coverage gate (state-machine parity, not just edge parity)**: for every
  `fully-traced` row, a spec must assert (a) verb+URL, (b) payload structure matches
  `requestShape` **exactly** incl. nested-vs-flat and casing ("the most common parity
  400"), (c) response bound to documented UI surfaces, and (d) every `visibleStateLabels`
  entry appeared *and disappeared* at the correct state-machine point. "Asserting only
  that the API was called is insufficient and has shipped parity defects to users."
- **Parameterized/detail routes: "never defer"** — a detail route marked "route-verified,
  deferred to UAT because it needs a real record" hides a `404` (client calls a
  path-parameter endpoint the backend only registered as a query-string GET).
- **Runtime Error Watch**: integrated browser DevTools console + backend log stream open
  side by side; a route that "looks loaded" while the console shows a swallowed `400` or
  the backend logged a `500` is not `live`.
- **Closing menu**: QA twin `12-QA-frontend-platform-integration` (Lanes: Contract, Auth
  interceptor checks; ETA 5-8 min) / `next` → Step 13 DEV / `stop`. Step 13's name
  confirmed: "Frontend Shell Stabilization".

## ⚠ Cross-step numbering drift found in prompt 12 (HIGH fork-risk)

This is the most consequential drift found so far and is transcribed **as photographed**,
not corrected:

- **"Step 14" appears 9 times inside the Step 12 prompt** — "resolve every broken call
  before Step 14 closes", "the Step 14 hard gate is machine-enforced", "Step 14 cannot
  close while `summary.brokenCallCount > 0`", "Step 14 owns the gate that every migrated
  route's primary data calls actually reach the real protected backend", "Step 14 must
  also load `workflow-trace-inventory.json`", "Step 14 cannot close while any
  `fully-traced` row lacks a passing spec", "keep Step 14 open" (403 gap), "When Step 14
  cites current startup-proof evidence…", "For every route exercised by Step 14 platform
  integration". Meanwhile the header, ownership boundary, verdict model, completion gate,
  and closing menu all say **Step 12**.
- Companion drift in the same region: "the **Step 8** per-route behavior plan" (that
  artifact is Step 6's `per-route-behavior-plan.json`), "the **Step 13**
  `perRouteBehaviorList`" (that list is Step 11's), "`workflow-trace-inventory.json`
  (produced in **Step 5**)" (Step 3 produces it per prompt 03), "an intentional plan delta
  in **Step 7's** `apiIntegrationPlan`" (Step 5 owns `apiIntegrationPlan` per prompt 05),
  "record an explicit **Step 8** retirement decision" (retirement decisions are Step 8 in
  prompt 11's wording, so this one may be correct), and a `workflow-trace-inventory.json`
  path under `.modernization/legacy-analysis/` where prompt 03 puts it under
  `.modernization/ignition-artifacts/discovery/`.
- **Why it matters:** this reads like content authored when platform integration was
  numbered Step 14 (and analysis/planning sat at different numbers), then renumbered
  without updating the body. Every one of these is a fork point — two developers' models
  will resolve "Step 14 cannot close" differently inside a step labelled 12, and the
  `-CurrentStep` drain gates depend on step numbers being literal.

## Transcription uncertainties (prompt 12)

- The step-number references above are transcribed exactly as photographed; several are
  in heavily-wrapped lines, so the *specific* numbers in the "Step 8 per-route behavior
  plan / Step 13 perRouteBehaviorList" clause are the least legible of the set and should
  be re-read against the source before acting on them.
- The window title changes from `OpX-Ignition-Kit [Administrator]` (photos 1-5) to
  `IgnitionKit1.2` (photos 6-9) while the breadcrumb still reads `OpX-Ignition-Kit`;
  possibly a second workspace or version folder. Both photo sets agree on the overlapping
  lines 237-256, so the content is consistent.
- The Step-12 "NO .feature files" rule directly contradicts prompt 06's Gherkin planning
  (`{feature-name}.feature` per user journey, `@smoke`/`@regression` tags); preserved
  as-is in both files.
- `generate-integration-tests.ps1` writes to `tests/frontend/e2e/integration/generated/`
  in one clause and `tests/frontend/integrationFrontend/` in the next; both transcribed
  as shown.
- Double-backtick identifier styling in the HAR Diff Gate section preserved as shown.
- Long wrapped lines throughout reconstructed from wrap positions; overlaps verified at
  237-256, 287-301, 323-327, and 347-363.
- File ends at line 381.

## Structural facts added by prompt 11

- **The route-family move lane** (same `OpX-AppMod-P2-Modernize` agent + browser/agent/todo/
  vscodeAPI/fusion-copilot-docs tools as Step 10; Premium tier this time, 20-45 min).
  Moves the *real* legacy pages and shared client code into the target root "one route
  family at a time," explicitly NOT re-creating thinner versions from memory: "Parity is
  the starting state you preserve, not a percentage you climb toward."
- **A new self-check: content reconciliation** (`Invoke-StepReconciliation.ps1 -Step 11`)
  — proves every `LegacyRoute` in `per-route-behavior-plan.json` actually existed in the
  Step 3 legacy analysis ("a shape check cannot catch a behavior plan that invents a
  route that never existed"). Each failure prints a `Fix:` line routing back to Step 3
  (real route) or Step 6 (wrong plan). First appearance of semantic (not just structural)
  input validation.
- **A new self-check: scaffold-debt scan** (`scan-scaffold-debt.ps1 -CurrentStep 11`) —
  flags surviving "Step N wires this" markers / placeholder bodies whose owning step has
  been reached; exit 2 = overdue markers survive; a scaffold-debt registry holds
  genuinely-intentional notes. Same `-CurrentStep <n>` drain pattern as Step 10's
  `deferral-drain` dimension.
- **The single-authoritative-data-gate boundary is spelled out**: Step 11 OWNS control/
  column/field presence + wiring each data call site to its real service; it does NOT own
  the authoritative live-data verdict — that's **Step 12's single authoritative data
  gate**. A wired-but-empty grid is acceptable *provisionally*; a shipped placeholder as
  *final* state is a defect. `dataBindingParity = pass (provisional)` is a distinct gate
  value. This is the cleanest example yet of two adjacent steps deliberately NOT
  re-litigating each other's territory.
- **Move-and-preserve, NOT Fusion-conversion**: deliberate primitive-family swaps belong
  to Step 14 planning + Step 15/16 execution; an opportunistic single-control swap is
  allowed only if incidental AND reaches legacy visual parity in the same pass. "Never
  leave a half-configured Fusion control behind" — a `fusion-*` primitive with wrong
  variant/color/width is a parity defect, not progress.
- **Forbidden per-route hand-offs** (must be fixed or named as blockers): surviving
  `javascript:void(0)`/`href="#"`/`onclick="return false"` inline handlers; unwired
  legacy modal/banner/toast/confirmation triggers (incl. "authorized users only"
  banners); data-bound controls rendering placeholder/seed/fixture instead of the real
  call site; **column collapse** (real data but fewer/more-generic columns than legacy —
  "every legacy column is part of the parity contract"); export/print/upload controls
  that call no service; keyboard shortcuts/focus traps that no longer fire. Each
  unresolved one → `perRouteBehaviorList` row `{route, interactiveElement,
  dispositionInStep11, ownerStepIfDeferred}`.
- **Framework-class-hook verification**: Bootstrap `nav-tabs`/`panel`/`dropdown`/`btn-*`/
  `col-*` etc. copied from legacy templates must be backed by a stylesheet actually
  loaded in the modern shell — otherwise "bare DOM that renders as unstyled lists or
  stacked blocks." (Exactly the FieldServe-style gotcha from our rehearsals.)
- **Guard redirect-target audit**: every `canActivate` denial-redirect (e.g.
  `FusionRoleGuard(GROUPS, 'access-denied')`) must point at a *declared* route — an
  undeclared target silently falls through to the wildcard/home route and "hides the
  access-denied condition entirely." A routing-integrity defect owned here, not Step 12.
- **Parameterized/detail-route wiring**: wire every path-param route (e.g.
  `filekeys/log/:keyNo/:changeNo`) and reach it from its parent grid; Step 12 is the gate
  of record for the `404` case (client calls a path-param endpoint the backend only
  registered as a query-string GET) — a concrete route-contract failure class.
- **`deferredInertControlCount` vs `majorGaps`**: `majorGaps=0` with a nonzero deferred
  count means behavior is "PARKED, not done"; every parked handler needs a truthful
  `ownerStep` whose gate actually verifies it ("a dead export/add/delete button belongs
  to Step 12 'no button is dead', not a vague 'later'"). The `ui-deferral-registry.json`
  is the same registry Step 10's scanner reads.
- **Dead-Code Trace Gate (MANDATORY)**: static reachability sweep from the modern router
  roots (Angular `Routes` / React `createBrowserRouter` / Vue `createRouter` / Blazor
  `Router` / MVC route table / Razor Pages folders — data-driven from `componentCensus`)
  → `dead-code-trace.json` with `filePath`/`reachableFromRoot`/`rootChain[]`/`keepReason?`.
  `reachableFromRoot:false` + no `keepReason` blocks closeout (wire it, document a
  reviewer-approved keepReason, or delete). A modernization-specific dead-code gate we
  didn't have.
- **Four-axis status**: `sharedCodeMigrationStatus` (Validated|Partial|Blocked),
  `routeFamilyStatus` (Validated|Partial|Blocked), `behaviorPreservationStatus`
  (Preserved|PartialPerRouteList|Blocked), `step12HandoffStatus`
  (ReadyForPlatformIntegration|NotReadyForPlatformIntegration|Blocked). Fixed closing
  gate line: `Ready for Step 12 Frontend Platform Integration: Yes`.
- **Closing menu**: QA twin `11-QA-frontend-migration` (Lanes: Browser-contract, Visual
  parity; ETA 5-10 min) / `next` → Step 12 DEV (Frontend Platform Integration) / `stop`.
  Step 12's name confirmed: "Frontend Platform Integration".

## Transcription uncertainties (prompt 11)

- This prompt is unusually dense with very long wrapped lines (the forbidden-handoffs and
  runtime-checkpoint bullets each wrap 4-6 visual lines); reconstructed from wrap
  positions with overlaps verified at 46-53, 84-94, and 118-120.
- Double-backtick identifier styling appears in the Dead-Code Trace Gate section (as in
  prompts 04-10); preserved as shown.
- `4xx`/`5xx` and `≈`-free inline code transcribed exactly as shown.
- File ends at line 158 (content through line 157 + trailing blank).

## Structural facts added by prompt 10

- **First frontend prompt; expanded tools list**: same `OpX-AppMod-P2-Modernize` agent,
  Balanced tier (15-30 min, no model pin), but the frontmatter `tools` now adds `agent`,
  `browser`, `todo`, `vscode/vscodeAPI`, and `fusion/copilot-docs/*` — the first prompt
  that drives a live browser and the Fusion copilot-docs MCP.
- **Plain-language framing**: opens with a "What This Step Does (plain language)" block
  (what/why-it-matters/what-you'll-have) per `step-confidence-contract.instructions.md`
  ("open in plain language, end on binary gates, prove `src/` changes against the running
  app"). This is a different rhetorical register from the backend prompts.
- **Anti-drift ownership contract made explicit**: "Each numbered step owns exactly one
  concern so a defect always has one home and no two steps re-litigate the same
  territory." Step 10 **OWNS the styling foundation outright**; Steps 11-16 consume it,
  never re-author it. Steps 11/12/13 must re-run `scan-styling-foundation.ps1` as an
  entry check — a regressed foundation is a "Step 10 regression" fixed at the foundation,
  never patched in one page.
- **Shared decomposition-skill router**: `/.github/skills/browser-source-decomposition/SKILL.md`
  classifies the legacy source (server-rendered / browser-led SPA / Fusion G1 / mixed /
  static-document / already-modern / validate-only). Each branch routes to a dedicated
  sub-prompt that must run in full before shell formation closes:
  `.github/prompts/P2-Modernize/mvc-to-browser-client.prompt.md` (→
  `MVC-To-Browser-Client-Decomposition-Contract.generated.json`) and
  `angular-to-browser-client.prompt.md` (→
  `Angular-To-Browser-Client-Decomposition-Contract.generated.json`). Mixed/hybrid runs
  both. A whole family of decomposition contracts we hadn't seen.
- **`browserSurfaceApplicability` from Step 7** gates the lane: `Required` = full
  foundation+scaffold loop; `NotApplicable` = lightweight proof pass. Portal republish is
  never automatic — staleness is reported in chat for manual refresh.
- **Two deterministic parity scanners** (both under `.github/scripts/parity/`):
  - `scan-styling-foundation.ps1 -ModernClientRoot <root>` — statically fails on OS
    `prefers-color-scheme` following instead of pinned legacy scheme, no style
    `includePaths`, no shared partials, header not bound to legacy brand color, or a data
    grid with all auto-sized columns.
  - `scan-ui-parity-gaps.ps1 -Quiet` — multi-dimensional control-parity scanner. Pairs
    every legacy `<a>`/`<button>`/`<li>` with every modern `<app-*>`/`<fusion-*>` wrapper
    (incl. inline `template:` blocks and tab-data arrays) across a **registry of named
    parity dimensions**, each a self-contained rule pack (legacy extractor / modern
    extractor / normalizer / comparator / allowlist). Built-in dimensions: `label`
    (MissingLabel Major), `icon` (FA4 alias + semantic-vocab normalization → MissingIcon
    Critical / IconMismatch Minor), `color` (Bootstrap `btn-*` ↔ Fusion `color=` via
    `$BootstrapColorMap` → ColorMismatch Minor), `column` (MissingColumn Major — the
    "column-collapse" defect), `handler-wiring` (empty/TODO `(click)` or
    `[disabled]="true"` → InertControl Major), `deferral-drain` (per-app deferral registry
    `ui-deferral-registry.json` with `{handler, ownerStep, reason}`; `-CurrentStep <n>`
    re-flags any deferral whose `ownerStep <= n` — "a deferral cannot survive past the
    step that promised to wire it"). Gate fails on `criticalGaps>0 || majorGaps>0`.
- **"Discovery probe" for unknown-unknowns**: the same scan emits a `discoveryProbe` block
  ranking every legacy attribute/class-token family that NO active dimension consumed, by
  frequency — the kit's mechanism for surfacing parity dimensions it has never seen
  (`confirm`, `tooltip`, `ng-disabled`, `accesskey`...). Plus a documented "Adding a new
  dimension (recipe)" (alias map → `$rec.X` in both Scan-File branches → copy the color
  DIMENSION PASS block → append to `summary.dimensions`). This is a self-extending gate.
- **Render-verified over field-recorded**: the Runtime Parity Checkpoint insists gates be
  proved by *observed browser render*, not by trusting `colorSchemeForced` /
  `brandBindingVerified` JSON claims. "A clean build, a scanner `majorGaps=0`, or an HTTP
  200 are necessary but never sufficient" — a gate recorded `pass` from those proxies is
  invalid; unrenderable → `blocked`/`unverified`, keep the step open. Strongest
  false-green guard in the kit so far.
- **Interaction Wiring + Workflow Trace enforcement at scaffold time**: every rendered
  control must map to a Step 5 `interaction-wiring-inventory.json` entry (reproduce
  `target`/`sideEffects`/`authGate`); high-risk `wiringKind` controls must reproduce the
  `workflow-trace-inventory.json` `requestShape` EXACTLY (verb/URL/payload nesting+casing
  — "flat-vs-nested mismatches ... are the most common parity 400") and every
  `visibleStateLabels` entry. "A button that looks right but has no handler" is a parity
  defect, not cosmetic.
- **Design Tokens Extraction (MANDATORY)**: first pass extracts
  `styling-foundation.tokens.json` (families: color/spacing/typography/borderRadius/
  shadow/zIndex/motion; each row `tokenId`/`valueLight`/`valueDark?`/`sourceEvidencePath`/
  `usageCount`/`mapsToFusionToken?` verified via Fusion MCP), emitted as CSS custom
  properties in `src/<App>.Web.Client/src/styles/_tokens.css`. Raw hex/pixels/font-stacks
  in component CSS are a violation caught by Step 13 + Step 17.
- **"Legacy Visual Language By Construction"**: the goal is the modern shell resembles the
  legacy app "from the first page paste rather than being restyled to parity later." Bind
  the legacy palette through the theme system's **actual consumed API** (`@fusion/theme`
  override map + `root/main` header-branding, or Bootstrap `$bootstrap-config`), NOT as
  orphan CSS custom properties ("a generated `--color-brand-*` that no generator reads
  changes nothing"). Force the legacy color scheme — never inherit OS
  `prefers-color-scheme` (the starter `index.html` ships a `dark-theme`-from-OS script
  that must be neutralized). Five named failure conditions (empty nav / raw default theme
  / wrong scheme / wrong header color or field sizing / missing chrome) = exactly what the
  Step 13 visual-parity gate measures.
- **Per-Slice Shell Parity + Repeat-Run Recommendation (both MANDATORY)**: Phase 2
  frontend advances incrementally from Step 10, one shell slice per pass targeting +5-10pp
  of screenshot/visual/inventory parity, ROI-scored
  `(visibilityScore + interactionScore) - riskScore`; first 3 passes must produce a
  user-visible change. Each pass emits per-slice pixel+structural diffs under
  `parity-diffs/step10-pass-{passId}/` and a `step10-pass-log.json`. Closeout `Suggestions`
  must recommend rerunning with the next slice + expected gain (same wording as Steps
  15/16). New instructions files: `frontend-modernization-learning.instructions.md`
  (Slice Parity And ROI Rules) and `testing-design-contract.instructions.md` (Slice
  Parity Floor And Flake Budget).
- **Fixed response spine**: `About To Do` (Context/Dev work/QA after) → `Modernization
  Added` → `UI Parity Snapshot` (screenshot coverage / visual parity / inventory parity /
  selector coverage / overall rating/10) → `Suggestions` → `Returned Data` (~35 named
  fields incl. the 3 status axes, parity percentages, and `controlParity*` gap counts).
- **Portal surface rename**: canonical Step 10 page is now `frontend-foundation-and-scaffold`
  (`.html`+`.json` under `portal/data/pages/`); the old `frontend-modernization-parity.*`
  is retired and any lingering reference is "dead-surface drift."
- **Three-axis status**: `decompositionContractStatus`
  (Current|NotApplicable|Blocked), `shellFoundationStatus` (Validated|Partial|Blocked),
  `step11HandoffStatus` (ReadyForMigration|NotReadyForMigration|Blocked). Fixed closing
  gate line: `Ready for Step 11 Frontend Migration: Yes`.
- **Closing menu**: QA twin `10-QA-frontend-foundation-and-scaffold` (Lanes:
  Browser-contract shell smoke; ETA 3-5 min) / `next` → Step 11 DEV (Frontend Migration) /
  `stop`. Step 11's name confirmed: "Frontend Migration".

## Transcription uncertainties (prompt 10)

- Double-backtick identifier styling appears in the Design Tokens and Legacy-Visual
  sections (as in prompts 04-09); preserved as shown.
- The `deferral-drain` and `column`/`handler-wiring` dimension bullets wrap heavily and
  were reconstructed from wrap positions; wording verified across the 216-221 overlap
  between the two photo batches.
- `≈` (approximately-equal) used in the icon FA4 alias examples renders faintly in the
  photo; transcribed as `≈`.
- A couple of long completion-gate / visual-language paragraphs were reconstructed from
  wrap positions; overlaps verified at 249-255 and 274-294.
- File ends at line 313 (content through line 311 + trailing blanks).

## Structural facts added by prompt 09

- **Step 9 = production-style backend hardening lane** after Step 8 formation (same
  `OpX-AppMod-P2-Modernize` agent, GPT-5.3-Codex model requirement, Premium tier,
  20-40 min). Frontmatter uses the full `description`/`name`/`argument-hint`/`agent`
  form (like prompts 01-03), not the inline-array style of 07.
- **New MANDATORY self-check: backend functionality-parity scan** — a fourth self-check
  bullet beyond input/restore-point/output. `scan-backend-parity.ps1 -Quiet` proves
  every LEGACY backend endpoint — especially every mutation
  (POST/PUT/DELETE/PATCH: Add/Edit/Delete/Link/Export) — has a modern counterpart.
  Exit 2 = modern API dropped write endpoints; port them or record `acceptedDrops[]`
  (with reason) in `.modernization/ignition-artifacts/discovery/backend-parity-registry.json`.
  Rationale captured verbatim: "Catching a dropped mutation HERE (backend formation) is
  far cheaper than discovering at Step 12 that the UI has Add/Edit/Delete buttons with
  no endpoint behind them." New shared script dir: `.github/scripts/parity/`.
- **Fusion Console logging provider is the mandated logging path**: install
  `Fusion.Fx.Logging.Providers.Console` (latest Sonatype production version), add
  `"FusionConsole": {}` to the `appsettings.json` Logging section (presence triggers
  auto-registration via the Fusion app builder), consult
  `fusion-readme:///src/dotnet/Fusion.Fx.Logging.Providers.Console/README.md` via
  **Fusion MCP** (`fusion-readme://` is a real MCP resource URI scheme). Logs emit as
  JSON to stdout/stderr — no extra ILogger registration needed. Application Insights is
  explicitly a future lane, not required for Step 9.
- **Store-level logging + error-handling contract**: repositories inject `ILogger<T>`,
  log at every DB failure boundary; connection-open failures caught and logged with
  `SqlException.Number` + message + `Data Source` (never passwords) then rethrown → HTTP
  500; each mutation (`Insert`/`Update`/`Delete`/`Upsert`) catches `SqlException`
  separately and returns the legacy error-signaling value instead of throwing (preserves
  service contract); `LogDebug` before each stored-proc call. Same Dapper typed-mapping
  and constructor-parity rules as Step 8, now with the exact materialization exception
  string quoted as a hard-fail signature.
- **Connection-string startup proof**: validate `ConnectionStrings:<name>` resolves
  non-empty at construction time (log `LogError` at startup if empty — "a green
  `dotnet build` does NOT prove the connection string is populated"); DNS-lookup/ping
  the server name before committing; correct env-specific name comes from legacy
  `Configuration/<env>/` files, NOT commented-out `Repository.cs` shortcuts. Split
  env-var pattern reconfirmed:
  `SqlServer__Server|Database|Username|Password|Encrypt|TrustServerCertificate`;
  `startupProofStatus = Blocked` when a first-request 500 comes from a missing config key.
- **SqlClient TLS scar restated** (3rd appearance): `Microsoft.Data.SqlClient` on
  .NET 6+ enforces TLS validation → `Win32Exception 0x80090325 "certificate chain was
  issued by an authority that is not trusted"` even when PowerShell `SqlConnection`
  (older `System.Data.SqlClient`) works; fix `TrustServerCertificate=True` in
  `appsettings.Development.json` only, never prod/staging.
- **Authorization policy registration verification**: grep `[Authorize(Policy =` and
  cross-check every named policy against `AddAuthorization(...AddPolicy(...))` — a missing
  policy throws `InvalidOperationException` at first request (generic 500), invisible at
  build time. Verify during startup proof, not by reading code.
- **Three-axis Step 9 status**: `controlPointAlignmentStatus`
  (Aligned|DriftDetected|Blocked), `integrationProtectionStatus` (Current|Partial|Blocked),
  `startupProofStatus` (CurrentBuildBacked|SkippedBuildCoverageExplicit|Blocked). The
  "SkippedBuildCoverageExplicit" value + the `test-workspace-gates.json`
  `refreshSafePreflight`/`skipFlags.skipApiBuild` check = the kit refuses to let a skipped
  API build masquerade as real hardening proof (false-green guard).
- **DEV/QA lane separation restated**: Step 9 DEV *creates* the IntegrationBackend,
  ContractApi, and Db test projects + initial tests but does NOT execute them —
  execution proofs owned by `09-QA-backend-dotnet-integration-hardening`. DEV proof is
  `dotnet build` against `src/<AppName>.Web.Api` (build-backed startup proof) plus ≥1
  real runtime request per newly hardened DB-backed endpoint.
- **Backend Load Smoke Gate (MANDATORY)** — new perf gate: 60s load smoke (configurable
  from Step 7 `performanceBudgetPlan`) against top-N `apiEndpointCatalog` endpoints
  (default N=5) using Bombardier/k6/NBomber/hey, data-driven from `load-smoke.config.json`
  (default Bombardier on Windows, k6 on Linux/macOS). Captures rps/p50/p95/p99/errorRate
  to `backend-load-smoke.json`; fails when below `requestsPerSecondFloor` or above
  `p95LatencyCeiling`; when Step 7 declared no budget, this run *becomes* the baseline
  floor/ceiling for Step 17. Auth scheme from `authIntegrationCatalog` — "never invent a
  token shape."
- **Comment/annotation cleanup**: strip stale future-step wording ("another step *will*
  harden this"), remove unused `using` directives, declare `ProducesResponseType` with
  concrete CLR types, no anonymous-object success payloads for documented API surfaces.
- **Closing menu**: QA twin `09-QA-backend-dotnet-integration-hardening` (Lanes:
  Integration, Contract, Db; ETA 5-10 min) / `next` → Step 10 DEV (Frontend Foundation &
  Scaffold) / `stop`. No fixed "Ready for Step 10..." closing line in this prompt (unlike
  07/08) — closeout is the three status fields + the menu.

## Transcription uncertainties (prompt 09)

- The `About To Do` header is rendered as a bullet (`- About To Do`) in the photo,
  unlike prompts 07/08 where it's a plain heading; preserved as photographed.
- Several long connection-string / SqlClient / policy-verification paragraphs wrap
  heavily and were reconstructed from wrap positions; wording verified across photo
  overlaps at lines 38-51, 106-134.
- Double-backtick identifier styling appears in the DEV/QA-separation and Load-Smoke
  sections (as in prompts 04-08); preserved as shown.
- `Win32Exception 0x80090325` and `TrustServerCertificate=True` transcribed exactly as
  shown.
- File ends ~line 172 in the editor (trailing blanks after line 167 of content).

## Structural facts added by prompt 08

- **Cross-vendor per-step model pin**: `Model requirement: Step 8 execution must run on
  GPT-5.3-Codex` (in prose, not frontmatter). With prompt 03's `model: Claude Opus 4.6
  (copilot)` frontmatter pin, the kit picks specific models per step across vendors —
  Opus for heavy analysis, Codex for heavy code movement. New agent:
  `OpX-AppMod-P2-Modernize` (Premium tier, 20-40 min).
- **Two new self-check gates**: restore-point precheck
  (`.github/scripts/Workspace/Invoke-StepRestorePoint.ps1 -Step 8 -Mode Verify|Ensure` —
  no `src/` or `LegacyCode/` mutations until a restore point exists) and a **Fusion MCP
  preflight** (must successfully call `mcp_fusion_fusion_api_docs_entrypoints` or the
  step is `Blocked` with "Fusion MCP unavailable" — never make unverified
  Fusion-structure decisions).
- **Two new skills**: `/.github/skills/architecture-structure/Architecture-Structure.md`
  (applied "literally": entities under `Library/Models/Entities/`, API transport DTOs
  stay in Web.Api, ambiguity resolved explicitly as `Entity` | `API transport model` |
  `Temporary bridge`) and `/.github/skills/fusion-feature-standards/SKILL.md`. Per-app
  addendum: `.modernization/ignition-artifacts/addendums/Architecture-Structure.md`
  (additive clarification only — never rewrite authored guidance).
- **Formation ordering law**: `Library` formed and validated FIRST, then `Web.Api`;
  client scaffold explicitly belongs to Steps 10-11. Statuses:
  `libraryFormationStatus`/`apiFormationStatus` (Validated|Incomplete|Blocked),
  `step9HandoffStatus` (ReadyForHardening|NotReadyForHardening|Blocked).
- **Move-not-copy doctrine**: form destination slice → validate there → remove prior
  source; fallback only create-validate-delete with leftovers reported as "visible
  drift"; closeout gate blocks if movement accounting is `none` when blockers are
  absent; Step 7 clone workspace deleted after consumption (disposition recorded as
  `Deleted`|`Retained by user request`|`Blocked`).
- **Anti-fake-data guardrail**: production seams must not replace DB-backed behavior
  with hardcoded in-memory stores (in-memory only under `tests/**`); unavoidable
  bridges classified `Temporary bridge`, thin, replacement routed to Step 9.
- **Battle scars**: Authorization Policy DI checklist (unported named policies throw
  `InvalidOperationException` → generic 500 before controller body, invisible at build;
  grep legacy Startup for AddPolicy/AddAuthorization/IAuthorizationHandler); Dapper
  typed-mapping parity rule (constructor CLR types must match SQL column CLR types;
  two-step mapping when contracts differ; ≥1 real runtime call per DB-backed endpoint
  before closeout); domain-capability naming (no `Home*`/`Pj*` service names);
  starter placeholder cleanup (MyEntitiesController/PublicTextController).
- **Step 8 = heaviest unit-test growth step**: full scaffolding specified inline
  (csproj net10.0 + xunit/Moq/FluentAssertions/coverlet, GlobalUsings, 4-line file
  purpose block, CaseId/Scenario/Description/Input/Expected comments per catalog);
  exit criteria "EXECUTION ONLY — DO NOT DERIVE"; tracker update shows
  `step8Target: 60`, `step9Target: 80` (confirming prompt 06's tracker keys were
  step-numbered oddly there; flagged in prompt 06 uncertainties).
- **Layering Enforcement Gate**: NetArchTest-style rules in
  `tests/backend/<App>.Architecture.Tests` run via `dotnet test` in CI — Library must
  not reference Web.Api/hosting types; Web.Api must not reference legacy assemblies
  after a slice closes (closed-slice list from `slice-status.json`); no
  System.Web/System.Web.Mvc/System.Web.Http/WebActivatorEx per
  `forbidden-references.json` — forbidden-namespace list is **data-driven from JSON,
  not hard-coded in the test class**. Layering violations fail the build.
- **Protected starter shell**: `Program.cs`, DI composition seams, logging/bootstrap,
  auth wiring, OpenAPI/Scalar setup are never replaced/regenerated unless Step 5
  decisions explicitly allow a narrow rebind; platform concerns re-home into
  starter/Fusion-native sections or `ConnectionStrings` (one centralized startup-bound
  composition seam for split DB env vars — no raw env reads in feature code);
  policy-based authorization only (no Windows auth/Negotiate/direct role checks as
  target state).
- **Code comment quality contract**: file-header comments (what/why/fit), `<summary>`
  on every public type/method, inline comments wherever non-obvious legacy behavior is
  preserved, "explain *why*, not just *what*", no TODO-without-owner, no
  `// generated` markers.
- **Closing menu**: QA twin `08-QA-backend-modernization-formation` (Lanes: Unit,
  ETA 3-5 min) / `next` → Step 9 DEV / `stop`. Step 9's name confirmed: "Backend
  .NET Integration Hardening". Step 10's name confirmed: "Frontend Foundation &
  Scaffold". Fixed closing line: `Ready for Step 9 BackEnd - .NET Integration
  Hardening: Yes or No`.

## Transcription uncertainties (prompt 08)

- The unit-test directory tree (lines ~124-134) renders its box-drawing characters as
  garbled glyphs in the photo; transcribed with ASCII `+--`/`|` tree characters.
- Double-backtick identifier styling appears in the Layering Enforcement Gate and a few
  earlier sections (as in prompts 04-06); preserved as shown.
- Two adjacent near-duplicate bullets under Required work ("Move or prepare only the
  backend shell..." with and without the trailing clause) preserved as photographed —
  apparent source duplication.
- Duplicate Quality-bar bullets ("stable enough for Step 10...") with and without the
  trailing clause likewise preserved as photographed.
- Long wrapped lines reconstructed; overlaps verified at 57-61, 97-113, 135-158,
  193-200, 248-256, 301-306, 355-360, 395-400, 437-444, and 475-498.
- File ends at line 523.

## Structural facts added by prompt 07

- **First Phase 2 prompt; new per-lane agent**: `agent: OpX-dotnet-upgrade` (not the
  Discovery agent) — confirming agents are per-workstream. Frontmatter uses a third
  style: inline `tools: [...]` array. Balanced tier, 15-30 min; no model pin.
- **DEV/QA prompt pairing**: every Phase 2 step has a QA twin (`07-QA-backend-upgrade-dotnet`,
  invocable as `/07-QA-backend-upgrade-dotnet`). DEV ends with a numbered-choice menu
  (`QA` recommended / `next` / `stop`) plus per-lane QA preview (HTTP verify, Screenshot,
  Legacy characterization, Modern characterization, Coverage gap assessment, Legacy
  frontend compatibility, Evidence refresh) and an ETA. Closeout must list every
  created/modified file as workspace-relative markdown links.
- **Dual execution modes** declared from host topology: `RunnableRuntime` (full runtime
  proof required) vs `ConstrainedLegacyHost` (classic System.Web/MVC/WebForms that cannot
  truthfully run as net10 in-place → build + invariant + handoff evidence instead, with
  runtime marked `N/A`, not `Blocked`) — a "truthful constraint" pattern that avoids
  false-red gates without softening them.
- **"Build-green is NOT done" doctrine** with layered runtime proof: infrastructure probe
  (OpenAPI → Swagger JSON → Swagger UI → root, with curl retry flags) → **deep API probe**
  (authenticated real controller route; anonymous 401/403 is explicitly *inconclusive*;
  capture the body, never `-o NUL`; a 500's `InnerMessage` naming DB/TLS/login is a REAL
  upgrade regression, not environmental) → **loaded-vs-compiled invariant re-check** on
  the run/publish folder → **loader-exception log scan** (MissingMethodException etc. is
  a hard failure even with healthy HTTP status — "the app's own error handling can remap
  a fatal loader fault to an ordinary status") → **readiness gate 8a** (cross-origin CORS
  test from the planned Angular port, middleware source-reading, fix/rebuild/retest loop,
  `readinessVerification` block recorded in the step ledger).
- **`verify-upgrade-invariants.ps1`** — new shared gate: single-version package invariant
  across the whole closure (catches split-version/diamond breaks a green build hides),
  with `-PublishDir` mode for shipped-vs-compiled cross-check; test projects classified
  separately (report, don't block).
- **Mutable workspace discipline**: work ONLY in `step7UpgradeWorkspaceRoot`
  (`.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`), never repo `src/`
  (gate-only input, reminder-only baseline check) and never `LegacyCode/`; workspace
  self-heals by copying the whole legacy solution from `authoritativeLegacyRoot`;
  contract values are advisory and path-verified ("never treat a value read from the
  contract as ground truth"). Port defaults 5100/5200; 4200/5001 reserved for the
  modernized src app. Port clearing requires PID ownership validation before
  force-stopping.
- **Project taxonomy**: `Direct` (can move fully to target runtime now) vs `BlockedHost`
  (legacy ASP.NET host started via IIS Express `/clr:v4.0` instead); copied test
  projects are carry-forward context only (Step 8 owns test upgrades).
- **Battle-scar package rules** (mirrors our rehearsal findings): SqlClient 4.0+
  `Encrypt` default flip → `TrustServerCertificate=True` (full failure narrative,
  "a build never reveals this"); EF Core version-matching (3.x on .NET 10 "will compile
  but crash at runtime"); `SqlFunctionExpression.Create` removal →
  `HasDbFunction().HasTranslation()`; EF internals reflection → `ToQueryString()`;
  SPA middleware removal (SpaServices deprecated .NET 7/removed 8+); NETSDK1152
  duplicate-appsettings publish break; NU1102/NU1107/NU1202 zero-tolerance after
  package moves; "move package majors atomically across the entire closure".
- **State save/readback contract**: `step-workflow-state.json` requires populated
  TOP-LEVEL `status`/`updatedAt`/`latestFullResponse` plus `lastExecutedStep`,
  `recommendedNextStep`, and a `stepResponses.steps[]` entry ("a nested step status
  alone is NOT enough"); `step-response-ledger.json` mirrors it; closeout blocked until
  `verify-step-artifacts.ps1 -Step 7 -Mode Output` returns OK.
- **Completion bar** lists explicit truths incl. "`LegacyCode/` was not modified" and a
  scripted blocked-message ("The Step 7 mutable workspace was created but the .NET
  upgrade did not complete successfully. Re-run Step 7 before Step 8.").

## Transcription uncertainties (prompt 07)

- The Required final report list shows a duplicated ordinal in the photo (test
  carry-forward note and build result both read as item "4."), consistent with markdown
  auto-numbering hiding a source-side duplication; preserved as photographed.
- Two references to the single-version invariant say "Execution order step 6" while the
  invariant actually lives under Execution order item 7 (clean build); preserved as-is —
  likely stale numbering after the step-0 reminder was inserted.
- Self-Check block wording reconstructed to the standard two-bullet form seen in prompts
  01-06 (photo wraps obscure some mid-line text).
- Long wrapped lines reconstructed; overlaps verified at 47-54, 100-107, 134-147,
  192-199, 241-249, and 267-299.
- File ends at line 305.

## Structural facts added by prompt 06

- **Step 6 = QA planning pack owner** (extracted from a previously overloaded Step 5):
  owns requirements doc, test plan, testing ownership matrix, characterization ladder,
  testcase catalog direction, testing strategy, regression plan, risk matrix, tool
  rationale, ADO CI/CD planning. Preceded by a **Legacy Unit Test Baseline pre-gate**
  (`legacy-unit-test-baseline.prompt.md`, a sub-prompt invoked from inside Step 6) that
  must report `step7ReadinessStatus: Ready` before quality design runs.
- **A QA prompt stack exists** under `.github/prompts/qaTestPrompts/` read in exact order:
  qa-core-master, qa-core-contract, qa-core-workflows, qa-plan-strategy,
  qa-legacy-characterization. Named reusable workflows: `[WORKFLOW] Modernization
  Solution Design`, `[WORKFLOW] Modern Build Planned QA Tests`.
- **owningStep routing table**: characterization → Step 7 (tests live in
  `LegacyCode/Characterization/Baseline/` — "the frozen baseline ships with the code it
  protects"); unit → Step 8 (`tests/backend/unit/`); integration/contract → Step 9
  (`tests/backend/contractApi|integrationBackend/`); browser-contract/e2e → Steps 10-16
  (`tests/frontend/`).
- **"Phase 2 has no derivation authority"**: the testcase catalog is the work order;
  Steps 7-17 implement entries verbatim, never analyze legacy code or add unplanned
  tests. Gap discovered mid-phase → stop → route back to Step 3/6 → refresh catalog →
  resume. Same drift-control philosophy as Squad-ik gates, applied to test planning.
- **Characterization = behavioral parity, not source-shape lock**: 7 backend behavior
  families (business rules, calculations, validation, API responses incl. every
  documented error path, DB side effects, legacy quirks "weird but load-bearing",
  permission behavior), each needing **three coordinated catalog entries**
  (characterization/unit/integration) unless a thin seam collapses to
  `coverageLevel: "single-layer"`. Frontend behavior is delegated to the UI Screenshot
  Parity lane (visual gates at Steps 11/12/15/18) — legacy screenshots are the contract.
- **C1-C9 source-shape lock rules** (structural floor): controller class presence, API
  action+verb, mutating-endpoint contract shape, EF entity shape, config seams,
  bootstrap/startup sequence, view/template markers (ng-* directives, @Scripts.Render),
  calculation-helper contracts, JS controller file presence (owningStep 10+, browser
  lane). Thin coverage marked `coverageLevel: "class-presence-only"` for QA Lane 5 audit.
- **8-rule per-service scenario derivation** reading Step 3 service-behavior-inventory
  fields (branchingParameters, throwGuards, nullCoalescingDefaults, ...): every public
  method ≥1 scenario; nullable returns get found+not-found; every throwing guard its own
  scenario; mode/flag branches one per mode; `??=` defaults two scenarios; collection
  methods empty-case; display decorators idempotency; delegation orchestrators one per
  path. Deterministic inventory→catalog mapping with rule-number traceability.
- **Five-tier API smoke safety model** (T1 unauthenticated reachability expecting
  401/403 → T2 CORS preflight → T3 authenticated invalid-body rejection with
  validation-gate file+line evidence that must precede the first mutation call → T4
  dry-run/pure-compute POST with grep-evidenced `mutatesState: false` → T5 ephemeral
  round-trip, **default OFF**, requires `dataSafety: ephemeral` in kit-params + explicit
  named user opt-in, forbidden against any data source whose loss would be noticed).
  T1 floor for every endpoint; real mutations belong to Step 12 integration with
  `page.route(...)` interception. 100% `apiSmokeCoverage` before Step 12.
- **Progress denominators contract**: qa-test-plan.json publishes `progressDenominators`
  (totalBackendFilesPlanned, totalApiEndpoints, totalRoutes, ..., plus extensions:
  totalErrorStates, totalExportSurfaces, totalRealtimeSurfaces, performanceBudgetRoutes,
  flakeBudgetPercent, dataFixtureCoverage, localesPlanned, routeStateParityFloor 90%);
  every Phase 2 percentage must be `done / total` citing real artifacts — "estimated
  percentages are forbidden" (appmod-phase-agent-contract rule 20).
- **Per-route behavior plan** (`per-route-behavior-plan.json`): per route
  `primaryDataCalls`, `interactiveElements` (with ownerStep 11/12/15+),
  `modalsAndBanners`, `placeholderDataPolicy: forbidden|allowedUntilStep<N>` — exists
  because "Steps 11 and 12 ship dead routes when they only have to prove 'the page
  renders' and not 'the page works'."
- **Testing accumulation plan Steps 7-17** with per-step targets (Step 8 >60% Library
  coverage growing to 80% by Step 9; Step 10 creates Playwright+Cucumber foundation;
  Step 17 = "S-TIER VERIFICATION GATE" 100% POM/Gherkin/aria/testid + >80% backend →
  Quality Score 95+ ready for Step 22), tracked in `test-accumulation-tracker.json`
  (updated by Steps 9-20, verified by Step 17; fields step17ReadinessScore,
  step22ProjectedScore).
- **Canonical planning script**: `qa-refresh-test-plan.ps1` is the authoritative
  generator for qa-test-plan/ownership-matrix/testcase-catalog + Step 8 layering-gate
  baselines (forbidden-references.json, slice-status.json) — "do not hand-author".
- **Frontend smoke lane doctrine**: one `ui-navigation-smoke.spec.ts` (~30-45s, read-only,
  no business transactions), shared helper `playwright-navigation-smoke-helper.js` under
  `.github/scripts/QA/`, exactly **one deterministic self-heal attempt** before reporting
  `Blocked`; smoke-evidence publisher is tracked infrastructure, not generated content.
- **Data-safety patterns**: Pattern A (live round-trip) for read-only GET/HEAD, Pattern B
  (interception) for mutating verbs; `ui-api-wiring-map.json` + spec template
  `_template/ui-api-wiring.spec.template.ts` drive mechanical derivation (Rule-Route-1).
- **Test root layout**: `tests/backend/{unit,contractApi,integrationBackend,smoke}`,
  `tests/frontend/{smoke,integrationFrontend,visualParity,e2e/{pages,journeys,
  accessibility,support}}`, `tests/modernization/characterization/{testcase,testResult}`;
  no step-named subfolders; one Markdown execution report per modernization step.
  Anti-Pact/perf-suite default: add only when compliance explicitly requires.
- Fixed closing line: `Ready for Step 7 Backend - Upgrade .NET: Yes or No` — and step
  names now confirmed: Step 7 "Backend - Upgrade .NET", Step 22 quality-score gate,
  Steps 9-20 update the tracker.

## Transcription uncertainties (prompt 06)

- Several headings/dashes render as garbled glyphs in the photos (e.g. "MANDATORY <?>
  Step 6 MUST assign a tier per endpoint"); transcribed as em dashes (`—`) — almost
  certainly UTF-8 em dashes displaying oddly at an angle.
- The owningStep routing table says characterization "Step 7 DEV authors and runs
  these", while the planning rule below it says "Step 7 QA uses these rows ... Step 7
  DEV does not run characterization tests" — tension preserved exactly as photographed.
- `test-accumulation-tracker.json` backendCoverage keys read `step6Target: 60`,
  `step7Target: 80`, `step15Target: 80` in the photo; the accumulation plan says Step 8
  >60% and Step 9 >80%, so these could plausibly be `step8Target`/`step9Target`/
  `step17Target` — transcribed as photographed and flagged.
- Line 525 says "Each step from 9-20 must UPDATE this tracker" while the exit criteria
  say scenarios are assigned to steps 7-17; preserved as-is.
- Execution order item 3 renders as "- 3." (stray list dash) in the photo; preserved.
- The "NO raw CSS or XPath selectors" bullet and Gherkin/data-testid/aria conventions
  appear detached after the bold Steps-7-17 paragraph (lines 378-391), likely displaced
  from the Playwright architecture section; transcribed in photographed order.
- Double-backtick identifier styling in the denominator sections preserved as shown.
- Long wrapped lines reconstructed; overlaps verified at 54-62, 92-114, 139-151,
  181-189, 222-245, 276-279, 315-321, 359-371, 411-422, 461-472, 516-522, 538-544.
- File ends at line 576.

## Structural facts added by prompt 05

- **Step 5 is the plan-closure gate** ("last major planning gate before implementation"):
  thirteen mandatory plan families — API Integration, Auth Integration, Test-Hook/Playwright,
  Data Fixture & Seeding, Performance Budget, Accessibility Audit, State Management,
  Realtime & Push, Logging & Telemetry, Environment Config, Cutover & Rollback,
  Test Isolation & Flake Budget, Localization — each recorded as a named plan array in
  `fusion-restructure/decisions.json`, each with the same drift-control rule: *"a Phase 2
  step that discovers a gap is a Step 5 planning gap and must route back here."*
- **Dominion confirmed as the acceptance-standard**: authoritative file is
  `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` (fail-fast if
  missing). Fusion is the default target outcome; MVC/Razor/AngularJS/Angular are "source
  patterns or temporary bridges, not the target-state goal by default."
- **Three-axis Step 5 readiness**: `ownershipDecisionStatus`
  (DecisionGrade|NeedsFollowUp|Blocked), `userInputGateStatus`
  (Cleared|Outstanding|Blocked), `executionReadinessStatus`
  (ReadyForQualityDesign|NotReadyForQualityDesign|UserInputRequired|BlockedMissingArtifact) —
  with `UserInputRequired` (artifacts fine, human gates open) explicitly distinguished from
  `BlockedMissingArtifact` (upstream artifacts missing/stale).
- **Named markdown reports are canonical, JSON is companion**: Step 5 must produce
  `Modernization-Solution-Design.md`, `Modernization-Execution-Contract.md`, and
  `Modernization-Phase-Assessment.md` (read downstream by exact path; the Phase-Assessment
  must state a Step 8 disposition of `Skip`|`ValidateOnly`|`Execute`) plus three DEV-owned
  control-plane JSONs under portal data. Anti-hallucination contract: every control-plane
  JSON needs non-empty `reportId` + `title` so the shared verifier can reject "a truncated
  or hallucinated fragment"; field contracts live under **`.github/contracts/schemas/`**
  (new kit directory).
- **Immutable-baseline contract**: after Step 3, AI may write under `LegacyCode/` ONLY in
  `LegacyCode/<LegacyTestProject>/Characterization/Baseline`; all other legacy-tree writes
  (and any generated JSON/reports/portal pages) are forbidden — same principle as
  Squad-ik's read-only LegacyApplication/ rule. Step 7 upgrade workspace root:
  `.modernization/OpXUtil/Backup/LegacyCode_NET<major>_Upgrade`.
- **Code Quality Standards section** Steps 7-18 enforce (and Step 24 Technical Review
  verifies — confirming the 24-step count): .NET (nullable everywhere, no
  .Result/.Wait/GetAwaiter, ctor DI, methods <50 lines / classes <500,
  IFusionLogger/IFusionHttpClientFactory/IFusionCache, [Authorize] on all controllers),
  Angular (standalone components only, signals, @if/@for/@switch, inject()), a11y
  (aria-label, data-testid on all testables, landmarks, full keyboard), tests (backend
  >80% on Library, POM class per route + Gherkin per journey,
  MethodName_Scenario_ExpectedResult).
- **Wrapper capability vocabulary**: each `requiresWrapperCapability` gets
  `ShipFromDayOne`|`ExtendAtStep15`|`ExtendAtStep17Preflight`|`IntentionallyDeferred`;
  wrappers fronting generic Fusion primitives need permissive `options:
  Record<string, unknown>`; form-field wrappers need `readOnly`+`disabled` with derived
  `controlDisabled`; every wrapper passes through `elementId`+`testId` so `<label for>`
  and Playwright selectors survive the swap.
- **Carry-forward disposition vocabulary**: every material Step 3/4 item must end as
  `ResolvedByPlanningDecision`|`UserInputGate`|`OwnedByModernizationQualityDesign`|
  `OwnedByLaterStep`|`Blocked` — "do not report ready by feel."
- **Auth plan machinery**: legacy `Web.config` is authoritative for auth detection
  (`authentication mode="Windows"`, `AppletSecurity.SarRoleMapping` auto-populate
  kit-params); Okta issuer + default client id are pinned kit-wide (values redacted here);
  connection-string runtime intake uses shorthand `OCPEnv` (default OpenShift/K8s split
  env vars) | `LocalIntegrated`/`OpEx` (local Windows integrated) | `OpX` (operator
  deferral, tracked-not-blocking) | concrete config-file ref/connection string.
- **`No QA` run mode**: the exact phrase `No QA` in a request skips the mapped QA workflow
  for the run (noted as operator-requested) — the control-plane JSONs exist specifically
  so `No QA` runs still work.
- **Fixed response spine**: 12 ordered sections, a closing `User Input Required` block
  (`Required now` / `Optional` / `Auto-detected from legacy config` / `Operator
  deferrals`), and one explicit final line `Ready for Modernization Quality Design: Yes
  or No`.
- Frontmatter gains an `edit` tool entry (first Discovery prompt that writes artifacts);
  **no `model:` pin despite Premium reasoning tier** — so pins are not simply
  tier-correlated.

## Redactions (prompt 05 — deliberate, not uncertainties)

- Line ~138: the real Okta tenant URL pinned as `oktaIssuerOverride` is replaced with
  `https://<company-tenant>.okta.com` and an inline `REDACTED` comment.
- Line ~139: the concrete default Okta client ID (`0oa1…`) is replaced with
  `<default-okta-client-id>` and an inline `REDACTED` comment.
- Rationale: standing repo policy — no real Okta tenant hostnames or IDs in this repo.
  The work-side original pins the real values; restore them there, never here.

## Transcription uncertainties (prompt 05)

- Frontmatter tools list ends with a bare `- edit` (prompt 02 used `edit/editFiles`);
  transcribed as photographed.
- Double-backtick identifier styling appears from the Data Fixture section onward (mixed
  with single backticks earlier); preserved as shown.
- The `wrapperCapabilityPlan[]` bullet shows the decisions.json path without backticks,
  unlike sibling bullets; preserved as shown.
- "Step 5 closes from its own planning artifacts…" joined to the Dev-work bullet based on
  indentation in the photo.
- Long wrapped lines reconstructed from wrap positions; wording verified across photo
  overlaps at lines 14-59, 57-62, 98-108, 143-150, 189-199, and 236-246.
- File ends ~line 288 in the editor.

## Structural facts added by prompt 04

- **This is the Ignition scorecard step** (maps to Squad-ik's steps 03/19 scorecard
  machinery): a hybrid review with a deterministic layer and an AI-judgment layer, scored
  by closure formula `100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)`.
- **"Dominion"** is the compliance/acceptance-criteria framework name ("Dominion
  compliance evidence", "Dominion criteria", "Dominion requirements").
- **Deterministic pattern catalog with stable IDs**: A1.x CRITICAL (-10 each, 5 patterns:
  hardcoded creds, SQL injection, tokens in localStorage, unsanitized innerHTML, sensitive
  data in logs), A2.x HIGH (-5 each, 18 patterns incl. FormsAuthentication, .Result/.Wait
  blocking, new HttpClient(), Session state, jQuery-in-Angular), A3.x MEDIUM (-2 each,
  13 patterns incl. missing OnPush, subscribe-without-unsubscribe, UseSwagger without dev
  check, verb-based URLs). Each row is Pattern + "What It Looks Like" example.
- **AI-judgment criteria with IDs**: B1 SOLID (5), B2 Security (4), B3 12-Factor (5),
  B4 API design (2, controllers only), B5 Angular (3, .ts/.html only) — plus file-level
  thresholds (class >500 lines HIGH, ctor >7 params HIGH, interface >15 methods HIGH)
  and an explicit "NOT violations" skip-list (DTO `new`, `static readonly`, IMemoryCache,
  `new` in tests).
- **Per-criterion scoring is data-driven**: criteria load from a versioned
  `acceptance-criteria-catalog.json`, each criterion gets `criterionId`/`baselineScore`
  (0..100)/`observedEvidencePaths[]`/`findingIdsContributing[]`/`confidence` in
  `baseline-review.json`; Step 5 plans remediation order from it and **Step 17 computes
  per-criterion `improvementDelta`** (baseline vs modern) — same before/after delta idea
  as Squad-ik's delta-report. Explicitly framework-generic (MVC, Razor Pages, Web Forms,
  Blazor, AngularJS, Angular, React, Vue, server-rendered HTML).
- **AI-judgment artifact with guardrails**: design-level criteria the scanner can't decide
  (SOLID SRP/OCP/LSP/ISP, stateless posture) surface as `UNKNOWN` unless an evidence-backed
  `judgments[]` artifact (`baseline-criterion-judgments.json`; Final phase uses
  `final-criterion-judgments.json`) resolves them. Guardrails: status must be
  PASS/FAIL/PARTIAL with >=1 cited `path:line - reason`; inferred-without-evidence is
  disallowed; deterministic rows are never overridden ("hard findings always outrank AI
  reasoning"); undecidable -> `PARTIAL` with reason, never a guessed clean result.
- **Step 4 three-axis status model**: `criterionCoverageStatus`
  (DecisionGrade|BroadButIncomplete|Blocked), `blockingGapStatus`
  (None|Present|BlockedByMissingEvidence), `planningInputStatus`
  (ReadyForStep5|NeedsFollowUp|Blocked). Step 4 is "incomplete" until findings are ranked
  into exact Step 5 planning inputs — evidence alone isn't done.
- **Cross-step courtesy rule**: `rename-verification.json` (Step 2-owned) unresolved items
  do NOT hard-block Step 4 when Step 2 is recorded complete in step-workflow-state.json —
  treated as informational. Steps don't re-litigate other steps' gates.
- **Model tier**: Balanced (medium thinking), 10-20 min; **no `model:` pin in this
  prompt's frontmatter** (unlike prompt 03's Opus pin) — pins appear only on the heavy
  reasoning steps.
- **Chunked review protocol**: process manifest files in chunks of 10-15, save progress
  after each chunk, require 100% file coverage verified by
  `P2-Modernize/verify-coverage.ps1` before `04-P1-generate-report.ps1 -Phase Baseline`
  refreshes `BASELINE-COMPLIANCE-REPORT.json` (portal). Fixed completion phrase:
  "BASELINE REVIEW COMPLETE".

## Transcription uncertainties (prompt 04)

- Two artifact roots appear for the same file: header block says **Output:**
  `.modernization/ignition-artifacts/discovery/baseline-review.json`, while the closure
  contract saves chunks to `.modernization/artifacts/reviews/baseline-review.json` (and
  the judgment artifact lives under `.modernization/artifacts/reviews/`). Transcribed
  exactly as photographed — possibly a source inconsistency or an intentional
  staging-vs-final split.
- The Per-Criterion Baseline Score section visibly uses **double backticks** around
  identifiers (e.g. ``criterionId``) unlike single backticks elsewhere; preserved as
  shown.
- `A2.6 async void` example shows a trailing space inside the backticks (`async void `);
  preserved.
- Long wrapped lines (status model, artifact contract, AI-judgment guardrails, closing
  bullet) reconstructed from wrap positions; wording verified across photo overlaps at
  lines 55-62, 112-118, and 157-175.
- File ends ~line 207 with trailing blank lines to 211 in the editor.

## Transcription uncertainties (prompt 03)

- Frontmatter shows only `description`, `agent`, `model`, `tools` — no `name:`/
  `argument-hint:` lines visible (unlike prompts 01-02). A "Configure Tools…" UI
  affordance appears between `model:` and `tools:`; transcribed as photographed.
- The Step Artifact Self-Check header may carry the "(QA-independent; works on `No QA`
  runs)" parenthetical seen in prompts 01-02; not legible in the photo, so omitted here.
- Source-internal inconsistency preserved as-is: the Required Artifacts table has **10**
  rows, but Required Response Sections / Output Normalization Rules say "each of the 7
  artifacts" / "list all 7 artifacts every run" (likely the A1-A7 schema artifacts).
  > **RESOLVED by `Step3-Artifact-Schema-Contract.md`.** The schema contract defines exactly
  > **seven** artifacts (`## Artifact 1` … `## Artifact 7`), so the "7 artifacts" prose is
  > correct and refers to the schema-contract artifacts. The 10-row Required Artifacts table
  > is a different, larger list (the schema contract covers 3 standalone JSON files plus 4
  > sections embedded inside `inventory.json` and `legacy-system-analysis-report.json`).
  > Not a defect — two different groupings of the same output.
- Line 88's `OPX_ENABLE_QA_PORTAL_REFRESH=1;` prefix transcribed exactly as shown
  (env-assignment + semicolon before a `powershell` invocation).
- Long wrapped lines (Hard Stops, capture requirements, enrichment rules, visual
  contract) reconstructed from wrap positions; wording verified across photo overlaps
  at lines 53-62, 101-109, 148-156, 203-208, and 251-260.
- File ends ~line 305 with trailing blank lines to 309 in the editor.

## Transcription uncertainties (prompt 02)

- Frontmatter `name:` line hidden behind the wrapped description in the photo;
  reconstructed from the visible filename.
- Line 6 in the tools list shows a "Configure Tools…" UI affordance, not file content.
- `npm run install` (Required Edits #6) transcribed as shown — possibly `npm install`
  in source; flagged rather than corrected.

## Transcription uncertainties (prompt 01)

- Frontmatter opening `---` not visible in photo (closing `---` at line 11 is); standard
  prompt-file frontmatter assumed.
- Lines 54-55 both appear in the source with near-duplicate wording (remove stale
  `.vs`/`obj` vs `.vs`/`bin`/`obj` "when the old build outputs are poisoning the legacy
  import graph") — transcribed as-is; possibly an intentional escalation, possibly a
  source duplication.
- Minor wrapped-line reconstruction in the Step Artifact Self-Check block (lines 22-24).

## Transcription uncertainties (`verify-gate-integrity.ps1`)

- Complete at **86 content lines** (gutter 87), from 2 photos with overlap at
  lines 41-67. All thirteen photographed anchors match (29 `[CmdletBinding()]`,
  37 `$ErrorActionPreference`, 39 the root default, 43 `$selfTests`, 50 the
  zero-self-tests guard, 55 `$results`, 56 the loop, 61 `$psArgs`, 67
  `$results.Add`, 75 `$failed`, 78 the success branch, 86 the close).
- The two `Select-String -Pattern` literals are `'\[PASS\]'` and `'\[FAIL\]'`
  — regex-escaped brackets inside single-quoted PowerShell strings, transcribed
  as photographed. They are the load-bearing contract with every `Assert-That`.
- **Not executed** — `pwsh` unavailable.

## Transcription uncertainties (`selftest-scaffold-debt.ps1`)

- **PARTIAL — 1 of the 3 photos in the batch was read.** Source lines **1-65**;
  the file continues (the `Invoke-DebtCase` `try` block is cut before its
  `finally`). Delimited trailing note in the committed copy. Not runnable.
- All thirteen photographed anchors in range match (14 `[CmdletBinding()]`, 17
  `$ErrorActionPreference`, 18 `$scanner`, 21 `$script:failures`, 23
  `Assert-That`, 34 the harness comment, 36 `Invoke-DebtCase`, 43 `$root`, 53
  `$reg`, 57 `$psArgs`, 60 the invocation, 65 the `try` close).
- **Not executed** — `pwsh` unavailable and the file is incomplete.

## Transcription uncertainties (`selftest-parity-gate.ps1`)

- **PARTIAL — 1 of the 5 photos in the batch was read.** Source lines **1-66**;
  the file continues (the `Invoke-ScanCase` param block is cut mid-list). The
  committed copy carries a delimited trailing note. Not runnable.
- All eleven photographed anchors in range match (35 `[CmdletBinding()]`, 38
  `$ErrorActionPreference`, 40 `$scanner`, 41 `$verifier`, 44 `$script:failures`,
  46 `Assert-That`, 57 the harness comment, 61 `Invoke-ScanCase`, 63/66 its
  params).
- Line 41's `$verifier` is a chained `Join-Path … | Join-Path -ChildPath …`
  expression resolving `$PSScriptRoot/../shared/verify-step-artifacts.ps1`;
  transcribed as photographed. It is the first direct evidence of a file inside
  `.github/scripts/shared/`.
- **Not executed** — `pwsh` unavailable and the file is incomplete.

## Transcription uncertainties (`selftest-functional-parity-ledger.ps1`)

- **PARTIAL, in two fragments with a known interior gap.** `…PARTIAL.ps1` holds
  source lines **1-121**; `…TAIL-284-341.ps1` holds **284-341**. **Lines 122-283
  are not transcribed.** The source file is **340 content lines**. The tail was
  deliberately kept as a separate file rather than spliced in, so nothing in the
  repository misrepresents itself as contiguous. Neither is runnable.
- In the tail fragment the **case-block boundaries** were read directly from the
  photo; individual `Assert-That` line positions within each block may be off by
  one. The assertions themselves and their order are as photographed.
- All fifteen photographed anchors in the transcribed range match (34
  `[CmdletBinding()]`, 37 `$ErrorActionPreference`, 44 `Assert-That`, 57
  `Invoke-LedgerCase`, 62 `$BackendScanJson`, 73 `$root`, 81 the fixture writes,
  87 `$routeLines`, 96 `try {`, 101 the scanner invocation, 105 `$scanOut`, 114
  the fixture-helpers banner, 118/121 the `$oldSchemaLedger` start).
- Line 99's comment says *"Use the current shell (pwsh) directly since the
  scanner is PS7-compatible"* while line 101 invokes `powershell` (5.1). That
  inconsistency is transcribed as photographed and is worth checking against the
  real file — the comment and the code disagree about which shell runs the gate.
- **Not executed** — `pwsh` unavailable and the file is incomplete.

## Transcription uncertainties (`selftest-backend-parity.ps1`)

- Complete at 170 content lines (gutter 171). All fifteen photographed anchors
  match (25 `[CmdletBinding()]`, 34 `Assert-That`, 48 `Invoke-BackendCase`, 83 the
  banner, 86/104/113 the three fixtures, 130/136/141/147/158 the test cases, 162
  the summary, 170 the close).
- The three C# fixtures are PowerShell here-strings (`@'` … `'@`); their contents
  are transcribed verbatim including the `[Authorize(Policy = "RequireAdministratorRole")]`
  attribute, which is fixture data rather than real configuration.
- Line 141's `$reg` JSON is one long single line that soft-wraps across three
  editor rows in the photo; reproduced unwrapped.
- **Not executed** — `pwsh` unavailable, and the self-test shells `powershell`
  (Windows PowerShell 5.1) explicitly.

## Transcription uncertainties (`scan-ui-parity-gaps.ps1`)

- **PARTIAL — and now with a known interior gap.** Source lines **1-454** are
  transcribed. **Lines 455-831 are missing.** A separate photographed set covers
  roughly **832 to the end** and is also not transcribed. The committed copy's
  trailing note states this. Do not execute.
- The file is ~950+ lines, making it by far the largest script transcribed. It
  needs two more passes: the 455-831 range, then the 832-end tail. Not photographed: the rest of the `Scan-File` body, the
  legacy↔modern matcher, gap emission, the summary and the exit. Deliberately
  incomplete; must not be run.
- The 291-394 extension needed a blank line inserted at **291** (before
  `Extract-ColorToken`) to align; after that all fourteen anchors in that range
  match (292, 313, 325, 331, 334, 348, 369, 390, 393, 394 among them).
- Line 335's attribute-harvest regex and line 392's `$blockPattern` are the least
  legible tokens in this range and both carry embedded quote-escaping; re-check
  them against the real file before acting on anything that depends on their
  exact form.
- Fifteen photographed anchors match the written file (53 `param(`, 75
  `$ErrorActionPreference`, 82 the root resolution, 114 `$script:AppComponentPrefix`,
  129 the registry banner, 148 `$inertControlAllowlist`, 155 the registry path,
  177 `Normalize-Label`, 189 `Extract-IconClasses`, 204 `$SemanticIconMap`, 224
  `$IconAliasMap`, 241 `Resolve-IconTokens`, 261 the dimension-registry banner,
  282 `$BootstrapColorMap`, 290 its close).
- The long FA-modifier exclusion regex on line 193 is the least legible token in
  the batch; the `Normalize-Label` replacements on 179-185 are next. Both findings
  that depend on them (the modifier list, the `{{...}}` stripping) should be
  re-checked against the real file.
- `FileLog` / `filelog-command-button` appear as worked examples in comments;
  they are app and component names, not credentials or hosts, and were left as
  photographed.
- **Not executed** — `pwsh` unavailable, and the file is incomplete regardless.

## Transcription uncertainties (`scan-scaffold-debt.ps1`)

- One line short on the first pass (220 vs 221); resolved by counting the header
  against the photo rather than guessing — a blank line at **6**, before
  `.DESCRIPTION`, matching the convention in the sibling scripts. All twelve
  photographed anchors then match (7 `.DESCRIPTION`, 41 `param(`, 93 the first
  `$MarkerRules` entry, 106 the array close, 123 `Test-MarkerAccepted`, 135
  `$files`, 142 `$lines`, 186 `$tracked`, 190 `generatedUtc`, 208 the console
  block, 221 the exit).
- The nine marker regexes on lines 93-105 are the least legible tokens in the
  file. Line 105's `ScaffoldPlaceholder` pattern contains PowerShell's doubled
  single-quote escaping (`["''][^"'']*`), transcribed as photographed; the live
  regex is `class\s*=\s*["'][^"']*\bscaffold-placeholder\b`.
- **Not executed** — `pwsh` unavailable.

## Transcription uncertainties (`scan-functional-parity-ledger.ps1`)

- **RESOLVED — the file is now complete** (376 lines, from 7 photos total). The
  `.PARTIAL.ps1` copy has been replaced. Ten further anchors in the second half
  match the photographed gutters (283 `default`, 285 `$blockingGaps.Add`, 300
  `$deduped`, 309 `$majorGaps`, 315 `$result`, 338 `note`, 341 the JSON write,
  346 the console block, 366 the BLOCKED branch, 376 `exit 0`).
- Seventeen photographed gutter anchors were checked against the written file and
  all match — 41 `[CmdletBinding()]`, 42 `param(`, 47 `$ErrorActionPreference`,
  56 `$discoveryRoot`, 66 the BLOCKED guard, 71 `$ledgerDoc`, 97
  `function Test-IsWaived`, 115 `$missingMutCount`, 134
  `$placeholderActionCount`, 151 `$modernRoutePaths`, 167
  `$modernMutationMethods`, 193 `$allEffectClasses`, 199 `$blockingGaps`, 201 the
  entry loop, 220 `$isImplemented = switch`, 276 `$reason = switch`, 282
  `'open-dialog'`.
- Nothing required redaction.
- The regex on line 157 (`"(?i)path\s*:\s*['\"](?<p>[^'\"]+)['\"]"`) uses a
  double-quoted PowerShell string with doubled quotes inside; it was read at
  magnification but is the least certain token in the file. The line-232 route
  match and the line-235 slug normalisation are next least certain. The findings
  that turn on the `\]` vs `\b` verb-attribute difference (lines 176/179) were
  cross-checked against `scan-backend-parity.ps1` line 137, which uses the other
  form — that contrast is the load-bearing observation and both were re-read.
- **Not executed.** `pwsh` is unavailable here, and this file is incomplete
  regardless.

## Transcription uncertainties (`scripts/parity/scan-backend-parity.ps1`)

- **A one-line discrepancy was resolved by magnification, not by guessing.** The
  first pass produced 240 lines against a 241-line gutter, with every anchor from
  `param(` onward off by one. Cropping the header region settled it: there is a
  blank line at **36**, between the `GENERIC:` paragraph and `.OUTPUTS`. After
  inserting it, all eight photographed anchors match exactly — 37 `.OUTPUTS`,
  48 `param(`, 62 `$ErrorActionPreference`, 119 `$mutationVerbs`,
  121 `function Get-Endpoints`, 161 the legacy-scan `Write-Host`, 200 `$result`,
  241 the `exit` line.
- Nothing required redaction.
- The regexes are again the least legible tokens, particularly the method-name
  pattern on line 146 (`'(?im)(?:public|internal|protected)\s+(?:async\s+)?[A-Za-z0-9_<>,\[\]\.\s]+?\s+([A-Za-z0-9_]+)\s*\('`)
  and the class pattern on line 133. The findings that depend on them — the
  600-character forward window, the class-per-file assumption — should be
  re-checked against the real file before being acted on.
- **Not executed.** `pwsh` is unavailable here and this script has no `.sh`
  counterpart, so this is a code reading.

## Transcription uncertainties (`scripts/parity/scan-api-dto-coverage.ps1`)

- Nothing required redaction. `FileLog` / `FileLogView` / `FileLogResponse` are
  domain type names used as worked examples in the header comment, not
  credentials, hosts or tenant identifiers.
- Line count verified against the gutter: 222 content lines (gutter 223). Photo
  coverage overlapped at 62-67, 121-125 and 177-188, so every function boundary
  was read directly.
- Line 200 (`note = '...'`) is a single long string that soft-wraps across two
  editor rows in the photo; transcribed as one line, which is what makes the
  total land on 222.
- The regexes were read at magnification but are the least legible tokens in the
  file — particularly `'(?im)^\s*public\s+[\w<>\[\]\?]+\s+(\w+)\s*\{'` and
  `'(?i)\brecord\s+\w+\s*\(([^)]+)\)'`. The findings that depend on them
  (missed generics with commas, missed `required` modifier, missed field
  declarations) should be re-checked against the real file before being acted on.
- **Not executed.** `pwsh` is unavailable in this environment and this script has
  no `.sh` counterpart, so every claim here is from reading, not from running it.

## Transcription uncertainties (client root configs)

- **No redaction was required in this batch.** The client `AppInfo.xml` uses
  `{TeamEmail}`-style tokens throughout, and neither nginx config contains a
  hostname. The API's `AppInfo.xml` redactions (`serviceAccountDomain`,
  `serviceAccountPasswordSource`) have no counterpart here — a static site has no
  service account. A full sweep across `_ignition-import/` is clean.
- Line counts verified against the photo gutters: `AppInfo.xml` 77 (gutter 78),
  `default.conf` 23, `nginx.conf` 23, `eslint.config.js` 73 (74),
  `package.json` 58 (59), `esproj` 11, `tsconfig.json` 34 (35),
  `tsconfig.app.json` 15 (16), `tsconfig.spec.json` 14 (15).
- `AppInfo.xml` and `web.config` validate as XML; `package.json`,
  `tsconfig*.json` parse as JSON with comments stripped mentally (the `tsconfig`
  files open with a `/* … */` banner, which is JSONC and is reproduced as
  photographed). `eslint.config.js` parses under `node --check`.
- `AppInfo.xml`'s twelve `<environment>` blocks are highly repetitive; the four
  with a `<webSite>`/`<healthCheckUrl>` child (1-DEVL, 2-UAT, 4-STAGING,
  6-PRODUCTION) were read individually and the rest reproduced mechanically.
  Photo coverage overlapped at lines 36-67, so every block boundary was read.
- Indentation for `AppInfo.xml` is 2-space, matched to the already-transcribed
  `Starter.Web.Api/AppInfo.xml` rather than measured from the photo.
- The `eslint.config.js` comment on line 8 is long and soft-wraps in the photo;
  transcribed as one line.

## Transcription uncertainties (`angular.json`)

- **An off-by-one between two photos was resolved, not guessed.** Photos 1 and 2
  overlap on the `prd` block and appeared to disagree by one line on where
  `"fileReplacements"` starts. Settled three ways: photo 1's direct gutter
  reading, back-projecting the row slope on a magnified crop of photo 2, and
  reconstructing the block structurally. All three give **line 56**. The written
  file was then checked against fourteen photographed gutter anchors (44, 45, 56,
  62, 73, 129, 156, 158, 165, 167, 213, 217, 225, 234) and every one matches.
- The five configuration blocks are near-identical, so they were reproduced from
  a template after reading each one's distinguishing lines (the `with:` target,
  and `dvl`'s extra `sourceMap`). Photo coverage overlapped at 51-66, 106-112 and
  151-167, so every block boundary was read directly.
- **`"$schema"` is transcribed as `"./node_modules/@angular/cli/lib/config/schema.json"`.**
  The photo is consistent with either `./` or `../` at that resolution; `./` is
  the Angular CLI default for a project at the workspace root, which this is
  (`"root": ""`). Flagged rather than treated as certain.
- The file has **no trailing newline** — gutter ends at 234 with `}` on it, with
  clear screen below, matching the `test-datastore` files.
- File validates under `json.loads`.

## Transcription uncertainties (client-root `.npmrc`, `.dockerignore`)

- **Redaction applied.** The Sonatype host appears twice in the root `.npmrc`;
  same `<SONATYPE-NPM-HOST>` placeholder as `tools.mjs` and `tmpt/.npmrc`. The
  repository paths are kept.
- The root `.npmrc` has **no** `; begin auth token` / `; end auth token` markers
  and carries no credential — that is the difference from the `tmpt/` copy, and
  it is what supports reading `tmpt/` as a build-time template.
- **Whether the root `.npmrc` is committed or merely present on disk cannot be
  determined from a photo.** The finding downgrade assumes it is tracked; if it
  is gitignored, the original ENOENT reasoning applies again to fresh clones.
  A `git check-ignore .npmrc` in the source repo settles it.
- The `.dockerignore` photo was taken sideways; line order was read from the
  gutter and is unambiguous. 16 content lines, gutter 17.
- **`default.conf` is inferred from a path tooltip**, not from a file listing —
  `…\src\Starter.Web.Client\default.conf` appeared in the corner of the
  `.npmrc` screenshot. Its existence is solid; its contents are entirely unknown,
  and every statement about the container path's security headers is therefore a
  question rather than a finding.

## Transcription uncertainties (`tmpt/.npmrc`)

- **Redaction applied.** The Sonatype host appears twice and is replaced with
  `<SONATYPE-NPM-HOST>`, the same placeholder used in `tools.mjs`. The two
  repository paths (`/repository/npm-org/`, `/repository/fusion-npm/`) are kept —
  they are structural, and the second is the load-bearing `@fusion:` scope route.
- **No credential was present to redact.** Lines 1 and 7 read `; begin auth token`
  and `; end auth token`, and the five lines between them are plain config. Either
  the token region is populated elsewhere or it was cleared before the photo; the
  file as photographed contains no secret.
- **The folder name is read as `tmpt`** from the breadcrumb
  (`src > Starter.Web.Client > tmpt > .npmrc`). `tmpl` is a plausible alternative
  at this resolution and would fit the template reading better. Recorded as
  photographed; worth confirming, because the ENOENT finding depends on this file
  not being at the client root.
- Whether a second `.npmrc` exists at `Starter.Web.Client/` root is **unknown** —
  dotfiles did not appear in the file-tree photo. A `ls -a` of that directory, or
  the client `.gitignore`, would settle both this and the `cert.pem` /
  `cert.key` question left open by `pre-start.mjs`.
- Line count verified against the gutter: 7 content lines.

## Transcription uncertainties (env configs, `src/` root, `web.config`)

- **Redactions applied.** `fusion.config.dvl.ts`: the live `clientId` and
  `issuer`, the two `starterkit…` callback hosts, and the four commented-out
  identifiers (a second tenant and a second internal host) → `<OKTA_CLIENT_ID_DVL>`,
  `<OKTA_ISSUER_URL_DVL>`, `<STARTER-DVL-HOST>`, `<OKTA_ISSUER_URL_CORP>`,
  `<INTERNAL-APP-HOST>`. `web.config`: three corporate domains in the CSP
  `connect-src` → `*.REDACTED-CORP-DOMAIN-{1,2,3}.invalid`. `*.gstatic.com` is a
  public Google host and was kept.
- **Placeholder style differs in `web.config` deliberately.** The `<…>` form used
  elsewhere is invalid inside an XML attribute value and broke well-formedness;
  the bracket-free form keeps the file parseable. Verified with a real XML parse.
- **The CSP `sha256-…` hash is NOT redacted.** It is a hash of the public inline
  theme script in `index.html`, not a secret, and it is load-bearing evidence for
  the finding that editing that script breaks CSP.
- A sweep for Okta client-ID patterns, both Okta tenants, all three corporate
  domains, the OpenShift host fragments, and `integrator-…` across
  `_ignition-import/` returns clean.
- `web.config` is highly repetitive (seven identical eleven-line `no-store`
  `<location>` blocks). Photo coverage overlapped at lines 51-67 and 90-115, so
  every block boundary was read at least once; the blocks were then reproduced
  mechanically. Line 156 (`</configuration>`) matches the gutter.
- `fusion.config.dvl.ts` line 51 is `isDebug: true,` **with a trailing comma**
  before the closing brace — as photographed, and unlike `fusion.config.base.ts`.
- `routes.config.ts` lines 19 and 28 are long single-line `loadComponent` arrow
  functions; their tails render alongside the next gutter number.
- Line counts verified against the gutters: `fusion.config.dvl.ts` 52 (gutter 53),
  `prd` 10 (11), `qa`/`uat`/`fusion.config.ts` 9 (10), `routes.config.ts` 50 (51),
  `types.ts` 9 (10), `index.html` 35 (36), `main.ts` 6 (7), `styles.scss` 8 (9),
  `web.config` 156 (157).
- **Still outstanding, highest value first:** `npm-safe-package-installs.mjs`
  (decides whether the Kendo licence patch is automated), `package.json`,
  `angular.json`, `.npmrc`, `.gitignore`, `clean.mjs`, `install.mjs`,
  `npm-clean.mjs`, and the three page `.spec.ts` files.

## Transcription uncertainties (`src/app/` root)

- **Two redactions applied to `fusion.config.base.ts`**: `clientId` and `issuer`
  are replaced with `<OKTA_CLIENT_ID>` and `<OKTA_ISSUER_URL>`. The
  `https://localhost:5001/login/callback` and `/logout/callback` URLs are
  localhost and were kept verbatim; the scope list, `pkce`, `devMode`,
  `signInAttempts`, `theme` and `secure` are not sensitive and are as
  photographed. A regex sweep for Okta client-ID and tenant patterns across
  `_ignition-import/` and across this branch's history returns clean.
- `app.config.ts` lines 1-4 and 25/30 are long single lines whose tails render
  alongside the following gutter number. Each was resolved by row slope; the
  bodies are complete statements, which cross-checks the mapping.
- `import {} from '@fusion/ngx-fusion-auth-oauth-okta';` on line 2 of
  `fusion.config.base.ts` has genuinely **empty braces** — transcribed exactly.
  It is a module-augmentation import, not a typo or a partial read.
- Line counts verified against the gutters: `app.component.html` 7 (gutter 8),
  `app.component.ts` 11 (12), `app.component.spec.ts` 11 (12), `app.config.ts`
  50 (51), `fusion.config.base.ts` 38 (39).
- **Still outstanding and now highest priority:** `fusion.config.prd.ts` — it
  decides whether `devMode: true` / `isDebug: true` reach production. Then
  `routes.config.ts`, `fusion.config.ts`, `types.ts`, and `src/styles.scss`.

## Transcription uncertainties (`services/public-text`)

- `public-text.service.ts` line 13 is a long single line whose tail
  (`?? { message: '' };`) renders alongside gutter 14 because of the photo's tilt.
  Lines 14 and 15 are the two closing braces, at different indents — resolved by
  their x-offsets, not by the y-position of the tail.
- Line count verified against the gutter: 15 content lines, closing brace on 15.
- No spec file was mentioned or photographed for this folder. Whether
  `public-text/` has no spec, or one that simply was not sent, is unknown.

## Transcription uncertainties (`services/my-entities`)

- **Filename needs confirming.** The spec was reported as
  `my-entities.services.spec.ts` — **"services" plural** — beside
  `my-entities.service.ts` singular. Recorded under the name as given, but this
  may be a typo in the message rather than in the repo. If the repo really does
  spell it plural it is worth fixing: it still matches Angular's `**/*.spec.ts`
  glob so nothing breaks, but it will not be found by anyone searching for the
  service's own name.
- The spec is recorded as a **zero-byte file**, per "there is a blank file called
  …". Its emptiness is the finding; there was no photo of it to verify against.
- `my-entities.service.ts` lines 12, 18, and 21 are long single lines whose tails
  render alongside the following gutter number because of the photo's tilt. Each
  was resolved by measuring the row slope; lines 13, 19, and 22 are `}`,
  `id = entity.id;`, and `}` respectively.
- `{ actionName: actionName }` is transcribed longhand exactly as photographed,
  not normalised to the `{ actionName }` shorthand.
- Line count verified against the gutter: 26 content lines (gutter 27).

## Transcription uncertainties (`pages/test-datastore`)
- `test-datastore.component.ts` line 4 is a single ~190-character import. The
  photo's tilt places its tail visually alongside line 5; confirmed as one line by
  measuring the row slope and by the fact that line 5 is a complete statement.
- The `imports:` array order and its trailing comma were verified by magnifying
  the region — both diverge from the other three components, and both are as
  photographed.
- `test-datastore.component.ts` also has **no trailing newline** (gutter ends at
  74 with `}` on it), matching the `.html` in the same folder.

- **The missing trailing newline was verified, not assumed.** The editor gutter
  ends at line 54 with content on it and no line 55, which is how VS Code renders
  a file with no final newline. Every other starter file shows a trailing empty
  gutter row. The committed copy reproduces this exactly.
- Gutter-to-line alignment for lines 8-15 was checked by magnifying the region,
  because the photo's tilt made the mapping ambiguous at a glance. Sequence
  confirmed: 10 `<section class="panel">`, 11 `<header>`, 12 `<h2>`.
- `{{ displayedText }}`, `[disabled]="isLoading"`, `[disabled]="isSaving"`, and
  `[(ngModel)]="payloadValue"` are all transcribed **without** call parentheses,
  as photographed. That is the basis for the "plain fields, not signals" finding,
  so it is worth re-checking against `test-datastore.component.ts` when that
  arrives — if the `.ts` declares them as signals, the template is buggy rather
  than merely inconsistent.
- Line counts verified against the gutters: `.html` 54 (no trailing newline),
  `.scss` 14 (gutter 15).
- **Still outstanding:** `test-datastore.component.ts` and `.spec.ts`.

## Transcription uncertainties (`pages/home`, `pages/my-entity`)

- **One line was resolved by re-cropping, not by inference.** Two photos of
  `my-entity.component.ts` appeared to disagree on which control carries
  `Validators.required`. Magnifying the overlap settles it: **`name`** has it,
  `description` does not. Recording the method because the first reading of the
  second photo was wrong.
- `fusion-button`'s conflicting attribute sets (`appearance`/`color` vs `theme`)
  were verified by magnifying the `my-entity` line separately. Both are as
  photographed; this is a source inconsistency, not a transcription artefact.
- `home.component.html` uses Prettier's whitespace-sensitive HTML wrapping —
  `<fusion-grid-cell` … `><p>` at lines 56-57 and `</p></fusion-grid-cell` … `>`
  at lines 71-72. Reproduced exactly, including the dangling `>` lines, because
  reflowing them would change rendered whitespace.
- The lorem-ipsum paragraph text was transcribed literally at the photographed
  line breaks. It is filler and carries no meaning, but the line count depends on
  it, so the breaks are preserved.
- Indentation transcribed as 4 spaces throughout, measured from the photo pixel
  offsets (≈4 character widths per level) and consistent with the rest of the
  starter. A 2-space source rendered at tab width 4 would look identical; not
  independently verifiable from an image.
- Line counts verified against the photo gutters: `home.component.html` 74
  (gutter 75), `home.component.ts` 28 (29), `home.component.scss` 4 (5),
  `my-entity.component.html` 43 (44), `my-entity.component.ts` 69 (70).
- **Still outstanding in these folders:** `my-entity.component.scss`, and the
  `.spec.ts` for all three pages — the spec files matter, because the kit's
  characterization-test rules (D-001) will need to know what the starter's test
  conventions actually are.

## Transcription uncertainties (`Starter.Web.Client/src/app/`)

- The directory tree was photographed sideways (portrait shot of a landscape
  screen). Folder nesting was read from the indent guides; `pages/` and
  `services/` sit at the same level under `app/`, and `common-components`,
  `home`, `my-entity`, `test-datastore` are all children of `pages/`. The user
  confirmed the `pages/common-components` placement in the message text.
- `test-datastore/` and `services/` were collapsed in the photo, so their contents
  are unknown. `assets \ icons` is rendered with VS Code's compacted-single-child
  notation, i.e. `assets/` contains only `icons/`.
- `common-components.component.ts` line 16 is the class declaration and line 17 is
  the trailing blank; the photo's tilt makes the 16/17 boundary ambiguous at the
  left margin, but the 17-row gutter matches every other file's trailing-newline
  pattern.
- Indentation transcribed as 4 spaces to match the rest of the starter. The photo
  is consistent with 4 but a 2-space source rendered at a tab width of 4 would
  look the same; not independently verifiable from an image.
- The `@Component` `imports:` array is one long line in the source, soft-wrapped
  in the photo with no continuation character.

## Transcription uncertainties (`Starter.Web.Client/scripts/`)

- **Redaction applied.** `tools.mjs` line 91 tests `.npmrc` for a literal internal
  Sonatype registry hostname. The committed copy substitutes
  `<SONATYPE-NPM-HOST>`. This is the only redaction in the folder. The
  restore-or-placeholder decision is still pending, together with `AppInfo.xml`
  and `appsettings.json`.
- `tools.mjs` line 52 reads `npm run ${safePackageInstalls[safePackage]} --ignore-scripts false`
  in the photo — a **space** before `false`, not `=`. Transcribed as photographed.
  If the source is actually `--ignore-scripts=false` the behaviour differs, so
  this is worth re-checking against the real file rather than taking from the
  transcription.
- `tools.mjs` has **no blank line between lines 102 and 103** (`npmAuth`'s closing
  brace and `export async function npmInstall`). Every other top-level function in
  the file is separated by one. Preserved as-is; confirmed across the photo
  overlap, so it is a source formatting slip, not a transcription artefact.
- `tools.mjs` does not import `console` (it uses the global), while `pre-start.mjs`
  does `import console from 'node:console'`. Inconsistent but harmless;
  transcribed as photographed in both.
- Line counts verified against the photo gutters: `tools.mjs` 180 content lines
  (gutter ends at 181), `pre-build.mjs` 19, `pre-start.mjs` 10 (gutter 11),
  `update.mjs` 4 (gutter 5), `build.mjs` 13 (gutter 14). All five parse as valid
  ESM under `node --check`.
- Photo overlaps used to join the four `tools.mjs` images: 42-55 / 57-67, 103-120,
  and 136-140. Every join was verified on at least four common lines.
- `build.mjs` line 11 is one long line in the source (the `configuration` const),
  soft-wrapped in the photo with no continuation character.
- **Still outstanding in this folder:** `clean.mjs`, `install.mjs`, `npm-clean.mjs`,
  `npm-safe-package-installs.mjs`. The last is the important one — it holds the
  `safePackageInstalls` map and therefore decides whether the Kendo licence patch
  is automated.
