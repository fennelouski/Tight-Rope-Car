#!/usr/bin/env bash
# Copy Graphics/Icon.png (1024×1024) into AppIcon.appiconset for iOS.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/Graphics/Icon.png"
DEST="$ROOT/Tight Rope Car/Assets.xcassets/AppIcon.appiconset/AppIcon.png"

if [[ ! -f "$SRC" ]]; then
  echo "Missing source icon: $SRC" >&2
  echo "Add a 1024×1024 PNG or run: python3 scripts/generate_app_icon_placeholder.py" >&2
  exit 1
fi

w=$(sips -g pixelWidth "$SRC" | awk '/pixelWidth:/{print $2}')
h=$(sips -g pixelHeight "$SRC" | awk '/pixelHeight:/{print $2}')
if [[ "$w" != "1024" || "$h" != "1024" ]]; then
  echo "Resizing $SRC from ${w}×${h} → 1024×1024" >&2
  work="$(mktemp -t icon).png"
  sips -z 1024 1024 "$SRC" --out "$work" >/dev/null
  cp "$work" "$DEST"
  rm -f "$work"
else
  cp "$SRC" "$DEST"
fi

echo "App icon → $DEST (1024×1024)"
