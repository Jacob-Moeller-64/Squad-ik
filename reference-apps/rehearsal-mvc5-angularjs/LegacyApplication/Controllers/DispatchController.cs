using System;
using System.IO;
using System.Web.Mvc;
using FieldServe.Models;
using FieldServe.Services;
using Newtonsoft.Json;

namespace FieldServe.Controllers
{
    public class DispatchController : Controller
    {
        private readonly DispatchAllocator _allocator = new DispatchAllocator();

        // POST /Dispatch/Assign   body: { "WorkOrderId": "WO-1001", "TechnicianId": 2 }
        [HttpPost]
        public JsonResult Assign()
        {
            var body = new StreamReader(Request.InputStream).ReadToEnd();
            var req = JsonConvert.DeserializeObject<AssignRequest>(body)
                      ?? new AssignRequest();

            int activeLoad;
            try
            {
                activeLoad = _allocator.Assign(req.WorkOrderId, req.TechnicianId);
            }
            catch (ArgumentException)
            {
                Response.StatusCode = 400;
                return Json(new { Error = "no such technician" });
            }
            catch (InvalidOperationException)
            {
                Response.StatusCode = 422;
                return Json(new { Error = "over capacity" });
            }

            return Json(new
            {
                TechnicianId = req.TechnicianId,
                WorkOrderId = req.WorkOrderId,
                ActiveLoad = activeLoad
            });
        }
    }
}
