//
//  DeviceStillnessMonitor.swift
//  Tight Rope Car
//

import Combine
import Foundation
#if canImport(CoreMotion)
import CoreMotion
#endif

/// Detects when the device is resting on a surface (for the landing-screen tilt hint).
@MainActor
final class DeviceStillnessMonitor: ObservableObject {
    @Published private(set) var isDeviceStill = false

    #if canImport(CoreMotion)
    private let motionManager = CMMotionManager()
    #endif
    private var evaluator = DeviceStillnessEvaluator()

    func start() {
        #if canImport(CoreMotion)
        guard motionManager.isDeviceMotionAvailable else {
            isDeviceStill = false
            return
        }
        evaluator.reset()
        isDeviceStill = false
        motionManager.deviceMotionUpdateInterval = 1.0 / GameBalanceConstants.landingStillnessUpdateHz
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self, let motion else { return }
            let magnitude = DeviceStillnessSample.accelerationMagnitude(
                x: motion.userAcceleration.x,
                y: motion.userAcceleration.y,
                z: motion.userAcceleration.z
            )
            self.isDeviceStill = self.evaluator.record(accelerationMagnitude: magnitude)
        }
        #endif
    }

    func stop() {
        #if canImport(CoreMotion)
        motionManager.stopDeviceMotionUpdates()
        #endif
        evaluator.reset()
        isDeviceStill = false
    }
}
