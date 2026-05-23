//
//  TicketPickupView.swift
//  Tight Rope Car
//
//  Reusable collectible ticket illustration for SwiftUI and future SpriteKit placement.
//
//  SpriteKit: add an `SKSpriteNode` with `size = TicketPickupLayout.spriteKitSize` (44×56 pt),
//  `anchorPoint = TicketPickupLayout.spriteKitAnchor` (0.5, 0.5), zPosition above the rope.
//  Export art at @2x/@3x from a 44×56 pt artboard, or rasterize this view via `ImageRenderer`.
//  Place nodes at rope arc-length fractions from `Course.ticketFractions`.
//

import CoreGraphics
import SwiftUI

/// Point sizes for the ticket illustration (SpriteKit uses ``spriteKitSize``).
enum TicketPickupLayout {
    static let spriteKitSize = CGSize(width: 44, height: 56)
    static let spriteKitAnchor = CGPoint(x: 0.5, y: 0.5)
}

enum TicketPickupDisplaySize {
    case compact
    case playfield
    case standard

    var dimensions: CGSize {
        switch self {
        case .compact:
            CGSize(width: 22, height: 28)
        case .playfield:
            CGSize(width: 32, height: 40)
        case .standard:
            TicketPickupLayout.spriteKitSize
        }
    }
}

enum TicketPickupState: Equatable {
    case available
    case collected
}

struct TicketPickupView: View {
    var state: TicketPickupState = .available
    var accentColor: Color = HotWheelsTheme.racingYellow
    var displaySize: TicketPickupDisplaySize = .playfield

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var shimmer = false

    private var dimensions: CGSize { displaySize.dimensions }

    var body: some View {
        ZStack {
            ticketBody
            if state == .collected {
                collectedOverlay
            }
            if state == .available, displaySize != .compact {
                availableSparkle
            }
        }
        .frame(width: dimensions.width, height: dimensions.height)
        .opacity(state == .collected ? 0.72 : 1)
        .scaleEffect(shimmerScale)
        .accessibilityLabel(accessibilityLabel)
        .onAppear(perform: runShimmerAnimation)
        .onChange(of: state) { _, _ in
            shimmer = false
            runShimmerAnimation()
        }
    }

    private var shimmerScale: CGFloat {
        guard state == .available, shimmer, !reduceMotion, displaySize == .playfield else {
            return 1
        }
        return 1.06
    }

    private var ticketBody: some View {
        let corner = dimensions.width * 0.14
        return ZStack {
            RoundedRectangle(cornerRadius: corner, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            accentColor,
                            HotWheelsTheme.racingYellow,
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            RoundedRectangle(cornerRadius: corner, style: .continuous)
                .strokeBorder(HotWheelsTheme.hotRed, lineWidth: max(1.5, dimensions.width * 0.07))

            perforationLine

            Text("T")
                .font(.system(size: dimensions.width * 0.42, weight: .black, design: .rounded))
                .foregroundStyle(HotWheelsTheme.hotRed.opacity(0.85))
                .offset(y: -dimensions.height * 0.04)
        }
        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.4), radius: 0, x: 0, y: dimensions.height * 0.06)
    }

    private var perforationLine: some View {
        Path { path in
            let midX = dimensions.width * 0.5
            path.move(to: CGPoint(x: midX, y: dimensions.height * 0.18))
            path.addLine(to: CGPoint(x: midX, y: dimensions.height * 0.82))
        }
        .stroke(
            HotWheelsTheme.hotRed.opacity(0.65),
            style: StrokeStyle(
                lineWidth: max(1, dimensions.width * 0.06),
                lineCap: .round,
                dash: [2, 3]
            )
        )
    }

    private var collectedOverlay: some View {
        ZStack {
            Circle()
                .fill(HotWheelsTheme.trackBlack.opacity(0.55))
                .frame(width: dimensions.width * 0.55, height: dimensions.width * 0.55)
            Image(systemName: "checkmark")
                .font(.system(size: dimensions.width * 0.32, weight: .black))
                .foregroundStyle(HotWheelsTheme.racingYellow)
        }
    }

    private var availableSparkle: some View {
        Image(systemName: "sparkle")
            .font(.system(size: dimensions.width * 0.22, weight: .bold))
            .foregroundStyle(HotWheelsTheme.flameOrange)
            .offset(x: dimensions.width * 0.34, y: -dimensions.height * 0.36)
            .opacity(shimmer && !reduceMotion ? 1 : 0.65)
            .accessibilityHidden(true)
    }

    private var accessibilityLabel: String {
        switch state {
        case .available:
            "Collectible ticket"
        case .collected:
            "Collected ticket"
        }
    }

    private func runShimmerAnimation() {
        guard state == .available, !reduceMotion, displaySize == .playfield else { return }
        withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
            shimmer = true
        }
    }
}

/// Dev preview: tickets spaced like ``Course/ticketFractions`` along a rope mock.
struct TicketPickupPlacementPreview: View {
    let ticketCount: Int
    var collectedCount: Int = 0

    private var fractions: [Double] {
        guard ticketCount > 0 else { return [] }
        return (1 ... ticketCount).map { Double($0) / Double(ticketCount + 1) }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ropeMock(in: geometry.size)

                ForEach(Array(fractions.enumerated()), id: \.offset) { index, fraction in
                    let state: TicketPickupState = index < collectedCount ? .collected : .available
                    TicketPickupView(state: state, displaySize: .playfield)
                        .position(ropePoint(at: CGFloat(fraction), in: geometry.size))
                }
            }
        }
        .frame(height: 160)
        .padding()
        .background(HotWheelsTheme.trackBlack.opacity(0.9))
    }

    private func ropeMock(in size: CGSize) -> some View {
        Path { path in
            path.move(to: CGPoint(x: size.width * 0.06, y: size.height * 0.58))
            path.addCurve(
                to: CGPoint(x: size.width * 0.94, y: size.height * 0.52),
                control1: CGPoint(x: size.width * 0.35, y: size.height * 0.38),
                control2: CGPoint(x: size.width * 0.65, y: size.height * 0.72)
            )
        }
        .stroke(HotWheelsTheme.trackBlack, style: StrokeStyle(lineWidth: 8, lineCap: .round))
    }

    private func ropePoint(at fraction: CGFloat, in size: CGSize) -> CGPoint {
        let baseline = size.height * 0.55
        let x = size.width * (0.06 + fraction * 0.88)
        let wave = sin(fraction * .pi * 2) * size.height * 0.06
        return CGPoint(x: x, y: baseline + wave)
    }
}

#Preview("Sizes") {
  HStack(spacing: 20) {
    TicketPickupView(displaySize: .compact)
    TicketPickupView(displaySize: .playfield)
    TicketPickupView(displaySize: .standard)
  }
  .padding()
  .background(HotWheelsTheme.trackBlack)
}

#Preview("States") {
  HStack(spacing: 24) {
    TicketPickupView(state: .available, displaySize: .playfield)
    TicketPickupView(state: .collected, displaySize: .playfield)
  }
  .padding()
  .background(HotWheelsTheme.trackBlack)
}

#Preview("Rope placement") {
  TicketPickupPlacementPreview(ticketCount: 4, collectedCount: 2)
}
