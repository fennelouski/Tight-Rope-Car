//
//  ManualTiltRollProvider.swift
//  Tight Rope Car
//

import Foundation

/// Accessibility / Simulator tilt source driven by on-screen balance controls.
final class ManualTiltRollProvider: TiltRollProviding, @unchecked Sendable {
    var targetRollRadians: Double = 0

    var latestRollRadians: Double? { targetRollRadians }

    func start() {}

    func stop() {
        targetRollRadians = 0
    }

    func setRoll(_ radians: Double, maxMagnitude: Double) {
        targetRollRadians = max(-maxMagnitude, min(maxMagnitude, radians))
    }

    func nudge(left: Bool, step: Double, maxMagnitude: Double) {
        let delta = left ? -step : step
        setRoll(targetRollRadians + delta, maxMagnitude: maxMagnitude)
    }
}
