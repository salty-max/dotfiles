---
name: Liquid Glass for iOS glass effects
description: When user asks for glass effect, they mean iOS 26 Liquid Glass, not expo-blur
type: feedback
---

"Glass effect" means iOS 26 Liquid Glass styling, not blur/expo-blur.

**Why:** The app targets modern iOS with Liquid Glass support.

**How to apply:** Use React Native's Liquid Glass API (available in RN 0.83+) for glass effects on iOS. Provide a solid translucent fallback for Android and older iOS.
