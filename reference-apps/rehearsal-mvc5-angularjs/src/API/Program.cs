using FieldServe.Library.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.HttpOverrides;
using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// Platform readiness (kit D-010): configurable port, 8080 default.
builder.WebHost.UseUrls(Environment.GetEnvironmentVariable("ASPNETCORE_URLS") ?? "http://0.0.0.0:8080");

// PascalCase JSON preserved: the legacy MVC5 contract serialized property names as-is,
// and the goldens pin that casing (mvc5 adapter: serializer parity is the #1 breaker).
builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.PropertyNamingPolicy = null;
});
builder.Services.AddOpenApi();
builder.Services.AddHealthChecks();

builder.Services.AddSingleton<SlaCalculator>();
builder.Services.AddSingleton<InvoiceCalculator>();
builder.Services.AddSingleton<DispatchAllocator>();

// Auth strangler complete (D-004, run decision RD-3): legacy forms-cookie path removed;
// OIDC bearer (Okta-shaped: authority + audience from config) is the sole scheme.
var oidcIssuer = builder.Configuration["Oidc:Issuer"] ?? "http://127.0.0.1:8322";
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = oidcIssuer;
        options.Audience = "fieldserve";
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
app.MapScalarApiReference(options => options.WithTitle("FieldServe API"));
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
