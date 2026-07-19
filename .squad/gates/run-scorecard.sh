#!/usr/bin/env bash
# Gate + artifact producer: run the FROZEN scorecard engine (D-008).
# Usage: run-scorecard.sh <before|after> [repo-root]
# Writes $ARTIFACTS_DIR/scorecard-<phase>.json conforming to schemas/scorecard.schema.json.
# The engine version scoring 'before' MUST be the version scoring 'after' — the pin
# lives in ../scorecard/VERSION and is read-only to agents.
#
# Mechanical dimensions are computed by ../scorecard/engine/engine.py (deterministic,
# unit-tested — see engine/test_engine.py). The LLM-judged 'qualitative' dimension runs
# OUTSIDE the engine (pinned rubric + anchors, best-of-3 median) and is merged from
# $ARTIFACTS_DIR/qualitative.json when present.
# For 'after', step-19 thresholds are enforced (exit 1 on failure).
set -euo pipefail

PHASE="${1:?usage: run-scorecard.sh <before|after> [repo-root]}"
ROOT="${2:-.}"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-./artifacts}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ENFORCE=()
[[ "$PHASE" == "after" ]] && ENFORCE=(--enforce)

exec python3 "$SCRIPT_DIR/../scorecard/engine/engine.py" \
  --phase "$PHASE" --root "$ROOT" --artifacts "$ARTIFACTS_DIR" "${ENFORCE[@]}"
