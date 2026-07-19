# Team

Five agents. Per-stack knowledge lives in `skills/adapters/`, not in the roster — do not
add stack-specific team members as the support matrix grows.

| Agent | Role | Model tier | Writes code? |
|---|---|---|---|
| **Lead** | Orchestrator & gatekeeper. Runs `pipeline.md`, enforces gate results, owns `decisions.md`. | mid | never |
| **Analyst** | Phase 1 owner: profile detection, inventories, golden capture, baseline screenshots, characterization test generation, opening scorecard. | mid · **strong at step 04** | tests only |
| **Backend Dev** | Backend upgrade, restructure into `src/{Library,API}`, cleanup of survivors, Scalar. Selects backend adapter from `app-profile.json`. | mid | yes |
| **Frontend Dev** | Frontend upgrade, restructure into `src/Client`, Okta flip, component swap loop. Selects frontend adapter from `app-profile.json`. | mid · **strong at step 10** | yes |
| **QA** | Runs every gate script, triages visual diffs, closing scorecard. Adversarial by charter: reports *against* the other agents' work. | cheap · mid for visual triage | never |

## Model assignment rationale (token budget)

**The strong tier is capped at two standing steps: 04 and 10** (pinned in
`pins.json.models.standingStrongSteps`). The selection principle: spend the strong model
where failures are *silent*, economize where gates make failures *visible*.

- **Step 04 (characterization tests):** a mediocre suite fails no gate — it silently
  weakens every downstream gate that relies on "suite green". Model quality here buys
  safety nothing else can.
- **Step 10 (frontend rewrite):** hardest generation work with the thinnest behavioral
  net while it happens (no frontend characterization coverage; visual verification
  arrives only at step 15).
- Everything else runs mid/cheap because it operates inside strong nets (suite, goldens,
  e2e, visual) — a weaker model there costs visible retries, never silent defects.

**Escalation valve** (so the cap is not a trap): after a step's **2nd consecutive gate
failure**, its owner may make **one** strong-tier attempt; the 3rd failure halts to a
human (routing rule 7). Escalations are logged in the run report — a step that escalates
on every app is a data-backed candidate for a third standing-strong slot.

The judge for the scorecard's qualitative dimension is pinned separately
(`pins.json.models.judge`): mid tier suffices; what matters is the **identical** model
scoring steps 03 and 19, or the before/after delta contains judge variance.

Pin exact model IDs per kit release in `.squad/pins.json` (`models` block) — the kit is
engine-agnostic, so the tiers map to whatever provider the org runs:

| Tier | Claude (API / Claude Code) | GitHub Copilot (Squad CLI) |
|---|---|---|
| strong | `claude-fable-5` (or Opus-class) | best available premium model |
| mid | `claude-sonnet-5` | standard model |
| cheap | `claude-haiku-4-5-20251001` | lightweight/fast model |

The tier split is the token-budget mechanism: most steps are `judgment: low` and run on
cheap/mid; only analysis, cleanup, and triage earn the strong tier.
