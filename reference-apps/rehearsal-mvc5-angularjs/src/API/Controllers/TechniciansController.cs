using FieldServe.Library.Data;
using Microsoft.AspNetCore.Mvc;

namespace FieldServe.Api.Controllers
{
    [ApiController]
    [Route("Technicians")]
    public class TechniciansController : ControllerBase
    {
        [HttpGet("List")]
        public IActionResult List() => Ok(Repo.Technicians);

        [HttpGet("Detail/{id:int}")]
        public IActionResult Detail(int id)
        {
            var tech = Repo.FindTechnician(id);
            if (tech == null) return NotFound(new { Error = "not found" });
            return Ok(tech);
        }
    }
}
