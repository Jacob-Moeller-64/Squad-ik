using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using FieldServe.Data;
using FieldServe.Models;
using FieldServe.Services;
using Newtonsoft.Json;

namespace FieldServe.Controllers
{
    public class WorkOrdersController : Controller
    {
        private readonly SlaCalculator _sla = new SlaCalculator();

        // GET /WorkOrders/List
        public JsonResult List()
        {
            return Json(Repo.WorkOrders, JsonRequestBehavior.AllowGet);
        }

        // GET /WorkOrders/Detail/{id}
        public JsonResult Detail(string id)
        {
            var order = Repo.FindWorkOrder(id);
            if (order == null)
            {
                Response.StatusCode = 404;
                return Json(new { Error = "not found" }, JsonRequestBehavior.AllowGet);
            }
            return Json(order, JsonRequestBehavior.AllowGet);
        }

        // GET /WorkOrders/Search?status=Open  (exact match on Status)
        public JsonResult Search(string status)
        {
            var matches = Repo.WorkOrders.Where(w => w.Status == status).ToList();
            return Json(matches, JsonRequestBehavior.AllowGet);
        }

        // POST /WorkOrders/Create
        // body: { "Title": "...", "Priority": "High", "ContractTier": "Gold", "Weekend": false }
        [HttpPost]
        public JsonResult Create()
        {
            var body = new StreamReader(Request.InputStream).ReadToEnd();
            var req = JsonConvert.DeserializeObject<CreateWorkOrderRequest>(body)
                      ?? new CreateWorkOrderRequest();

            int dueInHours;
            try
            {
                dueInHours = _sla.DueInHours(req.Priority, req.ContractTier, req.Weekend);
            }
            catch (ArgumentException ex)
            {
                Response.StatusCode = 400;
                return Json(new { Error = ex.Message });
            }

            var workOrderId = Guid.NewGuid().ToString("N");
            Session["LastWorkOrderId"] = workOrderId; // InProc session: statelessness hazard

            // Legacy audit trail: local file write, ephemeral-filesystem hazard.
            var auditPath = Server.MapPath(ConfigurationManager.AppSettings["AuditLogPath"]);
            System.IO.File.AppendAllText(auditPath,
                workOrderId + "\t" + req.Title + "\t" + dueInHours + Environment.NewLine);

            return Json(new
            {
                WorkOrderId = workOrderId,
                Title = req.Title,
                Priority = req.Priority,
                DueInHours = dueInHours
            });
        }
    }
}
