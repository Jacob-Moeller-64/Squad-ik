using System;
using System.Collections.Generic;
using System.IO;
using System.Web.Mvc;
using LegacyApplication.Models;
using LegacyApplication.Services;
using Newtonsoft.Json;

namespace LegacyApplication.Controllers
{
    public class OrdersController : Controller
    {
        private readonly PricingService _pricing = new PricingService();

        // POST /Orders/Create   body: { "lines": [...], "promoCode": "VIP" }
        [HttpPost]
        public JsonResult Create()
        {
            var body = new StreamReader(Request.InputStream).ReadToEnd();
            var order = JsonConvert.DeserializeObject<OrderRequest>(body);

            PricingResult result;
            try
            {
                result = _pricing.Price(order.Lines, order.PromoCode);
            }
            catch (ArgumentException ex)
            {
                Response.StatusCode = 400;
                return Json(new { error = ex.Message });
            }

            var orderId = Guid.NewGuid().ToString("N");
            Session["LastOrderId"] = orderId; // InProc session: statelessness hazard

            // Legacy audit trail: local file write, ephemeral-filesystem hazard.
            var auditPath = Server.MapPath("~/App_Data/orders.log");
            System.IO.File.AppendAllText(auditPath, orderId + "\t" + result.TotalCents + Environment.NewLine);

            return Json(new
            {
                orderId,
                subtotalCents = result.SubtotalCents,
                discountPercent = result.DiscountPercent,
                discountCents = result.DiscountCents,
                totalCents = result.TotalCents
            });
        }

        public class OrderRequest
        {
            public List<OrderLine> Lines { get; set; }
            public string PromoCode { get; set; }
        }
    }
}
