---
name: Remove all debug code before committing
description: Always scan diff for console.log, debug flags, and temp code before staging
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Before staging files for a commit, review the diff for leftover debug code: `console.log`, `console.error` debug lines, temporary variables, commented-out code.

**Why:** A `console.log('session', session)` was nearly committed in session.ts. Debug code in production degrades performance and leaks internal state to the console.

**How to apply:** After finishing a task, run `git diff` and search for `console.log`, `console.error`, `// TODO: remove`, `debugger` before staging. If debug logging was added during investigation, revert those lines before committing the actual fix.
