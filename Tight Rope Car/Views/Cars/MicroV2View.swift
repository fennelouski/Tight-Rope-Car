//
//  MicroV2View.swift
//  Tight Rope Car
//
//  Premium side-view micro car renderer (v2).
//

import SwiftUI

/// Die-cast style kei / city micro car drawing for ``CarRenderVersion/v2``.
struct MicroV2View: View {
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
        size.height * 0.52
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                microWheel
                microWheel
            }

            microBodyStack
                .offset(y: -wheelDiameter * 0.35)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.2))
            .frame(width: bodyWidth * 0.78, height: size.height * 0.09)
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
            .fill(HotWheelsTheme.trackBlack.opacity(0.26))
            .frame(width: wheelDiameter * 1.02, height: wheelDiameter * 0.2)
    }

    // MARK: - Wheels

    private var microWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.88),
                            appearance.accentColor,
                            HotWheelsTheme.trackBlack,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(Color(white: 0.72).opacity(0.48), lineWidth: wheelDiameter * 0.05)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.38),
                            appearance.accentColor.opacity(0.86),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            Circle()
                .strokeBorder(Color.white.opacity(0.28), lineWidth: wheelDiameter * 0.022)
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [HotWheelsTheme.racingYellow.opacity(0.9), appearance.accentColor],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.11
                    )
                )
                .frame(width: wheelDiameter * 0.18, height: wheelDiameter * 0.18)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var microBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.32)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.28)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.16)

        return ZStack {
            MicroV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.32, y: 0),
                        endPoint: UnitPoint(x: 0.58, y: 1)
                    )
                )

            MicroV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.44),
                            appearance.accentColor.opacity(0.72),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.65
                )

            MicroV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.32)
                .padding(0.9)
                .blendMode(.plusLighter)

            MicroV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.45), appearance.accentColor.opacity(0.38)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            MicroV2CanopyGlassShape()
                .fill(windowGradient)
                .overlay {
                    MicroV2CanopyGlassShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.38)
                }

            MicroV2GrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.85), HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    MicroV2GrilleShape()
                        .stroke(Color.white.opacity(0.14), lineWidth: 0.3)
                }

            MicroV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.08
                    )
                )
                .overlay {
                    MicroV2HeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.32)
                }

            MicroV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed.opacity(0.9), appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    MicroV2TaillightShape()
                        .stroke(Color.white.opacity(0.16), lineWidth: 0.28)
                }

            MicroV2DoorLineShape()
                .stroke(appearance.accentColor.opacity(0.38), lineWidth: 0.38)

            MicroV2CheekStripeShape()
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.electricBlue.opacity(0.45),
                            appearance.accentColor.opacity(0.3),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            MicroV2MirrorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            MicroV2AntennaShape()
                .stroke(appearance.accentColor.opacity(0.55), lineWidth: 0.35)

            MicroV2WheelArchShape()
                .stroke(appearance.accentColor.opacity(0.3), lineWidth: 0.38)
        }
        .frame(width: bodyWidth * 0.9, height: bodyHeight * 0.88)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.58),
                HotWheelsTheme.electricBlue.opacity(0.26),
                appearance.accentColor.opacity(0.5),
            ],
            startPoint: UnitPoint(x: 0.15, y: 0),
            endPoint: UnitPoint(x: 0.85, y: 1)
        )
    }
}

// MARK: - Body silhouette (rounded bubble micro, front left → rear right)

private struct MicroV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.04, y: ground - h * 0.22))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.18, y: ground - h * 0.48),
            control: CGPoint(x: w * 0.06, y: ground - h * 0.32)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.42, y: ground - h * 0.86),
            control: CGPoint(x: w * 0.26, y: ground - h * 0.72)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.62, y: ground - h * 0.88),
            control: CGPoint(x: w * 0.52, y: ground - h * 0.94)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.88, y: ground - h * 0.52),
            control: CGPoint(x: w * 0.78, y: ground - h * 0.74)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.94, y: ground - h * 0.28),
            control: CGPoint(x: w * 0.94, y: ground - h * 0.38)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.48, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.74, y: ground - h * 0.12)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.04, y: ground - h * 0.22),
            control: CGPoint(x: w * 0.22, y: ground - h * 0.14)
        )
        path.closeSubpath()
        return path
    }
}

private struct MicroV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.16, y: rect.height * 0.58, width: rect.width * 0.68, height: rect.height * 0.1),
            cornerSize: CGSize(width: 3, height: 3)
        )
        return path
    }
}

private struct MicroV2CanopyGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.22, y: rect.height * 0.16, width: rect.width * 0.48, height: rect.height * 0.42)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.45, height: glass.height * 0.45))
        return path
    }
}

private struct MicroV2GrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let grille = CGRect(x: rect.width * 0.04, y: rect.height * 0.5, width: rect.width * 0.1, height: rect.height * 0.12)
        path.addRoundedRect(in: grille, cornerSize: CGSize(width: grille.height * 0.4, height: grille.height * 0.4))
        path.addEllipse(in: CGRect(
            x: grille.midX - grille.width * 0.18,
            y: grille.midY - grille.height * 0.22,
            width: grille.width * 0.36,
            height: grille.height * 0.44
        ))
        return path
    }
}

private struct MicroV2HeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.075
        let center = CGPoint(x: rect.width * 0.1, y: rect.height * 0.5)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct MicroV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.055
        let center = CGPoint(x: rect.width * 0.9, y: rect.height * 0.48)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct MicroV2DoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.44, y: rect.height * 0.56))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.56, y: rect.height * 0.56),
            control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.52)
        )
        return path.strokedPath(StrokeStyle(lineWidth: 0.38, lineCap: .round))
    }
}

private struct MicroV2CheekStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.28, y: rect.height * 0.48, width: rect.width * 0.38, height: rect.height * 0.05),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct MicroV2MirrorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.2, y: rect.height * 0.22, width: rect.width * 0.05, height: rect.height * 0.07),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct MicroV2AntennaShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let base = CGPoint(x: rect.width * 0.5, y: rect.height * 0.12)
        path.move(to: base)
        path.addLine(to: CGPoint(x: rect.width * 0.52, y: rect.height * 0.02))
        return path.strokedPath(StrokeStyle(lineWidth: 0.35, lineCap: .round))
    }
}

private struct MicroV2WheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.12, y: rect.height * 0.52, width: rect.width * 0.2, height: rect.height * 0.22),
            CGRect(x: rect.width * 0.64, y: rect.height * 0.52, width: rect.width * 0.2, height: rect.height * 0.22),
        ]
        for arch in arches {
            path.addEllipse(in: arch)
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.38))
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

#Preview("Micro v2 standalone") {
    CarView(
        car: CarDesign.micro.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
