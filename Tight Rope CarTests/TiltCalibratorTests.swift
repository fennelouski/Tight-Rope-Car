//
//  TiltCalibratorTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct TiltCalibratorTests {

    @Test func requiresEnoughStableSamplesBeforeComplete() {
        var calibrator = TiltCalibrator(requiredSamples: 5, maxRollVariance: 0.001)
        for _ in 0 ..< 4 {
            calibrator.addSample(0.01)
        }
        #expect(!calibrator.isComplete)

        calibrator.addSample(0.012)
        #expect(calibrator.isComplete)
        #expect(abs(calibrator.neutralRollRadians - 0.0104) < 0.01)
    }

    @Test func unstableHoldDoesNotCompleteEarly() {
        var calibrator = TiltCalibrator(requiredSamples: 4, maxRollVariance: 0.0001)
        calibrator.addSample(0)
        calibrator.addSample(0.2)
        calibrator.addSample(0)
        calibrator.addSample(0.2)
        #expect(!calibrator.isComplete)
    }

    @Test func forceCompleteUsesFallbackWhenEmpty() {
        var calibrator = TiltCalibrator()
        calibrator.forceComplete(fallback: 0.08)
        #expect(calibrator.isComplete)
        #expect(calibrator.neutralRollRadians == 0.08)
    }

    @Test func progressTracksSampleCount() {
        var calibrator = TiltCalibrator(requiredSamples: 10, maxRollVariance: 1)
        #expect(calibrator.progress == 0)
        calibrator.addSample(0)
        #expect(calibrator.progress == 0.1)
    }
}
