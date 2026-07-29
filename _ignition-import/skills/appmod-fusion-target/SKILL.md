---
name: "appmod-fusion-target"
description: "The shared Fusion target: structure, Okta/OIDC, Scalar, and component swap — provisioned by construction, confirmed via Fusion MCP."
domain: "fusion"
confidence: "high"
source: "earned (Ignition Kit fusion-mcp-restructure + target skills)"
---

## Context

The shared target-side implementation for all apps. Fusion MCP (pinned) is the SOLE authority on
structure and component counterparts (D-006, D-016) — check the package catalog + docs before inventing
an app-owned replacement, and record which lookups informed each decision.

## Patterns

- **Structure / provision by construction:**
  - Backend (`src/<App>.Web.Api`): `FusionWebBuilder.CreateBuilder(...)` + `await builder.BuildAndRunAsync()`. Okta, Scalar, OpenAPI, caching, CORS driven by appsettings config blocks. Packages `Fusion.Fx.App.Web`, `Fusion.Fx.Security.Web.OAuth.Okta`.
  - Client (`src/<App>.Web.Client`): `provideNgxFusionAuthOAuthOkta()` + the `fusion.config` `auth` block (issuer, clientId, redirectUri, logoutUrl, scopes, `pkce: true`, `authenticateOnStart: false`); `FusionAuthenticatedGuard` / `FusionRoleGuard` on protected routes. Package `@fusion/ngx-fusion-auth-oauth-okta`.
- **Okta / auth strangler (D-004):** preserve legacy -> flip frontend to Okta -> remove legacy path (gated by `check-auth-removed`). Policy-based authorization only (D-013).
- **Scalar:** serves at `/scalar` transitively via `Fusion.Fx.App.Web`; do NOT hand-write `AddScalar`/`MapScalar`. Internal-only by default (D-005).
- **Component swap:** one primitive family at a time, one component per commit; standard grid = `FusionDataGridBasicComponent`, free-text+suggest = `FusionSuggestionTextboxComponent`. No-counterpart components are wrapped, recorded, reported (D-003).

## Examples

- A restructured `src/` missing Scalar/OpenAPI, the Okta config blocks, or the client auth provider is INCOMPLETE provisioning even if it compiles.

## Anti-Patterns

- Authoring `AddAuthentication(...)` / `AddJwtBearer(...)` / custom Swagger from memory when the starter shell already owns it.
- A route counted "Fusion-complete" just because `<fusion-...>` tags exist — runtime smoke must prove the Fusion theme is actually applied.
- Pinning Fusion packages to stale sample versions instead of the latest production Sonatype version (D-015).
