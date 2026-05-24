//
//  TicketPickupTextureRenderer.swift
//  Tight Rope Car
//

import SpriteKit
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Rasterizes ``TicketPickupView`` for SpriteKit; caches by accent color and reduce-motion.
enum TicketPickupTextureRenderer {
    /// @2x rasterization for crisp in-game sprites.
    static let renderScale: CGFloat = 2.0

    private static let cache = NSCache<NSString, SKTexture>()

    @MainActor
    static func texture(
        accentColor: Color = HotWheelsTheme.racingYellow,
        reduceMotion: Bool = false
    ) -> SKTexture {
        let key = cacheKey(accentColor: accentColor, reduceMotion: reduceMotion) as NSString
        if let cached = cache.object(forKey: key) {
            return cached
        }

        #if canImport(UIKit)
        let view = TicketPickupView(
            state: .available,
            accentColor: accentColor,
            displaySize: .standard,
            allowsMotionEffects: !reduceMotion
        )

        let renderer = ImageRenderer(content: view)
        renderer.scale = renderScale
        renderer.isOpaque = false

        guard let image = renderer.uiImage else {
            return fallbackTexture()
        }

        let texture = SKTexture(image: image)
        texture.filteringMode = SKTextureFilteringMode.linear
        cache.setObject(texture, forKey: key)
        return texture
        #else
        return SKTexture()
        #endif
    }

    @MainActor
    static func prewarm(
        accentColor: Color = HotWheelsTheme.racingYellow,
        reduceMotion: Bool = false
    ) {
        _ = texture(accentColor: accentColor, reduceMotion: reduceMotion)
    }

    static func cacheKey(accentColor: Color, reduceMotion: Bool) -> String {
        [
            rgbaComponents(accentColor),
            reduceMotion ? "rm1" : "rm0",
        ].joined(separator: "|")
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
