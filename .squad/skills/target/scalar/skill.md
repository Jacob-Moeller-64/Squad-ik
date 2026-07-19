# Target skill — Scalar API docs (step 08)

## Procedure
1. Enable OpenAPI generation on the upgraded API project; wire Scalar as the docs UI.
2. Endpoint descriptions/summaries come from the endpoint inventory + code, not
   invented; auth requirements per endpoint reflected in the spec.
3. Docs route is **internal-only by default** (D-005). Public exposure is a per-run
   decision recorded in `decisions.md`, never a default.

## Gate (the real check)
The generated OpenAPI spec's endpoint set must match `endpoint-inventory.json`
**exactly** — same methods, same paths (modulo agreed renames recorded as decisions).
- Spec has an endpoint the inventory lacks → either the inventory missed it (fix the
  inventory via decision) or the migration invented an endpoint (remove it).
- Inventory has an endpoint the spec lacks → the migration dropped a feature. That's the
  exact silent failure this gate exists to catch.
