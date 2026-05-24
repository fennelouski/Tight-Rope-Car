//
//  DeviceStillnessEvaluator.swift
//  Tight Rope Car
//

import Foundation

/// Pure stillness gate from user-acceleration magnitudes (testable without Core Motion).
struct DeviceStillnessEvaluator: Sendable {
    let accelerationThreshold: Double
    let requiredStillSamples: Int

    private(set) var consecutiveStillSamples: Int = 0

    init(
        accelerationThreshold: Double = GameBalanceConstants.landingStillnessAccelerationThreshold,
        requiredStillSamples: Int = GameBalanceConstants.landingStillnessRequiredSamples
    ) {
        self.accelerationThreshold = accelerationThreshold
        self.requiredStillSamples = requiredStillSamples
    }

    var isDeviceStill: Bool {
        consecutiveStillSamples >= requiredStillSamples
    }

    mutating func reset() {
        consecutiveStillSamples = 0
    }

    /// Records one sample; returns whether the device is considered still after this reading.
    @discardableResult
    mutating func record(accelerationMagnitude: Double) -> Bool {
        if accelerationMagnitude <= accelerationThreshold {
            consecutiveStillSamples += 1
        } else {
            consecutiveStillSamples = 0
        }
        return isDeviceStill
    }
}

enum DeviceStillnessSample {
    /// User-acceleration magnitude √(x² + y² + z²) in m/s².
    static func accelerationMagnitude(x: Double, y: Double, z: Double) -> Double {
        (x * x + y * y + z * z).squareRoot()
    }
}
