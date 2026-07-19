# Adapter — ASP.NET Web API 2 · Experimental

## Detection
- `Microsoft.AspNet.WebApi.*` 5.x packages; `WebApiConfig.Register`; `ApiController`
  base classes.
- Frequently co-hosted with MVC 5 — profile records both; backend adapter is `webapi2`
  when the API surface dominates, `mvc5` otherwise, and the run report notes the mix.

## Extraction
- Endpoints: `ApiController` actions via convention + attribute routes; include OData
  or `HttpResponseMessage`-returning actions (shape-sensitive — capture goldens
  carefully, serializer differences bite here).
- Run locally via IIS Express; goldens through HTTP.

## Upgrade path (step 05)
- Target: ASP.NET Core controllers (pinned version). `ApiController` → `ControllerBase`
  + `[ApiController]`; `HttpResponseMessage` → `IActionResult`/typed results;
  `HttpConfiguration` (formatters, message handlers) → `Program.cs` options + middleware;
  JSON.NET settings → System.Text.Json (or pinned Newtonsoft compat — record as decision;
  serializer drift is the #1 golden-breaking change in this path).
- Auth: bearer/cookie behavior preserved through step 09 (D-004).

## Hazard hotspots
- Message handlers with ordering assumptions; per-controller formatter overrides;
  `HttpContext.Current` in service layers (hidden `System.Web` coupling in Library-bound
  code — must be flagged, it blocks the restructure's dependency direction).
