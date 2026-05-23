//
//  CourseMapToolbarButton.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapToolbarButton: View {
    enum Style {
        case standard
        case accent
    }

    let systemImage: String
    let accessibilityLabel: String
    let accessibilityHint: String
    var style: Style = .standard
    var isEnabled: Bool = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.body.weight(.black))
                .foregroundStyle(foregroundColor)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(fillColor)
                        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 2)
                )
                .overlay(
                    Circle()
                        .strokeBorder(strokeColor, lineWidth: 2)
                )
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.38)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }

    private var fillColor: Color {
        switch style {
        case .standard:
            return HotWheelsTheme.racingYellow
        case .accent:
            return HotWheelsTheme.electricBlue
        }
    }

    private var strokeColor: Color {
        switch style {
        case .standard:
            return HotWheelsTheme.hotRed
        case .accent:
            return HotWheelsTheme.racingYellow
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .standard:
            return HotWheelsTheme.trackBlack
        case .accent:
            return .white
        }
    }
}

/// Circular label matching ``CourseMapToolbarButton`` — for `ShareLink` and other non-button controls.
struct CourseMapToolbarIcon: View {
    let systemImage: String
    var style: CourseMapToolbarButton.Style = .standard
    var isEnabled: Bool = true

    var body: some View {
        Image(systemName: systemImage)
            .font(.body.weight(.black))
            .foregroundStyle(foregroundColor)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .fill(fillColor)
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 2)
            )
            .overlay(
                Circle()
                    .strokeBorder(strokeColor, lineWidth: 2)
            )
            .opacity(isEnabled ? 1 : 0.38)
    }

    private var fillColor: Color {
        style == .standard ? HotWheelsTheme.racingYellow : HotWheelsTheme.electricBlue
    }

    private var strokeColor: Color {
        style == .standard ? HotWheelsTheme.hotRed : HotWheelsTheme.racingYellow
    }

    private var foregroundColor: Color {
        style == .standard ? HotWheelsTheme.trackBlack : .white
    }
}

#Preview("Styles") {
    HStack(spacing: 12) {
        CourseMapToolbarButton(
            systemImage: "chevron.left",
            accessibilityLabel: "Back",
            accessibilityHint: "Go back",
            action: {}
        )
        CourseMapToolbarButton(
            systemImage: "trophy.fill",
            accessibilityLabel: "Scores",
            accessibilityHint: "High scores",
            style: .accent,
            action: {}
        )
        CourseMapToolbarIcon(systemImage: "square.and.arrow.up")
    }
    .padding()
    .background(HotWheelsTheme.backgroundGradient)
}
