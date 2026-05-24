# App icon

## Source of truth

| File | Role |
|------|------|
| `Graphics/Icon.png` | Master **1024×1024** PNG (edit here) |
| `Tight Rope Car/Assets.xcassets/AppIcon.appiconset/AppIcon.png` | iOS universal icon copied from master |

Xcode uses a single **1024×1024** slot (`Contents.json` → `ios-marketing` / universal 1024). The system generates home-screen sizes at build time.

## Import

From the repo root:

```bash
./scripts/import_app_icon.sh
```

The script copies `Graphics/Icon.png` into the app icon imageset and resizes with `sips` if the source is not already 1024×1024.

## Placeholder (no master art yet)

If `Graphics/Icon.png` is missing, generate a temporary icon:

```bash
python3 scripts/generate_app_icon_placeholder.py
./scripts/import_app_icon.sh
```

Produces a simple Hot Wheels–striped placeholder with a car-on-rope motif. When `Graphics/Icon.png` is present, run `./scripts/import_app_icon.sh` only.

## Design notes

- Keep the focal subject inside the **center safe area**; iOS applies a squircle mask.
- Bold contrast reads well at small sizes (toy-racing palette: red, yellow, blue, black).
- Dark and tinted appearances in `Contents.json` currently reuse the same PNG; add separate files later if needed.

## Verify

1. Open the project in Xcode → **Tight Rope Car** target → **General** → App Icons (should show the car-on-rope art).
2. Build and run on a simulator; check the home screen icon.
3. Unit test `applicationDeclaresAppIcon` in `AppIconTests.swift`.
