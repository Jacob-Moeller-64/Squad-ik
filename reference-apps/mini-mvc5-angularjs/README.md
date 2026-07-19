# Mini reference app — mvc5 + angularjs (flagship profile)

The Tier-2 eval target: a deliberately tiny legacy app containing every *kind* of thing
the flagship profile handles, at minimum size.

## What's inside

- **`LegacyApplication/`** — the migration subject. ASP.NET MVC 5 (.NET Framework 4.8)
  serving JSON to an AngularJS 1.x frontend. Deliberately seeded with the hazards the
  kit must detect and fix:
  - `Session["LastOrderId"]` + `sessionState mode="InProc"` (statelessness violation)
  - `Server.MapPath`/`App_Data` file write (ephemeral-filesystem hazard)
  - Hardcoded connection string with a password in `web.config` (12-factor violation)
  - File-based log path (logs-to-stdout violation)
  - Vulnerable/EOL packages: Newtonsoft.Json 6.0.8, jQuery 1.10.2, .NET Framework target
  - `Services/PricingService.cs` — branchy discount logic with legacy quirks
    (integer-truncation rounding; VIP code ignored at the top tier). This is the
    characterization-test target: tests must PIN these quirks, not fix them.
- **`harness/serve.py`** — a stdlib Python stand-in for IIS Express so the "running
  legacy app" exists on Linux eval machines. Serves the real AngularJS frontend and
  implements the same endpoints with behavior-identical logic (including the quirks).
  It is eval scaffolding, NOT part of the migration subject — the pipeline migrates
  `LegacyApplication/`, never `harness/`. On Windows, run the real thing under IIS
  Express instead.
- **`artifacts/`** — the canonical Phase-0/1 artifacts for this app (profile,
  inventories, goldens captured from the running harness, baselines).

## Running the harness

```bash
python3 harness/serve.py --port 8123
# app:       http://localhost:8123/
# endpoints: GET /Products/List · GET /Products/Detail/{id} · POST /Orders/Create
#            POST /Account/Login (demo/demo123) · GET /Orders/History (forms-auth)
```

Auth: legacy forms auth (`.ASPXAUTH` cookie). Protected goldens replay with
`TEST_COOKIE=".ASPXAUTH=demo-ticket"`; anonymous access to `/Orders/History` goldens the
302 login redirect. This is the legacy scheme the Okta strangler (D-004) migrates.

## Characterization suite (step-04 reference)

`./run-characterization.sh` (or `.ps1`) runs 14 tests pinning the PricingService quirks
(tier boundaries, VIP-ignored-above-top-tier, integer truncation) against the harness's
`harness/pricing.py` port, and writes the cobertura report to
`artifacts/coverage/coverage.xml` (100% branch coverage of the pricing logic). On
Windows, port the same assertions to MSTest/xUnit against `Services/PricingService.cs`.

**Reproducing `scorecard-before.json`:** the before-score is a step-03 artifact,
captured *before* the characterization suite exists — regenerate it with
`artifacts/coverage/` absent (temporarily move it aside), or the kit-generated coverage
inflates the "legacy" score.

## Eval flow (Tier 2)

1. Start the harness (the "running legacy app").
2. Run the pipeline against `LegacyApplication/`.
3. Gates use `artifacts/` as the ground truth: goldens replay, baselines diff,
   scorecard delta. The delta must be stable release-to-release — a moving delta on an
   unchanged app means the kit drifted.
