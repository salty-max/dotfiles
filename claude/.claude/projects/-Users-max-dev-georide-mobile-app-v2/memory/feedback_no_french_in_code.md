---
name: No French in code identifiers
description: Code identifiers, file names, and comments must be English. French only allowed in user-facing strings (locale files).
type: feedback
originSessionId: d1098e84-8e91-4c2f-bc3d-df3fd3a327cf
---
Code identifiers, file names, type names, hook names, selector names, testID prefixes, and comments must be in **English**. French strings are only allowed in `features/<name>/locales/fr.ts` (user-facing translations).

**Why:** The codebase is a multinational engineering surface; French-only words like `proches`, `lieux`, `partage` are opaque to non-French-speaking contributors and dilute the design-system vocabulary. The product UI can stay in French; the code that supports it cannot.

**How to apply:**

- Domain types: `Share`, `Zone` — never `Proche`, `Lieu`.
- Hooks/selectors: `useShares`, `useZones`, `selectZones` — never `useLieux`, `selectProches`.
- File names: `queries/zones.ts`, `selectors/zones.ts` — never `queries/lieux.ts`.
- testID prefixes: `sharing-loved-one`, `sharing-zone` — never `sharing-proche`, `sharing-lieu`.
- Comments: write the English domain term ("loved one", "arrival zone") rather than the French source ("proche", "lieu").
- Locale **keys** are also code: prefer `sharing.zones.*` over `sharing.lieux.*`. The values inside `fr.ts` are user-facing copy and stay in French.

When the Pencil designer named a component or section in French, translate the concept into English when naming the code identifier — don't transliterate.
