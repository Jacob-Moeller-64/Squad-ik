# Adapter — AngularJS 1.x · Experimental

## Detection
- `angular` 1.x in package/bower manifests or script tags; `ng-app`, `$scope`,
  `angular.module(...)` idioms; often no real build system (script tags / grunt / gulp)
  — record in profile.build.frontend.

## Extraction (steps 00–02)
- Routes: `$routeProvider` / `ui-router` states → ui-inventory routes; each state's
  resolve failures give the error states worth baselining.
- Components: directives, `.component()` registrations, and controller+template pairs
  all count as components; usage sites via template scan. Bindings (`scope:`/`bindings:`)
  → propsOrBindings.
- Run locally per its build (or plain static hosting) for baseline capture.

## Upgrade path (step 10) — the widest gap in the matrix
- Target: modern Angular (pinned per kit release). This is a rewrite-per-component, not
  a version bump. Strategy: scaffold the target app shell (routing, DI, HTTP layer)
  first, then port route-by-route, using the UI inventory as the worklist and baselines
  as the per-route acceptance check.
- Do NOT invest in ngUpgrade hybrid mode by default — it's a coexistence tool for
  in-place teams; this pipeline ports within a step and verifies at step 15. (Revisit as
  a decision for very large apps.)
- Port order: leaf components → composites → route shells. `$scope` state →
  component state/services; `$http` → typed HttpClient services aligned to the endpoint
  inventory; filters → pipes; watches → reactive bindings.
- Keep porting 1:1 visually — fidelity standard through step 15 is the *legacy
  baselines*; fusion styling arrives at step 16, not here.

## Component idioms (feeds step 12)
- Directives with `link`-function DOM manipulation are the classification hotspots:
  usually `no-counterpart` (wrap per D-003) or a behavior-losing swap — flag them early
  in the map rather than discovering at swap time.
