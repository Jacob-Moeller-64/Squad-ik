# fusion-g1-to-g2-modernization/SKILL.md — transcription state

Photos read so far: 3 of 6 (covering source lines 1-185).
Remaining photo paths (already uploaded, re-read next turn):
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/2cf4cdb2-photo.jpeg
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/ecb0be30-photo.jpeg
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/ef06b114-photo.jpeg   (last part)

Then fusion-restructure-review/SKILL.md (5 photos, not yet read):
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/f7d5e724-photo.jpeg
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/606b4195-photo.jpeg
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/36714b5d-photo.jpeg
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/20ef9f39-photo.jpeg
  /root/.claude/uploads/14b1ddd3-b354-53d8-981d-1ad257a223ae/ef3cca6f-photo.jpeg

## KEY FINDING captured from lines 125-131 (do not lose)

`## Phase Placement In The Modernization Process` lists six step references and
ALL SIX are +2 stale, and the list is printed out of order (15 before 14):

  Step 5  captures legacy UI behavior and evidence          -> actually Step 3  (Legacy System Analysis)
  Step 7  produces the modernization solution design        -> actually Step 5  (Modernization Solution Design)
  Step 8  Modernization Quality Design owns requirements    -> actually Step 6  (Modernization Quality Design)
  Step 12 forms the target frontend structure               -> actually Step 10 (Frontend Foundation & Scaffold)
  Step 13 wires page behavior and backend integration       -> actually Step 11 (Frontend Migration)
  Step 15 remediates parity drift in layout, CSS, visual    -> actually Step 13 (Frontend Shell Stabilization)
  Step 14 hardens the Angular client's runtime integration  -> actually Step 12 (Frontend Platform Integration)

Uniform +2, internally consistent, so a whole-file -2 is the correct fix.
Same class as browser-source-decomposition/SKILL.md, and just as dangerous:
every wrong number is a real current step with a different job.

Note the "Step 8 Modernization Quality Design" reference confirms the mapping,
since Quality Design is unambiguously Step 6 under current numbering.

## Other facts captured (lines 1-124)

- Activation Gate: load only when `/.modernization/.readme/kit-params.md` sets
  `legacyFrontendProfile: fusion-g1`, OR repo evidence confirms G1 shape.
  "If neither condition is true, do not load this skill by default."
  -> First conditional-activation gate seen in any skill. Token-conscious.
- Read-these-first list of 8 sources, incl. `fusion-auth-standards.md` (#3).
- "If the sources disagree, prefer the repo's active starter implementation and
  security instructions over generic examples or older notes."
- Non-Negotiables (9): do not invent Fusion control params/service methods;
  treat unknown G1 signatures as `unknown`; preserve behavior first, translate
  framework shape second; modernize in small vertical slices; use the
  starter-derived client as destination source of truth; convert jQuery Deferred
  to native Promise/async early; make lifecycle teardown explicit;
  "Final-state Fusion apps must use Okta-based auth through Fusion conventions.
  Do not land Windows Auth or custom ad hoc auth as the final result."
- Current Fusion G2 Destination Model: Angular 20 standalone bootstrap,
  `bootstrapApplication(AppComponent, appConfig)` in `main.ts`, providers via
  `app.config.ts`, `provideNgxFusion()` from `@fusion/ngx-fusion`,
  `provideNgxFusionAuthOAuthOkta()` from `@fusion/ngx-fusion-auth-oauth-okta`,
  `FUSION_CONFIG`, `FUSION_ROUTES`, `FusionUrlSerializer`.
  -> FOURTH independent confirmation of the provider-based Okta model, and
     "auth provided through the Fusion Okta package, not custom token logic
     spread through feature code" is a direct contradiction of
     fusion-auth-standards.md. Tally now 4-to-1.
- Recognition Guide: G1 signals + a "common hidden-risk patterns" list
  (screen-global mutable objects, DOM querying outside declarative bindings,
  Kendo/jQuery widget setup by selector lookup, event-bus coupling, state hidden
  in route params/globals/deferred callback order, lifecycle cleanup that never
  happens because the old page assumes full reload navigation).
- Six-step intended pattern (lines 134-139) + G1 To G2 Slice Workflow sections
  1. Inventory The Legacy Slice, 2. Classify Page Responsibilities,
  3. Normalize Async Boundaries, 4. Scaffold The G2 Destination (lines 141-185).
