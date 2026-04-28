---
name: Add typecheck npm script when missing
description: This project should always expose `pnpm typecheck` (tsc --noEmit) — add it if a project is missing it instead of running tsc directly
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
If `pnpm typecheck` doesn't exist in this repo, add `"typecheck": "tsc --noEmit"` to package.json scripts rather than running `pnpm exec tsc --noEmit` ad hoc.

**Why:** The user prefers a stable script entry point over invoking the TypeScript compiler directly. They flagged this when I ran `pnpm exec tsc --noEmit` because the npm script was missing, saying "Ce serait pas mal de rajouter le script type check au package.json, en vrai."

**How to apply:** Whenever you reach for `tsc --noEmit` (verifying a change, pre-commit safety check), first ensure the `typecheck` script exists in `package.json`. If it doesn't, add it in the same change before running it.
