using System;
using System.IO;
using System.Web.Mvc;
using FieldServe.Data;
using FieldServe.Models;
using FieldServe.Services;
using Newtonsoft.Json;

namespace FieldServe.Controllers
{
    public class InvoicesController : Controller
    {
        private readonly InvoiceCalculator _calculator = new InvoiceCalculator();

        // POST /Invoices/Quote
        // body: { "LaborHours": 3, "HourlyRateCents": 9500, "PartsCents": [1200, 4500], "Visits": 1 }
        [HttpPost]
        public JsonResult Quote()
        {
            var body = new StreamReader(Request.InputStream).ReadToEnd();
            var req = JsonConvert.DeserializeObject<QuoteRequest>(body)
                      ?? new QuoteRequest();

            InvoiceQuote result;
            try
            {
                result = _calculator.Quote(req.LaborHours, req.HourlyRateCents, req.PartsCents, req.Visits);
            }
            catch (ArgumentException ex)
            {
                Response.StatusCode = 400;
                return Json(new { Error = ex.Message });
            }

            return Json(new
            {
                LaborCents = result.LaborCents,
                PartsCents = result.PartsCents,
                TravelCents = result.TravelCents,
                TaxCents = result.TaxCents,
                TotalCents = result.TotalCents
            });
        }

        // GET /Invoices/Recent — protected surface. Unauthenticated forms-auth
        // requests get a 302 redirect to the login URL (web.config loginUrl).
        [Authorize]
        public JsonResult Recent()
        {
            return Json(Repo.Invoices, JsonRequestBehavior.AllowGet);
        }
    }
}
