//
//  GameplayPauseOverlay.swift
//  Tight Rope Car
//

import SwiftUI

struct GameplayPauseOverlay: View {
    var onResume: () -> Void
    var onQuitToMap: () -> Void
    var onMainMenu: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showQuitConfirmation = false
    @State private var showMainMenuConfirmation = false
    @State private var contentAppeared = false

    var body: some View {
        ZStack {
            RunFlowOverlayBackdrop(accentColor: HotWheelsTheme.electricBlue)

            RunFlowOverlayCard(borderColor: HotWheelsTheme.racingYellow) {
                VStack(spacing: 18) {
                    header

                    pauseButton("Resume", fillColor: HotWheelsTheme.racingYellow) {
                        onResume()
                    }

                    pauseButton("Quit to Map", fillColor: .white.opacity(0.92)) {
                        showQuitConfirmation = true
                    }

                    pauseButton("Main Menu", fillColor: HotWheelsTheme.hotRed.opacity(0.9)) {
                        showMainMenuConfirmation = true
                    }
                }
            }
            .padding(.horizontal, 28)
            .hotWheelsContentWidth()
            .opacity(contentAppeared ? 1 : 0)
            .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 16))
        }
        .onAppear(perform: runEntranceAnimation)
        .alert("Leave this run?", isPresented: $showQuitConfirmation) {
            Button("Keep Playing", role: .cancel) {}
            Button("Quit to Map", role: .destructive) {
                onQuitToMap()
            }
        } message: {
            Text("Progress for this attempt won't be saved unless you finish the course.")
        }
        .alert("Return to main menu?", isPresented: $showMainMenuConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Main Menu", role: .destructive) {
                onMainMenu()
            }
        } message: {
            Text("Your profiles and progress stay saved on this device.")
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            Image(systemName: "pause.circle.fill")
                .font(.system(size: 52, weight: .bold))
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
    }

    private func pauseButton(
        _ title: String,
        fillColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(HotWheelsAccentButtonStyle(fillColor: fillColor))
        .frame(maxWidth: .infinity)
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
        Color.gray
        GameplayPauseOverlay(onResume: {}, onQuitToMap: {}, onMainMenu: {})
    }
}
