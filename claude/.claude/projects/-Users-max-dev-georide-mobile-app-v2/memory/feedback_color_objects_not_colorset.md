---
name: feedback_color_objects_not_colorset
description: Theme color type is named Color (not ColorSet/ColorGroup), and Colors stays as-is
type: feedback
---

When structuring theme color variants as objects ({ accent, foreground, background, muted }), the type should be named `Color` — not `ColorSet` or `ColorGroup`. The `Colors` type name stays unchanged.

**Why:** User prefers simple, short names. "colors c'est très bien", "ne nomme pas ça ColorGroup, just Color".
**How to apply:** Use `Color` for the variant object type, keep `Colors` for the map type.
