---
name: Tracer — motorcycle ride AI app (backend paused 2026-04-22)
description: Backend scaffolded from georide-api-v2 conventions; Max paused it mid-session to pivot to Loom. No GitHub repo, no mobile app yet
type: project
originSessionId: f8f382b4-cf42-449c-a2a5-fa5ff2594301
---
**Tracer** is Max's personal app concept: motorcycle ride itineraries generated via prompt → LLM → routing. Named after the Yamaha Tracer model (partnership planned with a Yamaha concession).

**Status:** paused 2026-04-22, mid-scaffold. Backend skeleton exists locally but nothing pushed to GitHub. No mobile app started. Max pivoted to Loom in the same session and hasn't indicated when he'll resume.

**How to apply (when Max mentions Tracer):**
- Local path: `/Users/max/dev/tracer-api`
- Stack: NestJS 11 + Fastify + Drizzle + Postgres (single pool, not master/replica), Pino, class-validator, Redis + `@nestjs/throttler`, Sentry (feature-flagged, default off). Derived from `georide-api-v2` conventions — see the `reference_georide_claude_md` memory for the source-of-truth patterns to match.
- Design doc: `/Users/max/dev/tracer-api/docs/design.md` — covers the LLM pipeline (Haiku 4.5 default, Sonnet 4.6 escalator when prompt complexity warrants it), Mapbox routing, ride generation flow
- Key decision already locked: **prompt caching on Claude is mandatory from v1** (system prompt ~3k stable tokens → caching brings cost per request from ~$0.014 to ~$0.005 averaged)
- Safety nets wired: exception hierarchy (4 families), rate limiting (IP throttler via Redis), Sentry plugged into global exception filter, husky+commitlint+lint-staged
- Not wired: BetterAuth (planned, deferred), the actual `POST /v1/rides/generate` route, mobile app (Expo RN planned)

**When Max resumes Tracer**, check whether he wants to push to GitHub (decision deferred) and which route to implement first. The `rate-limiting-before-any-paid-API-route` rule from feedback_lean_stacks_with_quality_guards applies strongly here — generation endpoint spends money per call.
