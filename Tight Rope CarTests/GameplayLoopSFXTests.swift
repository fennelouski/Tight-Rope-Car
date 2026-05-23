//
//  GameplayLoopSFXTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct GameplayLoopSFXTests {

    @Test func bundledEngineLoopExistsInAppBundle() {
        #expect(GameplayLoopSFXPlayer.isClipAvailable(GameplayLoopSFXPlayer.engineSoundName))
    }

    @Test @MainActor func playerStartAndStopDoesNotCrash() {
        let player = GameplayLoopSFXPlayer()
        player.playEngine(duckedForThemeAmbience: false)
        player.playEngine(duckedForThemeAmbience: true)
        player.stop()
        #expect(player.isEnginePlaying == false)
    }
}
