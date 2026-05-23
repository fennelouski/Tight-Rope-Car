//
//  VanV2View.swift
//  Tight Rope Car
//
//  Premium side-view van renderer (v2).
//

import SwiftUI

/// Die-cast style cargo van drawing for ``CarRenderVersion/v2``.
struct VanV2View: View {
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
        size.height * 0.62
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                vanWheel
                vanWheel
            }

            vanBodyStack
                .offset(y: -wheelDiameter * 0.38)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.9, height: size.height * 0.1)
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
            .frame(width: wheelDiameter * 1.05, height: wheelDiameter * 0.23)
    }

    // MARK: - Wheels

    private var vanWheel: some View {
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
                            Color.white.opacity(0.52),
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

            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.18))
                    .frame(width: wheelDiameter * 0.042, height: wheelDiameter * 0.15)
                    .offset(y: -wheelDiameter * 0.2)
                    .rotationEffect(.degrees(Double(index) * 72))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(white: 0.76), appearance.accentColor.opacity(0.88)],
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

    private var vanBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.22)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.22)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.14)

        return ZStack {
            VanV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.62, y: 1)
                    )
                )

            VanV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.45),
                            appearance.accentColor.opacity(0.7),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.7
                )

            VanV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.35)
                .padding(1)
                .blendMode(.plusLighter)

            VanV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.45), appearance.accentColor.opacity(0.38)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VanV2WindowRowShape()
                .fill(windowGradient)
                .overlay {
                    VanV2WindowRowShape()
                        .stroke(Color.white.opacity(0.35), lineWidth: 0.38)
                }

            VanV2WindshieldShape()
                .fill(windowGradient)
                .overlay {
                    VanV2WindshieldShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.4)
                }

            VanV2GrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    VanV2GrilleShape()
                        .stroke(Color.white.opacity(0.14), lineWidth: 0.32)
                }

            VanV2FrontBumperShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VanV2RearBumperShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VanV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.85)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.06
                    )
                )
                .overlay {
                    VanV2HeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.32)
                }

            VanV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    VanV2TaillightShape()
                        .stroke(Color.white.opacity(0.16), lineWidth: 0.3)
                }

            VanV2SlidingDoorLineShape()
                .stroke(appearance.accentColor.opacity(0.42), lineWidth: 0.42)

            VanV2RoofRackShape()
                .stroke(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 0.5
                )

            VanV2SideMirrorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VanV2AccentStripeShape()
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.electricBlue.opacity(0.5),
                            appearance.accentColor.opacity(0.35),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            VanV2WheelArchShape()
                .stroke(appearance.accentColor.opacity(0.32), lineWidth: 0.42)
        }
        .frame(width: bodyWidth * 0.88, height: bodyHeight * 1.18)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.58),
                HotWheelsTheme.electricBlue.opacity(0.28),
                appearance.accentColor.opacity(0.52),
            ],
            startPoint: UnitPoint(x: 0.12, y: 0),
            endPoint: UnitPoint(x: 0.88, y: 1)
        )
    }
}

// MARK: - Body silhouette (tall box van, front left → rear right)

private struct VanV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.18))
        path.addLine(to: CGPoint(x: w * 0.04, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.12, y: ground - h * 0.38),
            control: CGPoint(x: w * 0.05, y: ground - h * 0.3)
        )
        path.addLine(to: CGPoint(x: w * 0.14, y: ground - h * 0.88))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.22, y: ground - h * 0.94),
            control: CGPoint(x: w * 0.16, y: ground - h * 0.98)
        )
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.94))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.99, y: ground - h * 0.86),
            control: CGPoint(x: w * 0.99, y: ground - h * 0.92)
        )
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.22))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.88, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.96, y: ground - h * 0.14)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.18),
            control: CGPoint(x: w * 0.42, y: ground - h * 0.12)
        )
        path.closeSubpath()
        return path
    }
}

private struct VanV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.1, y: rect.height * 0.68, width: rect.width * 0.84, height: rect.height * 0.08),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct VanV2WindowRowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let windowCount = 3
        let marginX = rect.width * 0.32
        let availableWidth = rect.width * 0.58
        let gap = availableWidth * 0.06
        let windowWidth = (availableWidth - gap * CGFloat(windowCount - 1)) / CGFloat(windowCount)
        let windowHeight = rect.height * 0.28
        let windowY = rect.height * 0.2

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

private struct VanV2WindshieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.1, y: rect.height * 0.18, width: rect.width * 0.2, height: rect.height * 0.36)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.2, height: glass.height * 0.2))
        return path
    }
}

private struct VanV2GrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let grille = CGRect(x: 0, y: rect.height * 0.48, width: rect.width * 0.09, height: rect.height * 0.2)
        path.addRoundedRect(in: grille, cornerSize: CGSize(width: 2, height: 2))
        let barWidth = grille.width * 0.2
        for index in 0..<3 {
            let x = grille.minX + CGFloat(index + 1) * barWidth
            path.addRect(CGRect(x: x, y: grille.minY + grille.height * 0.12, width: barWidth * 0.35, height: grille.height * 0.76))
        }
        return path
    }
}

private struct VanV2FrontBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.74, width: rect.width * 0.1, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct VanV2RearBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.92, y: rect.height * 0.72, width: rect.width * 0.08, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct VanV2HeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.05
        let center = CGPoint(x: rect.width * 0.07, y: rect.height * 0.5)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct VanV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.94, y: rect.height * 0.44, width: rect.width * 0.04, height: rect.height * 0.16),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct VanV2SlidingDoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let x = rect.width * 0.52
        path.move(to: CGPoint(x: x, y: rect.height * 0.52))
        path.addLine(to: CGPoint(x: x, y: rect.height * 0.24))
        return path.strokedPath(StrokeStyle(lineWidth: 0.42, lineCap: .round))
    }
}

private struct VanV2RoofRackShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rackY = rect.height * 0.1
        path.move(to: CGPoint(x: rect.width * 0.28, y: rackY))
        path.addLine(to: CGPoint(x: rect.width * 0.92, y: rackY))
        path.move(to: CGPoint(x: rect.width * 0.35, y: rackY + rect.height * 0.04))
        path.addLine(to: CGPoint(x: rect.width * 0.35, y: rackY))
        path.move(to: CGPoint(x: rect.width * 0.55, y: rackY + rect.height * 0.04))
        path.addLine(to: CGPoint(x: rect.width * 0.55, y: rackY))
        path.move(to: CGPoint(x: rect.width * 0.75, y: rackY + rect.height * 0.04))
        path.addLine(to: CGPoint(x: rect.width * 0.75, y: rackY))
        return path.strokedPath(StrokeStyle(lineWidth: 0.5, lineCap: .round))
    }
}

private struct VanV2SideMirrorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.26, y: rect.height * 0.24, width: rect.width * 0.05, height: rect.height * 0.07),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct VanV2AccentStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.3, y: rect.height * 0.54, width: rect.width * 0.55, height: rect.height * 0.04))
        return path
    }
}

private struct VanV2WheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.12, y: rect.height * 0.58, width: rect.width * 0.18, height: rect.height * 0.2),
            CGRect(x: rect.width * 0.68, y: rect.height * 0.58, width: rect.width * 0.18, height: rect.height * 0.2),
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

#Preview("Van v2 standalone") {
    CarView(
        car: CarDesign.van.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
