//
//  GameplayCalibrationOverlay.swift
//  Tight Rope Car
//

import SwiftUI

/// Pre-run step: hold the device level until calibration completes.
struct GameplayCalibrationOverlay: View {
    let progress: Double
    var isCalibrationComplete: Bool = false
    var courseDisplayName: String?
    var profile: PlayerProfile?
    var usesOnScreenBalance: Bool = false
    var onContinue: () -> Void = {}
    var onSkipCalibration: () -> Void = {}
    var onCancel: () -> Void = {}

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var contentAppeared = false

    private var clampedProgress: Double {
        min(max(progress, 0), 1)
    }

    private var instructionMessage: String {
        if isReadyToStart {
            return "You're set — start the run or cancel to pick another course."
        }
        if usesOnScreenBalance {
            return "Tilt calibration is optional — skip anytime or use on-screen balance during the run."
        }
        return "Hold your phone upright with the screen facing you, or skip to use your last saved steering."
    }

    private var isReadyToStart: Bool {
        isCalibrationComplete || clampedProgress >= 1
    }

    private var statusMessage: String {
        if isReadyToStart {
            return isCalibrationComplete ? "Ready to race!" : "Tap Start Run to go"
        }
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

            ScrollView {
                RunFlowOverlayCard(borderColor: HotWheelsTheme.electricBlue) {
                    VStack(spacing: 18) {
                        header
                        if hasRunContext {
                            runContextSection
                        }
                        progressSection
                        HotWheelsInfoBanner(
                            message: instructionMessage,
                            systemImage: usesOnScreenBalance ? "hand.tap.fill" : "iphone"
                        )
                        actionButtons
                    }
                }
                .padding(.horizontal, 24)
                .hotWheelsSafeAreaPadding(.vertical, 12)
                .hotWheelsSafeAreaPadding(.bottom, 8)
                .frame(maxWidth: .infinity)
            }
            .scrollBounceBehavior(.basedOnSize)
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
                systemImage: usesOnScreenBalance ? "hand.tap.fill" : "iphone",
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

    private var actionButtons: some View {
        VStack(spacing: 10) {
            if isReadyToStart {
                HotWheelsOverlayActionButton(
                    systemImage: "flag.checkered",
                    title: "Start Run",
                    subtitle: "Begin \(courseDisplayName ?? "this course")",
                    style: .primary,
                    action: onContinue
                )
            } else {
                HotWheelsOverlayActionButton(
                    systemImage: "forward.fill",
                    title: "Skip calibration",
                    subtitle: usesOnScreenBalance
                        ? "Use on-screen balance controls"
                        : "Use last saved balance",
                    style: .secondary,
                    action: onSkipCalibration
                )
            }

            HotWheelsOverlayActionButton(
                systemImage: "xmark",
                title: "Cancel",
                subtitle: "Back to course map",
                style: .destructive,
                action: onCancel
            )
        }
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
            profile: PlayerProfile(name: "Speed Racer", age: 9, profileColorIndex: 4)
        )
    }
}

#Preview("On-screen balance") {
    ZStack {
        Color.gray
        GameplayCalibrationOverlay(
            progress: 1,
            isCalibrationComplete: true,
            courseDisplayName: "Roller Rope",
            profile: PlayerProfile(name: "Jordan", age: 12, profileColorIndex: 13),
            usesOnScreenBalance: true
        )
    }
}
