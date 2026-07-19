using LegacyShop.Library.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.HttpOverrides;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// Platform readiness (kit D-010): configurable port, 8080 default.
builder.WebHost.UseUrls(Environment.GetEnvironmentVariable("ASPNETCORE_URLS") ?? "http://0.0.0.0:8080");

builder.Services.AddControllers();
builder.Services.AddOpenApi();
builder.Services.AddHealthChecks();

builder.Services.AddSingleton<PricingService>();
builder.Services.AddSingleton<ShippingCalculator>();
builder.Services.AddSingleton<InventoryAllocator>();

// Auth strangler step 3 complete (D-004, run decision RD-3): the legacy cookie path is
// removed. OIDC bearer (Okta-shaped: authority + audience from config) is the sole
// authentication scheme.
var oidcIssuer = builder.Configuration["Oidc:Issuer"] ?? "http://127.0.0.1:8321";
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = oidcIssuer;
        options.Audience = "legacyshop";
        options.RequireHttpsMetadata = false; // stand-in issuer is local HTTP; real Okta is HTTPS
    });

var app = builder.Build();

// Platform readiness: behind a TLS-terminating router, redirect URIs must honor
// X-Forwarded-* or OIDC callbacks break (kit okta skill).
app.UseForwardedHeaders(new ForwardedHeadersOptions
{
    ForwardedHeaders = ForwardedHeaders.XForwardedProto | ForwardedHeaders.XForwardedHost
});

var clientDist = Path.GetFullPath(Path.Combine(app.Environment.ContentRootPath, "..", "Client", "dist", "legacy-shop"));
if (Directory.Exists(clientDist))
{
    var provider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(clientDist);
    app.UseDefaultFiles(new DefaultFilesOptions { FileProvider = provider });
    app.UseStaticFiles(new StaticFileOptions { FileProvider = provider });
}

app.UseAuthentication();
app.UseAuthorization();

app.MapOpenApi();
app.MapScalarApiReference(options => options.WithTitle("LegacyShop API"));
app.MapHealthChecks("/health");
app.MapControllers();
if (Directory.Exists(clientDist))
{
    app.MapFallbackToFile("index.html", new StaticFileOptions
    {
        FileProvider = new Microsoft.Extensions.FileProviders.PhysicalFileProvider(clientDist)
    });
}

app.Run();
