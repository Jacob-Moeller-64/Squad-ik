---
name: "appmod-modernization-process"
description: "The phased sequence for modernizing a legacy app in LegacyCode/ into the Fusion target under src/ — and the parity rules that gate it."
domain: "modernization"
confidence: "high"
source: "earned (Ignition Kit, validated on a .NET Framework MVC + Angular app)"
---

## Context

Applies to any run that modernizes the app in `LegacyCode/` into the app-named target under `src/`.
The Lead owns this sequence. Legacy is the immutable reference after discovery; the modern target is `src/<App>.*`.

## Patterns

**Phases (in order):**
1. **Discovery** — reverse-engineer `LegacyCode/` while it is RUNNING: routes, endpoints (with live golden request/response pairs), UI controls, workflows, source-stack family, high-risk seams. Capture baseline screenshots per route/state. Write inventories to `.modernization/ignition-artifacts/discovery/` (`service-behavior-inventory.json`, `interaction-wiring-inventory.json`, `workflow-trace-inventory.json`, `review-manifest.json`) and produce an explicit cannot-locate backlog. **Produce the BASELINE compliance report** against `LegacyCode/` — the honest pre-modernization code-smell list to fix (reviewer + `/.github/skills/appmod-compliance-review`; `compliance-scan manifest before` -> review every file -> `assemble before --manifest --enforce`; writes to `.modernization/ignition-artifacts/compliance/`).
2. **Backend wave** — upgrade the backend in an ISOLATED workspace (never mutate `LegacyCode/`), then move into `src/<App>.Library` then `src/<App>.Web.Api` (move-only). Expose Scalar/OpenAPI matching the inventory. Milestone: the legacy frontend runs against the new backend.
3. **Frontend wave** — stand up the client shell that inherits the legacy visual language by construction, migrate route families into `src/<App>.Web.Client`, wire real data, flip auth to Okta.
4. **Fusionization** — swap to Fusion components one family at a time (one component per commit), then REMOVE the legacy auth path.
5. **Close-out** — closing scorecard (no dimension below the before score), closed-loop reconciliation against the discovery inventory, run report. **Produce the FINAL compliance report** against `src/` with the SAME rubric, then run `compliance-scan compare` — the before -> after proof that modernization fixed what the BASELINE found.

**Answer-key principle:** the parity reference is ALWAYS the legacy app in `LegacyCode/` + its extracted visual contract, never a finished modern reference.

**Frontend parity gate (before any Fusion swap):**
- **Field parity** — every legacy grid column/field, filter, and control is present AND wired (no column collapse, no inert stubbed handler, no dead filter, distinct data per sibling list).
- **Visual parity** — palette, typography, header/nav/footer chrome, nav route model, layout density match the legacy answer key.

## Examples

- Ownership classes (decide before editing): app-owned / Fusion-owned final state / temporary bridge / banned final state (D-012).
- Fusion MCP is the sole authority on target structure + counterparts (D-006, D-016).

## Anti-Patterns

- Skipping the BASELINE compliance report in Discovery — then there is no honest "before" to compare the FINAL against, and the improvement can't be proven.
- Starting Fusion component swaps before field + visual parity pass.
- Treating a green build as "done" (see `appmod-backend-dotnet`).
- Recreating a Fusion-owned platform concern (auth, logging, Scalar) as app-owned code.
- Leaving discovery questions as loose prose instead of a planning decision, user-input gate, or explicit blocker.
