---
name: Fix at the shared level first, not per-component
description: When fixing a UI issue, check if it affects multiple instances and fix globally
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When encountering a UI issue (padding, spacing, safe area), always check if it could affect other instances of the same component. Fix at the shared component level rather than adding per-component overrides.

**Why:** The bottom padding issue was first fixed only on the SOS sheet with a hardcoded `paddingBottom: gap(6)`, when it should have been fixed once in `SheetScrollView` with `useSafeAreaInsets()` to benefit all sheets automatically.

**How to apply:** Before adding a local fix, ask: "Does this affect other instances?" If yes, fix the shared component. Examples: SheetScrollView padding, AsyncBoundary wrapping, theme token values.
