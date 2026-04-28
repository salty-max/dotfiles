---
name: amend-fixes-to-original
description: When fixing review feedback, amend the fix into the original commit that introduced the issue
type: feedback
---

When fixing issues from code review, amend the fix into the commit that originally introduced the issue rather than creating a new commit.

**Why:** Keeps the git history clean — each commit should be correct, not have a separate "fix" commit for review feedback.

**How to apply:** Use interactive rebase to fixup review fixes into their corresponding original commits.
