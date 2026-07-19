#!/usr/bin/env python3
"""Replay golden request/response pairs from endpoint-inventory.json against a base URL.

Deterministic: stdlib only, no retries that mask flakiness, no LLM involvement.
Request file format (JSON): {"query": "a=1&b=2", "headers": {...}, "body": <json|string>}
Response file: expected JSON body (normalized) — or raw text for non-JSON endpoints.
normalizedFields: field NAMES replaced with "<NORMALIZED>" recursively in both expected
and actual before comparison.

Auth: endpoints with auth != public send Authorization: Bearer $TEST_BEARER and/or
Cookie: $TEST_COOKIE when those env vars are set.
Exit: 0 all goldens match; 1 any mismatch/error.
"""
import json
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path


def normalize(obj, fields):
    if isinstance(obj, dict):
        return {k: ("<NORMALIZED>" if k in fields else normalize(v, fields)) for k, v in obj.items()}
    if isinstance(obj, list):
        return [normalize(v, fields) for v in obj]
    return obj


def replay(base_url, inv_path):
    inv = json.loads(Path(inv_path).read_text())
    inv_dir = Path(inv_path).parent
    results = []
    for ep in inv["endpoints"]:
        for g in ep["goldens"]:
            name = f"{ep['method']} {ep['path']} [{g['name']}]"
            try:
                req_spec = json.loads((inv_dir / g["requestFile"]).read_text()) if g.get("requestFile") else {}
                url = base_url.rstrip("/") + ep["path"]
                if req_spec.get("query"):
                    url += "?" + req_spec["query"]
                body = req_spec.get("body")
                data = json.dumps(body).encode() if isinstance(body, (dict, list)) else (body.encode() if body else None)
                req = urllib.request.Request(url, data=data, method=ep["method"])
                for k, v in (req_spec.get("headers") or {}).items():
                    req.add_header(k, v)
                if data is not None and not req.has_header("Content-type"):
                    req.add_header("Content-Type", "application/json")
                if ep.get("auth") != "public":
                    if os.environ.get("TEST_BEARER"):
                        req.add_header("Authorization", f"Bearer {os.environ['TEST_BEARER']}")
                    if os.environ.get("TEST_COOKIE"):
                        req.add_header("Cookie", os.environ["TEST_COOKIE"])
                try:
                    with urllib.request.urlopen(req, timeout=15) as resp:
                        status, raw = resp.status, resp.read()
                except urllib.error.HTTPError as e:
                    status, raw = e.code, e.read()

                if status != g["status"]:
                    results.append((name, False, f"status {status} != {g['status']}"))
                    continue
                expected_raw = (inv_dir / g["responseFile"]).read_text()
                fields = set(g.get("normalizedFields") or [])
                try:
                    actual = normalize(json.loads(raw.decode()), fields)
                    expected = normalize(json.loads(expected_raw), fields)
                    ok = actual == expected
                    detail = "" if ok else "body mismatch (JSON)"
                except json.JSONDecodeError:
                    ok = raw.decode().strip() == expected_raw.strip()
                    detail = "" if ok else "body mismatch (raw)"
                results.append((name, ok, detail))
            except Exception as e:  # noqa: BLE001 — every golden must report, never abort the run
                results.append((name, False, f"error: {e}"))
    return results


def main():
    if len(sys.argv) < 2:
        print("usage: verify_goldens.py <base-url> [inventory-path]", file=sys.stderr)
        return 2
    base_url = sys.argv[1]
    inv = sys.argv[2] if len(sys.argv) > 2 else os.path.join(os.environ.get("ARTIFACTS_DIR", "./artifacts"), "endpoint-inventory.json")
    if not Path(inv).is_file():
        print(f"FAIL: {inv} missing — run step 01 first", file=sys.stderr)
        return 1
    results = replay(base_url, inv)
    passed = sum(1 for _, ok, _ in results if ok)
    for name, ok, detail in results:
        print(f"{'ok  ' if ok else 'FAIL'}: {name}{'  — ' + detail if detail else ''}")
    print(f"goldens: {passed}/{len(results)} passed")
    return 0 if passed == len(results) and results else 1


if __name__ == "__main__":
    sys.exit(main())
