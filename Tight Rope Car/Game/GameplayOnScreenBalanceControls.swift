//
//  GameplayOnScreenBalanceControls.swift
//  Tight Rope Car
//

import SwiftUI

/// Left/right balance buttons using the same tilt pipeline as CoreMotion (S10).
struct GameplayOnScreenBalanceControls: View {
    let maxRollRadians: Double
    var onNudgeLeft: () -> Void
    var onNudgeRight: () -> Void
    var onCenter: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            balanceButton(
                systemImage: "arrow.left",
                label: "Lean left",
                action: onNudgeLeft
            )

            balanceButton(
                systemImage: "minus",
                label: "Level",
                action: onCenter,
                iconSize: 18
            )

            balanceButton(
                systemImage: "arrow.right",
                label: "Lean right",
                action: onNudgeRight
            )
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 24)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("On-screen balance")
        .accessibilityHint("Use when device tilt is unavailable. Max lean \(Int(maxRollRadians * 180 / .pi)) degrees.")
    }

    private func balanceButton(
        systemImage: String,
        label: String,
        action: @escaping () -> Void,
        iconSize: CGFloat = 22
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: iconSize, weight: .bold))
                .foregroundStyle(HotWheelsTheme.trackBlack)
                .frame(width: 56, height: 56)
                .background(Circle().fill(HotWheelsTheme.racingYellow))
                .overlay(Circle().strokeBorder(HotWheelsTheme.hotRed, lineWidth: 2))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}
