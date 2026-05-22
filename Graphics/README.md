# Parallax background source art

PNG strips in this folder are the **source of truth** for level parallax backgrounds. Catalog copies (with @1x/@2x/@3x scales) live in `Tight Rope Car/Assets.xcassets/`.

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
