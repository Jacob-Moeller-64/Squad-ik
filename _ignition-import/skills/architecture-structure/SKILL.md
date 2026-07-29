---
name: architecture-structure
description: Use this skill when planning or executing modernization formation work that moves modernized code from `LegacyCode/` into the target architecture under `src/<AppName>.*`.
---

# Architecture Structure

This skill explains how to use `/.github/skills/architecture-structure/Architecture-Structure.md` as the source of truth for the target folder and project shape during modernization formation.

Use this skill when an agent needs to classify code into the target architecture, decide where files belong, or move code from `LegacyCode/` into `src/<AppName>.*` in a controlled way.

## Source of Truth

Read these files first:

1. `/.github/skills/architecture-structure/Architecture-Structure.md`
2. `/.github/instructions/modernization-starter-boundaries.instructions.md`
3. `/.github/instructions/fusion-mcp-restructure.instructions.md`
4. `/.github/instructions/AppMod-Process.instructions.md`
5. `/.modernization/.readme/kit-params.md`
6. The active restructure workflow or task instructions

Before inventing or approving any Fusion-aligned platform, package, startup, auth, HTTP, data, logging, caching, or UI solution during restructure, check the Fusion MCP package/docs tools first.

When a restructure slice adds or upgrades Fusion dependencies, use the latest production version available in Sonatype feeds for both NuGet (`Fusion.*`) and npm (`@fusion/*`) packages.

When a repo-local `Framework/` folder exists, also use these as supplemental reference-only inputs:

6. `/Framework/docs/README.md`
7. `/Framework/docs/framework.map.md`
8. `/Framework/docs/architecture.md`
9. `/Framework/src/node/copilot/README.md`

If those sources disagree, prefer the repo-specific architecture documents over generic examples, prefer the current workflow instructions over older notes, and treat `Framework/` docs as package/template references rather than as the source of truth for app-specific behavior.
If `SimpleArchitectureExample/` exists, treat it as optional reference-only evidence rather than a prerequisite for restructure.

## When to Use This Skill

Use this skill when the work involves any of the following:

- mapping legacy files to the destination structure under `src/`
- moving backend or frontend files during modernization formation
- deciding whether a file belongs in API, Library, Application, Infrastructure, Domain, or test projects
- validating that moved files follow the intended target tree
- updating prompts or agents that describe modernization formation work

Do not use this skill as the main source for early-phase baseline work that stays inside `LegacyCode/`.
Do not use this skill as the primary workflow for the later route-level Fusion component-upgrade phase. For step-15 style work that replaces stabilized route controls with Fusion primitives, prefer `/.github/skills/fusion-ui-component-upgrade/SKILL.md` when that skill exists in the active tree; otherwise follow the equivalent repo-local Fusion UI component-upgrade guidance.

## Process Placement

The modernization formation phase happens after early modernization work has already been completed in `LegacyCode/`.

Use `/.github/instructions/AppMod-Process.instructions.md` for the shared phase ordering. Do not restate or reinterpret the full modernization sequence unless the local task truly requires it.

Do not describe modernization formation as the first modernization step.

For frontend work, treat these as separate phases rather than one combined change:

1. structural move into the starter-derived client shell
2. platform integration for Fusion-owned concerns such as auth, HTTP wiring, config, and bootstrap ownership
3. frontend stabilization inside the Fusion shell and theme
4. deliberate Fusion UI component adoption by primitive family

For phase 4, prefer `/.github/skills/fusion-ui-component-upgrade/SKILL.md` when that skill exists in the active tree so the route-level primitive swaps use one consistent slice order, validation loop, and artifact-update pattern. When it does not exist, follow the equivalent repo-local Fusion UI component-upgrade guidance instead.

## General Rules

- Move code in small, testable functional slices.
- Keep parity first: preserve behavior while changing structure.
- When a lesson from one app should influence the kit, capture the portable restructuring rule in behavior-family or artifact-family terms and keep app-specific decisions in the app execution addendum rather than in the shared skill text.
- Use the existing starter-derived files in `src/` as the destination-side reference for project layout, configuration style, and scaffolding.
- Use Fusion MCP package discovery and API/docs lookups as the first reference surface for what Fusion already provides before creating app-owned platform code or workaround wrappers.
- When a local `Framework/` folder is present, use its docs as secondary evidence for Fusion package capabilities, startup composition, and template patterns, but do not let it override repo-specific app behavior or starter-shell ownership.
- Classify each legacy concern before moving it: app-owned, Fusion-owned final state, temporary bridge, or banned final state.
- Do not blindly copy the legacy folder layout into `src/`.
- Do not invent new top-level projects or folders unless the architecture source of truth requires them.
- Do not move or transplant files from `Framework/` into `src/` unless the task explicitly targets framework internals rather than app restructure.
- Keep tests runnable as slices move.
- Let target ownership drive test placement. Do not let an opaque legacy test-suite name become the primary reason a moved file lands in a particular destination folder.
- If legacy tests do not map cleanly to the destination structure and the workflow will generate fresh target-aligned tests anyway, prefer documenting that gap over force-fitting the old suite layout into the new tree.
- Prefer updating namespaces, references, and paths as part of each slice rather than deferring all fixes to the end.
- Treat configuration as a first-class migration concern: inventory appsettings/appsettings.* sections and environment-variable inputs, classify each as app-owned, Fusion-owned final state, temporary bridge, or banned final state, and record the final-state section that should own it.
- When a legacy top-level config section duplicates a Fusion-owned concern such as auth, roles, policies, identity providers, logging, CORS, OpenAPI, or connection strings, re-home that concern into Fusion-native sections or `ConnectionStrings` instead of preserving the legacy section name as the final state.
- If deployment inputs provide split database values such as server, database, username, password, encrypt, or trust-certificate flags rather than a ready-made connection string, add one centralized startup-bound composition seam that materializes the required `ConnectionStrings` entry; do not teach feature code to read those raw inputs directly.
- During restructure, treat missing connection-string truth as a required input gap rather than something to guess. If runtime verification shows the moved app is still resolving a local default, starter placeholder, wrong database target, or a SQL connectivity/login failure, ask the user for the authoritative environment connection string or split database inputs before marking backend configuration complete.
- When classifying an ambiguous legacy folder, use usage evidence from controllers, services, repositories, DI wiring, and tests rather than relying on the folder name alone.
- When a slice moves DI-managed types, update the existing starter DI registration points in `*.Library/Extensions/`, `*.Library/DependencyInjection.cs`, `*.Web.Api/Extensions/`, `*.Web.Api/DependencyInjection.cs`, or the active API startup files so the moved slice still resolves correctly.
- For backend apps using Fusion Okta auth, treat app-owned authorization as a first-class migration concern: inventory any current-user endpoint, security helper, authorization handler, policy evaluator, and role or group config section that participates in app authorization.
- If app-owned authorization needs memberships beyond raw principal claims, align it to Fusion user-profile services or another approved Fusion-aligned membership source during restructure rather than assuming appsettings-only changes will fix role resolution.
- When a custom authorization handler depends on a per-request service such as `IUserProfileService`, register it through the starter DI extension points with a lifetime compatible with that dependency instead of leaving a default singleton registration in place by accident.
- Treat required role-group identifiers as an explicit project input. If the repo does not already prove the authoritative Okta/AD groups for `User`, `Admin`, or app-specific policies, ask the user for those values and record them before closing backend auth verification.
- If a bearer token produces `403` instead of `401` during verification, assume authentication may be working while role mapping is still unresolved; inspect the configured role mappings, compare against runtime behavior, and ask the user for the correct group identifiers rather than inferring them from `SimpleArchitectureExample` or unrelated apps.
- For frontend restructure, treat legacy styling as a first-class migration concern: inventory global style entry points, stylePreprocessor include paths, Bootstrap or SCSS partial order, route/component styles, assets, fonts/icons, host/body classes, shell/layout CSS, shared selectors, shared utility classes, and measurable sizing rules that the app depends on for usability.
- During the initial move into `src/<AppName>.Web.Client`, preserve the legacy visual contract closely enough for parity by carrying forward the stylesheet stack, shared utility classes, component sizing and density rules, assets, and DOM or class contract before any later Fusion component swap. The legacy visual contract (theme palette, typography, header/nav/footer chrome, and the nav route model) is the answer key captured in `.modernization/fusion-restructure/styling-foundation.json` and `ui-visual-contract.json`; the modern shell must inherit it by construction and pass the dedicated visual-parity gate (`/.github/skills/visual-parity-gate/SKILL.md`) before deliberate Fusion primitive replacement begins.
- For Angular clients using Fusion Okta auth, treat authenticated HTTP ownership as a first-class migration concern: every protected API path must be proven to use Fusion's auth-aware HTTP path or an explicitly approved app-owned bearer-token interceptor before the frontend slice is considered complete.
- For frontend temporary bridges such as AG Grid, Bootstrap or ng-bootstrap widgets, legacy dialog shells, or app-owned route infrastructure, require a route-level runtime smoke in addition to the build. A green compile is not enough to prove the bridge actually instantiates inside the migrated shell.
- During the first frontend move, compare the legacy client API contract to the migrated backend route surface before closing the slice. If legacy startup or page services still call `/api/...` endpoints, preserve that route contract on the migrated backend or rebind the client in the same slice instead of assuming later handoffs will absorb the drift.
- Do not treat a moved frontend as complete until its first required bootstrap API call returns the expected JSON shape and the first migrated route renders past loading state inside the starter shell.
- Do not combine the first frontend move into `src/<AppName>.Web.Client` with broad Fusion UI component replacement. First make the moved app work inside the starter shell, then stabilize the UI, then replace primitive families deliberately.
- Treat high-risk widgets such as grids, charts, heavily customized tables, and composite forms as dedicated UI migration slices with their own parity checks instead of incidental cleanup during the initial move.
- When executing restructure rather than merely planning it, treat user directions such as `continue`, `proceed`, `resume`, or `keep going` as approval to keep advancing through the next eligible restructure slices and handoffs until a real blocker, failed gate, required user decision, or workflow completion is reached.

## Fusion Ownership Categories

Use the categories below to decide how a legacy concern should be handled during restructure:

- **App-owned**
  - business rules, entities, DTOs, feature logic, controllers, page behavior, client services, and reusable UI components
  - move these concerns into the destination architecture under `src/<AppName>.*`
  - app-specific configuration such as spec-book or static-file paths, business feature options, and other settings that do not already belong to a Fusion-owned platform contract also remain app-owned
  - legacy global styles, route or component styles, assets, fonts or icons, shell or layout selectors, shared utility classes, DOM or class contracts, and component sizing or density rules needed to keep the moved UI usable are also app-owned during restructure unless the plan explicitly classifies them otherwise
- **Fusion-owned final state**
  - hosting or bootstrap, Okta auth conventions, API documentation surface, logging stack, caching, platform middleware, client bootstrap, and Fusion config wiring
  - platform-owned configuration sections for auth, roles, policies, identity providers, logging, CORS, OpenAPI, and required `ConnectionStrings` resolution belong here as well
  - do not recreate legacy implementations of these concerns inside the starter shell by default; align them to the starter-derived target structure
- **Temporary bridge**
  - legacy auth, legacy Swagger wiring, old middleware, or compatibility adapters that are temporarily needed to preserve parity while a slice is being moved
  - keep these isolated, minimal, and documented for later removal
- **Banned final state**
  - patterns disallowed by repo instructions, security requirements, or target-state Fusion guidance

If a concern is Fusion-owned in the final state, the default goal during restructure is to map the legacy behavior onto the existing starter shell, not to transplant the legacy implementation wholesale.

App-owned authorization surfaces may remain app-owned after restructure, but their identity and membership source must align to the Fusion-owned final-state auth conventions rather than drifting onto a separate claim-only path.

## Protected Starter Shell

Preserve the destination-side starter shell by default. During restructure, do not broadly rewrite these files unless the active task explicitly requires a narrow Fusion-aligned update:

- `src/<AppName>.Web.Api/Program.cs`
- `src/<AppName>.Web.Api/Extensions/FusionWebBuilderExtensions.cs` or `src/<AppName>.Web.Api/DependencyInjection.cs`
- `src/<AppName>.Library/Extensions/FusionApplicationBuilderExtensions.cs` or `src/<AppName>.Library/DependencyInjection.cs`
- `src/<AppName>.Web.Client/src/main.ts`
- `src/<AppName>.Web.Client/src/app/app.config.ts`
- `src/<AppName>.Web.Client/src/app/fusion.config*.ts`

The expected move pattern is to replace starter sample business code and UI content while preserving the starter's framework shell for Fusion-provided concerns.

## Architecture Decision Rule

Do not make the architecture selection inside this skill.

Read `architectureStyle` from `/.modernization/.readme/kit-params.md`.

- If `architectureStyle` is missing, assume `simple`.
- Use `clean` only when it is explicitly selected.
- For this repo, treat the simple architecture as a collapsed form of clean architecture: domain, application, and infrastructure concerns are still present conceptually, but they are organized into a single `*.Library` project instead of being split into separate projects.

- **Simple Web App**
  - use when the app is relatively self-contained and does not need CQRS project separation
  - target projects usually center on `*.Web.Api` and `*.Library`
- **Clean Architecture**
  - use when the app has broader downstream consumers, more complex boundaries, or needs clear CQRS separation
  - target projects usually split into `*.Web.Api`, `*.Application`, `*.Infrastructure`, `*.Domain`, and tests

## File Mapping Guidance

### Backend

- **Controllers** -> `*.Web.Api/Controllers/`
- **Request DTOs bound from HTTP input models** -> `*.Web.Api/DTOs/Requests/`
- **Response DTOs shaped for the UI/API** -> `*.Web.Api/DTOs/Responses/`
- **Validators for API request models** -> `*.Web.Api/Validation/`
- **Middleware** -> `*.Web.Api/Middleware/` when the target architecture includes it
- **API auth handlers and security helpers** -> `*.Web.Api/Auth/` or `*.Web.Api/Security/`
- **Current-user role projection endpoints and shared membership evaluators** -> keep them in `*.Web.Api/Controllers/` plus `*.Web.Api/Auth/` or `*.Web.Api/Security/`, but require them to share the same Fusion-aligned membership evaluator used by protected policies instead of duplicating claim-only logic
- **API filters** -> `*.Web.Api/Filters/`
- **API startup-bound configuration concerns** -> merge into the existing API host files and extension points in `*.Web.Api/Program.cs` and `*.Web.Api/Extensions/`; do not create a competing startup source of truth by default
- **Appsettings or config-section normalization for platform-owned concerns** -> re-home auth, policy, role, identity-provider, logging, CORS, OpenAPI, and connection-string concerns into Fusion-native sections or `ConnectionStrings` through the existing API host files and extension points; treat any legacy section kept temporarily as an explicit bridge with a removal plan
- **Connection-string composition from split deployment inputs** -> implement once in a startup-bound configuration seam that materializes `ConnectionStrings:<Name>` for downstream consumers; do not duplicate raw environment-variable reads in feature services or repositories
- **Legacy auth, legacy API-doc wiring, or legacy platform middleware retained only for parity** -> keep as temporary bridge code during restructure only when required, isolate it so it can be removed later, and replace it during the Fusion-integration step rather than treating it as the destination pattern
- **Entities, enums, and persistence-facing models**
  - simple app -> `*.Library/Models/Entities/`, `*.Library/Models/Enums/`, `*.Library/Models/ValueObjects/`, and `*.Library/Models/Models/` for intermediate non-persistence models
  - clean app -> `*.Domain/Entities/`, `*.Domain/Enums/`, or `*.Domain/ValueObjects/`
- **Existing legacy command/query classes in this repo's simple architecture** -> preserve their current CQRS-style grouping under `*.Library/Models/Entities/Commands/` and `*.Library/Models/Entities/Queries/` unless the active workflow explicitly defines a different destination
  - this is a repo-specific transition rule for legacy code that already uses command/query classes; do not interpret it as a requirement to introduce new CQRS layers into every simple app
- **Repositories, API clients, and external integrations**
  - simple app -> `*.Library/Data/Repositories/`, `*.Library/Data/Repositories/Context/`, `*.Library/Data/Repositories/Util/`, `*.Library/Data/APIs/`, `*.Library/Data/Services/`
  - clean app -> `*.Infrastructure/Repositories/`, `*.Infrastructure/APIs/`, `*.Infrastructure/Services/`
- **Feature/use-case logic**
  - simple app -> `*.Library/Features/<FeatureName>/`
  - clean app -> `*.Application/<FeatureName>/`
- **Feature service interfaces and implementations** -> keep them together under `*.Library/Features/<FeatureName>/` in simple architecture
- **Interfaces and contracts for implementation boundaries**
  - clean app -> usually `*.Domain/Interfaces/`
- **Obsolete legacy layers** -> do not move them by default when evidence such as `[Obsolete]` attributes and missing live references shows they are superseded; be cautious and require evidence before excluding files

### Frontend

Use the target client structure already present in the starter-derived web client. Map moved files into the destination structure rather than preserving a legacy Angular folder tree by default.

The starter-derived client is the source of truth for client-side structure and supporting files. Layer the legacy frontend into that structure.

When planning later Fusion UI adoption, local docs under `Framework/docs/` and `Framework/src/node/copilot/` are useful package-level references for choosing the right Fusion primitive or wrapper, but they do not replace the app's own parity evidence or the starter-derived client structure.

The first frontend move is a structural or parity move, not a full UI modernization pass. The goal is to keep the frontend working without destroying its styling while it lands inside the Fusion shell. Some visual drift may still occur, but the app should not be broadly restyled to the starter or Fusion look during this step. Treat `Complete Frontend Migration` as complete only when the app-owned frontend now lives under `src/<AppName>.Web.Client` and representative migrated routes still honor the preserved legacy styling contract rather than rendering with starter-default styling.

- preserve existing Fusion configuration files and supporting auth/logging scaffolding unless a workflow step explicitly addresses a conflict
- merge legacy app settings and configuration needs into the existing starter-derived files rather than replacing those files wholesale
- keep any temporary legacy auth or API-doc compatibility behavior out of the permanent client bootstrap when the starter already provides the final-state Fusion wiring
- default starter pages and example views may be removed once the legacy frontend has replaced them
- preserve or port the legacy stylesheet stack, stylePreprocessor include paths, Bootstrap or SCSS partial order, assets, fonts or icons, shared selectors, shared utility classes, and host or body classes required for route usability before attempting broad visual cleanup
- treat `src/styles.*`, app-owned component or route style files, client assets, and style-related `angular.json` entries as app-owned compatibility seams during the initial move unless the plan explicitly says otherwise
- if legacy CSS depends on specific markup, class names, Bootstrap utility classes, grid wrappers, or collection components, preserve that DOM or class contract during the move instead of rewriting the page into a new shell layout too early
- explicitly classify each protected API call path as one of: `FusionHttpService`, approved app-owned bearer-token interceptor, temporary bridge, or invalid final state
- plain Angular `HttpClient` usage for protected `/api` requests is not starter or Fusion-aligned by itself; it remains temporary bridge until bearer-token injection is explicitly handled
- when the app uses `provideNgxFusionAuthOAuthOkta()`, do not assume arbitrary Angular `HttpClient` calls will automatically receive bearer tokens; verify the actual request path used by migrated services

- page-level screens -> `src/app/pages/`
- reusable view components -> `src/app/components/`
- services -> `src/app/services/`
- guards/interceptors/auth helpers -> appropriate app subfolders already used by the target client
- environment or Fusion config wiring should align with the existing Fusion config files in the client starter

When planning the frontend move, use the following sequence:

- move pages, services, routes, state, app-owned components, and the minimum legacy styling and sizing stack needed for route usability into the starter-derived shell first
- stabilize the moved UI in the Fusion shell by fixing missing style imports, include paths, partial ordering, asset paths, host or body classes, selector breakage, theme drift, layout regressions, spacing issues, control heights, row densities, and global style conflicts
- build a UI inventory and map legacy primitives to Fusion-owned final-state components or approved wrappers
- replace primitive families such as buttons, form controls, dialogs, navigation, grids, and charts in deliberate slices after stabilization succeeds

During the first route that uses a temporary bridge family, add one explicit runtime proving check before calling the slice validated. Typical examples:

- AG Grid or shared grid wrappers: open the first migrated grid route and confirm the grid renders without module-registration or row-model runtime errors
- ng-bootstrap popovers, dialogs, or date pickers: open the route and exercise one representative control to catch runtime DI or template errors
- app-owned auth or HTTP bridges: open a protected route and confirm the expected API request succeeds with the required auth path
- startup bootstrap calls such as current-user or role-projection endpoints: open the app, confirm the first required API call resolves on the migrated backend using the preserved URL contract, and verify the shell renders past any loading gate
- fixed-header or projected-shell layouts: open a representative migrated route and confirm the page title, mode toggle or top action row, and first filter band render below the shell header instead of being clipped behind it

Record the route used for the runtime proving check in the modernization artifacts so later review can tell which bridge families were actually exercised.

During stabilization, temporary UI bridge wrappers are allowed. Temporary style bridges such as compatibility imports, wrapper classes, or retained legacy selectors are also allowed when needed to preserve usability. During UI adoption, prefer app-owned wrappers over one-off page-level overrides when a legacy API surface or visual contract must be preserved temporarily.

### Tests

- Use one repo-root testing workspace organized by execution surface first, then by target ownership inside that surface.
- Keep backend proof under `tests/backend/`.
- Inside `tests/backend/`, use `unit/`, `contractApi/`, and `integrationBackend/`, then mirror destination ownership boundaries when helpful, for example:
  - `Features/<FeatureName>/`
  - `Data/APIs/`
  - `Data/Repositories/`
  - `Data/Repositories/Context/`
  - `Data/Repositories/Util/`
  - `Data/Services/`
- Keep frontend proof under `tests/frontend/` using `angularUnitComponent/`, `integrationFrontend/`, `smoke/`, `e2e/`, and `visualParity/`.
- Keep whole-frontend navigation smoke under `tests/frontend/smoke/`, browser journey proof under `tests/frontend/e2e/journeys/`, and accessibility proof under `tests/frontend/e2e/accessibility/`.
- Keep modernization-only characterization evidence and reports under `tests/modernization/characterization/`.
- Only keep model-focused test folders when they still represent meaningful behavior after the move.
- Legacy suite names such as `ControllerTests`, `InputTests`, `StartupTests`, `CommandTests`, `QueryTests`, `RepositoryTests`, and `UtilTests` are transition clues, not target folder names.
- When a legacy suite has no strong destination mapping and fresh tests will be generated as part of the modernization workflow, do not force that suite into the new structure just to preserve its old shape.
- When fresh tests are still being created, prefer documenting ownership gaps over inventing project-named top-level test trees that fight the repo-root workspace contract.

## Move Strategy

Preferred slice order:

1. choose one small functional area
2. map its destination folders and project references
3. move the code
4. fix namespaces/imports/usings
5. run the smallest meaningful build/test check
6. record what moved and what remains

If the slice includes a frontend bridge family, insert a runtime smoke between steps 5 and 6:

5a. start the relevant app(s), open the first route that exercises the touched bridge, and check for uncaught browser-console errors before recording the slice complete

Examples of acceptable slices:

- one controller plus its DTOs and directly related service wiring
- one feature folder and its repository/service dependencies
- one test group retargeted from `LegacyCode/` to `src/`
- one frontend page with its immediate supporting services/components

Avoid moving the entire backend or frontend in one pass unless the workflow explicitly requires it and verification remains reliable.

When a handoff or slice completes cleanly and another ordered handoff is already eligible, continue directly into that next handoff instead of waiting for another prompt. Stop only when an explicit gate fails, a real blocker remains unresolved, or the workflow reaches its defined checkpoint.

## What Not to Do

- Do not move files before the in-place legacy upgrades and validations are complete.
- Do not treat `LegacyCode/` as the final destination.
- Do not overwrite destination starter scaffolding without first checking whether it should remain the source of truth.
- Do not force CQRS onto a simple app when the architecture guidance does not require it.
- Do not remove temporary bridge behavior too early if doing so would block parity verification during restructure.
- Do not leave temporary bridge behavior in place once the corresponding Fusion-owned implementation has been validated.
- Do not keep references, paths, or tests pointed at `LegacyCode/` once a slice has been intentionally moved to `src/`.
- Do not fuse or refactor large amounts of behavior at the same time you are still trying to prove the move itself works.
- Do not assume that registering `provideNgxFusionAuthOAuthOkta()` automatically secures arbitrary Angular `HttpClient` calls.
- Do not assume that changing role or group names in `appsettings.json` is sufficient when the app has custom current-user endpoints, security helpers, or authorization handlers.
- Do not mark a backend move complete just because the target API builds, starts, and serves OpenAPI when frontend-consumed or downstream-consumed route families are still missing from `src`.
- Do not leave current-user role projection and protected policy authorization reading from different membership sources after restructure.
- Do not rely on raw-claim-only exact matching when runtime memberships may come from Fusion user-profile services and may use a different qualified-versus-short-name shape than the configured values.
- Do not preserve a legacy appsettings section name for a platform-owned concern when the starter or Fusion target already provides a final-state config contract for that concern.
- Do not scatter raw `SqlServer:*` or similar split deployment inputs through feature services when the final-state consumer expects `ConnectionStrings:<Name>`; centralize that composition at startup instead.
- Do not mark a migrated frontend slice complete until authenticated `/api` calls have been verified to use Fusion auth-aware HTTP wiring or an explicitly approved app-owned bearer-token interceptor.
- Do not replace the legacy stylesheet stack with starter sample styling during the structural move into `src/<AppName>.Web.Client`.
- Do not rewrite page markup, grid structure, or shell structure in ways that break the legacy DOM or class contract, shared utility classes, or recorded component sizes before those styling dependencies have been inventoried and preserved.
- Do not treat matching colors alone as styling parity when spacing, control heights, row density, content widths, or breakpoint behavior have changed.
- Do not rebuild a legacy Bootstrap or grid-based page into a custom card or table layout during the initial move when that changes the recorded sizing or density contract.
- Do not treat initial Fusion theme drift or widget styling regressions as proof that the frontend move failed structurally; stabilize the shell first before deciding which UI primitives must be replaced.
- Do not replace broad UI primitive families during the same slice that first lands the frontend in the starter shell unless the legacy widget is completely unusable without the swap.
- Do not retire high-risk legacy widgets such as grids or charts until the Fusion replacement has explicit parity evidence for layout, sizing, interaction, and render behavior.

## Verification Checklist

After each modernization formation slice, verify the smallest relevant checks you can run:

- project references still point to the intended target projects
- namespaces/imports/usings reflect the new locations
- touched tests still compile and pass when the repo already has a runnable home for that scope; otherwise the exact missing test home or blocker is reported explicitly
- the move matches the target architecture document
- no accidental duplicate source of truth is created between `LegacyCode/` and `src/`
- runtime configuration resolves platform-owned concerns from the approved Fusion-native sections or `ConnectionStrings` instead of retired legacy top-level config shapes
- any required connection string that is fed by split deployment inputs is materialized by one centralized startup-bound seam and verified for the touched slice
- before backend sign-off, every frontend-consumed or downstream-consumed endpoint family for the moved scope is inventoried, including collection or list, detail, create, update, delete, export or download, and current-user or bootstrap routes
- before backend sign-off, each inventoried consumer-used endpoint family is proven to exist on the target backend under `src` or is explicitly recorded as a temporary bridge
- backend sign-off is blocked when only detail-by-id routes were moved but the migrated frontend or other consumers still depend on collection or list routes for the same feature family
- live verification for backend sign-off includes at least one representative non-404 route smoke per consumer-used endpoint family, plus expected auth or status behavior where full business execution cannot be exercised yet
- any moved DI registrations were re-homed into the target starter DI extension points or API startup files
- any temporary bridge retained for parity is explicitly identified, still necessary, and has a removal plan tied to the later Fusion-integration step
- before closing a major restructure handoff, the touched scope has been reviewed against Fusion MCP package/docs discovery plus the current starter shell to catch custom code that duplicates Fusion-owned capabilities
- app-owned current-user role projection endpoints and protected policies resolve roles from the same membership source and produce consistent results for the same authenticated user
- authenticated users with a mapped role can access at least one protected endpoint, and authenticated users without the required role receive `403` where appropriate
- when configured group identifiers and runtime memberships use different qualified-versus-short-name shapes, the normalization or comparison path is verified
- if custom authorization handlers depend on per-request services such as `IUserProfileService`, their DI lifetime is compatible and verified
- protected browser API requests have been verified to send `Authorization: Bearer ...` headers when the final state expects Fusion or Okta auth
- authenticated client API paths are proven to flow through `FusionHttpService` or an explicitly approved app-owned bearer-token interceptor instead of a silent `HttpClient` bypass
- the moved frontend still loads the legacy global styles, partial order, route or component styles, assets, fonts or icons, shared utility classes, and host or body classes required for usability
- before closing `Complete Frontend Migration`, at least one representative migrated route is proven to run from `src/<AppName>.Web.Client` and still render with the preserved legacy stylesheet stack and sizing contract rather than starter-default styling
- key routes remain visually usable after the move and are not unintentionally restyled to starter sample defaults before the later Fusion UI step
- any preserved DOM or class contract that styling depends on is explicitly recorded when it blocks an early markup rewrite
- touched routes still honor the recorded sizing and density contract closely enough for parity, including content widths, gutter spacing, control heights, table or grid row heights, dialog sizes, and breakpoint behavior
- after the frontend move, stabilized routes render correctly inside the Fusion shell before broad UI component-family replacement begins
- representative stabilized routes prove page-top shell parity, including visible route titles, action bars, first-row filters, and preserved fixed-header offset rather than hidden or clipped content
- UI primitive-family migrations record the visual contract they must preserve, especially spacing, sizing, typography, interaction states, and responsive behavior
- high-risk widgets such as grids and charts are verified in isolated slices before their legacy versions are retired

Before moving the frontend, ensure the backend move has reached its required verification checkpoint if the active workflow defines one.

## Output Style for Agents

When using this skill in prompts, plans, or agent responses:

- name the chosen architecture style explicitly
- state which source document justified the destination path
- describe the move in slices, not just in final-state terms
- call out any unresolved architecture questions as explicit follow-ups
- keep path examples generic with `<AppName>` unless app-specific documentation is explicitly requested
- when classifying an ambiguous legacy folder such as `Inputs/`, `Views/`, or an unexpectedly named `Util/` area, include the evidence used to classify it, such as controller bindings, service return types, repository usage, DI registration, or test coverage
- when an ambiguous placement decision needs durable review, format it with `/.github/templates/AMBIGUOUS-PLACEMENT-REPORT-TEMPLATE.md` so the evidence and decision can be checked outside the chat
- when files are intentionally not moved, explicitly name the evidence for exclusion, such as `[Obsolete]` attributes or lack of active references
- at the end of a move, note any ambiguous-folder decisions that were made using this evidence-based analysis so the user can review them

## Future Considerations (Not Active Move Rules)

Do not treat the notes in this section as binding move instructions. They are reminders for future refinement of the skill and the architecture reference.

- Validate whether request-model validators should remain in `*.Web.Api/Validation/` long term or whether some validation concerns should eventually live closer to library-side models.
- Revisit whether separate `DTOs/Requests/` and `DTOs/Responses/` folders remain the best long-term split for all apps or whether some apps should keep a flatter DTO structure.
- Revisit whether command and query classes should stay under `*.Library/Models/Entities/Commands/` and `*.Library/Models/Entities/Queries/` for simple architecture, or whether some apps should instead group those contracts by represented object or feature.
- Keep the previously considered alternatives for command/query placement available for review: `Features/<FeatureName>/Requests/`, `Features/<FeatureName>/Contracts/`, and `Features/<FeatureName>/Operations/`.
- Revisit whether `*.Library/Data/Repositories/Util/` is the right long-term home for repository-layer utilities such as pagination, sorting, and query helpers.
- Revisit whether the intermediate-model folder should remain `*.Library/Models/Models/` or be renamed to a clearer term in the future.

## Reference Trees

Keep these target-shape diagrams available as a quick reference during modernization formation. They are condensed from `/.github/skills/architecture-structure/Architecture-Structure.md`.

### Simple Web App Target

```text
<AppName>.Web.Api/
├── Controllers/
├── DTOs/
│   ├── Requests/
│   └── Responses/
├── Validation/
├── Auth/
├── Filters/
├── Middleware/
├── Extensions/
└── appsettings*.json

<AppName>.Library/
├── Data/
│   ├── APIs/
│   ├── Repositories/
│   │   ├── Context/
│   │   └── Util/
│   └── Services/
│       ├── Emails/
│       └── Notifications/
├── Models/
│   ├── Entities/
│   │   ├── Commands/
│   │   └── Queries/
│   ├── Enums/
│   ├── Models/
│   └── ValueObjects/
└── Features/
    └── <FeatureName>/

tests/
├── backend/
│   ├── unit/
│   ├── contractApi/
│   └── integrationBackend/
├── frontend/
│   ├── angularUnitComponent/
│   ├── integrationFrontend/
│   ├── smoke/
│   ├── e2e/
│   │   ├── journeys/
│   │   └── accessibility/
│   └── visualParity/
└── modernization/
    └── characterization/
        └── reports/
```

### Clean Architecture Target

```text
<AppName>.Web.Api/
├── Controllers/
├── Middleware/
└── appsettings*.json

<AppName>.Application/
├── <FeatureName>/
│   ├── <FeatureName>Command.cs
│   └── <FeatureName>Query.cs
└── DependencyInjection.cs

<AppName>.Infrastructure/
├── APIs/
├── Repositories/
├── Services/
│   ├── Emails/
│   └── Notifications/
└── DependencyInjection.cs

<AppName>.Domain/
├── Common/
├── Entities/
├── ValueObjects/
├── Enums/
├── Interfaces/
├── Events/
└── Exceptions/

tests/
├── backend/
│   ├── unit/
│   ├── contractApi/
│   └── integrationBackend/
├── frontend/
│   ├── angularUnitComponent/
│   ├── integrationFrontend/
│   ├── smoke/
│   ├── e2e/
│   │   ├── journeys/
│   │   └── accessibility/
│   └── visualParity/
└── modernization/
    └── characterization/
        └── reports/
```
