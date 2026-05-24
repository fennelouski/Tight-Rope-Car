//
//  DeviceStillnessEvaluatorTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct DeviceStillnessEvaluatorTests {

    @Test func flatAccelerationCountsAsStill() {
        let magnitude = DeviceStillnessSample.accelerationMagnitude(x: 0.01, y: 0.01, z: 0.01)
        #expect(magnitude < GameBalanceConstants.landingStillnessAccelerationThreshold)
    }

    @Test func requiresConsecutiveStillSamples() {
        var evaluator = DeviceStillnessEvaluator(
            accelerationThreshold: 0.05,
            requiredStillSamples: 5
        )
        for _ in 0 ..< 4 {
            let isStill = evaluator.record(accelerationMagnitude: 0.02)
            #expect(!isStill)
        }
        let becameStill = evaluator.record(accelerationMagnitude: 0.02)
        #expect(becameStill)
        #expect(evaluator.isDeviceStill)
    }

    @Test func movementResetsStillStreak() {
        var evaluator = DeviceStillnessEvaluator(
            accelerationThreshold: 0.05,
            requiredStillSamples: 3
        )
        evaluator.record(accelerationMagnitude: 0.01)
        evaluator.record(accelerationMagnitude: 0.01)
        #expect(!evaluator.isDeviceStill)
        evaluator.record(accelerationMagnitude: 0.5)
        #expect(!evaluator.isDeviceStill)
        evaluator.record(accelerationMagnitude: 0.01)
        evaluator.record(accelerationMagnitude: 0.01)
        #expect(!evaluator.isDeviceStill)
        let finalIsStill = evaluator.record(accelerationMagnitude: 0.01)
        #expect(finalIsStill)
    }

    @Test func oscillatingSamplesNeverBecomeStill() {
        var evaluator = DeviceStillnessEvaluator(
            accelerationThreshold: 0.05,
            requiredStillSamples: 4
        )
        for _ in 0 ..< 20 {
            evaluator.record(accelerationMagnitude: 0.01)
            evaluator.record(accelerationMagnitude: 0.4)
        }
        #expect(!evaluator.isDeviceStill)
    }

    @Test func resetClearsStreak() {
        var evaluator = DeviceStillnessEvaluator(requiredStillSamples: 2)
        evaluator.record(accelerationMagnitude: 0.01)
        evaluator.record(accelerationMagnitude: 0.01)
        #expect(evaluator.isDeviceStill)
        evaluator.reset()
        #expect(!evaluator.isDeviceStill)
    }
}
