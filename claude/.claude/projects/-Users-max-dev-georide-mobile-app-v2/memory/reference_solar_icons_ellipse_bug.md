---
name: Broken solar icons that use Ellipse
description: Some react-native-solar-icons include Ellipse nodes without importing them, crashing at runtime with "Property 'Ellipse' doesn't exist". Avoid these specific icons.
type: reference
originSessionId: f39fe68c-7447-45e9-8c46-f73f414b693f
---
Several icons in `react-native-solar-icons` are packaged with a missing
`Ellipse` import from `react-native-svg` — the generated JS file calls
`createElement(Ellipse, ...)` but only destructures `{ Circle, Path }`.
Using them crashes the app at render time.

Known affected icons (linear set, as of v0.x):

- `UsersGroupRounded`
- `UsersGroupTwoRounded`

When picking a "people/riders" style icon, prefer `PeopleNearby` or
`UserRounded` — they don't use Ellipse.

**Why**: Verified by inspecting the packaged
`node_modules/react-native-solar-icons/dist/generated/linear/*.esm.js`
files — the Ellipse reference is present in the `createElement` call
but absent from the top-level `import from "react-native-svg"`
destructure.

**How to apply**: Before using a solar icon name you haven't seen
elsewhere in the codebase, grep its packaged source for `Ellipse` —
if it's used but not imported, pick another icon.
