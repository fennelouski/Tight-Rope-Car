#!/usr/bin/env python3
"""Hot Wheels–style placeholder app icon (1024×1024) when Graphics/Icon.png is missing."""

from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "Graphics" / "Icon.png"
SIZE = 1024


def rgb(t: tuple[float, float, float]) -> tuple[int, int, int, int]:
    return (int(t[0] * 255), int(t[1] * 255), int(t[2] * 255), 255)


def main() -> None:
    img = Image.new("RGBA", (SIZE, SIZE), rgb((0.1, 0.1, 0.1)))
    draw = ImageDraw.Draw(img)

    for i in range(0, SIZE, 48):
        color = (1.0, 0.4, 0.0, 0.35) if (i // 48) % 2 == 0 else (0.0, 0.4, 1.0, 0.28)
        draw.polygon(
            [(i - SIZE, SIZE), (i + 80, 0), (i + 128, 0), (i + 48, SIZE)],
            fill=rgb(color[:3]),
        )

    rope_y = int(SIZE * 0.58)
    draw.line([(120, rope_y), (904, rope_y)], fill=rgb((0.1, 0.1, 0.1)), width=28)
    draw.line([(120, rope_y - 6), (904, rope_y - 6)], fill=rgb((1.0, 0.82, 0.0)), width=8)

    cx, cy = SIZE // 2, int(SIZE * 0.52)
    draw.rounded_rectangle(
        [cx - 150, cy - 50, cx + 150, cy + 50],
        radius=28,
        fill=rgb((0.89, 0.09, 0.22)),
        outline=rgb((0.1, 0.1, 0.1)),
        width=8,
    )
    draw.ellipse([cx - 170, cy + 20, cx - 110, cy + 80], fill=rgb((0.1, 0.1, 0.1)))
    draw.ellipse([cx + 110, cy + 20, cx + 170, cy + 80], fill=rgb((0.1, 0.1, 0.1)))

    draw.text((cx - 40, cy - 120), "TRC", fill=rgb((1.0, 1.0, 1.0)))

    OUT.parent.mkdir(parents=True, exist_ok=True)
    img.save(OUT, "PNG")
    print(f"Wrote {OUT} — run ./scripts/import_app_icon.sh")


if __name__ == "__main__":
    main()
