using System;
using FieldServe.Library.Models;
using FieldServe.Library.Services;
using Microsoft.AspNetCore.Mvc;

namespace FieldServe.Api.Controllers
{
    [ApiController]
    [Route("Dispatch")]
    public class DispatchController : ControllerBase
    {
        private readonly DispatchAllocator _allocator;

        public DispatchController(DispatchAllocator allocator)
        {
            _allocator = allocator;
        }

        [HttpPost("Assign")]
        public IActionResult Assign([FromBody] AssignRequest req)
        {
            int activeLoad;
            try
            {
                activeLoad = _allocator.Assign(req.WorkOrderId, req.TechnicianId);
            }
            catch (ArgumentException)
            {
                return BadRequest(new { Error = "no such technician" });
            }
            catch (InvalidOperationException)
            {
                return UnprocessableEntity(new { Error = "over capacity" });
            }

            return Ok(new
            {
                TechnicianId = req.TechnicianId,
                WorkOrderId = req.WorkOrderId,
                ActiveLoad = activeLoad
            });
        }
    }
}
