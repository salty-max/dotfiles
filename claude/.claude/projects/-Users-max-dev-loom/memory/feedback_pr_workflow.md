---
name: PR workflow — one per issue, self-review until LGTM, wait for merge
description: Implementation flow for Loom backlog issues — one PR per issue, self-review with auto-fix until LGTM, wait for merge before next
type: feedback
originSessionId: 1f88c179-a2c0-444f-89ba-7c5aac852a72
---
When implementing a backlog of issues in Loom:

1. **One PR per issue.** Never bundle multiple issues into one branch or PR.
2. **Self-review loop before handing off.** Once the implementation feels done:
   - Run `/review` (or spawn the code-review agent) against the branch.
   - Apply every suggestion, bug, nit the reviewer raises — use `git commit --fixup <sha>` on the original commit, never a standalone "address review" commit.
   - **"Optional" / "nice to have" / "non-blocking" labels from the reviewer are NOT a license to skip.** Rule 4 in CLAUDE.md is binding: every item the reviewer surfaces gets applied (or explicitly pushed back against with a reason). If I genuinely disagree, the push-back goes into the PR body or a reply comment, not into silence.
   - Re-run the reviewer.
   - Repeat until it responds **LGTM** (or equivalent).
   - Only then push / open the PR for the user.
3. **Wait for merge.** After opening the PR, stop. Do not start the next issue until the user merges (or explicitly says "continue" / "stack").

**Why:** The user reviews PRs sequentially, wants each issue to map to exactly one clean merged PR, and expects me to catch my own obvious issues before asking for review time.

**How to apply:** After the self-review loop reaches LGTM → `gh pr create` → report the PR URL → stop. When the user confirms the PR is merged, switch to `main`, `git pull`, delete the local branch, start the next issue fresh from updated `main`.

Also recorded in `CLAUDE.md` under "Issue-to-PR workflow" — keep both in sync if one changes.
