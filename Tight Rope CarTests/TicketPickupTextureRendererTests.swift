//
//  TicketPickupTextureRendererTests.swift
//  Tight Rope CarTests
//

import SpriteKit
import SwiftUI
import Testing
@testable import Tight_Rope_Car

struct TicketPickupTextureRendererTests {

    @Test @MainActor func rendersAvailableTexture() {
        let texture = TicketPickupTextureRenderer.texture()
        #expect(texture.size().width > 0)
        #expect(texture.size().height > 0)
    }

    @Test func cacheKeyDiffersByAccent() {
        let yellow = TicketPickupTextureRenderer.cacheKey(
            accentColor: HotWheelsTheme.racingYellow,
            reduceMotion: false
        )
        let red = TicketPickupTextureRenderer.cacheKey(
            accentColor: HotWheelsTheme.hotRed,
            reduceMotion: false
        )
        #expect(yellow != red)
    }

    @Test func cacheKeyDiffersWhenReduceMotionChanges() {
        let motionOn = TicketPickupTextureRenderer.cacheKey(
            accentColor: HotWheelsTheme.racingYellow,
            reduceMotion: false
        )
        let motionOff = TicketPickupTextureRenderer.cacheKey(
            accentColor: HotWheelsTheme.racingYellow,
            reduceMotion: true
        )
        #expect(motionOn != motionOff)
    }
}
