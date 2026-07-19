# Run decisions — rehearsal-netcore31-angular12

Run-local decisions, per kit `decisions.md` conventions. Kit policies D-001…D-010 apply.

**RD-1** · steps 06/11 · Characterization suite moved with the code: `Compile` includes
re-pointed `LegacyApplication/Api/*` → `src/Library/*`, and `using LegacyShop.Api.*` →
`using LegacyShop.Library.*` in the three test files. Mechanical rider of the namespace
move — zero assertions changed (D-001 compliant). Suite 21/21 green before and after.

**RD-2** · step 15 · Visual triage: 4/6 routes pixel-identical (0.000%) after the
Angular 12→18 port. `/login` and `/history` (unauthenticated redirect view) differ by
2.808% — the intentional step-14 SSO flip (primary "Sign in with SSO" button, legacy
credentials demoted). Classified: intentional behavior change, approved. Phase-1 legacy
baselines archived to `baselines-phase1-legacy/`; the two routes re-baselined.

**RD-3** · step 17 · Legacy cookie auth path removed from the API (scheme + Account
endpoints). Contract change vs the Phase-1 inventory: `POST /api/account/login` and
`/api/account/logout` deleted; `/api/orders/history` auth is bearer-only. Endpoint
inventory updated accordingly; the login goldens retired; history replayed with
TEST_BEARER. This is the planned strangler completion, not a dropped feature.

**RD-4** · structure gates · `LegacyApplication/` is retained in this repo deliberately
as the before-reference of a reference app (normally deleted at step 11). Full-phase
structure and after-scorecard gates therefore run against an app-view containing only
`src/` (+ shared artifacts), documented here instead of deleting the reference.

**RD-5** · run environment · The 3.1 runtime is EOL and uninstallable; the legacy app
executed via DOTNET_ROLL_FORWARD on the .NET 10 runtime. Okta and Fusion are
represented by stand-ins (local OIDC issuer with real JWKS/RS256 validation; fusion-ui
as a local design-system component set) because no real tenant/MCP is reachable from
the rehearsal environment. Consuming code is written so real endpoints swap in via
config only.
