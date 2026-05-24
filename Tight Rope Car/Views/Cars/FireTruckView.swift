//
//  FireTruckView.swift
//  Tight Rope Car
//
//  Premium side-view fire truck renderer.
//

import SwiftUI

/// Die-cast style fire engine side view.
struct FireTruckView: View {
    let appearance: CarAppearance
    let size: CGSize

    private var wheelDiameter: CGFloat {
        size.height * 0.45 * appearance.wheelSizeMultiplier
    }

    private var wheelSpacing: CGFloat {
        size.width * 0.35 * appearance.wheelSpacingMultiplier
    }

    private var bodyWidth: CGFloat {
        size.width * 0.85
    }

    private var bodyHeight: CGFloat {
        size.height * 0.6
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                fireWheel
                fireWheel
            }

            fireTruckBodyStack
                .offset(y: -wheelDiameter * 0.38)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.24))
            .frame(width: bodyWidth * 0.94, height: size.height * 0.11)
            .offset(y: -wheelDiameter * 0.05)
    }

    private var wheelContactShadows: some View {
        HStack(spacing: wheelSpacing) {
            wheelShadowEllipse
            wheelShadowEllipse
        }
        .offset(y: -wheelDiameter * 0.02)
    }

    private var wheelShadowEllipse: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.3))
            .frame(width: wheelDiameter * 1.08, height: wheelDiameter * 0.24)
    }

    // MARK: - Wheels

    private var fireWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.9),
                            appearance.accentColor,
                            HotWheelsTheme.trackBlack,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(Color(white: 0.66).opacity(0.5), lineWidth: wheelDiameter * 0.048)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.4),
                            appearance.accentColor.opacity(0.9),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.66, height: wheelDiameter * 0.66)

            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: wheelDiameter * 0.025)
                .frame(width: wheelDiameter * 0.66, height: wheelDiameter * 0.66)

            ForEach(0..<6, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.17))
                    .frame(width: wheelDiameter * 0.04, height: wheelDiameter * 0.16)
                    .offset(y: -wheelDiameter * 0.2)
                    .rotationEffect(.degrees(Double(index) * 60))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(white: 0.72), appearance.accentColor],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.12
                    )
                )
                .frame(width: wheelDiameter * 0.2, height: wheelDiameter * 0.2)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var fireTruckBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.26)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.32)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.2)

        return ZStack {
            FireTruckBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.28, y: 0),
                        endPoint: UnitPoint(x: 0.62, y: 1)
                    )
                )

            FireTruckBodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.4),
                            appearance.accentColor.opacity(0.85),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.72
                )

            FireTruckBodyShape()
                .stroke(Color.white.opacity(0.18), lineWidth: 0.35)
                .padding(1.1)
                .blendMode(.plusLighter)

            FireTruckLadderBaseShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            FireTruckLadderStripeShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.racingYellow, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            FireTruckLightBarShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, HotWheelsTheme.electricBlue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    FireTruckLightBarShape()
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.32)
                }

            FireTruckRockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.5), appearance.accentColor.opacity(0.42)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            FireTruckCabGlassShape()
                .fill(windowGradient)
                .overlay {
                    FireTruckCabGlassShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.38)
                }

            FireTruckCompartmentDoorShape()
                .stroke(appearance.accentColor.opacity(0.45), lineWidth: 0.42)

            FireTruckGrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            FireTruckHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.9)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.06
                    )
                )

            FireTruckTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            FireTruckHoseReelShape()
                .fill(
                    RadialGradient(
                        colors: [appearance.accentColor.opacity(0.75), HotWheelsTheme.trackBlack],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.05
                    )
                )
                .overlay {
                    FireTruckHoseReelShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.32)
                }

            FireTruckBumperShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.55), appearance.accentColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            FireTruckWheelArchShape()
                .stroke(appearance.accentColor.opacity(0.38), lineWidth: 0.45)
        }
        .frame(width: bodyWidth, height: bodyHeight * 1.08)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.56),
                HotWheelsTheme.electricBlue.opacity(0.28),
                appearance.accentColor.opacity(0.55),
            ],
            startPoint: UnitPoint(x: 0.12, y: 0),
            endPoint: UnitPoint(x: 0.88, y: 1)
        )
    }
}

// MARK: - Body silhouette (cab + apparatus body)

private struct FireTruckBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY
        let cabEnd = w * 0.38

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.18))
        path.addLine(to: CGPoint(x: w * 0.05, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.12, y: ground - h * 0.38),
            control: CGPoint(x: w * 0.06, y: ground - h * 0.3)
        )
        path.addLine(to: CGPoint(x: w * 0.14, y: ground - h * 0.86))
        path.addLine(to: CGPoint(x: cabEnd, y: ground - h * 0.88))
        path.addLine(to: CGPoint(x: w * 0.98, y: ground - h * 0.12))
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.22))
        path.addLine(to: CGPoint(x: cabEnd, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.18),
            control: CGPoint(x: w * 0.2, y: ground - h * 0.14)
        )
        path.closeSubpath()
        return path
    }
}

private struct FireTruckLadderBaseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(
            x: rect.width * 0.4,
            y: rect.height * 0.02,
            width: rect.width * 0.56,
            height: rect.height * 0.14
        ))
        return path
    }
}

private struct FireTruckLadderStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let ladderRect = CGRect(
            x: rect.width * 0.42,
            y: rect.height * 0.03,
            width: rect.width * 0.52,
            height: rect.height * 0.12
        )
        let stripeCount = 5
        let stripeWidth = ladderRect.width / CGFloat(stripeCount * 2)
        for index in 0..<stripeCount where index % 2 == 0 {
            let x = ladderRect.minX + CGFloat(index) * stripeWidth * 2
            path.addRect(CGRect(x: x, y: ladderRect.minY, width: stripeWidth, height: ladderRect.height))
        }
        return path
    }
}

private struct FireTruckLightBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.08, y: rect.height * 0.14, width: rect.width * 0.22, height: rect.height * 0.06),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct FireTruckRockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.1, y: rect.height * 0.66, width: rect.width * 0.86, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct FireTruckCabGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.1, y: rect.height * 0.22, width: rect.width * 0.2, height: rect.height * 0.32)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.15, height: glass.height * 0.15))
        return path
    }
}

private struct FireTruckCompartmentDoorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let doorWidth = rect.width * 0.14
        let startX = rect.width * 0.44
        let doorY = rect.height * 0.28
        let doorHeight = rect.height * 0.38
        for index in 0..<3 {
            let x = startX + CGFloat(index) * (doorWidth + rect.width * 0.02)
            path.addRoundedRect(
                in: CGRect(x: x, y: doorY, width: doorWidth, height: doorHeight),
                cornerSize: CGSize(width: 2, height: 2)
            )
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.42))
    }
}

private struct FireTruckGrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.44, width: rect.width * 0.1, height: rect.height * 0.22),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct FireTruckHeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.05
        let center = CGPoint(x: rect.width * 0.07, y: rect.height * 0.48)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct FireTruckTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.94, y: rect.height * 0.38, width: rect.width * 0.04, height: rect.height * 0.16),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct FireTruckHoseReelShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.055
        let center = CGPoint(x: rect.width * 0.72, y: rect.height * 0.48)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct FireTruckBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.72, width: rect.width * 0.11, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct FireTruckWheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.08, y: rect.height * 0.54, width: rect.width * 0.22, height: rect.height * 0.24),
            CGRect(x: rect.width * 0.62, y: rect.height * 0.54, width: rect.width * 0.24, height: rect.height * 0.24),
        ]
        for arch in arches {
            path.addEllipse(in: arch)
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.45))
    }
}

// MARK: - Color helpers

private extension Color {
    func mix(with other: Color, amount: CGFloat) -> Color {
        let amount = min(max(amount, 0), 1)
        #if canImport(UIKit)
        let uiSelf = UIColor(self)
        let uiOther = UIColor(other)
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        uiSelf.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiOther.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        return Color(
            red: Double(r1 + (r2 - r1) * amount),
            green: Double(g1 + (g2 - g1) * amount),
            blue: Double(b1 + (b2 - b1) * amount),
            opacity: Double(a1 + (a2 - a1) * amount)
        )
        #else
        return self.opacity(1 - amount).overlay(other.opacity(amount))
        #endif
    }
}

#Preview("Fire truck standalone") {
    CarView(
        car: CarDesign.fireTruck.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
