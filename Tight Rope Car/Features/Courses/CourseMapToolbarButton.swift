//
//  CourseMapToolbarButton.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapToolbarButton: View {
    let systemImage: String
    let accessibilityLabel: String
    let accessibilityHint: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.body.weight(.black))
                .foregroundStyle(HotWheelsTheme.trackBlack)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(HotWheelsTheme.racingYellow)
                        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 2)
                )
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.hotRed, lineWidth: 2)
                )
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }
}
