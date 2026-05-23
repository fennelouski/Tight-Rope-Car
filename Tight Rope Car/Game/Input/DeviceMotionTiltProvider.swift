//
//  DeviceMotionTiltProvider.swift
//  Tight Rope Car
//

import Foundation
#if canImport(CoreMotion)
import CoreMotion
#endif

/// Reads device attitude roll via `CMMotionManager` on the main queue.
final class DeviceMotionTiltProvider: TiltRollProviding, @unchecked Sendable {
    #if canImport(CoreMotion)
    private let motionManager = CMMotionManager()
    #endif
    private let lock = NSLock()
    private var storedRoll: Double?

    var latestRollRadians: Double? {
        lock.lock()
        defer { lock.unlock() }
        return storedRoll
    }

    func start() {
        #if canImport(CoreMotion)
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0 / GameBalanceConstants.tiltInputNominalHz
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self, let motion else { return }
            self.lock.lock()
            self.storedRoll = motion.attitude.roll
            self.lock.unlock()
        }
        #endif
    }

    func stop() {
        #if canImport(CoreMotion)
        motionManager.stopDeviceMotionUpdates()
        #endif
        lock.lock()
        storedRoll = nil
        lock.unlock()
    }
}
