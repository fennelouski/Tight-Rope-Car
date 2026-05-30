//
//  HotWheelsTheme.swift
//  Tight Rope Car
//

import SwiftUI

enum HotWheelsTheme {
    static let flameOrange = Color(red: 1.0, green: 0.4, blue: 0.0)
    static let electricBlue = Color(red: 0.0, green: 0.4, blue: 1.0)
    static let racingYellow = Color(red: 1.0, green: 0.82, blue: 0.0)
    static let hotRed = Color(red: 0.89, green: 0.09, blue: 0.22)
    static let trackBlack = Color(red: 0.1, green: 0.1, blue: 0.1)

    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [trackBlack, flameOrange.opacity(0.85), flameOrange],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static var titleFont: Font {
        .system(size: 42, weight: .black, design: .rounded)
    }

    static var taglineFont: Font {
        .system(size: 18, weight: .semibold, design: .rounded)
    }

    static var playButtonFont: Font {
        .system(size: 22, weight: .black, design: .rounded)
    }

    static var sectionTitleFont: Font {
        .system(size: 28, weight: .black, design: .rounded)
    }

    static var headlineFont: Font {
        .system(size: 20, weight: .bold, design: .rounded)
    }

    static var bodyFont: Font {
        .system(size: 16, weight: .semibold, design: .rounded)
    }

    static var captionFont: Font {
        .system(size: 14, weight: .medium, design: .rounded)
    }
}

struct HotWheelsAccentButtonStyle: ButtonStyle {
    var fillColor: Color = HotWheelsTheme.racingYellow
    var strokeColor: Color = HotWheelsTheme.hotRed

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(HotWheelsTheme.playButtonFont)
            .foregroundStyle(HotWheelsTheme.trackBlack)
            .padding(.horizontal, 32)
            .padding(.vertical, 14)
            .background(
                Capsule()
                    .fill(fillColor)
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.4), radius: 0, x: 0, y: 4)
            )
            .overlay(
                Capsule()
                    .strokeBorder(strokeColor, lineWidth: 3)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct PlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(HotWheelsTheme.playButtonFont)
            .foregroundStyle(HotWheelsTheme.trackBlack)
            .padding(.horizontal, 56)
            .padding(.vertical, 16)
            .background(
                Capsule()
                    .fill(HotWheelsTheme.racingYellow)
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.4), radius: 0, x: 0, y: 4)
            )
            .overlay(
                Capsule()
                    .strokeBorder(HotWheelsTheme.hotRed, lineWidth: 4)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension View {
    func hotWheelsTitleShadow() -> some View {
        shadow(color: HotWheelsTheme.trackBlack.opacity(0.6), radius: 0, x: 2, y: 3)
    }

    func hotWheelsContentWidth() -> some View {
        frame(maxWidth: 560)
        .frame(maxWidth: .infinity)
    }

    /// Adds a 16 pt buffer below the status bar inside the safe layout.
    /// Does not define the screen background — use ``hotWheelsMenuScreenBackground()`` for that.
    @ViewBuilder
    func hotWheelsScreenContentPadding() -> some View {
        if HotWheelsLayoutExperiment.ignoresSafeArea {
            self
        } else {
            padding(.top, 16)
        }
    }

    /// Wraps or grows vertically instead of truncating with an ellipsis.
    func hotWheelsShowsFullText(alignment: TextAlignment = .leading) -> some View {
        lineLimit(nil)
            .multilineTextAlignment(alignment)
            .fixedSize(horizontal: false, vertical: true)
    }
}
