#!/usr/bin/env python3
"""Synthesize a short rope-stress creak one-shot for near-fall gameplay SFX."""

from __future__ import annotations

import math
import random
import struct
import subprocess
import wave
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT_DIR = ROOT / "Tight Rope Car" / "Resources" / "Audio"
WAV_PATH = OUT_DIR / "rope_creak.wav"
CAF_PATH = OUT_DIR / "rope_creak.caf"

SAMPLE_RATE = 44_100
DURATION_SEC = 0.42


def generate_samples() -> list[float]:
    count = int(SAMPLE_RATE * DURATION_SEC)
    random.seed(91)
    samples: list[float] = []

    for i in range(count):
        t = i / SAMPLE_RATE
        env = math.sin(min(1.0, t / 0.02) * math.pi * 0.5)
        env *= math.exp(-t * 9.5)

        scrape = math.sin(t * 180 * 2 * math.pi + random.uniform(-0.2, 0.2)) * 0.12
        scrape += math.sin(t * 260 * 2 * math.pi) * 0.06
        twang = math.sin(t * 420 * 2 * math.pi) * math.exp(-t * 14) * 0.08
        grit = random.uniform(-1, 1) * 0.18 * env

        sample = (scrape + twang + grit) * env
        samples.append(sample * 0.55)

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
    print(f"Wrote {CAF_PATH.relative_to(ROOT)} ({DURATION_SEC:.2f}s one-shot)")


if __name__ == "__main__":
    main()
