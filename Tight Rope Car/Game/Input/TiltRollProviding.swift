//
//  TiltRollProviding.swift
//  Tight Rope Car
//

import Foundation

/// Device roll (gamma) in radians for balance input; injectable for tests and Simulator.
protocol TiltRollProviding: AnyObject, Sendable {
    /// Latest roll sample, or `nil` when no reading is available yet.
    var latestRollRadians: Double? { get }
    func start()
    func stop()
}

enum TiltInputFactory {
    /// Live device motion on hardware; zeroed fallback in Simulator or when motion is unavailable.
    static func makeDefaultProvider() -> TiltRollProviding {
        #if targetEnvironment(simulator)
        return SimulatorTiltRollProvider()
        #else
        return DeviceMotionTiltProvider()
        #endif
    }
}
