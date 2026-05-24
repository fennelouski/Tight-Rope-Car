//
//  GameRunPhysics.swift
//  Tight Rope Car
//

import Foundation

/// Pure lateral motion integration shared by ``GameScene`` and unit tests.
enum GameRunPhysics {
    /// Integrates filtered tilt and wind into lateral velocity for one timestep.
    static func integrateLateral(
        tiltRadians: Double,
        lateralVelocity: inout Double,
        windLateralAcceleration: Double,
        dt: Double
    ) {
        lateralVelocity += tiltRadians * GameBalanceConstants.lateralAccelerationFromTilt * dt
        lateralVelocity += windLateralAcceleration * dt
        lateralVelocity *= pow(
            GameBalanceConstants.lateralVelocityDampingPerFrame,
            dt * GameBalanceConstants.tiltInputNominalHz
        )
    }
}
