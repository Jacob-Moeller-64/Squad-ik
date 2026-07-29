---
description: Deep scan checklist for modernization discovery, planning, verification, and cleanup.
applyTo: ".github/prompts/**/*.prompt.md,.github/agents/*.agent.md,.github/instructions/AppMod-Process.instructions.md"
---

# Modernization Deep Scan Checklist

Purpose: use this checklist when a modernization pass feels broadly correct but still risks hidden rediscovery, vague traceability, or chat-only operator knowledge. The goal is to make Steps 1 through 24 repeatable across different app shapes without app-specific branches.

## Discovery checks

- Preserve the original starter runtime proof from Step 2 inside the canonical Step 2 page JSON instead of silently overwriting it with later refreshes or splitting it into a proof-of-proof sidecar.
- Separate runtime reachability from build reproducibility in Step 3 so later failures say whether the legacy app stopped running, stopped building, or both.
- Record the original runtime launcher contract, verified URLs, and prerequisite dependencies early enough that later characterization reruns do not guess how to relaunch the source system.
- In Step 5, trace each high-risk command family from visible control to downstream seam when evidence allows: save, delete, submit, calculate, approve, export, print, upload, download, callback, logout, lookup, and other data-changing or side-effecting actions.
- In Step 5, record a cannot-locate register for any visible command or workflow whose target cannot be proven. Name the exact control, searched files, missing seam, and the evidence still needed.
- In Step 5, capture startup and runtime dependency topology by surface: browser shell, API host, auth provider, configuration keys, connection strings, background jobs, queues, file shares, exports, and external integrations.
- In Step 5, capture control-to-code traceability, configuration traceability, and source-to-destination hints strongly enough that Step 7 can plan without reopening discovery.
- When a numbered step already owns a canonical structured artifact, strengthen that artifact in place instead of adding a second proof file for the same evidence family.

## Planning and backend checks

- In Step 7, refuse to smooth over invisible seams. High-risk command families must be traced or explicitly carried as unresolved planning gates.
- Map every major artifact family from current source to intended destination, owning step, consumer phase, and delete-after-validation disposition.
- Make auth, logging, caching, configuration, export, report, print, and file-processing ownership explicit instead of leaving them implicit inside general architecture prose.
- In Step 7, turn unproven auth-role inputs into explicit user-input gates, especially authoritative group identifiers or equivalent membership-source inputs needed for current-user/bootstrap calls and protected API success. Do not let Step 11 or Step 14 discover those inputs for the first time through frontend `403` failures.
- Materialize the characterization ladder and the executable suite backlog before backend extraction expands, and keep the suite roots under `tests/` explicit.
- Treat legacy view-hosted logic as an extraction inventory, not as a rendering note, whenever `.cshtml`, templates, or inline scripts own business behavior.

## Frontend and verification checks

- Keep shell-level guard tests current enough that route-shell drift is caught before long-running watch tasks start.
- Materialize a one-command refresh-safe preflight before relying on `src: run api`, `src: run client`, or combined watch tasks as the main verification path, and keep that proof inside the Step 19 workspace-gates artifact rather than a separate sidecar when the evidence already belongs to Step 19.
- When refresh-safe preflight uses skip flags, carry that coverage forward into the existing Step 9, Step 12, and Step 19 artifacts instead of collapsing it to a generic pass/fail summary.
- Distinguish command succeeded from parity incomplete in reporting. `Partial` must not be reported as the same condition as `Fail`.
- Preserve explicit client-to-API wiring evidence for migrated routes, mixed-prefix paths, auth callbacks, and download or export seams.
- Do not stop at bearer-token observation. Keep proof that at least one significant protected API path succeeds end-to-end from the modernized frontend under an authenticated session.
- If a positive-path browser request sends the approved auth mechanism but still returns `403`, treat that as a role-mapping or membership-source gap until it is resolved or explicitly reported as the blocker.
- Keep step-owned verification honest about what ran, what passed, what partially matched, and what was skipped or blocked.

## Cleanup checks

- Report validated leftovers, duplicate roots, old aliases, and transitional bridges explicitly instead of letting them linger as invisible drift.
- Keep reusable lessons in shared guidance, prompts, instructions, or skills. Keep app-specific facts in generated app artifacts and evidence packs.
