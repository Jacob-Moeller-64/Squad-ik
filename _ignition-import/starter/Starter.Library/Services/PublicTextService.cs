namespace Starter.Library.Services;

/// <summary>
/// Provides sample text for an anonymous API endpoint.
/// </summary>
public interface IPublicTextService
{
    /// <summary>
    /// Gets the sample text payload.
    /// </summary>
    Task<string> GetTextAsync(CancellationToken cancellationToken = default);
}

/// <summary>
/// Returns a fixed text response for quick API connectivity checks.
/// </summary>
public sealed class DefaultPublicTextService : IPublicTextService
{
    /// <inheritdoc />
    public Task<string> GetTextAsync(CancellationToken cancellationToken = default) =>
        Task.FromResult("Hello from the anonymous sample API.");
}
