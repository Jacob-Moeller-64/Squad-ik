#!/usr/bin/env bash
# Gate: validate run artifacts against the narrow-waist schemas.
# Usage: validate-artifacts.sh <target>... | all
# Targets (each REQUIRES its file(s) to exist and validate):
#   app-profile          -> app-profile.json
#   endpoint-inventory   -> endpoint-inventory.json
#   ui-inventory         -> ui-inventory.json
#   component-map        -> component-map.json
#   scorecard-before     -> scorecard-before.json
#   scorecard-after      -> scorecard-after.json
#   all                  -> app-profile, endpoint-inventory, ui-inventory, scorecard-before
#                           required; component-map and scorecard-after validated only if
#                           present (they don't exist until steps 12/19).
# Expects artifacts in $ARTIFACTS_DIR (default: ./artifacts); schemas live next to this script.
# Requires python jsonschema; exits 1 if unavailable unless ALLOW_SYNTAX_ONLY=1 — a gate
# that silently degrades to a syntax check is a false green.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_DIR="$SCRIPT_DIR/../schemas"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-./artifacts}"

schema_for() {
  case "$1" in
    scorecard-before|scorecard-after) echo "$SCHEMA_DIR/scorecard.schema.json" ;;
    *) echo "$SCHEMA_DIR/$1.schema.json" ;;
  esac
}

validate_file() { # <schema> <file>  -> 0 valid / 1 invalid
  python3 - "$1" "$2" <<'PY'
import json, os, sys
try:
    import jsonschema
except ImportError:
    if os.environ.get("ALLOW_SYNTAX_ONLY") == "1":
        sys.stderr.write("WARN: jsonschema unavailable; syntax check only (ALLOW_SYNTAX_ONLY=1)\n")
        json.load(open(sys.argv[2])); sys.exit(0)
    sys.stderr.write("FAIL: python jsonschema not installed (pip install jsonschema), "
                     "or set ALLOW_SYNTAX_ONLY=1 to accept a weaker syntax-only check\n")
    sys.exit(1)
schema = json.load(open(sys.argv[1])); doc = json.load(open(sys.argv[2]))
jsonschema.validate(doc, schema)
PY
}

check() { # <target> <required:0|1>
  local name="$1" required="$2"
  local file="$ARTIFACTS_DIR/$name.json"
  local schema; schema="$(schema_for "$name")"
  [[ -f "$schema" ]] || { echo "FAIL: unknown target '$name'"; return 1; }
  if [[ ! -f "$file" ]]; then
    if [[ "$required" == "1" ]]; then echo "FAIL: missing artifact $file"; return 1; fi
    echo "skip: $name.json (not yet produced)"; return 0
  fi
  if validate_file "$schema" "$file"; then echo "ok:   $name.json"; else
    echo "FAIL: $name.json does not conform to schema"; return 1; fi
}

targets=("$@")
[[ ${#targets[@]} -eq 0 ]] && targets=(all)

fail=0
for t in "${targets[@]}"; do
  if [[ "$t" == "all" ]]; then
    for req in app-profile endpoint-inventory ui-inventory scorecard-before; do
      check "$req" 1 || fail=1
    done
    for opt in component-map scorecard-after; do
      check "$opt" 0 || fail=1
    done
  else
    check "$t" 1 || fail=1
  fi
done
exit $fail
