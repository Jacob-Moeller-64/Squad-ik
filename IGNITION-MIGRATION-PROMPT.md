# Ignition Kit → Squad Format: Migration Prompt

> **How to use this file (human instructions — do not paste this block):**
> 1. Open your agent (Copilot Chat / Claude Code / etc.) with the **Ignition Kit repo**
>    as the working directory.
> 2. Fill in the three `[BRACKETED]` values in the CONTEXT section below.
> 3. Paste everything from `--- PROMPT STARTS HERE ---` down, in one message.
> 4. The agent will STOP after Phase 0 and show you a mapping table — review it before
>    telling it to continue. Expect the whole migration to take several sessions;
>    each phase ends at a committable checkpoint.
> 5. Never paste real secrets, Okta tenant IDs, or connection strings into chat.

--- PROMPT STARTS HERE ---

You are converting our internal **Ignition Kit** (a 24-step prompt-sequence legacy-app
modernization kit with skills, instruction files, and PowerShell scripts) into the
**Squad format**: a `.squad/` directory of agent charters, a gated sequential pipeline,
JSON artifact schemas, and deterministic gate scripts. Work in THIS repository. Do not
invent modernization knowledge — your job is to **restructure our existing content**,
preserving its hard-won lessons verbatim wherever they encode real experience.

## CONTEXT (filled in by the human)

- Fusion MCP tool version available on this machine: `[FUSION_MCP_VERSION]`
- Fusion Starter Kit version: `[FUSION_STARTER_KIT_VERSION]`
- Our target model tiers (IDs as our org exposes them): strong=`[STRONG_MODEL_ID]`,
  mid=`[MID_MODEL_ID]`, cheap=`[CHEAP_MODEL_ID]`

## GROUND RULES (non-negotiable, apply to every phase)

1. **Gates are scripts, not opinions.** Every verification currently phrased as prose
   ("check that the build passes") becomes an exit-code-checked script. An agent never
   self-declares a step done.
2. **Never mix content moves with content changes** in one commit. Restructuring
   commits move text verbatim; improvement commits are separate and explicit.
3. **Preserve our wording** where it encodes experience (gotchas, warnings, orderings).
   You may reorganize freely; you may not paraphrase away hard-won specifics.
4. **The scorecard is frozen infrastructure**: it gets a version file, agents never
   edit it mid-run, and any rubric change requires a version bump.
5. **Stop at every phase boundary** and wait for human approval before continuing.
6. If any Ignition file contains credentials/secrets, do NOT copy them into the new
   structure — replace with env-var references and flag them in your report.

## TARGET STRUCTURE (build exactly this shape)

```
AGENTS.md                    # ambient instructions, ALL agents, every session (thin!)
squad.agent.md               # Squad CLI coordinator binding (if we use Copilot Squad)
verify-kit.sh / verify-kit.ps1  # post-clone self-test
.squad/
├── pipeline.md              # the gated sequential backbone (see Appendix A)
├── team.md                  # 5 roles: Lead, Analyst, Backend Dev, Frontend Dev, QA
├── routing.md               # strict rules: one active step; fan-out only inside
│                            #   flagged steps; halt on unsupported profile;
│                            #   2nd gate failure → one strong-model retry, 3rd → human
├── decisions.md             # standing policies D-001…D-010 (see Appendix B)
├── support-matrix.md        # Supported / Experimental / Planned per stack profile
├── pins.json                # version pins: fusionMcpVersion, fusionStarterKitVersion,
│                            #   scorecardEngine, models {strong, mid, cheap, judge,
│                            #   standingStrongSteps: ["04","10"]}
├── agents/<role>/charter.md # identity, responsibilities, boundaries, model tier
├── skills/
│   ├── core/                # stack-agnostic phase procedures (what each step produces)
│   ├── adapters/backend/<stack>/   # per-stack HOW (webforms, mvc5, webapi2, netcore…)
│   ├── adapters/frontend/<stack>/  # angularjs, angular-8-13, angular-14plus…
│   └── target/              # fusion-structure, okta, scalar, component-swap
│                            #   (ONE shared implementation, all apps)
├── schemas/                 # the 5 artifact schemas (see Appendix C)
├── gates/                   # gate launchers: <name>.sh AND <name>.ps1 pairs, both
│   └── lib/                 #   thin shims over shared Python logic in lib/
└── scorecard/               # VERSION file + rubric.md + engine/ (deterministic scorer)
```

Architecture principle (the "hourglass"): many legacy stacks in → adapters normalize
everything into the 5 canonical JSON artifacts → one shared target-side implementation
out. Downstream of the artifacts, nothing is stack-specific.

## PHASE 0 — INVENTORY & MAPPING TABLE (then STOP)

Read every Ignition Kit file: the 24 step prompts, all skills, all instruction files,
all PowerShell scripts, the scorecard. Produce `MIGRATION-MAP.md` containing one row
per Ignition file/section: source path → destination in the target structure → triage
category → any content you propose to drop (with justification). Categories:

| Ignition content | Destination |
|---|---|
| Always-true rules repeated across many prompts (conventions, target structure, "never do X") | `AGENTS.md` (thin) or `decisions.md` (if it's a policy) |
| Step procedure ("how to do step N") | `skills/core/` if stack-agnostic, `skills/adapters/<stack>/` if stack-specific |
| Fusion/Okta/Scalar integration content | `skills/target/` |
| Verification instructions ("check that…") | a gate script contract in `gates/` (list which gate) |
| Scorecard rubric/criteria | `scorecard/rubric.md` + mechanical checks for the engine |
| PowerShell script, portable logic (file ops, JSON, validation, orchestration) | Python in `gates/lib/` or a tool dir, with `.sh` + `.ps1` launcher pair |
| PowerShell script, genuinely Windows-bound (IIS, registry, MSBuild specifics) | stays PowerShell 7 (`#Requires -Version 7`, `$ErrorActionPreference='Stop'`) |
| Reference dumps (folder layouts, naming standards) | structural goldens / schemas, not prose |

Also map each of the 24 Ignition steps onto the pipeline in Appendix A (expect
many-to-one merges; flag any Ignition step with NO home, and any Appendix-A step your
kit content doesn't cover). **STOP HERE and present MIGRATION-MAP.md for approval.**

## PHASE 1 — SCAFFOLD (after approval)

Create the target structure with the content of Appendices A–D filled in, plus empty
placeholder skills named per the map. Commit ("scaffold squad structure — no Ignition
content moved yet").

## PHASE 2 — CONTENT MIGRATION

Execute the approved map, one destination area per commit (core skills; each adapter;
target skills; AGENTS.md; decisions). Moves verbatim first; then a SEPARATE commit per
area for any edits (dedup, tightening), each edit listed in the commit message.

## PHASE 3 — SCRIPTS

Port per the triage table. Rules: logic exists ONCE (Python or PS7, never both);
every gate has both launchers; every ported script gets at least one regression test;
any Ignition script whose behavior you cannot fully determine gets ported with a
`# TODO(verify)` marker and listed in your report rather than guessed at.

## PHASE 4 — SCORECARD

Port our rubric into `scorecard/rubric.md`. Split every criterion into: mechanically
checkable (→ engine check: implement or stub with an explicit TODO) vs judgment-based
(→ LLM-judged dimension with pinned 0/5/8-style anchor examples, best-of-3 median,
judge model pinned in pins.json — the SAME judge must score before and after).
Recommended dimensions if ours lack them: security-CVEs, dependency-EOL,
test-coverage-of-risky-code. Write `scorecard/VERSION` = 1.0.0.

## PHASE 5 — SELF-TEST & CLOSE-OUT

Write `verify-kit.sh/.ps1`: checks prerequisites, runs all script tests, validates any
example artifacts against the schemas, exits non-zero on any failure. Fill `pins.json`
from CONTEXT. Write a final `MIGRATION-REPORT.md`: what moved where, what was dropped
(and why), every TODO(verify), and a token-spend estimate per pipeline step for our
budget planning. STOP for final review.

---

## APPENDIX A — PIPELINE BACKBONE (adapt names to our domain; keep order + gates)

Phases and steps (each step: owner, inputs, outputs, gate, checkpoint commit tag
`step-NN-done`; `fan-out` = parallelism allowed inside the step only):

- **P0 Intake** — 00 profile detection → `app-profile.json`; unknown stack = HALT.
- **P1 Analysis** (app must be RUNNING; capture everything now) —
  01 endpoint+UI inventories with golden request/response pairs captured live (fan-out);
  02 baseline screenshots per route/state, dynamic content normalized (fan-out);
  03 opening scorecard (engine; BEFORE tests exist so the before-score is honest);
  04 characterization tests pinning current behavior BUGS INCLUDED, targeted at the
  scorecard's hotspots, branch-coverage threshold ≥70% of risky logic (fan-out)
  【strong model — silent-failure step】. From here the suite runs inside EVERY gate.
- **P2 Backend wave** — 05 framework upgrade (behavior commits only);
  06 restructure → `src/{Library,API}` (move-only; Fusion MCP is sole structure
  authority; requires pins); 07 cleanup, scorecard-finding-driven, survivors only;
  08 Scalar: OpenAPI endpoint set must EXACTLY match the inventory;
  09 ★shippable milestone: legacy frontend runs against new backend (legacy auth
  preserved / dual-stack); gate = goldens + visual diff through the old frontend.
- **P3 Frontend wave** — 10 framework port 【strong model — thinnest net until 15】;
  11 restructure → `src/Client` (move-only); 12 component classification →
  `component-map.json` (swap/survive/no-counterpart, 100% coverage, requires pins);
  13 cleanup survivors ONLY (never polish what 16 replaces); 14 auth flip to Okta
  (OIDC; gate = automated login→protected-route→logout e2e); 15 visual verification
  vs step-02 baselines; triage diffs: regression / intentional (re-baseline with
  logged decision) / borderline (human).
- **P4 Fusionization** — 16 component swap loop driven by the map, one component per
  commit, re-verify each (fan-out, requires pins); 17 REMOVE legacy auth path
  (never skip — else you ship a backdoor); 18 re-baseline: standard is now the Fusion
  design system + behavior parity, NOT legacy pixels.
- **P5 Close-out** — 19 closing scorecard, same frozen engine, thresholds + no-dimension-
  regressed enforced; delta report; 20 closed-loop final gate against the P1
  inventories (every endpoint/route/component accounted for) + run report (tokens per
  step, decisions, escalations).

Model policy: strong tier ONLY on steps 04 and 10; everything else mid/cheap
(judgment:high steps = mid). Escalation: a step's 2nd consecutive gate failure buys ONE
strong-tier attempt; 3rd failure halts to a human. All escalations logged.

## APPENDIX B — STANDING DECISIONS (seed decisions.md with these, adapt IDs)

- **D-001** Characterization tests are evidence: modified only with a logged
  intentional-behavior-change entry. Editing one without a decision = destroying evidence.
- **D-002** Clean AFTER restructure, survivors only.
- **D-003** No-Fusion-counterpart policy: wrap (thin local wrapper), record, report.
- **D-004** Auth strangler order: preserve legacy auth through the backend wave →
  flip frontend to Okta → remove legacy path. Okta is never backend-only mid-run.
- **D-005** API docs route internal-only by default; public exposure is a per-run decision.
- **D-006** Fusion MCP (pinned in pins.json) is the SOLE authority on target structure
  and component counterparts. Never answered from model memory. check-pins gates
  steps 06/11/12/16.
- **D-007** Move commits never mix with behavior commits.
- **D-008** Scorecard frozen per run; same engine version scores before and after;
  rubric is read-only to agents.
- **D-009** Unknown stack = halt with "unsupported profile", never improvise.
- **D-010** The kit ends at the modernized app (no deployment), but code-level platform
  readiness ships: configurable port (8080 default), /health endpoints,
  forwarded-headers middleware, config-from-env, logs-to-stdout, and analysis-phase
  detection of in-proc session state / local file writes / Windows dependencies.

## APPENDIX C — ARTIFACT SCHEMAS (implement as JSON Schema files; field spec)

- `app-profile.json`: appName; backend{flavor,version,adapter}; frontend{flavor,
  version,adapter}; auth{mechanism,notes}; build{backend,frontend};
  hazards{inProcSessionState:bool, localFileWrites:[], windowsDependencies:[]};
  commands{build,test,serve} (per-app commands as DATA so gates never hardcode them).
- `endpoint-inventory.json`: capturedAt; endpoints[]{method,path,auth(public/
  authenticated/role-restricted),goldens[]{name,requestFile?,responseFile,status,
  normalizedFields[]}}. Goldens are captured from the RUNNING legacy app; replay
  protocol = fresh app restart first; comparison is TYPE-STRICT (true≠1, int≠float).
- `ui-inventory.json`: routes[]{path,auth,states[],stateUrls{}?};
  components[]{name,sourcePath,usageSites[],propsOrBindings[],variants[]}.
- `component-map.json`: fusionMcpVersion; rows[]{component,classification(swap/
  survive/no-counterpart),fusionCounterpart?,disposition?,status(pending/in-progress/
  done/blocked),commit?} — append-only status, one component per commit.
- `scorecard.json`: engineVersion, rubricVersion, scoredAt, phase(before/after), total,
  dimensions[]{key,kind(mechanical/llm-judged),score,max,findings[]{id,summary,
  location?,severity?}}.

## APPENDIX D — GATE CONTRACTS (each = shared logic + .sh/.ps1 launchers)

- `validate-artifacts <target>|all` — artifacts conform to schemas; explicitly named
  target REQUIRED to exist; `all` skips only not-yet-produced optionals; missing
  schema validator = FAIL (never silently degrade to a syntax check).
- `verify-goldens <base-url>` — replay every golden; type-strict JSON compare with
  normalizedFields masked; auth via TEST_BEARER/TEST_COOKIE env; don't follow
  redirects (3xx must be observable).
- `visual-diff <base-url> [--capture]` — screenshot every route/state (fixed viewport,
  animations disabled), pixel-compare vs baselines; re-baselining is NEVER done by the
  diff mode, only by --capture plus a logged decision.
- `check-structure [--phase backend|full]` — backend: src/Library+src/API exist;
  full: all three + LegacyApplication gone; extend with Fusion-MCP-derived checks.
- `run-scorecard <before|after>` — frozen engine; after-mode enforces: no critical/high
  CVEs, coverage threshold, total ≥ target, and NO dimension below its before score.
- `check-pins` — fails while any pins.json value is a placeholder.

--- PROMPT ENDS ---
