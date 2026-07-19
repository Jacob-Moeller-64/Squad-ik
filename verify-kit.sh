#!/usr/bin/env bash
# Kit self-test launcher — logic in .squad/tools/verify_kit.py. Run after cloning.
set -euo pipefail
exec python3 "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.squad/tools/verify_kit.py" "$@"
