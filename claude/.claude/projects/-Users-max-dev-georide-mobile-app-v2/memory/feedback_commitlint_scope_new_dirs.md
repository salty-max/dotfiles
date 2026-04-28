---
name: Add commitlint scope when creating new directories
description: Always add the scope to commitlint.config.mjs when creating new lib/, components/, or features/ dirs
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When creating a new directory under `lib/`, `components/ui/`, or `features/`, immediately add its scope to `commitlint.config.mjs` in the same commit. Don't wait for the hook to fail.

**Why:** The `lib/units` commit failed because the scope wasn't registered. This wastes a commit cycle and requires re-staging.

**How to apply:** After creating a new directory (e.g. `src/lib/units/`), open `commitlint.config.mjs` and add the scope with a comment explaining when to use it, before committing.
