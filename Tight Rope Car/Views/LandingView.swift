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
                .padding(.top, 10)
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
            HStack(spacing: 6) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 14, weight: .bold))
                Text("Backgrounds")
                    .font(HotWheelsTheme.taglineFont)
            }
            .foregroundStyle(.white.opacity(0.92))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(HotWheelsTheme.trackBlack.opacity(0.45))
                    .overlay(
                        Capsule()
                            .strokeBorder(HotWheelsTheme.electricBlue.opacity(0.7), lineWidth: 2)
                    )
            )
        }
        .accessibilityLabel("Background themes")
        .accessibilityHint("Opens parallax background gallery")
    }

    private var titleSection: some View {
        VStack(spacing: 8) {
            ZStack {
                Text("Tight Rope Car")
                    .font(HotWheelsTheme.titleFont)
                    .foregroundStyle(HotWheelsTheme.hotRed.opacity(0.85))
                    .offset(x: 3, y: 3)

                Text("Tight Rope Car")
                    .font(HotWheelsTheme.titleFont)
                    .foregroundStyle(.white)
            }
            .multilineTextAlignment(.center)
            .hotWheelsTitleShadow()
            .rotationEffect(.degrees(titlePulse ? -3 : -2))
            .animation(
                reduceMotion ? nil : .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                value: titlePulse
            )

            titleAccentBar
        }
    }

    private var titleAccentBar: some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [
                        HotWheelsTheme.racingYellow,
                        HotWheelsTheme.flameOrange,
                        HotWheelsTheme.hotRed,
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 132, height: 5)
            .shadow(color: HotWheelsTheme.trackBlack.opacity(0.45), radius: 0, x: 0, y: 2)
    }

    private var taglineSection: some View {
        Text("Tilt to balance. Don't fall.")
            .font(HotWheelsTheme.taglineFont)
            .foregroundStyle(.white.opacity(0.95))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(HotWheelsTheme.trackBlack.opacity(0.35))
            )
            .hotWheelsTitleShadow()
    }

    private var playButton: some View {
        Button(action: onPlay) {
            Text("PLAY")
        }
        .buttonStyle(PlayButtonStyle())
        .overlay {
            if playButtonPulse, !reduceMotion {
                Capsule()
                    .strokeBorder(HotWheelsTheme.racingYellow.opacity(0.55), lineWidth: 3)
                    .padding(-6)
                    .scaleEffect(1.12)
                    .opacity(0.85)
            }
        }
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
