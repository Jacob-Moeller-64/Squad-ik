# Core skill — Restructure (steps 06, 11)

Move the application into the Fusion three-folder layout: `src/{Library, API, Client}`.

## Rules
- **Move-only commits (D-007).** No behavior changes, no cleanup, no "while I'm here."
  If a move forces a code change (namespace, import path), that mechanical change rides
  along; anything more waits for the cleanup step.
- Structure is authored by the **Fusion MCP tool at its pinned version** (D-006). Query
  it for layout, project naming, and dependency direction; never answer from memory.
- Produce a move map (old path → new path) as a run artifact before executing; execute
  from the map with scripts, not ad-hoc agent moves. The map is reviewable; 400 ad-hoc
  moves are not.
- Characterization tests move with the code and must be green at the gate — restructures
  are where suites silently break.
- Dependency direction after the move: Client → API → Library only. No reverse
  references. `gates/check-structure.sh` enforces the mechanical subset.
