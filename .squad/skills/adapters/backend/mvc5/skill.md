# Adapter — ASP.NET MVC 5 (.NET Framework) · Experimental

## Detection
- `packages.config` or `.csproj` referencing `Microsoft.AspNet.Mvc` 5.x; `Global.asax`
  with `RouteConfig`; `web.config` with `system.web`.
- Record exact framework version (`TargetFrameworkVersion`) in the profile.

## Extraction (steps 00–02)
- Endpoints: controllers/actions via route table (`RouteConfig` + attribute routes).
  Include non-obvious surface: `ActionResult` returning JSON, child actions, MVC
  endpoints acting as APIs for the frontend.
- Run locally: IIS Express against the legacy solution; capture goldens through the
  real HTTP surface, not by invoking controllers directly.

## Upgrade path (step 05)
- Target: ASP.NET Core (version pinned per kit release), controllers-first (closest
  idiom; minimal-API conversion is a later cleanup decision, not an upgrade decision).
- Standard translations: `Global.asax`/`web.config` → `Program.cs` + `appsettings` +
  env config; `System.Web.*` removal; HttpModules/Handlers → middleware; `HttpContext`
  usage → injected `IHttpContextAccessor` or endpoint parameters; MVC filters → Core
  filters/middleware; bundling → frontend build pipeline.
- Auth: forms auth stays functional through step 09 (D-004) — translate to cookie auth
  in Core, do not jump to Okta here.

## Hazard hotspots
- `Session[...]` (InProc by default) — flag in profile hazards; needs distributed cache
  or removal before multi-replica hosting.
- `Server.MapPath` / `App_Data` file writes; `machineKey`-dependent crypto; registry
  and COM references in supporting libraries.
