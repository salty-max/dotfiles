---
name: All shared components must be compound by default
description: Every component in src/components/ui/ must use Object.assign compound pattern, never content props
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Every shared UI component in `src/components/ui/` must use the compound component pattern with `Object.assign(Root, { Sub1, Sub2 })`. Never use content/render props for composition.

**Why:** The user explicitly enforced this as a hard rule. Even simple components should be compound from the start — it's cheaper to compose than to refactor from props to compound later. Examples: `SettingToggleCard.Row`, `HowItWorks.Title`, `Button.Text`, etc.

**How to apply:** When creating any new component in `src/components/ui/`:
1. Create a `Root` function component
2. Create sub-components for each composable part
3. Export via `Object.assign(Root, { Sub1, Sub2, ... })`
4. Never accept `title`, `description`, `content`, `header`, `footer` as string/ReactNode props — use sub-components instead
