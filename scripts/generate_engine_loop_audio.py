#!/usr/bin/env python3
"""Synthesize a seamless idle engine rumble loop for gameplay runs."""

from __future__ import annotations

import math
import random
import struct
import subprocess
import wave
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "Tight Rope Car" / "Resources" / "Audio"
WAV_PATH = OUT_DIR / "engine_loop.wav"
CAF_PATH = OUT_DIR / "engine_loop.caf"

SAMPLE_RATE = 44_100
DURATION_SEC = 5.0


def generate_samples() -> list[float]:
    count = int(SAMPLE_RATE * DURATION_SEC)
    random.seed(77)
    brown = 0.0
    samples: list[float] = []

    for i in range(count):
        t = i / SAMPLE_RATE
        white = random.uniform(-1, 1)
        brown = brown * 0.97 + white * 0.12

        idle_pulse = 0.55 + 0.45 * math.sin(t * 2.8 * 2 * math.pi)
        idle_pulse *= 0.85 + 0.15 * math.sin(t * 0.9 * 2 * math.pi + 0.4)
        harmonic = math.sin(t * 42 * 2 * math.pi) * 0.03 * idle_pulse
        harmonic += math.sin(t * 63 * 2 * math.pi + 1.1) * 0.018

        sample = brown * 0.5 * idle_pulse + harmonic
        fade = min(1.0, t / 0.25, (DURATION_SEC - t) / 0.25)
        samples.append(sample * fade * 0.38)

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
        [
            "afconvert",
            "-f",
            "caff",
            "-d",
            "aac",
            "-b",
            "128000",
            str(wav_path),
            str(caf_path),
        ],
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
