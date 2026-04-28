---
name: Don't kick off rebuilds proactively
description: Wait for the user to ask before running ./scripts/e2e.sh / expo run:ios; iterate on code first
type: feedback
originSessionId: 738b7734-eca4-419d-8294-5c7bac619b3b
---
Don't kick off iOS rebuilds (`./scripts/e2e.sh`, `expo run:ios --configuration Release`, etc.) on my own after every code change. The user will explicitly say when to rebuild.

**Why:** A release build burns 3–5 minutes and a chunk of disk on every cycle. The user often wants to iterate further on the code (or other branches) before paying for a verify pass. Pre-emptively rebuilding wastes their time and clutters the task list with cancellable jobs.

**How to apply:** After making code changes, run `pnpm typecheck` / `pnpm lint` / `pnpm check:i18n` / `pnpm knip:check` to get fast feedback, but don't trigger a native build until the user says "build" / "tu peux build" / "rebuild" / similar. Same goes for re-running Maestro flows after a code change — those need a fresh build, so they wait for the same trigger.
