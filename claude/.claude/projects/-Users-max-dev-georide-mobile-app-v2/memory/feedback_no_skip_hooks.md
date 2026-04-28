---
name: Never skip git hooks
description: Always run lint-staged/commitlint hooks on commit, fix lint issues before committing
type: feedback
---

Never use `--no-verify` on git commits. Always let hooks run (lint-staged, commitlint). Fix lint/format issues before committing instead of bypassing.

**Why:** Skipping hooks lets broken lint slip through, which then fails in CI or creates noise in diffs.

**How to apply:** Run `eslint --fix` and `prettier --write` on changed files before committing if needed. Let husky hooks validate every commit.
