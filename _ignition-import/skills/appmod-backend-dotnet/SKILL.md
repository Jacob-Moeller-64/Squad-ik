---
name: "appmod-backend-dotnet"
description: ".NET Framework -> modern .NET upgrade + restructure into src/{Library,API}, with the runtime traps that a green build hides."
domain: "backend"
confidence: "high"
source: "earned (Ignition Kit Step 7 + dotnet standards)"
---

## Context

The backend agent owns this. Upgrade in an ISOLATED workspace (never mutate `LegacyCode/`), behavior
commits only, then move into `src/<App>.Library` (domain first) then `src/<App>.Web.Api` (move-only, D-007).

## Patterns

- Upgrade in dependency order: shared libraries -> backend libraries -> entry host. Retarget SDK-style projects to the resolved even .NET version. A copied project still on `.NET Framework` is NOT an upgraded handoff.
- **Single-version invariant:** after all package changes, every shared package resolves to exactly ONE version across the whole closure. Move majors atomically.
- Compose the connection string once at startup from split SQL env vars (`SqlServer__Server/Database/Username/Password/Encrypt/TrustServerCertificate`) into `ConnectionStrings` (D-014).
- Scalar/OpenAPI is provisioned by construction via `Fusion.Fx.App.Web` (config blocks `Fusion.Web.Api.EnableApi` + `OpenApi`); do NOT hand-write `AddScalar`/`MapScalar`. The published endpoint set must EXACTLY match the inventory.
- Consumer-complete route parity: every frontend-consumed family (list/detail/create/update/delete/export/current-user) exists on the target or is a recorded temporary bridge.

## Examples

- Bind SQL params with explicit type: `command.Parameters.Add("@P", SqlDbType.SmallInt).Value = (short)value;`
- Restore legacy TLS behavior: add `TrustServerCertificate=True` (or `Encrypt=False`) to every connection string.

## Anti-Patterns

- **"Build-green is NOT done."** A clean build only proves each project compiles against its own referenced versions. You are done only when the backend STARTS and a real authenticated route returns real data.
- **Split-version package trap** — builds green, only the highest version ships, the sibling faults at runtime. Prevent with the single-version invariant.
- **SqlClient `Encrypt` default flipped to true** (SqlClient 4.0+ via EF Core 7/8) — green build, then 500 at the first DB hit: `InnerMessage` = "The certificate chain was issued by an authority that is not trusted." Not environmental.
- **`AddWithValue` infers the wrong `SqlDbType`** — SQL silently returns zero rows; the API answers HTTP 200 with `[]` and no exception. Bind the explicit column type.
- **Dapper materialization mismatch** — mapping SQL `int` into a `string` constructor param throws "a parameterless default constructor or one matching signature ... is required."
- Leaving `Microsoft.AspNetCore.SpaServices.Extensions` (removed in .NET 8+) or other retired packages in place.
