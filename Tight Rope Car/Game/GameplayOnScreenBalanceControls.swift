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

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var contentAppeared = false

    private var maxLeanDegrees: Int {
        Int(maxRollRadians * 180 / .pi)
    }

    var body: some View {
        VStack(spacing: 0) {
            balancePanel
                .opacity(contentAppeared ? 1 : 0)
                .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 16))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .onAppear(perform: runEntranceAnimation)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("On-screen balance")
        .accessibilityHint("Use when device tilt is unavailable. Max lean \(maxLeanDegrees) degrees.")
    }

    private var balancePanel: some View {
        VStack(spacing: 12) {
            HStack {
                Label("Balance Pad", systemImage: "hand.tap.fill")
                    .font(HotWheelsTheme.captionFont.weight(.bold))
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                    .labelStyle(.titleAndIcon)

                Spacer(minLength: 0)

                HotWheelsInlineStat(
                    systemImage: "angle",
                    text: "±\(maxLeanDegrees)°",
                    accent: HotWheelsTheme.electricBlue
                )
            }

            HStack(spacing: 16) {
                HotWheelsCircularControlButton(
                    systemImage: "arrow.left",
                    accessibilityLabel: "Lean left",
                    accessibilityHint: "Tilts the car left",
                    style: .primary,
                    action: onNudgeLeft
                )

                HotWheelsCircularControlButton(
                    systemImage: "minus",
                    accessibilityLabel: "Level",
                    accessibilityHint: "Centers the car on the wire",
                    style: .neutral,
                    diameter: 52,
                    iconSize: 18,
                    action: onCenter
                )

                HotWheelsCircularControlButton(
                    systemImage: "arrow.right",
                    accessibilityLabel: "Lean right",
                    accessibilityHint: "Tilts the car right",
                    style: .primary,
                    action: onNudgeRight
                )
            }
            .frame(maxWidth: .infinity)

            Text("Tap left or right to lean · center to level out")
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.72))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.82))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.electricBlue.opacity(0.85),
                            HotWheelsTheme.racingYellow.opacity(0.75),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2.5
                )
        )
        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.45), radius: 0, x: 0, y: 4)
    }

    private func runEntranceAnimation() {
        if reduceMotion {
            contentAppeared = true
            return
        }
        withAnimation(.easeOut(duration: 0.32)) {
            contentAppeared = true
        }
    }
}

#Preview {
    ZStack {
        HotWheelsTheme.backgroundGradient
            .ignoresSafeArea()
        VStack {
            Spacer()
            GameplayOnScreenBalanceControls(
                maxRollRadians: .pi / 4,
                onNudgeLeft: {},
                onNudgeRight: {},
                onCenter: {}
            )
        }
    }
}
