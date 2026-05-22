#!/usr/bin/env python3
"""Generate flat parallax background PNGs for ocean, forest, and beach themes."""

from __future__ import annotations

import json
import math
import random
from pathlib import Path

from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "Tight Rope Car" / "Assets.xcassets"

# Design canvas @1x (export @2x/@3x by scaling)
BASE_W = 1024
BASE_H = 768

THEMES = ("ocean", "forest", "beach")
LAYERS = ("far", "mid", "near")
SCALES = (1, 2, 3)


def rgb(t: tuple[float, float, float], a: int = 255) -> tuple[int, int, int, int]:
    return (
        int(t[0] * 255),
        int(t[1] * 255),
        int(t[2] * 255),
        a,
    )


def lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t


def lerp_color(c1, c2, t: float):
    return tuple(lerp(c1[i], c2[i], t) for i in range(3))


def seamless_x(x: float, period: float) -> float:
    return x % period


def write_imageset(name: str, images: dict[int, Image.Image]) -> None:
    folder = ASSETS / f"{name}.imageset"
    folder.mkdir(parents=True, exist_ok=True)
    for scale, img in images.items():
        img.save(folder / f"{name}@{scale}x.png", "PNG")
    contents = {
        "images": [
            {"filename": f"{name}@1x.png", "idiom": "universal", "scale": "1x"},
            {"filename": f"{name}@2x.png", "idiom": "universal", "scale": "2x"},
            {"filename": f"{name}@3x.png", "idiom": "universal", "scale": "3x"},
        ],
        "info": {"author": "xcode", "version": 1},
        "properties": {"template-rendering-intent": "original"},
    }
    (folder / "Contents.json").write_text(json.dumps(contents, indent=2) + "\n")


def scale_image(img: Image.Image, factor: int) -> Image.Image:
    if factor == 1:
        return img
    return img.resize((img.width * factor, img.height * factor), Image.Resampling.LANCZOS)


def blank() -> Image.Image:
    return Image.new("RGBA", (BASE_W, BASE_H), (0, 0, 0, 0))


# --- Ocean ---

def draw_ocean_far(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    """Horizon line and soft clouds; upper two-thirds only."""
    horizon_y = int(h * 0.52)
    water = (0.18, 0.48, 0.72)
    for x in range(0, w, 2):
        wave = math.sin(x / 120.0) * 6
        draw.line([(x, horizon_y + int(wave)), (x, h)], fill=rgb(water, 90), width=2)

    cloud_color = (1.0, 1.0, 1.0)
    clouds = [(80, 90, 140), (320, 70, 180), (560, 110, 160), (820, 85, 150), (1040, 100, 130)]
    for cx, cy, cw in clouds:
        for ox in (-w, 0, w):
            draw.ellipse([cx + ox - cw // 2, cy, cx + ox + cw // 2, cy + 55], fill=rgb(cloud_color, 200))
            draw.ellipse([cx + ox - cw // 3, cy - 25, cx + ox + cw // 3, cy + 35], fill=rgb(cloud_color, 210))


def draw_ocean_mid(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    """Repeating wave bands across mid-lower area; keep center band lighter."""
    band_top = int(h * 0.45)
    band_bottom = int(h * 0.78)
    colors = [(0.14, 0.42, 0.62), (0.1, 0.36, 0.55), (0.16, 0.45, 0.65)]
    for row, col in enumerate(colors):
        y_base = band_top + row * 55
        for x in range(-w, w * 2, 8):
            sx = seamless_x(x, w)
            offset = int(math.sin((sx + row * 40) / 55.0) * 12)
            y = y_base + offset
            draw.arc(
                [sx - 30, y - 18, sx + 30, y + 22],
                0,
                180,
                fill=rgb(col, 200),
                width=14,
            )
    # gameplay clearance — faint only
    clear = int(h * 0.55)
    draw.rectangle([0, clear, w, band_bottom], fill=(0, 0, 0, 0))


def draw_ocean_near(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    """Foam and spray silhouettes along bottom edge."""
    foam = (0.85, 0.95, 1.0)
    spray = (0.55, 0.82, 0.95)
    base_y = int(h * 0.72)
    for x in range(-w, w * 2, 24):
        sx = seamless_x(x, w)
        hgt = 18 + int(abs(math.sin(sx / 35.0)) * 22)
        draw.pieslice(
            [sx - 28, base_y - hgt, sx + 28, base_y + 12],
            200,
            340,
            fill=rgb(foam, 230),
        )
        if sx % 72 < 36:
            draw.line(
                [(sx, base_y - hgt - 8), (sx + 6, base_y - hgt - 28)],
                fill=rgb(spray, 180),
                width=4,
            )


# --- Forest ---

def draw_forest_far(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    hill = (0.28, 0.52, 0.32)
    for ox in (-w, 0, w):
        pts = []
        for x in range(0, w + 1, 40):
            y = int(h * 0.58 + math.sin((x + ox) / 90.0) * 35 + math.cos((x + ox) / 140.0) * 20)
            pts.append((x + ox, y))
        pts += [(w + ox, h), (ox, h)]
        draw.polygon(pts, fill=rgb(hill, 220))


def draw_forest_mid(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    trunk = (0.32, 0.22, 0.14)
    canopy = (0.12, 0.38, 0.2)
    spacing = 95
    for ox in (-w, 0, w):
        for i in range(-2, w // spacing + 3):
            cx = ox + i * spacing + (i % 3) * 12
            base = int(h * 0.62)
            tw = 22
            th = 120 + (i % 4) * 18
            draw.rectangle([cx - tw // 2, base - th, cx + tw // 2, base], fill=rgb(trunk, 255))
            draw.ellipse(
                [cx - 55, base - th - 70, cx + 55, base - th + 30],
                fill=rgb(canopy, 240),
            )


def draw_forest_near(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    bush = (0.1, 0.32, 0.16)
    stump = (0.38, 0.28, 0.18)
    for ox in (-w, 0, w):
        for i in range(0, w // 70 + 2):
            cx = ox + i * 70 + 20
            by = int(h * 0.78)
            draw.ellipse([cx - 40, by - 45, cx + 40, by + 5], fill=rgb(bush, 250))
            if i % 3 == 0:
                draw.rectangle([cx - 12, by, cx + 12, by + 28], fill=rgb(stump, 255))


# --- Beach ---

def draw_beach_far(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    sun = (1.0, 0.92, 0.45)
    draw.ellipse([w - 200, 60, w - 60, 200], fill=rgb(sun, 240))
    for ox in (-w, 0, w):
        draw.arc(
            [ox + 40, int(h * 0.5), ox + w - 40, int(h * 0.72)],
            0,
            180,
            fill=rgb((0.95, 0.85, 0.55), 180),
            width=6,
        )


def draw_beach_mid(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    sand = (0.94, 0.82, 0.58)
    dune = (0.88, 0.75, 0.5)
    for ox in (-w, 0, w):
        pts = []
        for x in range(0, w + 1, 30):
            y = int(h * 0.62 + math.sin((x + ox) / 70.0) * 18)
            pts.append((x + ox, y))
        pts += [(w + ox, h), (ox, h)]
        draw.polygon(pts, fill=rgb(sand, 230))
        draw.line(pts[: len(pts) - 2], fill=rgb(dune, 255), width=4)


def draw_beach_near(draw: ImageDraw.ImageDraw, w: int, h: int) -> None:
    sand_tex = (0.9, 0.78, 0.52)
    umbrella = (0.95, 0.35, 0.4)
    pole = (0.55, 0.45, 0.4)
    random.seed(7)
    for ox in (-w, 0, w):
        for x in range(0, w, 18):
            if random.random() > 0.55:
                draw.point((x + ox, int(h * 0.8) + random.randint(0, 40)), fill=rgb(sand_tex, 90))
        for i in range(4):
            ux = ox + 180 + i * 240
            draw.line([(ux, int(h * 0.82)), (ux, int(h * 0.55))], fill=rgb(pole, 255), width=5)
            draw.pieslice(
                [ux - 70, int(h * 0.48), ux + 70, int(h * 0.62)],
                180,
                0,
                fill=rgb(umbrella, 240),
            )


DRAWERS = {
    "ocean": {"far": draw_ocean_far, "mid": draw_ocean_mid, "near": draw_ocean_near},
    "forest": {"far": draw_forest_far, "mid": draw_forest_mid, "near": draw_forest_near},
    "beach": {"far": draw_beach_far, "mid": draw_beach_mid, "near": draw_beach_near},
}


def render_layer(theme: str, layer: str) -> Image.Image:
    img = blank()
    draw = ImageDraw.Draw(img)
    DRAWERS[theme][layer](draw, BASE_W, BASE_H)
    return img


def main() -> None:
    for theme in THEMES:
        for layer in LAYERS:
            name = f"bg_{theme}_{layer}"
            base = render_layer(theme, layer)
            scaled = {s: scale_image(base, s) for s in SCALES}
            write_imageset(name, scaled)
            print(f"Wrote {name}.imageset")
    print("Done — 9 image sets (ocean, forest, beach × far/mid/near).")


if __name__ == "__main__":
    main()
