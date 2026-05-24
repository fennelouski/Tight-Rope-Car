//
//  MotorcycleView.swift
//  Tight Rope Car
//
//  Premium side-view motorcycle renderer.
//

import SwiftUI

/// Die-cast style sport bike side view.
struct MotorcycleView: View {
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
        size.height * 0.80
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                motorcycleWheel
                motorcycleWheel
            }

            motorcycleBodyStack
                .offset(y: -wheelDiameter * 0.22)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.2))
            .frame(width: bodyWidth * 1.1, height: size.height * 0.08)
            .offset(y: -wheelDiameter * 0.04)
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

    private var motorcycleWheel: some View {
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
                .strokeBorder(appearance.bodyColor.opacity(0.45), lineWidth: wheelDiameter * 0.05)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.48),
                            appearance.accentColor.opacity(0.42),
                            appearance.accentColor.opacity(0.88),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.62, height: wheelDiameter * 0.62)

            Circle()
                .strokeBorder(Color.white.opacity(0.28), lineWidth: wheelDiameter * 0.022)
                .frame(width: wheelDiameter * 0.62, height: wheelDiameter * 0.62)

            ForEach(0..<4, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.16))
                    .frame(width: wheelDiameter * 0.038, height: wheelDiameter * 0.14)
                    .offset(y: -wheelDiameter * 0.19)
                    .rotationEffect(.degrees(Double(index) * 90))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [HotWheelsTheme.racingYellow.opacity(0.85), appearance.accentColor],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.11
                    )
                )
                .frame(width: wheelDiameter * 0.17, height: wheelDiameter * 0.17)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var motorcycleBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.22)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.28)
        let accentShadow = appearance.accentColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.2)

        return ZStack {
            MotorcycleBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, shadow],
                        startPoint: UnitPoint(x: 0.35, y: 0),
                        endPoint: UnitPoint(x: 0.55, y: 1)
                    )
                )

            MotorcycleBodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.38),
                            appearance.accentColor.opacity(0.75),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.6
                )

            MotorcycleBodyShape()
                .stroke(Color.white.opacity(0.18), lineWidth: 0.3)
                .padding(0.8)
                .blendMode(.plusLighter)

            MotorcycleFairingShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, accentShadow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    MotorcycleFairingShape()
                        .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.35)
                }

            MotorcycleTankShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.6, y: 1)
                    )
                )
                .overlay {
                    MotorcycleTankShape()
                        .stroke(Color.white.opacity(0.22), lineWidth: 0.32)
                }

            MotorcycleSeatShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.85), HotWheelsTheme.trackBlack.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            MotorcycleTailShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.bodyColor, shadow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            MotorcycleWindscreenShape()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.55),
                            HotWheelsTheme.electricBlue.opacity(0.28),
                            appearance.accentColor.opacity(0.45),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    MotorcycleWindscreenShape()
                        .stroke(Color.white.opacity(0.32), lineWidth: 0.32)
                }

            MotorcycleForkShape()
                .stroke(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.45
                )

            MotorcycleHandlebarShape()
                .stroke(appearance.accentColor.opacity(0.7), lineWidth: 0.4)

            MotorcycleExhaustShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.55), appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    MotorcycleExhaustShape()
                        .stroke(Color.white.opacity(0.15), lineWidth: 0.28)
                }

            MotorcycleHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.85)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.08
                    )
                )

            MotorcycleTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            MotorcycleAccentStripeShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.flameOrange.opacity(0.55), HotWheelsTheme.racingYellow.opacity(0.4)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.95)
    }
}

// MARK: - Body silhouette (sport bike, front left → rear right)

private struct MotorcycleBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.08, y: ground - h * 0.35))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.28, y: ground - h * 0.55),
            control: CGPoint(x: w * 0.16, y: ground - h * 0.48)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.52, y: ground - h * 0.72),
            control: CGPoint(x: w * 0.38, y: ground - h * 0.68)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.72, y: ground - h * 0.58),
            control: CGPoint(x: w * 0.64, y: ground - h * 0.7)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.94, y: ground - h * 0.42),
            control: CGPoint(x: w * 0.86, y: ground - h * 0.48)
        )
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.32))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.42, y: ground - h * 0.28),
            control: CGPoint(x: w * 0.72, y: ground - h * 0.24)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.08, y: ground - h * 0.35),
            control: CGPoint(x: w * 0.22, y: ground - h * 0.3)
        )
        path.closeSubpath()
        return path
    }
}

private struct MotorcycleFairingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.12, y: rect.height * 0.45))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.28, y: rect.height * 0.15),
            control: CGPoint(x: rect.width * 0.14, y: rect.height * 0.22)
        )
        path.addLine(to: CGPoint(x: rect.width * 0.34, y: rect.height * 0.12))
        path.addLine(to: CGPoint(x: rect.width * 0.36, y: rect.height * 0.42))
        path.closeSubpath()
        return path
    }
}

private struct MotorcycleTankShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let tank = CGRect(x: rect.width * 0.3, y: rect.height * 0.22, width: rect.width * 0.28, height: rect.height * 0.28)
        path.addRoundedRect(in: tank, cornerSize: CGSize(width: tank.height * 0.45, height: tank.height * 0.45))
        return path
    }
}

private struct MotorcycleSeatShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.38))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.68, y: rect.height * 0.32),
            control: CGPoint(x: rect.width * 0.58, y: rect.height * 0.22)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.78, y: rect.height * 0.42),
            control: CGPoint(x: rect.width * 0.76, y: rect.height * 0.36)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.38),
            control: CGPoint(x: rect.width * 0.62, y: rect.height * 0.48)
        )
        path.closeSubpath()
        return path
    }
}

private struct MotorcycleTailShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.78, y: rect.height * 0.32, width: rect.width * 0.18, height: rect.height * 0.14),
            cornerSize: CGSize(width: 3, height: 3)
        )
        return path
    }
}

private struct MotorcycleWindscreenShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.26, y: rect.height * 0.28))
        path.addLine(to: CGPoint(x: rect.width * 0.3, y: rect.height * 0.08))
        path.addLine(to: CGPoint(x: rect.width * 0.34, y: rect.height * 0.1))
        path.addLine(to: CGPoint(x: rect.width * 0.32, y: rect.height * 0.3))
        path.closeSubpath()
        return path
    }
}

private struct MotorcycleForkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.14, y: rect.height * 0.42))
        path.addLine(to: CGPoint(x: rect.width * 0.1, y: rect.height * 0.08))
        return path.strokedPath(StrokeStyle(lineWidth: 0.45, lineCap: .round))
    }
}

private struct MotorcycleHandlebarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.22, y: rect.height * 0.12))
        path.addLine(to: CGPoint(x: rect.width * 0.36, y: rect.height * 0.1))
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
    }
}

private struct MotorcycleExhaustShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.62, y: rect.height * 0.48, width: rect.width * 0.32, height: rect.height * 0.08),
            cornerSize: CGSize(width: rect.height * 0.04, height: rect.height * 0.04)
        )
        return path
    }
}

private struct MotorcycleHeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.07
        let center = CGPoint(x: rect.width * 0.1, y: rect.height * 0.38)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct MotorcycleTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.9, y: rect.height * 0.36, width: rect.width * 0.06, height: rect.height * 0.1),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct MotorcycleAccentStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.32, y: rect.height * 0.34, width: rect.width * 0.22, height: rect.height * 0.04))
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

#Preview("Motorcycle standalone") {
    CarView(
        car: CarDesign.motorcycle.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
