---
name: No useRef in React 19
description: useRef is deprecated in React 19 — use useState with ref callback instead
type: feedback
---

Don't use `useRef` — it's deprecated in React 19. For DOM element refs, use `useState` with a ref callback:

```tsx
const [el, setEl] = useState<TextInput | null>(null);
<TextInput ref={setEl} />
// then: el?.focus()
```

**Why:** React 19 deprecates `useRef`. The project uses React 19 with React Compiler.

**How to apply:** Replace all `useRef` for element refs with `useState` + `ref={setState}`.
