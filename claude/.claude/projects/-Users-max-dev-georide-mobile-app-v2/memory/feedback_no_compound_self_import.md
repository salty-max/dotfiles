---
name: Sub-components must never import from their compound's index
description: Never import from ./index in a sub-component — creates require cycle
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
In a compound component split into multiple files, sub-components must NEVER import the compound entry from `./index`. This creates a require cycle:

```
index.tsx imports selector.tsx (to add Pill.Selector to the compound)
selector.tsx imports Pill from index.tsx → CYCLE
```

**Why:** This warning was on the project since the Pill component was created but never fixed. Require cycles can cause uninitialized values in production. Lead asked to add a rule preventing this.

**How to apply:** When a sub-component needs another sub-component, import it directly via its own file:

```tsx
// Bad — creates cycle
import { Pill } from '@georide/components/ui/pill';
<Pill><Pill.Text>...</Pill.Text></Pill>

// Good — direct sibling imports
import { PillRoot } from './root';
import { PillText } from './text';
<PillRoot><PillText>...</PillText></PillRoot>
```

Apply this whenever creating or refactoring a compound component. The compound `index.tsx` is for external consumers only — internal sub-components talk to each other directly.
