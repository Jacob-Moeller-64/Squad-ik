#!/usr/bin/env python3
"""Verify the repo conforms to the Fusion three-folder structure.

Single source of gate logic — .sh/.ps1 launchers are thin shims.
Usage: check_structure.py [repo-root] [--phase backend|full]
  backend (step 06): requires src/Library and src/API only — the frontend has not moved
                     yet, so src/Client is not required and LegacyApplication/ may remain.
  full (steps 11+, default): all three folders required and LegacyApplication/ gone.
Structural authority is the Fusion MCP tool at its pinned version (D-006); this checks
the mechanically checkable subset so the gate stays deterministic and free.
"""
import argparse
import sys
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("root", nargs="?", default=".")
    ap.add_argument("--phase", choices=["backend", "full"], default="full")
    args = ap.parse_args()
    root = Path(args.root)

    fail = False
    required = ["src/Library", "src/API"] + (["src/Client"] if args.phase == "full" else [])
    for d in required:
        if not (root / d).is_dir():
            print(f"FAIL: missing {d}/")
            fail = True
    if args.phase == "full" and (root / "LegacyApplication").is_dir():
        print("FAIL: LegacyApplication/ still present — restructure incomplete")
        fail = True

    # TODO(kit): extend with Fusion-MCP-derived checks (references point
    # Client->API->Library only; naming conventions; one project per folder).

    if not fail:
        print(f"ok: structure conforms (mechanical subset, phase={args.phase})")
    return 1 if fail else 0


if __name__ == "__main__":
    sys.exit(main())
