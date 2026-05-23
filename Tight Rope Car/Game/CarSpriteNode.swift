//
//  CarSpriteNode.swift
//  Tight Rope Car
//

import SpriteKit
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// SpriteKit representation of a car, driven by `CarAppearance` colors and proportions.
final class CarSpriteNode: SKNode {
    init(appearance: CarAppearance) {
        let scale: CGFloat      = appearance.scale
        let baseW: CGFloat      = 72
        let baseH: CGFloat      = 26
        let w: CGFloat          = baseW * scale * appearance.bodyAspectRatio
        let h: CGFloat          = baseH * scale
        let wheelRadius: CGFloat = h * 0.38 * appearance.wheelSizeMultiplier
        let wheelSpread: CGFloat = w * 0.28 * appearance.wheelSpacingMultiplier

        #if canImport(UIKit)
        let bodyColor: SKColor   = UIColor(appearance.bodyColor)
        let accentColor: SKColor = UIColor(appearance.accentColor)
        #else
        let bodyColor: SKColor   = SKColor.red
        let accentColor: SKColor = SKColor.black
        #endif

        // Body centered on (0, 0) in node-local space
        let halfW = w * 0.5
        let halfH = h * 0.5
        let bodyNode = SKShapeNode(
            rect: CGRect(x: -halfW, y: -halfH, width: w, height: h),
            cornerRadius: h * 0.28
        )
        bodyNode.fillColor   = bodyColor
        bodyNode.strokeColor = accentColor
        bodyNode.lineWidth   = 1.5
        bodyNode.zPosition   = 1

        // Wheels hang below the body center
        let wheelY: CGFloat = -halfH - wheelRadius

        let frontWheel = SKShapeNode(circleOfRadius: wheelRadius)
        frontWheel.fillColor   = accentColor
        frontWheel.strokeColor = SKColor.clear
        frontWheel.position    = CGPoint(x: wheelSpread, y: wheelY)

        let rearWheel = SKShapeNode(circleOfRadius: wheelRadius)
        rearWheel.fillColor   = accentColor
        rearWheel.strokeColor = SKColor.clear
        rearWheel.position    = CGPoint(x: -wheelSpread, y: wheelY)

        super.init()
        addChild(bodyNode)
        addChild(frontWheel)
        addChild(rearWheel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}
