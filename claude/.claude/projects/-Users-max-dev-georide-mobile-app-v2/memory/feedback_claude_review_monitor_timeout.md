---
name: Claude review Monitor timeout ≈ 4 minutes
description: Use ~240000ms when watching for a @claude review comment, not the Monitor tool max
type: feedback
originSessionId: 738b7734-eca4-419d-8294-5c7bac619b3b
---
When arming a Monitor to watch for a `@claude review` reply on a PR, set `timeout_ms` to **~240000ms (4 minutes)**, not the tool's 3,600,000ms ceiling.

**Why:** Observed latencies on this repo's `@claude review` round-trips are ~1–2 minutes (1m21s and 2m07s on PR #185). Using the Monitor max keeps an idle watcher armed for an hour after the comment lands, which the user explicitly flagged as wasteful. 4 minutes covers ~2× the observed P99 with comfortable margin.

**How to apply:** Default to `timeout_ms: 240000` for `@claude review` watchers. If the review legitimately takes longer (huge PR, queue delay), re-arm rather than pre-budgeting an hour. Don't reach for the tool ceiling just because it's available — match the timeout to the realistic latency.
