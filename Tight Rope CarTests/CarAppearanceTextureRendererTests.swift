//
//  CarAppearanceTextureRendererTests.swift
//  Tight Rope CarTests
//

import SpriteKit
import Testing
@testable import Tight_Rope_Car

struct CarAppearanceTextureRendererTests {

    @Test @MainActor func rendersDefaultAppearanceTexture() {
        let texture = CarAppearanceTextureRenderer.texture(for: .default)
        #expect(texture.size().width > 0)
        #expect(texture.size().height > 0)
    }

    @Test @MainActor func rendersRaceCarSilhouetteTexture() {
        let appearance = CarDesign.raceCar.appearance
        let texture = CarAppearanceTextureRenderer.texture(for: appearance)
        #expect(texture.size().width > 0)
        #expect(texture.size().height > 0)
    }

    @Test func cacheKeyDiffersBySilhouette() {
        let classic = CarAppearanceTextureRenderer.cacheKey(for: CarDesign.classicBug.appearance)
        let race = CarAppearanceTextureRenderer.cacheKey(for: CarDesign.raceCar.appearance)
        #expect(classic != race)
    }
}
