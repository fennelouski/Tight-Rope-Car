//
//  TicketPickupSKNode.swift
//  Tight Rope Car
//
//  SpriteKit counterpart to ``TicketPickupView`` — keep in sync with SwiftUI art.
//

import SpriteKit

enum TicketPickupSKNode {
    static func make() -> SKNode {
        let size = TicketPickupLayout.spriteKitSize
        let rect = CGRect(
            x: -size.width * 0.5,
            y: -size.height * 0.5,
            width: size.width,
            height: size.height
        )

        let body = SKShapeNode(rect: rect, cornerRadius: size.width * 0.14)
        body.fillColor = SKColor(red: 1.0, green: 0.82, blue: 0.0, alpha: 1.0)
        body.strokeColor = SKColor(red: 0.89, green: 0.09, blue: 0.22, alpha: 1.0)
        body.lineWidth = max(2, size.width * 0.07)

        let perforation = SKShapeNode()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: rect.minY + size.height * 0.18))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY - size.height * 0.18))
        perforation.path = path
        perforation.strokeColor = body.strokeColor
        perforation.lineWidth = max(1.5, size.width * 0.06)
        perforation.lineCap = .round

        let label = SKLabelNode(text: "T")
        label.fontName = "Avenir-Black"
        label.fontSize = size.width * 0.42
        label.fontColor = body.strokeColor
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: -size.height * 0.04)

        let container = SKNode()
        container.addChild(body)
        container.addChild(perforation)
        container.addChild(label)
        return container
    }
}
