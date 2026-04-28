---
name: No fix/review commits — always amend or fixup
description: Never create standalone fix or review-address commits; amend into the original commit
type: feedback
---

Don't create standalone fix commits or "address review" commits. Always amend or fixup into the original commit that introduced the code.

**Why:** Keeps the git history clean — fixes for something in the same PR should not be separate commits.

**How to apply:** Use `git commit --fixup=<sha>` + autosquash rebase, or `git commit --amend` when fixing the HEAD commit. This applies to both bug fixes and review feedback within the same branch.
