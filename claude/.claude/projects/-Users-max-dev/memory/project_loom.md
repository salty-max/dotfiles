---
name: Loom — pattern-algebra DSL for chiptune music
description: Public lib for PICO-8-scoped algorithmic music. Scaffolded 2026-04-22; implementation not started, tracked via 30 GitHub issues
type: project
originSessionId: f8f382b4-cf42-449c-a2a5-fa5ff2594301
---
**Loom** is Max's personal library project: a TypeScript pattern-algebra DSL inspired by TidalCycles/Strudel but deliberately scoped to the PICO-8 tracker model (4 channels, 32 steps, 8 waveforms, 8 effects, pitch 0-63, volume 0-7). Target users: live coders and chiptune makers.

**Why scope to PICO-8:** shippable in months (vs 3+ years for full Strudel clone), constraint crystallizes identity (instantly recognizable 8-bit aesthetic).

**How to apply:**
- Local path: `/Users/max/dev/loom`
- Public GitHub: `salty-max/loom` (personal account, not georide work)
- GitHub Project: https://github.com/users/salty-max/projects/2
- Stack: Bun 1.3+ (runtime + pm) + TS strict NodeNext + Vitest + ESLint (typescript-eslint/prettier/unicorn/simple-import-sort) + Husky + lint-staged + commitlint + knip + GitHub Actions CI
- Path aliases: `@loom/*` → `src/*`; imports use `.js` extensions canonically (NodeNext rule)
- Layering: `core → pico8 → adapters → runtime → cli` (never reversed)

**Scope snapshot** (authoritative in `docs/design.md`):
- v0 (17 issues): core pattern algebra + PICO-8 types + print adapter + CLI events
- v0.1 (12 issues): live coding (hot-swap controller, web-audio adapter, `loom serve` with Cmd+Enter), mini-notation expansion (groups `[x y]`, alternation `<x y>`, modifiers `*n /n @n`), export (`.wav`, `.mid`, stems, URL share `#s=…`)
- v1 (3 issues): MIDI live adapter, REPL terminal, euclidean `x(k, n)` rhythms

**API convention:** Strudel-style chains, NOT builder patterns. `mini('c3 e3').inst('triangle').vol(5).ch(0).fx('vibrato')` — see the `feedback_no_builder_patterns_in_dsls` memory.

**Hard constraints** (locked in design doc §4): no FM, no samples, no filters, no reverb/delay, no polyrhythms inside an SFX, no polymetric patterns, mono per channel, no stereo pan, no variable tempo within a song, no MIDI-sync-in. These are intentional scope limits — changing them requires amending the design doc, not just adding an issue.
