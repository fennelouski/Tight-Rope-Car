//
//  WindParameters.swift
//  Tight Rope Car
//

import Foundation

/// Named wind presets and tunable lateral-force parameters (README v0.2 gusts).
enum WindProfile: String, Codable, Sendable, CaseIterable {
    case calm
    case alley
    case gusty
    case fierce

    /// Lateral-force parameters; `nil` when calm.
    var parameters: WindParameters? {
        switch self {
        case .calm:
            return nil
        case .alley:
            return WindParameters(
                steadyAmplitude: 22,
                gustAmplitude: 38,
                basePeriodSeconds: 4.8,
                gustHarmonic: 2.4
            )
        case .gusty:
            return WindParameters(
                steadyAmplitude: 30,
                gustAmplitude: 52,
                basePeriodSeconds: 4.2,
                gustHarmonic: 2.8
            )
        case .fierce:
            return WindParameters(
                steadyAmplitude: 38,
                gustAmplitude: 72,
                basePeriodSeconds: 3.6,
                gustHarmonic: 3.2
            )
        }
    }
}

/// Periodic steady wind plus pulsing gust envelope (lateral acceleration, points/s²).
struct WindParameters: Codable, Sendable, Equatable {
    let steadyAmplitude: Double
    let gustAmplitude: Double
    let basePeriodSeconds: Double
    /// Multiplier on the base phase for the gust envelope frequency.
    let gustHarmonic: Double

    init(
        steadyAmplitude: Double,
        gustAmplitude: Double,
        basePeriodSeconds: Double,
        gustHarmonic: Double = 2.5
    ) {
        self.steadyAmplitude = steadyAmplitude
        self.gustAmplitude = gustAmplitude
        self.basePeriodSeconds = max(0.5, basePeriodSeconds)
        self.gustHarmonic = max(1, gustHarmonic)
    }
}
