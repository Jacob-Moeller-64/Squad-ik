using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;

namespace LegacyShop.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AccountController : ControllerBase
    {
        public class Creds
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] Creds creds)
        {
            if (creds != null && creds.Username == "demo" && creds.Password == "demo123")
            {
                var identity = new ClaimsIdentity(
                    new List<Claim> { new Claim(ClaimTypes.Name, "demo") },
                    CookieAuthenticationDefaults.AuthenticationScheme);
                await HttpContext.SignInAsync(new ClaimsPrincipal(identity));
                return Ok(new { ok = true, user = "demo" });
            }
            return Unauthorized(new { error = "invalid credentials" });
        }

        [HttpPost("logout")]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync();
            return Ok(new { ok = true });
        }
    }
}
