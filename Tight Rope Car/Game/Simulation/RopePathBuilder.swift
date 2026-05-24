//
//  RopePathBuilder.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

/// One drawable rope layer (underlay, main, or highlight) along a style/width span.
struct RopeVisualLayer: Sendable, Equatable {
    let path: CGPath
    let stroke: CourseColor
    let lineWidth: Double
    let strokeOpacity: Double
}

/// Pure rope polyline builder for SpriteKit; sway is cosmetic only.
enum RopePathBuilder {
    enum LayerKind: Sendable {
        case underlay
        case main
        case highlight
    }

    /// Builds drawable layers for the visible rope window around `progressS`.
    static func buildLayers(
        sampler: CourseSampler,
        progressS: Double,
        elapsedSeconds: Double,
        reduceMotion: Bool
    ) -> [RopeVisualLayer] {
        let startS = max(0, progressS - GameBalanceConstants.ropeVisibleArcLengthBehind)
        let endS = min(sampler.totalLength, progressS + GameBalanceConstants.ropeVisibleArcLengthAhead)
        guard endS > startS else { return [] }

        let stepCount = GameBalanceConstants.ropePathSampleCount
        let step = (endS - startS) / Double(stepCount)
        var points: [(s: Double, position: CGPoint, normal: CGVector, width: Double, style: CourseStyleSpan)] = []
        points.reserveCapacity(stepCount + 1)

        for index in 0 ... stepCount {
            let s = startS + Double(index) * step
            let sample = sampler.sample(at: s)
            let position = swayedPosition(
                sample: sample,
                arcLength: s,
                elapsedSeconds: elapsedSeconds,
                reduceMotion: reduceMotion
            )
            points.append((s, position, sample.normal, sample.ropeWidth, sample.style))
        }

        let microSegments = splitMicroSegments(points: points)
        var result: [RopeVisualLayer] = []
        for segment in microSegments {
            result.append(contentsOf: makeLayers(for: segment, kind: .underlay))
            result.append(contentsOf: makeLayers(for: segment, kind: .main))
            result.append(contentsOf: makeLayers(for: segment, kind: .highlight))
        }
        return result
    }

    // MARK: - Private

    private struct MicroSegment: Sendable {
        let points: [(position: CGPoint, width: Double, style: CourseStyleSpan)]
    }

    private static func swayedPosition(
        sample: RopeSample,
        arcLength: Double,
        elapsedSeconds: Double,
        reduceMotion: Bool
    ) -> CGPoint {
        guard !reduceMotion, GameBalanceConstants.ropeVisualSwayAmplitudePoints > 0 else {
            return sample.position
        }
        let phase = 2 * Double.pi * GameBalanceConstants.ropeVisualSwayFrequencyHz * elapsedSeconds
            + GameBalanceConstants.ropeVisualSwayPhasePerArcLength * arcLength
        let offset = GameBalanceConstants.ropeVisualSwayAmplitudePoints * sin(phase)
        return CGPoint(
            x: sample.position.x + CGFloat(offset) * sample.normal.dx,
            y: sample.position.y + CGFloat(offset) * sample.normal.dy
        )
    }

    private static func splitMicroSegments(
        points: [(s: Double, position: CGPoint, normal: CGVector, width: Double, style: CourseStyleSpan)]
    ) -> [MicroSegment] {
        guard let first = points.first else { return [] }
        var segments: [MicroSegment] = []
        var current: [(position: CGPoint, width: Double, style: CourseStyleSpan)] = [
            (first.position, first.width, first.style),
        ]

        for point in points.dropFirst() {
            let previous = current.last!
            let styleChanged = point.style.ropeStroke != previous.style.ropeStroke
            let widthChanged = abs(point.width - previous.width) > GameBalanceConstants.ropeVisualWidthChangeThreshold
            if styleChanged || widthChanged {
                segments.append(MicroSegment(points: current))
                current = [(point.position, point.width, point.style)]
            } else {
                current.append((point.position, point.width, point.style))
            }
        }
        if !current.isEmpty {
            segments.append(MicroSegment(points: current))
        }
        return segments
    }

    private static func makeLayers(for segment: MicroSegment, kind: LayerKind) -> [RopeVisualLayer] {
        guard segment.points.count >= 2 else { return [] }
        let path = path(from: segment.points.map(\.position))
        let style = segment.points[0].style
        let averageWidth = segment.points.map(\.width).reduce(0, +) / Double(segment.points.count)

        switch kind {
        case .underlay:
            return [
                RopeVisualLayer(
                    path: path,
                    stroke: style.ropeStroke,
                    lineWidth: averageWidth + GameBalanceConstants.ropeUnderlayWidthPadding,
                    strokeOpacity: GameBalanceConstants.ropeUnderlayStrokeOpacity
                ),
            ]
        case .main:
            return [
                RopeVisualLayer(
                    path: path,
                    stroke: style.ropeStroke,
                    lineWidth: averageWidth,
                    strokeOpacity: 1
                ),
            ]
        case .highlight:
            guard let highlight = style.ropeHighlight else { return [] }
            let highlightWidth = max(
                3,
                averageWidth * GameBalanceConstants.ropeHighlightLineWidthFactor
            )
            return [
                RopeVisualLayer(
                    path: path,
                    stroke: highlight,
                    lineWidth: highlightWidth,
                    strokeOpacity: 1
                ),
            ]
        }
    }

    private static func path(from positions: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        for (index, point) in positions.enumerated() {
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        return path
    }
}
