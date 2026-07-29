# AGENTS.md

Ambient instructions for ALL Squad agents, loaded every session. Keep this file THIN. It holds
plain conventions only. Deliberate policies with rationale live in `.squad/decisions.md` (D-001..D-016).

> Phase 2: the always-true engineering conventions below are migrated verbatim from the legacy kit
> (`.github/instructions/copilot.instructions.md`, `appmod-agent-personality-baseline.instructions.md`,
> `.github/copilot-instructions.md`), preserving their exact wording. Ignition-specific operational
> plumbing (QA portal, numbered-step state files, `.modernization` paths) is intentionally NOT restated
> here - it stays in the Ignition process files (the numbered prompts, portal, and the artifact
> contract), which Squad executes as its runner; see `.github/copilot-instructions.md` "Process Model
> And Execution Layer". Stack-specific standards (.NET / Angular / naming) live
> in `.github/skills/appmod-*`, not here.

## The one architectural idea (the hourglass)

Many legacy stacks flow **in** -> stack-specific **adapters** normalize everything into the 5 canonical
JSON artifacts (`tools/appmod/schemas/`) -> **one shared target-side implementation** flows **out**.
Downstream of the artifacts, nothing is stack-specific.

## Where rules live (sorting rule)

- **Plain convention / style, no real trade-off** -> here in `AGENTS.md` (keep it short).
- **Deliberate decision with a rationale** (something an agent must not override on a whim)
  -> `.squad/decisions.md` as a `D-00x` entry.

## Non-negotiables (every agent, every step)

- **Gates are scripts, not opinions.** An agent never self-declares a step done. Done means the
  step's gate script exited `0`. See `tools/appmod/gates/`.
- **One active step at a time.** Fan-out (parallelism) is allowed only inside a step explicitly
  flagged `fan-out` in `.github/skills/appmod-modernization-process/SKILL.md`.
- **Never mix content moves with content changes in one commit.** Move-only commits move text
  verbatim; improvement commits are separate and list each edit.
- **The scorecard is frozen infrastructure.** Agents never edit `tools/appmod/scorecard/` mid-run. Any
  rubric change requires a `tools/appmod/scorecard/VERSION` bump.
- **Unknown stack = halt** with "unsupported profile". Never improvise (D-009).
- **Never copy secrets.** Use env-var references; flag any secret you find.

## Engineering conventions (migrated verbatim from the Ignition kit)

These apply to every agent, every session. Wording is preserved from the source kit.

### Behavior-preserving change
- Preserve existing behavior first unless the user explicitly asks for a behavior change.
- Prefer small, verifiable slices over broad rewrites.
- Keep the legacy user workflow, API contract, validation behavior, and visible UI behavior stable while modernizing code structure.
- Don't mix styles: keep changes consistent with the existing codebase.

### Readability and maintainability
- Optimize every changed file for an entry-level developer to follow.
- Prefer tutorial-level clarity: obvious names, short methods, linear control flow, and explicit intermediate variables when they improve comprehension.
- Avoid dense one-liners, cryptic helper chains, and compressed abstractions that make debugging harder.
- Prefer boring, obvious code over clever code unless the cleverness is clearly necessary and documented.
- Prefer KISS: don't over-engineer. Optimize for long-term human maintenance.

### Comments and file headers
- Be more aggressive with comments than a typical production repo.
- Every new or modified source, test, and important configuration file should contain enough comments for a junior developer and QA reviewer to understand the file quickly.
- Important files should start with a short header comment explaining the file purpose, the main behavior or responsibility, key dependencies or collaborators, and any notable safety or parity constraints.
- Do not rely on comments to excuse bad structure. First make the code simpler, then comment the remaining important intent.

### Testing
- Treat testability as part of implementation, not cleanup.
- Add or update tests whenever behavior-bearing code changes.
- Generated or updated tests must be Gherkin-style with explicit comments and metadata.
- Required test header comments: `CaseId`, `Scenario`, `Description`, `Input`, `Expected`.
- Required test body flow comments: `Given`, `When`, `Then`.
- Keep test wording extremely simple and concrete.

### Security, logging, and error handling
- Secure by default: no hardcoded secrets, no unsafe auth shortcuts, no injection-prone query construction.
- Never add secrets (keys, passwords, connection strings with creds) to the repo or container images. Avoid logging secrets/PII; redact if needed.
- Use structured logging and meaningful error handling.
- Catch exceptions only when doing something useful such as translation, cleanup, retry, or controlled fallback.

### Configuration
- Keep configuration externalized and environment-specific.
- Prefer strongly typed options and named sections over scattered ad hoc config lookups.
- Never hardcode environment-specific values when configuration is the correct home.

### Accessibility
- Treat accessibility as a default engineering requirement, not a polish pass.
- Prefer semantic markup, keyboard-friendly flows, labels, roles, and accessible names.
- Build UI so both users and Playwright can understand it through the same meaningful structure.

### Git and change hygiene
- Keep changes focused and easy to review.
- Do not mix unrelated refactors into behavior-preserving work unless they are required for safety or clarity.
- Prefer small diffs that clearly communicate intent and risk.

### Files and tooling
- Avoid creating loose `.md`, `.txt`, and `.log` files; do not create ad hoc scripts, scanners, or `_debug` / `_tmp` / `_bak` files.
- Do not assume `rg` / ripgrep is installed in the current shell. Check availability first; otherwise use workspace search tools or PowerShell `Select-String`.
- Keep CLI commands the source of truth so VS Code and Visual Studio stay interchangeable; avoid IDE-only steps.

### Communication
- Plain, simple, and clear English. Avoid jargon; define acronyms on first use.
- Start with a brief summary; provide the proposed change; include how to validate; call out risks and tradeoffs.
- When making code changes, communicate: what will change, what behavior must remain the same, what tests must be added or updated, and the main risks.

## Execution posture (coordinator baseline)
- Complete the user request end-to-end without unnecessary pauses; prefer direct execution over proposing future work.
- When blocked: state the blocker clearly, attempt an in-scope deterministic remediation, re-verify, and escalate only with concrete evidence if still blocked.
- Escalate instead of auto-remediating when the next move would be destructive or hard to reverse, needs user intent or product judgment, depends on credentials / permissions / external systems, or would cross into materially different work.

## Read these before acting

- `.github/skills/appmod-modernization-process/SKILL.md` - the 3-wave modernization backbone (discovery, backend, frontend) and where each gate runs.
- `.squad/routing.md` - which work type routes to which agent, fan-out rules, gate-failure escalation.
- `.squad/team.md` - the modernization roster and who owns what.
- `.squad/decisions.md` - standing policies D-001..D-016.
- `tools/appmod/pins.json` - version + model pins (structure authority, model tiers, frozen judge).
- `tools/appmod/gates/` + `tools/appmod/scorecard/` - the deterministic gate scripts and frozen scorecard agents run to prove a step is done.
