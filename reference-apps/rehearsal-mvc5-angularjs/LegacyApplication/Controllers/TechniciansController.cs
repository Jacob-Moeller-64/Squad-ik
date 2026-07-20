using System.Web.Mvc;
using FieldServe.Data;

namespace FieldServe.Controllers
{
    public class TechniciansController : Controller
    {
        // GET /Technicians/List
        public JsonResult List()
        {
            return Json(Repo.Technicians, JsonRequestBehavior.AllowGet);
        }

        // GET /Technicians/Detail/{id}
        public JsonResult Detail(int id)
        {
            var tech = Repo.FindTechnician(id);
            if (tech == null)
            {
                Response.StatusCode = 404;
                return Json(new { Error = "not found" }, JsonRequestBehavior.AllowGet);
            }
            return Json(tech, JsonRequestBehavior.AllowGet);
        }
    }
}
