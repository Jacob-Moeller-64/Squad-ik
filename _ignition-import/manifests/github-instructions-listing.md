# `.github/` directory listing (from screenshot)

Transcribed from a single file-tree photo. This is a **structural manifest**, not file content —
none of these files' contents are transcribed unless listed separately in the main index.

## `.github/instructions/` — 25 entries

22 `*.instructions.md` files plus 3 `.json` contract files.

| # | File | Previously referenced by |
|---|---|---|
| 1 | `agent-integrity-checks.instructions.md` | — **new** |
| 2 | `agent-process-conformance.instructions.md` | — **new** |
| 3 | `agent-toolkit-protection.instructions.md` | — **new** |
| 4 | `angular.instructions.md` | — **new** |
| 5 | `appmod-agent-personality-baseline.instructions.md` | `OpX-AppMod-P1-Discovery`, `-P2-Modernize`, `-P3-Review`, `Ultimate-AppMod-Ignition` |
| 6 | `AppMod-Artifact-Contract.json` | — **new** |
| 7 | `appmod-phase-agent-contract.instructions.md` | the three phase coordinators |
| 8 | `AppMod-Process.instructions.md` | P1/P2/P3 agents, `architecture-structure`, `browser-source-decomposition`, `step3-legacy-system-analysis`, `Ultimate-Ignition-edit` |
| 9 | `AppMod-Step-Contract.json` | P1/P2/P3 agents, `step3-legacy-system-analysis` |
| 10 | `copilot.instructions.md` | — **new** |
| 11 | `discovery-runner.instructions.md` | — **new** |
| 12 | `dotnet.instructions.md` | `OpX-dotnet-upgrade` |
| 13 | `frontend-modernization-learning.instructions.md` | — **new** |
| 14 | `fusion-mcp-restructure.instructions.md` | `OpX-AppMod-P2-Modernize`, `OpX-Fusion-Reviewer`, `architecture-structure` |
| 15 | `fusion-restructure.instructions.md` | — **new** (distinct from #14) |
| 16 | `kit-update.instructions.md` | prompt 02, `Ultimate-Ignition-edit` |
| 17 | `modernization-deep-scan-checklist.instructions.md` | — **new** |
| 18 | `modernization-starter-boundaries.instructions.md` | `OpX-Fusion-Reviewer`, `architecture-structure`, `fusion-ui-component-upgrade`, `dominion-requirements` |
| 19 | `powershell-script-maintenance.instructions.md` | `Ultimate-Ignition-edit` |
| 20 | `qa-portal-reporting.instructions.md` | — **new** |
| 21 | `step-confidence-contract.instructions.md` | — **new** |
| 22 | `step-registry.json` | prompt 02 (step ids like `step:1fc2ba`) |
| 23 | `testing-design-contract.instructions.md` | — **new** |
| 24 | `tests-commenting.instructions.md` | — **new** |
| 25 | `ui-capture-reverse-engineering.instructions.md` | — **new** |

**15 of 25 are new** — never named by any of the 24 prompts, 11 agents, or 20 skill files
transcribed so far.

## `.github/templates/` — 2 entries

| File | Referenced by |
|---|---|
| `AMBIGUOUS-PLACEMENT-REPORT-TEMPLATE.md` | `architecture-structure/SKILL.md` |
| `COMPLIANCE-ANALYSIS-REPORT.template.md` | `appmod-compliance-review/SKILL.md` (the seeded category rubric is parsed from it) |

Both templates referenced elsewhere in the kit exist. No orphan templates, no dangling
template references.

## `.github/` top level

| Entry | Notes |
|---|---|
| `agents/` | 11 agent files transcribed |
| `contracts/schemas/` | referenced by prompt 03's schema-contract versioning; contents unknown |
| `instructions/` | 25 entries, above |
| `prompts/` | 24 numbered + `P2-Modernize/` and `qaTestPrompts/` subfolders |
| `scripts/` | `shared/`, `parity/`, `QA/`, `P1-Discovery/`, `P2-Modernize/` families observed |
| `skills/` | 14 skill folders observed |
| `templates/` | 2 entries, above |
| `constitution.md` | **new top-level file**, referenced by nothing transcribed |
| `Copilot-Customization-Cheat-Sheet.md` | **new top-level file** |
| `copilot-instructions.md` | **new top-level file** (partially legible; distinct from `instructions/copilot.instructions.md`) |

## Observations

**1. The instruction layer is the largest untranscribed surface in the kit.** 25 files, of which
15 have never been named by anything transcribed. By comparison the prompts (24) and agents (11)
are fully mapped.

**2. Three files look like they govern agent behaviour globally** and are named by nothing:
`agent-integrity-checks`, `agent-process-conformance`, `agent-toolkit-protection`. The last one in
particular overlaps `OpX-AppMod-P1-Discovery`'s hand-written Write Boundary section — which would
explain why only one of the three coordinators carries that section inline, if the rule actually
lives here.

**3. `copilot.instructions.md`, `copilot-instructions.md`, and `Copilot-Customization-Cheat-Sheet.md`
are three separate files** with near-identical names in two different directories. `copilot-instructions.md`
at `.github/` root is the GitHub Copilot convention path (auto-loaded by Copilot); the other two are not.
Worth confirming which is authoritative.

**4. `fusion-restructure.instructions.md` and `fusion-mcp-restructure.instructions.md` are
distinct files.** Only the `-mcp-` one is referenced anywhere transcribed. The unreferenced one may
be a predecessor.

**5. `AppMod-Artifact-Contract.json` is a third contract file** alongside `AppMod-Step-Contract.json`
and `step-registry.json`, and is referenced by nothing transcribed. Given how much of this
transcription has turned on artifact-path disagreements, an artifact contract is the single file
most likely to resolve the `.modernization/fusion-restructure/` vs
`.modernization/ignition-artifacts/modernize/fusion-restructure/` fork.

## Transcription uncertainties

- The photo is rotated ~90° and shot at an angle; filenames were read at magnification. Long
  hyphenated names (`modernization-deep-scan-checklist`, `ui-capture-reverse-engineering`,
  `frontend-modernization-learning`) are the least certain.
- The gutter line numbers (4-42) are the explorer's own row numbering, not file contents.
- `copilot-instructions.md` at the bottom edge is partially cut off; the name is inferred from the
  visible fragment and the standard GitHub Copilot convention.
- File ordering is the explorer's alphabetical sort, which is case-insensitive — hence
  `AppMod-*.json` interleaved with lowercase `appmod-*.md`.
