---
name: No builder patterns in DSLs — prefer functional chains
description: For any TS library/DSL, avoid Java-style builder patterns (config object bags, `.with({...})`, `X({...opts...})`). Use chainable methods that return new immutable values, Strudel/Tidal-style
type: feedback
originSessionId: f8f382b4-cf42-449c-a2a5-fa5ff2594301
---
When designing a TS library API, Max rejects builder-object patterns. He expects fluent functional chains.

**Why:** On Loom, I proposed `sfx({ speed, notes: [...] })` / `music({ ch0, ch1 })` / `pattern.with({ instrument, volume })` and he flagged immediately: *"On dirait pas un builder pattern en fait"* — meaning the proposal looked like a builder, which is the opposite of what he wanted. Strudel's `s("bd sd").gain(0.5).fast(2).every(4, rev)` is the reference aesthetic: every value is a Pattern, setters are single-purpose chainable methods that return a new Pattern.

**How to apply:**
- **Good:** `pattern.inst('triangle').vol(5).ch(0).fx('vibrato')`, `stack(a, b, c)`, `cat(verse, chorus).loop({ start: 0, end: 1 })`
- **Bad:** `build({ inst, vol, ch, fx })`, `.with({ attr: value })`, `create(options)` that takes a config bag
- Short aliases (`.inst`, `.vol`, `.fx`, `.ch`) are preferred to long names (`.instrument`, `.volume`) for live-coding ergonomics — but ship both
- Setters should accept primitive **or** Pattern — patternisable values are the Strudel idiom (`.vol(mini('5 3 7 2'))` varies vol per step)
- Composition via combinators (`stack`, `cat`, `seq`) not via constructors with options
- Implementation: prototype augmentation via module declaration is the canonical Strudel approach for attaching domain-specific methods to the generic Pattern
