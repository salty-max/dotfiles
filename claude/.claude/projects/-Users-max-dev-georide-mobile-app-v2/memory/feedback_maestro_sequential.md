---
name: Run Maestro flows sequentially, stop on first failure
description: When rerunning E2E suite, run flows one-by-one and bail on the first failure instead of running the whole folder
type: feedback
originSessionId: 84b8eb1d-30bb-437d-9542-b311b67a3859
---
Don't run `maestro test .maestro/` (entire folder) when iterating on fixes.
Launch each flow individually and stop at the first failure.

**Why:** Running the whole folder masks which flow actually broke first
(dependent flows cascade failures) and makes the feedback loop slow. If the
early flows are failing, fix those first before retrying the rest — no
point waiting for 10 downstream flows to redundantly fail on the same
missing testID or stuck login.

**How to apply:** After a rebuild, invoke `maestro test .maestro/<flow>.yml`
per flow in a stable order (setup → login → each menu) and only continue
to the next flow when the previous one passes. The `./scripts/e2e.sh`
helper runs the full folder — don't use it for iterating; build with
`npx expo run:ios --configuration Release --no-bundler` + `EXPO_PUBLIC_E2E_MODE=true`
and drive maestro manually.
