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
    private let carHeight: CGFloat = 50
    private let lateralOffsetScale: Double = 0.08
    private let ropeCurve = LandingRopeCurve()
    /// Distance from ZStack center to car wheel contact (half car height minus rope stroke).
    private let carBottomInset: CGFloat = 22
    /// Extra drop so wheels visually meet the rope surface.
    private let carVerticalAdjust: CGFloat = 16
    private let balanceWobbleTilt: Double = 0.03
    private let shadowBelowValley: CGFloat = 32

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

    private var effectiveSagAmount: CGFloat {
        reduceMotion ? 0 : ropeSag
    }

    /// Small lateral sway in points (matches pre-rope-geometry idle motion).
    private var lateralSwayPixels: CGFloat {
        motionBalance * carWidth * CGFloat(lateralOffsetScale)
    }

    /// Sample the sagging rope near center so balance reads as wobble, not a full crossing.
    private var ropeProgress: CGFloat {
        0.5 + lateralSwayPixels / ropeCurve.width
    }

    private var carWorldOffset: CGPoint {
        let ropePos = ropeCurve.worldPosition(at: ropeProgress, sagAmount: effectiveSagAmount)
        return CGPoint(
            x: ropePos.x,
            y: ropePos.y - carBottomInset + carVerticalAdjust
        )
    }

    private var carRopeTangentAngle: CGFloat {
        ropeCurve.tangentAngle(at: ropeProgress, sagAmount: effectiveSagAmount)
    }

    private var shadowYOffset: CGFloat {
        let valley = ropeCurve.worldPosition(at: 0.5, sagAmount: effectiveSagAmount)
        return valley.y + shadowBelowValley - carWorldOffset.y
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
                .frame(width: ropeCurve.width, height: ropeCurve.height)
                .offset(y: 22)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.hotRed.opacity(0.35),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: ropeCurve.width, height: ropeCurve.height)
                .offset(y: 21)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.trackBlack,
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .frame(width: ropeCurve.width, height: ropeCurve.height)
                .offset(y: ropeCurve.frameOffsetY)

            AnimatedRopeShape(sagAmount: ropeSag)
                .stroke(
                    HotWheelsTheme.racingYellow.opacity(0.75),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .frame(width: ropeCurve.width, height: ropeCurve.height)
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
                .frame(width: ropeCurve.width, height: ropeCurve.height)
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
                .offset(y: shadowYOffset)
                .blur(radius: 2)

            CarView(
                car: Car(
                    lateralOffset: 0,
                    tiltRadians: Double(carRopeTangentAngle) + Double(motionBalance) * balanceWobbleTilt,
                    appearance: heroAppearance
                ),
                size: CGSize(width: carWidth, height: carHeight)
            )
        }
        .offset(x: carWorldOffset.x, y: carWorldOffset.y)
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

// MARK: - Rope geometry

/// Quadratic tightrope curve shared by `AnimatedRopeShape` and car placement.
struct LandingRopeCurve {
    let width: CGFloat = 270
    let height: CGFloat = 84
    let frameOffsetY: CGFloat = 20

    func sagPixels(sagAmount: CGFloat) -> CGFloat {
        30 + sagAmount * 6
    }

    func bezierPoints(sagAmount: CGFloat, in rect: CGRect) -> (start: CGPoint, control: CGPoint, end: CGPoint) {
        let sag = sagPixels(sagAmount: sagAmount)
        return (
            CGPoint(x: 0, y: rect.midY + 10),
            CGPoint(x: rect.midX, y: rect.midY + sag),
            CGPoint(x: rect.width, y: rect.midY + 10)
        )
    }

    func standardRect() -> CGRect {
        CGRect(x: 0, y: 0, width: width, height: height)
    }

    func point(at t: CGFloat, sagAmount: CGFloat, in rect: CGRect? = nil) -> CGPoint {
        let rect = rect ?? standardRect()
        let points = bezierPoints(sagAmount: sagAmount, in: rect)
        let clamped = min(max(t, 0), 1)
        let oneMinusT = 1 - clamped
        let x = oneMinusT * oneMinusT * points.start.x
            + 2 * oneMinusT * clamped * points.control.x
            + clamped * clamped * points.end.x
        let y = oneMinusT * oneMinusT * points.start.y
            + 2 * oneMinusT * clamped * points.control.y
            + clamped * clamped * points.end.y
        return CGPoint(x: x, y: y)
    }

    func tangent(at t: CGFloat, sagAmount: CGFloat, in rect: CGRect? = nil) -> CGVector {
        let rect = rect ?? standardRect()
        let points = bezierPoints(sagAmount: sagAmount, in: rect)
        let clamped = min(max(t, 0), 1)
        let dx = 2 * (1 - clamped) * (points.control.x - points.start.x)
            + 2 * clamped * (points.end.x - points.control.x)
        let dy = 2 * (1 - clamped) * (points.control.y - points.start.y)
            + 2 * clamped * (points.end.y - points.control.y)
        return CGVector(dx: dx, dy: dy)
    }

    func tangentAngle(at t: CGFloat, sagAmount: CGFloat) -> CGFloat {
        let vector = tangent(at: t, sagAmount: sagAmount)
        return atan2(vector.dy, vector.dx)
    }

    func worldPosition(at t: CGFloat, sagAmount: CGFloat) -> CGPoint {
        let local = point(at: t, sagAmount: sagAmount)
        return CGPoint(
            x: local.x - width / 2,
            y: local.y - height / 2 + frameOffsetY
        )
    }

    func path(in rect: CGRect, sagAmount: CGFloat) -> Path {
        let points = bezierPoints(sagAmount: sagAmount, in: rect)
        var path = Path()
        path.move(to: points.start)
        path.addQuadCurve(to: points.end, control: points.control)
        return path
    }
}

private struct AnimatedRopeShape: Shape {
    var sagAmount: CGFloat

    var animatableData: CGFloat {
        get { sagAmount }
        set { sagAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        LandingRopeCurve().path(in: rect, sagAmount: sagAmount)
    }
}

#Preview {
    ZStack {
        RacingStripeBackground()
        LandingCarGraphic()
    }
}
