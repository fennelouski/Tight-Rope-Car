//
//  PerspectiveRopeRenderer.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation
import SpriteKit

/// Pseudo-3D "Mode 7" perspective road renderer for the behind-the-car gameplay view.
///
/// Replaces ``RopePathBuilder`` in ``GameScene``. Projects the rope path ahead of the car
/// into screen-space perspective: the rope narrows to a vanishing point at the horizon, and
/// curves in the path appear as road bends.
enum PerspectiveRopeRenderer {

    // MARK: - Tuning constants

    /// Controls how quickly the perspective scale falls off with depth.
    /// Higher = more dramatic vanishing point / steeper road.
    static let perspectiveStrength: CGFloat = 8.0

    /// Rope visual half-width at depth 0 (directly under car), as a fraction of screen half-width.
    static let ropeScreenWidthFraction: CGFloat = 0.13

    /// Number of look-ahead sample points used to build the road shape.
    static let sampleCount = 80

    // MARK: - Node building

    /// Returns SpriteKit nodes that draw the perspective rope.
    /// Add them to a container that is a child of the camera node.
    ///
    /// - Parameters:
    ///   - sampler: Course sampler for the active course.
    ///   - progressS: Current arc-length position (car's position).
    ///   - lateralOffset: Car's perpendicular offset from rope centre (positive = right).
    ///   - ropeHalfWidth: Fall-threshold half-width at the current sample.
    ///   - sceneSize: SpriteKit scene size for screen-space math.
    ///   - horizonY: Horizon Y in camera space (SpriteKit Y-up; typically above centre).
    ///   - bottomY: Nearest-depth Y in camera space (car level; typically below centre).
    static func buildNodes(
        sampler: CourseSampler,
        progressS: Double,
        lateralOffset: Double,
        ropeHalfWidth: Double,
        sceneSize: CGSize,
        horizonY: CGFloat,
        bottomY: CGFloat
    ) -> [SKNode] {
        guard sceneSize.width > 0, sceneSize.height > 0 else { return [] }

        let maxLookAhead = min(
            sampler.totalLength - progressS,
            Double(sceneSize.height) * 2.0
        )
        guard maxLookAhead > 0 else { return [] }

        let ropeScreenHalfW = sceneSize.width / 2 * ropeScreenWidthFraction
        let posScale = ropeScreenHalfW / CGFloat(ropeHalfWidth)
        let currentSample = sampler.sample(at: progressS)

        var leftPts: [CGPoint] = []
        var rightPts: [CGPoint] = []
        var centerPts: [CGPoint] = []
        leftPts.reserveCapacity(sampleCount)
        rightPts.reserveCapacity(sampleCount)
        centerPts.reserveCapacity(sampleCount)

        let style = currentSample.style

        for i in 0 ..< sampleCount {
            let d = Double(i) / Double(sampleCount - 1) * maxLookAhead
            let t = CGFloat(d / maxLookAhead)
            let future = sampler.sample(at: progressS + d)

            // Lateral deviation: how far the rope has drifted perpendicularly from current heading.
            let dx = future.position.x - currentSample.position.x
            let dy = future.position.y - currentSample.position.y
            let latDev = dx * currentSample.normal.dx + dy * currentSample.normal.dy

            // Perspective scale: 1 at depth 0 (car position), → 0 at the horizon.
            let ps = 1.0 / (1.0 + t * perspectiveStrength)

            let sy = horizonY + (bottomY - horizonY) * ps
            let sx = CGFloat(latDev) * ps * posScale
            let hw = ropeScreenHalfW * ps

            leftPts.append(CGPoint(x: sx - hw, y: sy))
            rightPts.append(CGPoint(x: sx + hw, y: sy))
            centerPts.append(CGPoint(x: sx, y: sy))
        }

        // Extend rope polygon below the car to the screen bottom so the road
        // doesn't appear to end at the car.
        if let firstLeft = leftPts.first, let firstRight = rightPts.first {
            let screenBottomY = -sceneSize.height / 2 - 2
            let sx0 = (firstLeft.x + firstRight.x) / 2
            let bottomExtHW = ropeScreenHalfW * 1.45
            let midExtY = (bottomY + screenBottomY) / 2
            let midExtHW = (ropeScreenHalfW + bottomExtHW) / 2

            leftPts.insert(CGPoint(x: sx0 - midExtHW, y: midExtY), at: 0)
            rightPts.insert(CGPoint(x: sx0 + midExtHW, y: midExtY), at: 0)
            centerPts.insert(CGPoint(x: sx0, y: midExtY), at: 0)

            leftPts.insert(CGPoint(x: sx0 - bottomExtHW, y: screenBottomY), at: 0)
            rightPts.insert(CGPoint(x: sx0 + bottomExtHW, y: screenBottomY), at: 0)
            centerPts.insert(CGPoint(x: sx0, y: screenBottomY), at: 0)
        }

        guard leftPts.count >= 2 else { return [] }

        var nodes: [SKNode] = []

        // Underlay: wider shadow beneath the rope.
        let underlayPath = filledPolygon(left: leftPts, right: rightPts, lateralExpand: 5)
        let underlayNode = SKShapeNode(path: underlayPath)
        underlayNode.fillColor = skColor(style.ropeStroke, opacity: GameBalanceConstants.ropeUnderlayStrokeOpacity)
        underlayNode.strokeColor = .clear
        nodes.append(underlayNode)

        // Main rope fill.
        let mainPath = filledPolygon(left: leftPts, right: rightPts, lateralExpand: 0)
        let mainNode = SKShapeNode(path: mainPath)
        mainNode.fillColor = skColor(style.ropeStroke, opacity: 1.0)
        mainNode.strokeColor = .clear
        nodes.append(mainNode)

        // Highlight stripe along the centre of the rope.
        if let highlight = style.ropeHighlight {
            let highlightPath = cgPath(from: centerPts)
            let highlightNode = SKShapeNode(path: highlightPath)
            highlightNode.strokeColor = skColor(highlight, opacity: 1.0)
            highlightNode.lineWidth = 2.5
            highlightNode.fillColor = .clear
            highlightNode.lineCap = .round
            nodes.append(highlightNode)
        }

        return nodes
    }

    // MARK: - Ticket position

    /// Projects a ticket at `ticketS` arc-length into screen space.
    /// Returns `nil` if the ticket is behind the car or beyond the look-ahead range.
    static func ticketScreenPosition(
        sampler: CourseSampler,
        progressS: Double,
        ticketS: Double,
        ropeHalfWidth: Double,
        sceneSize: CGSize,
        horizonY: CGFloat,
        bottomY: CGFloat
    ) -> CGPoint? {
        let d = ticketS - progressS
        guard d > 0 else { return nil }
        let maxLookAhead = min(sampler.totalLength - progressS, Double(sceneSize.height) * 2.0)
        guard d <= maxLookAhead else { return nil }

        let ropeScreenHalfW = sceneSize.width / 2 * ropeScreenWidthFraction
        let posScale = ropeScreenHalfW / CGFloat(ropeHalfWidth)
        let currentSample = sampler.sample(at: progressS)
        let ticketSample = sampler.sample(at: ticketS)

        let dx = ticketSample.position.x - currentSample.position.x
        let dy = ticketSample.position.y - currentSample.position.y
        let latDev = dx * currentSample.normal.dx + dy * currentSample.normal.dy

        let t = CGFloat(d / maxLookAhead)
        let ps = 1.0 / (1.0 + t * perspectiveStrength)

        return CGPoint(
            x: CGFloat(latDev) * ps * posScale,
            y: horizonY + (bottomY - horizonY) * ps
        )
    }

    // MARK: - Obstacle position

    /// Projects an obstacle at `obstacleFraction` of total arc-length with its own lateral offset into screen space.
    /// Returns position and perspective scale (use scale to size the obstacle node).
    /// Returns `nil` if the obstacle is behind the car or beyond look-ahead.
    static func obstacleScreenPosition(
        sampler: CourseSampler,
        progressS: Double,
        obstacleFraction: Double,
        obstacleLateralOffset: Double,
        ropeHalfWidth: Double,
        sceneSize: CGSize,
        horizonY: CGFloat,
        bottomY: CGFloat
    ) -> (position: CGPoint, scale: CGFloat)? {
        let obstacleS = obstacleFraction * sampler.totalLength
        let d = obstacleS - progressS
        guard d > 0 else { return nil }
        let maxLookAhead = min(sampler.totalLength - progressS, Double(sceneSize.height) * 2.0)
        guard d <= maxLookAhead else { return nil }

        let ropeScreenHalfW = sceneSize.width / 2 * ropeScreenWidthFraction
        let posScale = ropeScreenHalfW / CGFloat(ropeHalfWidth)
        let currentSample = sampler.sample(at: progressS)
        let futureSample = sampler.sample(at: obstacleS)

        let dx = futureSample.position.x - currentSample.position.x
        let dy = futureSample.position.y - currentSample.position.y
        let ropeLateralDev = dx * currentSample.normal.dx + dy * currentSample.normal.dy

        let t = CGFloat(d / maxLookAhead)
        let ps = 1.0 / (1.0 + t * perspectiveStrength)
        let totalLateralDev = ropeLateralDev + obstacleLateralOffset

        return (
            position: CGPoint(
                x: CGFloat(totalLateralDev) * ps * posScale,
                y: horizonY + (bottomY - horizonY) * ps
            ),
            scale: ps
        )
    }

    // MARK: - Helpers

    private static func filledPolygon(
        left: [CGPoint],
        right: [CGPoint],
        lateralExpand: CGFloat
    ) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: left[0].x - lateralExpand, y: left[0].y))
        for pt in left.dropFirst() {
            path.addLine(to: CGPoint(x: pt.x - lateralExpand, y: pt.y))
        }
        for pt in right.reversed() {
            path.addLine(to: CGPoint(x: pt.x + lateralExpand, y: pt.y))
        }
        path.closeSubpath()
        return path
    }

    private static func cgPath(from points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        for (i, pt) in points.enumerated() {
            i == 0 ? path.move(to: pt) : path.addLine(to: pt)
        }
        return path
    }

    private static func skColor(_ c: CourseColor, opacity: Double) -> SKColor {
        SKColor(
            red: CGFloat(c.red),
            green: CGFloat(c.green),
            blue: CGFloat(c.blue),
            alpha: CGFloat(c.alpha * opacity)
        )
    }
}
