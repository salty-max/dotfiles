---
name: No dash placeholders
description: Never use "—" as placeholder for empty data, leave blank or hide the element
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Don't use "—" (em dash) as a placeholder when data is null/empty. Either leave the value blank or hide the element entirely.

**Why:** The user finds dashes as placeholders ugly and unhelpful.

**How to apply:** When displaying optional data (vehicle name, plate, phone, etc.), use empty string `''` for null values, not `'—'`.
