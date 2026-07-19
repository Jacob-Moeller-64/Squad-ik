# Target skill — Fusion structure (steps 06, 11)

Stack-blind. Consumes the move map and canonical artifacts; owns the `src/` layout.

## Authority
The **Fusion MCP tool at the pinned version** (D-006) answers all structure questions:
folder layout under `src/{Library, API, Client}`, project naming, dependency direction,
starter-kit conventions. Never from memory — a plausible-but-wrong convention here
propagates through every later step.

## Procedure
1. Query the MCP tool for the target layout given the app profile.
2. Build the move map (old → new path, per project/file group) as a run artifact.
3. Execute moves via script from the map (see `core/restructure.md` rules).
4. Wire baseline platform-readiness into the API project template (D-010): configurable
   port (8080 default), health-check endpoints, `UseForwardedHeaders` middleware,
   config-from-env, logs-to-stdout. These are code-level, cheap now, expensive to
   retrofit — this kit still does not deploy.
5. Verify with `gates/check-structure.sh`; MCP-derived checks beyond the mechanical
   subset are reported per violation.
