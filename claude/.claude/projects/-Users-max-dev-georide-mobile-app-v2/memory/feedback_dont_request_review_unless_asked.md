---
name: Don't request Claude reviews unless explicitly asked
description: Wait for existing reviews to complete, never request a new one proactively
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Never request a `@claude review` unless the user explicitly asks. If the user says "wait for the review", they mean wait for an already-requested review to complete — don't fire a new one.

**Why:** The user had already requested a review. Requesting another one creates duplicate review comments and noise on the PR.

**How to apply:** When the user says "wait for the review" or "address the review", check the PR comments first to see if a review is already in progress or completed. Only request a new review when the user explicitly says "ask for a review" or "request a review".
