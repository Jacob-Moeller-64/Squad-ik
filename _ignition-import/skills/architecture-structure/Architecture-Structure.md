# App Mod Architecture Standards

**CQRS** (Command Query Responsibility Segregation): the application layer separates **reads** (queries/gets) from **writes** (commands/posts).

---

## Simple Web App ("No one relies on me")

### Front-end (Simple Web App)

1. Web project folder

### Back-end (Simple Web App)

> **No CQRS for simple apps.**

#### 1. API layer (`Project.Api`) for simple apps

Directly calls the Library.

- **References:** `Project.Library`
- **Structure:**

```csharp
Project.Api/
    Controllers/
        MyObjectController.cs
        OtherObjectController.cs
    DTOs/ // Map out the object the way that the UI needs it
        WebObjectDTO.cs
    appsettings*.json // AppSettings for WebAPI running
```

#### 2. Library (`Project.Library`) for simple apps

This combines the complicated app's Domain, Application, and Infrastructure projects.

- **References:** none
- **Structure:**

```csharp
Project.Library/
    Data/
        APIs/            // Connections to external APIs
        Repositories/    // Should separate by different DBs
            MyDataRepository.cs
        Services/
            Emails/
                MailkitService.cs
                SMTPService.cs
            Notifications/
    Models/
        Entities/        // Mapping a class to DB
            MyObject1.cs
        Enums/
            Statuses.cs
    Features/            // Separate folders by functionality (feature implementations)
        MyAppObject1/
            MyAppObject1Service.cs
```

---

## Complicated Application ("Other apps currently or will rely on me")

> **Uses CQRS.**

### Front-end (Complicated Application)

1. Web project folder

### Back-end (Complicated Application)

#### 1 API layer (`Project.Api`) for complicated apps

Directly calls the Application layer.

- **References:** `Project.Application`
- **Structure:**

```csharp
Project.Api/
    Controllers/
        MyObjectController.cs
        OtherObjectController.cs
    Middleware/     // What does this do??
    appsettings.json
```

- **Notes:** Controllers are called by the front end and should be organized based on the DTOs they return/work with.

#### 2 Application (`Project.Application`)

Holds the logic for your use cases/features (i.e., the logic for your front end to do what it needs to do for the user).

- **References:** `Project.Domain`
- **Structure (example):**

```csharp
Project.Application/        // Separate folders by object type / feature worked with?
    MyAppObject1/
        MyAppObject1Command.cs  // Dion thinks handler + definition in one; command returns success/failure
        MyAppObject1Query.cs    // List + handler in one? Query returns data (object or list of objects)
    MyAppObject2/
    DependencyInjection.cs   // Defines which Infrastructure stuff you are using
```

#### 3 Infrastructure (`Project.Infrastructure`)

Specific implementations of the interfaces defined in Domain. This typically includes external references like DBs, files, and APIs.

- **References:** none? (`Project.Application`?)
- **Structure (example):**

```csharp
Project.Infrastructure/
    APIs/ // Connections to various external APIs?
    Repositories/ // Should separate for different DBs
    Services/ // Separate folders by functionality
        Emails/
            MailkitService.cs
            SMTPService.cs
        Notifications/
    DependencyInjection.cs // Defines which Infrastructure stuff you are using
```

#### 4 Domain (`Project.Domain`)

The logical separation of models and interfaces to be used/implemented (by Infrastructure).

- **References:** `Contracts` (if logical layer is needed to be separated)
- **Structure (example):**

```csharp
Project.Domain/
    Common/
        BaseEntity.cs
    Entities/
        Object1.cs
        Object2.cs
    ValueObjects/
        ValueObject1.cs
    Enums/
        Statuses.cs
    Interfaces/
        IOrderRepo.cs    // Interface definition only
        IThingToDo.cs
    Events/
    Exceptions/
```

#### 5 Tests

Use one repo-root testing workspace organized by execution surface first, then by test type.

```text
LegacyCode/<App>.Data.Tests/
    Characterization/
        Baseline/

tests/
    backend/
        unit/
        contractApi/
        integrationBackend/
    frontend/
        angularUnitComponent/
        integrationFrontend/
        smoke/
        e2e/
            journeys/
            accessibility/
        visualParity/
    modernization/
        characterization/
            testcase/
            testResult/
```

- Inside `LegacyCode/`, new tests should be characterization-only and must live under the owning `Characterization/Baseline` folder.
- Legacy baseline characterization stays in `LegacyCode/<App>.Data.Tests/Characterization/Baseline`, while modernization-owned parity harness files live under `tests/modernization/characterization/testcase` and each modernization step records its cumulative execution summary in `tests/modernization/characterization/testResult/`.
- Do not create new step-named folders or duplicate step-prefixed parity files under `tests/modernization/characterization`. Use testcase metadata, stable ids, and per-step Markdown reports to track phase ownership instead.
- Keep backend proof under `tests/backend/`.
- Keep frontend proof under `tests/frontend/`.
- Keep browser-driven frontend integration proof under `tests/frontend/integrationFrontend/`.
- Keep whole-frontend Playwright smoke under `tests/frontend/smoke/`.
- Keep Playwright journeys and accessibility proof under `tests/frontend/e2e/`.
- Keep screenshot-backed parity and visual review proof under `tests/frontend/visualParity/`.
- Use `tests/frontend/integrationFrontend` for browser-driven component-to-API proof that navigates to a real route, triggers the owning UI control, captures the matched network request or response plus response code, and asserts the resulting UI state.
- Keep modernization-only characterization parity harnesses under `tests/modernization/characterization/testcase/` and per-step reports under `tests/modernization/characterization/testResult/`.
- Modernization Quality Design should establish the phased characterization ladder before later phases begin adding modernization proof, and Step 9 should preserve the workspace contract as real tests grow.

---

#### Solution-level files

- `Dockerfile`
- `.dockerignore`
- `*.yaml` files

---

## Random Other Notes

### Domain-Driven Design (DDD)

- Domain mimics design of underlying data in DB.
- Models would be in Application and be more along lines of what is needed for the app.

### Entity vs Value Object

- **Entity:** removing the ID breaks it. This is a long lived unique instance of an object (e.g. a customer, a streetlight) with traits/values that can change but must be tracked.
- **Value Object:** removing the ID makes it better. This is for sort of generic data values that can be tied to Entities but has no history/tracking of traits on its own (e.g. addresses, values within a dropdown, etc.).

---
