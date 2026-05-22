#!/usr/bin/env swift
import CoreGraphics
import Foundation

// Mirror CourseSampler path segment logic for ropeBridge diagnostics.
enum CurveKind {
    case line
    case quadratic(control: CGPoint)
}

struct Waypoint {
    let position: CGPoint
    let curveToNext: CurveKind?
}

enum PathSegment {
    case line(start: CGPoint, end: CGPoint, length: Double)
    case quadratic(start: CGPoint, control: CGPoint, end: CGPoint, length: Double)

    init(start: CGPoint, end: CGPoint, curve: CurveKind) {
        switch curve {
        case .line:
            let length = start.distance(to: end)
            self = .line(start: start, end: end, length: length)
        case .quadratic(let control):
            let length = Self.measureQuadraticArcLength(start: start, control: control, end: end, samples: 24)
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
            let x = oneMinusT * oneMinusT * start.x + 2 * oneMinusT * clamped * control.x + clamped * clamped * end.x
            let y = oneMinusT * oneMinusT * start.y + 2 * oneMinusT * clamped * control.y + clamped * clamped * end.y
            return CGPoint(x: x, y: y)
        }
    }

    private static func measureQuadraticArcLength(
        start: CGPoint, control: CGPoint, end: CGPoint, samples: Int
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

extension CGPoint {
    func distance(to other: CGPoint) -> Double {
        let dx = Double(other.x - x)
        let dy = Double(other.y - y)
        return (dx * dx + dy * dy).squareRoot()
    }
}

let ropeBridge: [Waypoint] = [
    Waypoint(position: CGPoint(x: 0, y: 0), curveToNext: nil),
    Waypoint(position: CGPoint(x: 140, y: 22), curveToNext: .quadratic(control: CGPoint(x: 95, y: 42))),
    Waypoint(position: CGPoint(x: 280, y: 0), curveToNext: .quadratic(control: CGPoint(x: 210, y: -18))),
    Waypoint(position: CGPoint(x: 420, y: 28), curveToNext: .quadratic(control: CGPoint(x: 350, y: 48))),
    Waypoint(position: CGPoint(x: 560, y: 5), curveToNext: .quadratic(control: CGPoint(x: 490, y: -145))),
    Waypoint(position: CGPoint(x: 720, y: 32), curveToNext: .quadratic(control: CGPoint(x: 640, y: 52))),
    Waypoint(position: CGPoint(x: 880, y: 8), curveToNext: .quadratic(control: CGPoint(x: 800, y: -12))),
    Waypoint(position: CGPoint(x: 1020, y: 0), curveToNext: nil),
]

var segments: [PathSegment] = []
var cumulative: [Double] = [0]
for index in 0 ..< (ropeBridge.count - 1) {
    let start = ropeBridge[index]
    let end = ropeBridge[index + 1]
    let curve = start.curveToNext ?? .line
    let segment = PathSegment(start: start.position, end: end.position, curve: curve)
    segments.append(segment)
    cumulative.append(cumulative.last! + segment.arcLength)
}
let totalLength = cumulative.last!

func sample(at s: Double) -> CGPoint {
    var low = 0
    var high = segments.count - 1
    while low < high {
        let mid = (low + high + 1) / 2
        if cumulative[mid] <= s { low = mid } else { high = mid - 1 }
    }
    let localS = s - cumulative[low]
    let t = segments[low].arcLength > 0 ? localS / segments[low].arcLength : 0
    return segments[low].point(at: CGFloat(t))
}

let s58 = totalLength * 0.58
let p58 = sample(at: s58)
print(String(format: "totalLength=%.4f y@0.58=%.4f pass=%@", totalLength, p58.y, p58.y < -30 ? "YES" : "NO"))

var minY = Double.infinity
var minFrac = 0.0
for i in 0 ... 40 {
    let frac = Double(i) / 40
    let y = sample(at: totalLength * frac).y
    if y < minY { minY = y; minFrac = frac }
}
print(String(format: "minY=%.4f at frac %.3f", minY, minFrac))
