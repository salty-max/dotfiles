---
name: No Pencil references in JSDoc
description: JSDoc must describe behaviour and contracts; never name Pencil frames or component IDs there
type: feedback
originSessionId: 738b7734-eca4-419d-8294-5c7bac619b3b
---
Do not mention Pencil frames, node IDs, or design-system references inside JSDoc comments on exports.

**Why:** JSDoc is consumed by future readers of the code and by tooling. Pencil frame IDs are an implementation detail that drifts as the design moves; surfacing them in JSDoc rots fast and adds no value to someone trying to understand the API contract. The PR description, commit message, or referenced GitHub issue is the right place to anchor a Pencil frame.

**How to apply:** When writing JSDoc for a function, type, or component, describe what it does, its parameters, and its return value. Skip any sentence that includes "Pencil", a frame ID, or a node ID. If a Pencil reference is genuinely useful to track something (e.g. for a reusable primitive), put it in the PR body or commit message — never in the source.
