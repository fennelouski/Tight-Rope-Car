//
//  ParallaxBackgroundPreviewScene.swift
//  Tight Rope Car
//

import SpriteKit

/// Demo scene that auto-scrolls the camera so parallax layers move in the simulator.
final class ParallaxBackgroundPreviewScene: SKScene {
    private var backgroundNode: GameBackgroundNode?
    private var scrollSpeed: CGFloat = 120
    private var cameraX: CGFloat = 0
    private var lastUpdateTime: TimeInterval?

    var previewTheme: BackgroundTheme = .ocean
    /// When false, parallax layers stay fixed (e.g. Reduce Motion during gameplay shell).
    var isScrollingEnabled = true

    override func didMove(to view: SKView) {
        backgroundColor = .black
        scaleMode = .resizeFill
        rebuildBackground()
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        rebuildBackground()
    }

    override func update(_ currentTime: TimeInterval) {
        guard isScrollingEnabled else { return }
        let dt: TimeInterval
        if let last = lastUpdateTime {
            dt = currentTime - last
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        guard dt > 0 else { return }
        cameraX += scrollSpeed * CGFloat(dt)
        backgroundNode?.setCameraX(cameraX)
    }

    func setTheme(_ theme: BackgroundTheme) {
        previewTheme = theme
        if view != nil {
            rebuildBackground()
            cameraX = 0
        }
    }

    private func rebuildBackground() {
        backgroundNode?.removeFromParent()
        let node = GameBackgroundNode(theme: previewTheme, layoutSize: size)
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(node)
        backgroundNode = node
        backgroundNode?.setCameraX(cameraX)
    }
}
