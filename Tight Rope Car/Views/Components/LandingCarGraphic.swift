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
            ropeAndSupports
            car
        }
        .frame(height: 200)
        .onAppear(perform: startIdleAnimations)
    }

    private var ropeAndSupports: some View {
        ZStack {
            supportTower
                .offset(x: -120, y: 40)

            supportTower
                .offset(x: 120, y: 40)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.trackBlack,
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .frame(width: 260, height: 80)
                .offset(y: 20)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    Color(white: 0.55),
                    style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [6, 4],
                        dashPhase: dashPhase
                    )
                )
                .frame(width: 260, height: 80)
                .offset(y: 18)
        }
    }

    private var supportTower: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(HotWheelsTheme.electricBlue)
                .frame(width: 8, height: 50)
            Rectangle()
                .fill(HotWheelsTheme.trackBlack)
                .frame(width: 24, height: 8)
        }
    }

    private var car: some View {
        ZStack {
            Circle()
                .fill(HotWheelsTheme.trackBlack)
                .frame(width: 22, height: 22)
                .offset(x: -28, y: 18)

            Circle()
                .fill(HotWheelsTheme.trackBlack)
                .frame(width: 22, height: 22)
                .offset(x: 28, y: 18)

            Circle()
                .fill(Color(white: 0.75))
                .frame(width: 10, height: 10)
                .offset(x: -28, y: 18)

            Circle()
                .fill(Color(white: 0.75))
                .frame(width: 10, height: 10)
                .offset(x: 28, y: 18)

            RoundedRectangle(cornerRadius: 10)
                .fill(HotWheelsTheme.hotRed)
                .frame(width: 90, height: 36)
                .offset(y: 4)

            RoundedRectangle(cornerRadius: 6)
                .fill(HotWheelsTheme.electricBlue)
                .frame(width: 40, height: 22)
                .offset(x: -8, y: -6)

            RoundedRectangle(cornerRadius: 4)
                .fill(HotWheelsTheme.racingYellow.opacity(0.8))
                .frame(width: 18, height: 10)
                .offset(x: -14, y: -8)

            FlameAccent()
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.racingYellow,
                            HotWheelsTheme.flameOrange,
                            HotWheelsTheme.hotRed
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 16 * flameScale, height: 14 * flameScale)
                .offset(x: 38, y: 2)
                .opacity(0.75 + flameScale * 0.25)
        }
        .offset(y: -8)
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
    LandingCarGraphic()
        .padding()
        .background(HotWheelsTheme.trackBlack)
}
