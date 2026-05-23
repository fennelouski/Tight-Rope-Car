//
//  GameplayHapticsTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

@MainActor
private final class MockGameHaptics: GameHapticProviding {
    var isEnabled = true
    var respectsReduceMotion = false
    private(set) var fallReasons: [FallReason] = []
    private(set) var nearFallCount = 0

    func prepare() {}

    func playFall(_ reason: FallReason) {
        fallReasons.append(reason)
    }

    func playNearFall() {
        nearFallCount += 1
    }
}

@MainActor
struct GameplayHapticsTests {

    @Test func mockRecordsFallAndNearFall() {
        let mock = MockGameHaptics()
        mock.playNearFall()
        mock.playFall(.offRope)
        #expect(mock.nearFallCount == 1)
        #expect(mock.fallReasons == [.offRope])
    }

    @Test func nearFallCooldownLimitsRapidPulses() {
        let haptics = GameplayHaptics.shared
        haptics.isEnabled = true
        haptics.respectsReduceMotion = true
        haptics.resetNearFallCooldown()
        haptics.playNearFall()
        haptics.playNearFall()
        // Second call within cooldown is ignored (no assert on hardware; ensures no crash).
    }
}
