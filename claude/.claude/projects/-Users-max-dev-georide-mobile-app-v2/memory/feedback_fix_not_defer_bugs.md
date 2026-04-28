---
name: Fix bugs immediately, don't defer
description: When a bug is discovered mid-task, fix it now — don't ship broken UX with a TODO or remove the failing test
type: feedback
originSessionId: 11f6b5e2-34f5-4d46-8a5e-c6e29b25a968
---
When a test or interaction reveals a real UX bug (e.g. keyboard covering a submit button, broken inline editing), fix the bug. Don't:

- Delete the test that exposes it
- Note "we'll fix it later"
- Say it's "out of scope"

**Why:** user considers deferring a visible bug the same as shipping it broken — the test was useful precisely because it surfaced real breakage. Removing the test hides the problem instead of solving it.

**How to apply:** when a Maestro flow fails because of a UI layout issue (button below keyboard, non-interactive element, missing KeyboardAvoidingView, etc.) or a functional bug the test caught, update the actual component code to fix the issue, then re-enable the test. Only skip a test when the underlying thing genuinely isn't broken (e.g. Maestro tooling limitation that doesn't affect real users).
