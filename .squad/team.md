# Team

Five agents. Per-stack knowledge lives in `skills/adapters/`, not in the roster — do not
add stack-specific team members as the support matrix grows.

| Agent | Role | Model tier | Writes code? |
|---|---|---|---|
| **Lead** | Orchestrator & gatekeeper. Runs `pipeline.md`, enforces gate results, owns `decisions.md`. | strong | never |
| **Analyst** | Phase 1 owner: profile detection, inventories, golden capture, baseline screenshots, characterization test generation, opening scorecard. | strong | tests only |
| **Backend Dev** | Backend upgrade, restructure into `src/{Library,API}`, cleanup of survivors, Scalar. Selects backend adapter from `app-profile.json`. | mid (strong on judgment-flagged steps) | yes |
| **Frontend Dev** | Frontend upgrade, restructure into `src/Client`, Okta flip, component swap loop. Selects frontend adapter from `app-profile.json`. | mid (strong on judgment-flagged steps) | yes |
| **QA** | Runs every gate script, triages visual diffs, closing scorecard. Adversarial by charter: reports *against* the other agents' work. | cheap | never |

## Model assignment rationale (token budget)

Judgment-heavy work (analysis, cleanup decisions, diff triage) gets the strong model.
Mechanical work (applying restructure maps, running gates, filling mapping tables) gets
the cheap tier. Steps flagged `judgment: high` in `pipeline.md` may escalate one tier.
Pin exact model IDs per kit release in `.squad/pins.json` (`models` block) — the kit is
engine-agnostic, so the tiers map to whatever provider the org runs:

| Tier | Claude (API / Claude Code) | GitHub Copilot (Squad CLI) |
|---|---|---|
| strong | `claude-fable-5` (or Opus-class) | best available premium model |
| mid | `claude-sonnet-5` | standard model |
| cheap | `claude-haiku-4-5-20251001` | lightweight/fast model |

The tier split is the token-budget mechanism: most steps are `judgment: low` and run on
cheap/mid; only analysis, cleanup, and triage earn the strong tier.
