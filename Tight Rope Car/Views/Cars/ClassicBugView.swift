//
//  ClassicBugView.swift
//  Tight Rope Car
//
//  Premium side-view classic bug renderer.
//

import SwiftUI

/// Die-cast style beetle side view.
struct ClassicBugView: View {
    let appearance: CarAppearance
    let size: CGSize

    private var wheelDiameter: CGFloat {
        size.height * 0.45 * appearance.wheelSizeMultiplier
    }

    private var wheelSpacing: CGFloat {
        size.width * 0.12 * appearance.wheelSpacingMultiplier
    }

    private var bodyWidth: CGFloat {
        size.width * 0.85
    }

    private var bodyHeight: CGFloat {
        size.height * 0.93
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                bugWheel
                bugWheel
            }

            bugBodyStack
                .offset(y: -wheelDiameter * 0.35)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.2))
            .frame(width: bodyWidth * 0.82, height: size.height * 0.1)
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
            .fill(HotWheelsTheme.trackBlack.opacity(0.26))
            .frame(width: wheelDiameter * 1.08, height: wheelDiameter * 0.24)
    }

    // MARK: - Wheels

    private var bugWheel: some View {
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
                .strokeBorder(Color(white: 0.72).opacity(0.55), lineWidth: wheelDiameter * 0.05)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.4),
                            appearance.accentColor.opacity(0.85),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.68, height: wheelDiameter * 0.68)

            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: wheelDiameter * 0.022)
                .frame(width: wheelDiameter * 0.68, height: wheelDiameter * 0.68)

            // Hubcap spokes
            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.22))
                    .frame(width: wheelDiameter * 0.05, height: wheelDiameter * 0.2)
                    .offset(y: -wheelDiameter * 0.2)
                    .rotationEffect(.degrees(Double(index) * 72))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(white: 0.78), appearance.accentColor.opacity(0.9)],
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

    private var bugBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.32)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.32)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.18)

        return ZStack {
            ClassicBugFrontFenderShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    ClassicBugFrontFenderShape()
                        .stroke(appearance.accentColor.opacity(0.35), lineWidth: 0.5)
                }

            ClassicBugRearFenderShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.bodyColor, rocker, shadow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    ClassicBugRearFenderShape()
                        .stroke(appearance.accentColor.opacity(0.35), lineWidth: 0.5)
                }

            ClassicBugBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, appearance.bodyColor, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.55, y: 1)
                    )
                )

            ClassicBugBodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.4),
                            appearance.accentColor.opacity(0.7),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.7
                )

            ClassicBugBodyShape()
                .stroke(Color.white.opacity(0.18), lineWidth: 0.35)
                .padding(1)
                .blendMode(.plusLighter)

            ClassicBugRockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.55), appearance.accentColor.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            ClassicBugFrontWindowShape()
                .fill(windowGradient)
                .overlay {
                    ClassicBugFrontWindowShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.4)
                }

            ClassicBugRearWindowShape()
                .fill(windowGradient)
                .overlay {
                    ClassicBugRearWindowShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.4)
                }

            ClassicBugWindowDividerShape()
                .fill(appearance.accentColor.opacity(0.85))

            ClassicBugRunningBoardShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    ClassicBugRunningBoardShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.35)
                }

            ClassicBugHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.9)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.08
                    )
                )
                .overlay {
                    ClassicBugHeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.5), lineWidth: 0.35)
                }

            ClassicBugTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    ClassicBugTaillightShape()
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.3)
                }

            ClassicBugFrontBumperShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.82), appearance.accentColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            ClassicBugRearBumperShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.82), appearance.accentColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            ClassicBugRearEngineLouversShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.85), HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    ClassicBugRearEngineLouversShape()
                        .stroke(Color.white.opacity(0.12), lineWidth: 0.3)
                }

            ClassicBugDoorLineShape()
                .stroke(appearance.accentColor.opacity(0.45), lineWidth: 0.45)

            ClassicBugSideStripeShape()
                .fill(
                    LinearGradient(
                        colors: [
                            appearance.accentColor.opacity(0.15),
                            appearance.accentColor.opacity(0.35),
                            appearance.accentColor.opacity(0.15),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.92)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.58),
                HotWheelsTheme.electricBlue.opacity(0.28),
                appearance.accentColor.opacity(0.55),
            ],
            startPoint: UnitPoint(x: 0.15, y: 0),
            endPoint: UnitPoint(x: 0.85, y: 1)
        )
    }
}

// MARK: - Body silhouette (side profile, front left → rear right)

private struct ClassicBugBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.08, y: ground - h * 0.18))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.2, y: ground - h * 0.42),
            control: CGPoint(x: w * 0.1, y: ground - h * 0.28)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.42, y: ground - h * 0.88),
            control: CGPoint(x: w * 0.28, y: ground - h * 0.72)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.58, y: ground - h * 0.92),
            control: CGPoint(x: w * 0.5, y: ground - h * 0.98)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.78, y: ground - h * 0.62),
            control: CGPoint(x: w * 0.7, y: ground - h * 0.82)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.92, y: ground - h * 0.28),
            control: CGPoint(x: w * 0.88, y: ground - h * 0.42)
        )
        path.addLine(to: CGPoint(x: w * 0.94, y: ground - h * 0.2))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.48, y: ground - h * 0.14),
            control: CGPoint(x: w * 0.72, y: ground - h * 0.1)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.08, y: ground - h * 0.18),
            control: CGPoint(x: w * 0.26, y: ground - h * 0.12)
        )
        path.closeSubpath()
        return path
    }
}

private struct ClassicBugFrontFenderShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let fender = CGRect(x: w * 0.02, y: h * 0.52, width: w * 0.22, height: h * 0.38)
        return Path(ellipseIn: fender)
    }
}

private struct ClassicBugRearFenderShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let fender = CGRect(x: w * 0.76, y: h * 0.48, width: w * 0.22, height: h * 0.4)
        return Path(ellipseIn: fender)
    }
}

private struct ClassicBugRockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let panel = CGRect(x: rect.width * 0.2, y: rect.height * 0.62, width: rect.width * 0.58, height: rect.height * 0.12)
        path.addRoundedRect(in: panel, cornerSize: CGSize(width: 3, height: 3))
        return path
    }
}

private struct ClassicBugFrontWindowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let glass = CGRect(x: rect.width * 0.3, y: rect.height * 0.2, width: rect.width * 0.16, height: rect.height * 0.36)
        return Path(roundedRect: glass, cornerRadius: glass.height * 0.35)
    }
}

private struct ClassicBugRearWindowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let glass = CGRect(x: rect.width * 0.48, y: rect.height * 0.18, width: rect.width * 0.16, height: rect.height * 0.38)
        return Path(roundedRect: glass, cornerRadius: glass.height * 0.35)
    }
}

private struct ClassicBugWindowDividerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let x = rect.width * 0.465
        path.move(to: CGPoint(x: x, y: rect.height * 0.2))
        path.addLine(to: CGPoint(x: x, y: rect.height * 0.56))
        return path.strokedPath(StrokeStyle(lineWidth: 0.55, lineCap: .round))
    }
}

private struct ClassicBugRunningBoardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.22, y: rect.height * 0.58, width: rect.width * 0.54, height: rect.height * 0.06),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct ClassicBugHeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.07
        let center = CGPoint(x: rect.width * 0.1, y: rect.height * 0.48)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct ClassicBugTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.9, y: rect.height * 0.44, width: rect.width * 0.06, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct ClassicBugFrontBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.72, width: rect.width * 0.12, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct ClassicBugRearBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.9, y: rect.height * 0.68, width: rect.width * 0.1, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct ClassicBugRearEngineLouversShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let slotWidth = rect.width * 0.025
        let slotHeight = rect.height * 0.14
        let startX = rect.width * 0.8
        let y = rect.height * 0.38
        for index in 0..<4 {
            let x = startX + CGFloat(index) * (slotWidth + rect.width * 0.012)
            path.addRoundedRect(
                in: CGRect(x: x, y: y, width: slotWidth, height: slotHeight),
                cornerSize: CGSize(width: 1, height: 1)
            )
        }
        return path
    }
}

private struct ClassicBugDoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.38, y: rect.height * 0.58))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.52, y: rect.height * 0.58),
            control: CGPoint(x: rect.width * 0.45, y: rect.height * 0.54)
        )
        return path.strokedPath(StrokeStyle(lineWidth: 0.45, lineCap: .round))
    }
}

private struct ClassicBugSideStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.24, y: rect.height * 0.5, width: rect.width * 0.5, height: rect.height * 0.05))
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

#Preview("Classic bug standalone") {
    CarView(
        car: CarDesign.classicBug.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
