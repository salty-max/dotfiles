---
name: Use existing Section component
description: When restructuring sheet/screen layouts, reach for the shared `<Section>` compound — never roll a bespoke `styles.section` View
type: feedback
originSessionId: d1098e84-8e91-4c2f-bc3d-df3fd3a327cf
---
When a sheet or screen layout needs to be grouped into discrete blocks, use the shared `<Section>` compound from `@georide/components/ui/section` (with `Section.Title`, `Section.Header`, `Section.Link`). Pair it with `<Separator />` from `@georide/components/ui/separator` for between-section dividers — the same way the share detail sheet, badge detail sheet, and live detect sheet do.

**Why:** I rolled a bespoke `styles.section` View and `styles.mapSection` View on the zone editor and the user reacted hard ("PUTAIN OIN. A UN COMPOSANT SECTION ABRUTI") — the project already ships a `Section` compound that's used in every other sheet. Building local equivalents fragments the design language.

**How to apply:** Before adding `paddingHorizontal/paddingVertical` View wrappers around a block, grep for `Section` / `Separator` usage in similar surfaces. Use `Section` for the logical group, optionally with `Section.Title` for a heading, and let the outer container provide outer padding (`padding: gap(2.5), gap: gap(2)` on the body works well). Reach for `<Separator />` between sections rather than relying on the gap alone.
