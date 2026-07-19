using System;
using System.IO;
using LegacyShop.Api.Data;
using LegacyShop.Api.Models;
using LegacyShop.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace LegacyShop.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly PricingService _pricing;
        private readonly ShippingCalculator _shipping;
        private readonly IConfiguration _config;
        private readonly IWebHostEnvironment _env;

        public OrdersController(PricingService pricing, ShippingCalculator shipping,
            IConfiguration config, IWebHostEnvironment env)
        {
            _pricing = pricing;
            _shipping = shipping;
            _config = config;
            _env = env;
        }

        [HttpPost]
        public IActionResult Create([FromBody] OrderRequest order)
        {
            PricingResult pricing;
            try
            {
                pricing = _pricing.Price(order.Lines, order.PromoCode);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }

            var region = order.ShipTo?.Region ?? "US";
            int shippingCents = _shipping.Calculate(order.Lines, region, pricing.SubtotalCents);
            int totalCents = pricing.SubtotalCents - pricing.DiscountCents + shippingCents;

            var orderId = Guid.NewGuid().ToString("N");
            HttpContext.Session.SetString("LastOrderId", orderId); // in-memory session hazard

            // Local file audit trail: ephemeral-filesystem hazard.
            var auditPath = Path.Combine(_env.ContentRootPath, _config["AuditLogPath"]);
            Directory.CreateDirectory(Path.GetDirectoryName(auditPath));
            System.IO.File.AppendAllText(auditPath, orderId + "\t" + totalCents + Environment.NewLine);

            Repo.OrderHistory.Add(new OrderRecord { OrderId = orderId, PlacedAt = DateTime.UtcNow, TotalCents = totalCents });

            return Ok(new
            {
                orderId,
                subtotalCents = pricing.SubtotalCents,
                discountPercent = pricing.DiscountPercent,
                discountCents = pricing.DiscountCents,
                shippingCents,
                totalCents
            });
        }

        [Authorize]
        [HttpGet("history")]
        public IActionResult History() => Ok(Repo.OrderHistory);
    }
}
