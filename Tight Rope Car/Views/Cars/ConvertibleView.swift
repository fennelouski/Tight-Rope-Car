//
//  ConvertibleView.swift
//  Tight Rope Car
//
//  Premium side-view convertible roadster renderer.
//

import SwiftUI

/// Die-cast style open-top roadster side view.
struct ConvertibleView: View {
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
        size.height * 0.95
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                convertibleWheel
                convertibleWheel
            }

            convertibleBodyStack
                .offset(y: -wheelDiameter * 0.3)
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

    private var convertibleWheel: some View {
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
                .strokeBorder(Color(white: 0.7).opacity(0.5), lineWidth: wheelDiameter * 0.046)

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
                    .frame(width: wheelDiameter * 0.044, height: wheelDiameter * 0.16)
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

    private var convertibleBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.3)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.3)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.18)

        return ZStack {
            ConvertibleBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.58, y: 1)
                    )
                )

            ConvertibleBodyShape()
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

            ConvertibleBodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.34)
                .padding(1)
                .blendMode(.plusLighter)

            ConvertibleInteriorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.75), HotWheelsTheme.trackBlack.opacity(0.85)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            ConvertibleRockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.48), appearance.accentColor.opacity(0.38)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            ConvertibleWindscreenShape()
                .fill(windowGradient)
                .overlay {
                    ConvertibleWindscreenShape()
                        .stroke(Color.white.opacity(0.4), lineWidth: 0.42)
                }

            ConvertibleRollBarShape()
                .stroke(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.55
                )

            ConvertibleGrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    ConvertibleGrilleShape()
                        .stroke(Color.white.opacity(0.14), lineWidth: 0.32)
                }

            ConvertibleHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.07
                    )
                )
                .overlay {
                    ConvertibleHeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.42), lineWidth: 0.34)
                }

            ConvertibleTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    ConvertibleTaillightShape()
                        .stroke(Color.white.opacity(0.18), lineWidth: 0.3)
                }

            ConvertibleDoorLineShape()
                .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.4)

            ConvertibleSideStripeShape()
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.flameOrange.opacity(0.55),
                            HotWheelsTheme.racingYellow.opacity(0.45),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            ConvertibleMirrorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            ConvertibleDeckShape()
                .fill(
                    LinearGradient(
                        colors: [highlight.opacity(0.9), appearance.bodyColor, shadow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    ConvertibleDeckShape()
                        .stroke(Color.white.opacity(0.15), lineWidth: 0.32)
                }

            ConvertibleWheelArchShape()
                .stroke(appearance.accentColor.opacity(0.32), lineWidth: 0.4)
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.98)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.56),
                HotWheelsTheme.electricBlue.opacity(0.3),
                appearance.accentColor.opacity(0.55),
            ],
            startPoint: UnitPoint(x: 0.2, y: 0),
            endPoint: UnitPoint(x: 0.8, y: 1)
        )
    }
}

// MARK: - Body silhouette (open roadster, front left → rear right)

private struct ConvertibleBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.16))
        path.addLine(to: CGPoint(x: w * 0.06, y: ground - h * 0.22))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.24, y: ground - h * 0.36),
            control: CGPoint(x: w * 0.12, y: ground - h * 0.26)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.4, y: ground - h * 0.52),
            control: CGPoint(x: w * 0.3, y: ground - h * 0.44)
        )
        path.addLine(to: CGPoint(x: w * 0.52, y: ground - h * 0.54))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.68, y: ground - h * 0.48),
            control: CGPoint(x: w * 0.6, y: ground - h * 0.56)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.9, y: ground - h * 0.36),
            control: CGPoint(x: w * 0.8, y: ground - h * 0.4)
        )
        path.addLine(to: CGPoint(x: w * 0.97, y: ground - h * 0.28))
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.2))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.48, y: ground - h * 0.12),
            control: CGPoint(x: w * 0.72, y: ground - h * 0.1)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.2, y: ground - h * 0.13)
        )
        path.closeSubpath()
        return path
    }
}

private struct ConvertibleDeckShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.62, y: rect.height * 0.38, width: rect.width * 0.32, height: rect.height * 0.14),
            cornerSize: CGSize(width: 3, height: 3)
        )
        return path
    }
}

private struct ConvertibleInteriorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.34, y: rect.height * 0.36, width: rect.width * 0.3, height: rect.height * 0.16),
            cornerSize: CGSize(width: 4, height: 4)
        )
        return path
    }
}

private struct ConvertibleRockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.14, y: rect.height * 0.54, width: rect.width * 0.72, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct ConvertibleWindscreenShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.32, y: rect.height * 0.52))
        path.addLine(to: CGPoint(x: rect.width * 0.38, y: rect.height * 0.22))
        path.addLine(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
        path.closeSubpath()
        return path
    }
}

private struct ConvertibleRollBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let x = rect.width * 0.54
        path.move(to: CGPoint(x: x, y: rect.height * 0.48))
        path.addQuadCurve(
            to: CGPoint(x: x + rect.width * 0.04, y: rect.height * 0.18),
            control: CGPoint(x: x + rect.width * 0.06, y: rect.height * 0.32)
        )
        return path.strokedPath(StrokeStyle(lineWidth: 0.55, lineCap: .round))
    }
}

private struct ConvertibleGrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let grille = CGRect(x: 0, y: rect.height * 0.44, width: rect.width * 0.09, height: rect.height * 0.18)
        path.addRoundedRect(in: grille, cornerSize: CGSize(width: 2, height: 2))
        return path
    }
}

private struct ConvertibleHeadlightShape: Shape {
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

private struct ConvertibleTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.91, y: rect.height * 0.38, width: rect.width * 0.06, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct ConvertibleDoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.42, y: rect.height * 0.52))
        path.addLine(to: CGPoint(x: rect.width * 0.42, y: rect.height * 0.34))
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
    }
}

private struct ConvertibleSideStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.38, y: rect.height * 0.44, width: rect.width * 0.24, height: rect.height * 0.05))
        return path
    }
}

private struct ConvertibleMirrorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.3, y: rect.height * 0.24, width: rect.width * 0.05, height: rect.height * 0.07),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct ConvertibleWheelArchShape: Shape {
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

#Preview("Convertible standalone") {
    CarView(
        car: CarDesign.convertible.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
