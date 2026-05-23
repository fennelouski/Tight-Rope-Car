//
//  TiltCalibrator.swift
//  Tight Rope Car
//

import Foundation

/// Collects device roll samples until the player holds a steady level pose.
struct TiltCalibrator: Sendable {
    private(set) var samples: [Double] = []
    private(set) var isComplete = false

    var requiredSamples: Int
    var maxRollVariance: Double

    init(
        requiredSamples: Int = GameBalanceConstants.calibrationRequiredSamples,
        maxRollVariance: Double = GameBalanceConstants.calibrationMaxRollVariance
    ) {
        self.requiredSamples = requiredSamples
        self.maxRollVariance = maxRollVariance
    }

    var neutralRollRadians: Double {
        guard !samples.isEmpty else { return 0 }
        return samples.reduce(0, +) / Double(samples.count)
    }

    var progress: Double {
        guard requiredSamples > 0 else { return 1 }
        return min(1, Double(samples.count) / Double(requiredSamples))
    }

    var isStable: Bool {
        guard samples.count >= requiredSamples else { return false }
        let mean = neutralRollRadians
        let variance = samples.reduce(0) { $0 + ($1 - mean) * ($1 - mean) } / Double(samples.count)
        return variance <= maxRollVariance
    }

    mutating func reset() {
        samples = []
        isComplete = false
    }

    /// Records a roll reading; marks complete when enough stable samples are collected.
    mutating func addSample(_ roll: Double) {
        guard !isComplete else { return }
        samples.append(roll)
        if samples.count >= requiredSamples, isStable {
            isComplete = true
        }
    }

    /// Finishes immediately with the current mean (or `fallback` when no samples).
    mutating func forceComplete(fallback: Double = 0) {
        if samples.isEmpty {
            samples = [fallback]
        }
        isComplete = true
    }
}
