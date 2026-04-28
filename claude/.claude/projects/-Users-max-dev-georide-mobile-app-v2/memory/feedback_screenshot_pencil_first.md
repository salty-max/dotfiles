---
name: screenshot_pencil_first
description: Always fetch Pencil screenshots (not just text specs) before implementing or reviewing UI
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When implementing UI from the Pencil design, call `mcp__pencil__get_screenshot` on every relevant frame *before* writing code. Text-only descriptions from `batch_get` or subagent summaries miss critical visual details — card order (value-on-top vs label-on-top), banner colors (destructive red vs warning yellow vs info blue), button variants (primary vs secondary), layout direction (stacked vs side-by-side), and icon choices.

**Why:** On the battery feature I shipped a menu sheet that visibly diverged from Pencil — wrong stat-card order, wrong banner variants, wrong CTA color, wrong icon for the "sans batterie" mode, wrong activated-step ordering. The user was very angry because I had claimed the work matched the spec, but I had only read the text summary, not looked at the actual frames. Several iterations of "fix the visual gap" were needed to catch up.

**How to apply:** Before writing or reviewing any visual implementation against a Pencil design, always open the actual screenshot with `mcp__pencil__get_screenshot` per frame. Compare side-by-side against my implementation plan. Only then code. When the user says "iso Pencil", treat it as literal — every visible element (layout, color, iconography, order, typography scale) must match.
