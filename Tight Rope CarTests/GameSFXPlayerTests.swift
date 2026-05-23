//
//  GameSFXPlayerTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct GameSFXPlayerTests {

    @Test func bundledGameplaySFXExistInAppBundle() {
        for sfx in GameSFX.allCases {
            #expect(BundledAudioLocator.isAvailable(sfx.rawValue), "Missing \(sfx.rawValue) in bundle")
        }
    }

    @Test func ambienceStillResolvesAfterLocatorRefactor() {
        #expect(ThemeAmbiencePlayer.isSoundAvailable("ocean_waves"))
    }

    @Test @MainActor func playerDoesNotCrashWhenDisabled() {
        let player = GameSFXPlayer.shared
        player.isEnabled = false
        player.play(.fall)
        player.isEnabled = true
    }

    @Test @MainActor func playerAcceptsValidClip() {
        let player = GameSFXPlayer.shared
        player.play(.ticketPickup, volume: 0.5)
        #expect(BundledAudioLocator.url(forResource: GameSFX.ticketPickup.rawValue) != nil)
    }
}
