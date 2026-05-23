//
//  LandingCarGraphic.swift
//  Tight Rope Car
//

import SwiftUI

struct LandingCarGraphic: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var balance: CGFloat = -1
    @State private var ropeSag: CGFloat = 0
    @State private var flameScale: CGFloat = 1
    @State private var dashPhase: CGFloat = 0

    var body: some View {
        ZStack {
            carShadow
            ropeAndSupports
            heroTicket
            car
        }
        .frame(height: 220)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Car balancing on a tight rope")
        .onAppear(perform: startIdleAnimations)
    }

    private var carShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.35))
            .frame(width: 110, height: 18)
            .offset(y: 52)
            .blur(radius: 2)
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

    private var heroTicket: some View {
        TicketPickupView(displaySize: .compact)
            .offset(y: 8)
            .shadow(color: HotWheelsTheme.trackBlack.opacity(0.4), radius: 0, x: 0, y: 2)
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
            Circle()
                .fill(HotWheelsTheme.trackBlack)
                .frame(width: 24, height: 24)
                .offset(x: -30, y: 20)

            Circle()
                .fill(HotWheelsTheme.trackBlack)
                .frame(width: 24, height: 24)
                .offset(x: 30, y: 20)

            Circle()
                .fill(Color.white.opacity(0.85))
                .frame(width: 10, height: 10)
                .offset(x: -30, y: 20)

            Circle()
                .fill(Color.white.opacity(0.85))
                .frame(width: 10, height: 10)
                .offset(x: 30, y: 20)

            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(HotWheelsTheme.hotRed)
                .frame(width: 94, height: 38)
                .offset(y: 4)
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.35), Color.clear],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                        .offset(y: 4)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(HotWheelsTheme.trackBlack, lineWidth: 2)
                        .offset(y: 4)
                )

            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(HotWheelsTheme.electricBlue)
                .frame(width: 42, height: 24)
                .offset(x: -8, y: -6)

            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(HotWheelsTheme.racingYellow.opacity(0.9))
                .frame(width: 20, height: 11)
                .offset(x: -14, y: -8)

            FlameAccent()
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
                .frame(width: 16 * flameScale, height: 14 * flameScale)
                .offset(x: 40, y: 2)
                .opacity(0.75 + flameScale * 0.25)
        }
        .offset(y: -10)
        .rotationEffect(.degrees(balance * 5))
        .offset(x: balance * 6, y: balance * 2)
    }

    private func startIdleAnimations() {
        guard !reduceMotion else { return }

        withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
            balance = 1
        }

        withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
            ropeSag = 1
        }

        withAnimation(.easeInOut(duration: 0.35).repeatForever(autoreverses: true)) {
            flameScale = 1.25
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
            control: CGPoint(x: rect.midX, y: rect.midY - sag)
        )
        return path
    }
}

private struct FlameAccent: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.7, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ZStack {
        RacingStripeBackground()
        LandingCarGraphic()
    }
}
