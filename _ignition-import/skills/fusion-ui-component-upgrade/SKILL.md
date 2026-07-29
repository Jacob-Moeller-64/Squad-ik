---
name: fusion-ui-component-upgrade
description: "Use this skill when executing restructure Step 17 or similar route-level Fusion UI upgrades: read .modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json and ui-fusion-task-list.md, derive the next eligible route or shell slice from taskGraph and completedTaskIds, then replace Angular controls with @fusion/ngx-fusion primitives."
---

# Fusion UI Component Upgrade

Use this skill for the deliberate Fusion UI component-adoption phase that happens after the frontend has already been moved into the starter-derived client shell, platform integration is done, and the migrated UI has been stabilized enough for parity-first primitive replacement.

This skill is for the part of restructure that upgrades route-level components into Fusion equivalents. It is not the skill for the initial Angular move, auth wiring, HTTP ownership fixes, or shell stabilization.

## Use This Skill When

Use this skill when the task is any of the following:

- executing restructure Step 17, `Apply Fusion UI Integration`
- replacing native or app-owned Angular controls with `@fusion/ngx-fusion` primitives
- migrating grids, filters, row editors, dialogs, mode toggles, selection columns, or route-local action bars to Fusion components
- working route-by-route from `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json` and `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-task-list.md`
- reconciling the UI migration artifacts after a route slice passes validation

Typical trigger phrases include:

- Fusion UI integration
- upgrade components to Fusion
- replace native controls with Fusion controls
- route-level Fusion component migration
- Step 17 UI work
- component-family migration

## Do Not Use This Skill When

Do not use this skill for:

- the initial move from `LegacyCode/` into `src/<AppName>.Web.Client`
- client bootstrap, `main.ts`, `app.config.ts`, `fusion.config*.ts`, or auth/bootstrap ownership
- protected API transport or bearer-token wiring
- shell stabilization and general CSS rescue before the route is usable
- broad design cleanup or Figma polish after the route-level component adoption is already complete

For those earlier restructure phases, use the existing restructure workflow plus `/.github/skills/architecture-structure/SKILL.md`.

## Required Inputs

Read these inputs first:

1. `/.modernization/portal/data/json/step-workflow-state.json` when the work is being driven from the numbered workflow
2. `/.modernization/portal/data/json/step-response-ledger.json` when the work is being driven from the numbered workflow
3. `/.modernization/ignition-artifacts/modernize/fusion-restructure/control-point-inventory.json`
4. `/.modernization/ignition-artifacts/modernize/fusion-restructure/ui-inventory.json`
5. `/.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json`
6. `/.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-task-list.md`
7. `/.modernization/ignition-artifacts/modernize/fusion-restructure/ui-component-map.json`
8. `/.modernization/ignition-artifacts/modernize/fusion-restructure/ui-verification-report.json` when present
9. the target route component `.ts`, `.scss`, and any related route-local templates or services under `src/<AppName>.Web.Client/src/app/`
10. local Fusion component contracts from `Framework/src/node/angular/projects/ngx-fusion/**` when the exact API surface is unclear

Also keep these as context inputs:

- `/.github/skills/architecture-structure/Architecture-Structure.md`
- `/.github/instructions/modernization-starter-boundaries.instructions.md`
- `/.github/instructions/AppMod-Process.instructions.md`
- `/.github/agents/OpX-fusion-ui-component-upgrade.agent.md` for the specialized agent persona

Treat any repo-local `Framework/` docs as reference-only, and do not make this skill depend on `SimpleArchitectureExample/` or any other sample app being present.

## Default Decisions For This Repo

Unless a newer plan artifact explicitly changes them, use these defaults:

- Standard grid primitive: `FusionDataGridBasicComponent`
- CRUD/editor strategy: preserve the route's current app-owned inline editor or dialog shell, but replace the route-local controls inside that shell with Fusion form primitives
- Search suggestion strategy: `FusionSuggestionTextboxComponent` when the route needs free text plus suggestion behavior
- Validation baseline: `Push-Location 'src/<AppName>.Web.Client'; npm run build; Pop-Location`

These defaults should be treated as repo decisions, not generic Fusion rules.

## Artifact-Driven Task Selection

Do not ask the operator to choose the next route when `.modernization/ignition-artifacts/modernize/fusion-restructure/ui-fusion-map.json` is current.

Select work in this order:

1. read `completedTaskIds`, `taskGraph`, and `automationPhases`
2. filter to tasks not already completed
3. keep only tasks whose `dependencies` are fully satisfied by `completedTaskIds`
4. choose the first eligible task in `taskGraph` order unless the user explicitly overrides the task or route
5. use that task's `routeIds` and `controlFamilyIds` to scope the slice
6. if no eligible tasks remain, stop and report that step-15 work is exhausted and the restructure workflow should move to Step 17

Do not hardcode task IDs from prior runs or app-specific examples. Always re-derive the next eligible task from the current artifacts first.

## Route and File Map

Use the current `ui-fusion-map.json`, `ui-fusion-task-list.md`, and route-local source files under `src/<AppName>.Web.Client/src/app/**` as the editing anchors.

When the artifact already maps route IDs to concrete files, use that mapping directly. When it does not, derive the smallest current route-local file set from the active `routeIds` and stop with a blocker if that mapping cannot be made deterministically.

## Slice Model

Work in narrow route-local slices.

Preferred order:

1. choose one route or one tightly related sub-slice from the UI task graph
2. classify the touched surface by primitive family: grid, dialog/editor, form inputs, autocomplete, selection/bulk actions, navigation/toggles, or layout/panels
3. read the local Fusion component contract before editing if the API surface is not already proven
4. make the smallest route-local change that moves the selected surface onto Fusion primitives
5. immediately run the client build
6. if the build fails, repair only the same local slice and rerun the same build
7. only after the build passes, update the modernization artifacts for that slice

Do not batch unrelated routes into one edit cycle.

## Route Order Guidance

Primary route order comes from `taskGraph`, `completedTaskIds`, and dependency resolution.

If the artifacts are missing or stale, rebuild the fallback route order from the current `ui-inventory.json`, current route inventory, and current route-risk notes instead of relying on app-specific historical examples.

Within a route, prefer lower-risk surfaces first:

1. read-heavy grid or result surface
2. route-local filter and action controls
3. inline or dialog editor workflows
4. high-risk selection, bulk-action, or split-workspace behavior
5. layout or panel cleanup after the interaction model is already stable

## Current Hardening Focus

When the selected task targets `app-shell`, prioritize the shell-local dialogs, access-denied surfaces, loading overlay, and other shared chrome notes recorded in the current artifacts before reopening broader route work.

When the selected task is a cross-route verification or hardening slice, use the current artifact route order and open hardening notes from `ui-fusion-task-list.md` instead of relying on older app-specific route sequences.

## Primitive-Family Rules

### Data grid

- Default to `FusionDataGridBasicComponent`
- Preserve route-local sort, paging, action-column, and selection semantics
- Keep route-specific templates inside the grid when parity depends on inline buttons or custom display values
- Treat grids, charts, and complex tables as dedicated slices; do not combine them with broad page cleanup

### Form inputs

- Prefer `FusionTextboxComponent`, `FusionDropdownComponent`, `FusionNumberComponent`, `FusionCheckboxComponent`, and `FusionDatePickerComponent`
- Keep route-local validation behavior intact
- Preserve recorded control heights, density, spacing, and breakpoint behavior

### Dialogs and editors

- Do not force every route into a new modal shell
- If the route already uses an inline editor or a dialog, keep that shell unless the plan explicitly changes it
- Migrate the controls inside the editor to Fusion primitives first

### Autocomplete and suggestions

- Use `FusionSuggestionTextboxComponent` when the route already supports free typing with suggestion assistance
- Use `FusionAutocompleteComponent` only when the route is better expressed as a structured lookup choice

### Navigation and toggles

- Prefer `FusionButtonToggleGroupComponent` for route-local mode or view switches
- Do not reopen app-shell navigation during a route-level slice

### Selection and bulk actions

- Pair selection semantics with the owning grid slice whenever possible
- Preserve bulk-edit, delete, export, and multi-select behavior exactly before considering layout cleanup

### Layout and panels

- Treat app-owned panel shells, cards, and wrappers as compatibility seams unless the route is already stable
- Do not let layout cleanup become a hidden restyle of the page
- If a route's page title, mode toggle row, top action bar, or first filter band is hidden by fixed-header overlap or shell spacing drift, stop and route the work back through `Stabilize Frontend In Fusion Shell` before continuing route-level Fusion primitive replacement

## Validation

After the first substantive edit in a slice, the next action must be validation.

Preferred validation order:

1. `npm run build` from `src/<AppName>.Web.Client`
2. `npm run verify:fusion-ui` from `src/<AppName>.Web.Client` so the component-level swap report is refreshed from current source
3. route-level smoke checks when the runtime is already available
4. browser console review for uncaught runtime errors on the touched route, especially when the slice still contains temporary bridges or mixed bridge/Fusion surfaces
5. focused route tests when the repo already has a stable home for them

Do not continue patching new route surfaces before the current slice has one clean validation pass.

For route-task-driven work, treat any route that still uses a temporary bridge family as a mandatory runtime smoke candidate and record that choice in the current artifacts.

If a route throws a browser-console error during this smoke, do not mark the UI slice complete even if `npm run build` is green.

## Required Artifact Updates

When a slice is complete and validated, update the relevant artifacts under `/.modernization/ignition-artifacts/modernize/fusion-restructure/`:

- `control-point-inventory.json` when ownership or bridge status changes
- `ui-fusion-map.json`
- `ui-component-map.json`
- `ui-verification-report.json`
- `ui-fusion-task-list.md`

Do not create or update a separate Fusion-only tracker for numbered-step state. The owning numbered prompt or calling lane is responsible for persisting current execution state in `/.modernization/portal/data/json/step-response-ledger.json` and `/.modernization/portal/data/json/step-workflow-state.json`.

Record:

- which route and control family moved
- which Fusion primitive was adopted
- what remains a temporary bridge or app-owned compatibility seam
- what validation passed

For task-graph-driven work, also:

- append the completed `taskId` to `completedTaskIds` in `ui-fusion-map.json`
- update `sharedApplicationChrome` and the matching `routes[]` entry when the slice touches `app-shell`
- record the next eligible task from the refreshed task graph, or record that step-17 work is exhausted and Step 19 is the next workflow gate when no eligible tasks remain

## What Not To Do

- Do not rewrite `main.ts`, `app.config.ts`, `fusion.config*.ts`, or other protected shell files during route-level component adoption
- Do not combine auth, HTTP transport, bootstrap, and UI primitive migration in one slice
- Do not guess Fusion component APIs from memory when the local Framework source can confirm them
- Do not replace the route's visual contract with generic starter or default Kendo styling
- Do not remove a compatibility seam before the Fusion replacement is validated on that route
- Do not update the modernization artifacts ahead of the passing validation for the current slice

## Done Definition

A UI-upgrade slice is done only when:

- the targeted route surface uses the planned Fusion primitive family
- `npm run build` passes for the client
- `npm run verify:fusion-ui` refreshes a component-level report with no false claims for the touched family
- no unrelated route was changed as part of the slice
- the relevant modernization artifacts reflect the real new state
- the owning handoff or numbered step can record the slice outcome without introducing a parallel Fusion-only tracker
- step-15 closure uses `npm run verify:fusion-ui:complete` or explicitly records any remaining temporary bridges instead of silently counting them as done
