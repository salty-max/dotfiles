---
name: Hydration must be first + try/catch around external calls + 3s timeout fallback
description: Strict rules for store hydration to avoid race conditions and silent failures
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When persisting Zustand stores with `persist` middleware:

1. **Hydration must be set first** in `onRehydrateStorage` — before any other side effect.
2. **All other work in try/catch** — if you do external calls (i18next, Sentry, etc.) during hydration, wrap them in try/catch and report failures to Sentry.
3. **Always have a 3s timeout fallback** in the root layout that hides the splash screen even if stores haven't hydrated.
4. **Never call cross-cutting side effects** (like `changeLanguage`) from inside a store's hydration callback — this causes race conditions if the side effect's module isn't ready yet.

**Why:** A user got stuck on the splash screen because `initI18n()` ran after the preferences store import, so `changeLanguage()` in `onRehydrateStorage` threw silently and the store never marked itself as hydrated. The error wasn't caught by Sentry because the store hydration error wasn't wrapped in try/catch. Lead said "faut être mega hyper vigilant sur ça."

**How to apply:**
- In every persisted store's `onRehydrateStorage`: call `setHasHydrated(true)` FIRST, then run any optional side effects in try/catch with Sentry reporting.
- In the root layout: add a `setTimeout` of 3s that forcibly hides the splash screen if `isAppHydrated` is still false.
- Avoid calling i18n functions, navigation, or other cross-feature side effects from store hydration. Move them to a layout effect that runs after hydration.
- The structural fix for i18n: ensure `initI18n()` is called before any module that imports a persisted store. In practice, import order in the root layout matters.
