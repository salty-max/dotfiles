---
name: Use curl for downloading files
description: User prefers curl for downloading files directly rather than cloning entire repos
type: feedback
---

When downloading individual files from GitHub repos, use `curl` to download just the needed file(s) directly rather than cloning the whole repository.

**Why:** More efficient — no need to download an entire repo when only one or two files are needed.

**How to apply:** Use `curl -sL <raw-github-url> -o <destination>` for fetching individual theme/config files from GitHub.
