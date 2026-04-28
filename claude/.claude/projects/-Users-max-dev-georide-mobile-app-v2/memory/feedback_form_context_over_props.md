---
name: feedback_form_context_over_props
description: Field should resolve form errors via useFormContext, not via an errors prop
type: feedback
---

Prefer using react-hook-form's `useFormContext` inside Field to auto-resolve errors, rather than passing `errors` as a prop. Forms should wrap content in `<FormProvider>`.

**Why:** Avoids prop drilling the errors object through every Field. The form context is the canonical source of error state.

**How to apply:** When integrating Field with react-hook-form, use `FormProvider` + `useFormContext` pattern. Field only needs `name` to resolve its error.
