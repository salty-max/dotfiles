---
name: Sheets must always be scrollable
description: Always wrap full-height sheet content in SheetScrollView to prevent clipped content
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Always wrap sheet content in `SheetScrollView` when the sheet uses `detents: [1]` or has more than a few rows. Never assume content fits in the viewport.

**Why:** The SOS sheet was delivered without scrolling, making the save buttons unreachable on smaller devices. The user couldn't interact with the bottom sections.

**How to apply:** When building or modifying a sheet component, check if the content could overflow. If yes, use `SheetScrollView` (which already handles safe area bottom padding globally). Don't add manual paddingBottom — SheetScrollView handles it.
