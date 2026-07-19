#!/usr/bin/env bash
# Gate launcher — logic in ../tools/visual/visual.js (see its header for usage).
# visual-diff.sh <base-url> [--capture] [tool args...]   (--capture = baseline creation)
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[[ -d "$DIR/../tools/visual/node_modules" ]] || { echo "FAIL: run 'npm ci' in .squad/tools/visual first"; exit 1; }
BASE_URL="${1:?usage: visual-diff.sh <base-url> [--capture] [tool args...]}"; shift
MODE=diff
[[ "${1:-}" == "--capture" ]] && { MODE=capture; shift; }
exec node "$DIR/../tools/visual/visual.js" "$MODE" "$BASE_URL" "$@"
