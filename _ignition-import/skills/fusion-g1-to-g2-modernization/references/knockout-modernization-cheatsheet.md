# KnockoutJS Modernization Cheatsheet

Companion skill: `.github/skills/fusion-g1-to-g2-modernization/SKILL.md`. Use this file as the Knockout-focused reference behind that skill.

## Overview
KnockoutJS is an MVVM (Model-View-ViewModel) JavaScript framework for building dynamic UIs with declarative bindings and automatic UI refresh. It is now considered legacy; modernizing apps often means migrating to frameworks like React, Vue, or Angular.

## Core Concepts
- **Observables**: `ko.observable(value)` for primitives, `ko.observableArray([])` for arrays. Changes auto-update the UI.
- **Bindings**: Declarative HTML attributes (e.g., `data-bind="value: name"`).
- **ViewModels**: JavaScript objects with observable properties and methods.
- **Computed Observables**: `ko.computed(() => ...)` for derived values.
- **Binding Context**: `$root`, `$parent`, `$data` for scoping in nested templates.

## Common Bindings
- `text`, `html`, `visible`, `enable`, `disable`, `value`, `checked`, `click`, `foreach`, `with`, `if`, `attr`, `css`, `style`.
- Example: `<input data-bind="value: firstName, enable: isEditable" />`

## Validation (Knockout-Validation)
- Add validation rules to observables: `myField.extend({ required: true, minLength: 3 })`
- Use `data-bind="validationMessage: myField"` for error display.
- Configure globally via `ko.validation.init({ ... })`.
- See: https://github.com/Knockout-Contrib/Knockout-Validation/wiki/Configuration

## Modernization Tips
- **Identify ViewModels**: Map to component state in modern frameworks.
- **Replace Observables**: Use state hooks (React), refs (Vue), or services (Angular).
- **Bindings → JSX/Template Syntax**: Convert `data-bind` to framework-specific binding.
- **Validation**: Migrate to form validation libraries (Formik, Vuelidate, etc.).
- **Templates**: Replace `foreach`, `if`, `with` with native loops/conditionals.
- **Dispose**: Clean up subscriptions in modern component lifecycles.

## Example Migration (Knockout → React)
**Knockout:**
```html
<input data-bind="value: name, enable: isEditable" />
<span data-bind="text: name"></span>
```
```js
function AppViewModel() {
  this.name = ko.observable('Jane');
  this.isEditable = ko.observable(true);
}
ko.applyBindings(new AppViewModel());
```
**React:**
```jsx
const [name, setName] = useState('Jane');
const [isEditable, setIsEditable] = useState(true);
<input value={name} onChange={e => setName(e.target.value)} disabled={!isEditable} />
<span>{name}</span>
```

## References
- KnockoutJS: https://knockoutjs.com/
- Knockout-Validation: https://github.com/Knockout-Contrib/Knockout-Validation

---
_Use this cheatsheet to identify, refactor, and modernize KnockoutJS patterns in legacy web apps._
