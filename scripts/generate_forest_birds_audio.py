#!/usr/bin/env python3
"""Synthesize a short seamless forest birds + breeze loop for the forest theme ambience."""

from __future__ import annotations

import math
import random
import struct
import subprocess
import wave
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "Tight Rope Car" / "Resources" / "Audio"
WAV_PATH = OUT_DIR / "forest_birds.wav"
CAF_PATH = OUT_DIR / "forest_birds.caf"

SAMPLE_RATE = 44_100
DURATION_SEC = 10.0

CHIRP_TIMES = [0.6, 1.4, 2.8, 3.5, 4.9, 5.7, 6.8, 7.6, 8.5, 9.2]
CHIRP_FREQS = [2200, 2800, 1900, 3100, 2400, 2600, 2100, 2900, 2500, 2700]


def chirp(t: float, start: float, duration: float, freq: float) -> float:
    local = t - start
    if local < 0 or local > duration:
        return 0.0
    env = math.sin(math.pi * local / duration)
    warble = freq * (1.0 + 0.15 * math.sin(local * 42))
    return math.sin(2 * math.pi * warble * local) * env * 0.22


def generate_samples() -> list[float]:
    count = int(SAMPLE_RATE * DURATION_SEC)
    random.seed(7)
    brown = 0.0
    samples: list[float] = []

    for i in range(count):
        t = i / SAMPLE_RATE
        white = random.uniform(-1, 1)
        brown = brown * 0.988 + white * 0.06

        breeze = math.sin(t * 0.18 * 2 * math.pi) * 0.12
        rustle = brown * 0.35 + breeze

        birds = 0.0
        for chirp_t, freq in zip(CHIRP_TIMES, CHIRP_FREQS):
            birds += chirp(t, chirp_t, 0.18, freq)
            birds += chirp(t, chirp_t + 0.09, 0.12, freq * 1.08) * 0.6

        sample = rustle + birds
        fade = min(1.0, t / 0.4, (DURATION_SEC - t) / 0.4)
        samples.append(sample * fade * 0.48)

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
