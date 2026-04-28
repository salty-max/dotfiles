---
name: Don't override Button borderRadius
description: Use the Button component's built-in radius — every button in the app shares the same shape
type: feedback
originSessionId: 738b7734-eca4-419d-8294-5c7bac619b3b
---
Don't apply `style={{ borderRadius: ... }}` overrides to the `<Button>` component to match a Pencil corner radius value.

**Why:** The shared Button has a single `radius.lg` baked into its variants so every button in the app reads the same. Overriding it per call site fragments the design system: a "fully pill" Add CTA in one feature and a slightly-less-rounded Save CTA in another suggest two distinct primitives where Pencil only has one. If a different shape is genuinely needed, extend the Button component (new variant or new size), not the call site.

**How to apply:** When the Pencil corner radius for a button doesn't match `radius.lg`, accept the slight delta (a couple of pixels never matters at the consumer level) rather than threading a custom `style.borderRadius` prop. Same goes for height, background, and border colour — those live inside the Button variants. If you find yourself repeatedly overriding the same property to satisfy Pencil, propose a new variant or size on the Button instead.
