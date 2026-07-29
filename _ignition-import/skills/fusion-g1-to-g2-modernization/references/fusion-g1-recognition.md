# Fusion G1 Detailed Reference

Companion skill: `.github/skills/fusion-g1-to-g2-modernization/SKILL.md`. Use this file as the detailed portable reference behind that skill.

This file is a **portable, standalone cheat sheet** for Copilot agents working in and interpreting legacy **Fusion G1** applications (KnockoutJS + RequireJS/Durandal-style SPA patterns) as they are modernized (typically to **Angular 20 + .NET 10** unless otherwise specified).

It is intentionally written so it can be copied into other solutions **without assuming access to any specific repo folder structure or internal documentation site**.

## Non-negotiable rule
**Do not invent Fusion APIs.** Fusion controls/services are framework- and org-specific.

If you can't confirm a Fusion control/service/method in the target solution (via its own docs, code, or shipped client bundles), treat it as **unknown** and ask for developer context.

## What Fusion G1 typically looks like
- **KnockoutJS** drives bindings (`ko.observable`, `ko.computed`, `data-bind`, containerless bindings).
- **RequireJS (AMD)** loads modules (`define([...], function (...) { ... })`).
- **Durandal-style lifecycle hooks** may exist on view models (e.g., activation/attachment callbacks).
- Many framework services and integrations use **jQuery Deferred** (not native Promises).

### Minimal AMD view-model skeleton (copy/paste)
```js
define([
  "knockout",
  "$data",
  "$navigation",
  "$toastr"
], function (ko, $data, $navigation, $toastr) {
  "use strict";

  var m = {};

  // State
  m.isBusy = ko.observable(false);
  m.errorMessage = ko.observable("");

  // Example screen lifecycle (names vary by framework/version)
  m.onActivate = function () {
    m.isBusy(true);
    return $data.get("get", "demo", null, true)
      .done(function (result) {
        // map result -> observables
      })
      .fail(function (xhr) {
        $toastr.error("Failed to load data");
        m.errorMessage("Load failed");
      })
      .always(function () {
        m.isBusy(false);
      });
  };

  m.goHome = function () {
    // optionsObject shapes vary by implementation
    $navigation.navigateTo({ redirect: "home" });
  };

  return m;
});
```

## Third-party libraries you may encounter
Fusion G1 apps commonly include some combination of:
- jQuery (+ jQuery UI)
- KnockoutJS
- RequireJS
- Durandal
- Kendo UI (jQuery widgets)
- DataTables
- moment.js
- toastr
- SignalR v2 (in some stacks)
- ArcGIS JavaScript API (when map controls are present)

**Tip (portable version detection):** in the target solution, search the shipped client assets for banner comments like `/*! jQuery v... */` or inspect `*.map` files, `packages.config`, `package-lock.json`, or vendor folders. Prefer what the solution actually ships.

## KnockoutJS modernization notes (expanded)
Knockout is legacy, but modernization is straightforward when you translate KO concepts to component/state patterns.

### KO concepts -> modern equivalents
- `ko.observable(x)` -> component state
- `ko.observableArray([])` -> array state
- `ko.computed(fn)` / `ko.pureComputed(fn)` -> derived state / memoized selector
- `subscribe(...)` -> effect/watchers; ensure teardown
- `foreach/if/with` -> template loops/conditionals
- `click` -> event handlers

### Binding-context rules you must preserve
- `$root`, `$parent`, `$parents[n]`, `$data`, `$index` can materially affect behavior in nested templates.
- When modernizing, explicitly model which component owns which state.

### High-signal KO patterns to look for
- **Observable wrappers**: `m.value()` reads, `m.value(newValue)` writes.
- **Computed chains**: computed reading other computed/observables.
- **Mutation patterns**:
  - `observableArray.push(...)`, `remove(...)`, `replace(...)`
  - `observableArray().slice(...)` (be careful: this reads the underlying array)
- **Async behavior**: KO bindings + jQuery Deferred callbacks + DOM timing.

### Subscriptions: always plan teardown
Legacy pages often rely on screen lifetime; modern components need explicit cleanup.

```js
var sub = m.someObservable.subscribe(function (v) {
  // ...
});

// later, in component unmount / dispose hook:
sub.dispose();
```

### Common KO bindings (the ones modernization agents should recognize)
- `text`, `html`, `visible`, `enable`, `disable`
- `value`, `checked`, `click`
- `foreach`, `with`, `if`, `ifnot`
- `attr`, `css`, `style`

### KnockoutJS reference URLs (public)
- Knockout home: https://knockoutjs.com/
- Binding syntax: https://knockoutjs.com/documentation/binding-syntax.html
- Observables: https://knockoutjs.com/documentation/observables.html
- Computed observables: https://knockoutjs.com/documentation/computedObservables.html
- Click binding: https://knockoutjs.com/documentation/click-binding.html
- Value binding: https://knockoutjs.com/documentation/value-binding.html
- Checked binding: https://knockoutjs.com/documentation/checked-binding.html
- Foreach binding: https://knockoutjs.com/documentation/foreach-binding.html
- If/ifnot: https://knockoutjs.com/documentation/if-binding.html
- With: https://knockoutjs.com/documentation/with-binding.html
- Custom bindings: https://knockoutjs.com/documentation/custom-bindings.html
- Extenders (often used for validation): https://knockoutjs.com/documentation/extenders.html

### Knockout-Validation (if present)
- Repo + docs: https://github.com/Knockout-Contrib/Knockout-Validation
- Configuration: https://github.com/Knockout-Contrib/Knockout-Validation/wiki/Configuration

Modernization mapping ideas:
- Replace KO validation with Angular Reactive Forms validators (or your target framework's form library).
- Preserve validation semantics (required, min/max, async validation) rather than copying UI behavior.

## Fusion binding conventions (portable guidance)
Fusion G1 commonly uses **custom elements** like `<fusion-xyz>` that are documented in this file below.

Many implementations support an **attribute syntax** where attribute values are treated as KO expressions.

- To pass a **string literal**, wrap it in quotes: `labelText="'Name'"`.
- To pass an **observable**, pass the symbol name: `value="m.name"`.
- To pass a **boolean literal**, use `true/false`.
- For complex objects/arrays, prefer referencing a view-model property (avoid huge inline objects).

If your target solution uses `params="..."` style instead, keep consistent with that solution.

## Fusion UI controls (examples)
These examples are written to be copy/paste-friendly and **do not assume access to any repo-specific docs**.

Important: Fusion implementations vary. Parameter names, casing, and required modules **must be validated** in the target solution.

### `<fusion-alertbox>`

```html
<fusion-alertbox alertType="m.alertType" isAlertDismissable="true">
  <span data-bind="text: m.alertMessage"></span>
</fusion-alertbox>
```

```js
m.alertType = ko.observable("warning");
m.alertMessage = ko.observable("Check your input.");
```

### `<fusion-appleheader>`

```html
<fusion-appleheader applicationName="'MyApp'" homePath="'home'" iconUrl="m.iconUrl" isMenuHoverable="true"></fusion-appleheader>
```

```js
m.iconUrl = ko.observable("/content/img/app-icon.png");
```

### `<fusion-chart>`

Some implementations use `params="..."` rather than attribute syntax for this control.

```html
<fusion-chart params="charts: m.charts, options: m.chartOptions"></fusion-chart>
```

```js
m.charts = ko.observableArray([
  // shape varies by implementation
]);

m.chartOptions = {
  // shape varies by implementation
};
```

### `<fusion-chartjs>`

```html
<fusion-chartjs options="m.chartJsOptions" chart="m.chart"></fusion-chartjs>
```

```js
m.chart = ko.observable(null);

m.chartJsOptions = {
  type: "bar",
  data: {
    labels: ["A", "B"],
    datasets: [{ label: "Count", data: [1, 2] }]
  }
};
```

### `<fusion-checkbox>`

```html
<fusion-checkbox isChecked="m.isActive" labelText="'Active'" isEnabled="m.canEdit"></fusion-checkbox>
```

```js
m.isActive = ko.observable(false);
m.canEdit = ko.observable(true);
```

### `<fusion-checkboxgroup>`

```html
<fusion-checkboxgroup headerText="'Options'" selectedValues="m.selectedOptions">
  <fusion-checkboxgroup-item text="'Option A'" value="'A'"></fusion-checkboxgroup-item>
  <fusion-checkboxgroup-item text="'Option B'" value="'B'"></fusion-checkboxgroup-item>
</fusion-checkboxgroup>
```

```js
m.selectedOptions = ko.observableArray(["A"]);
```

### `<fusion-container>`

```html
<fusion-container isBusy="m.isBusy" busyMessage="'Loading...'" shouldCoverHeader="false">
  <div>
    <h2 data-bind="text: m.title"></h2>
    <button data-bind="click: m.reload">Reload</button>
  </div>
</fusion-container>
```

```js
m.title = ko.observable("Demo");
m.isBusy = ko.observable(false);

m.reload = function () {
  m.isBusy(true);
  return $data.get("get", "demo", null, true)
    .always(function () { m.isBusy(false); });
};
```

### `<fusion-currency>`

```html
<fusion-currency value="m.amount" labelText="'Amount'" isPrefixVisible="true" isZeroValuesAllowed="true" isNegativeNumberAllowed="false"></fusion-currency>
```

```js
m.amount = ko.observable(0);
```

### `<fusion-datatable>`

```html
<fusion-datatable dtdata="m.rows" dtcolumns="m.columns" dtoptions="m.dtOptions" tableRef="m.tableRef"></fusion-datatable>
<button data-bind="click: m.refreshTable">Refresh</button>
```

```js
m.rows = ko.observableArray([]);

m.columns = [
  { title: "Name", data: "name" },
  { title: "Age", data: "age" }
];

m.dtOptions = {
  paging: true,
  searching: false
};

m.tableRef = ko.observable(null);

m.refreshTable = function () {
  var table = m.tableRef();
  if (table && table.ajax && table.ajax.reload) {
    table.ajax.reload();
  }
};
```

### `<fusion-datepicker>`

```html
<fusion-datepicker value="m.selectedDate" labelText="'Date'" type="'datepicker'" allowWeekends="true"></fusion-datepicker>
```

```js
m.selectedDate = ko.observable(null);
```

### `<fusion-dropdown>`

```html
<fusion-dropdown
  items="m.items"
  selectedValue="m.selectedId"
  displayMember="'name'"
  valueMember="'id'"
  defaultItemText="'Select...'"
  labelText="'Item'">
</fusion-dropdown>
```

```js
m.items = ko.observableArray([
  { id: 1, name: "One" },
  { id: 2, name: "Two" }
]);

m.selectedId = ko.observable(null);
```

### `<fusion-esrimap>`

```html
<fusion-esrimap initCallback="m.onMapInit" esriServices="m.esriServices" esriApiVersion="'4.24'"></fusion-esrimap>
```

```js
m.esriServices = ko.observableArray([]);

m.onMapInit = function (mapApi) {
  // implementation-specific: mapApi may expose map/view/widgets
};
```

### `<fusion-expander>`

```html
<fusion-expander mode="'accordion'" expandedPanels="m.expandedPanels">
  <fusion-expander-panel text="'Panel 1'" isExpanded="true">
    <div>Panel 1 body</div>
  </fusion-expander-panel>
  <fusion-expander-panel text="'Panel 2'">
    <div>Panel 2 body</div>
  </fusion-expander-panel>
</fusion-expander>
```

```js
m.expandedPanels = ko.observableArray([0]);
```

### `<fusion-kendogrid>`

```html
<fusion-kendogrid observableData="m.gridData" kendoOptions="m.gridOptions" autoFitColumns="true"></fusion-kendogrid>
```

```js
m.gridData = ko.observableArray([
  { id: 1, name: "One" },
  { id: 2, name: "Two" }
]);

m.gridOptions = {
  columns: [
    { field: "id", title: "Id" },
    { field: "name", title: "Name" }
  ],
  sortable: true
};
```

### `<fusion-linkexpander>`

```html
<fusion-linkexpander mode="'expander'">
  <fusion-linkexpander-panel text="'More details'">
    <content>
      <div data-bind="text: m.details"></div>
    </content>
  </fusion-linkexpander-panel>
</fusion-linkexpander>
```

```js
m.details = ko.observable("Extra information...");
```

### `<fusion-list>`

```html
<script type="text/html" id="itemTemplate">
  <div>
    <span data-bind="text: name"></span>
    <button data-bind="click: $parent.removeItem">Remove</button>
  </div>
</script>

<fusion-list items="m.items" itemTemplate="'itemTemplate'" isZebraStriped="true"></fusion-list>
```

```js
m.items = ko.observableArray([{ name: "Alice" }, { name: "Bob" }]);

m.removeItem = function (item) {
  m.items.remove(item);
};
```

### `<fusion-mfa-verify>`

```html
<fusion-mfa-verify value="m.code" numberOfCodeDigits="6" isValueReady="m.isCodeReady" clearCode="m.clearCode"></fusion-mfa-verify>
```

```js
m.code = ko.observable("");
m.isCodeReady = ko.observable(false);

m.clearCode = function () {
  m.code("");
  m.isCodeReady(false);
};
```

### `<fusion-radioexpander>`

```html
<fusion-radioexpander selectedValue="m.plan">
  <fusion-radioexpander-panel value="'basic'"><header>Basic</header><content>Basic content</content></fusion-radioexpander-panel>
  <fusion-radioexpander-panel value="'pro'"><header>Pro</header><content>Pro content</content></fusion-radioexpander-panel>
</fusion-radioexpander>
```

```js
m.plan = ko.observable("basic");
```

### `<fusion-radiogroup>`

```html
<fusion-radiogroup headerText="'Choose one'" selectedValue="m.choice" contentMode="'static'">
  <fusion-radiogroup-item text="'A'" value="'A'"></fusion-radiogroup-item>
  <fusion-radiogroup-item text="'B'" value="'B'"></fusion-radiogroup-item>
</fusion-radiogroup>
```

```js
m.choice = ko.observable("A");
```

### `<fusion-slideout>`

```html
<fusion-slideout isOpen="m.isOpen" options="m.slideoutOptions">
  <panel>
    <h3>Panel</h3>
    <button data-bind="click: m.close">Close</button>
  </panel>
  <content>
    <button data-bind="click: m.open">Open</button>
    <div>Main content</div>
  </content>
</fusion-slideout>
```

```js
m.isOpen = ko.observable(false);
m.slideoutOptions = {};
m.open = function () { m.isOpen(true); };
m.close = function () { m.isOpen(false); };
```

### `<fusion-stepindicator>`

```html
<fusion-stepindicator steps="m.steps" currentstep="m.current"></fusion-stepindicator>
```

```js
m.steps = ko.observableArray([{ text: "Start" }, { text: "Verify" }, { text: "Finish" }]);
m.current = ko.observable(0);
```

### `<fusion-textarea>`

```html
<fusion-textarea value="m.notes" labelText="'Notes'" rows="4" valueUpdate="'afterkeydown'"></fusion-textarea>
```

```js
m.notes = ko.observable("");
```

### `<fusion-textbox>`

```html
<fusion-textbox value="m.username" labelText="'User'" placeholder="'Enter username'" isEnabled="true" maxLength="50" updateOnKeystroke="true"></fusion-textbox>
```

```js
m.username = ko.observable("");
```

### `<fusion-timepicker>`

```html
<fusion-timepicker value="m.selectedTime" labelText="'Time'"></fusion-timepicker>
```

```js
m.selectedTime = ko.observable("09:00");
```

### `<fusion-toggle>`

```html
<fusion-toggle value="m.featureEnabled" callBack="m.onToggle"></fusion-toggle>
```

```js
m.featureEnabled = ko.observable(false);

m.onToggle = function (newValue) {
  return $data.post("set", "feature", { enabled: newValue }, true)
    .done(function () { $toastr.success("Saved"); })
    .fail(function () { $toastr.error("Save failed"); });
};
```

### `<fusion-toolbar>`

```html
<fusion-toolbar>
  <fusion-toolbarbutton icon="'fa-save'" action="m.save" toolTip="'Save'" isEnabled="m.canSave"></fusion-toolbarbutton>
  <fusion-toolbarbutton icon="'fa-times'" action="m.cancel" toolTip="'Cancel'"></fusion-toolbarbutton>
</fusion-toolbar>
```

```js
m.canSave = ko.observable(true);

m.save = function () { $toastr.success("Saved"); };
m.cancel = function () { $navigation.navigateBack(); };
```

### `<fusion-upload>`

```html
<fusion-upload files="m.files" labelText="'Upload files'" multiple="true" allowedExtensions="m.allowedExtensions" maxFileSize="m.maxFileSize"></fusion-upload>
```

```js
m.files = ko.observableArray([]);
m.allowedExtensions = [".pdf", ".jpg", ".png"];
m.maxFileSize = 10 * 1024 * 1024;
```

## Fusion services (portable A-Z reference)

Service names and signatures vary by implementation. Treat this as a **recognition and search guide**.

### `$cache`
- Often provides simple client-side caching (get/set/clear/hasKey/reset patterns).
- `get(key, clear, throwIfNotFound)`
- `set(data)` and `set(key, data)`
- `clear(key, partialKey)`
- `hasKey(key)`
- `resetCache()`
- Example:
  ```js
  $cache.set("user", userObj);
  var cached = $cache.get("user");
  if ($cache.hasKey("user")) { $cache.clear("user"); }
  $cache.reset(); // clear all
  ```

### `$config`
- Often exposes applet/module configuration (baseUrl, navigation config, dynamic settings).
- Example:
  ```js
  var apiUrl = $config.baseUrl;
  var nav = $config.navigation;
  var setting = $config.get("featureFlag");
  ```

### `$data`
HTTP helper returning `jQuery.deferred.promise()`.
- `get(method, controller, data, enableLogging)`
- `post(method, controller, data, enableLogging)`
- `clear(controller, method, data)` (clears server-side cache for the call)
- `settings` (includes `adalToken` and `on401` hook)

- Modernization: normalize to native Promises/`async` early.
- Examples:
  ```js
  // GET example
  $data.get("APIFunctionName", "MyFusionWebApi")
    .then(function (result) {
      if (result2) {
        m.myResult(result);
      }
    })
    .fail(function () {
      $event.publish(m.events.pageBlock, false);
    });

  // POST example
  $data.post("set", "user", { id: 1, name: "Alice" }, true)
    .then(function () { $toastr.success("Saved"); })
    .fail(function () { $toastr.error("Save failed"); });

  // Modernization: wrap in Promise
  function getUsersAsync() {
    return new Promise(function (resolve, reject) {
      $data.get("GetAutoCardEnrollEligible", "PaymentsWebApi")
        .then(resolve)
        .fail(reject);
    });
  }
  ```

### `$dialog`
Dialog helper returning Deferreds for show operations.
- `show(title, message, buttons)`
- `showCustom(...)`
- `close(dialog, result)`
- Example:
  ```js
  // Show a modal dialog and handle result
  $dialog.show({ title: "Confirm", message: "Are you sure?" })
    .then(function (result) {
      if (result === "ok") { /* proceed */ }
    });
  ```

### `$event`
- Often provides pub/sub (`publish`, `subscribe`).
- Example:
  ```js
  $event.subscribe("user:login", function (user) { /* ... */ });
  $event.publish("user:login", { id: 1 });
  ```

### `$log`
Logging/analytics.
- `error(message, detail)`
- `warning(message)`
- `trace(message)`
- `analytic(type, message)`
- Example:
  ```js
  $log.trace("trace message");
  $log.warning("warn message");
  $log.error("error message");
  ```

### `$navigation`
SPA navigation.
- `activate(optionsObject)`
- `navigateTo(optionsObject, ...params)`
- `navigateToUrl(url)`
- `navigateBack()`

Notes from docs:
- `navigateTo` supports URL parameters and also "in-memory" parameters.
- Lifecycle hooks may return `{ redirect: 'home' }`.

- Examples:
  ```js
  $navigation.navigateTo({ redirect: "home" });
  $navigation.navigateBack();
  $navigation.navigateToUrl("/docs/intro");
  // Sometimes: $navigation.reload();
  ```

### `$perfLogScope`
- Often provides simple performance measurement helpers (start/end measure patterns).
- Example:
  ```js
  var perf = $perfLogScope.start("loadData");
  // ... do work ...
  perf.end();
  ```

### `$signalR`
When present, provides SignalR v2 integration patterns (client hub connection, events).
- Example:
  ```js
  var hub = $signalR.hub;
  hub.on("message", function (msg) { /* ... */ });
  hub.start();
  ```

### `$toastr`
- Common wrapper around toastr.
- `warning(message, title, optionsOverride)`
- `success(message, title, optionsOverride)`
- `error(message, title, optionsOverride)`
- `remove()`
- `clear(toast)`
- Example:
  ```js
  $toastr.success("Saved");
  $toastr.error("Error!");
  $toastr.info("Heads up");
  ```

### `$utility`
Common helper bag
- String: `startsWith`, `endsWith`, `trim`
- URL: `removeLeadingSlash`, `removeTrailingSlash`, `ensureTrailingSlash`
- Checks: `isNull`, `isNullOrEmpty`, `isNullOrWhitespace`, `isDate`, `isInteger`
- Parse: `tryParseBool`
- Other: `getAppletResource` (no leading slash), `formatCurrency`, `handleEnterKey`
- Examples:
  ```js
  var safe = $utility.tryParseInt("42");
  var isNullOrEmpty = $utility.isNullOrEmpty(str);
  var url = $utility.combineUrl("/api", "users");
  $utility.focusNextInput();
  // ...other helpers may exist...
  ```


## Practical modernization guidance (Fusion G1 -> Angular/.NET)

- **Stop the bleeding first:** replace jQuery Deferred with native Promise wrappers at module boundaries.
- **Carve screens into components:** each view model tends to map to a component + services.
- **Replace KO bindings with template syntax:** preserve behavior before visual parity.
- **Don't port DOM hacks:** prefer data-driven rendering and framework lifecycle.
- **Be explicit about routes/state:** KO/Durandal apps often rely on implicit global state.
