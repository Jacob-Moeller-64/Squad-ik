#!/usr/bin/env bash
# Gate: validate run artifacts against the narrow-waist schemas.
# Usage: validate-artifacts.sh <artifact-name>... | all
# Artifact names: app-profile, endpoint-inventory, ui-inventory, component-map, scorecard
# Expects artifacts in $ARTIFACTS_DIR (default: ./artifacts) and schemas next to this script.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_DIR="$SCRIPT_DIR/../schemas"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-./artifacts}"

declare -A FILES=(
  [app-profile]="app-profile.json"
  [endpoint-inventory]="endpoint-inventory.json"
  [ui-inventory]="ui-inventory.json"
  [component-map]="component-map.json"
  [scorecard]="scorecard-before.json scorecard-after.json"
)

targets=("$@")
[[ ${#targets[@]} -eq 0 || "${targets[0]}" == "all" ]] && targets=("${!FILES[@]}")

fail=0
for name in "${targets[@]}"; do
  schema="$SCHEMA_DIR/$name.schema.json"
  [[ -f "$schema" ]] || { echo "FAIL: unknown artifact '$name'"; fail=1; continue; }
  for f in ${FILES[$name]}; do
    path="$ARTIFACTS_DIR/$f"
    if [[ ! -f "$path" ]]; then
      # scorecard-after only exists at step 19; missing files fail only when named explicitly
      [[ "$name" == "scorecard" && "$f" == "scorecard-after.json" && $# -gt 0 && "$1" != "scorecard" ]] && continue
      echo "FAIL: missing artifact $path"; fail=1; continue
    fi
    if python3 - "$schema" "$path" <<'PY'
import json, sys
try:
    import jsonschema
except ImportError:
    sys.stderr.write("WARN: python jsonschema not installed; JSON syntax check only\n")
    json.load(open(sys.argv[2])); sys.exit(0)
schema = json.load(open(sys.argv[1])); doc = json.load(open(sys.argv[2]))
jsonschema.validate(doc, schema)
PY
    then echo "ok:   $f"
    else echo "FAIL: $f does not conform to $name schema"; fail=1
    fi
  done
done
exit $fail
