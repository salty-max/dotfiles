---
name: Propose before removing UI content
description: Ambiguous "remove some info" asks should be confirmed before dropping anything — don't unilaterally decide what to cut
type: feedback
originSessionId: e903ca11-fdf5-4bb1-af6b-2327a4821377
---
When the user gives an ambiguous instruction about simplifying or stripping a surface (e.g. "enlève la plupart des informations", "rends ça plus minimal"), propose *which* specific pieces to remove before editing. Don't unilaterally decide — name the candidates and let the user confirm.

**Why:** on the Ma moto tab (front page of a paid-subscription app), I silently dropped the formatted model subtitle (brand + name + year) when asked to "remove most of the bike info". The model is a central identity signal — the user pushed back and made clear that design-tier removals need a short confirmation step first.

**How to apply:** when the request is about reducing surface content and it's not obvious which items are expendable, respond with a one-line plan ("I'd drop X and Y, keep Z — ok?") and wait. Only act unilaterally when the user has *named* the specific item to remove.
