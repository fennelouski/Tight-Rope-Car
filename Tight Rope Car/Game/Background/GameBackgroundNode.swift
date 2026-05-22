//
//  GameBackgroundNode.swift
//  Tight Rope Car
//

import SpriteKit
#if canImport(UIKit)
import UIKit
#endif

/// Side-view parallax background: sky gradient, ground band, and catalog parallax layers.
final class GameBackgroundNode: SKNode {
    private let metadata: BackgroundThemeMetadata
    private let layoutSize: CGSize
    private var tilingLayers: [TilingParallaxLayer] = []
    private var cameraX: CGFloat = 0

    init(theme: BackgroundTheme, layoutSize: CGSize) {
        metadata = BackgroundThemeCatalog.metadata(for: theme)
        self.layoutSize = layoutSize
        super.init()
        build()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    /// Horizontal camera position (world units); layers scroll by ``ParallaxLayerSpec.scrollFactor``.
    func setCameraX(_ x: CGFloat) {
        cameraX = x
        for layer in tilingLayers {
            layer.update(cameraX: x)
        }
    }

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

        let sorted = metadata.parallaxLayers.sorted {
            ($0.zIndex ?? 0) < ($1.zIndex ?? 0)
        }

        for spec in sorted {
            let layer = TilingParallaxLayer(spec: spec, layoutSize: layoutSize)
            tilingLayers.append(layer)
            addChild(layer)
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
        let groundHeight = layoutSize.height * 0.22
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

// MARK: - Tiling layer

/// One parallax strip with horizontal tiling for infinite scroll.
final class TilingParallaxLayer: SKNode {
    private let scrollFactor: CGFloat
    private let tileWidth: CGFloat
    private let spriteA: SKSpriteNode
    private let spriteB: SKSpriteNode

    init(spec: ParallaxLayerSpec, layoutSize: CGSize) {
        scrollFactor = CGFloat(spec.scrollFactor)
        let texture = SKTexture(imageNamed: spec.assetName)
        texture.filteringMode = .linear

        let native = texture.size()
        let scale = layoutSize.height / max(native.height, 1)
        let displaySize = CGSize(width: native.width * scale, height: layoutSize.height)
        tileWidth = displaySize.width

        spriteA = SKSpriteNode(texture: texture, size: displaySize)
        spriteB = SKSpriteNode(texture: texture, size: displaySize)
        spriteA.anchorPoint = CGPoint(x: 0, y: 0.5)
        spriteB.anchorPoint = CGPoint(x: 0, y: 0.5)
        spriteA.position = CGPoint(x: -tileWidth / 2, y: 0)
        spriteB.position = CGPoint(x: -tileWidth / 2 + tileWidth, y: 0)

        super.init()

        zPosition = CGFloat(spec.zIndex ?? 0)
        addChild(spriteA)
        addChild(spriteB)
        update(cameraX: 0)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func update(cameraX: CGFloat) {
        let offset = -cameraX * scrollFactor
        let wrapped = Self.wrap(offset, period: tileWidth)
        position.x = wrapped
    }

    private static func wrap(_ value: CGFloat, period: CGFloat) -> CGFloat {
        guard period > 0 else { return value }
        var result = value.truncatingRemainder(dividingBy: period)
        if result > 0 { result -= period }
        return result
    }
}
