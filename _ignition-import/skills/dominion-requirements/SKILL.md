---
name: dominion-requirements
description: Dominion Energy App Modernization Requirements - Comprehensive guidance for code review. Load this skill when reviewing code for compliance.
version: "2.0"
---

# Dominion App Modernization Requirements

Comprehensive guidance for reviewing code against Dominion Energy's modernization standards. This skill provides the **WHY**, **WHAT**, and **HOW** for each requirement.

## Source Of Truth

Read `/.github/skills/dominion-requirements/AppMod-Acceptance-Criteria.md` alongside this skill when a review or planning surface needs the concise requirement list in its original checklist form.

## Review Approach

Each requirement is tagged with a review method:

- <MOJIBAKE: emoji> **DET (Deterministic)** - Can be found by pattern matching. Note it if present.
- <MOJIBAKE: emoji> **AI (Judgment)** - Requires reading code in context and making a judgment call. Provide reasoning in your findings.

**For DET items:** Find the pattern, report file/line, move on.
**For AI items:** Read the surrounding code, understand intent, then decide if it's actually a violation and how severe.

---

## Table of Contents

1. [12-Factor App Principles](#1-12-factor-app-principles)
2. [SOLID Principles](#2-solid-principles)
3. [Security Requirements](#3-security-requirements)
4. [API Structure Requirements](#4-api-structure-requirements)
5. [Angular/Frontend Requirements](#5-angularfrontend-requirements)
6. [Testing Requirements](#6-testing-requirements)
7. [Deliverables](#7-deliverables)
8. [Severity Definitions](#8-severity-definitions)

---

# 1. 12-Factor App Principles

The 12-Factor methodology enables applications to be built for modern cloud platforms. We check 6 of the 12 factors that are detectable from code review.

> **Factors NOT checked (infrastructure/operational concerns):** Codebase (I), Build/Release/Run (V), Port Binding (VII), Concurrency (VIII), Dev/Prod Parity (X), Admin Processes (XII)

---

## Factor II: Dependencies - Explicitly Declare and Isolate

> **Review Method:** <MOJIBAKE: emoji> DET - Pattern match for vendored DLLs, hardcoded paths

### The Principle

A twelve-factor app never relies on implicit existence of system-wide packages. It declares all dependencies completely and exactly via a dependency declaration manifest.

### Why It Matters

- **Reproducible builds** - New developers can set up the app reliably
- **No "works on my machine"** - All dependencies are explicit
- **Security scanning** - Tools can analyze declared dependencies for vulnerabilities
- **Containerization** - Containers need explicit dependency lists

### What to Look For

**Violations:**
- Reference to DLL not managed by NuGet (vendored DLLs in libs folder)
- Hardcoded paths to system tools (C:\Program Files\...)
- COM dependencies without explicit declaration
- Global CLI tool assumptions

**Correct Implementation:**
- All dependencies in .csproj PackageReferences
- All dependencies in package.json with pinned versions
- No vendored binaries in repo

---

## Factor III: Config - Store Config in the Environment

> **Review Method:** <MOJIBAKE: emoji> DET for hardcoded strings (connection strings, URLs, passwords). <MOJIBAKE: emoji> AI for judging whether a value should be externalized vs. is acceptable as a constant.

### The Principle

Configuration that varies between deployments must be strictly separated from code.

### Why It Matters

- **Security** - Secrets never end up in source control
- **Deployment flexibility** - Same artifact deploys to any environment
- **Operational control** - Ops can tune settings without developers

### What Qualifies as Config

| Externalize | Can Hardcode |
|-------------|--------------|
| Connection strings | Internal routes |
| API endpoints/URLs | Math constants |
| Credentials, API keys | HTTP status codes |
| Feature flags | Enum values |
| Timeouts, retry counts | |
| Batch sizes, limits | |

### Violations

```csharp
// BAD - Hardcoded connection string
var conn = "Server=prod-db.company.com;Database=Orders;Password=secret";

// BAD - Hardcoded API URL
private const string ApiUrl = "https://api.production.company.com/v1";

// BAD - Magic numbers
var timeout = 30;
var maxRetries = 3;
var batchSize = 100;

// BAD - Environment detection in code
if (Environment.MachineName.StartsWith("PROD")) { }
```

### Correct Implementation

```csharp
// GOOD - From configuration
var conn = _config.GetConnectionString("OrdersDb");
var apiUrl = _config["ExternalServices:Api:Url"];
var timeout = _config.GetValue<int>("Settings:Timeout");
```

---

## Factor IV: Backing Services - Treat as Attached Resources

> **Review Method:** <MOJIBAKE: emoji> AI - Requires judgment about whether service coupling is appropriate and if abstractions are at the right level.

### The Principle

Treat backing services (databases, queues, caches, email) as attached resources accessed via URL/config.

### Why It Matters

- **Portability** - Swap backing services without code changes
- **Testing** - Point to test instances easily
- **Cloud-native** - Services may be provisioned dynamically

### Violations

```csharp
// BAD - Direct instantiation
var smtp = new SmtpClient("smtp.company.com", 587);
var redis = ConnectionMultiplexer.Connect("redis.company.com:6379");

// BAD - Service-specific code
using var conn = new SqlConnection("...");  // Tightly coupled to SQL Server
```

### Correct Implementation

```csharp
// GOOD - Behind abstraction
public interface IEmailService { Task SendAsync(EmailMessage msg); }
public interface IOrderRepository { Task<Order> GetByIdAsync(int id); }

// Can swap: SMTP, SendGrid, Graph API - just change DI registration
```

**Key Test:** Can you swap the backing service by only changing configuration?

---

## Factor VI: Processes - Execute App as Stateless Processes

> **Review Method:** <MOJIBAKE: emoji> DET for `static` mutable state, `Session[`. <MOJIBAKE: emoji> AI for judging whether state management would break horizontal scaling.

### The Principle

Processes are stateless and share-nothing. Data that needs to persist goes in a backing service.

### Why It Matters

- **Horizontal scaling** - Any instance can handle any request
- **Resilience** - Instance failure doesn't lose data
- **Container orchestration** - Pods can be created/destroyed freely

### Violations

```csharp
// BAD - Static mutable state
private static List<Order> _cache = new();
private static int _requestCount = 0;

// BAD - Instance state in singleton
public class CacheService { private Dictionary<string, object> _cache = new(); }

// BAD - Session state
HttpContext.Session["Cart"] = cart;

// BAD - Local file storage
File.WriteAllText("C:\\uploads\\file.txt", data);
```

### Correct Implementation

```csharp
// GOOD - Distributed cache
await _distributedCache.SetStringAsync($"order:{id}", json);

// GOOD - Database for state
await _repository.SaveAsync(cart);

// GOOD - Blob storage for files
await _blobStorage.UploadAsync("uploads", filename, stream);
```

---

## Factor IX: Disposability - Fast Startup and Graceful Shutdown

> **Review Method:** <MOJIBAKE: emoji> AI - Requires judgment about startup performance, cancellation token usage, and resource cleanup patterns.

### The Principle

Processes start quickly and shut down gracefully, finishing current work before exit.

### Why It Matters

- **Elastic scaling** - New instances must start fast
- **Data integrity** - Graceful shutdown prevents corruption
- **Rolling deployments** - Quick startup enables zero-downtime deploys

### Violations

```csharp
// BAD - Long startup
public void Configure(IApplicationBuilder app)
{
    var data = LoadAllDataFromDatabase();  // 30 seconds
    WarmAllCaches();  // 60 seconds
}

// BAD - Ignores cancellation
while (true) { await ProcessNext(); }  // Never stops

// BAD - Resources not disposed
private SqlConnection _conn = new SqlConnection();  // Never closed
```

### Correct Implementation

```csharp
// GOOD - Respects cancellation
while (!stoppingToken.IsCancellationRequested)
{
    await ProcessNextAsync(stoppingToken);
}

// GOOD - IAsyncDisposable
public async ValueTask DisposeAsync()
{
    await _connection.CloseAsync();
}
```

---

## Factor XI: Logs - Treat Logs as Event Streams

> **Review Method:** <MOJIBAKE: emoji> DET for `Console.WriteLine`, `File.AppendAllText`, string concatenation in logs. <MOJIBAKE: emoji> AI for judging log level appropriateness and structured logging quality.

### The Principle

Write logs to stdout. Never manage log files in application code.

### Why It Matters

- **Container compatibility** - Containers capture stdout automatically
- **Centralized logging** - Aggregation systems collect from stdout
- **No file management** - No rotation, cleanup, disk space issues

### Violations

```csharp
// BAD - File logging
var logger = new StreamWriter("C:\\Logs\\app.log");
File.AppendAllText(logPath, message);

// BAD - Console.WriteLine for logging
Console.WriteLine($"Error: {ex.Message}");

// BAD - String concatenation
_logger.LogInformation("Order " + orderId + " for " + userId);
```

### Correct Implementation

```csharp
// GOOD - ILogger with structured logging
_logger.LogInformation("Processing order {OrderId} for {CustomerId}",
    order.Id, order.CustomerId);

// GOOD - Console provider (stdout)
builder.Logging.AddConsole();
builder.Logging.AddJsonConsole();
```

### Dominion Logging Standards - 7 Log Types Required

| Type | When to Use |
|------|-------------|
| **Performance** | Timing, metrics |
| **Debug** | Detailed diagnostics |
| **Trace** | Execution flow |
| **Error** | Exceptions |
| **Warning** | Potential issues |
| **Info** | Operational events |
| **Audit** | Security events |

---

# 2. SOLID Principles

---

## Single Responsibility Principle (SRP)

> **Review Method:** <MOJIBAKE: emoji> DET for class size (>300 lines), constructor params (>5). <MOJIBAKE: emoji> AI for judging whether responsibilities are actually mixed or if the class is cohesive.

### The Principle

A class should have only one reason to change.

### Why It Matters

- **Maintainability** - Changes isolated to one place
- **Testability** - Smaller classes easier to test
- **Readability** - Clear purpose

### Violations

```csharp
// BAD - Multiple responsibilities
public class OrderService
{
    public Order CreateOrder(OrderRequest req)
    {
        // 1. Validation
        if (req.Items.Count == 0) throw new Exception();

        // 2. Pricing
        order.Total = req.Items.Sum(i => i.Price);

        // 3. Database
        using var conn = new SqlConnection();
        conn.Execute("INSERT...");

        // 4. Email
        var smtp = new SmtpClient();
        smtp.Send(confirmation);

        // 5. Inventory
        conn.Execute("UPDATE Inventory...");
    }
}
```

### Correct Implementation

```csharp
// GOOD - Each class has one job
public class OrderService
{
    private readonly IOrderValidator _validator;
    private readonly IPricingService _pricing;
    private readonly IOrderRepository _repo;
    private readonly INotificationService _notifications;

    public async Task<Order> CreateAsync(OrderRequest req)
    {
        _validator.Validate(req);
        var order = new Order { Items = req.Items };
        _pricing.Calculate(order);
        await _repo.SaveAsync(order);
        await _notifications.SendConfirmationAsync(order);
        return order;
    }
}
```

### Red Flags

- Class > 300 lines
- Class > 7 public methods
- Constructor > 5-7 dependencies
- Name includes "Manager", "Helper", "Utility"

---

## Open/Closed Principle (OCP)

> **Review Method:** <MOJIBAKE: emoji> AI - Requires understanding design intent. Look for switch-on-type patterns, but judge whether a strategy pattern is actually warranted.

### The Principle

Open for extension, closed for modification.

### Why It Matters

- **Stability** - Existing code doesn't change
- **Testing** - Existing tests remain valid

### Violations

```csharp
// BAD - Must modify to add payment type
public void ProcessPayment(Payment payment)
{
    switch (payment.Type)
    {
        case PaymentType.CreditCard: ProcessCreditCard(); break;
        case PaymentType.PayPal: ProcessPayPal(); break;
        // Must modify class for each new type
    }
}
```

### Correct Implementation

```csharp
// GOOD - Add new types via new classes
public interface IPaymentProcessor
{
    bool CanProcess(PaymentType type);
    Task ProcessAsync(Payment payment);
}

public class CreditCardProcessor : IPaymentProcessor { }
public class PayPalProcessor : IPaymentProcessor { }
public class CryptoProcessor : IPaymentProcessor { }  // New - no modification
```

---

## Liskov Substitution Principle (LSP)

> **Review Method:** <MOJIBAKE: emoji> AI - Requires understanding inheritance behavior. Look for `NotImplementedException`, behavioral inconsistencies in subclasses.

### The Principle

Subtypes must be substitutable for their base types without breaking the program.

### Why It Matters

- **Correctness** - Derived classes don't surprise callers
- **Polymorphism** - Interfaces work as expected

### Violations

```csharp
// BAD - NotImplementedException
public class ReadOnlyRepo : IRepository<Product>
{
    public void Save(Product p) => throw new NotImplementedException();  // <MOJIBAKE: emoji>
    public void Delete(int id) => throw new NotImplementedException();  // <MOJIBAKE: emoji>
}
```

### Correct Implementation

```csharp
// GOOD - Segregated interfaces
public interface IReadRepository<T> { T GetById(int id); }
public interface IWriteRepository<T> { void Save(T entity); }

public class ReadOnlyRepo : IReadRepository<Product> { }  // No broken methods
```

---

## Interface Segregation Principle (ISP)

> **Review Method:** <MOJIBAKE: emoji> DET for interface method count (>7). <MOJIBAKE: emoji> AI for judging whether methods are cohesive or if the interface should be split.

### The Principle

Clients should not depend on interfaces they don't use.

### Why It Matters

- **Decoupling** - Classes depend only on what they need
- **Testability** - Smaller interfaces easier to mock

### Violations

```csharp
// BAD - Fat interface (20+ methods)
public interface IUserService
{
    User Authenticate(string user, string pass);
    void Logout(int userId);
    User GetById(int id);
    void Create(User user);
    void SendWelcomeEmail(User user);
    void LockUser(int userId);
    // ... 15 more methods
}
```

### Correct Implementation

```csharp
// GOOD - Segregated
public interface IUserAuthentication { User Authenticate(); void Logout(); }
public interface IUserRepository { User GetById(int id); void Save(User u); }
public interface IUserNotifications { void SendWelcome(User u); }
```

### Rule of Thumb

Interfaces with > 5-7 methods may be too fat.

---

## Dependency Inversion Principle (DIP)

> **Review Method:** <MOJIBAKE: emoji> DET for `new ConcreteService()` in business logic. <MOJIBAKE: emoji> AI for judging whether the abstraction level is appropriate and if DI is set up correctly.

### The Principle

High-level modules should not depend on low-level modules. Both depend on abstractions.

### Why It Matters

- **Testability** - Can mock dependencies
- **Flexibility** - Can swap implementations

### Violations

```csharp
// BAD - Direct instantiation
public class OrderService
{
    private readonly SqlOrderRepository _repo = new SqlOrderRepository();
    private readonly SmtpEmailService _email = new SmtpEmailService();
}

// BAD - new HttpClient()
var client = new HttpClient();

// BAD - Service locator
var repo = ServiceLocator.GetService<IOrderRepository>();
```

### Correct Implementation

```csharp
// GOOD - Constructor injection
public class OrderService
{
    private readonly IOrderRepository _repo;
    private readonly IEmailService _email;

    public OrderService(IOrderRepository repo, IEmailService email)
    {
        _repo = repo;
        _email = email;
    }
}

// GOOD - IHttpClientFactory
public class ApiService
{
    private readonly HttpClient _client;
    public ApiService(HttpClient client) { _client = client; }
}
```

---

# 3. Security Requirements

---

## Authentication: OAuth 2.0 / OIDC Required

> **Review Method:** <MOJIBAKE: emoji> DET for `FormsAuthentication`, `FormsAuthenticationTicket`, password handling patterns. <MOJIBAKE: emoji> AI for judging overall auth architecture.

### The Requirement

Use OAuth 2.0 with OIDC or SAML 2.0. Forms Authentication is prohibited.

### Violations

```xml
<!-- BAD - Forms Auth in web.config -->
<authentication mode="Forms">
```

```csharp
// BAD
FormsAuthentication.SetAuthCookie(username, true);
var ticket = new FormsAuthenticationTicket(...);

// BAD - Custom password handling
var user = _db.Users.First(u => u.Username == username);
return VerifyPassword(password, user.PasswordHash);  // Managing passwords
```

### Correct Implementation

```csharp
// GOOD - Keep auth in the repo's approved starter/Fusion control points.
// For LegacyCode-to-src restructure, use the current starter shell plus
// .github/instructions/modernization-starter-boundaries.instructions.md
// instead of introducing a parallel generic AddJwtBearer stack.
```

---

## Authorization: Policy-Based Required

> **Review Method:** <MOJIBAKE: emoji> DET for `User.IsInRole()`, `[Authorize(Roles=`. <MOJIBAKE: emoji> AI for judging whether authorization coverage is adequate across controllers and business logic.

### The Requirement

Use policy-based authorization. Role checks are prohibited.

### Violations

```csharp
// BAD
if (User.IsInRole("Admin")) { }

[Authorize(Roles = "Admin,Manager")]
public IActionResult Manage() { }
```

### Correct Implementation

```csharp
// GOOD - Define named policies in the repo's approved authorization control point
// and keep app-owned evaluators aligned to the same membership source as
// protected endpoints.

// GOOD - Use policies
[Authorize(Policy = "CanManageOrders")]
public IActionResult Manage() { }

// GOOD - Runtime check
var result = await _authService.AuthorizeAsync(User, "CanManageOrders");
```

---

## Async Patterns: No Blocking Calls

> **Review Method:** <MOJIBAKE: emoji> DET for `.Result`, `.Wait()`, `.GetAwaiter().GetResult()`, `async void`.

### The Requirement

Never use .Result, .Wait(), .GetAwaiter().GetResult(), or async void.

### Why It Matters

- **Deadlocks** - Blocking async in ASP.NET causes deadlocks
- **Scalability** - Blocking wastes thread pool threads

### Violations

```csharp
// BAD
var result = GetDataAsync().Result;
GetDataAsync().Wait();
var result = GetDataAsync().GetAwaiter().GetResult();
public async void ProcessOrder() { }  // async void
```

### Correct Implementation

```csharp
// GOOD - async all the way
public async Task<Data> ProcessAsync()
{
    var data = await GetDataAsync();
    return await TransformAsync(data);
}
```

---

## Content Security Policy (CSP)

> **Review Method:** <MOJIBAKE: emoji> DET for presence of CSP headers in middleware. <MOJIBAKE: emoji> AI for judging whether the policy is appropriate and complete.

### The Requirement

Implement CSP headers to prevent XSS attacks.

### Correct Implementation

```csharp
app.Use(async (context, next) =>
{
    context.Response.Headers.Add("Content-Security-Policy",
        "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline';");
    await next();
});
```

---

# 4. API Structure Requirements

---

## REST Principles

> **Review Method:** <MOJIBAKE: emoji> AI - Requires judging whether URLs are resource-based, HTTP methods are used correctly, and status codes are appropriate.

### The Requirement

Resource-based URLs, proper HTTP methods, standard status codes.

### Violations

```csharp
// BAD - Verb-based URLs
[HttpGet("api/GetAllOrders")]
[HttpPost("api/CreateOrder")]
[HttpGet("api/DeleteOrder/{id}")]  // GET for delete?!
```

### Correct Implementation

```csharp
[ApiController]
[Route("api/[controller]")]
public class OrdersController : ControllerBase
{
    [HttpGet]           // GET api/orders
    [HttpGet("{id}")]   // GET api/orders/5
    [HttpPost]          // POST api/orders
    [HttpPut("{id}")]   // PUT api/orders/5
    [HttpDelete("{id}")] // DELETE api/orders/5
}
```

---

## JSON Responses & Swagger

> **Review Method:** <MOJIBAKE: emoji> DET for XML formatters, Swagger in non-dev environments.

### The Requirement

- JSON only (remove XML formatters)
- Swagger disabled in production

### Correct Implementation

```csharp
// JSON only
builder.Services.AddControllers()
    .AddJsonOptions(opt => opt.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase);

// Swagger in dev only
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
```

---

# 5. Angular/Frontend Requirements

---

## Services for API Calls

> **Review Method:** <MOJIBAKE: emoji> DET for `HttpClient` injection in components. <MOJIBAKE: emoji> AI for judging whether service layer abstraction is appropriate.

### The Requirement

HttpClient only in services, never in components.

### Violations

```typescript
// BAD - HttpClient in component
@Component({...})
export class OrderComponent {
  constructor(private http: HttpClient) {}  // <MOJIBAKE: emoji>

  load() { this.http.get('/api/orders').subscribe(); }  // <MOJIBAKE: emoji>
}
```

### Correct Implementation

```typescript
// GOOD - Service
@Injectable({ providedIn: 'root' })
export class OrderService {
  constructor(private http: HttpClient) {}
  getOrders() { return this.http.get<Order[]>('/api/orders'); }
}

// GOOD - Component uses service
export class OrderComponent {
  constructor(private orderService: OrderService) {}
}
```

---

## Route Guards

> **Review Method:** <MOJIBAKE: emoji> AI - Requires judging which routes need protection and whether guards are implemented correctly.

### The Requirement

Protected routes must have guards.

### Violations

```typescript
// BAD - No guard
{ path: 'admin', component: AdminComponent }

// BAD - Guard always returns true
canActivate() { return true; }
```

### Correct Implementation

```typescript
export const authGuard: CanActivateFn = () => {
  const auth = inject(AuthService);
  const router = inject(Router);
  return auth.isAuthenticated() ? true : router.createUrlTree(['/login']);
};

{ path: 'admin', component: AdminComponent, canActivate: [authGuard] }
```

---

## No Direct DOM Manipulation

> **Review Method:** <MOJIBAKE: emoji> DET for `document.getElementById`, `ElementRef.nativeElement`, `querySelector`.

### The Requirement

No document.querySelector, ElementRef.nativeElement manipulation, or jQuery.

### Violations

```typescript
// BAD
document.getElementById('el').style.display = 'none';
this.el.nativeElement.innerHTML = '<b>text</b>';
$('.class').hide();
```

### Correct Implementation

```typescript
// GOOD - Angular bindings
<div [style.display]="isVisible ? 'block' : 'none'">
<div [class.active]="isActive">

// GOOD - Renderer2 when needed
this.renderer.setStyle(el, 'color', 'red');
```

---

## Modern Angular Patterns (21+)

> **Review Method:** <MOJIBAKE: emoji> AI - Requires judging whether migration to modern patterns (signals, standalone components, new control flow) is appropriate given the current version.

### The Requirement

Use standalone components, signals, new control flow syntax, and OnPush change detection.

### Correct Implementation

```typescript
@Component({
  selector: 'app-my-component',
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    @if (loading()) {
      <app-spinner />
    } @else {
      @for (item of items(); track item.id) {
        <app-item [data]="item" (selected)="onSelect($event)" />
      }
    }
  `
})
export class MyComponent {
  // Signal-based state
  items = signal<Item[]>([]);
  loading = signal(true);

  // Signal-based inputs (Angular 20)
  data = input<string>();
  requiredData = input.required<number>();

  // Signal-based outputs (Angular 20)
  dataChange = output<string>();

  // Computed signals
  itemCount = computed(() => this.items().length);

  // inject() instead of constructor DI
  private itemService = inject(ItemService);
}
```

### Violations

```typescript
// <MOJIBAKE: emoji> BAD - NgModule instead of standalone
@NgModule({
  declarations: [MyComponent],
  imports: [CommonModule]
})
export class MyModule { }

// <MOJIBAKE: emoji> BAD - Old control flow syntax
<div *ngIf="loading">Loading...</div>
<div *ngFor="let item of items">{{ item.name }}</div>

// <MOJIBAKE: emoji> BAD - Decorator-based inputs/outputs (deprecated)
@Input() data: string;
@Output() clicked = new EventEmitter<void>();

// <MOJIBAKE: emoji> BAD - Constructor injection instead of inject()
constructor(private service: MyService) { }

// <MOJIBAKE: emoji> BAD - BehaviorSubject instead of signals
private items$ = new BehaviorSubject<Item[]>([]);
```

---

## Enterprise Messaging Layer

> **Review Method:** <MOJIBAKE: emoji> DET for direct `SmtpClient`, `new SmtpClient()`. <MOJIBAKE: emoji> AI for judging whether messaging abstraction is appropriate.

### The Requirement

No direct SMTP/email clients. Use abstracted messaging service.

### Violations

```csharp
// BAD
var smtp = new SmtpClient("smtp.company.com");
var sendgrid = new SendGridClient(apiKey);
```

### Correct Implementation

```csharp
// GOOD - Abstraction
public interface INotificationService { Task SendEmailAsync(EmailMessage msg); }
```

---

# 6. Testing Requirements

---

## Mocked Backends

### The Requirement

Unit tests use mocks, not real services.

### Violations

```csharp
// BAD
var context = new AppDbContext(realConnectionString);  // Real DB
var client = new HttpClient();  // Real HTTP
```

### Correct Implementation

```csharp
// GOOD - Mocked
var mockRepo = new Mock<IOrderRepository>();
mockRepo.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(new Order { Id = 1 });

var service = new OrderService(mockRepo.Object);
```

---

## Security Tests Required

### The Requirement

Include authentication, authorization, and validation tests.

### Correct Implementation

```csharp
[Test]
public async Task GetOrders_WithoutAuth_Returns401()
{
    var response = await _client.GetAsync("/api/orders");
    Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
}

[Test]
public async Task DeleteOrder_AsRegularUser_Returns403()
{
    _client.DefaultRequestHeaders.Authorization = GetUserToken();
    var response = await _client.DeleteAsync("/api/orders/1");
    Assert.Equal(HttpStatusCode.Forbidden, response.StatusCode);
}
```

---

# 7. Deliverables

---

## README.md Required

Must include:
- Prerequisites
- Getting started / setup
- Build instructions
- Running tests
- Debugging guide

---

## Pipeline Configuration Required

Must include:
- Build stage
- Test stage
- Located in `azure-pipelines.yml`, `pipeline.yaml`, or the repo's configured GitHub Actions workflow files when GitHub Actions is used

---

# 8. Severity Definitions

| Severity | Criteria | Points | Action |
|----------|----------|--------|--------|
| **CRITICAL** | Security vulnerability, credential leak, auth bypass | -10 | MUST FIX - Block deploy |
| **HIGH** | 12-Factor violation, SOLID violation, deprecated auth, blocking async | -5 | MUST FIX |
| **MEDIUM** | Code smell, missing best practice | -2 | SHOULD FIX |
| **LOW** | Style, documentation gap | 0 | NICE TO FIX |

### Compliance Score

```
Score = 100 - (CRITICAL x 10) - (HIGH x 5) - (MEDIUM x 2)
```

### Passing Criteria

- Score >= 80
- CRITICAL = 0
- Test Coverage >= 80%

---

## Finding Format

```json
{
  "line": 45,
  "severity": "HIGH",
  "category": "SOLID",
  "rule": "Dependency Inversion",
  "message": "Direct instantiation of PaymentService",
  "code": "var svc = new PaymentService();",
  "recommendation": "Inject IPaymentService via constructor"
}
```

---

# 9. Severity Classification Guide

Use this guide to consistently classify findings.

---

## Decision Matrix

```
Is it a security vulnerability or credential exposure?
  -> YES -> CRITICAL

Does it prevent modernization or cause failures at scale?
  -> YES -> HIGH

Is it a code smell or missing best practice?
  -> YES -> MEDIUM

Is it style, documentation, or minor?
  -> YES -> LOW
```

---

## CRITICAL (-10 points) - Security & Data Risk

**These can cause immediate harm. Block deployment.**

| Issue | Example | Why Critical |
|-------|---------|--------------|
| Hardcoded credentials | `var password = "P@ssw0rd"` | Exposed in source control |
| Hardcoded API keys/secrets | `var apiKey = "sk-123..."` | Credential leak |
| SQL injection | `$"SELECT * WHERE id = {userInput}"` | Data breach risk |
| Missing auth on endpoint | `[AllowAnonymous]` on sensitive endpoint | Unauthorized access |
| Auth bypass possible | Broken auth logic | Security breach |
| Sensitive data in logs | `_logger.Log($"SSN: {ssn}")` | Compliance violation |
| Tokens in localStorage | `localStorage.setItem('token', jwt)` | XSS can steal tokens |
| innerHTML without sanitization | `el.innerHTML = userInput` | XSS vulnerability |
| Credentials in URL | `?apiKey=secret123` | Logged in server logs |
| Missing HTTPS enforcement | No HTTPS redirect | Data interception |

---

## HIGH (-5 points) - Architectural Violations

**These will cause problems at scale or block modernization. Must fix.**

### Authentication & Authorization
| Issue | Example | Why High |
|-------|---------|----------|
| Forms Authentication | `<authentication mode="Forms">` | Can't modernize to OAuth |
| FormsAuthentication API | `FormsAuthentication.SetAuthCookie()` | Deprecated pattern |
| User.IsInRole() | `if (User.IsInRole("Admin"))` | Must migrate to policy-based |
| Role-based Authorize | `[Authorize(Roles = "Admin")]` | Must migrate to policy-based |

### Async Anti-Patterns
| Issue | Example | Why High |
|-------|---------|----------|
| .Result | `var data = GetAsync().Result` | Deadlocks in ASP.NET |
| .Wait() | `GetAsync().Wait()` | Thread pool starvation |
| .GetAwaiter().GetResult() | `GetAsync().GetAwaiter().GetResult()` | Same deadlock risk |
| async void | `public async void Process()` | Exceptions are lost |

### Dependency Injection Violations
| Issue | Example | Why High |
|-------|---------|----------|
| new ServiceClass() | `var svc = new OrderService()` | Can't test, can't swap |
| new HttpClient() | `var client = new HttpClient()` | Resource leak, can't mock |
| Service locator | `ServiceLocator.Get<IService>()` | Hidden dependencies |
| Factory hiding new | `Factory.Create()` returning `new Service()` | Still coupled |

### 12-Factor Violations
| Issue | Example | Why High |
|-------|---------|----------|
| Hardcoded connection string | `"Server=prod-db;Database=..."` | Can't deploy to diff env |
| Hardcoded API URL | `"https://api.prod.company.com"` | Can't deploy to diff env |
| Static mutable state | `private static List<T> _cache` | Can't scale horizontally |
| Session state for app data | `Session["Cart"] = cart` | Can't scale horizontally |
| File-based logging | `File.AppendAllText(logPath, msg)` | Doesn't work in containers |
| Local file storage | `File.WriteAllText("C:\\data\\...")` | Not cloud-ready |

### Code Structure
| Issue | Example | Why High |
|-------|---------|----------|
| God class | 500+ lines, 20+ methods | Unmaintainable |
| 8+ constructor dependencies | `ctor(a,b,c,d,e,f,g,h,i)` | Too many responsibilities |
| NotImplementedException | `throw new NotImplementedException()` | LSP violation |
| Circular dependency | ServiceA -> ServiceB -> ServiceA | Architecture problem |

### Angular
| Issue | Example | Why High |
|-------|---------|----------|
| document.* DOM access | `document.getElementById()` | Breaks Angular patterns |
| jQuery usage | `$('.class').hide()` | Remove dependency |
| Missing guard on admin route | `{ path: 'admin', component: Admin }` | Security gap |
| Guard always returns true | `canActivate() { return true; }` | No actual protection |

---

## MEDIUM (-2 points) - Code Smells & Best Practices

**These hurt maintainability but aren't blocking. Should fix.**

### Code Structure
| Issue | Example | Why Medium |
|-------|---------|------------|
| Large class | 300-500 lines | Getting unwieldy |
| Fat interface | Interface with 8-15 methods | ISP violation, harder to mock |
| 5-7 constructor dependencies | `ctor(a,b,c,d,e,f)` | Getting complex |
| Long method | 50+ lines | Hard to understand |
| Deep nesting | 4+ levels of if/for | Hard to follow |

### 12-Factor
| Issue | Example | Why Medium |
|-------|---------|------------|
| Magic numbers (non-security) | `var timeout = 30;` | Should be config |
| Environment check in code | `if (env == "Production")` | Config should vary, not code |
| Console.WriteLine logging | `Console.WriteLine(error)` | Should use ILogger |
| String concat in logs | `_logger.Log("Order " + id)` | Not structured |

### Async
| Issue | Example | Why Medium |
|-------|---------|------------|
| Missing ConfigureAwait | `await Task.Delay(100)` in library | Best practice for libraries |
| Task.Run wrapping async | `Task.Run(() => GetAsync())` | Usually unnecessary |
| Fire and forget | `_ = ProcessAsync()` without logging | Errors lost silently |

### Security
| Issue | Example | Why Medium |
|-------|---------|------------|
| Missing CSP header | No Content-Security-Policy | XSS protection gap |
| Missing route guard (non-admin) | Regular pages unguarded | Best practice |
| Weak CSP (unsafe-inline) | `script-src 'unsafe-inline'` | Weakens protection |

### Angular
| Issue | Example | Why Medium |
|-------|---------|------------|
| HttpClient in component | `constructor(private http: HttpClient)` | Should be in service |
| fetch() instead of HttpClient | `fetch('/api/data')` | Loses interceptors |
| Missing OnPush | Default change detection | Performance |
| Subscribe without unsubscribe | `obs.subscribe()` in component | Memory leak potential |

### Testing
| Issue | Example | Why Medium |
|-------|---------|------------|
| Test uses real database | `new DbContext(realConn)` | Slow, flaky |
| Test uses real HTTP | `new HttpClient()` in test | External dependency |
| Missing error case tests | Only happy path tested | Incomplete coverage |

### Other
| Issue | Example | Why Medium |
|-------|---------|------------|
| Missing IDisposable | Class with disposable fields | Resource leak potential |
| Empty catch block | `catch (Exception) { }` | Swallowing errors |
| Catching base Exception | `catch (Exception ex)` | Too broad |

---

## LOW (0 points) - Style & Documentation

**Nice to fix but not impactful. Fix if time permits.**

| Issue | Example | Why Low |
|-------|---------|---------|
| Missing XML comments | Public method without `///` | Documentation gap |
| Missing README section | README lacks debugging info | Documentation gap |
| Inconsistent naming | `orderData` vs `order` | Style preference |
| TODO comments | `// TODO: refactor this` | Cleanup needed |
| Unused using statements | `using System.Linq;` not used | Clutter |
| var vs explicit type | Inconsistent usage | Style preference |
| Regions in code | `#region Methods` | Style preference |
| Missing blank lines | Dense code blocks | Readability |
| Suboptimal LINQ | Could be more efficient | Micro-optimization |
| Commented out code | Old code left in comments | Cleanup needed |

---

## Category-Specific Reference

### 12-Factor Violations

| Violation | Severity |
|-----------|----------|
| Hardcoded password/API key | **CRITICAL** |
| Hardcoded connection string | **HIGH** |
| Hardcoded API URL | **HIGH** |
| Magic number (timeout, batch size) | **MEDIUM** |
| Static mutable state | **HIGH** |
| Instance state in singleton | **HIGH** |
| Session state for app data | **HIGH** |
| File-based logging | **HIGH** |
| Console.WriteLine logging | **MEDIUM** |
| String concatenation in logs | **MEDIUM** |
| Local file storage | **HIGH** |
| Missing IAsyncDisposable | **MEDIUM** |
| Ignoring CancellationToken | **MEDIUM** |

### SOLID Violations

| Violation | Severity |
|-----------|----------|
| new ServiceClass() | **HIGH** |
| new HttpClient() | **HIGH** |
| Service locator pattern | **HIGH** |
| God class (500+ lines) | **HIGH** |
| Large class (300-500 lines) | **MEDIUM** |
| Very large class (800+ lines) | **HIGH** |
| Fat interface (8-15 methods) | **MEDIUM** |
| Very fat interface (15+ methods) | **HIGH** |
| 8+ constructor dependencies | **HIGH** |
| 5-7 constructor dependencies | **MEDIUM** |
| NotImplementedException | **HIGH** |
| Empty interface implementation | **HIGH** |

### Security Violations

| Violation | Severity |
|-----------|----------|
| Hardcoded credentials | **CRITICAL** |
| SQL injection | **CRITICAL** |
| XSS vulnerability | **CRITICAL** |
| Missing authentication | **CRITICAL** |
| Token in localStorage | **CRITICAL** |
| Forms Authentication | **HIGH** |
| User.IsInRole() | **HIGH** |
| Authorize(Roles=...) | **HIGH** |
| .Result / .Wait() | **HIGH** |
| async void | **HIGH** |
| Missing CSP | **MEDIUM** |
| Weak CSP | **MEDIUM** |

### Angular Violations

| Violation | Severity |
|-----------|----------|
| innerHTML without sanitizer | **CRITICAL** |
| document.querySelector | **HIGH** |
| jQuery usage | **HIGH** |
| Missing guard (admin route) | **HIGH** |
| Guard returns true always | **HIGH** |
| HttpClient in component | **MEDIUM** |
| fetch() usage | **MEDIUM** |
| Missing guard (regular route) | **MEDIUM** |
| Missing OnPush | **LOW** |
| NgModule instead of standalone | **LOW** |

### API Violations

| Violation | Severity |
|-----------|----------|
| Verb-based URLs | **MEDIUM** |
| Missing HTTP method attribute | **MEDIUM** |
| XML formatters enabled | **MEDIUM** |
| Swagger in production | **MEDIUM** |
| Missing API versioning | **LOW** |
| Inconsistent naming | **LOW** |

### Testing Violations

| Violation | Severity |
|-----------|----------|
| Real database in unit test | **MEDIUM** |
| Real HTTP in unit test | **MEDIUM** |
| No security tests | **MEDIUM** |
| Missing mocks | **MEDIUM** |
| Test coverage < 80% | **MEDIUM** |
| Missing error case tests | **LOW** |

### Deliverable Violations

| Violation | Severity |
|-----------|----------|
| Missing README.md | **HIGH** |
| README incomplete | **MEDIUM** |
| Missing pipeline.yaml | **HIGH** |
| Pipeline missing test stage | **MEDIUM** |
| Missing .gitignore | **LOW** |

---

## Edge Cases

### When to Upgrade Severity

- Multiple MEDIUM issues in same file -> Consider HIGH for the file
- Pattern repeated across codebase -> Upgrade by one level
- Issue in security-critical code path -> Upgrade by one level

### When to Downgrade Severity

- Issue is in test code only -> May downgrade
- Issue is in generated code -> May skip or LOW
- Issue has compensating control -> May downgrade
- Legacy code being replaced soon -> Document but may downgrade

### What's NOT a Violation

- Using `new` for DTOs, entities, value objects -> OK
- Using `new` for collections (`new List<T>()`) -> OK
- Static readonly/const values -> OK (not mutable state)
- IMemoryCache for performance (not correctness) -> OK
- Environment checks for feature flags -> OK (but config is better)
