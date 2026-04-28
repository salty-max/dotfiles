---
name: French for product chat, English for code artifacts
description: Default to French in conversational/strategy discussion; write code, CLAUDE.md, README, commits, issue bodies, PR descriptions in English
type: feedback
originSessionId: f8f382b4-cf42-449c-a2a5-fa5ff2594301
---
Max writes product/strategy discussion in French and expects the same back. But code-adjacent artifacts stay in English.

**Why:** Consistent throughout two projects (Tracer, Loom). Mirrors the georide-api-v2 and georide-mobile-app-v2 repos he works on professionally — their CLAUDE.md, commit messages, and API error codes are in English. The `AppException` `code` values are `SCREAMING_SNAKE_CASE` English identifiers that clients map to their own i18n.

**How to apply:**
- Chat, design docs (`docs/design.md`), product discussion, open-question flagging → French
- CLAUDE.md, README.md, commit messages, issue titles + bodies, PR descriptions, JSDoc, inline code comments, error codes, exception messages → English
- Variable/function names, file names → English per convention
- When unsure, check surrounding context — if the artifact is consumed by future developers (incl. non-French contributors / AI tooling), use English
