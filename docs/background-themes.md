# Level background themes

Each level in **Tight Rope Car** can use a distinct visual environment while sharing the same rope-and-balance gameplay. Background themes describe **what the player sees** (sky, parallax layers, ambience)—not rope width, wind, or difficulty. Those knobs belong on a future `Level` model.

## Data model

| Type | Role |
|------|------|
| `BackgroundTheme` | Stable enum identity (`ocean`, `forest`, …) for Codable storage and UI lists |
| `ThemeColor` | Codable RGBA for sky gradients and ground tint until image assets ship |
| `BackgroundThemeMetadata` | Display copy, colors, parallax layer specs, optional ambience sound |
| `BackgroundThemeCatalog` | Single source of truth: `all`, `sortedForDisplay`, `metadata(for:)` |

Catalog entries live in Swift under `Tight Rope Car/Models/`. They are **not** SwiftData models; progress/unlocks will reference `BackgroundTheme.rawValue` later.

## Themes

| Theme | Display name | Parallax fantasy |
|-------|--------------|------------------|
| `ocean` | Ocean | Horizon, waves, distant water |
| `forest` | Forest | Tree lines, hills, woodland depth |
| `city` | City | Skyline, buildings, rooftop layers |
| `bedroom` | Bedroom | Furniture and toys at kid scale |
| `toyShop` | Toy Shop | Shelves, signage, shop interior depth |
| `candyShop` | Candy Shop | Pastel sweets, jars, striped fronts |
| `garden` | Garden | Flowers, hedges, garden paths |
| `beach` | Beach | Sand, umbrellas, shoreline |

Sky gradients and ground bands always come from catalog `ThemeColor` metadata; parallax strips are separate PNG layers (see [background-art.md](background-art.md)).

**Art pipeline and export sizes:** [background-art.md](background-art.md). All eight themes ship 24 parallax imagesets (`bg_{theme}_{far|mid|near}`) in `Assets.xcassets`, imported from `Graphics/` via `scripts/import_parallax_graphics.sh`. Verify with `BackgroundThemeAssetTests` or **Backgrounds** on the landing screen.

## Asset naming convention

Parallax textures follow:

```text
bg_{themeRawValue}_{layer}
```

Where `{layer}` is typically `far`, `mid`, or `near` (slowest to fastest scroll). Examples:

- `bg_ocean_far`, `bg_ocean_mid`, `bg_ocean_near`
- `bg_toyShop_far` (camelCase matches `BackgroundTheme.toyShop.rawValue`)

Add images to the asset catalog or bundle with these exact names so `ParallaxLayerSpec.assetName` resolves in `GameScene`.

### Scroll factors

`ParallaxLayerSpec.scrollFactor` is a multiplier relative to camera motion:

- **0** — nearly fixed (distant sky/hills)
- **~0.15–0.2** — far layer
- **~0.35–0.45** — mid layer
- **~0.7–0.8** — near layer

Optional `zIndex` orders draws when layers overlap.

## Ambience audio

`ambienceSoundName` is a bundle file base name (no extension), resolved by `BundledAudioLocator` (`.caf` or `.wav` under `Tight Rope Car/Resources/Audio/`).

| Theme | Sound name | Notes |
|-------|------------|--------|
| `ocean` | `ocean_waves` | Bundled |
| `forest` | `forest_birds` | Bundled |
| `city` | `city_traffic` | Bundled |
| `bedroom` | — | Silent |
| `toyShop` | `toy_shop_chimes` | Bundled |
| `candyShop` | — | Silent |
| `garden` | `garden_breeze` | Bundled |
| `beach` | `beach_waves` | Bundled |

`ThemeAmbiencePlayer` loops clips with an `.ambient` audio session (respects the hardware silent switch). Loops play in the landing **Backgrounds** gallery and during gameplay while a run is active; they stop on pause, results, and exit.

### Gameplay run audio (not theme-specific)

| Layer | Clip | Player | When |
|-------|------|--------|------|
| Theme ambience | per-table above | `ThemeAmbiencePlayer` | `.running` if theme has `ambienceSoundName` |
| Engine | `engine_loop` | `GameplayLoopSFXPlayer` | every `.running` run (volume ~0.42, ~0.30 when theme ambience plays) |
| Rope stress | `rope_creak` | `GameSFXPlayer` one-shot | near-fall, same cooldown as near-fall haptics |

Regenerate procedural loops with `scripts/generate_*_audio.py` (see `generate_ocean_waves_audio.py` for the pattern). `BackgroundThemeAssetTests` asserts every non-`nil` catalogue name resolves in the app bundle.

## Adding a new theme

1. Add a case to `BackgroundTheme` with a unique `String` raw value (camelCase).
2. Implement `makeYourTheme()` in `BackgroundThemeCatalog` and append it to `all`.
3. Assign a unique `sortOrder` for level-select ordering.
4. Add tests: catalog covers the new case; display strings non-empty; sort order unique.
5. Create `bg_{rawValue}_far|mid|near` assets (and ambience file if applicable).
6. When `Level` exists, set `backgroundThemeRawValue` to the enum’s `rawValue`.

## Future `Level` integration

A level will likely store:

```swift
let backgroundThemeRawValue: String // BackgroundTheme.rawValue
```

Resolve at load time:

```swift
let theme = BackgroundTheme(rawValue: rawValue)!
let metadata = BackgroundThemeCatalog.metadata(for: theme)
```

Unlock state and star ratings stay in a separate progress store—not in `BackgroundThemeMetadata`.

## Localization

Display strings are English in the catalog today. When localizing, move `displayName` and `tagline` to a String Catalog or keyed lookups; keep `BackgroundTheme.rawValue` stable for saves.
