#!/usr/bin/env python3
"""Validate run artifacts against the narrow-waist schemas.

Single source of gate logic — the .sh and .ps1 launchers are thin shims over this.
Usage: validate_artifacts.py <target>... | all
Targets (each REQUIRES its file to exist and validate):
  app-profile, endpoint-inventory, ui-inventory, component-map,
  scorecard-before, scorecard-after
  all -> app-profile, endpoint-inventory, ui-inventory, scorecard-before required;
         component-map and scorecard-after validated only if present (steps 12/19).
Artifacts dir: $ARTIFACTS_DIR (default ./artifacts). Missing python-jsonschema fails
the gate (a silently weaker check is a false green) unless ALLOW_SYNTAX_ONLY=1.
"""
import json
import os
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SCHEMA_DIR = HERE.parent.parent / "schemas"
REQUIRED_ALL = ["app-profile", "endpoint-inventory", "ui-inventory", "scorecard-before"]
OPTIONAL_ALL = ["component-map", "scorecard-after"]


def schema_for(name: str) -> Path:
    base = "scorecard" if name in ("scorecard-before", "scorecard-after") else name
    return SCHEMA_DIR / f"{base}.schema.json"


def validate_one(name: str, required: bool, artifacts: Path) -> bool:
    schema_path = schema_for(name)
    if not schema_path.is_file():
        print(f"FAIL: unknown target '{name}'")
        return False
    file = artifacts / f"{name}.json"
    if not file.is_file():
        if required:
            print(f"FAIL: missing artifact {file}")
            return False
        print(f"skip: {name}.json (not yet produced)")
        return True
    try:
        doc = json.loads(file.read_text())
    except json.JSONDecodeError as e:
        print(f"FAIL: {name}.json is not valid JSON ({e})")
        return False
    try:
        import jsonschema
    except ImportError:
        if os.environ.get("ALLOW_SYNTAX_ONLY") == "1":
            print(f"WARN: jsonschema unavailable; {name}.json syntax-checked only (ALLOW_SYNTAX_ONLY=1)", file=sys.stderr)
            return True
        print("FAIL: python jsonschema not installed (pip install jsonschema), "
              "or set ALLOW_SYNTAX_ONLY=1 to accept a weaker syntax-only check", file=sys.stderr)
        return False
    try:
        jsonschema.validate(doc, json.loads(schema_path.read_text()))
    except jsonschema.ValidationError as e:
        print(f"FAIL: {name}.json does not conform to schema: {e.message}")
        return False
    print(f"ok:   {name}.json")
    return True


def main(argv):
    artifacts = Path(os.environ.get("ARTIFACTS_DIR", "./artifacts"))
    targets = argv or ["all"]
    ok = True
    for t in targets:
        if t == "all":
            for name in REQUIRED_ALL:
                ok = validate_one(name, True, artifacts) and ok
            for name in OPTIONAL_ALL:
                ok = validate_one(name, False, artifacts) and ok
        else:
            ok = validate_one(t, True, artifacts) and ok
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
