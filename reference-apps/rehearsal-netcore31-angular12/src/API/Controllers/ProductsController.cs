using System.Linq;
using LegacyShop.Library.Data;
using Microsoft.AspNetCore.Mvc;

namespace LegacyShop.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase
    {
        [HttpGet]
        public IActionResult List() => Ok(Repo.Products);

        [HttpGet("search")]
        public IActionResult Search([FromQuery] string q)
        {
            var term = (q ?? string.Empty).Trim().ToLowerInvariant();
            var hits = Repo.Products
                .Where(p => p.Name.ToLowerInvariant().Contains(term) || p.Category.ToLowerInvariant().Contains(term))
                .ToList();
            return Ok(hits);
        }

        [HttpGet("{id:int}")]
        public IActionResult Detail(int id)
        {
            var product = Repo.FindProduct(id);
            if (product == null) return NotFound(new { error = "not found" });
            return Ok(product);
        }
    }
}
