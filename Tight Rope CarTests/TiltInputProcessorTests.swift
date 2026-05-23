//
//  TiltInputProcessorTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct TiltInputProcessorTests {

    @Test func deadZoneSuppressesSmallRoll() {
        var processor = TiltInputProcessor(maxPitchRadians: .pi / 4)
        let dt = 1.0 / 60.0
        _ = processor.update(rawRoll: 0.03, dt: dt)
        #expect(processor.filteredTiltRadians == 0)
    }

    @Test func rollBeyondDeadZoneProducesLean() {
        var processor = TiltInputProcessor(maxPitchRadians: .pi / 4, smoothingWeight: 1)
        let tilt = processor.update(rawRoll: 0.2, dt: 1.0 / 60.0)
        #expect(tilt > 0.1)
    }

    @Test func neutralCalibrationCentersInput() {
        var processor = TiltInputProcessor(maxPitchRadians: .pi / 4, smoothingWeight: 1)
        processor.calibrateNeutral(using: 0.12)
        let tilt = processor.update(rawRoll: 0.12, dt: 1.0 / 60.0)
        #expect(abs(tilt) < 0.001)
    }

    @Test func pitchIsClampedToCourseLimit() {
        var processor = TiltInputProcessor(maxPitchRadians: 0.5, smoothingWeight: 1)
        let tilt = processor.update(rawRoll: 1.2, dt: 1.0 / 60.0)
        #expect(tilt == 0.5)
    }

    @Test func reduceMotionIgnoresDeviceRoll() {
        var processor = TiltInputProcessor(
            maxPitchRadians: .pi / 4,
            smoothingWeight: 0.5,
            reduceMotion: true
        )
        _ = processor.update(rawRoll: 0.4, dt: 1.0 / 60.0)
        #expect(processor.filteredTiltRadians == 0)
    }

    @Test func pausedInputDecaysWithoutNewSamples() {
        var processor = TiltInputProcessor(maxPitchRadians: .pi / 4, smoothingWeight: 0.5)
        _ = processor.update(rawRoll: 0.3, dt: 1.0 / 60.0)
        let before = processor.filteredTiltRadians
        processor.acceptsDeviceInput = false
        _ = processor.update(rawRoll: nil, dt: 1.0 / 60.0)
        #expect(processor.filteredTiltRadians < before)
    }

    @Test func simulatorProviderReturnsConfigurableRoll() {
        let provider = SimulatorTiltRollProvider()
        provider.rollRadians = 0.15
        #expect(provider.latestRollRadians == 0.15)
    }
}
