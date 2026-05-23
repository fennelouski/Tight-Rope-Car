# Gameplay tuning

Central balance knobs live in `GameBalanceConstants` (`Tight Rope Car/Game/Simulation/GameBalanceConstants.swift`). Per-course difficulty (speed, rope width, wind, pitch limit) is defined on each `Course` in `CourseCatalog`.

## Fall and stability

| Constant | Unit | Default | Affects | Turn up | Turn down |
|----------|------|---------|---------|---------|-----------|
| `lateralFallThresholdOfHalfWidth` | fraction of half-width | `1.0` | How far off-center before `.offRope` fall | Stricter edge (fall sooner) | More forgiveness on rope edge |
| `pitchFallUsesInclusiveLimit` | bool | `true` | Whether pitch at exactly `maxPitchRadians` falls | — | Set `false` for tiny margin below limit |
| `ropeHalfWidth(at:)` | points | derived | Hitbox half-width from sampled rope width | — | — |

## Tilt input

| Constant | Unit | Default | Affects | Turn up | Turn down |
|----------|------|---------|---------|---------|-----------|
| `tiltSmoothingNewSampleWeight` | 0–1 blend | `0.2` | Low-pass on device roll → lean | Snappier, jitterier | Smoother, slower response |
| `tiltInputNominalHz` | Hz | `60` | Damping exponent reference | — | — |
| `tiltFilterTargetHz` | Hz | `15` | Documented filter band (~10–20 Hz) | — | — |
| `tiltDeadZoneRadians` | radians | `0.05` | Roll ignored near level | Wider dead zone (less drift) | More sensitive near center |
| `lateralAccelerationFromTilt` | pts/s² per rad | `200` | How hard tilt pushes sideways | Faster slide, harder balance | Slower slide, easier corrections |
| `lateralVelocityDampingPerFrame` | 0–1 per 60 Hz frame | `0.85` | Lateral drift decay | Less damping (more slide) | More damping (stops faster) |
| `onScreenBalanceRollStep` | radians | `0.08` | Roll nudge per on-screen tap | Bigger taps | Finer taps |

## Calibration

| Constant | Unit | Default | Affects | Turn up | Turn down |
|----------|------|---------|---------|---------|-----------|
| `calibrationRequiredSamples` | count | `18` | Samples before auto-finish | Longer hold | Faster start |
| `calibrationMaxRollVariance` | rad² | `0.0008` | Max shake during calibration | Stricter steady hold | Easier to pass |
| `calibrationSampleInterval` | seconds | `1/30` | Poll rate during calibration | Faster finish | Slower sampling |

## Haptics

| Constant | Unit | Default | Affects | Turn up | Turn down |
|----------|------|---------|---------|---------|-----------|
| `nearFallSeverityThreshold` | 0–1 severity | `0.78` | When near-fall haptics fire | Earlier warnings | Later warnings |
| `nearFallHapticCooldownSeconds` | seconds | `0.45` | Min gap between near-fall pulses | More frequent buzz | Less frequent buzz |

## Audio

Engine loop (`GameplayLoopSFXPlayer`) runs at volume **0.42**, ducked to **0.30** when theme ambience is also playing. Near-fall `rope_creak` one-shots share `nearFallHapticCooldownSeconds` with haptics. **Reduce Motion** does not mute gameplay audio (only motion/visual sway and near-fall haptics).

## Simulation loop

| Constant | Unit | Default | Affects | Turn up | Turn down |
|----------|------|---------|---------|---------|-----------|
| `maxSimulationDeltaTime` | seconds | `1/30` | Max `update` step after hitch | — | Lower cap for tighter sim |
| `ticketCollectionLookaheadArcLength` | points | `25` | How early tickets auto-collect | Earlier pickup | Must drive closer |

## Rope rendering (visual only)

These affect SpriteKit draw only. **Fall logic uses unswayed `CourseSampler` positions and `ropeHalfWidth`.**

| Constant | Unit | Default | Affects | Turn up | Turn down |
|----------|------|---------|---------|---------|-----------|
| `ropeVisibleArcLengthBehind` | points | `300` | Rope drawn behind car | Longer trail | Shorter trail |
| `ropeVisibleArcLengthAhead` | points | `700` | Rope drawn ahead of car | See more course | Less draw cost |
| `ropePathSampleCount` | segments | `60` | Polyline smoothness | Smoother path | Coarser path |
| `ropeVisualSwayAmplitudePoints` | points | `3` | Cosmetic sway size | More wobble | Subtle / set `0` to disable |
| `ropeVisualSwayFrequencyHz` | Hz | `0.25` | Sway speed | Faster oscillation | Slower sway |
| `ropeVisualSwayPhasePerArcLength` | rad/point | `0.004` | Wave along rope length | More ripples | Gentler wave |
| `ropeHighlightLineWidthFactor` | fraction | `0.18` | Highlight stripe width | Thicker highlight | Thinner highlight |
| `ropeUnderlayWidthPadding` | points | `6` | Shadow stroke width | Heavier outline | Lighter outline |
| `ropeUnderlayStrokeOpacity` | 0–1 | `0.55` | Shadow stroke alpha | Darker underlay | Lighter underlay |
| `ropeVisualWidthChangeThreshold` | points | `1` | When width change splits segments | More width steps | Fewer segments |

Sway is disabled when **Reduce Motion** is on (`GameScene.reduceMotion`).

## Course-level knobs (not in `GameBalanceConstants`)

Edit entries in `CourseCatalog` / individual `Course` values:

| Field | Unit | Effect |
|-------|------|--------|
| `forwardSpeed` | points/s | Auto-forward rate along rope |
| `ropeWidth` / waypoint widths | points | Hitbox width via sampler |
| `maxPitchRadians` | radians | Max lean before `.excessivePitch` fall |
| `windProfile` | — | Gust amplitude/frequency via `WindGustSimulator` |
| `styleSpans` | — | Rope stroke/highlight colors along arc length |
| `ticketFractions` | 0–1 | Ticket positions along course |

See [systems-overview.md](systems-overview.md) for data flow.
