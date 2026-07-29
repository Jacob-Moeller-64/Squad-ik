---
description: Use when planning or executing LegacyCode-to-src restructure work with OpX-Fusion-Transform or the architecture-structure skill. Requires Fusion MCP package catalog and API/docs lookup tools to be checked before inventing Fusion-aligned platform, package, startup, auth, HTTP, data, logging, caching, or UI solutions.
applyTo: '.github/agents/OpX-Fusion-Transform.agent.md,.github/agents/OpX-Fusion-Reviewer.agent.md,.github/skills/architecture-structure/SKILL.md,.github/skills/fusion-restructure-review/SKILL.md,.github/skills/fusion-feature-standards/SKILL.md,.github/prompts/P2-Modernize/**/*.prompt.md,.modernization/ignition-artifacts/modernize/fusion-restructure/**'
---
# Fusion MCP-First Restructure Guidance

Use this file for restructure work that moves app behavior from `LegacyCode/` into the Fusion starter-derived target under `src/`.

For any non-trivial Fusion-aligned decision, treat the Fusion MCP docs and package tools as the first reference surface for available packages, supported APIs, startup patterns, and framework-owned solutions.

## Required lookup order

1. Check the Fusion package catalog first with `fusion-fusion_api_docs_list_packages`.
2. Use `fusion-fusion_api_docs_search` to find likely packages, namespaces, symbols, or feature areas.
3. Fetch the exact package or symbol docs with:
   - `fusion-fusion_api_docs_lookup_package`
   - `fusion-fusion_api_docs_lookup_dotnet_symbol`
   - `fusion-fusion_api_docs_lookup_node_symbol`
4. Use `fusion-fusion_docs_search` or `fusion-fusion_docs_fetch` when the API reference alone is not enough.
5. Use `fusion-fusion_framework_docs_search` or `fusion-fusion_framework_docs_fetch` and the local `Framework/` folder as the equivalent local mirror or supporting reference, not as the first discovery surface.

## Fusion package version selection (required)

- When adding or upgrading Fusion packages, install the latest production version available from Sonatype feeds.
- Applies to NuGet (`Fusion.*`) and npm (`@fusion/*`) dependencies.
- Use Fusion MCP docs/package discovery to determine what package is needed, then resolve the install version from Sonatype production feeds.
- Do not hard-code historical sample versions from prior chats, old snippets, or stale docs when newer production Sonatype versions exist.

## What this means during restructure

- Do not invent app-owned replacements for Fusion-owned concerns until the Fusion package catalog and docs have been checked.
- Prefer documented Fusion packages and starter-aligned composition patterns for:
  - auth and authorization wiring
  - HTTP abstractions and protected API transport
  - startup and DI composition
  - logging, caching, and data-access infrastructure
  - Angular/Fusion UI primitives and app-shell behaviors
  - theme, brand-color binding, and styling-system composition - do not invent orphan CSS custom properties for branding. Bind the legacy palette/typography/sizing through the documented theme API: for `@fusion/theme`, the light/dark theme-generator override map plus the `root/main` header-branding composition (confirm the override-map keys via the `@fusion/theme` README before binding). Force the legacy color scheme instead of inheriting the OS `prefers-color-scheme`.

## Provision the platform by construction

During restructure, the standard Fusion platform tools are wired by the Fusion app builder and configuration, not by hand. Provision them by construction and confirm package names, config keys, and versions via Fusion MCP rather than copying values from another app:

- **Backend** (`src/<AppName>.Web.Api`): compose the host with `FusionWebBuilder.CreateBuilder(...)` + `await builder.BuildAndRunAsync()`. Okta bearer-token validation, Scalar API reference, OpenAPI, caching, CORS, and problem-details are then driven by the appsettings config blocks - `Fusion.Web.Api.EnableApi` and `OpenApi`, `Fusion.Web.Security.IdentityProviders` (Okta web), and `Fusion.Security.Principal` (Okta user-info/roles) - plus the packages `Fusion.Fx.App.Web` and `Fusion.Fx.Security.Web.OAuth.Okta`. Scalar serves at `/scalar` transitively via `Fusion.Fx.App.Web`; do not hand-write `AddScalar`/`MapScalar`.
- **Client** (`src/<AppName>.Web.Client`): wire Okta via `provideNgxFusionAuthOAuthOkta()` in the app config and the `fusion.config` `auth` block (issuer, clientId, redirectUri, logoutUrl, scopes, `pkce: true`, `authenticateOnStart: false`), with `FusionAuthenticatedGuard` / `FusionRoleGuard` on protected routes. Package: `@fusion/ngx-fusion-auth-oauth-okta`.
- Treat a restructured `src/` that is missing Scalar/OpenAPI, the Okta validation config blocks, or the client auth provider as an incomplete provisioning, even when the app compiles. Record the Fusion MCP lookups that confirmed the packages and config keys.
- If Fusion docs show a supported package or pattern, use that as the default path unless repo-specific parity evidence or protected starter ownership rules require a narrower bridge.
- If the Fusion package catalog and docs do not show a suitable supported solution, record that gap explicitly before introducing a custom bridge or workaround.

## Precedence and guardrails

- Repo-specific behavior, parity evidence, and protected starter ownership still decide how the current app is wired.
- Fusion MCP docs and package discovery are the first source for what Fusion already provides.
- Local `Framework/` docs are supporting evidence and a local mirror of the same reference surface when needed, but they should not be used as an excuse to skip the MCP package/doc checks.

## Recording requirement

When restructure work makes a meaningful Fusion package, startup, auth, HTTP, or UI decision, record which Fusion package/docs lookups informed that decision in the modernization artifacts or handoff notes.
