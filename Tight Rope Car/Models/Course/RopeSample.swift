//
//  RopeSample.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

struct RopeSample: Sendable, Equatable {
    let position: CGPoint
    let tangentAngle: CGFloat
    let normal: CGVector
    let ropeWidth: Double
    let style: CourseStyleSpan
    let progress: Double
}
