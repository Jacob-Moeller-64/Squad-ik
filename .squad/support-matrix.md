# Support Matrix

Tiers:
- **Supported** — adapter complete, mini reference app exists, AND a full Tier-2 run passes with a stable scorecard delta on every kit release.
- **Experimental** — adapter exists; runs require human supervision. A mini app may exist without conferring Supported status until the full Tier-2 run passes.
- **Planned** — directory stub only. Profile detection reports these as unsupported (halt).

Promotion to Supported requires: adapter skills complete + mini app built + a full
Tier-2 run passing with a stable scorecard delta.

## Backend

| Profile | Adapter | Tier | Mini app |
|---|---|---|---|
| ASP.NET MVC 5 (.NET Framework) | `adapters/backend/mvc5` | Experimental | `reference-apps/mini-mvc5-angularjs` |
| ASP.NET Web API 2 | `adapters/backend/webapi2` | Experimental | — |
| .NET Core 3.1 | `adapters/backend/netcore31` | Planned | — |
| ASP.NET WebForms | `adapters/backend/webforms` | Planned | — |

## Frontend

| Profile | Adapter | Tier | Mini app |
|---|---|---|---|
| AngularJS (1.x) | `adapters/frontend/angularjs` | Experimental | `reference-apps/mini-mvc5-angularjs` |
| Angular 8–13 | `adapters/frontend/angular-8-13` | Experimental | — |
| Angular 14+ | `adapters/frontend/angular-14plus` | Planned | — |

## Flagship profile

`mvc5` + `angularjs` (most common legacy combination — confirm against the real
portfolio). The flagship profile gets the realistic-sized Tier-3 rehearsal app; all
other Supported profiles get mini apps only.
