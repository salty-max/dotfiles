---
name: Always match Pencil design exactly
description: Don't approximate or simplify when implementing from Pencil — extract exact specs and reproduce them faithfully
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When implementing a screen from the Pencil design, always extract the exact specs first (via batch_get or subagent) and reproduce them faithfully. Don't approximate or simplify the layout — the user expects pixel-accurate implementation.

**Why:** User called out a "lazy" Live Wheel sheet implementation that didn't match the Pencil design closely enough. The implementation used rough approximations instead of extracting and following the exact Pencil specs.

**How to apply:** Before writing any UI code for a new screen, always use a subagent to extract the full Pencil specs (layout, padding, gap, colors, font sizes, font weights, border radii, all children) from the target frame. Then implement from those exact values — don't wing it.
