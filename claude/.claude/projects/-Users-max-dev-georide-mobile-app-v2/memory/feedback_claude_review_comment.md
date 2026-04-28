---
name: Claude review via comment
description: Request Claude reviews by posting @claude comment on PR with change summary
type: feedback
---

When asked to request a Claude review on a PR, post a `@claude review` comment on the PR via `gh api`. Always include a summary of what changed since the last review.

**Why:** User wants reviews triggered via GitHub PR comments, which is how their Claude bot is configured. The summary helps Claude focus on what's new.

**How to apply:** After pushing, use `gh api` to post a comment with `@claude review` followed by a description of changes since the previous review.
