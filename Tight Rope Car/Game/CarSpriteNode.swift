//
//  CarSpriteNode.swift
//  Tight Rope Car
//

import SpriteKit

/// SpriteKit car sprite rasterized from ``CarView`` (same art as the garage).
final class CarSpriteNode: SKNode {
    init(appearance: CarAppearance, texture: SKTexture) {
        let logicalSize = CarAppearanceTextureRenderer.artboardSize
        let scaledW = logicalSize.width * appearance.scale * appearance.bodyAspectRatio
        let scaledH = logicalSize.height * appearance.scale

        let spriteNode = SKSpriteNode(texture: texture, size: CGSize(width: scaledW, height: scaledH))
        spriteNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        spriteNode.zPosition = 1

        super.init()
        addChild(spriteNode)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
