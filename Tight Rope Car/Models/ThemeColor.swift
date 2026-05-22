//
//  ThemeColor.swift
//  Tight Rope Car
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// RGBA color stored in Codable metadata (sky gradients, ground tints).
///
/// Use ``swiftUIColor`` at the UI/SpriteKit boundary; keep catalog data free of `Color` in Codable payloads.
struct ThemeColor: Codable, Equatable, Sendable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double

    init(red: Double, green: Double, blue: Double, opacity: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    init(_ color: Color) {
        #if canImport(UIKit)
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        self.red = Double(r)
        self.green = Double(g)
        self.blue = Double(b)
        self.opacity = Double(a)
        #else
        self.red = 0
        self.green = 0
        self.blue = 0
        self.opacity = 1
        #endif
    }

    var swiftUIColor: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }

    #if canImport(UIKit)
    var uiColor: UIColor {
        UIColor(red: red, green: green, blue: blue, alpha: opacity)
    }
    #endif
}
