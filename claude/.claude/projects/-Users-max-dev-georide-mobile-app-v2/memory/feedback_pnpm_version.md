---
name: pnpm-version-in-workflow
description: Prefer specifying pnpm version in CI workflow, not package.json
type: feedback
---

Specify pnpm version in the GitHub Actions workflow config, not in package.json's packageManager field.

**Why:** User prefers keeping pnpm version pinning in CI config rather than package.json.

**How to apply:** When configuring pnpm/action-setup, use the `version` input parameter.
