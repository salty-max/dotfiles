---
name: Use E2E script for builds
description: Always use ./scripts/e2e.sh for E2E test builds, not manual expo commands
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Use `./scripts/e2e.sh <platform>` for E2E test builds, not manual `npx expo run` commands.

**Why:** The script sets the correct env vars (`EXPO_PUBLIC_E2E_MODE=true`, `SENTRY_DISABLE_AUTO_UPLOAD=true`) and flags. User prefers using the established script.

**How to apply:** When building for E2E tests, always use the script. Don't try to replicate the flags manually.
