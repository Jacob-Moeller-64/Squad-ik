using System;
using System.Linq;
using LegacyShop.Library.Data;
using LegacyShop.Library.Models;
using LegacyShop.Library.Services;
using Microsoft.AspNetCore.Mvc;

namespace LegacyShop.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class WarehouseController : ControllerBase
    {
        private readonly InventoryAllocator _allocator;

        public WarehouseController(InventoryAllocator allocator)
        {
            _allocator = allocator;
        }

        [HttpGet("stock")]
        public IActionResult Stock()
        {
            var rows = Repo.Products.Select(p =>
            {
                Repo.Allocations.TryGetValue(p.Id, out var allocated);
                return new { productId = p.Id, allocated, available = Math.Max(0, p.StockQty - allocated) };
            }).ToList();
            return Ok(rows);
        }

        [HttpPost("allocate")]
        public IActionResult Allocate([FromBody] AllocationRequest request)
        {
            try
            {
                var (allocated, backordered) = _allocator.Allocate(request.ProductId, request.Qty);
                return Ok(new { productId = request.ProductId, allocated, backordered });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
            catch (InvalidOperationException ex)
            {
                return UnprocessableEntity(new { error = ex.Message });
            }
        }
    }
}
