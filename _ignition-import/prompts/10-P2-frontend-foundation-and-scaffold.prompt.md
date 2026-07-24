---
description: Step 10 numbered browser-foundation lane that expands the Fusion frontend scaffold guide for MVC, Razor, Angular, AngularJS, and mixed browser sources while publishing current evidence under the canonical frontend-foundation-and-scaffold surface.
agent: OpX-AppMod-P2-Modernize
tools:
  - read/readFile
  - search/codebase
  - execute/runInTerminal
  - execute/getTerminalOutput
  - read/terminalLastCommand
  - read/terminalSelection
  - agent
  - browser
  - edit/editFiles
  - todo
  - vscode/vscodeAPI
  - fusion/copilot-docs/*
---

# Step 10 FrontEnd Foundation & Scaffold

**Recommended model tier:** Balanced (medium thinking). **Estimated run time:** 15-30 min (varies with app size and model).

> Step Artifact Self-Check (QA-independent; works on `No QA` runs)
> - Input precheck before doing work: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 10 -Mode Input`. Proceed only on `RESULT: OK` (exit 0); on `RESULT: BLOCKED` (exit 2), resolve the producing step for the missing hard-stop input before continuing.
> - Output verify at closeout: run `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/shared/verify-step-artifacts.ps1 -Step 10 -Mode Output`. Require `RESULT: OK` before declaring this step complete, proving every artifact Later steps consume exists and is non-empty.

## What This Step Does (plain language)

- **What this step does:** Builds the destination browser shell and the empty page/route "rooms" the app will live in, and locks in the legacy styling foundation (global styles, fonts, icons, assets) so pages moved later look right from the first paste.
- **Why it matters:** If the shell or styling foundation is wrong here, every page moved in Step 11 inherits the wrong look and a broken or empty navigation. A shell that compiles but renders an empty nav is the exact failure this step must prevent.
- **What you will have when it is done:**
  - `styling-foundation.json` - the recorded legacy styling contract (style entries, SCSS import order, dependencies, assets) the destination must preserve.
  - The scaffolded route and page shells in the target client root.
  - `ui-parity-gap-scan.json` - the deterministic control-parity scan result.
  - `runtime-parity-checkpoint.json` - proof the running shell renders its navigation and is reachable in the browser.

Follow `/.github/instructions/step-confidence-contract.instructions.md`: open in plain language, end on binary gates, prove `src/` changes against the running app, and on any blocker guide the user toward completing THIS step accurately instead of advancing.

## Step Ownership Boundary (exclusive)

> Each numbered step owns exactly one concern so a defect always has one home and no two steps re-litigate the same territory (the anti-drift contract). Stay inside this boundary.

- **Step 10 OWNS the styling foundation outright** - it is the single source of truth for the app's look. The legacy color scheme, brand palette, header/footer chrome color, typography, field width/density, style `includePaths`, and shared style partials are settled here. Steps 11-16 consume this foundation; they do not re-author it.
- **This step does NOT own:** real page behavior or data wiring (Step 11), live data + auth (Step 12), shell-drift repair (Step 13), UI planning (Step 14), or Fusion primitive swaps (Steps 15-16). Do not pull those forward into foundation work.
- **Downstream regression rule (how the foundation stays clean):** Steps 11, 12, and 13 must re-run `scan-styling-foundation.ps1` as an entry check. If a later step finds the foundation regressed - dark scheme returned, header lost its brand color, controls went full-bleed - that is a **Step 10 regression**; fix it at the foundation and re-record `styling-foundation.json`, never patch it locally inside one page.

**Desired completed state:** the running shell boots in the legacy color scheme with branded header/nav/footer chrome, the nav renders every configured route link, form controls render at legacy width/density, and the deterministic styling-foundation scan exits clean - so every page moved in Step 11 inherits the correct look by construction instead of being restyled to parity later.

Objective
- Execute the numbered Step 10 lane as the canonical browser-foundation owner.
- Take the read-only Fusion guide handoff `Step 10 FrontEnd Foundation & Scaffold` and expand it so the numbered lane works for MVC, Razor, Angular, AngularJS, legacy Fusion G1, and mixed browser sources.
- Establish or refresh the styling foundation, scaffold the approved browser route and page shells, preserve the legacy visual contract at shell level, and prove the target browser root builds before Step 11 moves real feature behavior.
- Classify Step 10 completion explicitly with these statuses:
  - `decompositionContractStatus`: `Current`, `NotApplicable`, or `Blocked`
  - `shellFoundationStatus`: `Validated`, `Partial`, or `Blocked`
  - `step11HandoffStatus`: `ReadyForMigration`, `NotReadyForMigration`, or `Blocked`
- Do not report Step 10 ready when the shell compiles but the decomposition-contract posture is stale, the styling foundation is only partially reconciled, or the screenshot and locator baseline still lags the current shell.

Guide alignment
- The Fusion guide handoff remains the baseline checklist for Angular-style client formation.
- This prompt is the numbered execution contract and must generalize that guide for server-rendered browser surfaces, browser-led SPA surfaces, and mixed or hybrid browser inputs without assuming Angular is the source shape.
- Retire the older Step 10 page name `frontend-modernization-parity`. The canonical Step 10 portal surface is `frontend-foundation-and-scaffold`.

About To Do
- Context: Determine whether the legacy browser source is MVC or Razor, Angular or AngularJS, mixed or hybrid, or not applicable by using Step 7 decisions plus the shared browser-source decomposition skill. Use Legacy System Analysis screenshots and inventory as the visual baseline. Do not treat an older Step 10 portal page as source truth.
- Dev work: Refresh the styling foundation and scaffold the highest-value missing route, page, component, and shell seams in the Step 7-approved target browser root while preserving the legacy DOM/class, styling, and locator contract.
- QA plan: Use the mapped Step 10 QA workflow inside the active Step 10 loop at meaningful checkpoints and at closeout, or report the exact blocker, then save the numbered-step ledger and state and read back the current source evidence against the saved records.

Execution mode
- This prompt is operational, not advisory. Execute the full Step 10 lane.
- Run the styling-foundation gate first. Do not scaffold or migrate deeper browser slices until the foundation gate passes.
- If the styling foundation is already current and trustworthy, continue with the highest-value missing scaffold, shell, or route-formation gaps instead of stopping early.
- Within one active Step 10 pass, batch the shell edits, selectors, tests, and one proving build together before refreshing runtime-comparison artifacts and ledger readback. Do not rerun the heavier evidence-refresh work after each small shell tweak in the same pass.
- Treat the mapped QA workflow as the Step 10 validation loop. Run it at the next meaningful checkpoint, blocker, or closeout proof refresh inside the same step instead of saving all QA work for the end.
- Use move-not-copy progression wherever practical for app-owned browser assets. When direct move is too risky, use create-validate-delete fallback and report leftovers as visible drift.
- Do not close the step until the mapped QA workflow ran at the required in-loop checkpoint or closeout gate, or the exact QA blocker was reported, the latest full response was saved to `.modernization/portal/data/json/step-response-ledger.json` and `.modernization/portal/data/json/step-workflow-state.json`, and the saved entries were read back with populated `status`, `updatedAt`, and `latestFullResponse` values.

Required modality posture
- Do not hardcode Angular-specific assumptions. Use the Step 7 modality and target-browser decision to determine whether the destination is Angular, another browser client, or a lightweight proof-only surface.
- Use `browserSurfaceApplicability` from Step 7 as the browser-lane gate. When it is `Required`, execute the full foundation and scaffold loop. When it is `NotApplicable`, execute a lightweight proof pass that refreshes source evidence, confirms no managed browser-surface foundation work is owed, and saves the step ledger entry. Do not refresh the Quality Portal as part of this step. If portal surfaces are stale relative to source artifacts, report it in chat as a manual user action; portal refresh is never automatic. See /.github/instructions/qa-portal-reporting.instructions.md.
- Use `/.github/skills/browser-source-decomposition/SKILL.md` as the shared decision surface before choosing or refreshing any source-specific decomposition contract. That skill owns the reusable classification for server-rendered, browser-led SPA, Fusion G1, mixed or hybrid, static-document, already-modern, and validate-only browser inputs.
- When the shared browser-source decomposition skill classifies the discovered source as MVC, Razor, or another server-rendered browser app, require the approved decomposition contract before shell formation can close. If `.modernization/ignition-artifacts/MVC-To-Browser-Client-Decomposition-Contract.generated.json` is missing, stale, or contradicted by the current Step 5 or Step 7 evidence, use `.github/prompts/P2-Modernize/mvc-to-browser-client.prompt.md` and execute it in full before continuing Step 10 shell formation.
- When the shared browser-source decomposition skill classifies the discovered source as Angular, AngularJS, legacy Fusion G1, or another browser-led SPA, require the approved decomposition contract before shell formation can close. If `.modernization/ignition-artifacts/Angular-To-Browser-Client-Decomposition-Contract.generated.json` is missing, stale, or contradicted by the current Step 5 or Step 7 evidence, use `.github/prompts/P2-Modernize/angular-to-browser-client.prompt.md` and execute it in full before continuing Step 10 shell formation.
- When the shared browser-source decomposition skill classifies the discovered browser surface as mixed or hybrid, such as server-rendered views plus SPA islands or other layered browser evidence, refresh whichever decomposition contract or contracts are needed to cover the real surface and reconcile the active browser contract before shell formation closes. Do not force the whole app through only one source-shape path when current evidence proves a mixed browser surface.
- When the approved browser root already exists and the current decomposition-contract posture plus styling-foundation evidence are still trustworthy, run Step 10 as a validation or shell-gap pass: refresh the contract selection, preserve the current structure, and close the highest-value shell or parity gaps instead of regenerating the shell from scratch.
- If the source browser shape is neither cleanly server-rendered nor cleanly browser-led SPA, record the chosen primary decomposition path plus the unsupported secondary edges in the returned data and refreshed evidence instead of inventing a one-off stack-specific lane.

Styling foundation gate
- Consume `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json` and `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json` before editing browser-shell, route, callback/logout, client-service ownership, or protected request seams.
- When browser work is required, create or refresh `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json` if the existing version is stale, incomplete, or contradicted by current evidence.
- Always collect source-shape-specific styling inputs before touching the destination:
  - For MVC, Razor, or other server-rendered sources:
    1. Read legacy bundle and layout inputs such as `App_Start/BundleConfig.cs`, `_Layout.cshtml`, shared partials, page-level style or script references, print views, export views, `Content/**`, and any shell-level `Scripts/**` files that affect browser structure, styling, or UI state.
    2. Record the exact CSS and JS load order, bundle membership, fonts, icons, images, host or body classes, and DOM/class hooks that the legacy views depend on.
    3. Record third-party styling or UI libraries that must survive the move, whether they should be carried as static assets, destination package dependencies, or both.
  - For Angular, AngularJS, legacy Fusion G1, or other browser-led SPA sources:
    1. Read the legacy `angular.json` and record the exact `styles` array entries, `stylePreprocessorOptions.includePaths`, and any `scripts` entries that load CSS or JS at build time.
    2. Read the legacy global styles entry point, such as `src/styles.scss` or `src/assets/scss/styles.scss`, and record the full SCSS partial import list in order.
    3. Read the legacy `package.json` and record every styling-related dependency, including Bootstrap, ng-bootstrap, ag-grid themes, icon packages, font packages, and any other CSS or SCSS libraries.
  - For mixed or hybrid browser sources, merge both evidence families into one Step 10 foundation pass and preserve the side that currently owns the shell DOM, styles, and locator contract.
- Verify the destination browser styling foundation before scaffolding pages:
  - record the destination style entry points, include paths, build-time scripts, and package dependencies
  - preserve the legacy stylesheet, bundle, or theme import order that still governs parity
  - copy or reconcile assets, fonts, icons, images, static files, and print-supporting resources needed by the approved browser target
  - reconcile styling-related package dependencies in the destination package manifest only when the target browser root truly needs them as installable packages; do not force every legacy static library into `package.json` without evidence
  - when the destination manifest changes, run the real client install flow and verify it completes without errors
  - if install fails due to peer-dependency conflicts, align to Fusion-supported versions by default, record the conflict and workaround in `styling-foundation.json`, and prove a clean install before proceeding
  - run a compile-focused client proof and treat compile or asset-resolution failure as a gate blocker
  - when the repo's default build script bundles lint or other hygiene checks, separate shell-readiness compile proof from unrelated lint debt by running a direct compile path such as `ng build` or the repo's compile-only equivalent and report lint findings separately
- Save or refresh `.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.json` with at least these fields:
  - `sourceBrowserShape`
  - `sourceContractsUsed`
  - `angularJsonStyles`
  - `angularJsonIncludePaths`
  - `scssImportOrder`
  - `serverRenderedStyleInputs`
  - `stylingDependencies`
  - `assetManifest`
  - `legacyScreenshotBaseline`
  - `inventoryMatrixSource`
  - `npmInstallStatus`
  - `buildStatus`
  - `themePalette` - brand, header, primary-action, neutral/border, and semantic colors from the Step 5 contract, each mapped to the app-owned design-token id that now owns it
  - `typographyContract` - font families, weight scale, label sizing, and any `@font-face` families (with the asset paths copied into the client)
  - `shellChromeRegions` - header, nav, and footer regions the shell must render, with the modern component or template that owns each
  - `navRouteModel` - the ordered nav links (label, route, order, auth gate) the shell nav must render, derived from the route inventory
  - `perRouteReferenceScreenshots` - the legacy reference screenshot per route carried forward as the appearance baseline
  - `fusionThemeBinding` - the exact mechanism the legacy palette/typography/sizing is bound through so the components consume it (for `@fusion/theme`: the light/dark theme-generator override-map keys and the `root/main` header-branding inputs; for a preserved legacy system: the config map). Record the Fusion MCP doc lookup that confirmed the override-map API. Orphan CSS custom properties that no selector or theme generator reads do not count as bound.
  - `colorSchemeForced` - the legacy color scheme (`light` or `dark`) the shell applies deterministically, with proof it is not left to the OS `prefers-color-scheme`
  - `brandBindingVerified` - per brand token (header background, primary action, field border and sizing), the consumed binding point that proves the running component actually reads the legacy value
  - `appOwnedTokenOutputPath` - the CSS custom-property output the modern shell and components consume

Scaffold formation rules
- Scaffold the approved route, page, and feature shells inside the Step 7-approved target browser root. Default to `src/<AppName>.Web.Client` only when the selected architecture uses the standard browser client root.
- Preserve the protected starter client shell by default. Do not broadly replace `main.ts`, `app.config.ts`, `fusion.config.ts` variants, client auth/bootstrap files, `package.json`, or other Step 7-protected client control points unless the Step 7 decisions artifact explicitly allows a narrow rebind.
- Preserve the legacy shell-level visual contract while scaffolding:
  - keep the approved DOM or class hooks needed by styling and locator evidence
  - preserve layout intent, density, shell framing, print shells, modal shells, hidden-state surfaces, upload or export seams, and other critical page landmarks proven by Step 5 evidence
  - do not introduce Fusion-theme restyling or starter-sample styling drift as a substitute for parity
- For MVC, Razor, or other server-rendered source families, derive the scaffold from the approved route map, controller or action surface, view and partial structure, print and export views, and the screenshot-backed page states captured in Legacy System Analysis.
- For Angular or other SPA source families, derive the scaffold from routes, pages, components, services, state, and current browser-owned UI structure.
- For mixed or hybrid sources, preserve whichever side owns the visible shell and route contract today instead of collapsing the whole app into one source-shape assumption.
- Do not hide browser behavior wiring, client platform integration, shell stabilization, UI inventory generation, or deliberate primitive-family replacement inside Step 10 shell formation.
- Every interactive control rendered in `src/` (button, link, menu item, tab, row action, form submit, print/export/upload/download trigger, keyboard shortcut) must map to an entry in the Step 5 **Interaction Wiring Inventory** at `.modernization/ignition-artifacts/discovery/interaction-wiring-inventory.json` and reproduce the legacy `target`, `sideEffects`, and `authGate` for that control. Rebuilding a control without a matching wiring entry - a button that looks right but has no handler, no route, or no API call - is a parity defect, not a cosmetic issue, and must be fixed before the Step 10 visual-parity baseline is accepted. If a legacy control is intentionally being retired or redirected, the decision must be recorded in Step 8 before the modern control ships, not after.
- For any control whose Interaction Wiring entry has `wiringKind` ∈ `api-call|state-mutation|navigation-then-api|export|print|upload|download|auth-callback` (or whose label falls in the high-risk command family - save, delete, submit, calculate, approve, export, print, upload, download, callback, logout, lookup, refresh, generate, run), the Step 10 scaffold MUST also reproduce the **Workflow Trace Inventory** at `.modernization/ignition-artifacts/discovery/workflow-trace-inventory.json`: the modern handler must invoke the documented `requestShape` exactly (verb, URL, payload tree with the same nesting and casing - flat-vs-nested mismatches like `selectedSubstationName: { selectedSubstationName: "name" }` are the most common parity 400), and every `visibleStateLabels` entry (in-flight and post-success text) must appear in the modern shell at the correct state-machine point. A control whose UI is wired but whose `requestShape` or `visibleStateLabels` are missing is a parity defect even when the button "works" - it ships an invisible workflow regression and is rejected by the Step 12 Workflow Trace coverage gate.
- Create or refresh parity-supporting browser-surface shell and component tests under the Step 7-approved frontend test root, defaulting to `tests/frontend/angularUnitComponent` only when the selected browser client architecture actually uses that root.

**Per-Slice Shell Parity (MANDATORY)**
Step 10 inherits the slice-parity contract from `/.github/instructions/frontend-modernization-learning.instructions.md` `Slice Parity And ROI Rules` and `/.github/instructions/testing-design-contract.instructions.md` `Slice Parity Floor And Flake Budget`. Phase 2 frontend advances incrementally starting at Step 10, not just at Step 15 and Step 16.
- Each Step 10 pass advances ONE shell slice (one route shell, one layout region, or one styling-system primitive family) and targets +5 to +10 percentage points of either `screenshotCoveragePercent`, `currentVisualParityPercent`, or `currentInventoryParityPercent` for the touched rows.
- Per-slice diffs are emitted for the touched `{routeId, stateId}` rows under `.modernization/portal/data/images/parity-diffs/step10-pass-{passId}/` (pixel diff plus structural diff). The pass records `{ passId, sliceId, parityBefore, parityAfter, parityGain, diffArtifacts[] }` in the current Step 10 runtime comparison artifact or a sibling `step10-pass-log.json`.
- ROI-first selection from `Slice Parity And ROI Rules` applies: score each eligible shell slice `(visibilityScore + interactionScore) - riskScore` on a 1-to-5 scale. The first three Step 10 passes on a new browser surface MUST produce a change a user can see on the running application (primary route shell, top navigation, primary form region) before background containers or non-visible scaffolding.
- Generic across MVC, Razor Pages, Web Forms, AngularJS, Angular, React, Vue, Blazor, and server-rendered HTML. The shell slice unit is whatever the source framework actually renders: a Razor layout region, an Angular route component, a React layout container, a Blazor page, or a server-rendered partial.

**Repeat-Run Recommendation (MANDATORY)**
At the end of every Step 10 pass that advanced eligible shell-slice work without exhausting the foundation surface, the chat `Suggestions` section MUST explicitly recommend rerunning Step 10 with the expected next parity gain (5 to 10 percentage points) and name the next-eligible shell slice with its visibility/interaction score. Exhaustion claims must cite the current runtime comparison artifact rows that prove no eligible shell slice remains. Use the same wording family used at Step 15 and Step 16 so operators see consistent guidance across the frontend chain.

Evidence and portal contract
- Treat `.modernization/portal/data/json/Legacy-System-Analysis-Report.json` plus `.modernization/portal/data/images/legacy-system-analysis/**` as the Step 10 screenshot baseline unless current evidence explicitly supersedes them.
- Treat the Step 5 styling-system inventory and sizing or density contract from Legacy System Analysis and `.modernization/ignition-artifacts/modernize/fusion-restructure/inventory.json` as a co-equal visual baseline with screenshots. Do not restyle from screenshots alone or by feel.
- Treat `.modernization/portal/data/json/frontend-runtime-comparison.generated.json` as the current Step 10 comparison artifact and source for parity metrics, screenshot pairing, and shell-level locator coverage.
- Treat `inventoryParityRows` from the current runtime comparison artifact as a co-equal visual baseline with screenshots.
- Publish the Step 10 portal surface to these canonical outputs:
  - `.modernization/portal/data/pages/frontend-foundation-and-scaffold.html`
  - `.modernization/portal/data/pages/frontend-foundation-and-scaffold.json`
- Retire `frontend-modernization-parity.html` and `frontend-modernization-parity.json` as active Step 10 surfaces. If they still appear in links, selected-page tokens, or refresh outputs, treat that as dead-surface drift and correct it.
- Do not treat rendered portal HTML or the page-model JSON alone as source truth. Source truth is the current shell source, the active runtime comparison artifact, locator-first parity evidence, and the current matrix rows.
- Refresh source artifacts (runtime comparison artifacts, locator-first parity evidence, structured Step 10 source JSON) once near the end of the active Step 10 pass after the shell batch is green. Do not run any portal republish flow as part of this step. If the rendered portal page lags the refreshed source artifacts, report the staleness in chat for the user to refresh manually; never auto-refresh the portal. See /.github/instructions/qa-portal-reporting.instructions.md.
- After refresh, read back the canonical Step 10 page model and compare it against the runtime comparison artifact and the current browser shell. If only the page face changed, report render-only drift. If current shell edits are newer than the comparison artifact or page model, report freshness drift and do not claim the page is current.

Response contract
- Start with `About To Do` and keep the three bullets in the required order: `Context`, `Dev work`, and `QA after`.
- In the numbered-step response, add a `Modernization Added` section immediately before `Returned Data` and enumerate the exact route shells, pages, styles, assets, components, selectors, or test surfaces added or materially expanded during the pass.
- In the numbered-step response, add a `UI Parity Snapshot` section immediately after `Modernization Added` and before `Returned Data`. Report the current gate-bearing metrics from the newest trustworthy Step 10 runtime comparison evidence, including:
  - `Screenshot coverage: <capturedModernCounterpartCount> of <requiredLegacyScreenshotCount> (<screenshotCoveragePercent>%)`
  - `Visual parity: <currentVisualParityPercent>% (<currentVisualParityBand>)`
  - `Inventory parity: <currentInventoryParityPercent>% weighted`
  - `Selector contract coverage: <selectorContractCoveragePercent>% weighted`
  - `Overall rating: <overallRatingAgainstRequested4a> / 10`
- Add a `Suggestions` section immediately after `UI Parity Snapshot`. Return 1 to 3 concrete next actions grounded in the current artifacts. When all gates are already passing, use this section for the best remaining non-blocking cleanup, freshness-drift repair, or sign-off work instead of saying there is nothing left to do.
- If the current runtime comparison artifact, the Step 10 page model, and any parity-summary surfaces disagree, use the newest gate-bearing runtime comparison numbers in chat, call out the stale surface as freshness drift, and base the suggestions on the reconciled source truth.
- In `Returned Data`, include at least:
  - `decompositionContractStatus`
  - `shellFoundationStatus`
  - `step11HandoffStatus`
  - `sourceBrowserShape`
  - `decompositionContractsUsed`
  - `targetBrowserRoot`
  - `stylingFoundationPath`
  - `runtimeComparisonArtifactPath`
  - `portalPagePath`
  - `portalPageModelPath`
  - `legacyScreenshotBaselineSource`
  - `inventoryMatrixSource`
  - `buildStatus`
  - `qaStatus`
  - `requiredLegacyScreenshotCount`
  - `capturedModernCounterpartCount`
  - `screenshotCoveragePercent`
  - `currentVisualParityPercent`
  - `currentVisualParityBand`
  - `screensMeetingVisualParityRequirementCount`
  - `comparedScreenCount`
  - `currentInventoryParityPercent`
  - `selectorContractCoveragePercent`
  - `overallRatingAgainstRequested4a`
  - `topParitySuggestions`
  - `controlParityGapScanPath`
  - `controlParityCriticalGaps`
  - `controlParityMajorGaps`
  - `controlParityMinorGaps`
  - `controlParityDimensions` (e.g. `label, icon, color`)
  - `controlParityDiscoveryProbeTopTokens` (top 5 unrecognized legacy attribute / class families - planning input for the next dimension rule pack)
- Do not create or depend on a separate retired Fusion-only state tracker as numbered-flow state. Keep numbered-step state in the step ledger plus the step-owned structured artifacts.

UI Control Parity Gate (deterministic, multi-dimensional)
- Before declaring `Ready for Step 11`, run the deterministic UI control parity scanner from the repo root:
  `powershell -NoProfile -ExecutionPolicy Bypass -File .\.github\scripts\parity\scan-ui-parity-gaps.ps1 -Quiet`
- The scanner pairs every legacy `<a>` / `<button>` / `<li>` and every modern `<app-*>` / `<fusion-*>` wrapper (including inline `template:` blocks and tab-data arrays) and compares them across a registry of named **parity dimensions**. Each dimension is a self-contained rule pack with a legacy extractor, modern extractor, normalizer, comparator, and an allowlist for documented intentional improvements. Built-in dimensions today:
  - `label`  : visible button/link text after HTML/expression stripping. Drives MissingLabel (Major).
  - `icon`   : Font Awesome / glyphicon class set, with FA4 alias normalization (`fa-save`≈`fa-floppy-o`, `fa-edit`≈`fa-pencil-square-o`) and semantic-vocab resolution for component wrappers (`semantic:cancel`≈`fa-times-circle-o`, etc.). Drives MissingIcon (Critical) and IconMismatch (Minor).
  - `color`  : Bootstrap `btn-*` class vs Fusion `color="..."` attribute, mapped through `$BootstrapColorMap`. Drives ColorMismatch (Minor).
  - `column`  : grid column headers harvested app-agnostically from `<th>`, ag-grid `headerName`, ColDef `title`, and `<fusion-data-grid-column>` / `<kendo-grid-column>` titles, on BOTH the markup and the `.ts` side. A legacy column header with no modern counterpart drives MissingColumn (Major) - the column-collapse defect where a grid loads real data in fewer or more generic columns than legacy.
  - `handler-wiring`  : modern controls whose `(click)` handler is an empty / TODO-only method body, or that are permanently disabled by a literal `[disabled]="true"`. Drives InertControl (Major) - a control present but behaviorally dead. Scoped per component so a same-named real method elsewhere never false-flags.
  - `deferral-drain`  : a stubbed handler is suppressed from the Major count only by an entry in the per-app deferral registry `.modernization/ignition-artifacts/discovery/ui-deferral-registry.json` (`{ handler, ownerStep, reason }`) - app-specific handler names are never hard-coded into the scanner. Suppressed handlers are always surfaced in `deferredInertControls[]` / `deferredInertControlCount`, so a zero `inertControlCount` never hides a parked stub. Running the scan with `-CurrentStep <n>` re-flags any deferral whose `ownerStep <= n` as a Major InertControl (the drain gate), so a deferral cannot survive past the step that promised to wire it.
- Output is written to `.modernization/ignition-artifacts/discovery/ui-parity-gap-scan.json`. Exit code `0` = clean, `2` = at least one Critical or Major gap exists.
- The gate fails if `controlParityCriticalGaps > 0` or `controlParityMajorGaps > 0`. Minor hits (any dimension's mismatch kind) are informational and do not block, but should be either fixed or added to that dimension's allowlist with a written reason.

Discovery probe (catching future mysteries)
- The same scan emits a `discoveryProbe` block listing every legacy attribute name and unrecognized class-token family that NO active dimension consumed, ranked by frequency. This is the kit's mechanism for surfacing **unknown-unknown** parity dimensions: when the next app introduces a new attribute family the scanner has never seen (e.g. `confirm`, `tooltip`, `ng-disabled`, `ng-show`, `accesskey`), the top discovery-probe entries point directly at the next rule pack to add.
- Treat the probe as a planning input, not a gate. After Step 10 is clean, scan the top entries and decide for each: (a) ignore (truly app-specific noise - add to `$KnownLegacyAttributes` or `$KnownLegacyClassPrefixes`), (b) wire a new dimension by copy-adapting the `color` block, or (c) defer with a note explaining why this app does not need the dimension.

Adding a new dimension (recipe)
- To add a parity dimension (example: `tooltip` covering legacy `title="..."` vs modern `[title]` / `matTooltip`):
  1. Add a `$TooltipAliasMap` (if normalization is needed) near the top of `.github/scripts/parity/scan-ui-parity-gaps.ps1`.
  2. Populate `$rec.tooltip` in both branches of `Scan-File` (raw HTML and component wrapper).
  3. Copy the existing `# DIMENSION PASS: color/severity` block, rename to `tooltip`, and provide a `$tooltipAllowlist`.
  4. Append the dimension name to `summary.dimensions`.
- Burn down Critical and Major hits before claiming Step 10 complete. If a hit is a genuine scanner false positive (e.g. modern uses a dynamic `[label]` or a tab data array whose shape the scanner cannot read), extend the scanner's harvesters in `.github/scripts/parity/scan-ui-parity-gaps.ps1` so the parity is detected automatically; never bypass the gate by ignoring output.

Runtime Parity Checkpoint (required before closeout)
- A scaffolded shell that compiles is not proof. Before closing Step 10, run the running-app checkpoint from `/.github/skills/runtime-parity-checkpoint/SKILL.md` and save `.modernization/fusion-restructure/runtime-parity-checkpoint.json`.
- Boot `src` (VS Code task `src: start api + client`, or `/.github/skills/runtime-parity-checkpoint/scripts/Start-SrcRuntime.ps1` when you need a persisted backend log), open the shell in the integrated browser, and prove: the shell renders, and the navigation renders every link declared in the route menu metadata. An empty `<nav>` landmark, or a header component with no menu wiring, is a parity defect even though the element exists and compiles.
- **Verify the visual contract by observed render, not by recording JSON fields.** `colorSchemeForced` and `brandBindingVerified` in `styling-foundation.json` are claims; the gate is what the browser actually paints. With the shell open in the integrated browser, read the computed styles and confirm against the legacy contract: (a) the color scheme matches the legacy fixed scheme and does NOT follow the workstation OS `prefers-color-scheme` (the starter `index.html` ships a script that adds a `dark-theme` class from the OS preference - neutralize or override it so the app pins the legacy scheme on every workstation), (b) the header and footer chrome render the legacy background color, (c) primary buttons render the legacy button color, and (d) form controls render at the legacy width/density and are not full-bleed across the page. A clean build, a scanner `majorGaps=0`, or an HTTP 200 is not evidence for any of these.
- Full-bleed form controls are usually a missing-layout defect: confirm the client build's style preprocessor `includePaths` is configured and the shared layout partials exist so per-component styles can constrain field width. An empty `angularJsonIncludePaths` with full-width controls is a Step 10 layout-parity failure.
- Run the deterministic styling-foundation gate (no running app required, holds first-pass on any app): `powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/parity/scan-styling-foundation.ps1 -ModernClientRoot <client root>`. It statically fails when `index.html` follows the OS `prefers-color-scheme` instead of the pinned legacy scheme, when `angular.json` declares no style `includePaths`, when the include path has no shared partials, when the header chrome is not bound to the legacy brand color, or when a data grid's columns are all auto-sized. Clear it to exit 0 before closeout; it writes `.modernization/ignition-artifacts/qa-portal-reporting/styling-analysis/styling-foundation-scan.json`.
- For a Fusion/Angular client, use the copy-start foundation bundle at `/.github/skills/visual-parity-gate/references/fusion-client-foundation-templates/` (scheme-pin snippet, `includePaths` snippet, `_variables`/`_collection-grid`/`_legacy-bootstrap-baseline` partials, header-chrome override snippet). Materialize the structure, then BIND the values from `styling-foundation.json` (`themePalette`/`typographyContract`) and re-baseline any additional legacy utility classes the templates actually emit. This makes the foundation correct by construction instead of authored from scratch, so the developer is not vibe-coding the theme, field sizing, or nav-bar color.
- Watch the browser console and the backend log during the check. An unexplained browser-console error (Angular template/runtime error, unhandled promise rejection, failed XHR) or a backend `4xx`/`5xx` means the shell is not stable; diagnose and fix it in-step before closeout, do not advance with a known error.

Completion gate
- Return `Ready for Step 11 Frontend Migration: Yes` only when the styling foundation is verified, the approved route and page shells compile in the target browser root, any remaining lint debt is explicit instead of masquerading as a compile blocker, the canonical Step 10 page was refreshed under `frontend-foundation-and-scaffold`, shell-level parity evidence is current enough to trust, the Legacy System Analysis screenshot baseline and matrix-backed inventory evidence are aligned to the current shell, the source-specific decomposition-contract posture selected by the shared browser-source decomposition skill is current when required, the deterministic UI Control Parity Gate scanner exits clean (`controlParityCriticalGaps = 0` and `controlParityMajorGaps = 0`), and critical shell or styling regressions are resolved.
- Binary completion gates (each must be `pass` or carry an explicit, owned waiver):
  - styling foundation recorded and the shell builds clean
  - app-owned design tokens generated from the legacy palette/typography and the Fusion theme bound to them - the running shell shows the legacy brand palette, not the raw default framework theme
  - shell chrome renders: a branded header, a footer, and a nav populated from the `navRouteModel`
  - **color scheme verified by render**: the running shell paints the legacy fixed scheme (light/dark) and does not follow the workstation OS `prefers-color-scheme`
  - **chrome and control color verified by render**: the header/footer background and primary-button colors match the legacy contract in the browser computed styles, not just in recorded tokens
  - **control sizing verified by render**: form controls render at legacy width/density (not full-bleed); the client build's style `includePaths` and shared layout partials are configured
  - deterministic styling-foundation gate clean: `scan-styling-foundation.ps1` exits 0 (color scheme pinned, header chrome bound to the legacy brand color, style `includePaths` populated with shared partials, data grids declare explicit column widths)
  - UI Control Parity scanner exits clean (`majorGaps = 0`, `criticalGaps = 0`)
  - runtime checkpoint `navParity = pass` - the running shell nav renders every configured route link
  - runtime checkpoint reachable with no unexplained browser-console or backend errors
- A clean build, a scanner `majorGaps = 0`, or an SPA route returning HTTP 200 are necessary but never sufficient for the render-verified gates above. A gate recorded as `pass` from those proxies instead of an observed browser render is invalid; if the shell cannot render in the current environment, record the checkpoint `blocked`/`unverified` and keep the step open.
- If any binary gate fails, do not advance. Keep the exact next step on `Step 10 FrontEnd Foundation & Scaffold`.

If You Hit A Blocker (finish this step, do not drift)
- A broken shell or empty nav poisons every page moved in Step 11, so do not advance with a failing checkpoint.
- Report the exact failing gate, the most likely cause in plain language (for example: route menu metadata exists but the shell header is not wired to render it), the concrete fix to finish Step 10, and whether the real gap belongs upstream in Step 5 styling or inventory. Apply the smallest in-scope fix and re-run the affected proof before reporting `Blocked`.
- Otherwise keep the exact next step on `Step 10 FrontEnd Foundation & Scaffold`.

Design Tokens Extraction (MANDATORY when browser-surface is in scope)
- On the first Step 10 pass that owns the browser shell, extract a tokenized styling foundation from the legacy stylesheets and the captured screenshots before any modern component CSS is written.
- Produce `/.modernization/ignition-artifacts/modernize/fusion-restructure/styling-foundation.tokens.json` with these token families derived from the legacy evidence: `color` (brand, neutral, semantic), `spacing` (rhythm scale), `typography` (font family, size scale, weight, line-height), `borderRadius`, `shadow`, `zIndex`, `motion` (duration, easing). Each token row carries `tokenId`, `valueLight`, `valueDark?`, `sourceEvidencePath` (CSS file + selector or screenshot reference), `usageCount`, and `mapsToFusionToken?` (verified via Fusion MCP).
- Emit the tokens as CSS custom properties in `src/<App>.Web.Client/src/styles/_tokens.css` (or the equivalent shell-styling entry point). Modern shell, modern components, and modern slice work consume tokens only; raw hex, raw pixel literals, or ad-hoc font stacks in component CSS are a violation reported by Step 13 stabilization and Step 17 verification.
- Generic across MVC, Razor Pages, Web Forms, AngularJS, Angular, React, Vue, Blazor, and server-rendered HTML. The token harvester reads `componentCensus`, `screenshotCoverageMatrix`, and the captured legacy CSS rather than hard-coding any current-app color or pixel value.

Legacy Visual Language By Construction (MANDATORY when browser-surface is in scope)
- The goal of Step 10 is that the modern shell inherits the legacy visual language by construction, so the app resembles the legacy app from the first page paste rather than being restyled to parity later. The answer key is the legacy app in `LegacyCode/` and the Step 5 contract (`styling-foundation.json` + `ui-visual-contract.json`), never a finished modern reference.
- Generate app-owned design tokens from the extracted legacy `themePalette` and `typographyContract`, then **bind them through the theme system's actual consumed API, not as orphan CSS custom properties**. A generated `--color-brand-*` custom property that no theme generator, selector, or component reads changes nothing - the shell still renders the framework default. Inject the legacy palette/typography/sizing through the mechanism the components actually consume:
  - For `@fusion/theme`, pass the legacy palette to the light/dark theme-generator **override map** and use the `root/main` **header-branding** composition (the `@fusion/theme` README documents both; confirm the exact override-map keys via Fusion MCP `fusion_framework_docs` before binding - do not guess).
  - When a legacy styling system is preserved for parity (Bootstrap, Material, and similar), inject the legacy brand into that system's config map (for Bootstrap, the `$bootstrap-config` map consumed by `bootstrap/scss/bootstrap`) so the controls the legacy app already used render branded.
- **Force the legacy color scheme; do not inherit the OS `prefers-color-scheme`.** When the legacy app is light, the shell must apply the light theme deterministically. A shell that renders dark because of a `prefers-color-scheme: dark` media query or an auto-added `dark-theme` class while the legacy app is light is a Step 10 failure, not user preference.
- Bind the legacy **header background color** and the legacy **field sizing/density** (input height, border, label size) through the same consumed mechanism. Header color and form-control density are part of the visual contract, not cosmetic polish.
- The running shell must show the legacy brand palette, typography, header color, and field sizing - not the raw default framework theme.
- Build the shell chrome so the legacy layout is recognizable: a branded header, a navigation region populated from the `navRouteModel` (every route link rendered and navigable), a footer, and the legacy layout density (header/footer offsets, content max-width and padding).
- Explicit Step 10 failure conditions (each is a gate failure, not cosmetic drift):
  - **Empty nav** - the navigation region renders with zero links while the route inventory declares links.
  - **Raw default framework theme** - the shell renders the unbranded default theme (for example a default dark surface where the legacy app is light and branded) because the legacy palette was never bound through the theme system's consumed API, or was left as orphan CSS custom properties.
  - **Wrong color scheme** - the shell renders dark while the legacy app is light (or vice versa) because the scheme follows the OS `prefers-color-scheme` instead of being forced to the legacy scheme.
  - **Wrong header color or field sizing** - the header background or the form-control height/density does not match the legacy contract because those values were not bound through a consumed variable.
  - **Missing header or footer chrome** - the branded header or the footer the legacy app shows is absent.
- These conditions are exactly what the Step 13 visual-parity gate (`/.github/skills/visual-parity-gate/SKILL.md`) will measure, so resolve them here at the foundation rather than deferring them into UI-replacement slices.

## Step 10 DEV complete - next action

Step 10 DEV is finished. The matching QA verification is recommended next so the implementation does not drift before later steps consume it.

**Step 10 QA will:** Verify the target browser scaffold boots cleanly and the route table is present.
**Lanes:** Browser-contract (shell smoke)
**Expected ETA:** 3-5 min ET

Reply with the number of your choice:
1. `QA` - run `10-QA-frontend-foundation-and-scaffold` now (recommended).
2. `next` - continue to Step 11 DEV (Frontend Migration).
3. `stop` - pause here and wait for further direction.

The closeout response must also list every file created or modified in this step as workspace-relative markdown links.

You can also invoke the QA prompt directly with `/10-QA-frontend-foundation-and-scaffold`.
