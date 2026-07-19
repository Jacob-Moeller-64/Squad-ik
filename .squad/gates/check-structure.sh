#!/usr/bin/env bash
# Gate: verify the repo conforms to the Fusion three-folder structure.
# Usage: check-structure.sh [repo-root]
# Structural authority is the Fusion MCP tool at its pinned version (D-006); this script
# checks the mechanically checkable subset so the gate stays deterministic and free.
set -euo pipefail

ROOT="${1:-.}"
fail=0

for d in src/Library src/API src/Client; do
  [[ -d "$ROOT/$d" ]] || { echo "FAIL: missing $d/"; fail=1; }
done

# Nothing application-shaped may remain outside src/ after restructure steps.
if [[ -d "$ROOT/LegacyApplication" ]]; then
  echo "FAIL: LegacyApplication/ still present — restructure incomplete"
  fail=1
fi

# TODO(kit): extend with Fusion-MCP-derived checks (project references point
# Client->API->Library only, no reverse dependencies; naming conventions; one project
# per folder). Emit each violation on its own line for the step owner.

[[ $fail -eq 0 ]] && echo "ok: structure conforms (mechanical subset)"
exit $fail
