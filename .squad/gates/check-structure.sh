#!/usr/bin/env bash
# Gate: verify the repo conforms to the Fusion three-folder structure.
# Usage: check-structure.sh [repo-root] [--phase backend|full]
#   --phase backend  (step 06): requires src/Library and src/API only. The frontend has
#                    not moved yet, so src/Client is not required and LegacyApplication/
#                    may still exist (it still holds the legacy frontend).
#   --phase full     (steps 11+, default): requires all three folders and NO remaining
#                    LegacyApplication/.
# Structural authority is the Fusion MCP tool at its pinned version (D-006); this script
# checks the mechanically checkable subset so the gate stays deterministic and free.
set -euo pipefail

ROOT="."
PHASE="full"
while [[ $# -gt 0 ]]; do case "$1" in
  --phase) PHASE="$2"; shift 2;;
  *) ROOT="$1"; shift;;
esac; done
[[ "$PHASE" == "backend" || "$PHASE" == "full" ]] || { echo "FAIL: --phase must be backend|full"; exit 2; }

fail=0
required=(src/Library src/API)
[[ "$PHASE" == "full" ]] && required+=(src/Client)
for d in "${required[@]}"; do
  [[ -d "$ROOT/$d" ]] || { echo "FAIL: missing $d/"; fail=1; }
done

if [[ "$PHASE" == "full" && -d "$ROOT/LegacyApplication" ]]; then
  echo "FAIL: LegacyApplication/ still present — restructure incomplete"
  fail=1
fi

# TODO(kit): extend with Fusion-MCP-derived checks (project references point
# Client->API->Library only, no reverse dependencies; naming conventions; one project
# per folder). Emit each violation on its own line for the step owner.

[[ $fail -eq 0 ]] && echo "ok: structure conforms (mechanical subset, phase=$PHASE)"
exit $fail
