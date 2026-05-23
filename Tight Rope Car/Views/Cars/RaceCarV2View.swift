//
//  RaceCarV2View.swift
//  Tight Rope Car
//
//  Premium side-view race car renderer (v2).
//

import SwiftUI

/// Die-cast style race car drawing for ``CarRenderVersion/v2``.
struct RaceCarV2View: View {
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
        size.height * 0.48
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                raceWheel
                raceWheel
            }

            raceCarBody
                .offset(y: -wheelDiameter * 0.26)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.88, height: size.height * 0.1)
            .offset(y: -wheelDiameter * 0.08)
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
            .frame(width: wheelDiameter * 1.05, height: wheelDiameter * 0.22)
    }

    // MARK: - Wheels

    private var raceWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.95),
                            appearance.accentColor,
                            HotWheelsTheme.trackBlack,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(appearance.accentColor.opacity(0.5), lineWidth: wheelDiameter * 0.04)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.55),
                            appearance.accentColor.opacity(0.35),
                            appearance.accentColor.opacity(0.9),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.62, height: wheelDiameter * 0.62)

            Circle()
                .strokeBorder(Color.white.opacity(0.35), lineWidth: wheelDiameter * 0.025)
                .frame(width: wheelDiameter * 0.62, height: wheelDiameter * 0.62)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [HotWheelsTheme.racingYellow, appearance.accentColor],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.14
                    )
                )
                .frame(width: wheelDiameter * 0.22, height: wheelDiameter * 0.22)

            // Rotation hint — spoke tick at top
            Capsule()
                .fill(Color.white.opacity(0.25))
                .frame(width: wheelDiameter * 0.06, height: wheelDiameter * 0.18)
                .offset(y: -wheelDiameter * 0.22)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var raceCarBody: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.28)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.35)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.22)

        return ZStack {
            RaceCarV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.35, y: 0),
                        endPoint: UnitPoint(x: 0.55, y: 1)
                    )
                )

            RaceCarV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.45),
                            appearance.accentColor.opacity(0.85),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.75
                )

            RaceCarV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.35)
                .padding(1.2)
                .blendMode(.plusLighter)

            RaceCarV2RockerPanelShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.5), appearance.accentColor.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            RaceCarV2SplitterShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    RaceCarV2SplitterShape()
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.4)
                }

            RaceCarV2SideIntakeShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    RaceCarV2SideIntakeShape()
                        .stroke(Color.white.opacity(0.15), lineWidth: 0.35)
                }

            RaceCarV2CanopyGlassShape()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.55),
                            HotWheelsTheme.electricBlue.opacity(0.35),
                            appearance.accentColor.opacity(0.65),
                        ],
                        startPoint: UnitPoint(x: 0.2, y: 0),
                        endPoint: UnitPoint(x: 0.8, y: 1)
                    )
                )
                .overlay {
                    RaceCarV2CanopyGlassShape()
                        .stroke(Color.white.opacity(0.4), lineWidth: 0.45)
                }

            RaceCarV2StripeShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.racingYellow, HotWheelsTheme.flameOrange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            RaceCarV2NumberRoundelShape()
                .fill(Color.white)
                .overlay {
                    RaceCarV2NumberRoundelShape()
                        .stroke(HotWheelsTheme.trackBlack, lineWidth: 0.6)
                }
                .overlay {
                    Text("7")
                        .font(.system(size: bodyHeight * 0.22, weight: .black, design: .rounded))
                        .foregroundStyle(HotWheelsTheme.hotRed)
                        .offset(x: bodyWidth * 0.02, y: -bodyHeight * 0.01)
                }

            RaceCarV2RearWingShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    RaceCarV2RearWingShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.4)
                }

            RaceCarV2WingEndplateShape()
                .fill(appearance.accentColor)
                .overlay {
                    RaceCarV2WingEndplateShape()
                        .stroke(HotWheelsTheme.racingYellow.opacity(0.7), lineWidth: 0.5)
                }

            RaceCarV2ExhaustShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.55), appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.58)
    }
}

// MARK: - Body silhouette (side profile, front left → rear right)

private struct RaceCarV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.12))
        path.addLine(to: CGPoint(x: w * 0.06, y: ground - h * 0.22))
        path.addLine(to: CGPoint(x: w * 0.14, y: ground - h * 0.28))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.32, y: ground - h * 0.52),
            control: CGPoint(x: w * 0.18, y: ground - h * 0.38)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.48, y: ground - h * 0.78),
            control: CGPoint(x: w * 0.38, y: ground - h * 0.68)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.58, y: ground - h * 0.82),
            control: CGPoint(x: w * 0.54, y: ground - h * 0.86)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.72, y: ground - h * 0.58),
            control: CGPoint(x: w * 0.66, y: ground - h * 0.72)
        )
        path.addLine(to: CGPoint(x: w * 0.88, y: ground - h * 0.42))
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.36))
        path.addLine(to: CGPoint(x: w * 0.98, y: ground - h * 0.28))
        path.addLine(to: CGPoint(x: w * 0.94, y: ground - h * 0.18))
        path.addLine(to: CGPoint(x: w * 0.78, y: ground - h * 0.14))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.42, y: ground - h * 0.1),
            control: CGPoint(x: w * 0.58, y: ground - h * 0.08)
        )
        path.addLine(to: CGPoint(x: w * 0.02, y: ground - h * 0.12))
        path.closeSubpath()
        return path
    }
}

private struct RaceCarV2RockerPanelShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let panel = CGRect(x: rect.width * 0.18, y: rect.height * 0.58, width: rect.width * 0.55, height: rect.height * 0.14)
        path.addRoundedRect(in: panel, cornerSize: CGSize(width: 2, height: 2))
        return path
    }
}

private struct RaceCarV2SplitterShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: 0, y: rect.height * 0.82, width: rect.width * 0.2, height: rect.height * 0.1))
        return path
    }
}

private struct RaceCarV2SideIntakeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let intake = CGRect(x: rect.width * 0.34, y: rect.height * 0.48, width: rect.width * 0.1, height: rect.height * 0.2)
        path.addRoundedRect(in: intake, cornerSize: CGSize(width: intake.height * 0.2, height: intake.height * 0.2))
        return path
    }
}

private struct RaceCarV2CanopyGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.36, y: rect.height * 0.12, width: rect.width * 0.22, height: rect.height * 0.38)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.45, height: glass.height * 0.45))
        return path
    }
}

private struct RaceCarV2StripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.52, y: rect.height * 0.38, width: rect.width * 0.28, height: rect.height * 0.08))
        return path
    }
}

private struct RaceCarV2NumberRoundelShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width * 0.62, y: rect.height * 0.32)
        let radius = min(rect.width, rect.height) * 0.11
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct RaceCarV2RearWingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let wingY = rect.height * 0.04
        let pillarX = rect.width * 0.84
        path.move(to: CGPoint(x: pillarX, y: rect.height * 0.22))
        path.addLine(to: CGPoint(x: pillarX + rect.width * 0.02, y: wingY + rect.height * 0.06))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: wingY))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: wingY + rect.height * 0.1))
        path.addLine(to: CGPoint(x: pillarX + rect.width * 0.02, y: wingY + rect.height * 0.14))
        path.addLine(to: CGPoint(x: pillarX, y: rect.height * 0.3))
        path.closeSubpath()
        return path
    }
}

private struct RaceCarV2WingEndplateShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(
            x: rect.width * 0.95,
            y: rect.height * 0.02,
            width: rect.width * 0.04,
            height: rect.height * 0.16
        ))
        return path
    }
}

private struct RaceCarV2ExhaustShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let pipeHeight = rect.height * 0.06
        let y = rect.height * 0.52
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.9, y: y, width: rect.width * 0.08, height: pipeHeight),
            cornerSize: CGSize(width: pipeHeight * 0.4, height: pipeHeight * 0.4)
        )
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.9, y: y + pipeHeight * 1.15, width: rect.width * 0.08, height: pipeHeight),
            cornerSize: CGSize(width: pipeHeight * 0.4, height: pipeHeight * 0.4)
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

#Preview("Race car v2 standalone") {
    CarView(
        car: CarDesign.raceCar.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
