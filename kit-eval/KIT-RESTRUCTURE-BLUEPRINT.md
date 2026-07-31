# Ignition Kit — Restructure Blueprint (evidence-based)

**Method:** six fresh-context readers digested the entire kit corpus — all 24 prompt
bodies, all 26 skill files, all 24 instruction/governance files, all 11 agent files —
with every overlap/merge claim required to quote the text that justifies it. This
blueprint is the synthesis. Verdicts below that contradict the earlier §4/§8 analysis
are marked **[REVISED]** — the content-level evidence wins over the size-level prior.

Merge criteria applied uniformly to steps: (a) same phase and model tier; (b) no
artifact written by the first is consumed by any step other than the second; (c)
combined prompt ≤ ~10k tokens after reference extraction; (d) no gate boundary between
them with diagnostic value.

---

## 1. Is 24 steps the most condensed form? — No, but it is close: **20 steps + 1 hook**

The pipeline is leaner than its file count suggests. Content-level reading kills most
naive merges (intermediate artifacts have third-party consumers; gate boundaries carry
diagnostic value) and confirms four real reductions:

| Change | Evidence | Net |
|---|---|---|
| **Step 01 → session-start hook/CI** | contract declares `requiredInputs: []` AND `producedOutputs: []` — there is no artifact handoff for a gate to protect; the body is deterministic tool/port/cert checks. The one model-shaped duty (detect legacy solution, write HowToRun commands) moves into Step 02 | −1 step |
| **Step 16 → iteration of Step 15** | 15's only contract output (`wrapper-versions.json`) is consumed ONLY by 16; 16's `producedOutputs` are `[]`; identical tier lines in both prompts; 16 is literally "next slice." Becomes a loop header on 15 with the kit's existing drain semantics | −1 step |
| **Steps 21+22 → one review step** | `figma-review.json`'s declared consumers are `[22]` only; both "Balanced (medium thinking)"; combined ~3.4k tokens. The artifact is still written mid-step, preserving the visual-vs-acceptance evidence boundary | −1 step |
| **Steps 22+23 → fold forward into 23** | both outputs (`final-review.json`, `FINAL-COMPLIANCE-REPORT.json`) consumed only by `[23]`; combined ~3.6k. Chain result: 21+22+23 become **two** steps (visual+acceptance review → readiness/release decision) | −1 step |
| **Step 24 → split into script + review** | ~5-6k of its 11k is Playwright/Gherkin/POM checklist reference (→ skills); the weighted-score arithmetic and ROI formula are **a model hand-computing math** — convert to a deterministic script emitting JSON; what remains is a genuine Opus-shaped defect-disposition review | net 0 steps, large tier/token win |

**Explicitly rejected merges (the digests' counter-evidence):**
- 10+11: `styling-foundation.json` is consumed by 13 AND 14, not just 11 — criterion (b) fails; the styling/control-parity scanners form a gate boundary 11 depends on.
- 12+13, 14+15, and collapsing the P3 lane to two: blocked by cross-consumers or tier mismatches; 13 keeps its stabilization gate isolation.
- 02+03: `rename-verification.json` is consumed by Step 4 — (b) fails; and the Step-2 rebuild-and-run gate isolates rename fallout before analysis begins, which is diagnostic value worth a step boundary.
- 19+20: cleanest merge in P3 *if* 19 is re-tiered from its self-declared Premium to Sonnet (the digest judges its actual demand "sonnet-shaped"); conditional, not blocked.

**Prerequisite before any P3 folding:** Step 20 declares **zero produced outputs yet
three later steps consume its evidence** — an undeclared artifact. Name it in
`AppMod-Artifact-Contract.json` first; fold decisions on an undeclared dataflow are
guesses. (Same class as the `[CUT]` transcription holes in the contract — the contract
is the module boundary, so contract gaps block restructuring decisions before they
block runs.)

Result: **24 → 20 numbered steps + 1 hook**, with iteration made explicit run-state
instead of a fake step. Fewer would cost gate isolation that the evidence says pays.

## 2. Model-tier map v2 [REVISED where digest evidence moved it]

| Tier | Steps | Changes vs prior map |
|---|---|---|
| Hook/CI (no model) | 01, and the mechanical battery inside 20 | 01 was "Haiku" — it's actually free |
| Haiku | (none purely — see note) | 13, 18, 20, 23 **[REVISED]** up to Sonnet/Codex: their prompts embed judgment (stabilization triage, deployment residue decisions, conformance judgment) that the digests flag as not-yet-hardened for Haiku. Haiku becomes viable *after* prompt hardening + L2 certification (§6) |
| Codex-5.3 | 02 **[REVISED** from Haiku — the mandatory rebuild-and-run fallout loop is compile-error fixing**]**, 07, 08, 09 | |
| Sonnet | 04, 06, 10, 11, 12, 13, 14, 15(+16 loop), 17, 18, 20-residual, 21+22, 23, and 19 **[REVISED** from Opus — "the actual demand is sonnet-shaped"**]** | |
| Opus-reserve | 03, 05, 24-review-residual | unchanged — and 24 shrinks to its judgment core |

The digest's per-step `promptQualityNotes` double as the **hardening backlog** for
tier-downs: opaque `step:xxxxxx` registry tokens that weak models echo literally,
`npm run install` landmines, stale port/version pins, "operational not advisory" vs
"do not run anything" tensions.

## 3. Fold maps

### 3.1 Governance + instructions: 24 files → **1 core card + 5 file-scoped standards + 2 data files + skills**

The four-way governance overlap (`copilot-instructions.md` / `copilot.instructions.md`
/ `AGENTS.md` / `constitution.md`) resolves into **one always-on card of ~1,100
tokens** (digest-drafted, nine sections: workspace map & boundaries; ONE precedence
ladder; gates & evidence; anti-hallucination evidence contract; artifact I/O
discipline; toolkit write-protection; behavior-preservation hygiene; security/feed
policy; remediation & escalation). `AGENTS.md`'s Non-negotiables is the base text;
`constitution.md` retires as pushed context; `copilot.instructions.md` retires
entirely (standards → card; how-tos → skills).

Keep as `applyTo` file-scoped standards (correctly built today): `dotnet`, `angular`,
`tests-commenting`, `powershell-script-maintenance`, `modernization-starter-boundaries`
— **but re-anchor the first two to `src/**`**. As written, `**/*.cs` and `**/*.ts`
push modernization standards onto the immutable `LegacyCode/**` — an instruction
telling an agent to "fix" code the kit forbids touching. That's a correctness bug
wearing a token-waste costume, and the single most important glob fix (of 8 documented).

Everything else follows the classification: `frontend-modernization-learning` →
phase-split skills (the largest single win); `kit-update` + Cheat-Sheet +
constitution-meta → one kit-maintenance skill; `discovery-runner` → runner skill;
`AppMod-Process` splits (hard rules → card; step table → registry data; narrative →
process skill); `appmod-phase-agent-contract` splits three ways (guardrail kernel →
card; per-phase counts → step contracts; prose → skill).

**The 12 documented contradictions are the "iron out consistency" work list** — two
precedence ladders, `QA after` vs `QA plan` bullet contracts, three different owners
for the cannot-locate register, per-route-plan ownership stated two ways inside one
file, toolkit-protection forbidding a directory another rule mandates writing into,
"gates are scripts" vs "the AI review is the real gate," autonomous-continue vs
stop-and-wait. Each has a quoted pair in the digest; each resolves by declaring one
owner in the merged card and deleting the loser.

### 3.2 Skills: 26 files → **12-skill catalog**

Digest verdicts: 9 keep (some trimmed/renamed), 5 absorb-into/fold-into peers
(`appmod-backend-dotnet`→dotnet standard; `appmod-frontend-angular`→angular standard;
`appmod-modernization-process`→process authority; `appmod-fusion-target`→restructure
skill; `fusion-feature-standards`→`dominion-requirements`), 1 park with kit-maintenance
(`diagnose`), 1 merge-into-prompt (`step3-legacy-system-analysis` — thin wrapper on the
Step 3 prompt), 1 **referenced-but-missing** (`screenshot-capture` — recover from
source; `visual-parity-gate` depends on it). Final catalog: dominion-requirements,
appmod-compliance-review, architecture-structure, browser-source-decomposition,
fusion-g1-to-g2-modernization, fusion-ui-component-upgrade, runtime-parity-checkpoint,
visual-parity-gate, screenshot-capture, testing-and-gates, workstation-playwright-setup,
kit-maintenance.

**~half the skill corpus by tokens presupposes run-state artifacts** ("Confirm
browserSurfaceApplicability from Step 7", "This skill owns the schema contract for all
Step 3 artifacts"). That is not a defect — it confirms the dependency mechanism:
skills declare `requires-artifacts:` in frontmatter; steps declare skills; the
existing `verify-step-artifacts -Mode Input` gate already blocks a step before a
skill's missing prerequisite could matter; one new five-line gate asserts
skill-requirements ⊆ step-requiredInputs so the graph is machine-checked, not
remembered.

### 3.3 Agents: 11 files (+2 dangling references) → **4 agents**

The digest found two agents referenced by bindings but having **no file at all**
(`OpX-Code-Reviewer`, `OpX-Fusion-Transform`) and one archived self-described redirect
(`OpX-Frontend-Angular-Transform`, zero references). Roster:

1. **OpX-AppMod-Coordinator** — sole pipeline entry point; absorbs the three thin
   phase routers, Ultimate-AppMod-Ignition, the QA trio's handoffs, and the dangling
   Fusion-Transform bindings (base file: P2-Modernize, "the widest working charter").
2. **OpX-dotnet-upgrade** — the one specialist with real non-duplicated procedure and
   a live prompt binding (Step 07); absorbs csharp-expert + csharp-janitor as modes.
3. **OpX-Reviewer** — generalized from OpX-Fusion-Reviewer (the only reviewer with a
   file *and* a binding); absorbs the dangling Code-Reviewer references.
4. **Ultimate-Ignition-edit** — unchanged: the single edit-authorized kit-maintenance
   agent the write-boundary architecture depends on.

Personality baseline folds into the coordinator's own body (its stop-cadence clause
currently *contradicts* discovery-runner's — one more of the 12).

## 4. How artifact-dependent steps stay modular (the architecture answer)

The artifact contract IS the module interface. A step = `(artifacts-in, code-in) →
(artifacts-out, code-out)`, with schema validation at both edges, reconciliation for
truth, and gates for judgment. Skills never carry state; they are procedure loaded
into a step whose inputs the contract already guaranteed. Nothing about
skill-ification touches the dataflow — the dataflow was never in the instructions to
begin with; it is in `AppMod-Artifact-Contract.json` + `verify-step-artifacts`, where
it belongs. The contract holes found (Step 20's undeclared evidence, the `[CUT]`
rows, Step 1's untracked HowToRun.md) are therefore the highest-priority fixes in the
whole blueprint: **every fold, merge, tier and test decision keys off the contract
being complete and true.**

## 5. Individually testable modules (the missing test pyramid layers)

| Level | What | Status |
|---|---|---|
| L0 | script unit — `selftest-*.ps1` + `verify-gate-integrity` auto-discovery | exists |
| L1 | **step contract test** — `stepfixtures/NN/` golden input artifacts + minimal code slice; run the step's gates only; assert exit codes + schema. No LLM, milliseconds, CI-able | build |
| L2 | **step execution test** — a real model runs the (slimmed) prompt against the fixture; judged by the step's own gates/reconciliation. Repeatable because inputs are pinned. **This is the tier certifier**: "Haiku-certified" = N/N green runs on the fixture | build |
| L3 | full-run rehearsal on `mini-mvc5-angularjs` (the kit's own calibration app) | exists as concept |

L1/L2 make every restructuring change in this blueprint safe to land: a fold or merge
that breaks a step's contract fails its fixture before it reaches an app. The digest's
per-step `promptQualityNotes` seed each fixture's first regression assertions.

## 6. Net effect

| Metric | Today | After blueprint |
|---|---|---|
| Numbered steps | 24 | 20 + 1 hook (+ explicit iteration state) |
| Pushed context, always-on | ~10.9k (two master files) + phase stack | **~1.1k core card** |
| Standing context per step | ~48k | **~8–15k** (card + slim prompt + named skills when needed + file-scoped on touch) |
| Full-run scaffolding tokens | ~1.15M | **~250–350k (~70% reduction)** |
| Instruction/governance files | 24 | 1 card + 5 standards + 2 data |
| Skills | 26 | 12 (one recovered from source) |
| Agents | 11 files + 2 dangling | 4 |
| Opus-tier steps | (untiered — all default) | 3 (03, 05, 24-residual) |
| Contradictory rule pairs | 12 documented | 0 (single owner each) |

**Migration order (each stage independently verifiable):** (1) complete + correct the
artifact contract (Step-20 output, `[CUT]` rows, Step-1 truthing) — everything keys
off it; (2) build L1 fixtures for the current 24 steps — the safety net; (3) land the
glob re-anchoring and the 1.1k core card — biggest token win, lowest risk; (4) skills
folds + `requires-artifacts` frontmatter + the coverage gate; (5) agent roster
consolidation; (6) step merges (01, 16, 21–23) behind their fixtures; (7) the Step-24
scoring script + split; (8) L2 tier certification, then flip `model:` frontmatter
per certified step.
