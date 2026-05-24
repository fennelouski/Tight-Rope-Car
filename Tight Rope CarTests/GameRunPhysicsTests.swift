//
//  GameRunPhysicsTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct GameRunPhysicsTests {
    @Test func tiltIncreasesLateralVelocity() {
        var velocity = 0.0
        GameRunPhysics.integrateLateral(
            tiltRadians: 0.1,
            lateralVelocity: &velocity,
            windLateralAcceleration: 0,
            dt: 0.1
        )
        #expect(velocity > 0)
    }

    @Test func negativeTiltDecreasesLateralVelocity() {
        var velocity = 0.0
        GameRunPhysics.integrateLateral(
            tiltRadians: -0.1,
            lateralVelocity: &velocity,
            windLateralAcceleration: 0,
            dt: 0.1
        )
        #expect(velocity < 0)
    }

    @Test func dampingReducesVelocityOverTime() {
        var velocity = 50.0
        for _ in 0 ..< 120 {
            GameRunPhysics.integrateLateral(
                tiltRadians: 0,
                lateralVelocity: &velocity,
                windLateralAcceleration: 0,
                dt: 1.0 / 60.0
            )
        }
        #expect(abs(velocity) < 50)
    }

    @Test func windAccelerationAddsToVelocity() {
        var withWind = 0.0
        var withoutWind = 0.0
        GameRunPhysics.integrateLateral(
            tiltRadians: 0,
            lateralVelocity: &withWind,
            windLateralAcceleration: 40,
            dt: 0.05
        )
        GameRunPhysics.integrateLateral(
            tiltRadians: 0,
            lateralVelocity: &withoutWind,
            windLateralAcceleration: 0,
            dt: 0.05
        )
        #expect(withWind > withoutWind)
    }

    @Test func maxSimulationDeltaTimeMatchesSceneCap() {
        #expect(GameBalanceConstants.maxSimulationDeltaTime == 1.0 / 30.0)
    }
}
