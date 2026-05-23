//
//  GameplayPauseOverlay.swift
//  Tight Rope Car
//

import SwiftUI

struct GameplayPauseOverlay: View {
    var courseDisplayName: String?
    var profile: PlayerProfile?
    var onResume: () -> Void
    var onQuitToMap: () -> Void
    var onMainMenu: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showQuitConfirmation = false
    @State private var showMainMenuConfirmation = false
    @State private var contentAppeared = false

    private var actionItems: [(icon: String, title: String, subtitle: String?, style: HotWheelsOverlayActionButton.Style, action: () -> Void)] {
        [
            ("play.fill", "Resume", "Pick up where you left off", .primary, onResume),
            ("map.fill", "Quit to Map", "Leave this attempt", .secondary, { showQuitConfirmation = true }),
            ("house.fill", "Main Menu", "Back to Play screen", .destructive, { showMainMenuConfirmation = true }),
        ]
    }

    var body: some View {
        ZStack {
            RunFlowOverlayBackdrop(accentColor: HotWheelsTheme.electricBlue)

            ScrollView {
                RunFlowOverlayCard(borderColor: HotWheelsTheme.racingYellow) {
                    VStack(spacing: 18) {
                        header
                        if hasRunContext {
                            runContextSection
                        }
                        HotWheelsInfoBanner(
                            message: "Your run is frozen — tilt controls are off until you resume."
                        )
                        actionButtons
                    }
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity)
            }
            .scrollBounceBehavior(.basedOnSize)
            .safeAreaPadding(.vertical, 12)
            .safeAreaPadding(.bottom, 8)
            .hotWheelsContentWidth()
            .opacity(contentAppeared ? 1 : 0)
            .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.94))
        }
        .onAppear(perform: runEntranceAnimation)
        .alert("Leave this run?", isPresented: $showQuitConfirmation) {
            Button("Keep Playing", role: .cancel) {}
            Button("Quit to Map", role: .destructive, action: onQuitToMap)
        } message: {
            Text("Progress for this attempt won't be saved unless you finish the course.")
        }
        .alert("Return to main menu?", isPresented: $showMainMenuConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Main Menu", role: .destructive, action: onMainMenu)
        } message: {
            Text("Your profiles and progress stay saved on this device.")
        }
    }

    private var hasRunContext: Bool {
        courseDisplayName != nil || profile != nil
    }

    private var header: some View {
        VStack(spacing: 10) {
            Image(systemName: "pause.circle.fill")
                .font(.system(size: 44, weight: .bold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(HotWheelsTheme.racingYellow, HotWheelsTheme.trackBlack.opacity(0.35))
                .accessibilityHidden(true)

            Text("Paused")
                .font(HotWheelsTheme.sectionTitleFont)
                .foregroundStyle(.white)
                .hotWheelsTitleShadow()

            Text("Take a breather — your run is waiting")
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(HotWheelsTheme.electricBlue.opacity(0.95))
                .multilineTextAlignment(.center)
        }
        .multilineTextAlignment(.center)
    }

    private var runContextSection: some View {
        HotWheelsFormPanel {
            VStack(alignment: .leading, spacing: 10) {
                HotWheelsFormSectionHeader("Current Run")

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

    private var actionButtons: some View {
        VStack(spacing: 10) {
            ForEach(Array(actionItems.enumerated()), id: \.offset) { index, item in
                HotWheelsOverlayActionButton(
                    systemImage: item.icon,
                    title: item.title,
                    subtitle: item.subtitle,
                    style: item.style,
                    action: item.action
                )
                .opacity(contentAppeared ? 1 : 0)
                .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 10))
                .animation(
                    reduceMotion ? nil : .easeOut(duration: 0.32).delay(0.08 + Double(index) * 0.05),
                    value: contentAppeared
                )
            }
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

#Preview("With context") {
    ZStack {
        HotWheelsTheme.backgroundGradient
            .ignoresSafeArea()
        GameplayPauseOverlay(
            courseDisplayName: "First Steps",
            profile: PlayerProfile(name: "Speed Racer", age: 9, profileColorIndex: 4),
            onResume: {},
            onQuitToMap: {},
            onMainMenu: {}
        )
    }
}

#Preview("With context — iPhone SE", traits: .fixedLayout(width: 375, height: 667)) {
    ZStack {
        HotWheelsTheme.backgroundGradient
            .ignoresSafeArea()
        GameplayPauseOverlay(
            courseDisplayName: "First Steps",
            profile: PlayerProfile(name: "Speed Racer", age: 9, profileColorIndex: 4),
            onResume: {},
            onQuitToMap: {},
            onMainMenu: {}
        )
    }
}

#Preview("Minimal") {
    ZStack {
        Color.gray
        GameplayPauseOverlay(onResume: {}, onQuitToMap: {}, onMainMenu: {})
    }
}
