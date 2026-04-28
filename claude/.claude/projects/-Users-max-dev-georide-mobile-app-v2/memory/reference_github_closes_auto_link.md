---
name: GitHub "Closes #N" auto-link requires a blank line separator
description: PR closing references only register when each Closes/Fixes keyword sits on its own paragraph, not just its own line
type: reference
originSessionId: e903ca11-fdf5-4bb1-af6b-2327a4821377
---
GitHub's closing-reference auto-linker (what populates `closingIssuesReferences` and the "Linked issues" panel) is paragraph-aware, not line-aware. It will silently skip a `Closes #N` keyword if the very next line is another non-blank line.

**Pattern that FAILS to auto-link** (seen on this repo's PR #138 originally):
```
Closes #137
Stacked on #136
```

**Pattern that links**:
```
Closes #137

Stacked on #136
```

**Multi-issue pattern that links**:
```
Closes #143

Closes #145
```

**How to fix a missed link**: edit the PR body to insert a blank line after the `Closes` keyword, resubmit with `gh pr edit <num> --body-file <file>`, then verify via the GraphQL query `pullRequest(number: N) { closingIssuesReferences(first: 10) { nodes { number } } }`. Re-saving the same body does NOT retrigger parsing on its own — the body has to actually change.
