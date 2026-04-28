---
name: Extract sub-components before committing
description: Always split large component files into one file per sub-component before committing
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When building a complex sheet/screen, extract all sub-components into their own files before committing. Don't commit a 400-line file with 4 internal components — split them out first.

**Why:** User asked to "nettoyer un peu et extraire les composants dans leur propre fichier" before committing the Live Wheel sheet that had TireHeroCard, AlertRow, TutorialRow all inline.

**How to apply:** After writing a complex component, review the file and extract any sub-component that has its own props/types into a separate file in the same directory. Follow the existing convention: one component per file.
