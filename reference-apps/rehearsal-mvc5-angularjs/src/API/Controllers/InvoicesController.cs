using System;
using FieldServe.Library.Data;
using FieldServe.Library.Models;
using FieldServe.Library.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FieldServe.Api.Controllers
{
    [ApiController]
    [Route("Invoices")]
    public class InvoicesController : ControllerBase
    {
        private readonly InvoiceCalculator _calculator;

        public InvoicesController(InvoiceCalculator calculator)
        {
            _calculator = calculator;
        }

        [HttpPost("Quote")]
        public IActionResult Quote([FromBody] QuoteRequest req)
        {
            try
            {
                var quote = _calculator.Quote(req.LaborHours, req.HourlyRateCents, req.PartsCents, req.Visits);
                return Ok(quote);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { Error = ex.Message });
            }
        }

        [Authorize]
        [HttpGet("Recent")]
        public IActionResult Recent() => Ok(Repo.Invoices);
    }
}
