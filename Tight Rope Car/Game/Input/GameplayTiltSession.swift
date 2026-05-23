//
//  GameplayTiltSession.swift
//  Tight Rope Car
//

import Foundation
import Observation

/// Shared tilt provider and calibration state for a single gameplay session.
@MainActor
@Observable
final class GameplayTiltSession {
    let deviceProvider: TiltRollProviding
    let manualProvider: ManualTiltRollProvider
    private let compositeProvider: CompositeTiltRollProvider

    /// Provider passed to ``GameScene`` (device or manual based on ``preferOnScreenBalance``).
    var tiltProvider: TiltRollProviding { compositeProvider }

    var preferOnScreenBalance = false {
        didSet { compositeProvider.preferManual = preferOnScreenBalance }
    }

    private(set) var calibrator = TiltCalibrator()
    private(set) var neutralRollOffset: Double = 0
    private(set) var isCalibrating = false

    init() {
        let device = TiltInputFactory.makeDefaultProvider()
        let manual = ManualTiltRollProvider()
        self.deviceProvider = device
        self.manualProvider = manual
        self.compositeProvider = CompositeTiltRollProvider(device: device, manual: manual)
    }

    func configureForAccessibility(reduceMotion: Bool, isSimulator: Bool) {
        preferOnScreenBalance = reduceMotion || isSimulator
    }

    func nudgeOnScreenBalance(left: Bool, maxRoll: Double) {
        preferOnScreenBalance = true
        manualProvider.nudge(
            left: left,
            step: GameBalanceConstants.onScreenBalanceRollStep,
            maxMagnitude: maxRoll
        )
    }

    func centerOnScreenBalance() {
        manualProvider.targetRollRadians = 0
    }

    func beginCalibration() {
        calibrator.reset()
        isCalibrating = true
        compositeProvider.start()
    }

    func ingestCalibrationSample() {
        guard isCalibrating, let roll = tiltProvider.latestRollRadians else { return }
        calibrator.addSample(roll)
    }

    var isCalibrationComplete: Bool {
        calibrator.isComplete
    }

    var calibrationProgress: Double {
        calibrator.progress
    }

    func commitCalibration() {
        neutralRollOffset = calibrator.neutralRollRadians
        isCalibrating = false
    }

    func skipCalibration(using fallbackRoll: Double?) {
        calibrator.forceComplete(fallback: fallbackRoll ?? tiltProvider.latestRollRadians ?? 0)
    }

    func endSession() {
        compositeProvider.stop()
        isCalibrating = false
        preferOnScreenBalance = false
    }
}
