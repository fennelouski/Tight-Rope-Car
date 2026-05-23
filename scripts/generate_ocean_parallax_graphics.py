#!/usr/bin/env python3
"""Regenerate ocean parallax strips (1792×592 @3x) into Graphics/. Run import_parallax_graphics.sh after."""

from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
GRAPHICS = ROOT / "Graphics"

# Shipped strip size (@3x source for import script)
W = 1792
H = 592

# Gameplay readability band (center-lower third, side-view)
CLEAR_Y0 = int(H * 0.38)
CLEAR_Y1 = int(H * 0.72)
CLEAR_X0 = int(W * 0.28)
CLEAR_X1 = int(W * 0.72)


def rgb(t: tuple[float, float, float], a: int = 255) -> tuple[int, int, int, int]:
    return (int(t[0] * 255), int(t[1] * 255), int(t[2] * 255), a)


def sx(x: float) -> float:
    return x % W


def in_clear_zone(x: float, y: float) -> bool:
    return CLEAR_X0 <= x <= CLEAR_X1 and CLEAR_Y0 <= y <= CLEAR_Y1


def blank() -> Image.Image:
    return Image.new("RGBA", (W, H), (0, 0, 0, 0))


def draw_ocean_far(draw: ImageDraw.ImageDraw) -> None:
    """Distant horizon shimmer, island silhouettes on edges, soft clouds."""
    horizon = int(H * 0.48)
    water = (0.12, 0.38, 0.62)

    for x in range(0, W, 3):
        wave = int(math.sin(x / 140.0) * 4 + math.cos(x / 220.0) * 2)
        y0 = horizon + wave
        draw.line([(x, y0), (x, H)], fill=rgb(water, 70), width=3)

    cloud = (1.0, 1.0, 1.0)
    for base_x, cy, cw in [(120, 70, 200), (520, 55, 240), (980, 85, 210), (1380, 65, 190)]:
        for ox in (-W, 0, W):
            cx = base_x + ox
            if CLEAR_X0 < cx < CLEAR_X1 and cy < CLEAR_Y1:
                continue
            draw.ellipse(
                [cx - cw // 2, cy, cx + cw // 2, cy + 48],
                fill=rgb(cloud, 175),
            )
            draw.ellipse(
                [cx - cw // 3, cy - 22, cx + cw // 3, cy + 28],
                fill=rgb(cloud, 190),
            )

    island = (0.08, 0.28, 0.48)
    for base_x in (90, W - 160):
        for ox in (-W, 0, W):
            cx = base_x + ox
            if CLEAR_X0 - 80 < cx < CLEAR_X1 + 80:
                continue
            pts = [
                (cx - 90, horizon + 8),
                (cx - 40, horizon - 35),
                (cx + 30, horizon - 55),
                (cx + 95, horizon - 20),
                (cx + 110, horizon + 10),
            ]
            draw.polygon(pts, fill=rgb(island, 210))

    bird = (0.15, 0.22, 0.32)
    for bx in range(140, W, 280):
        for ox in (-W, 0, W):
            cx = bx + ox
            by = 95 + (bx % 3) * 12
            draw.line([(cx - 8, by), (cx, by - 5), (cx + 8, by)], fill=rgb(bird, 160), width=2)


def draw_ocean_mid(draw: ImageDraw.ImageDraw) -> None:
    """Rolling wave crests; lighter through the gameplay band."""
    colors = [
        (0.1, 0.34, 0.55),
        (0.14, 0.4, 0.6),
        (0.08, 0.3, 0.5),
    ]
    for row, col in enumerate(colors):
        y_base = int(H * 0.5) + row * 38
        for x in range(-W, W * 2, 10):
            px = sx(x)
            if in_clear_zone(px, y_base) and row == 1:
                continue
            offset = int(math.sin((px + row * 50) / 48.0) * 14)
            y = y_base + offset
            alpha = 120 if in_clear_zone(px, y) else 210
            draw.arc(
                [px - 36, y - 22, px + 36, y + 20],
                0,
                180,
                fill=rgb(col, alpha),
                width=16,
            )

    cap = (0.9, 0.97, 1.0)
    for x in range(-W, W * 2, 42):
        px = sx(x)
        if in_clear_zone(px, int(H * 0.58)):
            continue
        y = int(H * 0.54 + math.sin(px / 38.0) * 8)
        draw.arc([px - 22, y - 8, px + 22, y + 10], 200, 340, fill=rgb(cap, 200), width=5)


def draw_ocean_near(draw: ImageDraw.ImageDraw) -> None:
    """Foam and spray at the sides and lower edge; center stays open."""
    foam = (0.88, 0.96, 1.0)
    spray = (0.5, 0.78, 0.92)
    base_y = int(H * 0.68)

    for x in range(-W, W * 2, 20):
        px = sx(x)
        if in_clear_zone(px, base_y):
            continue
        hgt = 16 + int(abs(math.sin(px / 32.0)) * 24)
        draw.pieslice(
            [px - 32, base_y - hgt, px + 32, base_y + 14],
            200,
            340,
            fill=rgb(foam, 235),
        )
        if int(px) % 64 < 32:
            draw.line(
                [(px, base_y - hgt - 6), (px + 8, base_y - hgt - 26)],
                fill=rgb(spray, 190),
                width=4,
            )

    buoy = (0.95, 0.25, 0.28)
    for base_x in (120, W - 120):
        for ox in (-W, 0, W):
            cx = base_x + ox
            if CLEAR_X0 < cx < CLEAR_X1:
                continue
            by = int(H * 0.74)
            draw.ellipse([cx - 14, by - 28, cx + 14, by - 2], fill=rgb(buoy, 240))
            draw.rectangle([cx - 2, by - 38, cx + 2, by - 26], fill=rgb((0.4, 0.35, 0.32), 255))


def render_layer(layer: str) -> Image.Image:
    img = blank()
    draw = ImageDraw.Draw(img)
    if layer == "far":
        draw_ocean_far(draw)
    elif layer == "mid":
        draw_ocean_mid(draw)
    else:
        draw_ocean_near(draw)
    return img


def main() -> None:
    GRAPHICS.mkdir(parents=True, exist_ok=True)
    for layer in ("far", "mid", "near"):
        name = f"bg_ocean_{layer}.png"
        path = GRAPHICS / name
        render_layer(layer).save(path, "PNG")
        print(f"Wrote {path.relative_to(ROOT)} ({W}×{H})")
    print("Next: ./scripts/import_parallax_graphics.sh")


if __name__ == "__main__":
    main()
