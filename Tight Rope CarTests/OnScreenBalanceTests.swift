//
//  OnScreenBalanceTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct OnScreenBalanceTests {

    @Test func manualProviderExposesTargetRoll() {
        let manual = ManualTiltRollProvider()
        manual.setRoll(0.2, maxMagnitude: 0.5)
        #expect(manual.latestRollRadians == 0.2)
        manual.nudge(left: true, step: 0.1, maxMagnitude: 0.5)
        #expect(manual.latestRollRadians == 0.1)
    }

    @Test func compositePrefersManualWhenEnabled() {
        let device = SimulatorTiltRollProvider()
        device.rollRadians = 0.5
        let manual = ManualTiltRollProvider()
        manual.targetRollRadians = -0.15
        let composite = CompositeTiltRollProvider(device: device, manual: manual)

        #expect(composite.latestRollRadians == 0.5)
        composite.preferManual = true
        #expect(composite.latestRollRadians == -0.15)
    }

    @Test func onScreenBalanceWorksWithReduceMotion() {
        var processor = TiltInputProcessor(
            maxPitchRadians: .pi / 4,
            smoothingWeight: 1,
            reduceMotion: true,
            onScreenBalanceActive: true
        )
        let tilt = processor.update(rawRoll: 0.18, dt: 1.0 / 60.0)
        #expect(tilt > 0.1)
    }

    @Test func reduceMotionWithoutOnScreenBalanceZerosTilt() {
        var processor = TiltInputProcessor(
            maxPitchRadians: .pi / 4,
            smoothingWeight: 1,
            reduceMotion: true,
            onScreenBalanceActive: false
        )
        let tilt = processor.update(rawRoll: 0.4, dt: 1.0 / 60.0)
        #expect(tilt == 0)
    }

    @Test @MainActor func sessionNudgeEnablesManualMode() {
        let session = GameplayTiltSession()
        #expect(!session.preferOnScreenBalance)
        session.nudgeOnScreenBalance(left: false, maxRoll: 0.4)
        #expect(session.preferOnScreenBalance)
        #expect(session.manualProvider.latestRollRadians == GameBalanceConstants.onScreenBalanceRollStep)
    }
}
