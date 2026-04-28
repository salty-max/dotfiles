---
name: Fold follow-up work into the current PR when the subject matches
description: Don't spawn separate issues for cleanup that logically belongs to the change you're making right now — fold it into the current PR or current issue
type: feedback
originSessionId: 1f88c179-a2c0-444f-89ba-7c5aac852a72
---
When a code review surfaces a "follow-up" (e.g. "extract this to a composite action", "add a gitignore entry", "add a cache step"), do NOT reflexively file a separate GitHub issue.

**Default:** if the follow-up concerns the same file, same PR subject, or same module you're already touching, fold it into the current PR. File a separate issue only when:
- The follow-up is meaningfully out of scope (different module, different concern, requires deeper design)
- The follow-up needs discussion before implementing
- The current PR is already large and bundling would slow review

**Why:** Filing issues for work that could be done *now, in the same diff* creates churn — the issue gets closed minutes later by a new PR that touches the same file. The user prefers one coherent PR over a split of PR + trivial follow-up PR.

**How to apply:** After a reviewer says "X can be a follow-up" or "consider Y later", pause and ask yourself: is X in the same file / same workflow / same config as what I'm changing? If yes, just do X in this PR. Update the commit/PR body to reflect the broader scope. Only file a separate issue if X genuinely doesn't fit.

Concrete example from the CI-split PR (#36): the reviewer suggested extracting the repeated `checkout + setup-bun + cache + install` scaffolding to a composite action. I filed it as #35. The user corrected: it touches `.github/workflows/ci.yml` in the same way, same PR subject → should have been in PR #36 directly, not a separate issue.
