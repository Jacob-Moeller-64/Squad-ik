using System.IO;
using System.Web.Mvc;
using System.Web.Security;
using Newtonsoft.Json;

namespace FieldServe.Controllers
{
    public class AccountController : Controller
    {
        // POST /Account/Login   body: { "Username": "demo", "Password": "demo123" }
        [HttpPost]
        public JsonResult Login()
        {
            var body = new StreamReader(Request.InputStream).ReadToEnd();
            var creds = JsonConvert.DeserializeObject<Creds>(body);

            if (creds != null && creds.Username == "demo" && creds.Password == "demo123")
            {
                FormsAuthentication.SetAuthCookie("demo", false);
                return Json(new { Ok = true, User = "demo" });
            }

            Response.StatusCode = 401;
            return Json(new { Error = "invalid credentials" });
        }

        // POST /Account/Logout
        [HttpPost]
        public JsonResult Logout()
        {
            FormsAuthentication.SignOut();
            return Json(new { Ok = true });
        }

        public class Creds
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }
    }
}
