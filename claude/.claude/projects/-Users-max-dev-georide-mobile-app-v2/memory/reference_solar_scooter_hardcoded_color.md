---
name: react-native-solar-icons glyphs that hardcode #1C274C
description: Confirmed navy-hardcoded solar icons (Scooter bold + linear, SpedometerMiddle linear) — swap for clean alternatives; grep #1C274C before trusting any new icon
type: reference
originSessionId: 9c0b6075-18ed-4cca-b830-7c3027858354
---
Several `react-native-solar-icons` glyphs bake `#1C274C` into their SVG path / stroke and ignore the `color` / `primaryColor` prop entirely, so they always render navy regardless of what you pass — both in light and in dark mode.

**Confirmed offenders (audited 2026-04-21):**

| Icon | Variant | Swap |
| --- | --- | --- |
| `Scooter` | bold, linear | `BicyclingRound` |
| `SpedometerMiddle` | linear | `Ruler` (for odometer/km) — no clean speedometer alternative in the pack |
| `SpedometerLow` / `SpedometerMax` | linear | same — no clean speedometer variant |

**Symptom:** a row in a checklist / feature card / input icon renders dark navy while siblings render orange — the colored ones are using other glyphs (User, CheckCircle, Phone, Tag…) that correctly wire `color` through. Shows up most obviously in dark mode where the navy tile sits on a black background.

**How to audit a new icon before using it:**

```bash
grep -c "#1C274C" node_modules/react-native-solar-icons/dist/generated/<variant>/<IconName>.esm.js
```

A count of `0` is safe. `1+` means the fill/stroke is baked in — pick a different glyph.

**Where this bites:** any surface that tints solar icons (`color={theme.colors.primary.accent}` / `mutedForeground`). Also any focus-state icon wiring in TextInput — the hardcoded-color icon won't flip from muted to accent on focus.
