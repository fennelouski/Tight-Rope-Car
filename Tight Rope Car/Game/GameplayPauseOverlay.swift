//
//  GameplayPauseOverlay.swift
//  Tight Rope Car
//

import SwiftUI

struct GameplayPauseOverlay: View {
    var onResume: () -> Void
    var onQuitToMap: () -> Void
    var onMainMenu: () -> Void

    @State private var showQuitConfirmation = false
    @State private var showMainMenuConfirmation = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.55)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Paused")
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

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
            .padding(28)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(HotWheelsTheme.trackBlack.opacity(0.92))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(HotWheelsTheme.racingYellow, lineWidth: 3)
                    )
            )
            .padding(.horizontal, 32)
        }
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
}
