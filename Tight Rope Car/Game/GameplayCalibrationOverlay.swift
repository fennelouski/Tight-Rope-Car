//
//  GameplayCalibrationOverlay.swift
//  Tight Rope Car
//

import SwiftUI

/// Pre-run step: hold the device level until calibration completes.
struct GameplayCalibrationOverlay: View {
    let progress: Double
    var courseDisplayName: String?
    var profile: PlayerProfile?
    var usesOnScreenBalance: Bool = false
    let showsSkipControl: Bool
    var onSkip: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var contentAppeared = false

    private var clampedProgress: Double {
        min(max(progress, 0), 1)
    }

    private var instructionMessage: String {
        if usesOnScreenBalance {
            return "Tilt calibration is optional here — you can use on-screen balance buttons during the run."
        }
        return "Hold your device flat like a spirit level. Stay steady until the ring fills."
    }

    private var statusMessage: String {
        switch clampedProgress {
        case ..<0.25:
            return "Finding neutral tilt…"
        case ..<0.75:
            return "Keep holding level…"
        default:
            return "Locking in balance…"
        }
    }

    var body: some View {
        ZStack {
            RunFlowOverlayBackdrop(accentColor: HotWheelsTheme.electricBlue)

            RunFlowOverlayCard(borderColor: HotWheelsTheme.electricBlue) {
                VStack(spacing: 18) {
                    header
                    if hasRunContext {
                        runContextSection
                    }
                    progressSection
                    HotWheelsInfoBanner(
                        message: instructionMessage,
                        systemImage: usesOnScreenBalance ? "hand.tap.fill" : "level.fill"
                    )
                    if showsSkipControl {
                        skipButton
                    }
                }
            }
            .padding(.horizontal, 24)
            .hotWheelsContentWidth()
            .opacity(contentAppeared ? 1 : 0)
            .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.94))
        }
        .onAppear(perform: runEntranceAnimation)
        .accessibilityElement(children: .contain)
    }

    private var hasRunContext: Bool {
        courseDisplayName != nil || profile != nil
    }

    private var header: some View {
        VStack(spacing: 10) {
            Image(systemName: "gyroscope")
                .font(.system(size: 44, weight: .bold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(HotWheelsTheme.electricBlue, HotWheelsTheme.trackBlack.opacity(0.35))
                .accessibilityHidden(true)

            Text("Hold Level")
                .font(HotWheelsTheme.sectionTitleFont)
                .foregroundStyle(.white)
                .hotWheelsTitleShadow()

            Text(statusMessage)
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(HotWheelsTheme.electricBlue.opacity(0.95))
                .multilineTextAlignment(.center)
                .animation(.easeInOut(duration: 0.2), value: statusMessage)
        }
        .multilineTextAlignment(.center)
    }

    private var runContextSection: some View {
        HotWheelsFormPanel {
            VStack(alignment: .leading, spacing: 10) {
                HotWheelsFormSectionHeader("Starting Run")

                if let courseDisplayName {
                    Label(courseDisplayName, systemImage: "flag.checkered")
                        .font(HotWheelsTheme.headlineFont)
                        .foregroundStyle(.white)
                        .labelStyle(.titleAndIcon)
                }

                if let profile {
                    HotWheelsRacerChip(profile: profile)
                }
            }
        }
    }

    private var progressSection: some View {
        VStack(spacing: 12) {
            HotWheelsProgressRing(
                progress: clampedProgress,
                systemImage: usesOnScreenBalance ? "hand.tap.fill" : "level.fill",
                accent: HotWheelsTheme.racingYellow
            )

            HotWheelsMetricTile(
                systemImage: "scope",
                label: "Calibration",
                value: statusMessage,
                accent: HotWheelsTheme.electricBlue,
                isFeatured: clampedProgress >= 0.75
            )
        }
    }

    private var skipButton: some View {
        HotWheelsOverlayActionButton(
            systemImage: "forward.fill",
            title: "Continue without tilting",
            subtitle: usesOnScreenBalance ? "Use on-screen balance controls" : "Starts with level balance",
            style: .secondary,
            action: onSkip
        )
        .opacity(contentAppeared ? 1 : 0)
        .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 8))
        .animation(
            reduceMotion ? nil : .easeOut(duration: 0.32).delay(0.12),
            value: contentAppeared
        )
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

#Preview("Tilt calibration") {
    ZStack {
        HotWheelsTheme.backgroundGradient
            .ignoresSafeArea()
        GameplayCalibrationOverlay(
            progress: 0.42,
            courseDisplayName: "First Steps",
            profile: PlayerProfile(name: "Speed Racer", age: 9, profileColorIndex: 4),
            showsSkipControl: false,
            onSkip: {}
        )
    }
}

#Preview("On-screen balance") {
    ZStack {
        Color.gray
        GameplayCalibrationOverlay(
            progress: 0.85,
            courseDisplayName: "Roller Rope",
            profile: PlayerProfile(name: "Jordan", age: 12, profileColorIndex: 13),
            usesOnScreenBalance: true,
            showsSkipControl: true,
            onSkip: {}
        )
    }
}
