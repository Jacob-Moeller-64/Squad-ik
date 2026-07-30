using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Starter.Library.Services;
using Starter.Web.Api.Models;

namespace Starter.Web.Api.Controllers;

/// <summary>
/// Exposes a simple anonymous endpoint for testing frontend-to-API calls.
/// </summary>
[ApiController]
[AllowAnonymous]
[Route("[controller]")]
public sealed class PublicTextController : ControllerBase
{
    private readonly ILogger<PublicTextController> _logger;
    private readonly IPublicTextService _publicTextService;

    /// <summary>
    /// Initializes a new instance of the <see cref="PublicTextController"/> class.
    /// </summary>
    public PublicTextController(
        IPublicTextService publicTextService,
        ILogger<PublicTextController> logger
    )
    {
        _publicTextService = publicTextService;
        _logger = logger;
    }

    /// <summary>
    /// Gets a simple text payload without requiring authorization.
    /// </summary>
    [HttpGet]
    [ProducesResponseType<PublicTextResponse>(StatusCodes.Status200OK)]
    public async Task<ActionResult<PublicTextResponse>> Get(CancellationToken cancellationToken)
    {
        var message = await _publicTextService.GetTextAsync(cancellationToken);
        _logger.LogInformation("Returning sample anonymous text payload.");

        return Ok(new PublicTextResponse(message));
    }
}
