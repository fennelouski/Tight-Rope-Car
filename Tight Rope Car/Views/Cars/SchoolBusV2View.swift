//
//  SchoolBusV2View.swift
//  Tight Rope Car
//
//  Premium side-view school bus renderer (v2).
//

import SwiftUI

/// Die-cast style school bus drawing for ``CarRenderVersion/v2``.
struct SchoolBusV2View: View {
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
                busWheel
                busWheel
            }

            schoolBusBodyStack
                .offset(y: -wheelDiameter * 0.42)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.24))
            .frame(width: bodyWidth * 0.94, height: size.height * 0.1)
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
            .fill(HotWheelsTheme.trackBlack.opacity(0.28))
            .frame(width: wheelDiameter * 1.06, height: wheelDiameter * 0.23)
    }

    // MARK: - Wheels

    private var busWheel: some View {
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
                .strokeBorder(Color(white: 0.68).opacity(0.5), lineWidth: wheelDiameter * 0.046)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.4),
                            appearance.accentColor.opacity(0.88),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.65, height: wheelDiameter * 0.65)

            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: wheelDiameter * 0.024)
                .frame(width: wheelDiameter * 0.65, height: wheelDiameter * 0.65)

            ForEach(0..<6, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.17))
                    .frame(width: wheelDiameter * 0.04, height: wheelDiameter * 0.15)
                    .offset(y: -wheelDiameter * 0.2)
                    .rotationEffect(.degrees(Double(index) * 60))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [HotWheelsTheme.racingYellow, appearance.accentColor],
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

    private var schoolBusBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.26)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.3)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.18)

        return ZStack {
            SchoolBusV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.28, y: 0),
                        endPoint: UnitPoint(x: 0.62, y: 1)
                    )
                )

            SchoolBusV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.42),
                            appearance.accentColor.opacity(0.8),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.7
                )

            SchoolBusV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.34)
                .padding(1)
                .blendMode(.plusLighter)

            SchoolBusV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.48), appearance.accentColor.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SchoolBusV2WindowRowShape()
                .fill(windowGradient)
                .overlay {
                    SchoolBusV2WindowRowShape()
                        .stroke(Color.white.opacity(0.34), lineWidth: 0.36)
                }

            SchoolBusV2WindshieldShape()
                .fill(windowGradient)
                .overlay {
                    SchoolBusV2WindshieldShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.38)
                }

            SchoolBusV2SideStripeShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            SchoolBusV2GrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SchoolBusV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.06
                    )
                )

            SchoolBusV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            SchoolBusV2StopArmShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    SchoolBusV2StopArmShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.3)
                }

            SchoolBusV2DoorShape()
                .stroke(appearance.accentColor.opacity(0.42), lineWidth: 0.42)

            SchoolBusV2RoofLightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed.opacity(0.9), HotWheelsTheme.racingYellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            SchoolBusV2FrontBumperShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SchoolBusV2WheelArchShape()
                .stroke(appearance.accentColor.opacity(0.35), lineWidth: 0.42)
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.95)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.56),
                HotWheelsTheme.electricBlue.opacity(0.26),
                appearance.accentColor.opacity(0.52),
            ],
            startPoint: UnitPoint(x: 0.12, y: 0),
            endPoint: UnitPoint(x: 0.88, y: 1)
        )
    }
}

// MARK: - Body silhouette (long bus, front left → rear right)

private struct SchoolBusV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.05, y: ground - h * 0.26))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.12, y: ground - h * 0.4),
            control: CGPoint(x: w * 0.06, y: ground - h * 0.32)
        )
        path.addLine(to: CGPoint(x: w * 0.14, y: ground - h * 0.88))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.22, y: ground - h * 0.92),
            control: CGPoint(x: w * 0.16, y: ground - h * 0.96)
        )
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.92))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.99, y: ground - h * 0.84),
            control: CGPoint(x: w * 0.99, y: ground - h * 0.9)
        )
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.88, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.96, y: ground - h * 0.14)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.2),
            control: CGPoint(x: w * 0.42, y: ground - h * 0.12)
        )
        path.closeSubpath()
        return path
    }
}

private struct SchoolBusV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.1, y: rect.height * 0.64, width: rect.width * 0.84, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SchoolBusV2WindowRowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let windowCount = 5
        let marginX = rect.width * 0.22
        let availableWidth = rect.width * 0.68
        let gap = availableWidth * 0.035
        let windowWidth = (availableWidth - gap * CGFloat(windowCount - 1)) / CGFloat(windowCount)
        let windowHeight = rect.height * 0.28
        let windowY = rect.height * 0.22

        for index in 0..<windowCount {
            let x = marginX + CGFloat(index) * (windowWidth + gap)
            path.addRoundedRect(
                in: CGRect(x: x, y: windowY, width: windowWidth, height: windowHeight),
                cornerSize: CGSize(width: windowHeight * 0.12, height: windowHeight * 0.12)
            )
        }
        return path
    }
}

private struct SchoolBusV2WindshieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.1, y: rect.height * 0.2, width: rect.width * 0.1, height: rect.height * 0.34)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.15, height: glass.height * 0.15))
        return path
    }
}

private struct SchoolBusV2SideStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.12, y: rect.height * 0.54, width: rect.width * 0.82, height: rect.height * 0.05))
        return path
    }
}

private struct SchoolBusV2GrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.44, width: rect.width * 0.09, height: rect.height * 0.22),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SchoolBusV2HeadlightShape: Shape {
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

private struct SchoolBusV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.94, y: rect.height * 0.4, width: rect.width * 0.04, height: rect.height * 0.18),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SchoolBusV2StopArmShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let pivot = CGPoint(x: rect.width * 0.28, y: rect.height * 0.38)
        path.move(to: pivot)
        path.addLine(to: CGPoint(x: rect.width * 0.22, y: rect.height * 0.32))
        path.addLine(to: CGPoint(x: rect.width * 0.22, y: rect.height * 0.44))
        path.closeSubpath()
        return path
    }
}

private struct SchoolBusV2DoorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.18, y: rect.height * 0.38, width: rect.width * 0.1, height: rect.height * 0.38),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path.strokedPath(StrokeStyle(lineWidth: 0.42))
    }
}

private struct SchoolBusV2RoofLightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.12, y: rect.height * 0.1, width: rect.width * 0.2, height: rect.height * 0.05),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SchoolBusV2FrontBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.7, width: rect.width * 0.1, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SchoolBusV2WheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.12, y: rect.height * 0.52, width: rect.width * 0.2, height: rect.height * 0.24),
            CGRect(x: rect.width * 0.68, y: rect.height * 0.52, width: rect.width * 0.2, height: rect.height * 0.24),
        ]
        for arch in arches {
            path.addEllipse(in: arch)
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.42))
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

#Preview("School bus v2 standalone") {
    CarView(
        car: CarDesign.schoolBus.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
