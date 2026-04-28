---
name: No stub handlers or placeholder data
description: Wire all interactive elements with real functionality, don't leave onPress no-ops
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Never leave `onPress={() => {}}` stubs or hardcoded placeholder data when the editing flow already exists elsewhere. If there's an "Edit" button, wire it with actual inline editing or navigation.

**Why:** The SOS moto and personal info sections were left with static text and no-op edit links. The user expected the same editing experience as the profile — PhoneField with country picker, OTP verification, animated save/cancel.

**How to apply:** When a section has an edit action, implement the full editing flow. If the same pattern exists in another feature (e.g. profile InfoSection), extract shared components and reuse them rather than leaving stubs.
