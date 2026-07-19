# Decisions

Append-only. Kit-level policies are seeded below (D-001…D-010); run-local decisions are
appended during each run, in the app repo's copy, by the Lead — *before* dependent work
proceeds. Format: ID · date · decision · rationale · status.

---

**D-001** · 2026-07-19 · **Characterization tests are evidence, not scaffolding.**
Generated from legacy behavior before any transformation (step 03); assert what the app
*does*, bugs included. May only be modified with an intentional-behavior-change entry
here referencing the specific test and the reason. An agent that changes a failing
characterization test without a logged decision is destroying evidence. · active

**D-002** · 2026-07-19 · **Clean after restructure, survivors only.** Cleanup steps (07,
13) run after code has moved into `src/` and, on the frontend, only on components marked
`survive` in the component map. Never invest cleanup in code that step 16 replaces. · active

**D-003** · 2026-07-19 · **No-Fusion-counterpart policy: wrap.** Components with no
Fusion counterpart are wrapped behind a thin local component in `src/Client` (preserving
the legacy implementation inside), recorded as `no-counterpart` in the component map,
and reported in the run report as future Fusion feature requests. (Alternatives
considered: keep as-is — inconsistent surface; custom-build — unbounded scope.) · active

**D-004** · 2026-07-19 · **Auth strangler order.** (1) Backend wave preserves legacy auth
or runs dual-stack (step 09) so the legacy frontend keeps working — Okta is never
backend-only. (2) Frontend flips to Okta (step 14). (3) Legacy auth path removed
(step 17) — mandatory, never skipped. · active

**D-005** · 2026-07-19 · **Scalar docs route is internal-only by default.** Public
exposure of API docs is an explicit per-run decision, never a default. · active

**D-006** · 2026-07-19 · **Fusion MCP is the sole authority on target structure**, at the
version pinned for the current kit release. Agents never answer `src/` layout or Fusion
convention questions from memory. Pin: `<FUSION_MCP_VERSION — set per release>`. · active

**D-007** · 2026-07-19 · **Behavior commits and move commits never mix.** Upgrade steps
change behavior with no file moves; restructure steps move files with no behavior
change. Keeps diffs reviewable and regressions bisectable. · active

**D-008** · 2026-07-19 · **Scorecard engine is frozen per run.** The engine version that
scores step 04 scores step 19. The rubric (`scorecard/`) is read-only to agents; scoring
is executed by `gates/run-scorecard.sh`, never self-reported. · active

**D-009** · 2026-07-19 · **Unknown stack ⇒ halt.** No adapter for the detected profile
means the run stops with "unsupported profile". Improvised migrations are the primary
source of inconsistency and token blowouts. · active

**D-010** · 2026-07-19 · **This kit ends at the modernized app.** Deployment (manifests,
routes, CI/CD, cluster gates) is out of scope. Code-level platform readiness stays in:
OCP-readiness scorecard dimension, configurable port (8080 default), health-check
endpoints, forwarded-headers middleware, config-from-env, logs-to-stdout, and Legacy
Analysis detection of in-process session state / local filesystem writes / Windows
dependencies. · active
