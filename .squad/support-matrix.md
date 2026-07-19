# Support Matrix

Tiers:
- **Supported** — adapter complete, mini reference app exists, exercised by every kit release (Tier-2 eval).
- **Experimental** — adapter exists; runs require human supervision; no mini app yet.
- **Planned** — directory stub only. Profile detection reports these as unsupported (halt).

Promotion to Supported requires: adapter skills complete + mini app built + a full
Tier-2 run passing with a stable scorecard delta.

## Backend

| Profile | Adapter | Tier | Mini app |
|---|---|---|---|
| ASP.NET MVC 5 (.NET Framework) | `adapters/backend/mvc5` | Experimental | — |
| ASP.NET Web API 2 | `adapters/backend/webapi2` | Experimental | — |
| .NET Core 3.1 | `adapters/backend/netcore31` | Planned | — |
| ASP.NET WebForms | `adapters/backend/webforms` | Planned | — |

## Frontend

| Profile | Adapter | Tier | Mini app |
|---|---|---|---|
| AngularJS (1.x) | `adapters/frontend/angularjs` | Experimental | — |
| Angular 8–13 | `adapters/frontend/angular-8-13` | Experimental | — |
| Angular 14+ | `adapters/frontend/angular-14plus` | Planned | — |

## Flagship profile

`mvc5` + `angularjs` (most common legacy combination — confirm against the real
portfolio). The flagship profile gets the realistic-sized Tier-3 rehearsal app; all
other Supported profiles get mini apps only.
