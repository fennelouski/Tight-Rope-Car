//
//  BalanceStabilityEvaluator.swift
//  Tight Rope Car
//

import Foundation

/// Pure Swift fall checks for rope balance (lateral offset + pitch).
enum BalanceStabilityEvaluator {
    /// Returns a fall reason when stability limits are exceeded, otherwise `nil`.
    static func fallReason(
        lateralOffset: Double,
        pitchRadians: Double,
        ropeHalfWidth: Double,
        maxPitchRadians: Double
    ) -> FallReason? {
        if isOffRope(lateralOffset: lateralOffset, ropeHalfWidth: ropeHalfWidth) {
            return .offRope
        }
        if hasExcessivePitch(pitchRadians: pitchRadians, maxPitchRadians: maxPitchRadians) {
            return .excessivePitch
        }
        return nil
    }

    /// Evaluates using rope width at arc length `s` from the course sampler.
    static func fallReason(
        lateralOffset: Double,
        pitchRadians: Double,
        arcLength s: Double,
        course: Course,
        sampler: CourseSampler
    ) -> FallReason? {
        let sample = sampler.sample(at: s)
        return fallReason(
            lateralOffset: lateralOffset,
            pitchRadians: pitchRadians,
            ropeHalfWidth: GameBalanceConstants.ropeHalfWidth(at: sample.ropeWidth),
            maxPitchRadians: course.maxPitchRadians
        )
    }

    static func isOffRope(lateralOffset: Double, ropeHalfWidth: Double) -> Bool {
        abs(lateralOffset) > ropeHalfWidth
    }

    static func hasExcessivePitch(pitchRadians: Double, maxPitchRadians: Double) -> Bool {
        let magnitude = abs(pitchRadians)
        if GameBalanceConstants.pitchFallUsesInclusiveLimit {
            return magnitude >= maxPitchRadians
        }
        return magnitude > maxPitchRadians
    }

    /// Normalized lateral position in [-1, 1] for HUD/debug (0 = centered).
    static func normalizedLateralOffset(_ lateralOffset: Double, ropeHalfWidth: Double) -> Double {
        guard ropeHalfWidth > 0 else { return 0 }
        return max(-1, min(1, lateralOffset / ropeHalfWidth))
    }

    /// Combined lateral/pitch usage where 1.0 is at the stability limit and values above 1.0 mean a fall.
    static func instabilitySeverity(
        lateralOffset: Double,
        pitchRadians: Double,
        ropeHalfWidth: Double,
        maxPitchRadians: Double
    ) -> Double {
        let lateralUsage = abs(lateralOffset) / max(ropeHalfWidth, 1e-9)
        let pitchUsage = abs(pitchRadians) / max(maxPitchRadians, 1e-9)
        return max(lateralUsage, pitchUsage)
    }

    /// True when the car is close to a fall but ``fallReason`` is still nil.
    static func isNearFall(
        severity: Double,
        threshold: Double = GameBalanceConstants.nearFallSeverityThreshold
    ) -> Bool {
        severity >= threshold && severity < 1
    }
}
