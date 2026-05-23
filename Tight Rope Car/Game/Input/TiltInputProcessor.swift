//
//  TiltInputProcessor.swift
//  Tight Rope Car
//

import Foundation

/// Filters device roll into a smoothed target lean angle for gameplay and stability checks.
struct TiltInputProcessor: Sendable {
    private(set) var filteredTiltRadians: Double = 0
    private(set) var neutralRollOffset: Double = 0

    var maxPitchRadians: Double
    var deadZoneRadians: Double
    var smoothingWeight: Double
    var acceptsDeviceInput: Bool
    var reduceMotion: Bool
    /// When true, manual balance input is honored even if ``reduceMotion`` is enabled.
    var onScreenBalanceActive: Bool

    init(
        maxPitchRadians: Double,
        deadZoneRadians: Double = GameBalanceConstants.tiltDeadZoneRadians,
        smoothingWeight: Double = GameBalanceConstants.tiltSmoothingNewSampleWeight,
        acceptsDeviceInput: Bool = true,
        reduceMotion: Bool = false,
        onScreenBalanceActive: Bool = false
    ) {
        self.maxPitchRadians = maxPitchRadians
        self.deadZoneRadians = deadZoneRadians
        self.smoothingWeight = smoothingWeight
        self.acceptsDeviceInput = acceptsDeviceInput
        self.reduceMotion = reduceMotion
        self.onScreenBalanceActive = onScreenBalanceActive
    }

    /// Updates filtered tilt from a raw roll sample; returns the new filtered value.
    mutating func update(rawRoll: Double?, dt: Double) -> Double {
        let weight = smoothingAlpha(for: dt)
        let target: Double

        if !acceptsDeviceInput {
            filteredTiltRadians *= 1 - weight
            return filteredTiltRadians
        }
        if reduceMotion && !onScreenBalanceActive {
            target = 0
        } else if let rawRoll {
            target = clampedTarget(from: rawRoll)
        } else {
            // No sample (paused input): decay toward neutral without new device data.
            filteredTiltRadians *= 1 - weight
            return filteredTiltRadians
        }

        filteredTiltRadians = filteredTiltRadians * (1 - weight) + target * weight
        return filteredTiltRadians
    }

    /// Stores the current roll as neutral (level) calibration offset for S5 wiring.
    mutating func calibrateNeutral(using rawRoll: Double) {
        neutralRollOffset = rawRoll
    }

    mutating func reset() {
        filteredTiltRadians = 0
        neutralRollOffset = 0
    }

    // MARK: - Private

    private func clampedTarget(from rawRoll: Double) -> Double {
        let centered = applyDeadZone(rawRoll - neutralRollOffset)
        return max(-maxPitchRadians, min(maxPitchRadians, centered))
    }

    private func applyDeadZone(_ roll: Double) -> Double {
        let magnitude = abs(roll)
        guard magnitude > deadZoneRadians else { return 0 }
        let sign = roll > 0 ? 1.0 : -1.0
        return sign * (magnitude - deadZoneRadians)
    }

    private func smoothingAlpha(for dt: Double) -> Double {
        guard dt > 0 else { return smoothingWeight }
        let frames = dt * GameBalanceConstants.tiltInputNominalHz
        let perFrame = smoothingWeight
        return 1 - pow(1 - perFrame, max(frames, 0))
    }
}
