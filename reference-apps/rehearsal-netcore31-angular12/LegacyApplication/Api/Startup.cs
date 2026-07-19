using System.IO;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.OpenApi.Models;

namespace LegacyShop.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();

            // Statelessness hazard: in-memory session, order state pinned to this process.
            services.AddDistributedMemoryCache();
            services.AddSession();

            services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                .AddCookie(options =>
                {
                    options.Cookie.Name = "LegacyShopAuth";
                    options.Events.OnRedirectToLogin = ctx =>
                    {
                        ctx.Response.StatusCode = 401;
                        return System.Threading.Tasks.Task.CompletedTask;
                    };
                });

            services.AddSingleton<Services.PricingService>();
            services.AddSingleton<Services.ShippingCalculator>();
            services.AddSingleton<Services.InventoryAllocator>();

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "LegacyShop API", Version = "v1" });
            });
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "LegacyShop API v1");
            });

            var clientDist = Path.Combine(env.ContentRootPath, "..", "ClientApp", "dist", "legacy-shop");
            if (Directory.Exists(clientDist))
            {
                var provider = new PhysicalFileProvider(Path.GetFullPath(clientDist));
                app.UseDefaultFiles(new DefaultFilesOptions { FileProvider = provider });
                app.UseStaticFiles(new StaticFileOptions { FileProvider = provider });
            }

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseSession();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
                if (Directory.Exists(clientDist))
                {
                    endpoints.MapFallbackToFile("index.html", new StaticFileOptions
                    {
                        FileProvider = new PhysicalFileProvider(Path.GetFullPath(clientDist))
                    });
                }
            });
        }
    }
}
