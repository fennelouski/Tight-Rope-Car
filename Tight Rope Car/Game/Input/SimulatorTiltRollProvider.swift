//
//  SimulatorTiltRollProvider.swift
//  Tight Rope Car
//

import Foundation

/// Simulator-safe tilt source (defaults to level). Tests can subclass or replace `rollRadians`.
final class SimulatorTiltRollProvider: TiltRollProviding, @unchecked Sendable {
    var rollRadians: Double = 0

    var latestRollRadians: Double? { rollRadians }

    func start() {}
    func stop() {}
}
