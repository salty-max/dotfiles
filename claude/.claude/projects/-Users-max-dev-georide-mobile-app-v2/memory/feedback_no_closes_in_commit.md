---
name: No Closes in commit messages
description: Put Closes #N in the PR description only, not in commit messages
type: feedback
---

Don't put `Closes #N` in commit messages. The PR description handles issue linking.

**Why:** The user considers it noise in the commit message — the PR description is the right place for it.

**How to apply:** When creating commits, omit `Closes #N` trailers. Add them to the PR body instead.
