---
name: branch-from-main
description: Feature branches for PRs should be based on main, not on WIP branches
type: feedback
---

Feature branches intended for PRs should only contain commits relevant to the issue. Don't base them on WIP branches — rebase onto main so no unrelated content gets pushed.

**Why:** WIP branches contain dummy/temporary content that should not land on main.

**How to apply:** When creating a branch for a PR, always rebase onto origin/main before pushing, even if the work was originally done on a WIP branch.
