//
//  BackgroundTheme.swift
//  Tight Rope Car
//

import Foundation

/// Visual environment for a level's parallax background (sky, layers, ambience).
///
/// Levels will reference a ``BackgroundTheme`` by its ``rawValue`` when the ``Level`` model is added.
/// Rendering details live in ``BackgroundThemeMetadata`` via ``BackgroundThemeCatalog``.
enum BackgroundTheme: String, CaseIterable, Codable, Identifiable, Sendable {
    /// Open water, waves, and distant horizon.
    case ocean
    /// Trees, hills, and woodland silhouettes.
    case forest
    /// Skyline, buildings, and urban rooftops.
    case city
    /// Cozy room scale: furniture, toys, and soft indoor light.
    case bedroom
    /// Shelves of toys, bright signage, and playful clutter.
    case toyShop
    /// Pastel sweets, jars, and whimsical shop fronts.
    case candyShop
    /// Flowers, hedges, and sunny garden paths.
    case garden
    /// Sand, umbrellas, and shoreline details.
    case beach

    var id: String { rawValue }
}
