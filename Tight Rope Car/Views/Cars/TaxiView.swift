//
//  TaxiView.swift
//  Tight Rope Car
//
//  Premium side-view taxi renderer.
//

import SwiftUI

/// Die-cast style yellow cab side view.
struct TaxiView: View {
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
        size.height * 0.56
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                taxiWheel
                taxiWheel
            }

            taxiBodyStack
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

    private var taxiWheel: some View {
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
                .strokeBorder(Color(white: 0.68).opacity(0.48), lineWidth: wheelDiameter * 0.046)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.38),
                            appearance.accentColor.opacity(0.88),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: wheelDiameter * 0.024)
                .frame(width: wheelDiameter * 0.64, height: wheelDiameter * 0.64)

            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(Color.white.opacity(0.18))
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
                        endRadius: wheelDiameter * 0.12
                    )
                )
                .frame(width: wheelDiameter * 0.19, height: wheelDiameter * 0.19)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var taxiBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.28)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.28)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.16)

        return ZStack {
            TaxiBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.58, y: 1)
                    )
                )

            TaxiBodyShape()
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
                    lineWidth: 0.68
                )

            TaxiBodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.34)
                .padding(1)
                .blendMode(.plusLighter)

            TaxiRockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.48), appearance.accentColor.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            TaxiWindowShape()
                .fill(windowGradient)
                .overlay {
                    TaxiWindowShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.38)
                }

            TaxiCheckerStripeShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    TaxiCheckerStripeShape()
                        .stroke(Color.white.opacity(0.12), lineWidth: 0.28)
                }

            TaxiRoofSignShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    Text("TAXI")
                        .font(.system(size: bodyHeight * 0.1, weight: .black, design: .rounded))
                        .foregroundStyle(appearance.bodyColor)
                        .offset(y: -bodyHeight * 0.02)
                }

            TaxiGrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            TaxiHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.065
                    )
                )
                .overlay {
                    TaxiHeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.32)
                }

            TaxiTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            TaxiDoorLineShape()
                .stroke(appearance.accentColor.opacity(0.38), lineWidth: 0.4)

            TaxiMirrorShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            TaxiWheelArchShape()
                .stroke(appearance.accentColor.opacity(0.32), lineWidth: 0.4)
        }
        .frame(width: bodyWidth, height: bodyHeight * 0.82)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.56),
                HotWheelsTheme.electricBlue.opacity(0.28),
                appearance.accentColor.opacity(0.5),
            ],
            startPoint: UnitPoint(x: 0.15, y: 0),
            endPoint: UnitPoint(x: 0.85, y: 1)
        )
    }
}

// MARK: - Body silhouette (sedan cab, front left → rear right)

private struct TaxiBodyShape: Shape {
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
            to: CGPoint(x: w * 0.38, y: ground - h * 0.68),
            control: CGPoint(x: w * 0.26, y: ground - h * 0.52)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.55, y: ground - h * 0.72),
            control: CGPoint(x: w * 0.46, y: ground - h * 0.78)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.82, y: ground - h * 0.44),
            control: CGPoint(x: w * 0.7, y: ground - h * 0.58)
        )
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.32))
        path.addLine(to: CGPoint(x: w * 0.98, y: ground - h * 0.24))
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

private struct TaxiRockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.14, y: rect.height * 0.56, width: rect.width * 0.74, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct TaxiWindowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.22, y: rect.height * 0.2, width: rect.width * 0.38, height: rect.height * 0.34)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.22, height: glass.height * 0.22))
        return path
    }
}

private struct TaxiCheckerStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let stripeHeight = rect.height * 0.22
        let stripeY = rect.height * 0.42
        let squareSize = rect.width * 0.075
        let columns = 4
        let startX = rect.width * 0.5

        for column in 0..<columns {
            let x = startX + CGFloat(column) * squareSize
            if column % 2 == 0 {
                path.addRect(CGRect(x: x, y: stripeY, width: squareSize, height: squareSize))
                path.addRect(CGRect(x: x, y: stripeY + squareSize, width: squareSize, height: squareSize))
            } else {
                path.addRect(CGRect(x: x, y: stripeY + squareSize * 0.5, width: squareSize, height: squareSize))
            }
        }
        return path
    }
}

private struct TaxiRoofSignShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.38, y: rect.height * 0.06, width: rect.width * 0.24, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct TaxiGrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.44, width: rect.width * 0.09, height: rect.height * 0.2),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct TaxiHeadlightShape: Shape {
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

private struct TaxiTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.92, y: rect.height * 0.4, width: rect.width * 0.06, height: rect.height * 0.14),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct TaxiDoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.46, y: rect.height * 0.54))
        path.addLine(to: CGPoint(x: rect.width * 0.46, y: rect.height * 0.28))
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
    }
}

private struct TaxiMirrorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.2, y: rect.height * 0.24, width: rect.width * 0.05, height: rect.height * 0.07),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct TaxiWheelArchShape: Shape {
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

#Preview("Taxi standalone") {
    CarView(
        car: CarDesign.taxi.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
