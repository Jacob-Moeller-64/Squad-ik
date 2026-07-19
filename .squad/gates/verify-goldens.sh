#!/usr/bin/env bash
# Gate: replay golden request/response pairs from endpoint-inventory.json against the
# app under test; every response must match its normalized golden.
# Usage: verify-goldens.sh <base-url> [inventory-path]
# Inventory defaults to $ARTIFACTS_DIR/endpoint-inventory.json.
# Auth'd endpoints use $TEST_BEARER / $TEST_COOKIE when set.
# Exit 0 = all goldens match. Any mismatch, error, or empty golden set = exit 1.
set -euo pipefail

BASE_URL="${1:?usage: verify-goldens.sh <base-url> [inventory-path]}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $# -ge 2 ]]; then
  exec python3 "$SCRIPT_DIR/lib/verify_goldens.py" "$BASE_URL" "$2"
else
  exec python3 "$SCRIPT_DIR/lib/verify_goldens.py" "$BASE_URL"
fi
