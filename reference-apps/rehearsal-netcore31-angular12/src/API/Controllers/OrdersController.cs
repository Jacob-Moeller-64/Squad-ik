using System;
using LegacyShop.Library.Data;
using LegacyShop.Library.Models;
using LegacyShop.Library.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace LegacyShop.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrdersController : ControllerBase
    {
        private readonly PricingService _pricing;
        private readonly ShippingCalculator _shipping;
        private readonly ILogger<OrdersController> _logger;

        public OrdersController(PricingService pricing, ShippingCalculator shipping,
            ILogger<OrdersController> logger)
        {
            _pricing = pricing;
            _shipping = shipping;
            _logger = logger;
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

            // Modernized: session state removed (stateless process), file audit replaced
            // with structured stdout logging (12-factor).
            _logger.LogInformation("Order {OrderId} placed: total {TotalCents}c", orderId, totalCents);

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
