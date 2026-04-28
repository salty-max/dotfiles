---
name: Never silently swallow errors — Sentry always, toast for user-facing
description: Every catch must report to Sentry with source tag; show toast only for user-facing failures
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
Every `try/catch` and `.catch()` block must report unexpected errors to Sentry with a `source` tag for filtering.

**Toast rule:** if the error affects something the user is actively doing (mutation, action handler, anything triggered by a tap), ALSO show `toast.error(t('common.error.generic'))`. Background errors (cache writes, telemetry, hydration side effects) only need Sentry — no toast.

**Why:** Lead emphasized: "faut être mega hyper vigilant sur ça" — silent errors leave us blind in production. The toast rule comes from a follow-up: "si l'erreur mérite d'être donnée à l'utilisateur, on toast."

**How to apply:**
```ts
try {
  await someMutation();
} catch (err) {
  if (err instanceof SheetDismissedError) return; // expected, ignore
  Sentry.captureException(err, { tags: { source: 'feature.action' } });
  toast.error(t('common.error.generic')); // user is waiting → toast
}
```

Acceptable silent catches (no Sentry, no toast):
- Pure formatting fallbacks (e.g. `formatPhone` returning raw input on parse failure)
- Animation race conditions during component unmount with explicit fallback recovery

If unsure → report to Sentry. Filtering noise is easier than discovering silent failures in production.
