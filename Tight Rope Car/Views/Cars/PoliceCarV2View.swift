//
//  PoliceCarV2View.swift
//  Tight Rope Car
//
//  Premium side-view police cruiser renderer (v2).
//

import SwiftUI

/// Die-cast style police car drawing for ``CarRenderVersion/v2``.
struct PoliceCarV2View: View {
    let appearance: CarAppearance
    let size: CGSize

    private var wheelDiameter: CGFloat {
        size.height * 0.45 * appearance.wheelSizeMultiplier
    }

    private var wheelSpacing: CGFloat {
        size.width * 0.12 * appearance.wheelSpacingMultiplier
    }

    private var bodyWidth: CGFloat {
        size.width * 0.85 * appearance.bodyAspectRatio
    }

    private var bodyHeight: CGFloat {
        size.height * 0.54
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                policeWheel
                policeWheel
            }

            policeBodyStack
                .offset(y: -wheelDiameter * 0.35)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.88, height: size.height * 0.1)
            .offset(y: -wheelDiameter * 0.06)
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
            .fill(HotWheelsTheme.trackBlack.opacity(0.28))
            .frame(width: wheelDiameter * 1.04, height: wheelDiameter * 0.22)
    }

    // MARK: - Wheels

    private var policeWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.85),
                            HotWheelsTheme.trackBlack.opacity(0.9),
                            HotWheelsTheme.trackBlack,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(appearance.bodyColor.opacity(0.4), lineWidth: wheelDiameter * 0.044)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.48),
                            appearance.accentColor.opacity(0.35),
                            HotWheelsTheme.trackBlack.opacity(0.85),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            Circle()
                .strokeBorder(Color.white.opacity(0.28), lineWidth: wheelDiameter * 0.024)
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.16))
                    .frame(width: wheelDiameter * 0.044, height: wheelDiameter * 0.16)
                    .offset(y: -wheelDiameter * 0.21)
                    .rotationEffect(.degrees(Double(index) * 72))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.12
                    )
                )
                .frame(width: wheelDiameter * 0.19, height: wheelDiameter * 0.19)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var policeBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.28)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.32)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.18)

        return ZStack {
            PoliceCarV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.58, y: 1)
                    )
                )

            PoliceCarV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.42),
                            appearance.accentColor.opacity(0.75),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.68
                )

            PoliceCarV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.34)
                .padding(1)
                .blendMode(.plusLighter)

            PoliceCarV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.48), appearance.accentColor.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            PoliceCarV2DoorAccentShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, appearance.accentColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.08)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    PoliceCarV2DoorAccentShape()
                        .stroke(appearance.bodyColor.opacity(0.25), lineWidth: 0.32)
                }

            PoliceCarV2WindowShape()
                .fill(windowGradient)
                .overlay {
                    PoliceCarV2WindowShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.38)
                }

            PoliceCarV2LightBarShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, HotWheelsTheme.electricBlue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    PoliceCarV2LightBarShape()
                        .stroke(Color.white.opacity(0.28), lineWidth: 0.32)
                }

            PoliceCarV2PushBarShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), HotWheelsTheme.trackBlack.opacity(0.85)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            PoliceCarV2GrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.85), HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            PoliceCarV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.065
                    )
                )

            PoliceCarV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.bodyColor.opacity(0.9)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            PoliceCarV2SideStripeShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), appearance.accentColor.opacity(0.5)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            PoliceCarV2MirrorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack.opacity(0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            PoliceCarV2WheelArchShape()
                .stroke(appearance.accentColor.opacity(0.38), lineWidth: 0.4)
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.8)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.56),
                HotWheelsTheme.electricBlue.opacity(0.3),
                appearance.bodyColor.opacity(0.45),
            ],
            startPoint: UnitPoint(x: 0.15, y: 0),
            endPoint: UnitPoint(x: 0.85, y: 1)
        )
    }
}

// MARK: - Body silhouette (cruiser sedan)

private struct PoliceCarV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.18))
        path.addLine(to: CGPoint(x: w * 0.06, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.2, y: ground - h * 0.38),
            control: CGPoint(x: w * 0.1, y: ground - h * 0.28)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.4, y: ground - h * 0.7),
            control: CGPoint(x: w * 0.28, y: ground - h * 0.54)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.58, y: ground - h * 0.74),
            control: CGPoint(x: w * 0.5, y: ground - h * 0.8)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.84, y: ground - h * 0.42),
            control: CGPoint(x: w * 0.72, y: ground - h * 0.56)
        )
        path.addLine(to: CGPoint(x: w * 0.97, y: ground - h * 0.3))
        path.addLine(to: CGPoint(x: w * 0.98, y: ground - h * 0.22))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.48, y: ground - h * 0.14),
            control: CGPoint(x: w * 0.74, y: ground - h * 0.1)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.18),
            control: CGPoint(x: w * 0.22, y: ground - h * 0.14)
        )
        path.closeSubpath()
        return path
    }
}

private struct PoliceCarV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.14, y: rect.height * 0.56, width: rect.width * 0.74, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PoliceCarV2DoorAccentShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.38, y: rect.height * 0.28, width: rect.width * 0.32, height: rect.height * 0.38),
            cornerSize: CGSize(width: 3, height: 3)
        )
        return path
    }
}

private struct PoliceCarV2WindowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.2, y: rect.height * 0.2, width: rect.width * 0.4, height: rect.height * 0.34)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.2, height: glass.height * 0.2))
        return path
    }
}

private struct PoliceCarV2LightBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.32, y: rect.height * 0.1, width: rect.width * 0.28, height: rect.height * 0.06),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PoliceCarV2PushBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.62, width: rect.width * 0.1, height: rect.height * 0.14),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PoliceCarV2GrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.44, width: rect.width * 0.09, height: rect.height * 0.2),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PoliceCarV2HeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.06
        let center = CGPoint(x: rect.width * 0.08, y: rect.height * 0.46)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct PoliceCarV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.91, y: rect.height * 0.4, width: rect.width * 0.06, height: rect.height * 0.14),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PoliceCarV2SideStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.22, y: rect.height * 0.5, width: rect.width * 0.58, height: rect.height * 0.04))
        return path
    }
}

private struct PoliceCarV2MirrorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.18, y: rect.height * 0.24, width: rect.width * 0.05, height: rect.height * 0.07),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct PoliceCarV2WheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.1, y: rect.height * 0.5, width: rect.width * 0.2, height: rect.height * 0.22),
            CGRect(x: rect.width * 0.66, y: rect.height * 0.5, width: rect.width * 0.2, height: rect.height * 0.22),
        ]
        for arch in arches {
            path.addEllipse(in: arch)
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.4))
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

#Preview("Police car v2 standalone") {
    CarView(
        car: CarDesign.policeCar.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
