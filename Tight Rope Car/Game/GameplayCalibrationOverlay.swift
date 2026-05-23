//
//  GameplayCalibrationOverlay.swift
//  Tight Rope Car
//

import SwiftUI

/// Pre-run step: hold the device level until calibration completes.
struct GameplayCalibrationOverlay: View {
    let progress: Double
    let showsSkipControl: Bool
    var onSkip: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            RunFlowOverlayBackdrop(accentColor: HotWheelsTheme.electricBlue)

            RunFlowOverlayCard(borderColor: HotWheelsTheme.racingYellow) {
                VStack(spacing: 16) {
                    Text("Hold Level")
                        .font(HotWheelsTheme.sectionTitleFont)
                        .foregroundStyle(.white)
                        .hotWheelsTitleShadow()

                    Text("Hold your device level to calibrate tilt.")
                        .font(HotWheelsTheme.bodyFont)
                        .foregroundStyle(.white.opacity(0.92))
                        .multilineTextAlignment(.center)

                    ProgressView(value: progress)
                        .tint(HotWheelsTheme.racingYellow)
                        .accessibilityLabel("Calibration progress")

                    if showsSkipControl {
                        Button("Continue without tilting", action: onSkip)
                            .font(HotWheelsTheme.captionFont)
                            .foregroundStyle(.white.opacity(0.85))
                            .accessibilityHint("Starts the run with level balance")
                    }
                }
            }
            .padding(.horizontal, 28)
            .hotWheelsContentWidth()
            .opacity(reduceMotion ? 0.98 : 1)
        }
        .accessibilityElement(children: .contain)
    }
}
