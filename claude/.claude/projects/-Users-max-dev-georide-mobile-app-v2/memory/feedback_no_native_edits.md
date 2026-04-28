---
name: Never edit generated native files (ios/ and android/) manually
description: User rejects manual edits to Info.plist / AndroidManifest / Podfile — fix it via app.json config or by fixing the JS/TS instead
type: feedback
originSessionId: 9c0b6075-18ed-4cca-b830-7c3027858354
---
Never patch `ios/**/Info.plist`, `ios/**/Podfile*`, `android/app/src/main/AndroidManifest.xml`, or any other generated native file as a fix. These files are produced by `expo prebuild` from `app.json` + plugin configs — touching them by hand creates drift that gets wiped on the next prebuild.

**Why:** Max was explicit: "Change pas les pod files tout seul. C'est pas un fixe acceptable." They rebuild natively themselves, so they already know whether a rebuild picks up the change — if a rebuild still crashes, the bug is not in the native permission config; look for a different root cause (JS logic, wrong API usage, plugin version, etc.).

**How to apply:** When a native crash looks permission-related, add/adjust the Expo plugin entry in `app.json` (e.g. `expo-image-picker` with `photosPermission`) and stop there. If a rebuild doesn't fix it, treat it as a hint that the permission is already wired and the real bug lives in the JS/TS call site — simplify the call, check the package version's expected API, or remove risky options (e.g. `allowsEditing`, custom `aspect`).
