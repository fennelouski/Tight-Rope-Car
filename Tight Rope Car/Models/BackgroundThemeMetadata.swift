//
//  BackgroundThemeMetadata.swift
//  Tight Rope Car
//

import Foundation

/// One parallax slice for a background theme (SpriteKit texture + scroll speed).
struct ParallaxLayerSpec: Codable, Equatable, Sendable {
    /// Asset catalog / texture name, e.g. `bg_ocean_far`.
    let assetName: String
    /// Scroll multiplier relative to camera; 0 = distant/slow, 1 = near/fast.
    let scrollFactor: Double
    /// Draw order; higher values render in front.
    let zIndex: Int?

    init(assetName: String, scrollFactor: Double, zIndex: Int? = nil) {
        self.assetName = assetName
        self.scrollFactor = scrollFactor
        self.zIndex = zIndex
    }
}

/// Full visual and audio configuration for a ``BackgroundTheme``.
struct BackgroundThemeMetadata: Codable, Equatable, Sendable {
    let theme: BackgroundTheme
    let displayName: String
    /// Short line for level-select cards.
    let tagline: String
    /// Sky colors from top to bottom.
    let skyGradient: [ThemeColor]
    let groundColor: ThemeColor
    let parallaxLayers: [ParallaxLayerSpec]
    /// Ambient loop file name without extension; `nil` until audio assets exist.
    let ambienceSoundName: String?
    /// Level-select ordering (lower appears first).
    let sortOrder: Int

    /// Far parallax strip used for gallery list thumbnails.
    var galleryThumbnailAssetName: String {
        if let farLayer = parallaxLayers.first(where: { $0.assetName.hasSuffix("_far") }) {
            return farLayer.assetName
        }
        let sorted = parallaxLayers.sorted { ($0.zIndex ?? 0) < ($1.zIndex ?? 0) }
        return sorted.first?.assetName ?? ""
    }
}
