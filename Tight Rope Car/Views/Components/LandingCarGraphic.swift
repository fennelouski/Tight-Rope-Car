//
//  LandingCarGraphic.swift
//  Tight Rope Car
//

import SwiftUI

struct LandingCarGraphic: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var balance: CGFloat = -1
    @State private var ropeSag: CGFloat = 0
    @State private var dashPhase: CGFloat = 0

    private let carWidth: CGFloat = 110
    private let lateralOffsetScale: Double = 0.08

    var body: some View {
        ZStack {
            ropeAndSupports
            car
        }
        .frame(height: 220)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Car balancing on a tight rope")
        .onAppear(perform: startIdleAnimations)
    }

    /// Blaze Runner — same die-cast look as garage default (`CarCatalog.defaultCar`).
    private var heroAppearance: CarAppearance {
        CarCatalog.defaultCar.appearance
    }

    private var motionBalance: CGFloat {
        reduceMotion ? 0 : balance
    }

    private var lateralOffsetPixels: CGFloat {
        motionBalance * carWidth * CGFloat(lateralOffsetScale)
    }

    private var ropeAndSupports: some View {
        ZStack {
            supportTower
                .offset(x: -120, y: 44)

            supportTower
                .offset(x: 120, y: 44)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.trackBlack.opacity(0.55),
                    style: StrokeStyle(lineWidth: 9, lineCap: .round)
                )
                .frame(width: 270, height: 84)
                .offset(y: 22)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.hotRed.opacity(0.35),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 270, height: 84)
                .offset(y: 21)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.trackBlack,
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .frame(width: 270, height: 84)
                .offset(y: 20)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.racingYellow.opacity(0.75),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .frame(width: 270, height: 84)
                .offset(y: 18)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    Color.white.opacity(0.45),
                    style: StrokeStyle(
                        lineWidth: 1.5,
                        lineCap: .round,
                        dash: [5, 5],
                        dashPhase: dashPhase
                    )
                )
                .frame(width: 270, height: 84)
                .offset(y: 17)
        }
    }

    private var supportTower: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.electricBlue, HotWheelsTheme.electricBlue.opacity(0.7)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 8, height: 54)
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(HotWheelsTheme.trackBlack)
                .frame(width: 28, height: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .strokeBorder(HotWheelsTheme.racingYellow.opacity(0.6), lineWidth: 1)
                )
        }
        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.4), radius: 0, x: 0, y: 3)
    }

    private var car: some View {
        ZStack {
            Ellipse()
                .fill(HotWheelsTheme.trackBlack.opacity(0.35))
                .frame(width: 100, height: 18)
                .offset(x: lateralOffsetPixels, y: 52)
                .blur(radius: 2)

            CarView(
                car: Car(
                    lateralOffset: Double(motionBalance) * lateralOffsetScale,
                    tiltRadians: Double(motionBalance) * 0.09,
                    appearance: heroAppearance
                ),
                size: CGSize(width: carWidth, height: 50)
            )
        }
        .offset(y: -10)
    }

    private func startIdleAnimations() {
        guard !reduceMotion else { return }

        withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
            balance = 1
        }

        withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
            ropeSag = 1
        }

        withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
            dashPhase = 20
        }
    }
}

private struct AnimatedRopeShape: Shape {
    var sagAmount: CGFloat

    var animatableData: CGFloat {
        get { sagAmount }
        set { sagAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let sag = 30 + (sagAmount * 6)
        path.move(to: CGPoint(x: 0, y: rect.midY + 10))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.midY + 10),
            control: CGPoint(x: rect.midX, y: rect.midY + sag)
        )
        return path
    }
}

#Preview {
    ZStack {
        RacingStripeBackground()
        LandingCarGraphic()
    }
}
