//
//  GameBalanceConstants.swift
//  Tight Rope Car
//

import Foundation

/// README-aligned tuning knobs shared by simulation, SpriteKit, and tests.
enum GameBalanceConstants {
    /// Lateral offset magnitude above this fraction of rope width triggers a fall (1.0 = center past half-width).
    static let lateralFallThresholdOfHalfWidth: Double = 1.0

    /// Pitch magnitude at or above `Course.maxPitchRadians` triggers a fall.
    static let pitchFallUsesInclusiveLimit: Bool = true

    /// Low-pass blend for device roll → tilt (matches `GameScene` smoothing at 60 Hz).
    static let tiltSmoothingNewSampleWeight: Double = 0.2

    /// Nominal device-motion update rate (Hz) for future input modules.
    static let tiltInputNominalHz: Double = 60

    /// Documented README filter band (~10–20 Hz); used when deriving smoothing from Hz.
    static let tiltFilterTargetHz: Double = 15

    /// Device roll below this magnitude (after neutral offset) is treated as level.
    static let tiltDeadZoneRadians: Double = 0.05

    /// Roll samples required before calibration can finish.
    static let calibrationRequiredSamples: Int = 18

    /// Max variance (rad²) across calibration samples for a steady hold.
    static let calibrationMaxRollVariance: Double = 0.0008

    /// Poll interval while calibrating (seconds).
    static let calibrationSampleInterval: TimeInterval = 1.0 / 30.0

    /// Lateral acceleration from filtered tilt (points per second²).
    static let lateralAccelerationFromTilt: Double = 200

    /// Frame-rate-independent lateral damping base (0.85 at 60 fps).
    static let lateralVelocityDampingPerFrame: Double = 0.85

    /// Roll change per on-screen balance tap (radians).
    static let onScreenBalanceRollStep: Double = 0.08

    /// Normalized instability (max of lateral/pitch usage) at or above this triggers near-fall haptics.
    static let nearFallSeverityThreshold: Double = 0.78

    /// Minimum seconds between near-fall haptic pulses.
    static let nearFallHapticCooldownSeconds: TimeInterval = 0.45

    static func ropeHalfWidth(at ropeWidth: Double) -> Double {
        (ropeWidth / 2) * lateralFallThresholdOfHalfWidth
    }
}
