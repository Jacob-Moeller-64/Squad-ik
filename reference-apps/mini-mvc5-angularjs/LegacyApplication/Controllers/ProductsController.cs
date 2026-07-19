using System.Web.Mvc;
using LegacyApplication.Data;

namespace LegacyApplication.Controllers
{
    public class ProductsController : Controller
    {
        // GET /Products/List
        public JsonResult List()
        {
            return Json(ProductRepository.Products, JsonRequestBehavior.AllowGet);
        }

        // GET /Products/Detail/{id}
        public JsonResult Detail(int id)
        {
            var product = ProductRepository.Find(id);
            if (product == null)
            {
                Response.StatusCode = 404;
                return Json(new { error = "not found" }, JsonRequestBehavior.AllowGet);
            }
            return Json(product, JsonRequestBehavior.AllowGet);
        }
    }
}
