//
//  CourseColor.swift
//  Tight Rope Car
//

import Foundation

struct CourseColor: Codable, Sendable, Equatable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double

    init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    static let trackBlack = CourseColor(red: 0.1, green: 0.1, blue: 0.1)
    static let flameOrange = CourseColor(red: 1.0, green: 0.4, blue: 0.0)
    static let electricBlue = CourseColor(red: 0.0, green: 0.4, blue: 1.0)
    static let racingYellow = CourseColor(red: 1.0, green: 0.82, blue: 0.0)
    static let hotRed = CourseColor(red: 0.89, green: 0.09, blue: 0.22)
    static let ropeHighlightGray = CourseColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 0.9)
    static let skyTop = CourseColor(red: 0.05, green: 0.08, blue: 0.2)
    static let skyBottom = CourseColor(red: 0.2, green: 0.35, blue: 0.65)
}
