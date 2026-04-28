---
name: georide CLAUDE.md files — gold reference for TS backend/mobile conventions
description: Two large CLAUDE.md files in the georide repos are the source of truth for patterns Max applies to personal TS projects (Tracer, Loom)
type: reference
originSessionId: f8f382b4-cf42-449c-a2a5-fa5ff2594301
---
Max's professional georide projects have extensively-documented `CLAUDE.md` files that encode conventions he applies to personal projects too. Read them for any TS pattern question.

**How to apply:**

- `/Users/max/dev/georide-api-v2/CLAUDE.md` — NestJS + Drizzle + BetterAuth backend. Reference for:
  - 4-family exception hierarchy (`DomainException`, `ValidationException`, `AuthException`, `InfrastructureException`) with global filter routing logging + Sentry by family
  - `runInTransaction` via `AsyncLocalStorage` (one transaction per outermost call, nested calls transparently join)
  - TypeID on wire, bare UUID v7 in code; `@TypeId(table)` decorator via class-transformer
  - Cursor pagination (`CursorPaginationQuery`, `CursorPage<T>`, `paginateWithCursor` with sort/filter whitelist)
  - Per-module ownership (each module owns its config, exceptions, DTOs, tests)
  - Commit scope-enum with structured prefixes (`features/<name>`, `components/<name>`, `lib/<name>`)
  - Feature flags over `NODE_ENV` for security toggles
  - Boolean env-var transform pattern (read from `obj[key]` not `value`)

- `/Users/max/dev/georide-mobile-app-v2/CLAUDE.md` — Expo RN + React 19 + Unistyles v3 + Zustand + SWR + Expo Router. Reference for:
  - React Compiler enabled — no `useMemo`/`useCallback`/`React.memo`
  - Compound component pattern with `Object.assign`, split across files (`root.tsx`, `sub1.tsx`, …)
  - Store hydration safety rules (`setHasHydrated(true)` FIRST in try/catch, no side effects in `onRehydrateStorage`, 3s root-layout fallback)
  - Error reporting: every catch reports to Sentry with `source` tag; user-affecting errors also show a toast
  - Co-located compound component structure (never import sibling via compound entry point — use full path to avoid require cycles)
  - Pencil-first UI workflow (design spec is canonical, inspect with MCP before coding)

When scaffolding a new TS project or making an architectural decision in any personal repo, consult these two files before improvising. The conventions are battle-tested.
