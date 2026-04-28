---
name: No fixup spam on PRs
description: Squash fixups locally before pushing, or batch changes — don't push individual fixup commits to PRs
type: feedback
---

Don't push individual `fixup!` commits to PR branches one by one. The PR activity becomes unreadable with dozens of fixup entries.

**Why:** GitHub keeps the full push history in PR activity. Even after autosquash rebase, the old fixup commits remain visible, making the PR look messy.

**How to apply:** Batch style fixes and iterations locally. Only push when a logical chunk is complete. If fixups are needed, squash them locally before pushing.
