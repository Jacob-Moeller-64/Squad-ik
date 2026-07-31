# Ignition Kit — Optimization, Standards & Durability Review

**Scope:** analysis-only evaluation of the kit as transcribed in `_ignition-import/`
(24 numbered prompts, 20 instruction files, 11 agents, 26 skill files, 16 gate/self-test
scripts, starter, contracts). No kit code was modified. Quantities are measured from the
actual files (token estimate: chars ÷ 3.7 prose / ÷ 3.3 code). The QA prompt lane
(~17 prompts) and the auxiliary prompt folders (`P1-Discovery/`, `P2-Modernize/`,
`P3-Review/`, `OpXUtil/`) exist in the kit's file tree but were not part of the
transcription; where they matter, their effect is estimated and marked.

---

## 1. Executive summary

| Headline | Number |
|---|---|
| Kit corpus (prompts+instructions+agents+skills+scripts+contracts+starter) | ~420k tokens |
| The 24 core prompts | 149,363 tok (avg 6,223; max 15,245) |
| Standing context tax per step (before reading ANY app code) | **~48k tokens** |
| Full 24-step run, scaffolding tokens alone | **~1.15M tokens** |
| Achievable reduction with the changes in §3 | **~45–55% (≈550–640k/run)** |
| Prompt/agent files that pin a `model:` | **1 of 35** |
| Steps that genuinely need an Opus-class model | **3 of 24** (steps 3, 5, 24) |
| Deterministic gates that verify instead of the model | 6 scanners + 4 shared verifiers + meta-runner + 4 self-tests |
| Gates that can pass vacuously (empty input ⇒ exit 0) | 6 (catalogued in §6) |

**The kit's economics are structurally right and locally leaky.** Its own first
principle — *gates are scripts, not opinions* — is precisely what makes cheap models
viable: wherever a deterministic gate decides pass/fail, the model tier can drop without
risk. The leaks are (a) an instruction-attachment scheme that loads ~28k of guidance on
*every* step regardless of relevance — including a 10.4k frontend-learning file taxing
all backend steps; (b) zero model pinning, so every step runs on whatever the developer's
default is; and (c) six gates whose empty-input behavior would force you to keep an
expensive model as compensation exactly where you want Haiku.

---

## 2. Where the tokens go (measured)

### 2.1 Corpus inventory

| Area | Files | Tokens |
|---|---|---|
| prompts/ (24 core) | 24 | 149,363 |
| scripts/ (gates + self-tests) | 16 | 97,049 |
| skills/ | 26 | 62,544 |
| instructions/ | 20 | 61,740 |
| starter/ | 69 | 23,945 |
| agents/ | 11 | 18,757 |
| contracts/schemas/ | 10 | 6,448 |
| root governance (copilot-instructions, constitution, AGENTS, cheat-sheet) | 4 | ~9,900 |

Scripts cost **zero** run-time tokens (they execute, not load) — 97k of the corpus is
already in the cheapest possible place. Skills are on-demand — also the right place.
The problem is concentrated in instructions attachment and prompt bodies.

### 2.2 The standing per-step context tax

What a Copilot agent carries into **every** numbered step before touching app code:

| Piece | Tokens | Why it loads |
|---|---|---|
| `.github/copilot-instructions.md` | 3,792 | always-on by convention |
| `instructions/copilot.instructions.md` | 7,130 | no `applyTo` ⇒ effectively always-on |
| `frontend-modernization-learning.instructions.md` | **10,423** | glob includes `.github/prompts/*.md` ⇒ **matches all 24 prompts** |
| `agent-process-conformance` | 2,447 | glob targets prompts/agents |
| `step-confidence-contract` | 1,849 | glob `.github/prompts/*.prompt.md` |
| `modernization-deep-scan-checklist` | 1,362 | glob targets prompts/agents |
| `qa-portal-reporting` | 953 | glob targets prompts/agents |
| Phase agent file + personality baseline | ~2,200 | agent invocation |
| `appmod-phase-agent-contract` | 5,062 | glob targets the 3 phase agents |
| `AppMod-Process.instructions.md` | 8,679 | referenced by phase agents |
| Average prompt body | 6,223 | the step itself |
| **Typical standing total** | **≈48k** | **×24 steps ≈ 1.15M/run** |

File-triggered extras stack on top per step: `modernization-starter-boundaries` (4,314)
fires on `Program.cs`/`appsettings*`/`app.config.ts`/etc. (most of steps 7–16),
`kit-update` (4,052) fires on any `.github/**` touch, `dotnet` (1,241) on any `.cs`,
`angular` (1,084) on any `.ts/.html/.scss`.

### 2.3 What is *not* the problem

Cross-prompt copy-paste is negligible: exact-duplicate blocks >240 chars across the 24
prompts total ~418 redundant tokens (one 69-token block repeated in steps 10–16). The
duplication is **conceptual** (the same rules restated in prose across
copilot.instructions / AppMod-Process / phase contract / per-prompt hard-stop sections),
not textual — so the fix is consolidation of authority, not dedup tooling.

---

## 3. Token-reduction plan (ordered by savings ÷ effort)

| # | Change | Mechanics | Est. savings / full run |
|---|---|---|---|
| 1 | **Narrow `frontend-modernization-learning`'s glob** from `.github/prompts/*.md` to the frontend steps only (`10-*..16-*.prompt.md`, its QA script, the P2 agent) | 1-line frontmatter edit | **~177k** (10.4k × 17 non-frontend steps) |
| 2 | **Merge the two master instruction files** (`copilot-instructions.md` + `copilot.instructions.md` = 10.9k combined) into one ≤2.5k operating card; push the rest into skills fetched on demand | consolidation | **~200k** (8.4k × 24) |
| 3 | **Stop restating the 24-step table**: phase agents load `AppMod-Process` (8.7k) whole; replace with a per-step slice served from `step-registry.json` + the step's own contract entry (~1.5k) | registry is already built; this finishes its migration | **~170k** |
| 4 | **Move prompt reference-material into skills**: the six >10k prompts (06: 15.2k, 08: 14.5k, 10: 12.6k, 24: 12.0k, 12: 10.6k, 05: 10.2k) embed checklists/schema prose that Copilot skills can serve on demand; target ≤6k each | content move, no meaning change | **~30–35k** |
| 5 | **Demote conformance/QA-portal/deep-scan instructions to agent-attached only** (drop the `prompts/**` half of their globs — the agent file already carries them) | frontmatter edits | **~55k** |
| 6 | Trim `appmod-phase-agent-contract` (5.1k) — half of it re-explains what gates now enforce mechanically; cite the gate instead of narrating it | prose cut | **~40k** |
| | **Total** | | **≈550–640k (~45–55%)** |

Two second-order effects worth as much as the raw savings: smaller standing context
**improves weak-model reliability** (less distraction, less conflicting guidance), and
per-step slices make context **cache-friendly** (identical prefix per phase).

---

## 4. Model-tier map (Haiku / Sonnet / GPT-5.3-Codex / Opus-reserve)

Principle applied: **tier down wherever a deterministic gate verifies the output;
reserve Opus for steps whose failures gates cannot catch.** Today 1/35 prompt+agent
files pins a model — prompt files support `model:` frontmatter, so this entire table is
implementable with frontmatter only.

| Step | Tok | Tier | Rationale (gate coverage) |
|---|---|---|---|
| 01 workstation-readiness | 1.9k | **Haiku** | checklist + scripts decide |
| 02 rename-starter | 1.9k | **Haiku** | deterministic rename; verify-step-artifacts gates |
| 03 legacy-system-analysis | 7.3k | **Opus-reserve** → Sonnet-first | the evidence corpus everything reconciles against; hallucination here poisons downstream. Use Sonnet + `step-confidence-contract` escalation: only low-confidence sections re-run on Opus |
| 04 baseline-acceptance-review | 3.7k | **Sonnet** | structured review vs recorded baseline |
| 05 solution-design | 10.2k | **Opus-reserve** | genuine architectural tradeoffs; no gate can catch a bad design |
| 06 quality-design | 15.2k | **Sonnet** | schema-gated artifact generation |
| 07 backend-upgrade | 9.6k | **Codex-5.3** | mechanical retarget; `verify-upgrade-invariants` catches the failure a build hides |
| 08 backend-formation | 14.5k | **Codex-5.3** | starter is the answer key; `scan-backend-parity` + DTO coverage gate |
| 09 integration-hardening | 7.0k | **Codex-5.3** | pattern application; reconciliation at 11 backstops |
| 10 frontend-foundation | 12.6k | **Codex-5.3** | scaffold from starter; styling-foundation gate |
| 11 frontend-migration | 6.3k | **Sonnet** | UI mapping judgment; ui-parity + ledger gates catch omissions (this is the reconciliation-rule step — keep quality here) |
| 12 platform-integration | 10.6k | **Codex-5.3** | wiring; behavioral checkpoint + parity gates |
| 13 shell-stabilization | 6.4k | **Haiku** | fix-until-gates-green loop — the archetypal cheap-model step |
| 14 ui-inventory-fusion-map | 4.4k | **Sonnet** | inventory generation, schema-gated |
| 15 fusion-ui-integration | 4.4k | **Codex-5.3** | component swap vs component-map |
| 16 next-upgrade-slice | 3.7k | **Codex-5.3** | iterated slice, same gates |
| 17 rewire-tests | 5.7k | **Sonnet** | test semantics + D-001 evidence discipline |
| 18 deployment-cleanup | 2.6k | **Haiku** | file ops + scaffold-debt drain gate |
| 19 fusion-restructure-review | 1.3k | **Sonnet** | focused review |
| 20 final-verification | 2.0k | **Haiku** | runs gates, aggregates results |
| 21 figma-review | 1.8k | **Sonnet** (vision-capable) | visual compare |
| 22 acceptance-criteria-review | 1.8k | **Sonnet** | criteria vs evidence |
| 23 readiness-review | 2.1k | **Haiku** | checklist over artifacts |
| 24 technical-review | 12.0k | **Opus-reserve** | the one deep cross-cutting audit; cheapest place to spend big-model tokens because it runs once |

Net: **5 Haiku, 8 Sonnet, 8 Codex, 3 Opus** — Opus confined to 3 steps (~29.5k of
prompt payload), matching "keep Opus calls to a minimum" without giving up the two
places bad judgment is unrecoverable plus the final audit.

**Prompt hardening required before tier-down** (weak models need what strong models
infer): steps 13/18/20/23 prompts should carry explicit command sequences and expected
RESULT strings; steps 8/10 should point at concrete starter files as answer keys rather
than describing them. The gate layer is the safety net that makes this cheap to get
slightly wrong.

---

## 5. GitHub Copilot standards conformance

**Conformant / genuinely good:**
- All seven customization primitives are used deliberately, and the kit ships its own
  `Copilot-Customization-Cheat-Sheet.md` — rare discipline.
- All 11 agents declare `tools:`; skills carry proper frontmatter
  (`name`/`description` + provenance fields like `confidence`, `source: earned…`) and
  are the kit's most token-correct asset (loaded on demand).
- Path-scoped instructions via `applyTo` frontmatter — the right mechanism, misused in
  places (below).

**Divergences (each is also a token or durability cost):**
1. **No model pinning** — 1/35 files. Prompt files support `model:`; §4 is
   implementable today. This is the highest-leverage single conformance gap.
2. **Instruction-attachment via prompt-file globs** — five instruction files attach by
   globbing `.github/prompts/**` / agent files. It works, but it's an opaque
   emulation of "always on for this workflow", invisible at the step level, and it's
   how the 10.4k frontend file ended up taxing backend steps. Standard placement:
   phase-scoped rules live in the **agent file**; reference material lives in
   **skills**; `applyTo` stays reserved for *source-file* scoping (`**/*.cs`).
3. **Two overlapping master instruction files** (root `copilot-instructions.md` +
   no-`applyTo` `copilot.instructions.md`) — Copilot's guidance is one concise
   repo-wide file; authority is currently split and partially duplicated.
4. **Most prompts declare no `tools:`** (1 of 24 does) — each step inherits the full
   toolset; declaring the minimal set per step trims tool schemas from context and
   reduces weak-model tool-misuse.
5. **`.github/hooks/` unused** (the kit's own cheat-sheet calls hooks "stronger than
   instructions"). Gate execution at step close is currently *prose asking the agent
   to run scripts* — a hook running `verify-step-artifacts -Mode Output` on session
   end would make it mechanical and free of instruction tokens.
6. One `applyTo` appears truncated in transcription (`discovery-runner` shows
   `.gith`) — verify against source; if real, that instruction never attaches.

---

## 6. Consistency & durability

The review of the gate layer (see `_ignition-import/README.md`, backfill section)
established the pattern that matters here: **every practice needed for durability
already exists somewhere in the kit; none exists everywhere.** Durability work is
therefore normalization, not invention.

**The one systemic defect class: doc/code mismatch.** Found five times — the ledger's
`-Quiet` contract vs implementation; `selftest-parity-gate`'s stale in-process header
comment vs its out-of-process code; `$ParityDimensions` described as a registry but
implemented as hand-written passes; `scan-api-dto-coverage`'s promised-but-absent fuzzy
matching; the unreachable `.json` exclusion in the drift audit. Prose drifts; code
doesn't know. The kit already invented the countermeasure — `selftest-parity-gate`'s
**static source assertions** (grep the asset for what must/must-not be there). Extend
that pattern to pin every documented contract that matters.

**Priority-ordered durability list (all previously evidenced; no new design needed):**
1. **Zero-input guards in the 6 vacuous-pass gates** (`scan-api-dto-coverage`,
   `scan-backend-parity`, `scan-ui-parity-gaps`, `scan-scaffold-debt`,
   `verify-upgrade-invariants`, `audit-step-number-drift`) — the pattern exists in
   `Invoke-StepReconciliation` and `verify-gate-integrity`; ~3 lines each. This is
   also the #1 *token* enabler: it's what makes Haiku-tier execution safe.
2. **Empty-input / missing-artifact self-test cases** — all four harnesses are one
   parameter away; the assertions fail today, which is the point.
3. **Run `verify-gate-integrity` + `audit-step-number-drift` in CI** on every kit PR
   (the `.squad/workflows/` scaffolding exists) — turns anti-re-blinding from a
   convention into a ratchet.
4. **`shared/Gate-Common.ps1`** — the ~60 duplicated lines (root resolution, registry
   load, waiver test, exit) per scanner is where siblings diverge at birth.
5. **Behavioral-parity checkpoint: warn-when-absent** — the 8-to-1 outlier; the fix is
   `verify-upgrade-invariants` line 292's own pattern applied one file over.
6. **Finish the step-registry migration** (drift audit Checks A/B/C in CI; the
   reconciliation engine already resolves `-StepId`).
7. **Placeholder resolution via `kit-params.md`** for the redacted config values
   (Okta IDs, Sonatype host) — the `{Placeholder}` convention and the parser both
   already exist; onboarding durability at hackathon scale.
8. **Pin the five `latest` toolchain deps in the starter** — the kit's own law
   ("version pins are preconditions") applied to itself; the current state hands every
   participant a different linter depending on clone day.
9. **Cross-platform posture decision** — gates shell `powershell` (Windows PowerShell)
   and use `\\`-style path regexes; either declare Windows-only loudly in Step 01's
   readiness check, or make the gates shell-agnostic. Ambiguity here is a
   hackathon-day support burden.
10. **Fix the five stale comments/docs** named above — cheap, and each one is a
    future agent confidently doing the wrong thing.

**Consistency across runs** (the multi-app question): the strongest consistency
mechanisms the kit has are the canonical artifact hourglass + field contracts +
reconciliation + the answer-key starter. The weakest links are the places agents must
infer: the starter's internal contradictions (two `fusion-button` vocabularies, three
state-exposure conventions, reactive vs template forms — all catalogued in the README)
and unstated rules (grid vs block-grid, `@for` over `*ngFor`, `FusionHttpService`-not-
`HttpClient`, `useCache` default). Every one of those is a fork where two runs diverge
legitimately. One "canonical patterns" page in `angular.instructions.md` + starter
normalization closes the whole class — and it matters *more* under cheap models, which
imitate rather than adjudicate.

---

## 7. Method & limits

Token figures are estimates (chars ÷ 3.7 prose, ÷ 3.3 code) on the transcribed kit;
Copilot's actual attachment behavior may differ at the margin (e.g., whether a
no-`applyTo` instructions file attaches globally in all clients). The QA lane
(~17 prompts) and auxiliary prompt folders were not transcribed and are excluded from
per-run math — they add to it, so the savings figures are conservative. Planned
dynamic verification (fixture apps, route-render crawl, gate mutation testing) was
descoped by request to keep the repo untouched; §4/§6 claims about gate efficacy rest
on the line-verified static review plus the kit's own self-test suite, not on live runs.

---

## 8. Addendum: target architecture — artifacts, skills, and tiered planning

*(Written in answer to: "steps create artifacts other steps use — how can independent
skills do this? Is our artifact methodology incorrect? Should we plan with higher-tier
models and execute with lower ones?")*

### 8.1 Artifacts and skills are orthogonal — one carries state, the other carries knowledge

The kit has four layers doing four different jobs, and the confusion comes from two of
them being discussed as if they competed:

| Layer | Carries | Direction | Lifetime |
|---|---|---|---|
| **Artifacts** (`.modernization/**.json`) | **state** — what was discovered/decided *for this app* | step → step | the run |
| **Skills** | **knowledge** — how to do a class of work | library → any step, pulled | the kit version |
| **Prompts** | the **work order** — what this step reads, writes, loads, and is judged by | per step | the kit version |
| **Gates** | **judgment** — exit 0/2 | after every step | the kit version |

Skills never carry state; artifacts never carry procedure. Moving how-to prose out of
pushed instructions into pulled skills changes *nothing* about the artifact dataflow:
Step 11 consumes `interaction-wiring-inventory.json` from disk whether the agent
learned to read it from an instruction file, a skill, or the prompt itself.

**The artifact methodology is the correct pattern** — externalized, schema-validated,
reconciled state is precisely what lets every step run in a fresh context, which is
also precisely what lets every step run on a *different model tier*. A kit that passed
state conversationally would force one giant expensive context across all 24 steps.
The hourglass is the enabler of the token strategy, not an obstacle to it. And the kit
already encodes the dataflow as data: `AppMod-Artifact-Contract.json` declares
`requiredInputs`/`producedOutputs` per step and `verify-step-artifacts -Mode
Input/Output` enforces both ends. The step shape to standardize:

```
NN-step.prompt.md          (slim work order)
  ├─ loads: skill-a, skill-b            ← named explicitly; pull made deterministic
  ├─ reads: artifact-x.json (schema-checked on entry)
  ├─ does the work (Codex/Sonnet/Haiku per §4)
  ├─ writes: artifact-y.json (schema-checked, reconciled on exit)
  └─ judged by: gate scripts, exit 0/2
```

Two artifact refinements for cheap-model consumers (the only real gaps found):
1. **Self-describing handoffs** — a consumer must never need the producer's context.
   Producers should stamp a small summary head (counts, rootKey, provenance) so a
   Haiku-tier reader can navigate without loading everything; the reconciliation
   engine's `ReconNotes` and the scanners' summary blocks already model this.
2. **Slice-friendly reads** — large artifacts (legacy-system-analysis-report) should be
   consumed by section, not wholesale; per-artifact indexes make that mechanical.

### 8.2 Verdict on the methodology, layer by layer

| Layer | Verdict | Action |
|---|---|---|
| Artifact hourglass + two-layer validation (+ runtime checkpoint) | **Correct — ahead of most internal AI tooling** | keep; add summary heads |
| Gates-as-scripts + self-tests + meta-runner | **Correct — the kit's core asset** | grow (absorb checkable prose), normalize per §6 |
| 24 sequential gated steps + step-registry | **Correct for drift control** | finish registry migration; split the two >14k multi-concern steps (06, 08) into slices only if weak-model runs show it |
| Knowledge distribution (instructions vs skills) | **Misassembled — push-heavy** | reference mass → skills; loading named per step; guardrails stay pushed (§5, prior analysis) |
| Agents (3 phase + 8 specialist) | Sound | fold personality baseline into agent files |
| QA prompt lane (~17 prompts, untranscribed) | **Suspect redundancy** | any QA prompt that merely runs gates should become a hook/CI job — prompts cost tokens, hooks don't |
| Starter (the answer key) | Right idea, internally contradictory | canonical-patterns pass (previously catalogued) |

Nothing here says "rethink the methodology." It says: the state layer and the
judgment layer are right; the knowledge layer is wearing the wrong delivery mechanism.

### 8.3 Plan high, execute low — yes, and the kit already secretly does it

The kit's P1 produces *plans* (solution-design, per-route-behavior-plan, quality
design); P2 *executes* them; gates verify continuously; P3 audits once. That IS the
plan/execute split — it just isn't tiered yet. Making it explicit:

| Role | Steps | Tier | Why it holds |
|---|---|---|---|
| **Plan** (judgment, unrecoverable if wrong) | 3, 5 (+ 6 at Sonnet) | Opus-reserve / Sonnet | outputs are *plan artifacts* — pay once for quality that 12 cheap steps then consume |
| **Execute** (transform against an answer key) | 7–17 | Codex-5.3 / Sonnet | every step is schema-checked, reconciled, and gate-judged; the plan artifact removes ambiguity |
| **Mechanical + verify** (checklists, gate-running, cleanup) | 1, 2, 13, 18, 20, 23 | Haiku | scripts decide; the model just drives |
| **Audit** (once) | 24 | Opus-reserve | cheapest place for a big model: single invocation |

Three mechanics make this durable rather than aspirational:

1. **Execution-grade plans.** A plan a cheap model can follow is itemized and
   checkable — the behavior-plan's per-route entries with `effectClass` are the model;
   prose-y sections of solution-design should gain structured, per-item sections. Rule
   of thumb: *if the ledger can't reconcile it, an executor can't follow it.*
2. **A two-strikes escalation valve.** Cheap model fails a gate → one retry with the
   gate's remediation text in context → second failure escalates one tier *for that
   step only*. This is both a correctness and a **token** rule: Haiku looping five
   times on a red gate costs more than Sonnet passing once. The kit already owns the
   trigger signal (`step-confidence-contract` + gate exit codes + remediation strings —
   the gates' developer-guiding `Fix:` output was built for exactly this consumer).
3. **Don't over-plan.** Tiering is per-step, not a universal plan-first ceremony —
   for mechanical steps the planning overhead would exceed the execution cost. The
   step table above is the whole policy.

The reason this works here when it fails elsewhere: most orgs bolt cheap models onto
workflows with no deterministic verification, so quality collapses silently. This kit
spent its complexity budget on exactly the layer (gates + reconciliation + self-tests)
that catches a weak executor's mistakes mechanically. The architecture was already
built for tiering — it has just been running every step on one tier and paying
Opus-class prices for Haiku-class work.
