---
name: Mock screens don't need i18n
description: Only auth feature has final design — other features are mock/prototype, don't add translations for them
type: feedback
---

Don't create i18n locale files or replace hardcoded strings with t() calls for mock/prototype screens unless explicitly asked. Features with finalized designs (auth, profile) should use i18n.

**Why:** The hardcoded French strings are intentional placeholder text during prototyping — adding translations is premature work that will be redone when designs are finalized. But when the user explicitly asks to add i18n, do it.

**How to apply:** When implementing a feature, don't add i18n by default for mock screens. Add it when the user explicitly requests it or when wiring up live data (like theme/language pickers).
