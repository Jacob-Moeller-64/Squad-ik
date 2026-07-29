# Architecture Structure Skill - Remaining Points

## Purpose

This companion file highlights the modernization formation decisions that are still intentionally open after the current round of architecture-skill refinement.

Use it together with `SKILL.md` when exporting the skill into a reusable template repository.


### 1. Legacy Angular feature modules

Still needs an explicit rule for converting legacy `modules/<feature>/` folders into the starter-derived client structure.

Current likely direction:

- map each feature to `src/app/pages/<feature>/`
- split module-local shared pieces into colocated page support folders or shared `components/`
- do not move NgModule-era feature folders wholesale as `modules/`

### 2. Legacy Angular core/bootstrap files

Still needs an explicit rule for translating:

- `app.module.ts`
- `app-routing.module.ts`
- `APP_INITIALIZER`
- custom route reuse behavior
- `core/services/`, `core/guards/`, `core/interceptors/`, `core/models/`, and `core/util/`

Current likely direction:

- translate bootstrap concerns into the starter's existing app bootstrap and config files
- split `core/` by responsibility instead of preserving it as a single destination folder

### 3. Shared shell components

Still needs an explicit rule for things like:

- `nav-menu`
- help modal or help page content
- not-found pages
- layout-participating shell widgets

Current likely direction:

- shell/navigation pieces -> layout-level or shared `components/`
- not-found page -> `pages/`
- help -> page or shared modal component depending on runtime behavior

### 4. Host-era static assets and web-host leftovers

Still needs a triage rule for:

- `wwwroot/`
- `Pages/`
- `libman.json`
- client assets that currently flow through legacy web-host conventions

Current likely direction:

- keep real API endpoints such as `StaticFileController` in the API project
- review `wwwroot` assets one-by-one before migration
- do not assume Razor-era files move into the target unchanged

### 5. Filename hygiene as a formal modernization formation rule

This is still open as a formal policy decision.

## Filename Hygiene Explained

The earlier filename-refinement note was not about stylistic cleanup for its own sake. It was about avoiding path and automation problems during modernization formation.

### Concrete examples already seen

- `EquipmentService .cs`
- `LineService .cs`
- `EquipmentLinkView .cs`

These filenames contain a trailing space before `.cs`.

### Why that matters

- search and scripted move operations become less reliable because the visible name and the actual path are easy to mismatch
- patches and refactors can fail when the file path is not typed exactly
- future Linux/container-based tooling is less forgiving about path oddities
- reviewers can miss path defects because the problem is visually subtle
- a move script may treat a malformed path as a separate file rather than the intended target

### Other examples of filename issues worth watching for

- names that differ only by case and would become risky on non-Windows systems
- file names that no longer describe the file's role after it moves, such as a `*View.cs` file that is really becoming an API response DTO
- singular/plural mismatches that make destination folders harder to predict consistently
- leftover legacy naming like `Input`, `View`, or `Manager` where the target architecture uses clearer terms such as `Request`, `Response`, `Validator`, or `Service`

### Current recommendation

Treat filename cleanup as a move-slice concern when it helps correctness, predictable paths, or automation reliability.

Do not make broad rename-only churn unless the modernization formation step already touches those files.

## Export Guidance

When copying this skill into a template repository:

- copy `SKILL.md`
- copy this file if you want downstream teams to see what is still intentionally unresolved
- keep the unresolved points explicit instead of silently hard-coding premature answers into the skill
