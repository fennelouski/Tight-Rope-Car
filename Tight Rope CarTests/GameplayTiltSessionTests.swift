//
//  GameplayTiltSessionTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

@MainActor
struct GameplayTiltSessionTests {

    @Test func calibrationCommitStoresNeutralOffset() {
        let session = GameplayTiltSession()
        session.preferOnScreenBalance = true
        session.manualProvider.targetRollRadians = 0.11
        session.beginCalibration()

        for _ in 0 ..< GameBalanceConstants.calibrationRequiredSamples {
            session.ingestCalibrationSample()
        }

        #expect(session.isCalibrationComplete)
        session.commitCalibration()
        #expect(abs(session.neutralRollOffset - 0.11) < 0.001)
    }

    @Test func skipUsesFallbackRoll() {
        let session = GameplayTiltSession()
        session.beginCalibration()
        session.skipCalibration(using: 0.07)
        session.commitCalibration()
        #expect(session.neutralRollOffset == 0.07)
    }

    @Test func configureForAccessibilityEnablesOnSimulator() {
        let session = GameplayTiltSession()
        session.configureForAccessibility(reduceMotion: false, isSimulator: true)
        #expect(session.preferOnScreenBalance)
    }
}
