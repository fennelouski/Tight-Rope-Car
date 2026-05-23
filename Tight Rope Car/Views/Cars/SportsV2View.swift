//
//  SportsV2View.swift
//  Tight Rope Car
//
//  Premium side-view sports car renderer (v2).
//

import SwiftUI

/// Die-cast style sports coupe drawing for ``CarRenderVersion/v2``.
struct SportsV2View: View {
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
        size.height * 0.5
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                sportsWheel
                sportsWheel
            }

            sportsBodyStack
                .offset(y: -wheelDiameter * 0.28)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.9, height: size.height * 0.1)
            .offset(y: -wheelDiameter * 0.07)
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

    private var sportsWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.92),
                            appearance.accentColor,
                            HotWheelsTheme.trackBlack,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(Color(white: 0.68).opacity(0.5), lineWidth: wheelDiameter * 0.045)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.52),
                            appearance.accentColor.opacity(0.38),
                            appearance.accentColor.opacity(0.88),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            Circle()
                .strokeBorder(Color.white.opacity(0.32), lineWidth: wheelDiameter * 0.024)
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: wheelDiameter * 0.045, height: wheelDiameter * 0.17)
                    .offset(y: -wheelDiameter * 0.21)
                    .rotationEffect(.degrees(Double(index) * 72))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [HotWheelsTheme.racingYellow, appearance.accentColor],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.13
                    )
                )
                .frame(width: wheelDiameter * 0.2, height: wheelDiameter * 0.2)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var sportsBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.3)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.32)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.2)

        return ZStack {
            SportsV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.32, y: 0),
                        endPoint: UnitPoint(x: 0.58, y: 1)
                    )
                )

            SportsV2BodyShape()
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

            SportsV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.35)
                .padding(1.1)
                .blendMode(.plusLighter)

            SportsV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.5), appearance.accentColor.opacity(0.38)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SportsV2FrontSplitterShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    SportsV2FrontSplitterShape()
                        .stroke(Color.white.opacity(0.22), lineWidth: 0.35)
                }

            SportsV2SideVentShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack.opacity(0.92)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    SportsV2SideVentShape()
                        .stroke(Color.white.opacity(0.14), lineWidth: 0.32)
                }

            SportsV2CanopyGlassShape()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.56),
                            HotWheelsTheme.electricBlue.opacity(0.32),
                            appearance.accentColor.opacity(0.62),
                        ],
                        startPoint: UnitPoint(x: 0.2, y: 0),
                        endPoint: UnitPoint(x: 0.82, y: 1)
                    )
                )
                .overlay {
                    SportsV2CanopyGlassShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.42)
                }

            SportsV2DoorLineShape()
                .stroke(appearance.accentColor.opacity(0.42), lineWidth: 0.42)

            SportsV2RacingStripeShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            SportsV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.85)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.07
                    )
                )
                .overlay {
                    SportsV2HeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.45), lineWidth: 0.35)
                }

            SportsV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    SportsV2TaillightShape()
                        .stroke(Color.white.opacity(0.18), lineWidth: 0.3)
                }

            SportsV2RearSpoilerShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    SportsV2RearSpoilerShape()
                        .stroke(Color.white.opacity(0.22), lineWidth: 0.38)
                }

            SportsV2MirrorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    SportsV2MirrorShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.3)
                }

            SportsV2ExhaustTipShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.58), appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.62)
    }
}

// MARK: - Body silhouette (low GT coupe, front left → rear right)

private struct SportsV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.01, y: ground - h * 0.14))
        path.addLine(to: CGPoint(x: w * 0.05, y: ground - h * 0.2))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.22, y: ground - h * 0.34),
            control: CGPoint(x: w * 0.1, y: ground - h * 0.24)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.38, y: ground - h * 0.58),
            control: CGPoint(x: w * 0.28, y: ground - h * 0.46)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.52, y: ground - h * 0.82),
            control: CGPoint(x: w * 0.44, y: ground - h * 0.72)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.64, y: ground - h * 0.78),
            control: CGPoint(x: w * 0.58, y: ground - h * 0.88)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.82, y: ground - h * 0.48),
            control: CGPoint(x: w * 0.74, y: ground - h * 0.62)
        )
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.38))
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.3))
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.22))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.5, y: ground - h * 0.1),
            control: CGPoint(x: w * 0.74, y: ground - h * 0.08)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.01, y: ground - h * 0.14),
            control: CGPoint(x: w * 0.22, y: ground - h * 0.11)
        )
        path.closeSubpath()
        return path
    }
}

private struct SportsV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let panel = CGRect(x: rect.width * 0.2, y: rect.height * 0.56, width: rect.width * 0.58, height: rect.height * 0.13)
        path.addRoundedRect(in: panel, cornerSize: CGSize(width: 2, height: 2))
        return path
    }
}

private struct SportsV2FrontSplitterShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: 0, y: rect.height * 0.8, width: rect.width * 0.18, height: rect.height * 0.1))
        return path
    }
}

private struct SportsV2SideVentShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let vent = CGRect(x: rect.width * 0.58, y: rect.height * 0.44, width: rect.width * 0.09, height: rect.height * 0.18)
        path.addRoundedRect(in: vent, cornerSize: CGSize(width: vent.height * 0.22, height: vent.height * 0.22))
        return path
    }
}

private struct SportsV2CanopyGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.34, y: rect.height * 0.14, width: rect.width * 0.34, height: rect.height * 0.4)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.42, height: glass.height * 0.42))
        return path
    }
}

private struct SportsV2DoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.56))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.62, y: rect.height * 0.56),
            control: CGPoint(x: rect.width * 0.55, y: rect.height * 0.52)
        )
        return path.strokedPath(StrokeStyle(lineWidth: 0.42, lineCap: .round))
    }
}

private struct SportsV2RacingStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.42, y: rect.height * 0.36, width: rect.width * 0.22, height: rect.height * 0.06))
        return path
    }
}

private struct SportsV2HeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.065
        let center = CGPoint(x: rect.width * 0.08, y: rect.height * 0.44)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct SportsV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.9, y: rect.height * 0.4, width: rect.width * 0.07, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SportsV2RearSpoilerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let lipY = rect.height * 0.08
        path.move(to: CGPoint(x: rect.width * 0.78, y: rect.height * 0.28))
        path.addLine(to: CGPoint(x: rect.width * 0.82, y: lipY))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: lipY + rect.height * 0.04))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: lipY + rect.height * 0.1))
        path.addLine(to: CGPoint(x: rect.width * 0.82, y: lipY + rect.height * 0.08))
        path.addLine(to: CGPoint(x: rect.width * 0.78, y: rect.height * 0.34))
        path.closeSubpath()
        return path
    }
}

private struct SportsV2MirrorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.3, y: rect.height * 0.22, width: rect.width * 0.05, height: rect.height * 0.08),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct SportsV2ExhaustTipShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let pipeHeight = rect.height * 0.055
        let y = rect.height * 0.5
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.92, y: y, width: rect.width * 0.06, height: pipeHeight),
            cornerSize: CGSize(width: pipeHeight * 0.35, height: pipeHeight * 0.35)
        )
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.92, y: y + pipeHeight * 1.12, width: rect.width * 0.06, height: pipeHeight),
            cornerSize: CGSize(width: pipeHeight * 0.35, height: pipeHeight * 0.35)
        )
        return path
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

#Preview("Sports car v2 standalone") {
    CarView(
        car: CarDesign.sports.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
