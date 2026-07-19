# Pipeline

The backbone. Fixed for every app; adapters change *how* a step is done, never *which*
steps exist or what they must produce. Every step ends in a commit tagged
`step-NN-done`. A step is complete only when its gate exits 0.

Legend — **owner**: agent; **judgment**: low = mechanical (cheap model), high = may
escalate one model tier; **fan-out**: parallelism allowed inside the step.

## Phase 0 — Intake

### 00 · Profile detection
owner: Analyst · judgment: low · fan-out: no
- out: `artifacts/app-profile.json`
- gate: `gates/validate-artifacts.sh app-profile` + profile is Supported/Experimental in `support-matrix.md`
- On unsupported: HALT (routing rule 6).

## Phase 1 — Legacy Analysis (app must be runnable; capture everything while it still runs)

### 01 · Inventories & golden capture
owner: Analyst · judgment: low · fan-out: yes (per-endpoint)
- out: `artifacts/endpoint-inventory.json` (with golden request/response pairs), `artifacts/ui-inventory.json` (routes, states, components, usage sites)
- gate: `gates/validate-artifacts.sh endpoint-inventory ui-inventory`

### 02 · Baseline screenshots
owner: Analyst · judgment: low · fan-out: yes (per-route)
- out: `artifacts/baselines/<route>/<state>.png` for every route/state in ui-inventory; dynamic content (dates, IDs, animations) normalized
- gate: baseline exists for 100% of ui-inventory routes/states

### 03 · Characterization test generation
owner: Analyst · judgment: high · fan-out: yes (per-module)
- in: legacy code, pre-transformation
- out: characterization suite asserting what the app *does* (bugs included, by design); branch-coverage report over Library-layer logic
- gate: suite green against untouched legacy code; branch coverage of risk-flagged logic ≥ threshold in `scorecard/rubric.md`
- Rule: from this step on, this suite runs inside **every** subsequent gate. It may only
  be modified with an intentional-behavior-change entry in `decisions.md`.

### 04 · Opening scorecard
owner: QA · judgment: low · fan-out: no
- out: `artifacts/scorecard-before.json` via `gates/run-scorecard.sh` (frozen engine — see `scorecard/`)
- gate: `gates/validate-artifacts.sh scorecard`

## Phase 2 — Backend wave (ends in a shippable milestone)

### 05 · Backend framework upgrade
owner: Backend Dev · adapter: `adapters/backend/<profile>` · judgment: high · fan-out: no
- Behavior-affecting commits only. No file moves in this step.
- gate: build green + characterization suite green + `gates/verify-goldens.sh`

### 06 · Backend restructure → `src/{Library, API}`
owner: Backend Dev · target: `target/fusion-structure` · judgment: low · fan-out: no
- Move-only commits (no behavior changes mixed in). Structure authored by Fusion MCP (pinned).
- Characterization suite moves with the code and stays green.
- gate: `gates/check-structure.sh` + suite green + goldens pass

### 07 · Backend cleanup (survivors only, scorecard-driven)
owner: Backend Dev · judgment: high · fan-out: yes (per-file/module)
- in: `scorecard-before.json` findings
- gate: suite green + goldens pass + mechanical scorecard dimensions improved vs. before

### 08 · Scalar integration
owner: Backend Dev · target: `target/scalar` · judgment: low · fan-out: no
- gate: OpenAPI spec generates; its endpoint set **matches endpoint-inventory exactly**; goldens pass; Scalar route marked internal-only (decision D-005)

### 09 · Interim compatibility milestone  ★ shippable
owner: Backend Dev + QA · target: `target/okta` (strangler step 1) · judgment: high · fan-out: no
- Legacy auth preserved (or dual-stack legacy + Okta bearer). CORS/cookie/base-path compatibility for legacy frontend → new backend.
- gate: deployed-or-locally-hosted **legacy frontend passes smoke suite against the new backend**
- This is the "ship working parts" checkpoint: new backend + old frontend, working.

## Phase 3 — Frontend wave

### 10 · Frontend framework upgrade
owner: Frontend Dev · adapter: `adapters/frontend/<profile>` · judgment: high · fan-out: no
- gate: build green + app boots + goldens pass (frontend still talks to new backend)

### 11 · Frontend restructure → `src/Client`
owner: Frontend Dev · target: `target/fusion-structure` · judgment: low · fan-out: no
- Move-only commits. gate: `gates/check-structure.sh` + build green

### 12 · Component classification
owner: Frontend Dev · judgment: high · fan-out: no
- out: `artifacts/component-map.json` — every component: `swap` (Fusion counterpart per MCP lookup) | `survive` | `no-counterpart` (dispositioned per decision D-003)
- gate: `gates/validate-artifacts.sh component-map` + 100% of ui-inventory components classified

### 13 · Frontend cleanup (survivors only)
owner: Frontend Dev · judgment: high · fan-out: yes (per-component)
- Only components marked `survive`. Never clean what step 16 will replace.
- gate: build green + goldens pass

### 14 · Okta flip (strangler step 2)
owner: Frontend Dev · target: `target/okta` · judgment: high · fan-out: no
- gate: automated e2e — Okta login → protected route → logout — green; protected/public route split matches ui-inventory

### 15 · UI migration verification
owner: QA · judgment: high · fan-out: yes (per-route)
- `gates/visual-diff.sh` against Phase-1 baselines. QA triages diffs; borderline cases go to human review; approved diffs re-baseline with a `decisions.md` entry.
- gate: zero unapproved visual diffs; all routes render; characterization suite green

## Phase 4 — Fusionization

### 16 · Component swap loop
owner: Frontend Dev · target: `target/component-swap` · judgment: high · fan-out: yes (per-component)
- Driven by `component-map.json`. **One component per commit.** Visual + functional checks re-run per swap. Map table updated (append-only status).
- gate: every `swap` row status = done; build green; goldens pass

### 17 · Legacy auth removal (strangler step 3)
owner: Backend Dev · target: `target/okta` · judgment: low · fan-out: no
- Strip the legacy/dual-stack auth path. Do not skip: leaving it ships a backdoor.
- gate: Okta e2e green; legacy auth endpoints return 404/410; suite green

### 18 · Post-fusion verification & re-baseline
owner: QA · judgment: high · fan-out: yes (per-route)
- Acceptance standard changes here by design: fidelity to **Fusion design system + behavior parity**, not legacy pixels. Capture the new baseline set.
- gate: all routes render; goldens pass; suite green; new baselines complete

## Phase 5 — Close-out

### 19 · Closing scorecard & delta report
owner: QA · judgment: low · fan-out: no
- out: `artifacts/scorecard-after.json` (same frozen engine as step 04), `artifacts/delta-report.md`
- gate: scorecard thresholds met; OCP-readiness dimension scored (checklist for the deployment team — this kit does not deploy)

### 20 · Closed-loop final gate & run report
owner: Lead · judgment: low · fan-out: no
- Assert against Phase-1 inventories: every endpoint present + goldens pass; every route renders; every component-map row dispositioned; Okta e2e green.
- out: `artifacts/run-report.md` — tokens per step, decisions made, promotion candidates from `agents/*/history.md`
- gate: all of the above. **Done = modernized app, verified, fusionized.**
