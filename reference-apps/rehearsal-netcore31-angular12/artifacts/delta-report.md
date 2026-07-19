# Modernization Delta Report — LegacyShop (rehearsal-netcore31-angular12)

**Before: 44/100 → After: 86/100** (frozen engine 0.2.1 both phases — D-008)

| Dimension | Before | After | What changed |
|---|---|---|---|
| solid | 15/15 | 15/15 | held |
| twelve-factor | 3/15 | 15/15 | hardcoded conn-string password removed (env config); file audit log → stdout structured logging; in-memory session eliminated (stateless) |
| security-cve | 15/20 | 20/20 | Newtonsoft.Json 12.0.1 (known high CVE, flagged by NuGet itself at build) eliminated with the platform upgrade |
| dependency-eol | 4/10 | 10/10 | netcoreapp3.1 (EOL 2022) → .NET 10 LTS; Angular 12 (out of LTS) → Angular 18 |
| test-coverage | 0/15 | 15/15 | characterization suite: 21 xUnit tests, 94% branch coverage of Library services (`dotnet test --collect`) |
| complexity | 5/5 | 5/5 | held |
| ocp-readiness | 2/10 | 6/10 | 8080 default + /health + forwarded-headers added; remaining findings are the step-00 profile's recorded legacy hazards handed to the deployment checklist as "verify remediated" |
| qualitative | 0/10 | 0/10 | LLM judge not run in this rehearsal (pins.json judge unset) |

## Behavior preservation evidence
- **Goldens:** 16/16 against the legacy app; 16/16 against the modernized backend
  (dual-stack phase); **14/14 against the final bearer-only stack** (account endpoints
  retired by the auth strangler — RD-3). Every business quirk pinned and preserved:
  VIP-ignored-above-top-tier, pre-discount free-shipping threshold, per-line oversize
  handling surviving free shipping, silent partial allocation, bulk-desk rejection,
  integer truncation.
- **Characterization:** 21/21 green at every step, re-pointed (not rewritten) through
  the restructure (RD-1).
- **Visual:** Angular 12→18 port was pixel-identical on 4/6 routes (0.000%); the 2
  diffs were the intentional SSO login flip, triaged and re-baselined (RD-2). Fusion
  swap re-baselined at step 18 per the design-system standard.

## Transformation summary
- .NET Core 3.1 `Startup.cs` API → .NET 10 minimal hosting in `src/{Library, API}`
  (Fusion three-folder; `src/Client` = Angular 18 standalone)
- Swashbuckle Swagger UI → **Scalar** (`/scalar/v1`), OpenAPI surface = inventory
- Cookie forms auth → **OIDC bearer (Okta-shaped)**: discovery + JWKS + RS256 validated
  by JwtBearer; strangler executed in three steps (dual-stack → SPA flip → legacy path
  removed); local stand-in issuer (RD-5) — real Okta swaps in via `Oidc:Issuer` config
- Components swapped to fusion-ui counterparts per `component-map.json` (5 swap,
  5 survive, 0 blocked)
- Legacy toolchain friction reproduced authentically (EOL runtime uninstallable →
  roll-forward; Angular 12 needed the OpenSSL legacy-provider workaround) vs. the
  modern stack building clean in 7s — the modernization dividend in tooling alone.
