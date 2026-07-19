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
Pin exact model versions per kit release in `decisions.md`.
