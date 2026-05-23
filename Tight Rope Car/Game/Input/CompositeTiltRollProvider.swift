//
//  CompositeTiltRollProvider.swift
//  Tight Rope Car
//

import Foundation

/// Routes tilt reads to device motion or manual on-screen balance.
final class CompositeTiltRollProvider: TiltRollProviding, @unchecked Sendable {
    let device: TiltRollProviding
    let manual: ManualTiltRollProvider
    var preferManual: Bool = false

    init(device: TiltRollProviding, manual: ManualTiltRollProvider) {
        self.device = device
        self.manual = manual
    }

    var latestRollRadians: Double? {
        if preferManual {
            return manual.latestRollRadians
        }
        return device.latestRollRadians
    }

    func start() {
        device.start()
    }

    func stop() {
        device.stop()
        manual.stop()
    }
}
