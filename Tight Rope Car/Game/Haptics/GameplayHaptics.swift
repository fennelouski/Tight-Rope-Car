//
//  GameplayHaptics.swift
//  Tight Rope Car
//

import Foundation
import QuartzCore
import UIKit

/// UIKit ``UIImpactFeedbackGenerator`` fall and near-fall feedback (``.heavy`` / ``.rigid``), invoked from ``GameScene``.
/// Skips when disabled or when ``respectsReduceMotion`` and Reduce Motion is on; near-fall uses ``GameBalanceConstants.nearFallHapticCooldownSeconds``.
/// Core Haptics is an optional future enhancement, not a replacement for current UIKit feedback.
@MainActor
final class GameplayHaptics: GameHapticProviding {
    static let shared = GameplayHaptics()

    var isEnabled = true
    var respectsReduceMotion = true

    private let fallImpact = UIImpactFeedbackGenerator(style: .heavy)
    private let nearFallImpact = UIImpactFeedbackGenerator(style: .rigid)
    private var lastNearFallTime: TimeInterval = 0

    private init() {}

    private var shouldPlay: Bool {
        isEnabled && !(respectsReduceMotion && UIAccessibility.isReduceMotionEnabled)
    }

    func prepare() {
        fallImpact.prepare()
        nearFallImpact.prepare()
    }

    func playFall(_ reason: FallReason) {
        guard shouldPlay else { return }
        let intensity: CGFloat
        switch reason {
        case .offRope:
            intensity = 1
        case .excessivePitch:
            intensity = 0.92
        }
        fallImpact.impactOccurred(intensity: intensity)
        fallImpact.prepare()
    }

    func playNearFall() {
        guard shouldPlay else { return }
        let now = CACurrentMediaTime()
        guard now - lastNearFallTime >= GameBalanceConstants.nearFallHapticCooldownSeconds else { return }
        lastNearFallTime = now
        nearFallImpact.impactOccurred(intensity: 0.62)
        nearFallImpact.prepare()
    }

    func resetNearFallCooldown() {
        lastNearFallTime = 0
    }
}
