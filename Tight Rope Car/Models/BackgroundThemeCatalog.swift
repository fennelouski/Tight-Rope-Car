//
//  BackgroundThemeCatalog.swift
//  Tight Rope Car
//

import Foundation

/// Static registry of every ``BackgroundTheme`` and its rendering metadata.
enum BackgroundThemeCatalog {
    static let all: [BackgroundThemeMetadata] = [
        makeOcean(),
        makeForest(),
        makeCity(),
        makeBedroom(),
        makeToyShop(),
        makeCandyShop(),
        makeGarden(),
        makeBeach(),
    ]

    /// All themes sorted for level-select display.
    static var sortedForDisplay: [BackgroundThemeMetadata] {
        all.sorted { $0.sortOrder < $1.sortOrder }
    }

    /// Metadata for a single theme; precondition if the theme is missing from ``all``.
    static func metadata(for theme: BackgroundTheme) -> BackgroundThemeMetadata {
        guard let entry = all.first(where: { $0.theme == theme }) else {
            preconditionFailure("Missing catalog entry for \(theme.rawValue)")
        }
        return entry
    }

    // MARK: - Ocean

    private static func makeOcean() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .ocean,
            displayName: "Ocean",
            tagline: "Waves below, wide blue above",
            skyGradient: [
                ThemeColor(red: 0.45, green: 0.75, blue: 0.95),
                ThemeColor(red: 0.25, green: 0.55, blue: 0.85),
            ],
            groundColor: ThemeColor(red: 0.12, green: 0.35, blue: 0.55),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_ocean_far", scrollFactor: 0.15, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_ocean_mid", scrollFactor: 0.4, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_ocean_near", scrollFactor: 0.75, zIndex: 2),
            ],
            ambienceSoundName: "ocean_waves",
            sortOrder: 0
        )
    }

    // MARK: - Forest

    private static func makeForest() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .forest,
            displayName: "Forest",
            tagline: "Tall trees and rolling green hills",
            skyGradient: [
                ThemeColor(red: 0.55, green: 0.82, blue: 0.95),
                ThemeColor(red: 0.35, green: 0.65, blue: 0.88),
            ],
            groundColor: ThemeColor(red: 0.18, green: 0.42, blue: 0.22),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_forest_far", scrollFactor: 0.12, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_forest_mid", scrollFactor: 0.38, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_forest_near", scrollFactor: 0.7, zIndex: 2),
            ],
            ambienceSoundName: "forest_birds",
            sortOrder: 1
        )
    }

    // MARK: - City

    private static func makeCity() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .city,
            displayName: "City",
            tagline: "Skyscrapers and rooftop views",
            skyGradient: [
                ThemeColor(red: 0.5, green: 0.55, blue: 0.65),
                ThemeColor(red: 0.35, green: 0.4, blue: 0.5),
            ],
            groundColor: ThemeColor(red: 0.25, green: 0.28, blue: 0.32),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_city_far", scrollFactor: 0.1, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_city_mid", scrollFactor: 0.35, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_city_near", scrollFactor: 0.72, zIndex: 2),
            ],
            ambienceSoundName: "city_traffic",
            sortOrder: 2
        )
    }

    // MARK: - Bedroom

    private static func makeBedroom() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .bedroom,
            displayName: "Bedroom",
            tagline: "Cozy room at toy-car scale",
            skyGradient: [
                ThemeColor(red: 0.98, green: 0.92, blue: 0.88),
                ThemeColor(red: 0.92, green: 0.85, blue: 0.82),
            ],
            groundColor: ThemeColor(red: 0.75, green: 0.65, blue: 0.58),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_bedroom_far", scrollFactor: 0.18, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_bedroom_mid", scrollFactor: 0.42, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_bedroom_near", scrollFactor: 0.78, zIndex: 2),
            ],
            ambienceSoundName: nil,
            sortOrder: 3
        )
    }

    // MARK: - Toy Shop

    private static func makeToyShop() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .toyShop,
            displayName: "Toy Shop",
            tagline: "Shelves packed with colorful toys",
            skyGradient: [
                ThemeColor(red: 0.95, green: 0.88, blue: 0.75),
                ThemeColor(red: 0.88, green: 0.78, blue: 0.65),
            ],
            groundColor: ThemeColor(red: 0.55, green: 0.42, blue: 0.35),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_toyShop_far", scrollFactor: 0.14, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_toyShop_mid", scrollFactor: 0.4, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_toyShop_near", scrollFactor: 0.76, zIndex: 2),
            ],
            ambienceSoundName: "toy_shop_chimes",
            sortOrder: 4
        )
    }

    // MARK: - Candy Shop

    private static func makeCandyShop() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .candyShop,
            displayName: "Candy Shop",
            tagline: "Pastel sweets and striped awnings",
            skyGradient: [
                ThemeColor(red: 0.98, green: 0.85, blue: 0.92),
                ThemeColor(red: 0.92, green: 0.72, blue: 0.88),
            ],
            groundColor: ThemeColor(red: 0.72, green: 0.45, blue: 0.58),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_candyShop_far", scrollFactor: 0.16, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_candyShop_mid", scrollFactor: 0.41, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_candyShop_near", scrollFactor: 0.74, zIndex: 2),
            ],
            ambienceSoundName: nil,
            sortOrder: 5
        )
    }

    // MARK: - Garden

    private static func makeGarden() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .garden,
            displayName: "Garden",
            tagline: "Flowers, hedges, and sunny paths",
            skyGradient: [
                ThemeColor(red: 0.6, green: 0.88, blue: 0.98),
                ThemeColor(red: 0.45, green: 0.78, blue: 0.92),
            ],
            groundColor: ThemeColor(red: 0.28, green: 0.55, blue: 0.32),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_garden_far", scrollFactor: 0.13, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_garden_mid", scrollFactor: 0.37, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_garden_near", scrollFactor: 0.71, zIndex: 2),
            ],
            ambienceSoundName: "garden_breeze",
            sortOrder: 6
        )
    }

    // MARK: - Beach

    private static func makeBeach() -> BackgroundThemeMetadata {
        BackgroundThemeMetadata(
            theme: .beach,
            displayName: "Beach",
            tagline: "Sand, umbrellas, and sunny shore",
            skyGradient: [
                ThemeColor(red: 0.55, green: 0.85, blue: 0.98),
                ThemeColor(red: 0.4, green: 0.72, blue: 0.95),
            ],
            groundColor: ThemeColor(red: 0.92, green: 0.82, blue: 0.55),
            parallaxLayers: [
                ParallaxLayerSpec(assetName: "bg_beach_far", scrollFactor: 0.15, zIndex: 0),
                ParallaxLayerSpec(assetName: "bg_beach_mid", scrollFactor: 0.39, zIndex: 1),
                ParallaxLayerSpec(assetName: "bg_beach_near", scrollFactor: 0.73, zIndex: 2),
            ],
            ambienceSoundName: "beach_waves",
            sortOrder: 7
        )
    }
}
