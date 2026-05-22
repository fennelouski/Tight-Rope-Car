//
//  CourseMapNodeView.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapNodeView: View {
    let displayName: String
    let state: CourseMapNodeState
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundFill)
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.45), radius: 0, x: 0, y: 3)

            Circle()
                .strokeBorder(strokeColor, lineWidth: isSelected ? 4 : 3)

            VStack(spacing: 2) {
                statusIcon
                Text(shortLabel)
                    .font(.system(size: 9, weight: .black, design: .rounded))
                    .foregroundStyle(labelColor)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .frame(width: CourseMapLayout.nodeDiameter - 14)
            }
        }
        .frame(width: CourseMapLayout.nodeDiameter, height: CourseMapLayout.nodeDiameter)
        .opacity(state == .locked ? 0.55 : 1)
        .scaleEffect(isSelected ? 1.08 : 1)
        .animation(.easeOut(duration: 0.2), value: isSelected)
    }

    private var shortLabel: String {
        let words = displayName.split(separator: " ")
        if words.count >= 2, let first = words.first, let second = words.dropFirst().first {
            return "\(first)\n\(second)"
        }
        return displayName
    }

    @ViewBuilder
    private var statusIcon: some View {
        switch state {
        case .locked:
            Image(systemName: "lock.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.white.opacity(0.5))
        case .available:
            Image(systemName: "flag.checkered")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(HotWheelsTheme.racingYellow)
        case .beaten:
            Image(systemName: "star.fill")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(HotWheelsTheme.racingYellow)
        }
    }

    private var backgroundFill: Color {
        switch state {
        case .locked:
            HotWheelsTheme.trackBlack.opacity(0.75)
        case .available:
            HotWheelsTheme.hotRed.opacity(0.85)
        case .beaten:
            HotWheelsTheme.electricBlue.opacity(0.9)
        }
    }

    private var strokeColor: Color {
        if isSelected {
            return HotWheelsTheme.racingYellow
        }
        switch state {
        case .locked:
            return Color.white.opacity(0.25)
        case .available:
            return HotWheelsTheme.racingYellow
        case .beaten:
            return HotWheelsTheme.flameOrange
        }
    }

    private var labelColor: Color {
        state == .locked ? Color.white.opacity(0.55) : HotWheelsTheme.trackBlack
    }
}

#Preview("Available") {
    CourseMapNodeView(displayName: "First Steps", state: .available, isSelected: false)
        .padding()
        .background(HotWheelsTheme.trackBlack)
}

#Preview("Beaten selected") {
    CourseMapNodeView(displayName: "Long Haul", state: .beaten, isSelected: true)
        .padding()
        .background(HotWheelsTheme.trackBlack)
}
