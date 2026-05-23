//
//  SUVView.swift
//  Tight Rope Car
//
//  Premium side-view SUV renderer.
//

import SwiftUI

/// Die-cast style sport-utility side view.
struct SUVView: View {
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
        size.height * 0.64
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                suvWheel
                suvWheel
            }

            suvBodyStack
                .offset(y: -wheelDiameter * 0.4)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.24))
            .frame(width: bodyWidth * 0.92, height: size.height * 0.11)
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
            .fill(HotWheelsTheme.trackBlack.opacity(0.3))
            .frame(width: wheelDiameter * 1.08, height: wheelDiameter * 0.24)
    }

    // MARK: - Wheels

    private var suvWheel: some View {
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
                .strokeBorder(Color(white: 0.66).opacity(0.52), lineWidth: wheelDiameter * 0.048)

            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.5),
                            appearance.accentColor.opacity(0.4),
                            appearance.accentColor.opacity(0.9),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: wheelDiameter * 0.66, height: wheelDiameter * 0.66)

            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: wheelDiameter * 0.025)
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
                        colors: [HotWheelsTheme.racingYellow.opacity(0.85), appearance.accentColor],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.13
                    )
                )
                .frame(width: wheelDiameter * 0.21, height: wheelDiameter * 0.21)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var suvBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.26)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.32)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.2)

        return ZStack {
            SUVBodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.28, y: 0),
                        endPoint: UnitPoint(x: 0.6, y: 1)
                    )
                )

            SUVBodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.4),
                            appearance.accentColor.opacity(0.8),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.72
                )

            SUVBodyShape()
                .stroke(Color.white.opacity(0.18), lineWidth: 0.35)
                .padding(1.1)
                .blendMode(.plusLighter)

            SUVCladdingShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.85), HotWheelsTheme.trackBlack.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    SUVCladdingShape()
                        .stroke(Color.white.opacity(0.12), lineWidth: 0.32)
                }

            SUVRockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.5), appearance.accentColor.opacity(0.42)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SUVWindowRowShape()
                .fill(windowGradient)
                .overlay {
                    SUVWindowRowShape()
                        .stroke(Color.white.opacity(0.34), lineWidth: 0.38)
                }

            SUVWindshieldShape()
                .fill(windowGradient)
                .overlay {
                    SUVWindshieldShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.4)
                }

            SUVGrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    SUVGrilleShape()
                        .stroke(Color.white.opacity(0.14), lineWidth: 0.32)
                }

            SUVSkidPlateShape()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.55), appearance.accentColor],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SUVFrontBumperShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SUVRearBumperShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            SUVHeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.055
                    )
                )
                .overlay {
                    SUVHeadlightShape()
                        .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.34)
                }

            SUVTaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay {
                    SUVTaillightShape()
                        .stroke(Color.white.opacity(0.16), lineWidth: 0.3)
                }

            SUVRoofRailShape()
                .stroke(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 0.5
                )

            SUVRunningBoardShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor.opacity(0.9), HotWheelsTheme.trackBlack],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            SUVSpareTireShape()
                .fill(
                    RadialGradient(
                        colors: [appearance.accentColor.opacity(0.7), HotWheelsTheme.trackBlack],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.06
                    )
                )
                .overlay {
                    SUVSpareTireShape()
                        .stroke(Color.white.opacity(0.18), lineWidth: 0.32)
                }

            SUVDoorLineShape()
                .stroke(appearance.accentColor.opacity(0.38), lineWidth: 0.4)

            SUVAccentStripeShape()
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.racingYellow.opacity(0.5),
                            appearance.accentColor.opacity(0.35),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            SUVWheelArchShape()
                .stroke(appearance.accentColor.opacity(0.38), lineWidth: 0.48)
        }
        .frame(width: bodyWidth * 0.9, height: bodyHeight * 1.15)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.56),
                HotWheelsTheme.electricBlue.opacity(0.26),
                appearance.accentColor.opacity(0.55),
            ],
            startPoint: UnitPoint(x: 0.12, y: 0),
            endPoint: UnitPoint(x: 0.88, y: 1)
        )
    }
}

// MARK: - Body silhouette (tall SUV, front left → rear right)

private struct SUVBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.05, y: ground - h * 0.26))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.14, y: ground - h * 0.4),
            control: CGPoint(x: w * 0.07, y: ground - h * 0.32)
        )
        path.addLine(to: CGPoint(x: w * 0.16, y: ground - h * 0.9))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.24, y: ground - h * 0.94),
            control: CGPoint(x: w * 0.18, y: ground - h * 0.98)
        )
        path.addLine(to: CGPoint(x: w * 0.94, y: ground - h * 0.94))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.99, y: ground - h * 0.86),
            control: CGPoint(x: w * 0.99, y: ground - h * 0.92)
        )
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.86, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.95, y: ground - h * 0.14)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.2),
            control: CGPoint(x: w * 0.4, y: ground - h * 0.12)
        )
        path.closeSubpath()
        return path
    }
}

private struct SUVCladdingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.08, y: rect.height * 0.58, width: rect.width * 0.88, height: rect.height * 0.16),
            cornerSize: CGSize(width: 3, height: 3)
        )
        return path
    }
}

private struct SUVRockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.12, y: rect.height * 0.7, width: rect.width * 0.8, height: rect.height * 0.08),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SUVWindowRowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let windowCount = 3
        let marginX = rect.width * 0.3
        let availableWidth = rect.width * 0.58
        let gap = availableWidth * 0.05
        let windowWidth = (availableWidth - gap * CGFloat(windowCount - 1)) / CGFloat(windowCount)
        let windowHeight = rect.height * 0.26
        let windowY = rect.height * 0.22

        for index in 0..<windowCount {
            let x = marginX + CGFloat(index) * (windowWidth + gap)
            path.addRoundedRect(
                in: CGRect(x: x, y: windowY, width: windowWidth, height: windowHeight),
                cornerSize: CGSize(width: windowHeight * 0.1, height: windowHeight * 0.1)
            )
        }
        return path
    }
}

private struct SUVWindshieldShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.1, y: rect.height * 0.18, width: rect.width * 0.18, height: rect.height * 0.34)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.18, height: glass.height * 0.18))
        return path
    }
}

private struct SUVGrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let grille = CGRect(x: 0, y: rect.height * 0.46, width: rect.width * 0.1, height: rect.height * 0.22)
        path.addRoundedRect(in: grille, cornerSize: CGSize(width: 2, height: 2))
        let barWidth = grille.width * 0.18
        for index in 0..<4 {
            let x = grille.minX + CGFloat(index + 1) * barWidth
            path.addRect(CGRect(x: x, y: grille.minY + grille.height * 0.1, width: barWidth * 0.35, height: grille.height * 0.8))
        }
        return path
    }
}

private struct SUVSkidPlateShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.78, width: rect.width * 0.12, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SUVFrontBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.72, width: rect.width * 0.11, height: rect.height * 0.14),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SUVRearBumperShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.91, y: rect.height * 0.7, width: rect.width * 0.09, height: rect.height * 0.14),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SUVHeadlightShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.048
        let center = CGPoint(x: rect.width * 0.08, y: rect.height * 0.48)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct SUVTaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.93, y: rect.height * 0.42, width: rect.width * 0.05, height: rect.height * 0.18),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SUVRoofRailShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rackY = rect.height * 0.1
        path.move(to: CGPoint(x: rect.width * 0.22, y: rackY))
        path.addLine(to: CGPoint(x: rect.width * 0.92, y: rackY))
        path.move(to: CGPoint(x: rect.width * 0.3, y: rackY + rect.height * 0.035))
        path.addLine(to: CGPoint(x: rect.width * 0.3, y: rackY))
        path.move(to: CGPoint(x: rect.width * 0.55, y: rackY + rect.height * 0.035))
        path.addLine(to: CGPoint(x: rect.width * 0.55, y: rackY))
        path.move(to: CGPoint(x: rect.width * 0.78, y: rackY + rect.height * 0.035))
        path.addLine(to: CGPoint(x: rect.width * 0.78, y: rackY))
        return path.strokedPath(StrokeStyle(lineWidth: 0.5, lineCap: .round))
    }
}

private struct SUVRunningBoardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.18, y: rect.height * 0.62, width: rect.width * 0.62, height: rect.height * 0.05),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct SUVSpareTireShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.065
        let center = CGPoint(x: rect.width * 0.88, y: rect.height * 0.48)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct SUVDoorLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.56))
        path.addLine(to: CGPoint(x: rect.width * 0.48, y: rect.height * 0.26))
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
    }
}

private struct SUVAccentStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: rect.width * 0.32, y: rect.height * 0.52, width: rect.width * 0.5, height: rect.height * 0.04))
        return path
    }
}

private struct SUVWheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.1, y: rect.height * 0.54, width: rect.width * 0.22, height: rect.height * 0.24),
            CGRect(x: rect.width * 0.66, y: rect.height * 0.54, width: rect.width * 0.22, height: rect.height * 0.24),
        ]
        for arch in arches {
            path.addEllipse(in: arch)
        }
        return path.strokedPath(StrokeStyle(lineWidth: 0.48))
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

#Preview("SUV standalone") {
    CarView(
        car: CarDesign.suv.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
