//
//  RacingStripeBackground.swift
//  Tight Rope Car
//

import SwiftUI

struct RacingStripeBackground: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let stripeWidth: CGFloat = 28
    @State private var stripeOffset: CGFloat = 0
    @State private var deepStripeOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let diagonal = sqrt(
                geometry.size.width * geometry.size.width +
                geometry.size.height * geometry.size.height
            )

            ZStack {
                HotWheelsTheme.backgroundGradient

                stripeLayer(diagonal: diagonal, opacity: 1, offset: stripeOffset)

                stripeLayer(diagonal: diagonal, opacity: 0.55, offset: deepStripeOffset + stripeWidth * 0.5)

                LandingAmbientSparkles()
                    .opacity(reduceMotion ? 0.35 : 0.55)

                vignetteOverlay
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: startStripeScroll)
    }

    private func stripeLayer(diagonal: CGFloat, opacity: Double, offset: CGFloat) -> some View {
        Canvas { context, size in
            let stripeCount = Int(diagonal / stripeWidth) + 6
            let baseOffset = -diagonal / 2 + offset

            for index in 0 ..< stripeCount {
                let x = baseOffset + CGFloat(index) * stripeWidth
                var path = Path()
                path.move(to: CGPoint(x: x, y: -size.height))
                path.addLine(to: CGPoint(x: x + size.height, y: size.height))
                path.addLine(to: CGPoint(x: x + stripeWidth + size.height, y: size.height))
                path.addLine(to: CGPoint(x: x + stripeWidth, y: -size.height))
                path.closeSubpath()

                let isOrange = index.isMultiple(of: 2)
                context.fill(
                    path,
                    with: .color(
                        (isOrange ? HotWheelsTheme.flameOrange : HotWheelsTheme.electricBlue)
                            .opacity((isOrange ? 0.35 : 0.3) * opacity)
                    )
                )
            }
        }
        .rotationEffect(.degrees(-25))
    }

    private var vignetteOverlay: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color.clear,
                    HotWheelsTheme.trackBlack.opacity(0.45),
                ],
                center: .center,
                startRadius: 80,
                endRadius: 420
            )

            LinearGradient(
                colors: [
                    HotWheelsTheme.trackBlack.opacity(0.35),
                    Color.clear,
                    HotWheelsTheme.trackBlack.opacity(0.25),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .allowsHitTesting(false)
    }

    private func startStripeScroll() {
        guard !reduceMotion else { return }
        stripeOffset = 0
        deepStripeOffset = 0
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
            stripeOffset = stripeWidth * 2
        }
        withAnimation(.linear(duration: 16).repeatForever(autoreverses: false)) {
            deepStripeOffset = stripeWidth * 2
        }
    }
}

/// Soft bokeh-style dots over the landing stripes.
private struct LandingAmbientSparkles: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var drift = false

    private let specs: [(x: CGFloat, y: CGFloat, size: CGFloat, color: Color)] = [
        (0.12, 0.18, 6, HotWheelsTheme.racingYellow),
        (0.82, 0.22, 5, HotWheelsTheme.racingYellow),
        (0.28, 0.72, 4, .white),
        (0.68, 0.65, 7, HotWheelsTheme.electricBlue),
        (0.5, 0.38, 5, HotWheelsTheme.flameOrange),
        (0.9, 0.78, 4, .white),
    ]

    var body: some View {
        GeometryReader { geometry in
            ForEach(Array(specs.enumerated()), id: \.offset) { index, spec in
                Circle()
                    .fill(spec.color.opacity(0.55))
                    .frame(width: spec.size, height: spec.size)
                    .position(
                        x: geometry.size.width * spec.x + (drift && !reduceMotion ? driftOffset(index) : 0),
                        y: geometry.size.height * spec.y
                    )
                    .blur(radius: 0.5)
            }
        }
        .allowsHitTesting(false)
        .onAppear(perform: startDrift)
    }

    private func driftOffset(_ index: Int) -> CGFloat {
        index.isMultiple(of: 2) ? 6 : -5
    }

    private func startDrift() {
        guard !reduceMotion else { return }
        withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
            drift = true
        }
    }
}

#Preview {
    RacingStripeBackground()
}
