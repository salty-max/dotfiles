---
name: Diff before blaming a commit for a regression
description: When the user reports a regression after recent commits, run `git show <commit>` to confirm what each commit actually changed before reverting.
type: feedback
originSessionId: d1098e84-8e91-4c2f-bc3d-df3fd3a327cf
---
When the user says "it broke after X", read `git show <commit-of-X>` before assuming X caused it. The user named the most-recent visible change ("c'était niquel avant que tu rajoute le separator") but the actual regression came from later structural commits I'd queued behind it (collapsing the body wrapper, switching `mapWrap` to `flex: 1`).

**Why:** I trusted the user's framing and reverted the harmless commit (`c4a936b`, just an `<Separator />` add) when the real damage was in `8e433f4` / `5318a9b`. The user pushed back ("je vois pas en quoi le separator peterait tout") and was right.

**How to apply:** Before reverting on a regression report, run `git show <commit>` on the commit the user named. If the diff is mechanically harmless (an import + a sibling element), look further down the commit graph for the structural change that actually broke things. Then call it out before applying the revert ("you're right, X is harmless — Y is the real one"). Don't take blame attributions at face value.
