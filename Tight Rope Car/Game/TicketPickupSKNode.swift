//
//  TicketPickupSKNode.swift
//  Tight Rope Car
//
//  SpriteKit pickup sprite rasterized from ``TicketPickupView``.
//

import SpriteKit

enum TicketPickupSKNode {
    static func make(texture: SKTexture) -> SKSpriteNode {
        let node = SKSpriteNode(texture: texture, size: TicketPickupLayout.spriteKitSize)
        node.anchorPoint = TicketPickupLayout.spriteKitAnchor
        return node
    }
}
