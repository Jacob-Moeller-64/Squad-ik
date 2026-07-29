---
name: browser-source-decomposition
description: Use this skill when Step 12 or adjacent browser-led modernization work must classify the legacy browser source shape, decide which decomposition contract or contracts are required, and keep mixed, hybrid, static, or validate-only cases on one generic reusable surface.
---

# Browser Source Decomposition

This skill is the shared Copilot entrypoint for deciding how a legacy browser surface should decompose into the approved target browser client during Step 12 and the adjacent Step 13 through Step 15 browser lanes.

Use it to keep browser-source routing generic across MVC, Razor, Angular, AngularJS, Fusion G1, static document flows, and mixed or hybrid applications without reviving a second frontend lane.

## Read These Sources First

Read these sources before choosing a decomposition path or refreshing a decomposition contract:

1. `/.github/instructions/AppMod-Process.instructions.md`
2. `/.github/skills/architecture-structure/Architecture-Structure.md`
3. `.modernization/ignition-artifacts/modernize/fusion-restructure/decisions.json`
4. `.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`
5. The current Step 5 legacy-system-analysis evidence, especially route, workflow, screenshot, and marker-file outputs
6. The current Step 7 modernization solution design and migration plan
7. The current target browser root under `src/<AppName>.Web.Client` when it already exists
8. The source-specific decomposition prompts when classification requires them:
   - `/.github/prompts/P2-Modernize/mvc-to-browser-client.prompt.md`
   - `/.github/prompts/P2-Modernize/angular-to-browser-client.prompt.md`

When the source shows Fusion G1 recognition signals, also read `/.github/skills/fusion-g1-to-g2-modernization/SKILL.md` before closing the classification.

## Use This Skill When

Use this skill when the work involves any of the following:

- choosing the correct browser-source path during Step 12
- deciding whether one contract, both contracts, or validate-only posture is required
- classifying MVC, Razor, `.cshtml`, Angular, AngularJS, Fusion G1, or static browser sources
- deciding how to handle mixed or hybrid browser evidence such as server-rendered shells plus SPA islands
- deciding whether an already-present target browser shell should be regenerated or only validated
- recording unsupported secondary edges without inventing a one-off lane

Do not use this skill as a substitute for the source-specific contract prompts themselves. This skill decides which contract posture is required; the contract prompts produce the decomposition artifacts.

## Non-Negotiables

- Do not equate the source framework with the target-state framework.
- Do not treat Angular as the goal just because Angular appears in the current source or target.
- Do not force mixed or hybrid apps through only one contract when current evidence proves multiple active browser shapes.
- Do not skip decomposition-contract refresh when Step 5 or Step 7 evidence contradicts the current contract.
- Do not invent a new stack-specific frontend lane beyond the approved MVC-to-browser-client path, Angular-to-browser-client path, or an explicit validate-only or proof-only posture.
- When `browserSurfaceApplicability` is `NotApplicable`, return a lightweight proof decision instead of pretending browser decomposition still owns hidden work.
- When Fusion G1 patterns are present, treat that as a browser-led SPA path with extra verification requirements from the Fusion G1 skill.

## Classification Sequence

Follow this sequence in order:

1. Confirm `browserSurfaceApplicability` from Step 7.
2. Inventory all active browser-source families from Step 5 code markers, runtime evidence, and route ownership.
3. Identify the dominant execution model: server-rendered navigation, browser-led SPA routing, mixed or hybrid composition, static document flow, already-modern shell, or proof-only.
4. Confirm the approved destination browser root and protected control points from Step 7.
5. Decide which decomposition contract or contracts must be current before Step 12 can close.
6. Record the primary path, any secondary paths, unsupported edges, validate-only reasons, and exact Step 12 or Step 13 handoff impact.

## Source-Shape Decision Matrix

| Source shape | Recognition signals | Required contract posture | Notes |
| --- | --- | --- | --- |
| Server-rendered browser app | MVC controllers plus views, Razor Pages, `.cshtml` partials, server-owned routes, form posts, server-side tab or popup flows | Refresh `mvc-to-browser-client` when missing, stale, or contradicted | Treat view-hosted business or validation logic as extraction work, not as permanent client ownership. |
| Browser-led SPA | Angular, AngularJS, client-side routers, SPA bootstrap, feature modules, view-model JavaScript, browser-owned state transitions | Refresh `angular-to-browser-client` when missing, stale, or contradicted | Includes AngularJS and other browser-led SPA families even when the final target remains the approved Step 7 browser client. |
| Fusion G1 browser app | Knockout, RequireJS or AMD, Durandal patterns, legacy `<fusion-*>` controls, Fusion G1 services | Refresh `angular-to-browser-client` and apply the Fusion G1 skill before closing the classification | Fusion G1 is a browser-led SPA path with stricter translation and verification rules. |
| Mixed or hybrid browser surface | Server-rendered shell plus SPA islands, partial views plus browser routing, static pages plus embedded app widgets | Refresh whichever contracts cover the active shapes, often both | Return one primary path, explicit secondary paths, and the exact feature or route families that follow each contract. |
| Static document flow | Mostly static HTML, form posts, thin JavaScript helpers, no durable client router | Usually `mvc-to-browser-client`, unless runtime evidence proves hybrid or proof-only is more accurate | Choose based on route ownership and where behavior actually lives, not on file extension alone. |
| Already-modern shell | Approved target browser root already exists and still matches Step 7 | Validate-only or delta-only; refresh the relevant contract only when evidence drift exists | Preserve current shell structure and close the highest-value scaffold gaps instead of regenerating from scratch. |
| Browser not applicable | `browserSurfaceApplicability = NotApplicable` | No Path A contract required; publish proof-only reasoning | Steps 10 through 13 still return lightweight proof, not silence. |

## Contract Refresh Rules

- If the source is server-rendered, refresh `/.github/prompts/P2-Modernize/mvc-to-browser-client.prompt.md` before Step 12 closes unless the existing MVC contract is current and consistent with Step 5 and Step 7.
- If the source is browser-led SPA, refresh `/.github/prompts/P2-Modernize/angular-to-browser-client.prompt.md` before Step 12 closes unless the existing SPA contract is current and consistent with Step 5 and Step 7.
- If the source is mixed or hybrid, run whichever contract prompts are required to cover the active source families, then reconcile them into one Step 12 returned-data summary instead of creating a custom third lane.
- If the source is already-modern or validate-only, preserve the existing shell and refresh only the stale or contradicted contract evidence.
- If the source is static or ambiguous, choose the primary path by runtime ownership: server-owned navigation generally maps to MVC-to-browser-client, while client-owned routing and state generally map to Angular-to-browser-client.

## Required Returned Data

When this skill is used, the Step 12 response or the decomposition-routing note should explicitly return these facts:

- `browserSurfaceApplicability`
- `browserSourceFamilies`
- `primaryDecompositionPath`
- `secondaryDecompositionPaths`
- `requiredContracts`
- `contractRefreshActions`
- `approvedBrowserRoot`
- `validateOnlyReason` when applicable
- `unsupportedSecondaryEdges`
- `exactNextStep`

## Step Ownership Guardrail

- Step 12 owns source classification, decomposition-contract currency, styling foundation, shell formation, and shell-level proof.
- Step 13 owns route-family and shared-client migration after the Step 12 shell is trustworthy enough to carry feature behavior.
- Do not hide Step 13 migration inside Step 12 just because Step 12 needed a deeper decomposition pass.
