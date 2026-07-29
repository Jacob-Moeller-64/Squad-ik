using Starter.Library.Entities;

namespace Starter.Library.Services;

public interface IMyService
{
    void DeleteEntity(Guid id);
    IEnumerable<MyEntity> GetEntities();
    IEnumerable<MyEntity> GetEntities(string? name, string? description);
    MyEntity? GetEntity(Guid id);
    void SaveEntity(MyEntity entity);
}

public sealed class DefaultMyService : IMyService
{
    private readonly Dictionary<Guid, MyEntity> _repo = [];

    public void DeleteEntity(Guid id) => this._repo.Remove(id);

    public MyEntity? GetEntity(Guid id) =>
        this._repo.TryGetValue(id, out var entity) ? entity : null;

    public IEnumerable<MyEntity> GetEntities() => this._repo.Values;

    public IEnumerable<MyEntity> GetEntities(string? name, string? description)
    {
        IEnumerable<MyEntity> entities = this._repo.Values;

        if (!string.IsNullOrWhiteSpace(name))
            entities = entities.Where(p =>
                p.Name.Contains(name, StringComparison.OrdinalIgnoreCase)
            );

        if (!string.IsNullOrWhiteSpace(description))
            entities = entities.Where(p =>
                p.Description?.Contains(description, StringComparison.OrdinalIgnoreCase) ?? false
            );

        return entities;
    }

    public void SaveEntity(MyEntity entity) => this._repo[entity.Id] = entity;
}
