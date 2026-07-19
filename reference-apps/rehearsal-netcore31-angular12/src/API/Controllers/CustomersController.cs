using System.Linq;
using LegacyShop.Library.Data;
using Microsoft.AspNetCore.Mvc;

namespace LegacyShop.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CustomersController : ControllerBase
    {
        [HttpGet]
        public IActionResult List() => Ok(Repo.Customers);

        [HttpGet("{id:int}")]
        public IActionResult Detail(int id)
        {
            var customer = Repo.Customers.FirstOrDefault(c => c.Id == id);
            if (customer == null) return NotFound(new { error = "not found" });
            return Ok(customer);
        }
    }
}
