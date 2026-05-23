//
//  Car.swift
//  Tight Rope Car
//
//  Created by Nathan Fennel on 5/22/26.
//

import SwiftUI

/// Runtime game entity for a car on the tightrope.
struct Car: Identifiable, Equatable {
    let id: UUID
    /// Progress along the rope; 0 = start, 1 = end.
    var progressAlongRope: Double
    /// Lateral offset from rope center; negative = left, positive = right.
    var lateralOffset: Double
    /// Body tilt in radians; driven by filtered device roll or on-screen balance during gameplay (``GameplayTiltSession`` / ``TiltInputProcessor``).
    /// Applied to ``CarView`` rotation and ``GameScene`` car `zRotation` each frame.
    var tiltRadians: Double
    var appearance: CarAppearance

    var tiltAngle: Angle { .radians(tiltRadians) }

    init(
        id: UUID = UUID(),
        progressAlongRope: Double = 0,
        lateralOffset: Double = 0,
        tiltRadians: Double = 0,
        appearance: CarAppearance = .default
    ) {
        self.id = id
        self.progressAlongRope = progressAlongRope
        self.lateralOffset = lateralOffset
        self.tiltRadians = tiltRadians
        self.appearance = appearance
    }

    static let defaultCar = Car()

    static let preview = Car(
        lateralOffset: 0.25,
        tiltRadians: 0.35,
        appearance: CarAppearance(bodyColor: .blue, accentColor: .gray)
    )
}
