//
//  GameBackgroundNode.swift
//  Tight Rope Car
//

import SpriteKit
#if canImport(UIKit)
import UIKit
#endif

/// Behind-the-car background: sky gradient and ground plane.
/// Horizontal parallax layers are removed for the perspective view.
/// Forward-motion parallax (side-rush) is a future enhancement.
final class GameBackgroundNode: SKNode {
    private let metadata: BackgroundThemeMetadata
    private let layoutSize: CGSize

    init(theme: BackgroundTheme, layoutSize: CGSize) {
        metadata = BackgroundThemeCatalog.metadata(for: theme)
        self.layoutSize = layoutSize
        super.init()
        build()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    /// Called each frame with current arc-length progress.
    /// Legacy horizontal-scroll API — kept for the preview scene; no-op in perspective mode.
    func setCameraX(_ x: CGFloat) { _ = x }

    /// Currently a no-op placeholder for future forward-parallax layers.
    func setForwardProgress(_ progressS: Double) {
        _ = progressS
    }

    // MARK: - Build

    private func build() {
        zPosition = -1000

        if let sky = makeSkyNode() {
            sky.zPosition = -30
            addChild(sky)
        }

        if let ground = makeGroundNode() {
            ground.zPosition = -20
            addChild(ground)
        }
    }

    private func makeSkyNode() -> SKSpriteNode? {
        guard metadata.skyGradient.count >= 2 else { return nil }
        #if canImport(UIKit)
        let top = metadata.skyGradient[0].uiColor
        let bottom = metadata.skyGradient[metadata.skyGradient.count - 1].uiColor
        let texture = Self.makeVerticalGradientTexture(
            size: CGSize(width: 4, height: max(layoutSize.height, 1)),
            top: top,
            bottom: bottom
        )
        let node = SKSpriteNode(texture: texture)
        node.size = layoutSize
        node.position = .zero
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return node
        #else
        return nil
        #endif
    }

    private func makeGroundNode() -> SKSpriteNode? {
        #if canImport(UIKit)
        let color = metadata.groundColor.uiColor
        let groundHeight = layoutSize.height * 0.38  // taller than before — covers bottom half
        let texture = Self.makeSolidTexture(
            size: CGSize(width: 4, height: max(groundHeight, 1)),
            color: color
        )
        let node = SKSpriteNode(texture: texture)
        node.size = CGSize(width: layoutSize.width, height: groundHeight)
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.position = CGPoint(x: 0, y: -layoutSize.height / 2)
        return node
        #else
        return nil
        #endif
    }

    #if canImport(UIKit)
    private static func makeVerticalGradientTexture(
        size: CGSize,
        top: UIColor,
        bottom: UIColor
    ) -> SKTexture {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            let colors = [top.cgColor, bottom.cgColor] as CFArray
            let space = CGColorSpaceCreateDeviceRGB()
            guard let gradient = CGGradient(
                colorsSpace: space,
                colors: colors,
                locations: [0, 1]
            ) else { return }
            context.cgContext.drawLinearGradient(
                gradient,
                start: .zero,
                end: CGPoint(x: 0, y: size.height),
                options: []
            )
        }
        let texture = SKTexture(image: image)
        texture.filteringMode = .nearest
        return texture
    }

    private static func makeSolidTexture(size: CGSize, color: UIColor) -> SKTexture {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        let texture = SKTexture(image: image)
        texture.filteringMode = .nearest
        return texture
    }
    #endif
}
