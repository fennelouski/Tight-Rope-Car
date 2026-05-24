//
//  CourseMapNodeView.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapNodeView: View {
    let displayName: String
    let state: CourseMapNodeState
    let isSelected: Bool
    var ticketCount: Int? = nil

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var glowPulse = false
    @State private var readyPulse = false

    private let diameter = CourseMapLayout.nodeDiameter

    var body: some View {
        ZStack {
            outerEffects

            Circle()
                .fill(backgroundGradient)
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
                .overlay {
                    if state == .locked {
                        lockedPatternOverlay
                    }
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

            if let ticketCount, state != .locked {
                ticketBadge(ticketCount)
            }

            if isSelected {
                selectedBadge
            }

            stateChip
                .offset(y: diameter * 0.46)
        }
        .frame(width: diameter, height: diameter)
        .opacity(state == .locked ? 0.58 : 1)
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

    private var lockedPatternOverlay: some View {
        Canvas { context, size in
            var path = Path()
            let spacing: CGFloat = 8
            var offset: CGFloat = -size.height
            while offset < size.width + size.height {
                path.move(to: CGPoint(x: offset, y: size.height))
                path.addLine(to: CGPoint(x: offset + size.height, y: 0))
                offset += spacing
            }
            context.stroke(
                path,
                with: .color(Color.white.opacity(0.06)),
                style: StrokeStyle(lineWidth: 2)
            )
        }
        .clipShape(Circle())
        .allowsHitTesting(false)
    }

    private func ticketBadge(_ count: Int) -> some View {
        HStack(spacing: 2) {
            Image(systemName: "ticket.fill")
                .font(.system(size: 7, weight: .black))
            Text("\(count)")
                .font(.system(size: 8, weight: .black, design: .rounded))
        }
        .foregroundStyle(HotWheelsTheme.trackBlack)
        .padding(.horizontal, 5)
        .padding(.vertical, 3)
        .background(
            Capsule(style: .continuous)
                .fill(HotWheelsTheme.flameOrange)
                .overlay(
                    Capsule(style: .continuous)
                        .strokeBorder(HotWheelsTheme.trackBlack.opacity(0.35), lineWidth: 1)
                )
        )
        .offset(x: -diameter * 0.28, y: diameter * 0.30)
        .accessibilityHidden(true)
    }

    private var selectedBadge: some View {
        Image(systemName: "scope")
            .font(.system(size: 10, weight: .black))
            .foregroundStyle(HotWheelsTheme.racingYellow)
            .padding(5)
            .background(
                Circle()
                    .fill(HotWheelsTheme.trackBlack.opacity(0.88))
                    .overlay(Circle().strokeBorder(HotWheelsTheme.racingYellow, lineWidth: 1.5))
            )
            .offset(x: -diameter * 0.34, y: -diameter * 0.34)
            .accessibilityHidden(true)
    }

    private var stateChip: some View {
        Text(stateChipTitle)
            .font(.system(size: 8, weight: .heavy, design: .rounded))
            .foregroundStyle(stateChipForeground)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                Capsule(style: .continuous)
                    .fill(stateChipFill)
                    .overlay(
                        Capsule(style: .continuous)
                            .strokeBorder(stateChipStroke, lineWidth: 1.5)
                    )
            )
            .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 1)
            .accessibilityHidden(true)
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

    private var backgroundGradient: LinearGradient {
        switch state {
        case .locked:
            LinearGradient(
                colors: [
                    HotWheelsTheme.trackBlack.opacity(0.82),
                    HotWheelsTheme.trackBlack.opacity(0.62),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .available:
            LinearGradient(
                colors: [
                    HotWheelsTheme.hotRed,
                    HotWheelsTheme.flameOrange.opacity(0.92),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .beaten:
            LinearGradient(
                colors: [
                    HotWheelsTheme.electricBlue,
                    HotWheelsTheme.electricBlue.opacity(0.72),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
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

    private var stateChipTitle: String {
        switch state {
        case .locked: "LOCKED"
        case .available: "OPEN"
        case .beaten: "CLEAR"
        }
    }

    private var stateChipFill: Color {
        switch state {
        case .locked: HotWheelsTheme.trackBlack.opacity(0.88)
        case .available: HotWheelsTheme.electricBlue.opacity(0.92)
        case .beaten: HotWheelsTheme.racingYellow
        }
    }

    private var stateChipStroke: Color {
        switch state {
        case .locked: Color.white.opacity(0.22)
        case .available: HotWheelsTheme.racingYellow.opacity(0.85)
        case .beaten: HotWheelsTheme.flameOrange
        }
    }

    private var stateChipForeground: Color {
        switch state {
        case .locked: Color.white.opacity(0.72)
        case .available: .white
        case .beaten: HotWheelsTheme.trackBlack
        }
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
    CourseMapNodeView(displayName: "First Steps", state: .available, isSelected: false, ticketCount: 3)
        .padding(24)
        .background(HotWheelsTheme.trackBlack)
}

#Preview("Beaten selected") {
    CourseMapNodeView(displayName: "Long Haul", state: .beaten, isSelected: true, ticketCount: 4)
        .padding(24)
        .background(HotWheelsTheme.trackBlack)
}

#Preview("Locked") {
    CourseMapNodeView(displayName: "Summit Climb", state: .locked, isSelected: false)
        .padding(24)
        .background(HotWheelsTheme.trackBlack)
}

#Preview("All states") {
    HStack(spacing: 20) {
        CourseMapNodeView(displayName: "Summit Climb", state: .locked, isSelected: false)
        CourseMapNodeView(displayName: "First Steps", state: .available, isSelected: false, ticketCount: 3)
        CourseMapNodeView(displayName: "Long Haul", state: .beaten, isSelected: true, ticketCount: 5)
    }
    .padding(24)
    .background(HotWheelsTheme.trackBlack)
}
