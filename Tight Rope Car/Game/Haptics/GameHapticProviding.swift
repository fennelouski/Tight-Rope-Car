//
//  GameHapticProviding.swift
//  Tight Rope Car
//

import Foundation

/// Gameplay haptics (fall and near-fall); injectable for tests.
@MainActor
protocol GameHapticProviding: AnyObject {
    var isEnabled: Bool { get set }
    var respectsReduceMotion: Bool { get set }
    func prepare()
    func playFall(_ reason: FallReason)
    func playNearFall()
    func playEarlyWarning()
    func resetEarlyWarningCooldown()
}
