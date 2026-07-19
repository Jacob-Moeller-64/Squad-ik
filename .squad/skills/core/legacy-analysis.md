# Core skill — Legacy Analysis (steps 00–04)

Everything here happens **while the legacy app still runs**. These outputs are the
contracts the entire pipeline is verified against; whatever isn't captured now is
unverifiable later.

## Produce
1. `app-profile.json` — backend/frontend flavor+version, auth mechanism, build systems,
   platform hazards (in-proc session, local file writes, Windows deps). Unknown flavor ⇒
   `UNSUPPORTED` adapter ⇒ halt (D-009).
2. `endpoint-inventory.json` — every endpoint with ≥1 golden request/response pair
   captured from the running app. Normalize dynamic response fields (timestamps, IDs)
   and record which fields were normalized.
3. `ui-inventory.json` — every route with its meaningful states (empty/loaded/error at
   minimum where applicable); every component with usage sites and props/bindings.
4. Baseline screenshots — one per route/state, flat layout `baselines/<route>--<state>.png`;
   dynamic content normalized (fixed dates, seeded data, animations disabled); routes
   with multiple states declare `stateUrls` in the UI inventory.
5. `scorecard-before.json` — QA runs the frozen engine (step 03, before test
   generation, so the before-score reflects true legacy state).
6. Characterization test suite (step 04) — see `characterization-tests.md`; targeting
   seeded by the scorecard's hotspot findings.

## Rules
- Goldens and baselines come from the *running legacy app*, never reconstructed from
  reading code.
- Completeness beats polish: a route missing from the inventory is invisible to every
  later gate — that's how migrations silently drop features.
- Use the stack adapter for extraction mechanics (how to enumerate routes/components in
  this framework); emit only canonical schema shapes.
