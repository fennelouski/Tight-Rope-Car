#!/usr/bin/env python3
"""Regenerate bedroom parallax strips (1792×592 @3x) into Graphics/. Run import_parallax_graphics.sh after."""

from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
GRAPHICS = ROOT / "Graphics"

W = 1792
H = 592

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


def draw_bedroom_far(draw: ImageDraw.ImageDraw) -> None:
    """Back wall, window glow, distant shelf silhouettes on the sides."""
    wall = (0.94, 0.88, 0.84)
    floor_line = int(H * 0.62)

    draw.rectangle([0, floor_line - 8, W, H], fill=rgb((0.72, 0.62, 0.55), 120))

    for ox in (-W, 0, W):
        draw.rectangle([ox, int(H * 0.22), ox + W, floor_line], fill=rgb(wall, 200))

    win_x = W // 2 - 140
    draw.rounded_rectangle(
        [win_x, int(H * 0.18), win_x + 280, int(H * 0.52)],
        radius=18,
        fill=rgb((0.75, 0.88, 0.98), 190),
        outline=rgb((0.55, 0.45, 0.4), 220),
        width=6,
    )
    draw.rectangle(
        [win_x + 135, int(H * 0.2), win_x + 145, int(H * 0.5)],
        fill=rgb((0.55, 0.45, 0.4), 200),
    )
    draw.rectangle(
        [win_x + 10, int(H * 0.33), win_x + 270, int(H * 0.43)],
        fill=rgb((0.55, 0.45, 0.4), 200),
    )

    shelf = (0.45, 0.32, 0.28)
    for base_x in (60, W - 220):
        for ox in (-W, 0, W):
            cx = base_x + ox
            if CLEAR_X0 - 60 < cx < CLEAR_X1 + 60:
                continue
            draw.rectangle(
                [cx, int(H * 0.38), cx + 160, int(H * 0.42)],
                fill=rgb(shelf, 210),
            )
            for i, h in enumerate([70, 55, 62]):
                draw.rectangle(
                    [cx + 12 + i * 48, int(H * 0.42), cx + 52 + i * 48, int(H * 0.42) + h],
                    fill=rgb((0.2 + i * 0.08, 0.5, 0.7), 200),
                )


def draw_bedroom_mid(draw: ImageDraw.ImageDraw) -> None:
    """Bed and furniture silhouettes; keep the rope lane open."""
    wood = (0.55, 0.4, 0.32)
    blanket = (0.2, 0.45, 0.75)
    floor_y = int(H * 0.68)

    for ox in (-W, 0, W):
        draw.rectangle([ox, floor_y, ox + W, H], fill=rgb((0.78, 0.68, 0.6), 160))

    for base_x, width in [(40, 200), (W - 240, 200)]:
        for ox in (-W, 0, W):
            cx = base_x + ox
            if in_clear_zone(cx + width * 0.5, floor_y - 40):
                continue
            draw.rounded_rectangle(
                [cx, floor_y - 90, cx + width, floor_y - 20],
                radius=12,
                fill=rgb(wood, 230),
            )
            draw.rounded_rectangle(
                [cx + 20, floor_y - 110, cx + width - 20, floor_y - 35],
                radius=16,
                fill=rgb(blanket, 220),
            )

    for base_x in (100, W - 180):
        for ox in (-W, 0, W):
            cx = base_x + ox
            if in_clear_zone(cx, floor_y - 50):
                continue
            draw.rectangle(
                [cx, floor_y - 130, cx + 70, floor_y - 20],
                fill=rgb((0.95, 0.55, 0.35), 215),
            )
            draw.ellipse(
                [cx + 10, floor_y - 150, cx + 60, floor_y - 115],
                fill=rgb((1.0, 0.85, 0.5), 200),
            )


def draw_bedroom_near(draw: ImageDraw.ImageDraw) -> None:
    """Toy blocks, rug edge, lamp — foreground clutter on the sides."""
    floor_y = int(H * 0.72)
    rug = (0.85, 0.35, 0.4)

    for ox in (-W, 0, W):
        pts = [
            (ox + 40, floor_y + 20),
            (ox + W - 40, floor_y + 20),
            (ox + W - 80, H - 10),
            (ox + 80, H - 10),
        ]
        draw.polygon(pts, fill=rgb(rug, 120))

    block_colors = [
        (0.95, 0.25, 0.28),
        (1.0, 0.82, 0.0),
        (0.0, 0.4, 1.0),
        (1.0, 0.4, 0.0),
    ]
    for base_x in (70, W - 200):
        for ox in (-W, 0, W):
            cx = base_x + ox
            if CLEAR_X0 < cx < CLEAR_X1:
                continue
            for i, col in enumerate(block_colors):
                size = 36 + (i % 2) * 8
                bx = cx + i * 42
                by = floor_y - size - (i % 3) * 6
                draw.rounded_rectangle(
                    [bx, by, bx + size, by + size],
                    radius=4,
                    fill=rgb(col, 240),
                    outline=rgb((0.15, 0.12, 0.1), 200),
                    width=2,
                )

    lamp_x = W - 90
    for ox in (-W, 0, W):
        lx = lamp_x + ox
        if in_clear_zone(lx, floor_y - 80):
            continue
        draw.rectangle(
            [lx, floor_y - 120, lx + 8, floor_y - 10],
            fill=rgb((0.4, 0.3, 0.25), 255),
        )
        draw.polygon(
            [(lx - 25, floor_y - 125), (lx + 33, floor_y - 125), (lx + 4, floor_y - 155)],
            fill=rgb((1.0, 0.92, 0.7), 230),
        )


def render_layer(layer: str) -> Image.Image:
    img = blank()
    draw = ImageDraw.Draw(img)
    if layer == "far":
        draw_bedroom_far(draw)
    elif layer == "mid":
        draw_bedroom_mid(draw)
    else:
        draw_bedroom_near(draw)
    return img


def main() -> None:
    GRAPHICS.mkdir(parents=True, exist_ok=True)
    for layer in ("far", "mid", "near"):
        name = f"bg_bedroom_{layer}.png"
        path = GRAPHICS / name
        render_layer(layer).save(path, "PNG")
        print(f"Wrote {path.relative_to(ROOT)} ({W}×{H})")
    print("Next: ./scripts/import_parallax_graphics.sh")


if __name__ == "__main__":
    main()
