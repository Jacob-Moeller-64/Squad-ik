using System.Diagnostics.CodeAnalysis;

namespace Starter.Library.Entities;

public sealed class MyEntity
{
    public Guid Id { get; }

    public required string Name { get; set; }

    public string? Description { get; set; }

    [SetsRequiredMembers]
    public MyEntity(string name, string? description)
    {
        this.Id = Guid.NewGuid();
        this.Name = name;
        this.Description = description;
    }

    [SetsRequiredMembers]
    public MyEntity(Guid id, string name, string? description)
    {
        this.Id = id;
        this.Name = name;
        this.Description = description;
    }
}
