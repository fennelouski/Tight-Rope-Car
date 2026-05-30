//
//  CourseSampler.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

/// Samples position, tangent, and style along a course path by arc length `s`.
struct CourseSampler: Sendable {
    private let course: Course
    private let segments: [PathSegment]
    private let cumulativeLengths: [Double]
    private let startRopeWidths: [Double]

    let totalLength: Double

    init(course: Course) {
        self.course = course
        var builtSegments: [PathSegment] = []
        var lengths: [Double] = [0]
        var widths: [Double] = []
        var accumulated: Double = 0

        let waypoints = course.waypoints
        guard waypoints.count >= 2 else {
            self.segments = []
            self.cumulativeLengths = [0]
            self.startRopeWidths = []
            self.totalLength = 0
            return
        }

        for index in 0 ..< (waypoints.count - 1) {
            let start = waypoints[index]
            let end = waypoints[index + 1]
            let curve = start.curveToNext ?? .line
            let segment = PathSegment(
                start: start.position,
                end: end.position,
                curve: curve
            )
            builtSegments.append(segment)
            widths.append(start.ropeWidth ?? course.ropeWidth)
            accumulated += segment.arcLength
            lengths.append(accumulated)
        }

        self.segments = builtSegments
        self.cumulativeLengths = lengths
        self.startRopeWidths = widths
        self.totalLength = accumulated
    }

    /// Signed path curvature at arc-length `s` (radians per point).
    /// Positive = counterclockwise curve (appears rightward in perspective view).
    /// Negative = clockwise curve (appears leftward in perspective view).
    func curvature(at s: Double, epsilon: Double = 1.5) -> Double {
        let s0 = max(s - epsilon, 0)
        let s1 = min(s + epsilon, totalLength)
        guard s1 > s0 else { return 0 }
        var delta = Double(sample(at: s1).tangentAngle - sample(at: s0).tangentAngle)
        while delta >  .pi { delta -= 2 * .pi }
        while delta < -.pi { delta += 2 * .pi }
        return delta / (s1 - s0)
    }

    func isFinished(s: Double) -> Bool {
        s >= totalLength
    }

    func style(at s: Double) -> CourseStyleSpan {
        let clamped = clampS(s)
        if let span = course.styleSpans.reversed().first(where: { clamped >= $0.startS }) {
            return span
        }
        return course.styleSpans.first ?? defaultStyleSpan
    }

    func sample(at s: Double) -> RopeSample {
        let clamped = clampS(s)
        let progress = totalLength > 0 ? clamped / totalLength : 0
        let activeStyle = style(at: clamped)

        guard !segments.isEmpty else {
            let point = course.waypoints.first?.position ?? .zero
            return RopeSample(
                position: point,
                tangentAngle: 0,
                normal: CGVector(dx: 0, dy: 1),
                ropeWidth: course.ropeWidth,
                style: activeStyle,
                progress: progress
            )
        }

        if clamped <= 0 {
            return makeSample(
                segmentIndex: 0,
                localS: 0,
                globalS: 0,
                style: activeStyle,
                progress: progress
            )
        }

        if clamped >= totalLength {
            let lastIndex = segments.count - 1
            let lastSegment = segments[lastIndex]
            return makeSample(
                segmentIndex: lastIndex,
                localS: lastSegment.arcLength,
                globalS: totalLength,
                style: activeStyle,
                progress: 1
            )
        }

        let segmentIndex = segmentIndex(for: clamped)
        let segmentStart = cumulativeLengths[segmentIndex]
        let localS = clamped - segmentStart
        return makeSample(
            segmentIndex: segmentIndex,
            localS: localS,
            globalS: clamped,
            style: activeStyle,
            progress: progress
        )
    }

    // MARK: - Private

    private var defaultStyleSpan: CourseStyleSpan {
        CourseStyleSpan(
            startS: 0,
            endS: max(totalLength, 1),
            ropeStroke: .trackBlack,
            ropeHighlight: .ropeHighlightGray,
            skyGradient: nil
        )
    }

    private func clampS(_ s: Double) -> Double {
        min(max(s, 0), totalLength)
    }

    private func segmentIndex(for s: Double) -> Int {
        guard !segments.isEmpty else { return 0 }
        var low = 0
        var high = segments.count - 1
        while low < high {
            let mid = (low + high + 1) / 2
            if cumulativeLengths[mid] <= s {
                low = mid
            } else {
                high = mid - 1
            }
        }
        return low
    }

    private func makeSample(
        segmentIndex: Int,
        localS: Double,
        globalS: Double,
        style: CourseStyleSpan,
        progress: Double
    ) -> RopeSample {
        let segment = segments[segmentIndex]
        let t = segment.arcLength > 0 ? localS / segment.arcLength : 0
        let position = segment.point(at: t)
        let tangent = segment.tangent(at: t)
        let angle = atan2(tangent.dy, tangent.dx)
        let normal = unitNormal(from: tangent)
        let ropeWidth = startRopeWidths[segmentIndex]

        return RopeSample(
            position: position,
            tangentAngle: angle,
            normal: normal,
            ropeWidth: ropeWidth,
            style: style,
            progress: progress
        )
    }

    private func unitNormal(from tangent: CGVector) -> CGVector {
        let length = hypot(tangent.dx, tangent.dy)
        guard length > 1e-9 else {
            return CGVector(dx: 0, dy: 1)
        }
        return CGVector(dx: -tangent.dy / length, dy: tangent.dx / length)
    }
}

// MARK: - Path segments

private enum PathSegment {
    case line(start: CGPoint, end: CGPoint, length: Double)
    case quadratic(start: CGPoint, control: CGPoint, end: CGPoint, length: Double)

    init(start: CGPoint, end: CGPoint, curve: CurveKind) {
        switch curve {
        case .line:
            let length = start.distance(to: end)
            self = .line(start: start, end: end, length: length)
        case .quadratic(let control):
            let length = Self.measureQuadraticArcLength(
                start: start,
                control: control,
                end: end,
                samples: 24
            )
            self = .quadratic(start: start, control: control, end: end, length: length)
        }
    }

    var arcLength: Double {
        switch self {
        case .line(_, _, let length), .quadratic(_, _, _, let length):
            return length
        }
    }

    func point(at t: CGFloat) -> CGPoint {
        let clamped = CGFloat(min(max(Double(t), 0), 1))
        switch self {
        case .line(let start, let end, _):
            return CGPoint(
                x: start.x + (end.x - start.x) * clamped,
                y: start.y + (end.y - start.y) * clamped
            )
        case .quadratic(let start, let control, let end, _):
            let oneMinusT = 1 - clamped
            let x = oneMinusT * oneMinusT * start.x
                + 2 * oneMinusT * clamped * control.x
                + clamped * clamped * end.x
            let y = oneMinusT * oneMinusT * start.y
                + 2 * oneMinusT * clamped * control.y
                + clamped * clamped * end.y
            return CGPoint(x: x, y: y)
        }
    }

    func tangent(at t: CGFloat) -> CGVector {
        let clamped = CGFloat(min(max(Double(t), 0), 1))
        switch self {
        case .line(let start, let end, _):
            return CGVector(dx: end.x - start.x, dy: end.y - start.y)
        case .quadratic(let start, let control, let end, _):
            let dx = 2 * (1 - clamped) * (control.x - start.x) + 2 * clamped * (end.x - control.x)
            let dy = 2 * (1 - clamped) * (control.y - start.y) + 2 * clamped * (end.y - control.y)
            return CGVector(dx: dx, dy: dy)
        }
    }

    private static func measureQuadraticArcLength(
        start: CGPoint,
        control: CGPoint,
        end: CGPoint,
        samples: Int
    ) -> Double {
        guard samples > 0 else { return 0 }
        var length: Double = 0
        var previous = start
        for index in 1 ... samples {
            let t = CGFloat(index) / CGFloat(samples)
            let oneMinusT = 1 - t
            let point = CGPoint(
                x: oneMinusT * oneMinusT * start.x + 2 * oneMinusT * t * control.x + t * t * end.x,
                y: oneMinusT * oneMinusT * start.y + 2 * oneMinusT * t * control.y + t * t * end.y
            )
            length += previous.distance(to: point)
            previous = point
        }
        return length
    }
}

private extension CGPoint {
    func distance(to other: CGPoint) -> Double {
        let dx = Double(other.x - x)
        let dy = Double(other.y - y)
        return (dx * dx + dy * dy).squareRoot()
    }
}
