#!/usr/bin/env python3
"""Synthesize a short seamless toy-shop chimes ambience loop."""

from __future__ import annotations

import math
import random
import struct
import subprocess
import wave
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "Tight Rope Car" / "Resources" / "Audio"
WAV_PATH = OUT_DIR / "toy_shop_chimes.wav"
CAF_PATH = OUT_DIR / "toy_shop_chimes.caf"

SAMPLE_RATE = 44_100
DURATION_SEC = 8.0

CHIME_TIMES = [0.5, 1.6, 2.4, 3.8, 4.5, 5.9, 6.7, 7.4]
CHIME_FREQS = [880, 1175, 988, 1319, 1047, 1568, 880, 1175]


def chime(t: float, start: float, duration: float, freq: float) -> float:
    local = t - start
    if local < 0 or local > duration:
        return 0.0
    env = math.exp(-local * 6.0) * math.sin(math.pi * local / duration)
    return math.sin(2 * math.pi * freq * local) * env * 0.28


def generate_samples() -> list[float]:
    count = int(SAMPLE_RATE * DURATION_SEC)
    random.seed(13)
    samples: list[float] = []

    for i in range(count):
        t = i / SAMPLE_RATE
        bells = 0.0
        for ct, freq in zip(CHIME_TIMES, CHIME_FREQS):
            bells += chime(t, ct, 0.45, freq)
            bells += chime(t, ct + 0.04, 0.35, freq * 2.01) * 0.35

        shimmer = random.uniform(-0.02, 0.02) if int(t * 12) % 3 == 0 else 0.0
        sample = bells + shimmer
        fade = min(1.0, t / 0.3, (DURATION_SEC - t) / 0.3)
        samples.append(sample * fade * 0.5)

    return samples


def write_wav(path: Path, samples: list[float]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(path), "w") as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(SAMPLE_RATE)
        frames = bytearray()
        for s in samples:
            clamped = max(-1.0, min(1.0, s))
            frames.extend(struct.pack("<h", int(clamped * 32767)))
        wf.writeframes(frames)


def write_caf(wav_path: Path, caf_path: Path) -> None:
    subprocess.run(
        ["afconvert", "-f", "caff", "-d", "aac", "-b", "128000", str(wav_path), str(caf_path)],
        check=True,
    )


def main() -> None:
    samples = generate_samples()
    write_wav(WAV_PATH, samples)
    write_caf(WAV_PATH, CAF_PATH)
    print(f"Wrote {WAV_PATH.relative_to(ROOT)}")
    print(f"Wrote {CAF_PATH.relative_to(ROOT)} ({DURATION_SEC:.0f}s loop)")


if __name__ == "__main__":
    main()
