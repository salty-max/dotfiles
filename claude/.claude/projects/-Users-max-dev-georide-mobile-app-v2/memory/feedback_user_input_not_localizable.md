---
name: User-entered data is not localizable
description: Names of people, places, vehicles, and other user-typed strings stay in whatever language the user wrote them. Don't route them through i18n.
type: feedback
originSessionId: d1098e84-8e91-4c2f-bc3d-df3fd3a327cf
---
User-entered data — names of loved ones, places, vehicles, OTP messages typed by the rider, custom labels — stays in the language the user typed it. Don't pipe it through `t()` or split it into i18n keys, even when the source happens to be French.

**Why:** When a rider types "Maison" or "Marie" into a form, that's their input — not an app-defined string. Translating it would mean turning the rider's "Maison" into "Home" the next time they switch language, which is wrong: it's their data, not the app's. The "no French in code" rule (see `feedback_no_french_in_code.md`) targets **identifiers and code-defined strings**, not user input that happens to be stored as a string.

**How to apply:**

- Mock seed data that simulates user input (proche names, zone labels, vehicle nicknames) can ship in any natural language — French is fine if it matches the Pencil illustrative spec. The store is the mock backend; once the real API ships it returns whatever the rider typed.
- Don't add `t()` resolution layers, `*_KEY` maps, or `seed.<id>.label` locale entries to "fix" French-looking seed data. That's overengineering.
- The "no French" rule applies to: variable names, file names, type names, hook names, selector names, testIDs, and code-defined UI copy (button labels, error messages, headings) — not to data fields the user owns.
- If you're unsure whether a string is user-entered or app-defined: ask "could the rider edit this in a form?" If yes → user input → don't localize. If no → app copy → goes through i18n.

This came up after I escalated the reviewer's nit about French zone seeds (`Maison` / `Travail` / `Salle de sport`) into a full localization layer. The reviewer had explicitly flagged it as non-blocking *because* it's mock-shaped user input.
