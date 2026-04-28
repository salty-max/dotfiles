---
name: Rebuild iOS only when native code changed
description: Don't run pnpm expo run:ios for JS-only changes; Metro Fast Refresh handles it
type: feedback
originSessionId: 3edf1477-2e58-4727-8776-2d7a024c6672
---
Don't rebuild the iOS app (`pnpm expo run:ios` or `./scripts/e2e.sh`) after every JS/TS change — Metro Fast Refresh picks up JS edits without a full native build.

**Why:** Release builds take several minutes; rebuilding after every edit wastes the user's time and battery. The user gets visibly annoyed when I chain rebuilds for JS-only tweaks.

**How to apply:** Rebuild only when one of these changes:
- Native code (`ios/`, `android/`, native module versions in `package.json`)
- `app.json` / `app.config.*` plugin config that affects native
- Native-touching deps added/removed (expo-camera, expo-glass-effect, etc.)
- After `pnpm expo prebuild`

For pure JS/TS/asset/locale changes, tell the user the edit is done and let them reload via Metro (R in the dev client or shake → reload). If running Release mode for E2E, mention the code is ready and wait for them to rebuild when they decide it's worth it.
