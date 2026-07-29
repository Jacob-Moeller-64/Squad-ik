---
name: visual-parity-gate
description: Repeatable dual-port legacy-visual-parity gate that composes the runtime-parity-checkpoint and screenshot-capture skills to prove the modernized browser shell has inherited the legacy visual language (theme palette, typography, header/nav/footer chrome, nav route model, and layout density) before deliberate Fusion primitive swapping begins. Boots legacy and modern, captures matching routes, diffs computed styles plus screenshots against the legacy visual contract, and emits visual-parity-report.json with per-route pass/partial/fail.
argument-hint: Route list to compare, or "all in-scope routes", or a specific visual-parity dimension to confirm
---

# Visual Parity Gate Skill

Use this skill to run the **COMPARE** step of the legacy-visual-parity contract: prove that the modernized browser shell looks like the legacy application before any Fusion primitive family is swapped in. It is the enforced gate that sits at the Step 13 closeout and must pass before Step 14 begins.

This skill does not invent its own boot or capture machinery. It **composes** the two existing skills:

- `/.github/skills/runtime-parity-checkpoint/SKILL.md` — boots `src`, observes the running app in the integrated browser, watches the backend log, and proves the routes render and function. The visual gate reuses that boot-observe-assert loop and adds appearance assertions on top of it.
- `/.github/skills/screenshot-capture/SKILL.md` — the route-state and modal-state capture mechanics, full-size desktop viewport captures, and duplicate suppression. The visual gate reuses that capture path for both the legacy and the modern side.

Keep this separation. Do not add a parallel boot path or a parallel screenshot path here.

## Why This Gate Exists

A modernized shell can compile, render, and pass functional runtime parity while still looking nothing like the legacy app: a default framework theme instead of the brand palette, an empty navigation region, and no recognizable header or footer chrome. That outcome is a parity defect even though every functional gate is green. The legacy visual language is mechanically derivable from the legacy source for any application, so "the modern app does not resemble the legacy app" is never an acceptable closeout — it is a gate failure or an explicitly accepted, reasoned residual gap.

## Evidence Integrity (hard rule)

This gate's verdict must come from an **observed render of the running modern app**, never from a proxy. A clean client build, a parity-scanner `majorGaps=0`, or an SPA route returning HTTP 200 prove the bundle compiles and the route is served — they say nothing about the rendered color scheme, header/footer/button chrome color, or form-control sizing. A `visual-parity-report.json` written from build/scanner/HTTP signals, or from a prior session's screenshots restamped as current, is invalid evidence, not a pass. Render the route, read the **computed** styles, and capture the screenshot in the current `src` state. If the modern app cannot boot or render in the current environment, record the gate `blocked`/`unverified` and keep the owning step open — do not write `pass` from assumption. The color scheme (must match the legacy fixed scheme, not the OS `prefers-color-scheme`), the header/footer background color, the primary-button color, and the form-control sizing/density are all enforced computed-style dimensions below, not eyeball checks.

## Desired Foundation Look (definition of done)

This is the answer to "what should the app look like after the foundation/migration steps, before deliberate Fusion primitive swapping": a **faithful visual and functional twin of the legacy app**, not a raw framework default and not yet a re-styled modern theme. A `pass` foundation produces ALL of the following, each verified in the rendered computed styles, and each is also covered by the deterministic, app-agnostic static gate `/.github/scripts/parity/scan-styling-foundation.ps1` (color scheme, style include paths, shared partials, grid column widths) so the outcome holds on the first pass for any application:

- **Color scheme matches legacy and is pinned.** The shell renders the legacy fixed scheme (commonly light) on every workstation, independent of the OS `prefers-color-scheme`. A dark default surface where the legacy app is light is a fail. The starter `index.html` OS-preference script must be neutralized or replaced with a deterministic class.
- **Branded header/footer chrome.** The header bar (and footer) render the legacy brand color with legible foreground, not the framework's neutral default surface. When the framework default header paints a neutral surface (for example a Fusion header bound to `app-surface`), bind the brand color through a documented override of the header chrome selector after the theme include.
- **Constrained, inline filter and form controls.** Filter inputs render at legacy width/density (compact, inline) — never full-bleed across the page. This requires the client build's shared style include paths to be configured and the legacy layout/utility classes the templates emit (Bootstrap-style `row`/`col-*`/`form-group`/`grid-filter`, or the source framework's equivalent) to be re-baselined in shared partials; the framework theme does not provide them.
- **Branded data grids at legacy density.** Grids render the full legacy column set (no collapse), a brand-tinted header band, and explicit per-column widths; a genuinely free-text column may flex.
- **Legacy navigation affordances preserved.** A legacy side/left navigation stays a side nav, not a single dropdown.

Deliberate Fusion primitive modernization and polish happen in the later Fusion UI steps, layered on top of this parity baseline — never as a substitute for reaching it. "Looks like a clean modern app" is not the foundation target; "looks like the legacy app" is.

For a Fusion/Angular client, the copy-start bundle at `references/fusion-client-foundation-templates/` (in this skill) materializes the structure for all of the above — scheme pin, `includePaths`, the shared partials, the header-chrome override, and grid sizing — so Step 10 binds the extracted legacy values into a known structure instead of authoring it from scratch.

## Answer Key Is The Legacy App

- The parity reference is the **legacy application in `LegacyCode/`** plus the extracted legacy visual contract — never a finished modern reference, because real engagements do not have a modern twin to copy.
- The extracted contract lives in the existing browser-pack artifacts:
  - `.modernization/fusion-restructure/ui-visual-contract.json` — the measured legacy visual contract (palette, typography, chrome regions, nav route model, per-route reference screenshots, sizing/layout).
  - `.modernization/fusion-restructure/styling-foundation.json` — the styling foundation the modern app was built to inherit (app-owned design tokens, Fusion theme binding, shell-chrome plan).
- When the legacy app can run, the contract is enriched at runtime (computed styles + reference screenshots per route). When it cannot run, the gate still compares against the static contract values and the captured legacy reference screenshots already recorded during Discovery.

## Inputs (derive, never hard-code)

- App identity from `/.modernization/.readme/kit-params.md`.
- The legacy visual contract from `.modernization/fusion-restructure/ui-visual-contract.json`.
- The applied styling foundation from `.modernization/fusion-restructure/styling-foundation.json`.
- In-scope routes and the nav route model from the current inventory evidence: `.modernization/fusion-restructure/inventory.json`, `.modernization/fusion-restructure/ui-inventory.json`, and the route menu metadata in the modern `routes.config.ts`.
- The captured legacy reference screenshots under `.modernization/portal/data/images/legacy-system-analysis/**`.

Routes, palette, typography, chrome regions, and the nav model are always read from these artifacts so the gate stays generic across applications and frameworks. Do not bake any app's colors, fonts, route names, or brand strings into this skill.

## Dual-Port Setup

1. **Boot modern (`src`).** Use the runtime-parity-checkpoint boot path (VS Code task `src: start api + client`, or the persisted-log launcher) and confirm reachability before asserting anything.
2. **Boot legacy when it is runnable.** Start the legacy app on a separate port so the legacy and modern surfaces can be observed side by side. Use the live QA URL or the verified local legacy runtime resolved during Discovery. When the original `LegacyCode/` host is not locally runnable (for example a .NET Framework / `System.Web` backend), use the Step 7 .NET-upgraded workspace `LegacyCode_NETXX_Upgrade` as the runnable legacy reference — its browser client is the same legacy UI, so it is a faithful side-by-side answer key. When neither legacy host can boot, fall back to the captured legacy reference screenshots and the static contract values — the gate still runs against the answer key.
3. The live side-by-side dual-port view is a **developer aid** for spotting drift quickly. The enforced gate is the **automated diff** described below, not the visual eyeball check. The same side-by-side view is also where a reviewer confirms **field/content parity** — that the modern route exposes the same grid columns, filters, and controls as legacy — which is a separate gate from visual parity and is enforced by the `fieldParity` roll-up in the runtime-parity-checkpoint skill.
4. **Different Node majors are expected and must not gate the comparison.** The legacy client and the modern client typically need different Node versions, and `nvm` switches one active version per shell (on nvm-windows, machine-globally), so flipping `nvm` cannot run both live in one environment. When a live legacy run is wanted, give each dev server its own version-pinned Node on PATH, or **build the legacy client once and serve the static output** (no second live Node runtime), or run each app in its own container. None of this is required for the gate: the enforced comparison runs against the **legacy answer key captured during Discovery**, so the legacy app does not need to be running at gate time.

## Procedure

For each in-scope route, after the runtime-parity-checkpoint functional pass has confirmed the route renders:

1. **Capture matching routes.** Use the screenshot-capture skill to take full-size desktop captures of the same route on both the legacy reference and the modern shell. Include the parity-critical modal/dialog states the route owns.
2. **Diff computed styles against the contract.** Read the modern computed styles for the shell-chrome regions and representative controls and compare them to the contract for each dimension:
   - **Palette** — brand/header/primary-action/neutral-border/semantic colors resolve to the legacy palette as actually rendered (read the computed styles, not just the declared tokens): compare the computed header `background-color` and the computed brand/primary colors to the legacy contract. A raw default framework theme (an unbranded dark default surface where the legacy app is light and branded), a shell whose color scheme follows the OS `prefers-color-scheme` instead of the forced legacy scheme, or a legacy palette that exists only as orphan CSS custom properties no component reads, is a fail.
   - **Typography** — font family, weight scale, and label sizing match the legacy typography contract (including any `@font-face` families the legacy app shipped).
   - **Header / nav / footer presence** — the branded header region renders, the navigation region renders **every** link in the nav route model and each link navigates, and the footer chrome renders. An empty navigation region, a missing header, or a missing footer is a fail.
   - **Layout / density** — header/footer offsets, content max-width and padding, and control/row density match the contract closely enough to be recognizably the same screen. This includes the computed form-control sizing - input height, border, and label size: fields rendering at the framework default size/density instead of the legacy size are a density fail, not cosmetic drift.
3. **Diff screenshots against the reference.** Compare the modern capture to the legacy reference capture for the route. Reuse the canonical screenshot comparator at `tests/frontend/visualParity/run-visual-parity.mjs` for the pixel-level score rather than inventing a second comparator; this skill adds the dimension-level (palette/typography/chrome/layout) verdict on top of that score.
4. **Score the route.** Assign each route `pass`, `partial`, or `fail`:
   - `pass` — every dimension meets the contract.
   - `partial` — chrome and nav are present and the screen is recognizably the legacy screen, but one or more lower-priority style dimensions (for example exact spacing or a token shade) still drift.
   - `fail` — the navigation region is empty, the theme is the raw framework default, the header/footer chrome is missing, or the screen is not recognizably the legacy screen.

## Evidence Output

Write `.modernization/fusion-restructure/visual-parity-report.json` with at least:

- `generatedUtc`, `appName`, `legacyReferenceSource` (`runtime` or `captured-screenshots`), `modernClientUrl`, `legacyUrl` (or `null` when not runnable), `contractPath`, `stylingFoundationPath`.
- `routesCompared`: one entry per route with `{ route, legacyReference, modernCapture, palette, typography, headerPresence, navPresence, navLinksExpected, navLinksRendered, footerPresence, layoutDensity, screenshotMatchPercent, routeVerdict }` where each dimension is `pass | partial | fail` and `routeVerdict` is the route roll-up.
- Roll-ups: `paletteParity`, `typographyParity`, `chromeParity` (header + nav + footer), `layoutParity`, `routesPass`, `routesPartial`, `routesFail`, `overall`.
- `acceptedResidualGaps[]`: any explicitly accepted gap as `{ route, dimension, reason, acceptedBy, owningStep }`.

`overall` is `pass` only when every route is `pass`, or when every non-`pass` route is covered by an explicit entry in `acceptedResidualGaps[]` with a real reason. A route that is `fail` without an accepted residual-gap entry makes `overall` a `fail`.

## How A Step Uses This (gate placement)

- **Step 10 (apply)** builds the foundation this gate measures against: app-owned design tokens from the legacy palette/typography, the Fusion theme bound to those tokens, and the shell chrome (branded header, nav populated from the route inventory, footer, layout density). Step 10 already fails on an empty nav and must also fail on a raw default framework theme.
- **Step 13 (stabilize and gate)** runs this skill at closeout and saves `visual-parity-report.json`. Step 13 is not complete until `overall` is `pass` — meaning visual parity to the legacy answer key is met, or every residual gap is explicitly accepted with reasons. Visual parity (does it **look** like legacy) is distinct from field parity (does it expose the **same fields, columns, and controls** as legacy): a route can pass palette/typography/chrome while a grid has silently dropped columns or a control's handler is stubbed. Step 13 requires **both** — this visual gate `pass` **and** the runtime-parity-checkpoint `fieldParity` roll-up `pass` — before Step 14 begins.
- **Step 14 (entry discipline)** must not begin the map-and-swap block until a current `visual-parity-report.json` shows `overall: pass`. Beginning Fusion primitive swapping while the modern app still does not resemble the legacy app bakes the visual gap into every later slice.
- On `fail`, follow the owning step's blocker-to-completion guidance: fix the token, theme-binding, chrome, or layout defect and re-run this gate before advancing. Do not advance a failing visual-parity gate, and do not silently downgrade a `fail` route to an accepted gap without a recorded reason and owner.

## Cleanup

When the gate is finished and the apps no longer need to run, stop the modern runtime the same way runtime-parity-checkpoint does, and stop the separate legacy runtime started for the dual-port comparison.
