# Systems overview

High-level gameplay data flow for **Tight Rope Car**. SwiftUI owns menus and run phase; SpriteKit owns the live simulation frame loop.

```mermaid
flowchart TB
  subgraph input [Input]
    CM[CoreMotion / Simulator tilt]
    Manual[On-screen balance buttons]
    Cal[TiltCalibrator]
  end

  subgraph session [GameplayTiltSession]
    Providers[CompositeTiltRollProvider]
    Processor[TiltInputProcessor]
  end

  subgraph scene [GameScene SpriteKit]
    Loop[update loop]
    Physics[GameRunPhysics lateral integration]
    Wind[WindGustSimulator]
    Sampler[CourseSampler hitbox path]
    RopeVis[RopePathBuilder visual only]
    Eval[BalanceStabilityEvaluator]
  end

  subgraph shell [GameplayView SwiftUI]
    Phases[calibrating → running → paused → results]
    HUD[HUD + overlays]
    Results[RunResultsView]
  end

  subgraph persist [Progress]
    Recorder[GameRunRecorder]
    Progress[CourseProgressStore]
    Scores[CourseScoreStore]
  end

  CM --> Providers
  Manual --> Providers
  Cal --> Processor
  Providers --> Processor
  Phases -->|isPaused| Loop
  Processor --> Loop
  Loop --> Physics
  Wind --> Physics
  Sampler --> Eval
  Physics --> Eval
  RopeVis -.->|no hitbox| Loop
  Eval -->|onOutcome| Results
  Results --> Recorder
  Recorder --> Progress
  Recorder --> Scores
  HUD --> Phases
```

## Run phases

| Phase | Scene updates | Tilt input |
|-------|---------------|------------|
| Calibrating | Paused | Calibration samples only |
| Running | Active | Device and/or on-screen balance |
| Paused | Paused | Ignored (decay toward level) |
| Results | Paused | Ignored |

## Related docs

- [ui-layout.md](ui-layout.md) — safe areas, screen backgrounds, shared layout modifiers
- [gameplay-tuning.md](gameplay-tuning.md) — all `GameBalanceConstants` knobs
- [background-themes.md](background-themes.md) — parallax themes per course
