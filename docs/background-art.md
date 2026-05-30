# Parallax background art

Flat 2D parallax strips for level backgrounds. Catalog metadata lives in `BackgroundThemeCatalog.swift`; asset names must match `ParallaxLayerSpec.assetName` exactly.

## Source files (`Graphics/`)

Original PNGs live in `Graphics/` (see `Graphics/README.md`). Re-import into the asset catalog with:

```bash
./scripts/import_parallax_graphics.sh
```

**Scale strategy:** Each `Graphics/bg_*.png` is treated as **@3x**. The script uses `sips` to produce @2x (×⅔ width/height) and @1x (×⅓) into `Tight Rope Car/Assets.xcassets/{assetName}.imageset/`.

**Current source dimensions (all 24 layers):** 1792 × 592 px → catalog scales 598 × 198 (@1x), 1195 × 395 (@2x), 1792 × 592 (@3x).

These strips are wider and shorter than the older Python placeholder canvas (1024 × 768 @1x design); `GameBackgroundNode` scales layer height to the scene and tiles horizontally.

## Export sizes (design target)

| Scale | Layer width | Layer height | Notes |
|-------|-------------|--------------|-------|
| @1x | 1024 px | 768 px | Design canvas in `scripts/generate_parallax_backgrounds.py` |
| @2x | 2048 px | 1536 px | Scaled export |
| @3x | 3072 px | 2304 px | iPhone full-width target |

New art can match either the shipped **1792 × 592 @3x** strips or the table above; always run `import_parallax_graphics.sh` after updating `Graphics/`.

Each theme uses three layers: `far`, `mid`, `near`. Far/mid strips are drawn for **horizontal tiling** (content repeats at `width`); keep left and right edges visually compatible.

Sky gradient and ground tint are **not** baked into the PNGs — `GameBackgroundNode` draws them from `skyGradient` and `groundColor` so placeholders and art stay aligned when colors change.

## Asset naming

```text
bg_{themeRawValue}_{far|mid|near}
```

Examples: `bg_ocean_far`, `bg_toyShop_mid`. Image sets live under `Tight Rope Car/Assets.xcassets/` with the imageset name equal to the asset name.

### Shipped in repo

| Theme | Layers |
|-------|--------|
| `ocean` | `bg_ocean_far`, `bg_ocean_mid`, `bg_ocean_near` |
| `forest` | `bg_forest_far`, `bg_forest_mid`, `bg_forest_near` |
| `city` | `bg_city_far`, `bg_city_mid`, `bg_city_near` |
| `bedroom` | `bg_bedroom_far`, `bg_bedroom_mid`, `bg_bedroom_near` |
| `toyShop` | `bg_toyShop_far`, `bg_toyShop_mid`, `bg_toyShop_near` |
| `candyShop` | `bg_candyShop_far`, `bg_candyShop_mid`, `bg_candyShop_near` |
| `garden` | `bg_garden_far`, `bg_garden_mid`, `bg_garden_near` |
| `beach` | `bg_beach_far`, `bg_beach_mid`, `bg_beach_near` |

All **8 themes × 3 layers = 24** imagesets are populated from `Graphics/`.

## Art pipeline

1. **Layout** — Side-view strip; keep the center–lower third relatively empty for rope/car readability.
2. **Style** — Bold silhouettes, high contrast, cartoony flats; palette should sit near the theme’s catalog colors.
3. **Export** — PNG with alpha into `Graphics/` using the naming convention above.
4. **Import** — `./scripts/import_parallax_graphics.sh`
5. **Regenerate placeholders (optional)** — `python3 scripts/generate_parallax_backgrounds.py` writes ocean/forest/beach @1x canvases into Assets; for widescreen strips use `generate_ocean_parallax_graphics.py` or `generate_bedroom_parallax_graphics.py` → `Graphics/bg_*_*.png` then import.
6. **Verify** — Run unit tests (`BackgroundThemeAssetTests`), or open `BackgroundThemeGalleryView` / `ParallaxBackgroundPreviewView` previews in Xcode (the gallery is not linked from the production landing screen yet).

## Rendering

- **SpriteKit:** `GameBackgroundNode` loads metadata, draws sky/ground, and tiles each `SKTexture` by `scrollFactor` and `zIndex`.
- **Preview:** `ParallaxBackgroundPreviewScene` auto-scrolls `setCameraX` for simulator checks.
- **In-app gallery:** `BackgroundThemeGalleryView` (SwiftUI previews or a future menu entry) → full-screen `ParallaxBackgroundPreviewView`. Preview chrome uses safe-area padding; parallax fills the notch and home indicator ([ui-layout.md](ui-layout.md)).

See also [background-themes.md](background-themes.md) for scroll-factor conventions and theme list.

## Ambience audio

Catalog field `ambienceSoundName` maps to `Tight Rope Car/Resources/Audio/{name}.caf` (also accepts `.wav` / `.m4a`).

**Ocean (shipped):** `ocean_waves.caf` — regenerate with:

```bash
python3 scripts/generate_ocean_waves_audio.py
```

**Forest (shipped):** `forest_birds.caf` — regenerate with:

```bash
python3 scripts/generate_forest_birds_audio.py
```

Preview playback: open `BackgroundThemeGalleryView` in Xcode previews → pick a theme with bundled audio → speaker control (loops while preview is open).
