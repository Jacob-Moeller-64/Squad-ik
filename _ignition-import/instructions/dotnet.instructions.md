---
description: ".NET coding standards."
applyTo: "**/*.cs"
---

## General

- Use #tool:microsoftdocs/mcp/* to research relevant best practices, project analysis, and documentation.
- When troubleshooting breakages after upgrades, consult `patch-notes/**` first (or the MCP tools if available).
- Ensure suggestions satisfy **ALL** .NET analyzers.
- File names should match the primary type defined within.
- Avoid `#nullable disable` unless absolutely necessary.
- Avoid suppressing warnings or errors; prefer fixing the underlying issue.
- Use **expression-bodied members** and modern C# features where they improve clarity, but avoid cleverness that impairs readability.
- When creating parallel work, prefer **`Task.WhenAll`**/**`Task.WhenAny`** patterns over manual thread management.
- Favor **LINQ** for clarity; avoid multiple enumerations of `IEnumerable<T>` when expensive.
- Use the type that allows the most flexibility (e.g., `IEnumerable<T>` over `List<T>` for parameters).
- When capturing errors, use the `Fusion.Fx.IErrorService` service which already logs and executes policies.
- Do **NOT** use argument null checks; we have nullability annotations and analyzers to catch these at compile time.
- Types should be in separate files unless they are private nested types or very small related types (e.g., enums, delegates).
  - Non-trivial types should be in their own files for clarity and maintainability.

## Async/await

- Prefer **async/await** following TAP.
- Avoid blocking (`.Result/.Wait()`)
- Return `Task/Task<T>`
- Use `CancellationToken`.
- Name async methods with the `Async` suffix when they return Task/ValueTask/IAsyncEnumerable; avoid `Async` otherwise.

## Dependency Injection

- Register services with appropriate lifetimes.
- Avoid service locator.
- Keep services small/testable.
- Container handles disposal.

## Formatting, Styles, and Quality

- CSharpier for code formatting.
- Static Code Analysis for formatting, style, and quality.
- Adhere to `.editorconfig` settings.
  - Naming conventions.
  - Style rules.
  - Static analysis rules.

## Logging

- Inject `ILogger<T>`;

## Metrics/Tracing

- Prefer OpenTelemetry where available
- Expose health endpoints/readiness checks for services.


## Data Access (ADO.NET / SqlClient parameter typing)

When porting legacy SQL queries into modernized repositories, **bind every parameter with an explicit SqlDbType that matches the column** instead of using `SqlCommand.Parameters.AddWithValue(...)` on raw .NET primitives.

- `AddWithValue(name, intValue)` infers `SqlDbType.Int` (Int32). If the underlying column is `SMALLINT`, `TINYINT`, `BIT`, `DECIMAL`, or `VARCHAR(n)` (vs `NVARCHAR`), SQL Server applies implicit conversions that **silently return zero rows** or break index seeks, while the API still answers `HTTP 200` with an empty array.
- Symptom signature: legacy worked, modern controller responds 200 OK with `[]`, frontend shows "no results / empty list" for valid keys, no exception is logged.
- Mandatory pattern: `command.Parameters.Add("@P", SqlDbType.SmallInt).Value = (short)value;` (or the matching `SqlDbType` for the actual column). Cast the .NET value to the matching CLR type at the parameter boundary.
- When the legacy code explicitly casts (e.g. `Convert.ToInt16(S)`), that is the load-bearing evidence of the column type -- preserve it on the modern side.
- Verify against `sys.columns` / table schema, not just the C# property type, before choosing the `SqlDbType`.

## Data Access (Dapper typed materialization parity)

When using Dapper typed materialization (`Query<T>`, `QuerySingle<T>`, `QueryFirst<T>`, record/class constructor mapping), the target CLR member types MUST match the SQL result column types for that materialization shape.

- Do not map SQL `int` columns directly into a Dapper constructor parameter typed as `string`.
- Do not rely on downstream implicit conversions for constructor-bound mapping.
- For ID or code fields where the API contract wants a different type than the DB column (for example DB `int` but API `string`), materialize first into a DB-shape row type with matching CLR types, then project to the API/entity contract in a second explicit mapping step.
- Treat this runtime exception signature as a hard blocker: `A parameterless default constructor or one matching signature (...) is required ... materialization`.
- For each newly ported DB query in modernization steps, run at least one real runtime call that executes the query path and verify no Dapper materialization exception is thrown before marking the seam complete.
