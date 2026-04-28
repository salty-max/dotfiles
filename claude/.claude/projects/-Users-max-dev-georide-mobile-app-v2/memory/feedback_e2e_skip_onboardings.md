---
name: E2E flows skip every onboarding
description: All onboardings (main + feature) must be pre-marked complete in e2e-setup; flows must not walk users through onboarding to reach a feature
type: feedback
originSessionId: 738b7734-eca4-419d-8294-5c7bac619b3b
---
For Maestro / E2E flows, **every** onboarding (main first-launch + feature-specific: SOS, theft, alerts, battery, etc.) must be pre-marked complete in `src/features/tests/e2e-setup.ts` via `useOnboardStore.markComplete(<id>)`. The flow under test should land directly on the home/feature surface.

Onboardings themselves are tested in their own dedicated Maestro flows that **deep-link** into `/onboard/[id]` — they are never reached by walking through the app.

**Why:** When a new onboarding gates the app (e.g. the `force logout at launch when onboarding incomplete` redirect), forgetting to mark it complete in e2e-setup silently breaks every other Maestro flow because the rider gets stuck on the intro screens. Maestro then fails on `login-email-input` even though the test, the testID, and the login screen are all correct.

**How to apply:** When you add a new onboarding flow that's gated at app launch (or any path the e2e flows traverse), add `store.markComplete('<onboarding-id>')` to the e2e-setup block in the same PR. The exception is the onboarding's own dedicated Maestro flow, which deep-links and tests it in isolation.
