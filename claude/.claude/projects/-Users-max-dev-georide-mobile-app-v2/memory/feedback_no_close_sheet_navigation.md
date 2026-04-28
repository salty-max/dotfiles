---
name: feedback_no_close_sheet_navigation
description: When navigating from a sheet to a screen, dismiss the sheet first then push — but don't overcomplicate it
type: feedback
---

On iOS, formSheets have their own navigation context. To navigate to a full screen from inside a sheet, use `router.dismiss()` then `router.push()` — not `dismissAll` with timeouts. Keep it simple. The user doesn't want unnecessary sheet closing when it's not needed.

**Why:** Overcomplicating sheet-to-screen navigation caused bugs (onboard opening in sheets, timing issues).
**How to apply:** Use `router.dismiss(); router.push('/path')` when navigating from a sheet to a screen. Don't close sheets preemptively when just opening another sheet.
