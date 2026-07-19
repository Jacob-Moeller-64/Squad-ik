# Routing

Work is routed by **pipeline position**, not by request content.

1. Consult `pipeline.md`. Exactly one step is active at any time. Route all work to that
   step's owner.
2. No agent starts step N+1 until the Lead has recorded step N's gate as **passed**
   (gate script exit 0, checkpoint commit tagged `step-NN-done`).
3. Parallel dispatch is permitted only *within* a step marked `fan-out: yes`
   (e.g. the component swap loop, per-file cleanup). Fan-out work items must be
   independent; each converges to the single step checkpoint before the step's gate runs.
4. Stack-specific questions are answered by the adapter skill selected via
   `app-profile.json` — never from general memory of a framework.
5. Target-structure questions (`src/` layout, Fusion conventions) are answered by the
   Fusion MCP tool at its pinned version — never from memory.
6. `app-profile.json` reports a stack with no adapter, or fails the support-matrix
   check → **halt and report "unsupported profile"**. Do not improvise a migration.
7. A gate failure routes back to the same step's owner with the gate output. After the
   **2nd consecutive failure**, the owner may make **one** strong-tier attempt (the only
   strong-tier use outside standing steps 04/10; logged in the run report). A **3rd
   consecutive failure** halts the run and escalates to the human operator.
8. Any decision not already covered by `decisions.md` (kit-seeded or run-local) is made
   by the Lead, recorded in the run's `decisions.md` *before* work proceeds.
