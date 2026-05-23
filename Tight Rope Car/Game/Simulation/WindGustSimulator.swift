//
//  WindGustSimulator.swift
//  Tight Rope Car
//

import Foundation

/// Testable periodic lateral wind force (advances with run time).
struct WindGustSimulator: Sendable {
    let parameters: WindParameters
    private(set) var elapsedTime: Double = 0

    init(parameters: WindParameters) {
        self.parameters = parameters
    }

    mutating func advance(by deltaTime: Double) {
        guard deltaTime > 0 else { return }
        elapsedTime += deltaTime
    }

    mutating func reset() {
        elapsedTime = 0
    }

    /// Instantaneous lateral acceleration from wind at the current time (points/s²).
    func lateralAcceleration() -> Double {
        let period = parameters.basePeriodSeconds
        guard period > 0 else { return 0 }
        let basePhase = (elapsedTime / period) * 2 * Double.pi
        let steady = parameters.steadyAmplitude * sin(basePhase)
        let gustPhase = basePhase * parameters.gustHarmonic
        let envelope = max(0, sin(gustPhase))
        let gust = parameters.gustAmplitude * envelope * cos(basePhase)
        return steady + gust
    }

    /// Peak magnitude for tuning/tests.
    var peakAccelerationMagnitude: Double {
        parameters.steadyAmplitude + parameters.gustAmplitude
    }
}
