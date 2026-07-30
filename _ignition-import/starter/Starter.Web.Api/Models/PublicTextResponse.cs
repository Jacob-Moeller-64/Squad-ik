namespace Starter.Web.Api.Models;

/// <summary>
/// Response payload returned by the anonymous sample text endpoint.
/// </summary>
/// <param name="Message">The text returned to the caller.</param>
public sealed record PublicTextResponse(string Message);
