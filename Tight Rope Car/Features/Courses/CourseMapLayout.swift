//
//  CourseMapLayout.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

enum CourseMapLayout {
    static let minimumCanvasWidth: CGFloat = 340
    static let canvasHeight: CGFloat = 10_000

    /// Default canvas for previews and tests.
    static let canvasSize = CGSize(width: minimumCanvasWidth, height: canvasHeight)

    static func canvasSize(containerWidth: CGFloat) -> CGSize {
        CGSize(width: max(minimumCanvasWidth, containerWidth), height: canvasHeight)
    }

    static let nodeDiameter: CGFloat = 72

    static func positions(in canvasSize: CGSize) -> [String: CGPoint] {
        var result: [String: CGPoint] = [:]
        let insetX = nodeDiameter * 0.55
        let insetY = nodeDiameter * 0.45
        let width = canvasSize.width - insetX * 2
        let height = canvasSize.height - insetY * 2

        for node in CourseMapCatalog.nodes {
            let x = insetX + node.mapPosition.x * width
            let y = insetY + node.mapPosition.y * height
            result[node.courseID] = CGPoint(x: x, y: y)
        }
        return result
    }

    static func scrollOffsetToCenter(
        courseID: String,
        canvasSize: CGSize,
        viewportSize: CGSize,
        contentPadding: CGFloat = 0
    ) -> CGPoint? {
        guard let center = positions(in: canvasSize)[courseID] else { return nil }

        let contentWidth = canvasSize.width
        let contentHeight = canvasSize.height + contentPadding * 2

        let x = clamp(
            center.x - viewportSize.width / 2,
            min: 0,
            max: max(0, contentWidth - viewportSize.width)
        )
        let y = clamp(
            center.y + contentPadding - viewportSize.height / 2,
            min: 0,
            max: max(0, contentHeight - viewportSize.height)
        )

        return CGPoint(x: x, y: y)
    }

    private static func clamp(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        Swift.min(Swift.max(value, min), max)
    }
}
