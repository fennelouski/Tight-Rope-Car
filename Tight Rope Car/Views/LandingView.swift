//
//  LandingView.swift
//  Tight Rope Car
//

import SwiftUI

struct LandingView: View {
    var onPlay: () -> Void = {}

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var titleAppeared = false
    @State private var taglineAppeared = false
    @State private var graphicAppeared = false
    @State private var buttonAppeared = false
    @State private var titlePulse = false
    @State private var playButtonPulse = false
    @State private var showsBackgroundGallery = false

    var body: some View {
        VStack(spacing: 0) {
                Spacer()
                    .frame(height: 48)

                titleSection
                    .opacity(titleAppeared ? 1 : 0)
                    .scaleEffect(titleAppeared ? (titlePulse ? 1.02 : 1.0) : 0.96)

                taglineSection
                    .padding(.top, 8)
                    .opacity(taglineAppeared ? 1 : 0)
                    .scaleEffect(taglineAppeared ? 1 : 0.96)

                Spacer()

                LandingCarGraphic()
                    .opacity(graphicAppeared ? 1 : 0)
                    .scaleEffect(graphicAppeared ? 1 : 0.96)

                Spacer()

                playButton
                    .padding(.bottom, 8)
                    .opacity(buttonAppeared ? 1 : 0)
                    .scaleEffect(
                        buttonAppeared
                            ? (playButtonPulse ? 1.06 : 1.0)
                            : 0.96
                    )

                backgroundsLink
                    .padding(.bottom, 48)
                    .opacity(buttonAppeared ? 1 : 0)
        }
        .padding(.horizontal, 24)
        .hotWheelsContentWidth()
        .sheet(isPresented: $showsBackgroundGallery) {
            BackgroundThemeGalleryView()
        }
        .onAppear {
            runEntranceAnimation()
        }
    }

    private var backgroundsLink: some View {
        Button {
            showsBackgroundGallery = true
        } label: {
            Text("Backgrounds")
                .font(HotWheelsTheme.taglineFont)
                .foregroundStyle(.white.opacity(0.85))
        }
        .accessibilityLabel("Background themes")
        .accessibilityHint("Opens parallax background gallery")
    }

    private var titleSection: some View {
        Text("Tight Rope Car")
            .font(HotWheelsTheme.titleFont)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .hotWheelsTitleShadow()
            .rotationEffect(.degrees(titlePulse ? -3 : -2))
            .animation(
                reduceMotion ? nil : .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                value: titlePulse
            )
    }

    private var taglineSection: some View {
        Text("Tilt to balance. Don't fall.")
            .font(HotWheelsTheme.taglineFont)
            .foregroundStyle(.white.opacity(0.95))
            .multilineTextAlignment(.center)
            .hotWheelsTitleShadow()
    }

    private var playButton: some View {
        Button(action: onPlay) {
            Text("PLAY")
        }
        .buttonStyle(PlayButtonStyle())
        .accessibilityLabel("Play")
        .accessibilityHint("Opens profile selection")
        .animation(
            reduceMotion ? nil : .easeInOut(duration: 0.9).repeatForever(autoreverses: true),
            value: playButtonPulse
        )
    }

    private func runEntranceAnimation() {
        withAnimation(.easeOut(duration: 0.45)) {
            titleAppeared = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            withAnimation(.easeOut(duration: 0.45)) {
                taglineAppeared = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            withAnimation(.easeOut(duration: 0.45)) {
                graphicAppeared = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
            withAnimation(.easeOut(duration: 0.45)) {
                buttonAppeared = true
            }
            startIdleAnimations()
        }
    }

    private func startIdleAnimations() {
        guard !reduceMotion else { return }

        titlePulse = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            playButtonPulse = true
        }
    }
}

#Preview {
    ZStack {
        RacingStripeBackground()
        LandingView()
    }
}
