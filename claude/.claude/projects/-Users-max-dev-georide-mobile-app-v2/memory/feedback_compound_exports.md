---
name: feedback_compound_exports
description: UI components should use compound component pattern (Field.Label, Button.Text) not barrel re-exports
type: feedback
---

When creating barrel/index files for UI components, use the compound component pattern with Object.assign (e.g. `Field.Label`, `Button.Text`) instead of individual named exports. This matches the existing pattern used for `Onboard.Step`, `Onboard.Header`, etc.

**Why:** Consistent API across the codebase. Compound components make the relationship between parent and child explicit at the usage site.

**How to apply:** Use `Object.assign(RootComponent, { SubComponent1, SubComponent2 })` in the index file and update consumers to use `Root.Sub` syntax.
