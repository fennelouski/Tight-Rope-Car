//
//  CourseMapNodeView.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapNodeView: View {
    let displayName: String
    let state: CourseMapNodeState
    let isSelected: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var glowPulse = false
    @State private var readyPulse = false

    private let diameter = CourseMapLayout.nodeDiameter

    var body: some View {
        ZStack {
            outerEffects

            Circle()
                .fill(backgroundFill)
                .overlay {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(state == .locked ? 0.08 : 0.28),
                                    Color.clear,
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                }
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 0, y: 4)

            Circle()
                .strokeBorder(strokeColor, lineWidth: isSelected ? 4 : 3)

            Circle()
                .strokeBorder(innerRingColor, lineWidth: 1.5)
                .padding(5)

            VStack(spacing: 2) {
                statusIcon
                Text(shortLabel)
                    .font(.system(size: 9, weight: .black, design: .rounded))
                    .foregroundStyle(labelColor)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .frame(width: diameter - 14)
            }

        }
        .frame(width: diameter, height: diameter)
        .opacity(state == .locked ? 0.55 : 1)
        .scaleEffect(selectionScale)
        .animation(.easeOut(duration: 0.2), value: isSelected)
        .onAppear(perform: runStateAnimations)
        .onChange(of: state) { _, _ in
            glowPulse = false
            readyPulse = false
            runStateAnimations()
        }
    }

    private var selectionScale: CGFloat {
        if isSelected { return 1.1 }
        if state == .available, readyPulse, !reduceMotion { return 1.04 }
        return 1
    }

    @ViewBuilder
    private var outerEffects: some View {
        if state == .beaten {
            Circle()
                .fill(HotWheelsTheme.racingYellow.opacity(glowPulse && !reduceMotion ? 0.38 : 0.2))
                .frame(width: diameter + 14, height: diameter + 14)
                .blur(radius: 6)
                .accessibilityHidden(true)

            Circle()
                .strokeBorder(HotWheelsTheme.flameOrange.opacity(0.55), lineWidth: 2)
                .frame(width: diameter + 8, height: diameter + 8)
                .accessibilityHidden(true)
        }

        if isSelected {
            Circle()
                .strokeBorder(HotWheelsTheme.racingYellow, lineWidth: 3)
                .frame(width: diameter + 10, height: diameter + 10)
                .shadow(color: HotWheelsTheme.racingYellow.opacity(0.45), radius: 4, x: 0, y: 0)
                .accessibilityHidden(true)
        } else if state == .available {
            Circle()
                .strokeBorder(
                    HotWheelsTheme.electricBlue.opacity(readyPulse && !reduceMotion ? 0.9 : 0.5),
                    style: StrokeStyle(lineWidth: 2, dash: [4, 5])
                )
                .frame(width: diameter + 6, height: diameter + 6)
                .accessibilityHidden(true)
        }
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
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(HotWheelsTheme.racingYellow)
        // Beaten = cleared at least once (`completedCourseIDs`); not a 1–3 performance star score (v0.3).
        case .beaten:
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 15, weight: .bold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(HotWheelsTheme.racingYellow, HotWheelsTheme.trackBlack.opacity(0.35))
        }
    }

    private var backgroundFill: Color {
        switch state {
        case .locked:
            HotWheelsTheme.trackBlack.opacity(0.75)
        case .available:
            HotWheelsTheme.hotRed.opacity(0.88)
        case .beaten:
            HotWheelsTheme.electricBlue.opacity(0.92)
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

    private var innerRingColor: Color {
        switch state {
        case .locked:
            Color.white.opacity(0.12)
        case .available:
            Color.white.opacity(0.35)
        case .beaten:
            HotWheelsTheme.racingYellow.opacity(0.5)
        }
    }

    private var labelColor: Color {
        state == .locked ? Color.white.opacity(0.55) : HotWheelsTheme.trackBlack
    }

    private func runStateAnimations() {
        guard !reduceMotion else { return }
        switch state {
        case .beaten:
            withAnimation(.easeInOut(duration: 1.15).repeatForever(autoreverses: true)) {
                glowPulse = true
            }
        case .available:
            withAnimation(.easeInOut(duration: 0.85).repeatForever(autoreverses: true)) {
                readyPulse = true
            }
        case .locked:
            break
        }
    }
}

#Preview("Available") {
    CourseMapNodeView(displayName: "First Steps", state: .available, isSelected: false)
        .padding(24)
        .background(HotWheelsTheme.trackBlack)
}

#Preview("Beaten selected") {
    CourseMapNodeView(displayName: "Long Haul", state: .beaten, isSelected: true)
        .padding(24)
        .background(HotWheelsTheme.trackBlack)
}

#Preview("Locked") {
    CourseMapNodeView(displayName: "Summit Climb", state: .locked, isSelected: false)
        .padding(24)
        .background(HotWheelsTheme.trackBlack)
}
