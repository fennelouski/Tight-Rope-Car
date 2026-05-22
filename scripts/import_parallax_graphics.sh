#!/usr/bin/env bash
# Import Graphics/bg_{theme}_{far|mid|near}.png into Assets.xcassets imagesets.
# Treats each source PNG as @3x; generates @2x (×2/3) and @1x (×1/3) with sips.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/Graphics"
DEST="$ROOT/Tight Rope Car/Assets.xcassets"

if [[ ! -d "$SRC" ]]; then
  echo "Missing source folder: $SRC" >&2
  exit 1
fi

write_contents_json() {
  local name="$1"
  local dir="$2"
  cat >"$dir/Contents.json" <<EOF
{
  "images": [
    {
      "filename": "${name}@1x.png",
      "idiom": "universal",
      "scale": "1x"
    },
    {
      "filename": "${name}@2x.png",
      "idiom": "universal",
      "scale": "2x"
    },
    {
      "filename": "${name}@3x.png",
      "idiom": "universal",
      "scale": "3x"
    }
  ],
  "info": {
    "author": "xcode",
    "version": 1
  },
  "properties": {
    "template-rendering-intent": "original"
  }
}
EOF
}

import_one() {
  local src_file="$1"
  local name
  name="$(basename "$src_file" .png)"
  local imageset="$DEST/${name}.imageset"
  mkdir -p "$imageset"

  local w3 h3 w2 h2 w1 h1
  w3=$(sips -g pixelWidth "$src_file" | awk '/pixelWidth:/{print $2}')
  h3=$(sips -g pixelHeight "$src_file" | awk '/pixelHeight:/{print $2}')
  w2=$(( (w3 * 2 + 2) / 3 ))
  h2=$(( (h3 * 2 + 2) / 3 ))
  w1=$(( (w3 + 2) / 3 ))
  h1=$(( (h3 + 2) / 3 ))

  cp "$src_file" "$imageset/${name}@3x.png"
  sips -z "$h2" "$w2" "$src_file" --out "$imageset/${name}@2x.png" >/dev/null
  sips -z "$h1" "$w1" "$src_file" --out "$imageset/${name}@1x.png" >/dev/null

  write_contents_json "$name" "$imageset"
  echo "  $name → ${w1}×${h1} / ${w2}×${h2} / ${w3}×${h3}"
}

shopt -s nullglob
files=("$SRC"/bg_*.png)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "No bg_*.png files in $SRC" >&2
  exit 1
fi

echo "Importing ${#files[@]} parallax layers from Graphics/ …"
for f in "${files[@]}"; do
  import_one "$f"
done
echo "Done. Imagesets: $DEST"
