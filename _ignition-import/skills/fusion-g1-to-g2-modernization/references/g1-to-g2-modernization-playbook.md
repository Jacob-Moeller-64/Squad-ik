# Fusion G1 To G2 Modernization Playbook

Purpose: Use this reference as the working checklist when converting one legacy Fusion Generation 1 page, dialog, or workflow into the current Fusion Generation 2 starter.

## Destination Rules

- The destination client is the starter-derived Angular 20 app in `src/<AppName>.Web.Client`.
- Prefer the starter's standalone bootstrap and provider model.
- Prefer `@fusion/ngx-fusion` controls, services, and config wiring that are already present in the starter.
- Prefer `provideNgxFusionAuthOAuthOkta()` for final-state auth wiring.
- Keep auth and config in Fusion config, not scattered across feature components.

## Page-Slice Checklist

### 1. Capture The Legacy Surface

- identify the route, activation path, or menu trigger
- capture the markup, partials, templates, and dialogs involved
- list controls, services, and async flows used by the screen
- identify hidden states such as tabs, drawers, expanders, validation errors, and confirmation paths

### 2. Model The Destination Structure

- choose the routed page under `src/app/pages/`
- extract reusable UI into `src/app/components/` only when reuse is real
- move remote access to `src/app/services/`
- align route wiring with the starter route config
- align auth, config, and Fusion providers with the starter bootstrap

### 3. Translate Control Families

- textbox and textarea flows should move to Fusion Angular input components plus typed validation
- dropdown, radio, checkbox, and switch flows should move to the matching Fusion Angular controls when confirmed
- grid, chart, and upload flows should move to the matching confirmed Generation 2 control families, preserving paging, filtering, selection, export, and validation behavior when required
- expander, slideout, tab, and overlay flows should preserve visibility rules and close behavior before visual polish

### 4. Replace Service Globals

- move `$data` calls behind typed Angular services
- move `$navigation` behavior to Angular router-driven flows
- move `$dialog` behavior to Fusion dialog services or current confirmed dialog abstractions
- move `$toastr` and message flows to current Fusion messaging patterns
- replace `$event` global coupling with explicit component or service boundaries where possible

### 5. Preserve Parity-Critical Behavior

Always preserve these before claiming the slice complete:

- busy-state transitions
- validation and save blocking
- conditional visibility and enablement
- default values and prepopulation
- route parameter and query parameter behavior
- modal or drawer open and close behavior
- table filtering, sorting, paging, and selection rules
- role-based or auth-based visibility

### 6. Harden The Slice

- ensure route protection follows Fusion and Okta rules
- ensure config comes from `FusionConfig`
- ensure HTTP traffic follows the starter's provider and interceptor model
- ensure accessible names and stable selectors exist for future Playwright coverage

## Confirmed Current G2 Starter Signals

In this repo's starter client, the active Generation 2 direction includes:

- Angular 20
- `@fusion/ngx-fusion`
- `@fusion/ngx-fusion-auth-oauth-okta`
- `provideNgxFusion()`
- `provideNgxFusionAuthOAuthOkta()`
- Fusion config and route tokens registered in `app.config.ts`

Use those signals to keep modernization work grounded in the actual destination.

## Escalate As Unknown Instead Of Guessing

Record `unknown` when any of the following are not confirmed:

- direct current replacement for a legacy Fusion G1 control
- exact payload or caching semantics of a legacy `$data` call
- hidden behavior triggered by `$event` or global utility helpers
- third-party widget behavior wrapped inside a legacy Fusion control
- whether a page-level behavior belongs in the component, a shared service, or a higher-level app shell
