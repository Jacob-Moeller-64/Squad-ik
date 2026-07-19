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
