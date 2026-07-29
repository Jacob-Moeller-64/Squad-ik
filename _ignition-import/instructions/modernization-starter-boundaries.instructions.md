---
description: Canonical guardrails for LegacyCode-to-src Fusion restructures. Defines protected starter control points, editable seams, and the required ownership model for config, auth, HTTP, and styling.
applyTo: '**/Program.cs, **/DependencyInjection.cs, **/Extensions/*.cs, **/appsettings*.json, **/main.ts, **/app.config.ts, **/fusion.config*.ts, **/routes.config.ts, **/styles.*, **/angular.json, **/package.json, .github/agents/OpX-Fusion*.md, .github/skills/architecture-structure/SKILL.md, .github/skills/fusion-ui-component-upgrade/SKILL.md'
---

# Modernization Starter Boundaries

Use this file for any modernization work that moves code from `LegacyCode/` into `src/<AppName>.*`.

This is the canonical guardrail file for restructure. Agents, prompts, skills, and path-scoped instructions should defer to this file instead of restating competing rules.

## Source of truth

When guidance overlaps, use this order:

1. `constitution.md`
2. `.github/copilot-instructions.md`
3. this file
4. the active starter-derived files under `src/`
5. workflow-specific prompts, skills, and agents

The current repo starter shell under `src/` is the implementation source of truth for Fusion-owned platform behavior.

For Fusion package discovery and framework capability checks during restructure, also read `/.github/instructions/fusion-mcp-restructure.instructions.md` and use the Fusion MCP docs/package catalog before inventing app-owned platform solutions.

When restructure work adds or upgrades Fusion dependencies, use the latest production version available from Sonatype feeds for NuGet (`Fusion.*`) and npm (`@fusion/*`) packages.

Reference-only inputs:

- Fusion MCP docs and package catalog via the `fusion-fusion_api_docs_*`, `fusion-fusion_docs_*`, and `fusion-fusion_framework_docs_*` tools
- `Framework/docs/**` and `Framework/src/node/copilot/**`
- `SimpleArchitectureExample/**`, when present

Those references may inform package selection, route patterns, or UI mapping, but no modernization workflow may depend on them existing.

## Workflow continuation semantics

- In restructure execution, user directions such as `continue`, `proceed`, `resume`, or `keep going` mean approval to keep advancing through the next eligible handoff steps or slices in order.
- Do not stop merely because one sub-slice or one handoff completed if another eligible handoff remains and no required gate has failed.
- Stop only for a real unresolved blocker, a required user decision, an explicit workflow checkpoint or validation gate that failed, or completion of the approved lane.
- When stopping, record the exact blocker or failed gate plus the next eligible handoff so another developer can resume without re-discovery.

## Non-negotiable boundaries

- Do not move or transplant code from `Framework/**` into `src/` unless the task explicitly targets framework internals.
- Do not treat `SimpleArchitectureExample/**` as required input, a code donor, or a second starter shell.
- Do not rewrite protected starter control points just because the legacy app used a different auth, logging, Swagger, or bootstrap approach.
- Do not invent a parallel platform stack when Fusion already provides the platform concern.

## Ownership model

Classify every significant concern before editing:

- **App-owned**: business logic, DTOs, controllers, feature services, client pages/components/services, route behavior, app-specific config, legacy styling and layout contracts needed for parity
- **Fusion-owned final state**: host/bootstrap, Okta conventions, OpenAPI or Scalar surface, logging stack, platform middleware, client bootstrap, Fusion config wiring, protected API auth path
- **Temporary bridge**: legacy compatibility retained briefly for parity while a slice is proven
- **Banned final state**: patterns disallowed by repo policy or target-state Fusion guidance

If a concern is Fusion-owned in the final state, the default move is to map legacy behavior onto the starter shell, not to recreate the legacy implementation inside it.

## Protected starter control points

Protect these files by role even when names vary across starter versions:

- API host entry point: `src/<AppName>.Web.Api/Program.cs`
- API platform composition seam: `src/<AppName>.Web.Api/Extensions/FusionWebBuilderExtensions.cs`
- Library platform composition seam: `src/<AppName>.Library/Extensions/FusionApplicationBuilderExtensions.cs` or `src/<AppName>.Library/DependencyInjection.cs`
- Client bootstrap entry point: `src/<AppName>.Web.Client/src/main.ts`
- Client provider and auth shell: `src/<AppName>.Web.Client/src/app/app.config.ts`
- Client Fusion environment config: `src/<AppName>.Web.Client/src/app/fusion.config*.ts`

Default rule: do not broadly rewrite these files.

Allowed edits in protected control points must stay narrow and starter-aligned:

- app identity rebinding
- base URL and environment value rebinding
- centralized DI registration for newly moved app-owned services
- one approved connection-string composition seam
- starter-version-aligned config value replacement already recorded in the migration plan

If a change would replace or duplicate the starter's provider graph, auth wiring, middleware order, logging bootstrap, or client bootstrap contract, stop and record the exception before editing.

## Editable app-owned seams

These are the normal move targets during restructure:

- `src/<AppName>.Web.Api/Controllers/**`
- `src/<AppName>.Web.Api/DTOs/**`
- `src/<AppName>.Web.Api/Models/**`
- `src/<AppName>.Web.Api/Auth/**` or `Security/**` for app-owned evaluators and handlers
- `src/<AppName>.Library/**` except the protected platform composition seam
- `src/<AppName>.Web.Client/src/app/pages/**`
- `src/<AppName>.Web.Client/src/app/components/**`
- `src/<AppName>.Web.Client/src/app/services/**`
- `src/<AppName>.Web.Client/src/app/routes.config.ts`
- `src/<AppName>.Web.Client/src/styles.*`
- `src/<AppName>.Web.Client/src/assets/**`

## Guarded files

These files may be edited, but only while preserving the starter shape:

- `src/<AppName>.Web.Api/appsettings*.json`
- `src/<AppName>.Web.Client/angular.json`
- `src/<AppName>.Web.Client/package.json`
- app `Dockerfile`, `nginx.conf`, `default.conf`, and build scripts

Guarded-file rules:

- preserve the existing starter section shape and ownership boundaries
- add app values, assets, include paths, routes, and scripts without replacing the platform contract
- do not add a competing auth/bootstrap stack
- do not treat a sample app's file contents as the desired target by default

## Configuration ownership rules

Platform-owned concerns must end in Fusion-native sections or `ConnectionStrings`, not parallel legacy top-level shapes:

- auth and identity providers
- roles and policies
- logging
- CORS
- OpenAPI or Scalar
- platform middleware settings
- required connection strings

App-owned settings remain outside those areas only when they are genuinely application-specific, such as feature options, static-file paths, or business configuration.

If deployment inputs arrive as split database values, compose the final connection string once in a startup-bound seam. Do not teach repositories, services, or controllers to read raw deployment inputs directly.

Default assumption for modernization planning and hardening (unless app evidence says otherwise): deployment follows the OpenShift/Kubernetes split SQL environment-variable pattern and the backend composes a `ConnectionStrings` value at startup from `SqlServer__Server`, `SqlServer__Database`, `SqlServer__Username`, `SqlServer__Password`, `SqlServer__Encrypt`, and `SqlServer__TrustServerCertificate`.

Environment-specific files such as `appsettings.Development.json` should override values, not redefine the platform shape.

Before declaring backend configuration complete, prove that the current runtime resolves a working required connection string for the moved app-owned data path. If runtime verification shows a local default, starter placeholder, wrong server or database, or a SQL connectivity/login failure, stop and ask the user for the authoritative connection string or split database inputs for that environment instead of guessing replacements from sample apps or legacy defaults.

## Auth and authorization rules

- Okta is the required final-state auth model unless higher-precedence repo policy says otherwise.
- Use policy-based authorization only. Do not introduce `User.IsInRole(...)` checks or `[Authorize(Roles = ...)]`.
- App-owned current-user endpoints, security helpers, authorization handlers, and protected policies must share the same membership evaluator or source.
- Do not leave raw-claim-only exact group matching as the final state when Fusion-aligned user-profile memberships or group-name normalization are required for parity.
- Do not author new `AddAuthentication(...)`, `AddJwtBearer(...)`, custom Swagger bootstrapping, or ad hoc auth middleware from memory when the starter shell already owns that concern.
- Resolve auth/platform changes through the protected starter control points already present in the repo.

Before declaring backend auth complete, obtain the authoritative Okta/AD group identifiers or equivalent role-source inputs the project expects for at least `User` and `Admin`, and any app-specific policy roles such as `TestAdmin`, when those identifiers are not already proven by repo evidence. Use the user-facing question flow to request those values rather than inferring them from sample apps, stale defaults, or unrelated legacy environments.

If a valid bearer token reaches the API but protected endpoints return 403, treat that as a required role-mapping input gap until proven otherwise: inspect the configured role mappings, compare them to repo evidence and runtime behavior, then ask the user for the correct group identifiers or membership source before closing the verification gate.

## Backend consumer-parity rules

- Backend sign-off requires consumer-complete route parity, not just build, startup, auth, and OpenAPI health.
- Before declaring a backend move or backend verification complete, inventory every frontend-consumed and downstream-consumed endpoint family that the app still relies on, including collection or list, detail, create, update, delete, export or download, and current-user or bootstrap routes.
- Prove each consumed endpoint family exists on the target backend under `src/<AppName>.Web.Api` and that the corresponding target-side library service or query or command support exists under `src/<AppName>.Library`, unless an explicit temporary bridge is recorded.
- Do not treat a controller family as migrated if only the detail-by-id route exists while the migrated frontend or other consumers still call collection or list routes.
- Before any frontend handoff proceeds, verify the migrated frontend's `/api/...` contract against the target backend and stop if any consumer-used route family would still 404, return the wrong shape, or depend on legacy-only implementation.
- For backend verification, run live route smoke that proves at least one representative endpoint per consumer-used route family reaches the target backend with the expected auth or status behavior; a non-404 proof is required even when authenticated business data cannot be fully exercised in the current environment.

## Client HTTP ownership rules

- For protected browser API traffic, the default final-state path is `FusionHttpService`.
- An app-owned bearer-token interceptor is allowed only when the plan explicitly approves it.
- Plain Angular `HttpClient` usage for protected `/api` requests is Temporary bridge only until bearer-token injection is proven.
- Do not assume `HttpClient` automatically receives bearer tokens just because `provideNgxFusionAuthOAuthOkta()` exists. Prove the request path and API base URL alignment.
- Preserve the starter-owned auth provider graph in `app.config.ts`. Do not replace it with a parallel client auth stack.

## Styling and UI migration rules

- The initial move into `src/<AppName>.Web.Client` is a parity move, not a redesign.
- `Complete Frontend Migration` means the app-owned frontend has been restructured into `src/<AppName>.Web.Client` while the preserved legacy styling contract still renders closely enough for parity on representative migrated routes.
- Preserve the stylesheet stack, partial import order, assets, fonts/icons, host/body classes, layout wrappers, shared selectors, utility classes, DOM/class contract, and component sizing or density rules needed for usability.
- Do not let starter sample styling become the default visual result of the move.
- Theme auth partials must match the active auth strategy.
- Broad Fusion component replacement belongs in the later UI-integration phase after the moved UI is stable inside the starter shell.

## Validation gates

- A clean build alone is not enough for routes still using temporary UI bridges.
- Protected API requests must be proven to send bearer tokens through the approved path before a frontend slice is complete.
- Do not mark `Complete Frontend Migration` done until at least one representative migrated route or frontend slice proves both target-client ownership and preserved legacy-style parity: the route is served from `src/<AppName>.Web.Client`, renders past loading, and still uses the carried-forward legacy stylesheet stack rather than falling back to starter-default styling.
- Do not mark `Stabilize Frontend In Fusion Shell` done until representative migrated routes also prove page-top shell parity inside the Fusion shell: fixed-header offset is preserved, the route title and top action row are visible on first paint, and top-of-page filters or buttons are not clipped or hidden beneath shell chrome.
- Backend sign-off requires consumer-complete route parity: every frontend-consumed or downstream-consumed collection, detail, write, export, and current-user route family must exist in `src` or be explicitly recorded as a temporary bridge before frontend work advances.
- Backend verification must include live proof that representative consumer-used route families do not 404 on the target backend; build, startup, auth, and OpenAPI success alone are insufficient.
- Role projection and protected endpoint authorization must be proven against the same membership source before a backend auth slice is complete.
- Database-backed runtime behavior must be proven against a working required connection string before a backend config slice is complete. Build success alone is not evidence that the configured database target is correct.
- Do not treat `.modernization\ignition-artifacts\modernize\fusion-restructure\ui-inventory.json` and `ui-fusion-map.json` alone as proof of UI-swap completion. Maintain `.modernization\ignition-artifacts\modernize\fusion-restructure\ui-component-map.json` as the component-level inventory and swap map.
- After each step-15 UI slice build, run `Push-Location src\<AppName>.Web.Client; npm run verify:fusion-ui; Pop-Location` so the repo writes an updated `.modernization\ignition-artifacts\modernize\fusion-restructure\ui-verification-report.json` from the current source files.
- Before marking `Apply Fusion UI Integration` or `Final Verification` complete, run `Push-Location src\<AppName>.Web.Client; npm run verify:fusion-ui:complete; Pop-Location`. If it still reports temporary bridges or legacy indicators for claimed Fusion-complete families, keep the handoff open or record the remaining bridges explicitly.
- A route is not Fusion-complete just because `<fusion-...>` tags exist in source. Runtime smoke must still prove the Fusion theme/styling contract is actually applied and the route is not visually falling back to legacy/native rendering.

## When in doubt

Prefer the current repo starter shell, this boundaries file, and the restructure workflow artifacts over Framework internals, sample apps, or generic code snippets.
