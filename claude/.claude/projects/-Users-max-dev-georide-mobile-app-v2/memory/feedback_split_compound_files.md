---
name: Compound components must be split into one file per sub-component
description: Never pack compound components into a single index.tsx — split into sub-files
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When creating a compound component in `src/components/ui/<name>/`, never pack everything in `index.tsx`. Split into one file per sub-component:

```
src/components/ui/<component>/
├── index.tsx          # Root + Object.assign export only
├── <sub1>.tsx         # Each sub-component in its own file
├── <sub2>.tsx
├── styles.ts          # Shared StyleSheet
└── <component>.stories.tsx
```

**Why:** Iverly's review on PR #100 flagged both `setting-toggle-card/index.tsx` and `how-it-works/index.tsx` as needing to be split. Single-file compounds get hard to navigate and the styles section bloats.

**How to apply:** When creating a new compound or adding sub-components to an existing one, immediately create separate files for each sub-component and a shared `styles.ts`. The `index.tsx` should only contain the Root function and `Object.assign(Root, { Sub1, Sub2 })`.
