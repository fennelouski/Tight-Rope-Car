//
//  AmbulanceView.swift
//  Tight Rope Car
//
//  Premium side-view ambulance renderer.
//

import SwiftUI

/// Die-cast style ambulance side view.
struct AmbulanceView: View {
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
        size.height * 0.6
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                ambulanceWheel
                ambulanceWheel
            }

            ambulanceBodyStack
                .offset(y: -wheelDiameter * 0.38)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.92, height: size.height * 0.1)
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

    private var ambulanceWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.35),
                            HotWheelsTheme.trackBlack.opacity(0.9),
                            HotWheelsTheme.trackBlack,
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(Color(white: 0.7).opacity(0.48), lineWidth: wheelDiameter * 0.046)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.55),
                            appearance.accentColor.opacity(0.25),
                            HotWheelsTheme.trackBlack.opacity(0.85),
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
                    .frame(width: wheelDiameter * 0.042, height: wheelDiameter * 0.16)
                    .offset(y: -wheelDiameter * 0.21)
                    .rotationEffect(.degrees(Double(index) * 72))
            }

            Circle()
                .fill(
                    RadialGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
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

    private var ambulanceBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.08)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.18)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.1)

        return ZStack {
            AmbulanceBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.28, y: 0),
                        endPoint: UnitPoint(x: 0.6, y: 1)
                    )
                )

            AmbulanceBodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.65),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.7
                )

            AmbulanceBodyShape()
                .stroke(Color.white.opacity(0.22), lineWidth: 0.34)
                .padding(1)
                .blendMode(.plusLighter)

            AmbulanceRockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.4), appearance.accentColor.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            AmbulanceWindowRowShape()
                .fill(windowGradient)
                .overlay {
                    AmbulanceWindowRowShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.36)
                }

            AmbulanceWindshieldShape()
                .fill(windowGradient)
                .overlay {
                    AmbulanceWindshieldShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.38)
                }

            AmbulanceCrossShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, appearance.accentColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.2)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    AmbulanceCrossShape()
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.32)
                }

            AmbulanceLowerStripeShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, appearance.accentColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.15)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            AmbulanceLightBarShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, HotWheelsTheme.electricBlue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    AmbulanceLightBarShape()
                        .stroke(Color.white.opacity(0.28), lineWidth: 0.32)
                }

            AmbulanceGrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.5), HotWheelsTheme.trackBlack.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            AmbulanceHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.06
                    )
                )

            AmbulanceTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            AmbulanceRearDoorLineShape()
                .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.4)

            AmbulanceWheelArchShape()
                .stroke(appearance.accentColor.opacity(0.35), lineWidth: 0.42)
        }
        .frame(width: bodyWidth * 0.94, height: bodyHeight * 1.05)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.62),
                HotWheelsTheme.electricBlue.opacity(0.24),
                appearance.accentColor.opacity(0.2),
            ],
            startPoint: UnitPoint(x: 0.12, y: 0),
            endPoint: UnitPoint(x: 0.88, y: 1)
        )
    }
}

// MARK: - Body silhouette (box ambulance)

private struct AmbulanceBodyShape: Shape {
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
        path.addLine(to: CGPoint(x: w * 0.14, y: ground - h * 0.86))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.22, y: ground - h * 0.9),
            control: CGPoint(x: w * 0.16, y: ground - h * 0.94)
        )
        path.addLine(to: CGPoint(x: w * 0.96, y: ground - h * 0.9))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.99, y: ground - h * 0.82),
            control: CGPoint(x: w * 0.99, y: ground - h * 0.88)
        )
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.88, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.96, y: ground - h * 0.14)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.2),
            control: CGPoint(x: w * 0.4, y: ground - h * 0.12)
        )
        path.closeSubpath()
        return path
    }
}

private struct AmbulanceRockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.1, y: rect.height * 0.66, width: rect.width * 0.84, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct AmbulanceWindowRowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let windows: [CGRect] = [
            CGRect(x: rect.width * 0.34, y: rect.height * 0.22, width: rect.width * 0.14, height: rect.height * 0.28),
            CGRect(x: rect.width * 0.52, y: rect.height * 0.22, width: rect.width * 0.14, height: rect.height * 0.28),
            CGRect(x: rect.width * 0.7, y: rect.height * 0.22, width: rect.width * 0.14, height: rect.height * 0.28),
        ]
        for window in windows {
            path.addRoundedRect(in: window, cornerSize: CGSize(width: window.height * 0.12, height: window.height * 0.12))
        }
        return path
    }
}

private struct AmbulanceWindshieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.1, y: rect.height * 0.2, width: rect.width * 0.18, height: rect.height * 0.34)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.15, height: glass.height * 0.15))
        return path
    }
}

private struct AmbulanceCrossShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let crossSize = min(rect.width, rect.height) * 0.26
        let centerX = rect.width * 0.72
        let centerY = rect.height * 0.44
        let barThickness = crossSize * 0.32
        path.addRect(CGRect(
            x: centerX - crossSize * 0.5,
            y: centerY - barThickness * 0.5,
            width: crossSize,
            height: barThickness
        ))
        path.addRect(CGRect(
            x: centerX - barThickness * 0.5,
            y: centerY - crossSize * 0.5,
            width: barThickness,
            height: crossSize
        ))
        return path
    }
}

private struct AmbulanceLowerStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(
            x: rect.width * 0.06,
            y: rect.height * 0.62,
            width: rect.width * 0.22,
            height: rect.height * 0.12
        ))
        return path
    }
}

private struct AmbulanceLightBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.28, y: rect.height * 0.1, width: rect.width * 0.38, height: rect.height * 0.06),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct AmbulanceGrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.46, width: rect.width * 0.09, height: rect.height * 0.2),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct AmbulanceHeadlightShape: Shape {
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

private struct AmbulanceTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.93, y: rect.height * 0.4, width: rect.width * 0.05, height: rect.height * 0.16),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct AmbulanceRearDoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.88, y: rect.height * 0.58))
        path.addLine(to: CGPoint(x: rect.width * 0.88, y: rect.height * 0.28))
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
    }
}

private struct AmbulanceWheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.1, y: rect.height * 0.54, width: rect.width * 0.2, height: rect.height * 0.24),
            CGRect(x: rect.width * 0.66, y: rect.height * 0.54, width: rect.width * 0.2, height: rect.height * 0.24),
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

#Preview("Ambulance standalone") {
    CarView(
        car: CarDesign.ambulance.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
