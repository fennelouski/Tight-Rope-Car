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
}
