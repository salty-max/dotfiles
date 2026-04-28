---
name: No knip ignore hacks
description: Don't ignore unused files in knip — wire them properly so they're imported
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Never add files to knip ignore just because they're not imported yet. If mock API files (domain/types, queries, mutations) are unused, wire them into the feature that needs them so the import chain is real. Ignoring files is a hack that hides dead code.

**Why:** The user was upset about adding mock API files to knip ignore instead of actually importing them from the onboard flows or menus. The files should be consumed by actual UI code.

**How to apply:** When creating mock API infrastructure (types → mock → queries → mutations), immediately wire them into the UI component that will use them. Don't commit unused files with knip ignores.
