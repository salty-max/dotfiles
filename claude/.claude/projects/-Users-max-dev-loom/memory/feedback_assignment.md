---
name: Always assign PRs and issues to the user (salty-max)
description: Every PR I open and every issue I file in the Loom repo must be assigned to salty-max from the start
type: feedback
originSessionId: 1f88c179-a2c0-444f-89ba-7c5aac852a72
---
**Rule:** when opening a PR or filing an issue in the Loom repo on GitHub, always assign it to the user `salty-max`.

**Why:** The user tracks active work via the "assigned to me" filter on GitHub. If I skip the assignee, the PR/issue doesn't show up on their dashboard and they have to hunt for it. Explicit instruction from the user — not optional.

**How to apply:**

- **PRs:** pass `--assignee @me` (or `--assignee salty-max`) to `gh pr create`:
  ```
  gh pr create --title "…" --base main --assignee @me --body "…"
  ```
- **Issues:** pass `--assignee @me` to `gh issue create`:
  ```
  gh issue create --title "…" --label "…" --assignee @me --body "…"
  ```
- **Retroactive:** for an already-open PR or issue without assignee, use `gh pr edit <n> --add-assignee @me` or `gh issue edit <n> --add-assignee @me`.
- `@me` works because `gh` is authenticated as `salty-max`. Verify with `gh api user --jq .login` if there's ever doubt.

Applies to every `gh pr create` / `gh issue create` invocation in this project. Don't ask, don't forget, don't defer — it's the default.
