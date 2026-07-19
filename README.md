# Squad-ik — Legacy Modernization Kit

A Squad-based (`.squad/`) agent team that modernizes legacy Angular / ASP.NET applications
into the Fusion Starter Kit architecture: `src/{Library, API, Client}`, Scalar API docs,
Okta authentication, and Fusion UI components — verified end to end, with a before/after
scorecard proving the improvement.

## Architecture: the hourglass

**Many sources → one canonical middle → one target.**

- **Backbone** (`.squad/pipeline.md`) — a fixed, sequential, gate-checked phase sequence.
  It never changes per app.
- **Adapters** (`.squad/skills/adapters/`) — stack-specific *how* (WebForms vs MVC5,
  AngularJS vs Angular 14+). Selected by the app profile detected at step 00.
- **The narrow waist** (`.squad/schemas/`) — five canonical artifact schemas every adapter
  must emit. Downstream of the waist, every step is stack-agnostic.
- **Target skills** (`.squad/skills/target/`) — Fusion structure, Okta, Scalar, component
  swap. One implementation shared by all apps; consumes only schema-valid artifacts.

## Non-negotiable rules

1. **Sequential execution.** One pipeline step active at a time; parallelism only inside
   steps marked `fan-out`. See `.squad/routing.md`.
2. **Gates are scripts, not opinions.** A step is done when its gate script exits 0
   (`.squad/gates/`). Agents never self-declare success.
3. **Checkpoint every step.** Each step ends in a commit tagged `step-NN-done`.
   Recovery and single-step eval replay depend on this.
4. **Characterization tests are evidence.** Generated from legacy behavior *before* any
   transformation; changed only with a logged intentional-behavior-change decision.
5. **Fail fast on unknown stacks.** No adapter → halt and report. Never improvise.
6. **Pin everything per release.** Fusion MCP version, starter-kit version, scorecard
   engine, model assignments. Same kit version ⇒ same output.

## Scripts: what runs where (and the Windows story)

The kit's philosophy: **prompts for judgment, scripts for verification.** Every script
maps 1:1 to a gate or engine the pipeline depends on — there is deliberately no script
that "helps"; each one *decides* something.

| Entry point (`.sh` + `.ps1` pair) | Logic lives in | Decides |
|---|---|---|
| `gates/validate-artifacts` | `gates/lib/validate_artifacts.py` | artifacts conform to the narrow-waist schemas |
| `gates/verify-goldens` | `gates/lib/verify_goldens.py` | API behavior parity (type-strict golden replay) |
| `gates/visual-diff` | `tools/visual/visual.js` (Playwright) | UI fidelity vs. baselines |
| `gates/check-structure` | `gates/lib/check_structure.py` | Fusion three-folder conformance (per phase) |
| `gates/run-scorecard` | `scorecard/engine/engine.py` | before/after scores + step-19 thresholds |
| `gates/check-pins` | `gates/lib/check_pins.py` | version pins set (`.squad/pins.json`) before pinned-authority steps |

**Windows/PowerShell:** every gate ships paired thin launchers — `<name>.sh` (bash) and
`<name>.ps1` (PowerShell 7) — over a single cross-platform Python/Node implementation.
The logic is never written twice, so the dialects cannot drift; launchers are ~10 lines
of path resolution each. Windows developers need Python 3.11+, Node 22+, and PowerShell 7
(`#Requires -Version 7` is enforced). The `.ps1` launchers are authored to PS7 semantics
but have not yet been exercised on a Windows machine — first Windows run should smoke-test
all six. You can also bypass launchers entirely and invoke the Python/Node entry points
directly on any OS.

## Kit vs. run

This repo is the **kit** (source of truth, versioned, released). Each modernization
**run** stamps `.squad/` into the target app's repo; run artifacts (inventories,
baselines, decisions made during that run, checkpoints) live in the app repo and never
flow back here except through deliberate promotion (see `agents/*/history.md`).

## Testing the kit (token-consciously)

- **Tier 0 (free):** gate scripts and schemas are ordinary code — unit test them.
- **Tier 1:** changed a step? Replay only that step from its `step-NN-done` checkpoint
  on the affected profile's mini app.
- **Tier 2:** per release, full runs across the mini-app fleet (one tiny reference app
  per Supported profile — see `.squad/support-matrix.md`). The scorecard delta per mini
  is the regression assertion.
- **Tier 3:** realistic-sized rehearsal app, flagship profile, major versions only.

Track tokens per step per profile in every run report. When an agent solves the same
problem the same way three runs in a row, promote it to a script — the kit should get
cheaper and more consistent with every app it modernizes.
