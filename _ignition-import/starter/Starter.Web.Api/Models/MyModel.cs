using System.ComponentModel.DataAnnotations;

namespace Starter.Web.Api.Models;

public sealed class MyModel
{
    [Required]
    public required string Name { get; set; }

    public string? Description { get; set; }
}
