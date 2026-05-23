//
//  PickupV2View.swift
//  Tight Rope Car
//
//  Premium side-view pickup truck renderer (v2).
//

import SwiftUI

/// Die-cast style pickup truck drawing for ``CarRenderVersion/v2``.
struct PickupV2View: View {
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
        size.height * 0.58
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                pickupWheel
                pickupWheel
            }

            pickupBodyStack
                .offset(y: -wheelDiameter * 0.35)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.92, height: size.height * 0.1)
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
            .frame(width: wheelDiameter * 1.06, height: wheelDiameter * 0.24)
    }

    // MARK: - Wheels

    private var pickupWheel: some View {
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
                .strokeBorder(Color(white: 0.7).opacity(0.52), lineWidth: wheelDiameter * 0.048)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.42),
                            appearance.accentColor.opacity(0.9),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.66, height: wheelDiameter * 0.66)

            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: wheelDiameter * 0.024)
                .frame(width: wheelDiameter * 0.66, height: wheelDiameter * 0.66)

            ForEach(0..<6, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.18))
                    .frame(width: wheelDiameter * 0.04, height: wheelDiameter * 0.16)
                    .offset(y: -wheelDiameter * 0.2)
                    .rotationEffect(.degrees(Double(index) * 60))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(white: 0.75), appearance.accentColor.opacity(0.85)],
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

    private var pickupBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.28)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.3)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.18)
        let bedShadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.42)

        return ZStack {
            PickupV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.28, y: 0),
                        endPoint: UnitPoint(x: 0.6, y: 1)
                    )
                )

            PickupV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.4),
                            appearance.accentColor.opacity(0.75),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.7
                )

            PickupV2BodyShape()
                .stroke(Color.white.opacity(0.18), lineWidth: 0.35)
                .padding(1)
                .blendMode(.plusLighter)

            PickupV2BedInteriorShape()
                .fill(
                    LinearGradient(
                        colors: [bedShadow.opacity(0.7), appearance.accentColor.opacity(0.55)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            PickupV2BedRailShape()
                .stroke(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.55
                )

            PickupV2TailgateShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    PickupV2TailgateShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.35)
                }

            PickupV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.5), appearance.accentColor.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            PickupV2GrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    PickupV2GrilleShape()
                        .stroke(Color.white.opacity(0.15), lineWidth: 0.32)
                }

            PickupV2CabGlassShape()
                .fill(windowGradient)
                .overlay {
                    PickupV2CabGlassShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.4)
                }

            PickupV2SideStepShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    PickupV2SideStepShape()
                        .stroke(Color.white.opacity(0.18), lineWidth: 0.3)
                }

            PickupV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.07
                    )
                )
                .overlay {
                    PickupV2HeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.45), lineWidth: 0.35)
                }

            PickupV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    PickupV2TaillightShape()
                        .stroke(Color.white.opacity(0.18), lineWidth: 0.3)
                }

            PickupV2ToolboxShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    PickupV2ToolboxShape()
                        .stroke(Color.white.opacity(0.22), lineWidth: 0.35)
                }

            PickupV2WheelArchShape()
                .stroke(appearance.accentColor.opacity(0.35), lineWidth: 0.45)

            PickupV2DoorLineShape()
                .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.4)
        }
        .frame(width: bodyWidth, height: bodyHeight * 1.05)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.55),
                HotWheelsTheme.electricBlue.opacity(0.3),
                appearance.accentColor.opacity(0.58),
            ],
            startPoint: UnitPoint(x: 0.15, y: 0),
            endPoint: UnitPoint(x: 0.85, y: 1)
        )
    }
}

// MARK: - Body silhouette (cab left, bed right)

private struct PickupV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY
        let bedStart = w * 0.58

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.04, y: ground - h * 0.26))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.14, y: ground - h * 0.38),
            control: CGPoint(x: w * 0.06, y: ground - h * 0.3)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.28, y: ground - h * 0.72),
            control: CGPoint(x: w * 0.18, y: ground - h * 0.52)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.38, y: ground - h * 0.78),
            control: CGPoint(x: w * 0.34, y: ground - h * 0.84)
        )
        path.addLine(to: CGPoint(x: bedStart, y: ground - h * 0.76))
        path.addLine(to: CGPoint(x: w * 0.98, y: ground - h * 0.76))
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.68))
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.28))
        path.addLine(to: CGPoint(x: bedStart, y: ground - h * 0.28))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.42, y: ground - h * 0.24),
            control: CGPoint(x: w * 0.5, y: ground - h * 0.22)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.2),
            control: CGPoint(x: w * 0.2, y: ground - h * 0.16)
        )
        path.closeSubpath()
        return path
    }
}

private struct PickupV2BedInteriorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bed = CGRect(
            x: rect.width * 0.6,
            y: rect.height * 0.32,
            width: rect.width * 0.37,
            height: rect.height * 0.42
        )
        path.addRect(bed)
        return path
    }
}

private struct PickupV2BedRailShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bedTop = rect.height * 0.3
        let bedStart = rect.width * 0.58
        path.move(to: CGPoint(x: bedStart, y: bedTop))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: bedTop))
        path.move(to: CGPoint(x: bedStart, y: bedTop + rect.height * 0.04))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: bedTop + rect.height * 0.04))
        return path.strokedPath(StrokeStyle(lineWidth: 0.55, lineCap: .round))
    }
}

private struct PickupV2TailgateShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(
                x: rect.width * 0.9,
                y: rect.height * 0.34,
                width: rect.width * 0.08,
                height: rect.height * 0.38
            ),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PickupV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.12, y: rect.height * 0.6, width: rect.width * 0.82, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PickupV2GrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let grille = CGRect(x: 0, y: rect.height * 0.42, width: rect.width * 0.1, height: rect.height * 0.22)
        path.addRoundedRect(in: grille, cornerSize: CGSize(width: 2, height: 2))
        let barWidth = grille.width * 0.18
        for index in 0..<3 {
            let x = grille.minX + CGFloat(index + 1) * barWidth
            path.addRect(CGRect(x: x, y: grille.minY + grille.height * 0.15, width: barWidth * 0.35, height: grille.height * 0.7))
        }
        return path
    }
}

private struct PickupV2CabGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.18, y: rect.height * 0.2, width: rect.width * 0.22, height: rect.height * 0.38)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.28, height: glass.height * 0.28))
        return path
    }
}

private struct PickupV2SideStepShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.2, y: rect.height * 0.58, width: rect.width * 0.34, height: rect.height * 0.05),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PickupV2HeadlightShape: Shape {
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

private struct PickupV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.93, y: rect.height * 0.4, width: rect.width * 0.05, height: rect.height * 0.14),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct PickupV2ToolboxShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.64, y: rect.height * 0.38, width: rect.width * 0.18, height: rect.height * 0.14),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct PickupV2WheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.1, y: rect.height * 0.52, width: rect.width * 0.2, height: rect.height * 0.22),
            CGRect(x: rect.width * 0.68, y: rect.height * 0.52, width: rect.width * 0.22, height: rect.height * 0.22),
        ]
        for arch in arches {
            path.addEllipse(in: arch)
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.45))
    }
}

private struct PickupV2DoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.38, y: rect.height * 0.58))
        path.addLine(to: CGPoint(x: rect.width * 0.38, y: rect.height * 0.34))
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
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

#Preview("Pickup v2 standalone") {
    CarView(
        car: CarDesign.pickup.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
