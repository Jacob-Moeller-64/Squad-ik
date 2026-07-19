#!/usr/bin/env bash
# Gate: visual regression of the app under test against baselines.
# Usage: visual-diff.sh <base-url> [--baseline-dir DIR] [--out-dir DIR] [--threshold PCT]
# Steps 15 uses Phase-1 legacy baselines; step 18 uses the post-fusion re-baseline.
# Exit 0 = no diffs above threshold. Diff images written to --out-dir for QA triage.
set -euo pipefail

BASE_URL="${1:?usage: visual-diff.sh <base-url> [--baseline-dir DIR] [--out-dir DIR] [--threshold PCT]}"
BASELINE_DIR="${ARTIFACTS_DIR:-./artifacts}/baselines"
OUT_DIR="${ARTIFACTS_DIR:-./artifacts}/visual-diffs"
THRESHOLD="0.1"
shift
while [[ $# -gt 0 ]]; do case "$1" in
  --baseline-dir) BASELINE_DIR="$2"; shift 2;;
  --out-dir) OUT_DIR="$2"; shift 2;;
  --threshold) THRESHOLD="$2"; shift 2;;
  *) echo "unknown arg $1"; exit 2;;
esac; done

# TODO(kit): implement with Playwright (pre-installed browser at /opt/pw-browsers/chromium):
#  for each routes[].states[] in ui-inventory.json:
#    1. navigate, force the state (fixtures per adapter), normalize dynamic content
#    2. screenshot; compare to $BASELINE_DIR/<route>/<state>.png (pixelmatch, $THRESHOLD)
#    3. write diff image to $OUT_DIR on mismatch
#  Summary: total / passed / diffs. Exit non-zero if any diff.
# Re-baselining is NOT this script's job — that requires a decisions.md entry (QA charter).

echo "FAIL: visual-diff.sh not yet implemented (safe default: red until wired)"
exit 1
