//
//  CarSpriteNode.swift
//  Tight Rope Car
//

import SpriteKit

/// SpriteKit car sprite rasterized from a ``CarView`` or ``RearViewCarView``.
final class CarSpriteNode: SKNode {
    init(
        appearance: CarAppearance,
        texture: SKTexture,
        artboardSize: CGSize = CarAppearanceTextureRenderer.artboardSize,
        anchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)
    ) {
        let scaledW = artboardSize.width * appearance.scale * appearance.bodyAspectRatio
        let scaledH = artboardSize.height * appearance.scale

        let spriteNode = SKSpriteNode(texture: texture, size: CGSize(width: scaledW, height: scaledH))
        spriteNode.anchorPoint = anchorPoint
        spriteNode.zPosition = 1

        super.init()
        addChild(spriteNode)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
