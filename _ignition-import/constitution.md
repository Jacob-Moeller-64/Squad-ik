---
description: Shared governance and decision principles for this repository.
---

# Constitution

> This file is the durable governance source for shared repo-wide modernization principles.
> In this repo it is treated as a governance primitive for documentation and maintenance decisions, but it is not the repo's auto-attached Copilot instruction primitive by itself.
> The supported repo-wide Copilot entrypoint remains `/.github/copilot-instructions.md`, which should point back to this file instead of duplicating it.

## 1. Purpose

Use this Constitution for the rules that should stay shared across prompts, agents, skills, instructions, and maintainer docs.

This is the right home for:

- repo-wide governance and precedence rules
- shared modernization principles that span phases and tool surfaces
- source-of-truth boundaries between the main customization primitives
- central rules about what should be shared once instead of repeated across many files

This is not the right home for:

- language-specific coding standards
- framework- or package-specific implementation recipes
- step-by-step prompt execution logic
- agent-specific chat contracts
- long code examples or version-pin catalogs

Those details belong in the narrower instruction or skill files that already own them.

## 2. Supported Copilot Usage Model

Within this repo's current Copilot model:

1. `/.github/copilot-instructions.md` is the repository-wide attached instruction surface.
2. `/.github/instructions/*.instructions.md` files are the path-scoped or purpose-scoped attached instruction surfaces.
3. Prompts, agents, and skills are the reusable task and execution surfaces.
4. This Constitution is the durable governance source those surfaces should defer to for shared principles.

If a future change needs Copilot to automatically use a shared governance rule, wire that behavior through the supported attached instruction surfaces rather than assuming the Constitution will be auto-attached by itself.

## 3. Precedence Within Repo-Maintained Guidance

When repo-authored guidance overlaps, prefer this order:

1. `/.github/constitution.md` for cross-cutting governance and shared principles
2. `/.github/copilot-instructions.md` for concise repo-wide attached defaults
3. `/.github/instructions/*.instructions.md` for narrower path- or purpose-scoped rules
4. `/.github/prompts/**/*.prompt.md`, `/.github/agents/*.agent.md`, and `/.github/skills/<name>/SKILL.md` for task-specific execution behavior
5. package, project, or feature-level docs and code-local conventions

This precedence applies only within repo-maintained guidance. It does not override higher-priority system, platform, or user instructions.

## 4. Shared Repo Facts

- This repo is both a reusable modernization ignition kit and a working validation workspace used to improve that kit.
- `LegacyCode/` is the imported legacy reference application and should remain untouched unless the active step explicitly targets legacy inventory, runtime verification, or in-place backend upgrade work.
- `src/<AppName>.*` and `tests/` are the modernization destination workspace.
- Reusable kit assets belong under `.github/`, `.modernization/`, and `.vscode/` and should remain generic.
- `/.modernization/.readme/kit-params.md` is the canonical source for current app identity and deployment values.

## 5. Shared Modernization Principles

- The modernization workflow is a readable, human-followable process, not an opaque one-click automation lane.
- The process authority is the current 3-phase, 24-step model defined in `/.github/instructions/AppMod-Process.instructions.md` and `/.github/instructions/AppMod-Step-Contract.json`.
- Step numbers are global across the full process. QA is expected after each completed numbered step.
- Discovery must establish decision-layer truth before later implementation or reporting work proceeds.
- `Workstation Readiness`, `Legacy System Analysis`, and `Modernization Solution Design` are the required roots for later architectural and execution decisions.
- Do not let downstream reports become the first place where modality, target shape, phase applicability, or ownership decisions are clarified.
- Preserve evidence as you go. Important modernization truth should be stored in repo artifacts, not only in chat history.
- Prefer the smallest meaningful same-step remediation loop before classifying a step as blocked.
- When the target app is Fusion-backed, keep modernization aligned to the protected starter shell rather than recreating parallel platform code.

## 6. Customization Primitive Boundaries

Use the repo customization surfaces this way:

- `/.github/constitution.md`
  Use for shared governance and source-of-truth boundaries that many Copilot items should follow.
- `/.github/copilot-instructions.md`
  Use for concise repo-wide attached defaults that operationalize the Constitution.
- `/.github/instructions/*.instructions.md`
  Use for language-specific, path-scoped, or purpose-scoped rules.
- `/.github/prompts/**/*.prompt.md`
  Use for reusable task contracts and numbered step entrypoints.
- `/.github/agents/*.agent.md`
  Use for personas, handoff lanes, and tool-boundary execution roles.
- `/.github/skills/<name>/SKILL.md`
  Use for bundled workflows, references, and deeper support material.

Avoid repeating shared guidance across all of these surfaces when a single constitutional rule plus one attached instruction surface is enough.

## 7. Shared Personality And Override Model

- Shared coordinator personality should be defined once in a dedicated shared source, not copied into every agent.
- In this repo, the shared coordinator baseline lives in `/.github/instructions/appmod-agent-personality-baseline.instructions.md`.
- More specific contracts, instructions, prompts, or agents may narrow or override that baseline when they own a more specific execution context.
- The Constitution owns the rule that shared baseline behavior should be centralized and overrideable.
- The Constitution owns the rule that shared baseline behavior should be centralized and overridable.
- The dedicated baseline instruction file owns the inheritable baseline text itself.

## 8. Architecture And Implementation Boundaries

- Architecture decisions must stay aligned with the repo's active architecture sources, including `/.github/skills/architecture-structure/Architecture-Structure.md`, any applicable project-level architecture docs, and the current starter-derived implementation under `src/`.
- The Constitution should state the boundary rules, not duplicate concrete implementation layouts that already live in architecture skills or restructure guardrail files.
- Fusion starter-shell protection, destination file mapping, package-selection guidance, and similar implementation detail belong in the restructure and Fusion standards files, not here.

## 9. Verification And Change Hygiene

- Prefer small, reviewable changes over broad speculative rewrites.
- Preserve behavior first unless the user explicitly requests a behavior change.
- Run the smallest meaningful validation that proves the touched change.
- Do not create ad hoc scripts, scanners, or disposable backup files unless the user explicitly requests them or a maintained workflow already owns them.
- When reusable operational knowledge is discovered during execution, promote it into the appropriate repo artifact instead of leaving it only in chat history.

## 10. What Should Move Out Of The Constitution

The following content types should live elsewhere unless they become true repo-wide governance decisions:

- .NET and C# implementation standards
  - move to `/.github/instructions/dotnet.instructions.md` or a relevant skill
- Angular or frontend implementation standards
  - move to `/.github/instructions/angular.instructions.md` or a relevant skill
- Fusion-specific platform and starter-shell rules
  - move to `/.github/instructions/modernization-starter-boundaries.instructions.md`, `/.github/instructions/fusion-mcp-restructure.instructions.md`, or the relevant Fusion skill
- acceptance criteria, compliance scoring, and review catalogs
  - move to `/.github/skills/dominion-requirements/` and the review lane assets
- detailed task execution flows
  - move to prompts, agents, and QA workflow prompts

## 11. Canonical Shared Sources

When a shared rule needs a durable home, prefer one of these sources:

- `/.github/constitution.md` for cross-cutting governance and shared principles
- `/.github/copilot-instructions.md` for concise repo-wide attached defaults
- `/.github/instructions/AppMod-Process.instructions.md` for the readable modernization process
- `/.github/instructions/AppMod-Step-Contract.json` for exact step and QA mappings
- `/.github/instructions/kit-update.instructions.md` for reusable kit-maintenance rules

## 12. Maintenance Rule

- Keep one canonical Constitution file only: `/.github/constitution.md`.
- When the Constitution is materially rewritten, archive the previous version under `/.modernization/OpXUtil/archive/.github-archive/github.archive/` before replacing it.
- If a future shared rule is specific to one surface, do not expand the Constitution unnecessarily. Put the detail in the correct instruction, prompt, agent, or skill and reference that surface from here only when the distinction itself is important.
