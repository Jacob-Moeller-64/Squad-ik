# Adapter — Angular 8–13 · Experimental

## Detection
- `@angular/core` 8.x–13.x in `package.json`; Angular CLI workspace (`angular.json`).
  Record exact version — the upgrade hop count depends on it.

## Extraction
- Routes: `RouterModule` route configs (including lazy modules) → ui-inventory; guard
  presence marks routes `protected`.
- Components: decorated classes; `@Input()`/`@Output()` → propsOrBindings; usage via
  template scan.
- `ng serve` for golden/baseline capture.

## Upgrade path (step 10)
- Target: pinned modern Angular. Use `ng update` hop-by-hop (e.g. 8→9→…): scripted,
  well-trodden, cheap — this is the closest thing to a mechanical upgrade in the
  frontend matrix; resist rewriting what `ng update` migrates.
- Known cliff edges by era: ViewEngine→Ivy (8→9), `TestBed` and typed-forms changes,
  RxJS 6→7 operator deprecations, standalone-component migration at the modern end
  (do the standalone migration — Fusion components assume it).
- Build system: CLI throughout; custom webpack extensions are the main breakage — port
  or drop them, record as decisions.

## Component idioms (feeds step 12)
- Already component/props-shaped, so classification is mostly direct counterpart lookup.
  Hotspots: components wrapping third-party UI libs (Material, PrimeNG, ng-bootstrap) —
  those swap at the *library-component* level, and mixed design systems mid-swap are
  expected until step 16 completes; note them in the map.
