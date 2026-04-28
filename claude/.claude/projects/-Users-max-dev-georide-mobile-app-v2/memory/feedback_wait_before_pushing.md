---
name: Wait for validation before pushing
description: Always wait for explicit user validation of changes before running git push; committing locally is fine but never push without confirmation
type: feedback
originSessionId: 1e279c01-bac8-476c-b4f6-2ecf1dfe9d22
---
Do not push commits automatically — commit locally, then wait for the user to validate the change before running `git push`.

**Why:** User wants to review the diff / behaviour before it lands on the remote. Auto-pushing during iteration cycles removes their veto.

**How to apply:** After `git commit`, stop. Announce what was committed, ask if it's good to push (or wait implicitly for the user to say so). Only run `git push` after explicit "ok push" / "valide" / "envoie" / similar confirmation. This overrides the older `feedback_auto_push_pr` rule — that one applied to completed/approved work on a PR; during active iteration the user is reviewing each step, so hold.
