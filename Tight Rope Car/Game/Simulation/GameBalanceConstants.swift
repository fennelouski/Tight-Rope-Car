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

    // MARK: - Landing stillness hint

    /// User-acceleration magnitude (m/s²) at or below this counts as “not moving” for the landing tilt hint.
    static let landingStillnessAccelerationThreshold: Double = 0.05

    /// Consecutive still motion samples required before showing the landing tilt hint (~0.5 s at 60 Hz).
    static let landingStillnessRequiredSamples: Int = 30

    /// Device-motion poll rate (Hz) for landing stillness detection.
    static let landingStillnessUpdateHz: Double = 60

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

    /// Normalized severity at or above this triggers the early-warning haptic (softer, earlier than near-fall).
    static let nearFallEarlyWarningThreshold: Double = 0.50

    /// Minimum seconds between early-warning haptic pulses.
    static let nearFallEarlyWarningCooldownSeconds: TimeInterval = 1.2

    /// Arc-length window (world units) around an obstacle within which collision is checked.
    static let obstacleCollisionArcLength: Double = 28

    /// Lateral distance (world units) from an obstacle center that counts as a hit.
    static let obstacleCollisionLateralRadius: Double = 14

    // MARK: - Simulation loop

    /// Maximum `update` delta (seconds) to avoid spiral-of-death after a hitch.
    static let maxSimulationDeltaTime: TimeInterval = 1.0 / 30.0

    /// Arc length behind the car included in the visible rope window (points).
    static let ropeVisibleArcLengthBehind: Double = 300

    /// Arc length ahead of the car included in the visible rope window (points).
    static let ropeVisibleArcLengthAhead: Double = 700

    /// Polyline samples along the visible rope window.
    static let ropePathSampleCount: Int = 60

    /// Collect a ticket when the car is within this arc length of the pickup (points).
    static let ticketCollectionLookaheadArcLength: Double = 25

    // MARK: - Rope visuals (cosmetic; does not affect fall hitbox)

    /// Perpendicular sway amplitude for the drawn rope (points).
    static let ropeVisualSwayAmplitudePoints: Double = 3

    /// Sway oscillation frequency (Hz).
    static let ropeVisualSwayFrequencyHz: Double = 0.25

    /// Phase advance per arc-length unit along the rope (radians per point).
    static let ropeVisualSwayPhasePerArcLength: Double = 0.004

    /// Highlight stroke width as a fraction of the main rope width.
    static let ropeHighlightLineWidthFactor: Double = 0.18

    /// Extra width added to the underlay stroke beyond the main rope width (points).
    static let ropeUnderlayWidthPadding: Double = 6

    /// Underlay stroke opacity (main stroke uses full opacity).
    static let ropeUnderlayStrokeOpacity: Double = 0.55

    /// Start a new rope micro-segment when width changes by more than this (points).
    static let ropeVisualWidthChangeThreshold: Double = 1

    /// Scales the centrifugal lateral drift from path curvature.
    /// 1.0 = physically accurate v²κ; increase for more demanding steering.
    static let curvatureDriftStrength: Double = 1.0

    static func ropeHalfWidth(at ropeWidth: Double) -> Double {
        (ropeWidth / 2) * lateralFallThresholdOfHalfWidth
    }
}
