//
//  CourseWaypoint.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

struct CourseWaypoint: Codable, Sendable, Equatable {
    let position: CGPoint
    /// How the rope connects to the next waypoint; `nil` on the final point.
    let curveToNext: CurveKind?
    let ropeWidth: Double?

    init(position: CGPoint, curveToNext: CurveKind? = nil, ropeWidth: Double? = nil) {
        self.position = position
        self.curveToNext = curveToNext
        self.ropeWidth = ropeWidth
    }
}

enum CurveKind: Codable, Sendable, Equatable {
    case line
    case quadratic(control: CGPoint)
}
