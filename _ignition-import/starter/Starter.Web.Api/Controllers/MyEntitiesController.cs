using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Starter.Library.Entities;
using Starter.Library.Services;
using Starter.Web.Api.Models;

namespace Starter.Web.Api.Controllers;

[ApiController]
[Authorize(Policy = "User")]
[Route("[controller]")]
public class MyEntitiesController : ControllerBase
{
    private readonly IMyService _myService;

    public MyEntitiesController(IMyService myService)
    {
        this._myService = myService;
    }

    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
    public IActionResult Delete([FromRoute] Guid id)
    {
        this._myService.DeleteEntity(id);
        return this.Ok();
    }

    [HttpGet()]
    [ProducesResponseType<MyEntity[]>(StatusCodes.Status200OK)]
    public IActionResult Get() => this.Ok(this._myService.GetEntities());

    [HttpGet("{id}")]
    [ProducesResponseType<MyEntity>(StatusCodes.Status200OK)]
    [ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
    public IActionResult GetById([FromRoute] Guid id) => this.Ok(this._myService.GetEntity(id));

    [HttpPost()]
    [ProducesResponseType<Guid>(StatusCodes.Status201Created)]
    [ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
    public IActionResult Post([FromBody] MyModel model)
    {
        var entity = new MyEntity(model.Name, model.Description);
        this._myService.SaveEntity(entity);

        return this.Created(this.ToAbsoluteUrl($"MyEntities/{entity.Id}"), entity.Id);
    }

    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
    public IActionResult Put([FromRoute] Guid id, [FromBody] MyModel model)
    {
        var entity = new MyEntity(id, model.Name, model.Description);
        this._myService.SaveEntity(entity);

        return this.Ok(entity.Id);
    }

    [HttpPost("Search")]
    [ProducesResponseType<MyEntity[]>(StatusCodes.Status200OK)]
    [ProducesResponseType<ProblemDetails>(StatusCodes.Status400BadRequest)]
    public IActionResult Search([FromBody] MyModelSearch searchModel) =>
        this.Ok(this._myService.GetEntities(searchModel.Name, searchModel.Description));
}
