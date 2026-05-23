# Graphics source art

## App icon

| File | Size | Import |
|------|------|--------|
| `Icon.png` | 1024×1024 | `./scripts/import_app_icon.sh` |

See [docs/app-icon.md](../docs/app-icon.md).

## Parallax backgrounds

PNG strips are the **source of truth** for level parallax backgrounds. Catalog copies (with @1x/@2x/@3x scales) live in `Tight Rope Car/Assets.xcassets/`.

## Naming

```text
bg_{theme}_{far|mid|near}.png
```

Names must match `ParallaxLayerSpec.assetName` in `BackgroundThemeCatalog.swift` (without `.png`).

## Re-import into Xcode

From the repo root:

```bash
./scripts/import_parallax_graphics.sh
```

Source files are treated as **@3x**; the script downscales for @2x and @1x.

## Regenerate one theme

**Ocean:**
```bash
python3 scripts/generate_ocean_parallax_graphics.py
./scripts/import_parallax_graphics.sh
```

**Bedroom:**
```bash
python3 scripts/generate_bedroom_parallax_graphics.py
./scripts/import_parallax_graphics.sh
```

Strips are 1792×592 (@3x) with a clear center-lower band for rope/car readability.
