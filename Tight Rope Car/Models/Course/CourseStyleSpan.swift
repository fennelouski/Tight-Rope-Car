//
//  CourseStyleSpan.swift
//  Tight Rope Car
//

import Foundation

struct CourseStyleSpan: Codable, Sendable, Equatable {
    let startS: Double
    let endS: Double
    let ropeStroke: CourseColor
    let ropeHighlight: CourseColor?
    let skyGradient: [CourseColor]?

    func contains(s: Double) -> Bool {
        s >= startS && s < endS
    }
}
