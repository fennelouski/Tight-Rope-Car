//
//  CarAppearanceTextureRenderer.swift
//  Tight Rope Car
//

import SpriteKit
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Rasterizes ``CarView`` for SpriteKit; caches by full ``CarAppearance``.
enum CarAppearanceTextureRenderer {
    /// Logical artboard size (points) before render scale.
    static let artboardSize = CGSize(width: 120, height: 60)

    /// @2x rasterization for crisp in-game sprites.
    static let renderScale: CGFloat = 2.0

    private static let cache = NSCache<NSString, SKTexture>()

    @MainActor
    static func texture(for appearance: CarAppearance) -> SKTexture {
        let key = cacheKey(for: appearance) as NSString
        if let cached = cache.object(forKey: key) {
            return cached
        }

        #if canImport(UIKit)
        let car = Car(appearance: appearance)
        let view = CarView(car: car, size: artboardSize)
        let renderer = ImageRenderer(content: view)
        renderer.scale = renderScale
        renderer.isOpaque = false

        guard let image = renderer.uiImage else {
            return fallbackTexture()
        }

        let texture = SKTexture(image: image)
        texture.filteringMode = .linear
        cache.setObject(texture, forKey: key)
        return texture
        #else
        return SKTexture()
        #endif
    }

    @MainActor
    static func prewarm(appearance: CarAppearance) {
        _ = texture(for: appearance)
    }

    static func cacheKey(for appearance: CarAppearance) -> String {
        let body = rgbaComponents(appearance.bodyColor)
        let accent = rgbaComponents(appearance.accentColor)
        return [
            silhouetteKey(appearance.silhouette),
            body,
            accent,
            String(format: "%.3f", appearance.scale),
            String(format: "%.3f", appearance.bodyAspectRatio),
            String(format: "%.3f", appearance.wheelSpacingMultiplier),
            String(format: "%.3f", appearance.wheelSizeMultiplier),
        ].joined(separator: "|")
    }

    private static func silhouetteKey(_ silhouette: CarSilhouette) -> String {
        switch silhouette {
        case .classicBug: "classicBug"
        case .pickup: "pickup"
        case .sports: "sports"
        case .van: "van"
        case .micro: "micro"
        case .convertible: "convertible"
        case .suv: "suv"
        case .raceCar: "raceCar"
        case .iceCreamTruck: "iceCreamTruck"
        case .taxi: "taxi"
        case .fireTruck: "fireTruck"
        case .schoolBus: "schoolBus"
        case .policeCar: "policeCar"
        case .ambulance: "ambulance"
        case .motorcycle: "motorcycle"
        }
    }

    private static func fallbackTexture() -> SKTexture {
        let size = CGSize(width: 4, height: 4)
        #if canImport(UIKit)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { ctx in
            UIColor.clear.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
        }
        return SKTexture(image: image)
        #else
        return SKTexture()
        #endif
    }

    private static func rgbaComponents(_ color: Color) -> String {
        #if canImport(UIKit)
        let ui = UIColor(color)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        ui.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "%.3f,%.3f,%.3f,%.3f", r, g, b, a)
        #else
        return "0,0,0,1"
        #endif
    }
}
