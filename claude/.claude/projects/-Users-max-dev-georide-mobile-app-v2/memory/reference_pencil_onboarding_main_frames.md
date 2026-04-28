---
name: Pencil node IDs for "── Onboarding Principal ──"
description: Direct node IDs for each of the 15 screens in the main onboarding Pencil frame so I can screenshot without re-selecting
type: reference
originSessionId: e903ca11-fdf5-4bb1-af6b-2327a4821377
---
Source file: `/Users/max/Desktop/georide-pencil/15-04.pen`
Parent frame: `2BSQh` — `── Onboarding Principal ──`

Individual screens (ordered by onboarding step):

| Step | Name                         | Pencil ID |
|------|------------------------------|-----------|
| 00   | Présentation Immersive       | `s0xu6`   |
| 00b  | Présentation Stats           | `jzPTJ`   |
| 01   | Login Email                  | `9EUHi`   |
| 02   | Login OTP                    | `SO3ui`   |
| 03   | Prénom                       | `qeEj6`   |
| 04   | Choix Moto                   | `t79DR`   |
| 05v  | Ma Moto — Infos (gris)       | `VotX1`   |
| 05c  | Ma Moto — Photo              | `qp86L`   |
| 06   | Contexte Infos Profil        | `JNSXE`   |
| 07a  | Naissance                    | `8h88r`   |
| 07b  | Téléphone                    | `oFA06`   |
| 08   | Profil OK                    | `c0dUI`   |
| 09   | Choix GeoRide                | `GSYp2`   |
| 10   | Scanner QR                   | `iBhmp`   |
| 12   | GeoRide Activé               | `NjzUI`   |

Note: step 11 doesn't exist in the Pencil spec — the flow skips from 10 (QR scanner) to 12 (activation success).

**Why cached:** The Pencil MCP times out on `batch_get` / `snapshot_layout` against the whole `2BSQh` frame (too dense). `get_screenshot` with a specific leaf `nodeId` works fine. Using these IDs lets me re-fetch any screen's screenshot without asking the user to multi-select again.

**How to use:** call `mcp__pencil__get_screenshot { nodeId: "..." }` with the ID from the table. Re-select in Pencil only if the ID no longer resolves (frames deleted or renamed).

## Exported hero images (via `export_nodes`)

Each onboarding hero photo is a distinct frame — the intro and login share the motorcyclist/mountain vibe but are different crops/compositions, the success screen is an entirely different landscape.

| Screen                    | Image frame | Exported asset (`assets/images/`) |
|---------------------------|-------------|------------------------------------|
| 00 Présentation Immersive | `BmNkq`     | `onboard-hero.jpg` (697 KB)        |
| 01 Login Email            | `8dGGL`     | `login-hero.jpg` (450 KB)          |

To re-export after a Pencil edit: select the frame, then
```
mcp__pencil__export_nodes {
  filePath: "/Users/max/Desktop/georide-pencil/15-04.pen",
  nodeIds: ["<frame-id>"],
  format: "jpeg",
  outputDir: "/Users/max/dev/georide-mobile-app-v2/assets/images"
}
```
then `mv` the exported `<frame-id>.jpeg` to the friendly name.
