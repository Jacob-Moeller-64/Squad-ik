using System;
using System.Linq;
using FieldServe.Library.Data;
using FieldServe.Library.Models;
using FieldServe.Library.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace FieldServe.Api.Controllers
{
    [ApiController]
    [Route("WorkOrders")]
    public class WorkOrdersController : ControllerBase
    {
        private readonly SlaCalculator _sla;
        private readonly ILogger<WorkOrdersController> _logger;

        public WorkOrdersController(SlaCalculator sla, ILogger<WorkOrdersController> logger)
        {
            _sla = sla;
            _logger = logger;
        }

        [HttpGet("List")]
        public IActionResult List() => Ok(Repo.WorkOrders);

        [HttpGet("Detail/{id}")]
        public IActionResult Detail(string id)
        {
            var order = Repo.FindWorkOrder(id);
            if (order == null) return NotFound(new { Error = "not found" });
            return Ok(order);
        }

        [HttpGet("Search")]
        public IActionResult Search([FromQuery] string status)
            => Ok(Repo.WorkOrders.Where(w => w.Status == status).ToList());

        [HttpPost("Create")]
        public IActionResult Create([FromBody] CreateWorkOrderRequest req)
        {
            int dueInHours;
            try
            {
                dueInHours = _sla.DueInHours(req.Priority, req.ContractTier, req.Weekend);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { Error = ex.Message });
            }

            var workOrderId = Guid.NewGuid().ToString("N");

            // Modernized: session state removed (stateless process); file audit replaced
            // with structured stdout logging (12-factor).
            _logger.LogInformation("WorkOrder {WorkOrderId} created: '{Title}' due in {DueInHours}h",
                workOrderId, req.Title, dueInHours);

            return Ok(new
            {
                WorkOrderId = workOrderId,
                Title = req.Title,
                Priority = req.Priority,
                DueInHours = dueInHours
            });
        }
    }
}
