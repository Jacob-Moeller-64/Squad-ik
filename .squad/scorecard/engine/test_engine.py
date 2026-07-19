#!/usr/bin/env python3
"""Tier-0 unit tests for the scorecard engine. Run: python3 -m unittest discover -s . -v"""
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import engine  # noqa: E402


def make_repo(tmp: Path):
    (tmp / "App").mkdir(parents=True)
    (tmp / "App" / "packages.config").write_text(
        '<?xml version="1.0"?><packages>'
        '<package id="Newtonsoft.Json" version="6.0.8" targetFramework="net48" />'
        '<package id="jQuery" version="1.10.2" targetFramework="net48" />'
        "</packages>"
    )
    (tmp / "App" / "App.csproj").write_text(
        "<Project><PropertyGroup><TargetFrameworkVersion>v4.8</TargetFrameworkVersion></PropertyGroup></Project>"
    )
    (tmp / "App" / "Big.cs").write_text(
        "public class Big {\n" + "".join(f"  void M{i}() {{ if (true) {{ }} }}\n" for i in range(60)) + "}\n"
    )
    (tmp / "App" / "Sessiony.cs").write_text(
        'public class S { void F() { var x = Session["cart"]; Server.MapPath("~/App_Data"); } }\n'
    )
    (tmp / "App" / "web.config").write_text(
        '<configuration><connectionStrings><add connectionString="Server=db;password=hunter2" /></connectionStrings>'
        '<system.web><sessionState mode="InProc" /></system.web></configuration>'
    )


class ManifestParsing(unittest.TestCase):
    def test_packages_config_and_csproj(self):
        with tempfile.TemporaryDirectory() as d:
            make_repo(Path(d))
            deps = engine.parse_manifests(Path(d))
            names = {(e, n) for e, n, _, _ in deps}
            self.assertIn(("nuget", "Newtonsoft.Json"), names)
            self.assertIn(("nuget", "jQuery"), names)


class VersionCompare(unittest.TestCase):
    def test_ver_lt(self):
        self.assertTrue(engine.ver_lt("6.0.8", "13.0.1"))
        self.assertTrue(engine.ver_lt("1.10.2", "3.5.0"))
        self.assertFalse(engine.ver_lt("13.0.1", "13.0.1"))
        self.assertFalse(engine.ver_lt("13.0.3", "13.0.1"))


class Dimensions(unittest.TestCase):
    def test_cve_hits_legacy_packages(self):
        with tempfile.TemporaryDirectory() as d:
            make_repo(Path(d))
            deps = engine.parse_manifests(Path(d))
            score, findings = engine.dim_security_cve(Path(d), deps)
            ids = {f["id"] for f in findings}
            self.assertIn("CVE-2024-21907", ids)
            self.assertIn("CVE-2020-11022", ids)
            self.assertLess(score, 20)

    def test_eol_flags_netfx(self):
        with tempfile.TemporaryDirectory() as d:
            make_repo(Path(d))
            deps = engine.parse_manifests(Path(d))
            _, findings = engine.dim_dependency_eol(Path(d), deps)
            self.assertIn("eol-netfx", {f["id"] for f in findings})

    def test_twelve_factor_catches_secrets_and_session(self):
        with tempfile.TemporaryDirectory() as d:
            make_repo(Path(d))
            score, findings = engine.dim_twelve_factor(Path(d))
            ids = {f["id"] for f in findings}
            self.assertIn("12f-config", ids)
            self.assertIn("12f-state", ids)
            self.assertLessEqual(score, 9)

    def test_solid_flags_hotspot(self):
        with tempfile.TemporaryDirectory() as d:
            make_repo(Path(d))
            (solid, findings), (cx, _) = engine.dim_solid_and_complexity(Path(d))
            self.assertTrue(any("Big.cs" in f.get("location", "") for f in findings))
            self.assertLess(cx, 5)


class EndToEnd(unittest.TestCase):
    def test_cli_writes_schema_shaped_scorecard(self):
        with tempfile.TemporaryDirectory() as d:
            make_repo(Path(d))
            out = Path(d) / "artifacts" / "scorecard-before.json"
            rc = subprocess.run(
                [sys.executable, str(HERE / "engine.py"), "--phase", "before",
                 "--root", d, "--artifacts", str(Path(d) / "artifacts"), "--out", str(out)],
                capture_output=True, text=True,
            )
            self.assertEqual(rc.returncode, 0, rc.stderr)
            card = json.loads(out.read_text())
            for field in ("engineVersion", "rubricVersion", "scoredAt", "phase", "dimensions", "total"):
                self.assertIn(field, card)
            keys = {dim["key"] for dim in card["dimensions"]}
            self.assertEqual(keys, {"solid", "twelve-factor", "security-cve", "dependency-eol",
                                    "test-coverage", "complexity", "ocp-readiness", "qualitative"})
            self.assertLess(card["total"], 50)  # a legacy repo must score poorly


if __name__ == "__main__":
    unittest.main()
