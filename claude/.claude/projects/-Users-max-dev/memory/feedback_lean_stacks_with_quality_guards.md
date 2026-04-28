---
name: Lean stacks — but never strip quality or security guards
description: When simplifying a stack, cut infra complexity (replica DB, big pagination helpers, unused plugins) but preserve tests, PII redaction, rate limits, Sentry hooks, CI discipline
type: feedback
originSessionId: f8f382b4-cf42-449c-a2a5-fa5ff2594301
---
Max pushes hard for lean stacks but expects quality safeguards to stay.

**Why:** On Tracer scaffold he pushed back twice. When I slimmed Pino redact ("email/otp/accessToken/nested variants") to save ~15 lines, he flagged it as a PII/secret leak risk. When I removed Vitest config thinking "oublie les tests unitaires" meant drop tests, he corrected with "oublie PAS" — he wants tests, he just didn't want me scaffolding them inline at that moment. Rate limiting + Sentry were treated as "deferred safety nets that must land before public traffic", not "nice-to-haves".

**How to apply:**
- Cuts that are OK: master/replica DB when single pool suffices, `@nestjs/terminus` when `/healthz` is 2 lines, complex cursor pagination helper until a real list endpoint needs sort/filter, 5 custom ESLint plugins from a parent repo that don't map to the new project
- Cuts that are NOT OK: Pino redaction paths (keep the full `*.*.email` / `*.otp` / `*.accessToken` nested list), husky hooks if commitlint is configured, rate limiting once any paid-API route exists, Sentry slot in global exception filter
- When uncertain, flag explicitly as "deferred safety net" and document in CLAUDE.md as a pre-production blocker rather than silently omitting
