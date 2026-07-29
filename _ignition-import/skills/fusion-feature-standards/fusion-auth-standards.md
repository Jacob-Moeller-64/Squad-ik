# Security & Authentication Standards (Fusion)

Non-negotiable Dominion Energy security requirements. Final-state violations are deployment blockers. All auth patterns must use Fusion conventions - wire auth in `FusionWebBuilderExtensions.cs`, not scattered through `Program.cs`.

---

## Authentication: Okta Required For Final State

Okta is the required final authentication model for modernized applications.

During parity-preserving modernization, a legacy application that already uses Windows Authentication, Forms Authentication, or another legacy scheme may temporarily retain that existing scheme as an intermediate state so the team can verify that the modernized code still runs and behaves correctly before the auth cutover.

This temporary allowance is narrow:

- The legacy auth must already exist in the legacy application.
- It may be retained only to preserve parity during migration.
- It must be documented as temporary and scheduled for replacement.
- It must not be treated as an acceptable final or deployment-ready state.

Do not introduce new legacy auth into applications that do not already use it, and do not expand legacy auth to new features or endpoints unless required strictly for parity.

### CRITICAL violations in final state or deployment-ready code

```csharp
// Windows Authentication - CRITICAL in final state
services.AddAuthentication(IISDefaults.AuthenticationScheme);
services.AddAuthentication(NegotiateDefaults.AuthenticationScheme);

// Forms Authentication - CRITICAL in final state
services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme);

// No authentication at all - CRITICAL
```

### Temporary intermediate state during modernization

If the legacy app already uses Windows/IIS auth, Forms auth, or another legacy mechanism, it may remain in place temporarily while the app is being modernized and parity is being verified.

Use that temporary state only to:

- preserve existing behavior during migration,
- confirm startup and core workflows still work,
- isolate the auth replacement into a dedicated follow-up slice.

Before the app is considered modernized, ready for acceptance, or ready for deployment, the legacy auth must be removed and replaced with Okta.

### Fusion pattern (use this)

Wire in `FusionWebBuilderExtensions.cs`:

```csharp
public static class FusionWebBuilderExtensions
{
    public static WebApplication UseFusionWebMiddleware(this WebApplication app)
    {
        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseHttpsRedirection();
        app.UseAuthentication();
        app.UseAuthorization();
        return app;
    }
}
```

Wire in `FusionApplicationBuilderExtensions.cs` or `Program.cs`:

```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = builder.Configuration["Okta:Issuer"];
        options.Audience = builder.Configuration["Okta:Audience"];
        options.RequireHttpsMetadata = !builder.Environment.IsDevelopment();
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            RequireExpirationTime = true,
            ClockSkew = TimeSpan.FromMinutes(2)
        };
    });
```

Config in `appsettings.json`:
```json
{
  "Okta": {
    "Issuer": "https://your-org.okta.com/oauth2/default",
    "Audience": "api://your-app-id",
    "ClientId": "your-client-id"
  }
}
```

- Client secrets NEVER in `appsettings.json` - use Key Vault or environment variables
- `RequireHttpsMetadata` must be `true` in production

### Angular Okta wiring

```typescript
// Auth guard on protected routes
{ path: 'orders', component: OrderListComponent, canActivate: [OktaAuthGuard] }

// HTTP interceptor attaches bearer token
intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
  const token = this.oktaAuth.getAccessToken();
  if (token) {
    req = req.clone({ setHeaders: { Authorization: `Bearer ${token}` } });
  }
  return next.handle(req);
}
```

- Tokens NEVER in `localStorage` (XSS vulnerable) - use `sessionStorage` or in-memory
- Token refresh must be automatic
- 401 responses must redirect to Okta login

---

## Authorization: Policy-Based Only

### NOT acceptable (HIGH violations)

```csharp
if (User.IsInRole("Admin")) { ... }
[Authorize(Roles = "Admin,Manager")]
```

### Fusion pattern

```csharp
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("RequireAdmin", policy =>
        policy.RequireAssertion(context =>
            context.User.HasClaim(c => c.Type == "groups" && c.Value == "AppAdmins")));

    options.AddPolicy("RequireValidRole", policy =>
        policy.RequireAuthenticatedUser());
});

// On controllers
[Authorize(Policy = "RequireAdmin")]
public async Task<IActionResult> DeleteOrder(int id) { ... }
```

---

## Swagger: Development Only

### NOT acceptable (HIGH)

```csharp
app.UseSwagger();              // No environment check
app.UseSwaggerUI();            // Exposes API surface in production
```

### Fusion pattern (in FusionWebBuilderExtensions.cs)

```csharp
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "API V1"));
}
```

---

## Development-Only Endpoints

### NOT acceptable (CRITICAL)

```csharp
// Dev token endpoint in production
app.MapGet("/api/dev/token", ...);

// Dev auth handler without environment check
services.AddAuthentication().AddScheme<DevAuthHandler>("DevAuth", null);
```

### Fusion pattern

```csharp
if (app.Environment.IsDevelopment())
{
    app.MapGet("/api/dev/token", ...);

    var devAuth = builder.Configuration.GetSection("DevAuth").Get<DevAuthConfig>();
    if (devAuth?.Enabled == true)
    {
        builder.Services.AddAuthentication()
            .AddScheme<DevAuthHandler>(DevAuthHandler.SchemeName, null);
    }
}
```

---

## Secrets Management

### CRITICAL violations

- `Password=` or `Pwd=` with a non-empty value in a string literal
- Connection strings with credentials in `appsettings.json`
- API keys as string literals (32+ alphanumeric characters)
- JWT signing keys as string literals
- `Bearer ` followed by a token string in source code

### Fusion pattern

```csharp
// Development: user secrets
if (builder.Environment.IsDevelopment())
{
    builder.Configuration.AddUserSecrets<Program>();
}

// Production: Key Vault or environment variables
var password = builder.Configuration["DbPassword"];  // injected at runtime
```

---

## PII Protection

### NOT acceptable (HIGH)

```csharp
context.HttpContext.Response.Headers.Add("X-User-Id", user.Name);
context.HttpContext.Response.Headers.Add("X-User-Role", user.Role);
_logger.LogInformation("User {Email} logged in", user.Email);  // PII in logs
return BadRequest(new { error = $"User {user.Email} is not authorized" });
```

### Fusion pattern

```csharp
context.HttpContext.Response.Headers.Add("X-Correlation-Id", correlationId);  // Not PII
_logger.LogInformation("User {UserId} logged in", user.Id);  // ID, not email
return Forbid();  // No user details in error responses
```

---

## CORS

### NOT acceptable

```csharp
policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();  // Disables CORS
policy.AllowAnyOrigin().AllowCredentials();  // CRITICAL - browser security violation
```

### Fusion pattern

```csharp
builder.Services.AddCors(options => options.AddPolicy("Production",
    policy => policy
        .WithOrigins(builder.Configuration.GetSection("Cors:AllowedOrigins").Get<string[]>()!)
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials()));
```

---

## Token Validation

### NOT acceptable

```csharp
ValidateIssuer = false,      // MUST be true
ValidateAudience = false,    // MUST be true
ValidateLifetime = false,    // MUST be true
RequireHttpsMetadata = false, // Only inside IsDevelopment()
```

---

## Quick Reference: Severity

| Finding | Severity |
|---------|----------|
| Hardcoded password/secret | CRITICAL |
| Windows/IIS/Negotiate auth | CRITICAL |
| Dev endpoint without IsDevelopment() | CRITICAL |
| AllowAnyOrigin + AllowCredentials | CRITICAL |
| Swagger without IsDevelopment() | HIGH |
| IsInRole() instead of policy-based | HIGH |
| PII in headers or logs | HIGH |
| Token in localStorage | HIGH |
| Token in URL query string | HIGH |
| RequireHttpsMetadata = false in prod | HIGH |
| Token validation disabled | HIGH |
