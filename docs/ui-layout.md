# UI layout and safe areas

SwiftUI screens in **Tight Rope Car** follow one rule: **the screen background continues edge-to-edge into safe areas** (notch, status bar, home indicator). Interactive content may stay inset; only the fill extends.

Implementation lives in [`HotWheelsScreenLayout.swift`](../Tight%20Rope%20Car/Theme/HotWheelsScreenLayout.swift) and [`HotWheelsTheme.swift`](../Tight%20Rope%20Car/Theme/HotWheelsTheme.swift).

## Background by context

| Context | Background | Content |
|---------|------------|---------|
| Menu funnel (landing → map) | `RacingStripeBackground` | Headers, panels, lists inset |
| Gameplay run | `GameSceneView` (SpriteKit) | HUD inset; playfield full bleed |
| Run overlays (calibrate / pause / results) | `RunFlowOverlayBackdrop` (dimmed playfield) | `RunFlowOverlayCard` inset |
| Modal sheets | `HotWheelsTheme.backgroundGradient` | Form / scroll inside safe area |
| Theme preview (full-screen cover) | `ParallaxBackgroundPreviewView` | Controls inset with `safeAreaPadding` |

## Root shell

[`RootView`](../Tight%20Rope%20Car/Views/RootView.swift) shows `RacingStripeBackground` only for menu flows. During `.gameplay`, stripes are hidden so safe-area gaps never reveal menu art behind the SpriteKit scene.

Each menu screen also calls `hotWheelsMenuScreenBackground()` so stripes remain correct if the root shell changes.

## View modifiers

| Modifier | Use |
|----------|-----|
| `hotWheelsMenuScreenBackground()` | Racing stripes behind menu funnel screens |
| `hotWheelsSheetBackground()` | Gradient + `presentationBackground` on sheet `NavigationStack` roots |
| `hotWheelsMenuBottomChromeBackground()` | Dark fade on `.safeAreaInset(edge: .bottom)` footers (profile, garage, map) |
| `hotWheelsScreenContentPadding()` | Extra 16pt below status bar **inside** safe layout — not the screen fill |
| `hotWheelsContentWidth()` | Max 560pt centered column for menu chrome and overlay cards — **not** on gameplay `GameSceneView` |
| `ignoresSafeArea()` | Playfield, overlay backdrop, stripe/gradient fills |

## Screen inventory

| Screen | Background helper | Bottom inset chrome |
|--------|-------------------|---------------------|
| `LandingView` | `hotWheelsMenuScreenBackground()` | — |
| `ProfileSelectionView` | menu + bottom chrome | Continue |
| `CarSelectionView` | menu + bottom chrome | Continue |
| `CourseSelectionView` | menu + bottom chrome | Play track |
| `GameplayView` | `GameSceneView` (no stripes) | On-screen balance pad over playfield |
| `GameplayCalibrationOverlay` | `RunFlowOverlayBackdrop` | — |
| `GameplayPauseOverlay` | backdrop | — |
| `RunResultsView` | backdrop | — |
| `CreateProfileView` / `EditProfileView` | `hotWheelsSheetBackground()` | — |
| `HighScoresView` | sheet background | — |
| `BackgroundThemeGalleryView` | sheet background | — |
| `BackgroundThemePreviewScreen` | parallax preview | — |

## Run overlay layout

Overlays use a full-bleed `RunFlowOverlayBackdrop` and a `ScrollView` + `RunFlowOverlayCard`. Safe-area spacing is applied on the **card** (`.safeAreaPadding(.vertical, 12)` etc.), not on the scroll view, so the dim layer stays uniform.

## Sheets

Pattern:

```swift
NavigationStack {
    // content
}
.hotWheelsSheetBackground()
```

`ProfileEditorForm` uses `.scrollContentBackground(.hidden)` so the form does not paint a system gray fill.

## Previews

Stack the same background as production before the screen under test, e.g. `RacingStripeBackground()` + `LandingView()` in `#Preview`.

## Related docs

- [systems-overview.md](systems-overview.md) — SwiftUI vs SpriteKit flow
- [background-themes.md](background-themes.md) — parallax themes and preview gallery
- [background-art.md](background-art.md) — art pipeline
