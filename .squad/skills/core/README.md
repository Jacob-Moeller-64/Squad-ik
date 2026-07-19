# Skills — layering rule

Three layers; every charter enforces this:

1. **`core/`** — defines *what* a step must produce (stack-agnostic procedure + required
   artifacts + gate). Never contains stack-specific instructions.
2. **`adapters/`** — defines *how* for a specific legacy stack. Selected via
   `app-profile.json`, never by agent preference. Every adapter must emit artifacts
   conforming to `schemas/` — the narrow waist. If it isn't in the schema, downstream
   steps can't rely on it.
3. **`target/`** — stack-blind target-side skills (Fusion structure, Okta, Scalar,
   component swap). Consume only schema-valid artifacts; shared by every app the kit
   ever migrates. This is where test investment pays off most: validating a target skill
   on one profile validates it for all.

Promotion path: a learning recorded in `agents/*/history.md` that recurs across 3+ runs
becomes an adapter skill; an adapter procedure an agent executes identically 3 runs in a
row becomes a deterministic script. The kit gets cheaper and more consistent with every
app — if tokens-per-app isn't trending down, promotion is being skipped.
