# Target skill — Component swap loop (step 16)

Driven entirely by `component-map.json`. No component is swapped that isn't a `swap` row;
no `swap` row is left unswapped.

## Loop (fan-out allowed; items independent)
For each row with classification `swap` and status `pending`:
1. Look up the Fusion counterpart via the MCP tool (already recorded in the row at
   step 12; re-verify against the pinned MCP version if stale).
2. Map props/bindings and events from the legacy component to the counterpart's API.
   A mapping that loses behavior (a prop with no equivalent) → status `blocked`, note
   the gap, move on. Blocked rows go to the Lead, not to improvisation.
3. Swap at every usage site listed in the UI inventory.
4. **One component per commit.** Record the SHA in the row. Re-run build + affected-route
   visual/functional checks before marking `done`.
5. Update the row status append-only.

## No-counterpart rows
Disposition per D-003 (wrap): thin local wrapper in `src/Client` preserving the legacy
implementation; row records the wrapper path; run report lists these as Fusion feature
requests.

## Gate
Every `swap` row `done` (or `blocked` with a Lead-logged disposition); build green;
goldens pass. Fidelity standard is the Fusion design system — legacy-pixel comparison
ended at step 15 (see `core/visual-verification.md`).
