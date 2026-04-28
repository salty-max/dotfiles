---
name: Hooks belong in hooks files, not types files
description: Don't put React hooks (useXxx) in files named types.ts — hooks go in hooks files
type: feedback
---

Never export React hooks from a `types.ts` file. Types files should only contain types, interfaces, classes, and type utilities. Hooks belong in `hooks.tsx` or a dedicated hook file.

**Why:** The user finds it semantically wrong to import a hook from a types module — it breaks the convention that types files are pure type definitions.

**How to apply:** When extracting shared code from a module, ensure hooks stay in hook files and only types/classes move to types files.
