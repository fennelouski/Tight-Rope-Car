//
//  CarAppearance.swift
//  Tight Rope Car
//
//  Created by Nathan Fennel on 5/22/26.
//

import SwiftUI

/// Visual configuration for a car (colors, scale, silhouette). No position or tilt.
struct CarAppearance: Equatable {
    var bodyColor: Color
    var accentColor: Color
    /// Multiplier applied to the car's drawn size.
    var scale: CGFloat
    var silhouette: CarSilhouette
    /// Width relative to default body width (1 = default).
    var bodyAspectRatio: CGFloat
    /// Horizontal gap between wheels relative to default spacing.
    var wheelSpacingMultiplier: CGFloat
    /// Wheel diameter relative to default for this frame size.
    var wheelSizeMultiplier: CGFloat
    /// Procedural renderer tier; default v1 preserves existing drawing.
    var renderVersion: CarRenderVersion

    init(
        bodyColor: Color = .red,
        accentColor: Color = .black,
        scale: CGFloat = 1.0,
        silhouette: CarSilhouette = .classicBug,
        bodyAspectRatio: CGFloat = 1.0,
        wheelSpacingMultiplier: CGFloat = 1.0,
        wheelSizeMultiplier: CGFloat = 1.0,
        renderVersion: CarRenderVersion = .v1
    ) {
        self.bodyColor = bodyColor
        self.accentColor = accentColor
        self.scale = scale
        self.silhouette = silhouette
        self.bodyAspectRatio = bodyAspectRatio
        self.wheelSpacingMultiplier = wheelSpacingMultiplier
        self.wheelSizeMultiplier = wheelSizeMultiplier
        self.renderVersion = renderVersion
    }

    static let `default` = CarAppearance()
}
