# Instructions for AI coding agents

This repository is **Squad-ik**, a legacy-modernization kit. Whether you arrived via
Claude Code, Copilot, Codex, Cursor, or anything else, the same rules apply.

## Orientation
- The kit lives in `.squad/` — read `pipeline.md` (the 21-step gated backbone),
  `routing.md` (strict sequential routing), and `decisions.md` (standing policies
  D-001…D-010) before doing modernization work.
- `reference-apps/` contains eval apps: `mini-mvc5-angularjs` (Tier-2 calibration),
  plus two completed full rehearsals. Their `LegacyApplication/` folders are
  deliberately legacy — do not "fix" or modernize them in place; they are before-state
  references and eval fixtures.

## Non-negotiables
- **Gates are scripts, not opinions.** A pipeline step is done when its gate exits 0
  (`.squad/gates/` — every gate has `.sh` and `.ps1` launchers over shared
  Python/Node logic). Never soften or overrule a gate result.
- **Characterization tests are evidence (D-001):** never modify one without a logged
  intentional-behavior-change entry in the run's `run-decisions.md`.
- **The scorecard is frozen (D-008):** `.squad/scorecard/` is read-only during runs;
  changing rubric or engine is a kit release (bump `VERSION`, re-run the mini-app
  baseline, update `pins.json`).
- **Version pins are preconditions:** `.squad/gates/check-pins` must pass before
  structure/swap steps; placeholders in `.squad/pins.json` mean halt, not improvise.
- **Move commits never mix with behavior commits (D-007).**

## Verify your environment / changes
- After cloning or before trusting changes: `./verify-kit.sh` (or `.\verify-kit.ps1`
  on Windows) — 11 required checks must pass.
- Kit unit tests: `python3 -m unittest discover -s .squad/scorecard/engine` and
  `-s .squad/gates/lib`.
- Visual tooling needs `npm ci` in `.squad/tools/visual` once.

## Engine-specific entry points
- GitHub Copilot / Squad CLI: `squad.agent.md` (coordinator binding).
- The five agent roles, their boundaries, and model tiers: `.squad/team.md` +
  `.squad/agents/*/charter.md`.
