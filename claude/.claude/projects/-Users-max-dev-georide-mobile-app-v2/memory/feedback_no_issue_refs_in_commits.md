---
name: Don't reference issues / PRs in commit messages
description: No "Part of #N", "Closes #N", or similar issue/PR references in commit bodies — keep them in the PR description only
type: feedback
originSessionId: 9c0b6075-18ed-4cca-b830-7c3027858354
---
Never mention GitHub issues or PRs inside commit messages — no `Part of #148`, `Closes #149`, `Fixes #42`, "follow-up to #XX", or any similar reference. The commit message describes the change itself; issue/PR linking belongs in the PR description where GitHub's auto-linker can resolve and maintain it.

**Why:** Max said "les PR dans les commentaires, c'est ridicule" when reviewing three back-to-back commits I tagged `Part of #148/#149/#150`. They pollute the log, don't survive rebases as useful context, and duplicate information the PR description already carries cleanly.

**How to apply:** Write the commit message as if the issue/PR didn't exist — explain the what and the why of the code change in prose, no trailer, no footer, no parenthetical issue number. When a commit introduces a feature tracked by an issue, the PR body is where the `Closes #N` line lives.

This extends `feedback_no_closes_in_commit.md` (which covered `Closes #N` specifically) to every issue/PR reference form.
