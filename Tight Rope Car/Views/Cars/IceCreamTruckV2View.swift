//
//  IceCreamTruckV2View.swift
//  Tight Rope Car
//
//  Premium side-view ice cream truck renderer (v2).
//

import SwiftUI

/// Die-cast style ice cream truck drawing for ``CarRenderVersion/v2``.
struct IceCreamTruckV2View: View {
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
        size.height * 0.62
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            bodyDropShadow
            wheelContactShadows

            HStack(spacing: wheelSpacing) {
                iceCreamWheel
                iceCreamWheel
            }

            iceCreamBodyStack
                .offset(y: -wheelDiameter * 0.4)
        }
        .frame(width: size.width, height: size.height)
    }

    // MARK: - Ground shadows

    private var bodyDropShadow: some View {
        Ellipse()
            .fill(HotWheelsTheme.trackBlack.opacity(0.22))
            .frame(width: bodyWidth * 0.9, height: size.height * 0.1)
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

    // MARK: - Wheels (white rim + body-color hub, like v1)

    private var iceCreamWheel: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.accentColor.opacity(0.95),
                            appearance.accentColor,
                            HotWheelsTheme.trackBlack.opacity(0.85),
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.5
                    )
                )

            Circle()
                .strokeBorder(appearance.bodyColor.opacity(0.35), lineWidth: wheelDiameter * 0.04)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            appearance.bodyColor.opacity(0.55),
                            appearance.bodyColor.opacity(0.85),
                            appearance.accentColor.opacity(0.5),
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: wheelDiameter * 0.28
                    )
                )
                .frame(width: wheelDiameter * 0.58, height: wheelDiameter * 0.58)

            Circle()
                .strokeBorder(Color.white.opacity(0.35), lineWidth: wheelDiameter * 0.022)
                .frame(width: wheelDiameter * 0.58, height: wheelDiameter * 0.58)
        }
        .frame(width: wheelDiameter, height: wheelDiameter)
    }

    // MARK: - Body stack

    private var iceCreamBodyStack: some View {
        let highlight = appearance.bodyColor.mix(with: .white, amount: 0.28)
        let shadow = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.28)
        let rocker = appearance.bodyColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.16)

        return ZStack {
            IceCreamTruckV2BodyShape()
                .fill(
                    LinearGradient(
                        colors: [highlight, appearance.bodyColor, rocker, shadow],
                        startPoint: UnitPoint(x: 0.3, y: 0),
                        endPoint: UnitPoint(x: 0.6, y: 1)
                    )
                )

            IceCreamTruckV2BodyShape()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.48),
                            appearance.accentColor.opacity(0.85),
                            appearance.accentColor,
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 0.7
                )

            IceCreamTruckV2BodyShape()
                .stroke(Color.white.opacity(0.2), lineWidth: 0.34)
                .padding(1)
                .blendMode(.plusLighter)

            IceCreamTruckV2RoofBandShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, appearance.accentColor.mix(with: HotWheelsTheme.trackBlack, amount: 0.08)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    IceCreamTruckV2RoofBandShape()
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.35)
                }

            IceCreamTruckV2RockerShape()
                .fill(
                    LinearGradient(
                        colors: [shadow.opacity(0.45), appearance.accentColor.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            IceCreamTruckV2CabGlassShape()
                .fill(windowGradient)
                .overlay {
                    IceCreamTruckV2CabGlassShape()
                        .stroke(Color.white.opacity(0.38), lineWidth: 0.38)
                }

            IceCreamTruckV2ServiceWindowShape()
                .fill(windowGradient)
                .overlay {
                    IceCreamTruckV2ServiceWindowShape()
                        .stroke(Color.white.opacity(0.36), lineWidth: 0.38)
                }

            IceCreamTruckV2AwningShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.flameOrange.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    IceCreamTruckV2AwningStripeShape()
                        .fill(
                            LinearGradient(
                                colors: [HotWheelsTheme.hotRed.opacity(0.55), HotWheelsTheme.electricBlue.opacity(0.45)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }

            IceCreamTruckV2GrilleShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack.opacity(0.9)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            IceCreamTruckV2HeadlightShape()
                .fill(
                    RadialGradient(
                        colors: [Color.white, HotWheelsTheme.racingYellow.opacity(0.88)],
                        center: .center,
                        startRadius: 0,
                        endRadius: bodyHeight * 0.06
                    )
                )

            IceCreamTruckV2TaillightShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.hotRed, appearance.accentColor.opacity(0.8)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            IceCreamTruckV2ConeShape()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.flameOrange, HotWheelsTheme.racingYellow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    IceCreamTruckV2ConeScoopShape()
                        .fill(
                            LinearGradient(
                                colors: [appearance.accentColor, appearance.bodyColor.opacity(0.9)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                }

            IceCreamTruckV2SpeakerShape()
                .fill(
                    LinearGradient(
                        colors: [appearance.accentColor, HotWheelsTheme.trackBlack.opacity(0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    IceCreamTruckV2SpeakerShape()
                        .stroke(Color.white.opacity(0.18), lineWidth: 0.3)
                }

            IceCreamTruckV2MusicNotesShape()
                .stroke(HotWheelsTheme.electricBlue.opacity(0.7), lineWidth: 0.4)

            IceCreamTruckV2WheelArchShape()
                .stroke(appearance.accentColor.opacity(0.4), lineWidth: 0.42)
        }
        .frame(width: bodyWidth * 0.92, height: bodyHeight * 1.12)
    }

    private var windowGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(0.62),
                HotWheelsTheme.electricBlue.opacity(0.22),
                appearance.bodyColor.opacity(0.35),
            ],
            startPoint: UnitPoint(x: 0.15, y: 0),
            endPoint: UnitPoint(x: 0.85, y: 1)
        )
    }
}

// MARK: - Body silhouette (cab + box, front left → rear right)

private struct IceCreamTruckV2BodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let ground = rect.maxY
        let cabEnd = w * 0.34

        path.move(to: CGPoint(x: w * 0.02, y: ground - h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.05, y: ground - h * 0.26))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.12, y: ground - h * 0.4),
            control: CGPoint(x: w * 0.06, y: ground - h * 0.32)
        )
        path.addLine(to: CGPoint(x: w * 0.14, y: ground - h * 0.88))
        path.addLine(to: CGPoint(x: cabEnd, y: ground - h * 0.9))
        path.addLine(to: CGPoint(x: w * 0.98, y: ground - h * 0.9))
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.82))
        path.addLine(to: CGPoint(x: w * 0.99, y: ground - h * 0.24))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.88, y: ground - h * 0.16),
            control: CGPoint(x: w * 0.96, y: ground - h * 0.14)
        )
        path.addQuadCurve(
            to: CGPoint(x: cabEnd, y: ground - h * 0.18),
            control: CGPoint(x: w * 0.72, y: ground - h * 0.12)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.02, y: ground - h * 0.2),
            control: CGPoint(x: w * 0.18, y: ground - h * 0.16)
        )
        path.closeSubpath()
        return path
    }
}

private struct IceCreamTruckV2RoofBandShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: 0, y: 0, width: rect.width, height: rect.height * 0.18))
        return path
    }
}

private struct IceCreamTruckV2RockerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.08, y: rect.height * 0.66, width: rect.width * 0.86, height: rect.height * 0.1),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct IceCreamTruckV2CabGlassShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let glass = CGRect(x: rect.width * 0.1, y: rect.height * 0.24, width: rect.width * 0.2, height: rect.height * 0.3)
        path.addRoundedRect(in: glass, cornerSize: CGSize(width: glass.height * 0.15, height: glass.height * 0.15))
        return path
    }
}

private struct IceCreamTruckV2ServiceWindowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let window = CGRect(x: rect.width * 0.4, y: rect.height * 0.32, width: rect.width * 0.38, height: rect.height * 0.26)
        path.addRoundedRect(in: window, cornerSize: CGSize(width: window.height * 0.12, height: window.height * 0.12))
        return path
    }
}

private struct IceCreamTruckV2AwningShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let awningTop = rect.height * 0.28
        path.move(to: CGPoint(x: rect.width * 0.38, y: awningTop))
        path.addLine(to: CGPoint(x: rect.width * 0.82, y: awningTop))
        path.addLine(to: CGPoint(x: rect.width * 0.8, y: awningTop + rect.height * 0.06))
        path.addLine(to: CGPoint(x: rect.width * 0.4, y: awningTop + rect.height * 0.05))
        path.closeSubpath()
        return path
    }
}

private struct IceCreamTruckV2AwningStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let stripeWidth = rect.width * 0.06
        let y = rect.height * 0.29
        for index in 0..<6 {
            if index % 2 == 0 {
                let x = rect.width * 0.4 + CGFloat(index) * stripeWidth
                path.addRect(CGRect(x: x, y: y, width: stripeWidth * 0.9, height: rect.height * 0.05))
            }
        }
        return path
    }
}

private struct IceCreamTruckV2GrilleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: 0, y: rect.height * 0.46, width: rect.width * 0.09, height: rect.height * 0.2),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct IceCreamTruckV2HeadlightShape: Shape {
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

private struct IceCreamTruckV2TaillightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.94, y: rect.height * 0.42, width: rect.width * 0.04, height: rect.height * 0.16),
            cornerSize: CGSize(width: 1.5, height: 1.5)
        )
        return path
    }
}

private struct IceCreamTruckV2ConeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let tip = CGPoint(x: rect.width * 0.58, y: rect.height * 0.58)
        path.move(to: tip)
        path.addLine(to: CGPoint(x: rect.width * 0.52, y: rect.height * 0.48))
        path.addLine(to: CGPoint(x: rect.width * 0.64, y: rect.height * 0.48))
        path.closeSubpath()
        return path
    }
}

private struct IceCreamTruckV2ConeScoopShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) * 0.045
        let center = CGPoint(x: rect.width * 0.58, y: rect.height * 0.44)
        return Path(ellipseIn: CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        ))
    }
}

private struct IceCreamTruckV2SpeakerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(x: rect.width * 0.82, y: rect.height * 0.22, width: rect.width * 0.1, height: rect.height * 0.12),
            cornerSize: CGSize(width: 2, height: 2)
        )
        return path
    }
}

private struct IceCreamTruckV2MusicNotesShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let noteX = rect.width * 0.86
        let noteY = rect.height * 0.2
        path.addEllipse(in: CGRect(x: noteX, y: noteY, width: rect.width * 0.03, height: rect.height * 0.04))
        path.move(to: CGPoint(x: noteX + rect.width * 0.015, y: noteY))
        path.addLine(to: CGPoint(x: noteX + rect.width * 0.015, y: noteY - rect.height * 0.08))
        path.addQuadCurve(
            to: CGPoint(x: noteX + rect.width * 0.05, y: noteY - rect.height * 0.06),
            control: CGPoint(x: noteX + rect.width * 0.04, y: noteY - rect.height * 0.1)
        )
        return path.strokedPath(StrokeStyle(lineWidth: 0.4, lineCap: .round))
    }
}

private struct IceCreamTruckV2WheelArchShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let arches: [CGRect] = [
            CGRect(x: rect.width * 0.1, y: rect.height * 0.54, width: rect.width * 0.2, height: rect.height * 0.22),
            CGRect(x: rect.width * 0.64, y: rect.height * 0.54, width: rect.width * 0.2, height: rect.height * 0.22),
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

#Preview("Ice cream truck v2 standalone") {
    CarView(
        car: CarDesign.iceCreamTruck.makeCar(),
        size: CGSize(width: 96, height: 48)
    )
    .padding()
    .background(Color.gray.opacity(0.15))
}
