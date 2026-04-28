---
name: Fixup commits only for review feedback, never for new work
description: `git commit --fixup=<hash>` is reserved for addressing review comments; direct user requests get regular conventional commits
type: feedback
originSessionId: e903ca11-fdf5-4bb1-af6b-2327a4821377
---
CLAUDE.md rule: "When addressing review feedback, always `fixup!` into the original commit that introduced the code — never create standalone 'fix review' or 'address feedback' commits."

**Scope of the rule:** review feedback only. Reviews from `@claude`, a human reviewer, or a self-review pass count. Nothing else.

**Direct user instructions are NOT review feedback.** Even when they touch a file that's already covered by an existing commit on the branch (e.g. "regenerate orval", "remove the share button"), these are new asks that get fresh conventional commits. Reviewers reading the PR diff need to see those changes as their own commits on top of the history — not folded silently back into earlier commits.

**Why it matters:**
- Fixup commits on already-pushed branches are only resolvable via force-push, which rewrites history the reviewers have been seeing. That wipes their in-flight comments and breaks the "since last review" context.
- Users who aren't asking for a review fix don't expect their diff to disappear into a force-pushed squash. They expect a new commit they can see and revert if it's wrong.

**How to apply:**
- Review comment asks for a change? → `git commit --fixup=<original>` then squash locally before push (per `feedback_no_fixup_spam.md`).
- User asks for a change directly, or I'm iterating on my own work mid-PR? → regular `git commit` with a conventional message that states what changed and why. No fixup.

**The incident that prompted this memory:** I regenerated orval and removed a pair of disabled share buttons at the user's direct request, then packaged both as `fixup!` commits targeting already-pushed commits on an open PR. The user pushed back hard — correctly — because those changes were new asks, not review feedback.
