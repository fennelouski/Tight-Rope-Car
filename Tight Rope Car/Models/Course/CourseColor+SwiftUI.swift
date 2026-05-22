//
//  CourseColor+SwiftUI.swift
//  Tight Rope Car
//

import SwiftUI

extension CourseColor {
    var swiftUIColor: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension HotWheelsTheme {
    static func courseColor(_ color: CourseColor) -> Color {
        color.swiftUIColor
    }
}
