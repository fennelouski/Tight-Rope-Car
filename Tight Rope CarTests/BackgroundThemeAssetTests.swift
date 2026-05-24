//
//  BackgroundThemeAssetTests.swift
//  Tight Rope CarTests
//

import Testing
import UIKit
@testable import Tight_Rope_Car

struct BackgroundThemeAssetTests {

    @Test func catalogParallaxAssetsExistInBundle() {
        var assetNames: [String] = []
        for entry in BackgroundThemeCatalog.all {
            for layer in entry.parallaxLayers {
                assetNames.append(layer.assetName)
            }
        }
        #expect(assetNames.count == 24)

        for name in assetNames {
            let image = UIImage(named: name)
            #expect(image != nil, "Missing imageset or PNG for \(name)")
        }
    }

    @Test func galleryThumbnailAssetIsFarLayerAndExists() {
        for entry in BackgroundThemeCatalog.all {
            let name = entry.galleryThumbnailAssetName
            #expect(name.hasSuffix("_far"), "Expected far layer for \(entry.theme)")
            let image = UIImage(named: name)
            #expect(image != nil, "Missing gallery thumbnail for \(name)")
        }
    }

    @Test func oceanAmbienceClipIsBundled() {
        let metadata = BackgroundThemeCatalog.metadata(for: .ocean)
        #expect(metadata.ambienceSoundName == "ocean_waves")
        #expect(ThemeAmbiencePlayer.isSoundAvailable("ocean_waves"))
    }

    @Test func forestAmbienceClipIsBundled() {
        let metadata = BackgroundThemeCatalog.metadata(for: .forest)
        #expect(metadata.ambienceSoundName == "forest_birds")
        #expect(ThemeAmbiencePlayer.isSoundAvailable("forest_birds"))
    }

    @Test func cityAmbienceClipIsBundled() {
        let metadata = BackgroundThemeCatalog.metadata(for: .city)
        #expect(metadata.ambienceSoundName == "city_traffic")
        #expect(ThemeAmbiencePlayer.isSoundAvailable("city_traffic"))
    }

    @Test func toyShopAmbienceClipIsBundled() {
        let metadata = BackgroundThemeCatalog.metadata(for: .toyShop)
        #expect(metadata.ambienceSoundName == "toy_shop_chimes")
        #expect(ThemeAmbiencePlayer.isSoundAvailable("toy_shop_chimes"))
    }

    @Test func gardenAmbienceClipIsBundled() {
        let metadata = BackgroundThemeCatalog.metadata(for: .garden)
        #expect(metadata.ambienceSoundName == "garden_breeze")
        #expect(ThemeAmbiencePlayer.isSoundAvailable("garden_breeze"))
    }

    @Test func beachAmbienceClipIsBundled() {
        let metadata = BackgroundThemeCatalog.metadata(for: .beach)
        #expect(metadata.ambienceSoundName == "beach_waves")
        #expect(ThemeAmbiencePlayer.isSoundAvailable("beach_waves"))
    }

    @Test func everyCatalogAmbienceNameIsBundledWhenPresent() {
        for entry in BackgroundThemeCatalog.all {
            guard let soundName = entry.ambienceSoundName else { continue }
            #expect(
                ThemeAmbiencePlayer.isSoundAvailable(soundName),
                "Missing ambience clip for \(entry.theme): \(soundName)"
            )
        }
    }
}
