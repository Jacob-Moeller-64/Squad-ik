using System.IO;
using System.Web.Mvc;
using System.Web.Security;
using Newtonsoft.Json;

namespace LegacyApplication.Controllers
{
    public class AccountController : Controller
    {
        // POST /Account/Login   body: { "username": "demo", "password": "demo123" }
        // Classic forms auth: the migration target for the kit's Okta strangler (D-004).
        [HttpPost]
        public JsonResult Login()
        {
            var body = new StreamReader(Request.InputStream).ReadToEnd();
            var creds = JsonConvert.DeserializeObject<Creds>(body);

            if (creds != null && creds.Username == "demo" && creds.Password == "demo123")
            {
                FormsAuthentication.SetAuthCookie("demo", false);
                return Json(new { ok = true, user = "demo" });
            }

            Response.StatusCode = 401;
            return Json(new { error = "invalid credentials" });
        }

        public class Creds
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }
    }
}
