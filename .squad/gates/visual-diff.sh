#!/usr/bin/env bash
# Gate: visual regression of the app under test against baselines.
# Usage: visual-diff.sh <base-url> [--baseline-dir DIR] [--out-dir DIR] [--threshold PCT] [--capture]
# Step 02 uses --capture (baseline creation); step 15 diffs against Phase-1 legacy
# baselines; step 18 diffs against the post-fusion re-baseline.
# Exit 0 = no diffs above threshold. Diff images land in --out-dir for QA triage.
# Re-baselining requires a decisions.md entry — this script never overwrites baselines
# unless invoked with --capture.
#
# Requires: node deps installed once via `npm ci` in .squad/tools/visual/ (chromium is
# expected pre-installed; set CHROMIUM_PATH to override).
set -euo pipefail

BASE_URL="${1:?usage: visual-diff.sh <base-url> [--baseline-dir DIR] [--out-dir DIR] [--threshold PCT] [--capture]}"
shift
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOL="$SCRIPT_DIR/../tools/visual/visual.js"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-./artifacts}"
INVENTORY="$ARTIFACTS_DIR/ui-inventory.json"
BASELINE_DIR="$ARTIFACTS_DIR/baselines"
OUT_DIR="$ARTIFACTS_DIR/visual-diffs"
THRESHOLD="0.1"
MODE="diff"

while [[ $# -gt 0 ]]; do case "$1" in
  --baseline-dir) BASELINE_DIR="$2"; shift 2;;
  --out-dir) OUT_DIR="$2"; shift 2;;
  --threshold) THRESHOLD="$2"; shift 2;;
  --capture) MODE="capture"; shift;;
  *) echo "unknown arg $1"; exit 2;;
esac; done

[[ -f "$INVENTORY" ]] || { echo "FAIL: $INVENTORY missing — run step 01 first"; exit 1; }
[[ -d "$SCRIPT_DIR/../tools/visual/node_modules" ]] || { echo "FAIL: run 'npm ci' in .squad/tools/visual first"; exit 1; }

if [[ "$MODE" == "capture" ]]; then
  exec node "$TOOL" capture "$BASE_URL" --inventory "$INVENTORY" --out "$BASELINE_DIR"
else
  exec node "$TOOL" diff "$BASE_URL" --inventory "$INVENTORY" --baselines "$BASELINE_DIR" --out "$OUT_DIR" --threshold "$THRESHOLD"
fi
