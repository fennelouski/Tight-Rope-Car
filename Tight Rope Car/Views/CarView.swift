//
//  CarView.swift
//  Tight Rope Car
//
//  Created by Nathan Fennel on 5/22/26.
//

import SwiftUI

/// Visual representation of a `Car` for previews and future game placement.
struct CarView: View {
    let car: Car
    var size: CGSize = CGSize(width: 80, height: 40)

    private var appearance: CarAppearance { car.appearance }

    private var scaledSize: CGSize {
        CGSize(
            width: size.width * appearance.scale,
            height: size.height * appearance.scale
        )
    }

    var body: some View {
        let s = scaledSize
        let wheelDiameter = s.height * 0.45 * appearance.wheelSizeMultiplier
        let wheelSpacing = s.width * 0.12 * appearance.wheelSpacingMultiplier

        ZStack(alignment: .bottom) {
            if appearance.renderVersion == .v2 {
                switch appearance.silhouette {
                case .raceCar:
                    RaceCarV2View(appearance: appearance, size: s)
                case .classicBug:
                    ClassicBugV2View(appearance: appearance, size: s)
                default:
                    wheelRow(size: s, defaultDiameter: wheelDiameter, defaultSpacing: wheelSpacing)
                    carBody(in: s, wheelDiameter: wheelDiameter)
                        .offset(y: -wheelDiameter * bodyVerticalOffsetFactor)
                }
            } else {
                wheelRow(size: s, defaultDiameter: wheelDiameter, defaultSpacing: wheelSpacing)

                carBody(in: s, wheelDiameter: wheelDiameter)
                    .offset(y: -wheelDiameter * bodyVerticalOffsetFactor)
            }
        }
        .frame(width: s.width, height: s.height)
        .offset(x: car.lateralOffset * s.width, y: 0)
        .rotationEffect(car.tiltAngle, anchor: .bottom)
    }

    private func wheelRow(size: CGSize, defaultDiameter: CGFloat, defaultSpacing: CGFloat) -> some View {
        HStack(spacing: defaultSpacing) {
            wheel(diameter: defaultDiameter)
            wheel(diameter: defaultDiameter)
        }
    }

    private var bodyVerticalOffsetFactor: CGFloat {
        switch appearance.silhouette {
        case .sports: 0.28
        case .raceCar: 0.26
        case .convertible: 0.3
        case .van: 0.38
        case .suv: 0.4
        case .iceCreamTruck: 0.4
        case .fireTruck: 0.38
        case .schoolBus: 0.42
        case .ambulance: 0.38
        case .motorcycle: 0.22
        default: 0.35
        }
    }

    private func wheel(diameter: CGFloat) -> some View {
        Group {
            if appearance.silhouette == .iceCreamTruck {
                ZStack {
                    Circle()
                        .fill(appearance.accentColor)
                        .frame(width: diameter, height: diameter)
                    Circle()
                        .fill(appearance.bodyColor.opacity(0.35))
                        .frame(width: diameter * 0.55, height: diameter * 0.55)
                }
            } else {
                Circle()
                    .fill(appearance.accentColor)
            }
        }
        .frame(width: diameter, height: diameter)
    }

    @ViewBuilder
    private func carBody(in size: CGSize, wheelDiameter: CGFloat) -> some View {
        let bodyHeight = size.height * bodyHeightFactor
        let bodyWidth = size.width * 0.85 * appearance.bodyAspectRatio

        switch appearance.silhouette {
        case .classicBug:
            RoundedRectangle(cornerRadius: bodyHeight * 0.42)
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth, height: bodyHeight * 0.92)
        case .pickup:
            PickupBodyShape()
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth, height: bodyHeight * 1.05)
        case .sports:
            RoundedRectangle(cornerRadius: bodyHeight * 0.12)
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth, height: bodyHeight * 0.62)
        case .van:
            RoundedRectangle(cornerRadius: bodyHeight * 0.08)
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth * 0.88, height: bodyHeight * 1.18)
        case .micro:
            RoundedRectangle(cornerRadius: bodyHeight * 0.35)
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth * 0.9, height: bodyHeight * 0.88)
        case .convertible:
            Capsule()
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth, height: bodyHeight * 0.58)
        case .suv:
            RoundedRectangle(cornerRadius: bodyHeight * 0.06)
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth * 0.9, height: bodyHeight * 1.15)
        case .raceCar:
            RaceCarBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    RaceCarWingShape()
                        .fill(appearance.accentColor)
                }
                .frame(width: bodyWidth, height: bodyHeight * 0.58)
        case .iceCreamTruck:
            IceCreamTruckBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    IceCreamTruckRoofBandShape()
                        .fill(appearance.accentColor)
                }
                .overlay {
                    IceCreamTruckWindowsShape()
                        .fill(appearance.accentColor.opacity(0.85))
                }
                .frame(width: bodyWidth * 0.92, height: bodyHeight * 1.12)
        case .taxi:
            TaxiBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    TaxiCheckerStripeShape()
                        .fill(appearance.accentColor)
                }
                .frame(width: bodyWidth, height: bodyHeight * 0.82)
        case .fireTruck:
            FireTruckBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    FireTruckLadderStripeShape()
                        .fill(appearance.accentColor)
                }
                .frame(width: bodyWidth, height: bodyHeight * 1.08)
        case .schoolBus:
            SchoolBusBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    SchoolBusWindowRowShape()
                        .fill(appearance.accentColor.opacity(0.75))
                }
                .frame(width: bodyWidth, height: bodyHeight * 0.95)
        case .policeCar:
            PoliceCarBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    PoliceCarDoorAccentShape()
                        .fill(appearance.accentColor)
                }
                .frame(width: bodyWidth, height: bodyHeight * 0.8)
        case .ambulance:
            AmbulanceBodyShape()
                .fill(appearance.bodyColor)
                .overlay {
                    AmbulanceCrossShape()
                        .fill(appearance.accentColor)
                }
                .frame(width: bodyWidth * 0.94, height: bodyHeight * 1.05)
        case .motorcycle:
            Capsule()
                .fill(appearance.bodyColor)
                .frame(width: bodyWidth, height: bodyHeight * 0.42)
        }
    }

    private var bodyHeightFactor: CGFloat {
        switch appearance.silhouette {
        case .sports: 0.5
        case .raceCar: 0.48
        case .convertible: 0.52
        case .van: 0.62
        case .suv: 0.64
        case .iceCreamTruck: 0.62
        case .pickup: 0.58
        case .micro: 0.52
        case .classicBug: 0.55
        case .taxi: 0.56
        case .fireTruck: 0.6
        case .schoolBus: 0.54
        case .policeCar: 0.54
        case .ambulance: 0.6
        case .motorcycle: 0.38
        }
    }
}

// MARK: - Pickup cab + bed

private struct PickupBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bedWidth = rect.width * 0.42
        let cabWidth = rect.width - bedWidth
        let cabHeight = rect.height * 0.88
        let bedHeight = rect.height * 0.72
        let cabRect = CGRect(x: 0, y: rect.height - cabHeight, width: cabWidth, height: cabHeight)
        let bedRect = CGRect(x: cabWidth, y: rect.height - bedHeight, width: bedWidth, height: bedHeight)

        path.addRoundedRect(in: cabRect, cornerSize: CGSize(width: cabHeight * 0.22, height: cabHeight * 0.22))
        path.addRect(bedRect)
        return path
    }
}

// MARK: - Extended designs

private struct RaceCarBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: rect.height * 0.15, height: rect.height * 0.15)
        )
        return path
    }
}

private struct RaceCarWingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let wingRect = CGRect(
            x: rect.width * 0.68,
            y: rect.height * 0.05,
            width: rect.width * 0.28,
            height: rect.height * 0.22
        )
        path.addRect(wingRect)
        return path
    }
}

private struct IceCreamTruckBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: rect.height * 0.08, height: rect.height * 0.08)
        )
        return path
    }
}

private struct IceCreamTruckRoofBandShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(x: 0, y: 0, width: rect.width, height: rect.height * 0.18))
        return path
    }
}

private struct IceCreamTruckWindowsShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let windowRect = CGRect(
            x: rect.width * 0.12,
            y: rect.height * 0.28,
            width: rect.width * 0.35,
            height: rect.height * 0.22
        )
        path.addRect(windowRect)
        return path
    }
}

private struct TaxiBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: rect.height * 0.18, height: rect.height * 0.18)
        )
        return path
    }
}

// MARK: - Service vehicles

private struct FireTruckBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cabWidth = rect.width * 0.38
        let cabHeight = rect.height * 0.92
        let bodyWidth = rect.width - cabWidth
        let cabRect = CGRect(x: 0, y: rect.height - cabHeight, width: cabWidth, height: cabHeight)
        let bodyRect = CGRect(x: cabWidth, y: rect.height * 0.08, width: bodyWidth, height: rect.height * 0.92)

        path.addRoundedRect(in: cabRect, cornerSize: CGSize(width: cabHeight * 0.12, height: cabHeight * 0.12))
        path.addRoundedRect(in: bodyRect, cornerSize: CGSize(width: rect.height * 0.06, height: rect.height * 0.06))
        return path
    }
}

private struct FireTruckLadderStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let ladderRect = CGRect(
            x: rect.width * 0.42,
            y: rect.height * 0.02,
            width: rect.width * 0.52,
            height: rect.height * 0.14
        )
        path.addRect(ladderRect)
        let stripeCount = 5
        let stripeWidth = ladderRect.width / CGFloat(stripeCount * 2)
        for index in 0..<stripeCount where index % 2 == 0 {
            let x = ladderRect.minX + CGFloat(index) * stripeWidth * 2
            path.addRect(CGRect(x: x, y: ladderRect.minY, width: stripeWidth, height: ladderRect.height))
        }
        return path
    }
}

private struct SchoolBusBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: rect.height * 0.12, height: rect.height * 0.12)
        )
        return path
    }
}

private struct SchoolBusWindowRowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let windowCount = 5
        let marginX = rect.width * 0.08
        let availableWidth = rect.width - marginX * 2
        let gap = availableWidth * 0.04
        let windowWidth = (availableWidth - gap * CGFloat(windowCount - 1)) / CGFloat(windowCount)
        let windowHeight = rect.height * 0.28
        let windowY = rect.height * 0.22

        for index in 0..<windowCount {
            let x = marginX + CGFloat(index) * (windowWidth + gap)
            path.addRoundedRect(
                in: CGRect(x: x, y: windowY, width: windowWidth, height: windowHeight),
                cornerSize: CGSize(width: windowHeight * 0.15, height: windowHeight * 0.15)
            )
        }
        return path
    }
}

private struct PoliceCarBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: rect.height * 0.2, height: rect.height * 0.2)
        )
        return path
    }
}

private struct PoliceCarDoorAccentShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(
            x: rect.width * 0.38,
            y: rect.height * 0.28,
            width: rect.width * 0.32,
            height: rect.height * 0.38
        ))
        return path
    }
}

private struct AmbulanceBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: rect,
            cornerSize: CGSize(width: rect.height * 0.1, height: rect.height * 0.1)
        )
        return path
    }
}

private struct AmbulanceCrossShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let crossSize = min(rect.width, rect.height) * 0.28
        let centerX = rect.width * 0.72
        let centerY = rect.height * 0.45
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
        let stripeRect = CGRect(
            x: rect.width * 0.06,
            y: rect.height * 0.62,
            width: rect.width * 0.22,
            height: rect.height * 0.12
        )
        path.addRect(stripeRect)
        return path
    }
}

private struct TaxiCheckerStripeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let stripeHeight = rect.height * 0.22
        let stripeY = rect.height * 0.42
        let squareSize = rect.width * 0.08
        let columns = 4

        for column in 0..<columns {
            let x = rect.width * 0.52 + CGFloat(column) * squareSize
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

#Preview("Car states") {
    HStack(spacing: 32) {
        VStack {
            CarView(car: .defaultCar)
            Text("Default")
                .font(.caption)
        }
        VStack {
            CarView(car: Car(tiltRadians: 0.5))
            Text("Tilted")
                .font(.caption)
        }
        VStack {
            CarView(car: Car(lateralOffset: 0.4))
            Text("Offset")
                .font(.caption)
        }
        VStack {
            CarView(car: .preview)
            Text("Preview")
                .font(.caption)
        }
    }
    .padding()
}

#Preview("Classic bug v1 vs v2") {
    let frame = CGSize(width: 96, height: 48)
    let v1Appearance = CarAppearance(
        bodyColor: Color(red: 0.82, green: 0.22, blue: 0.18),
        accentColor: Color(red: 0.15, green: 0.12, blue: 0.12),
        scale: 0.85,
        silhouette: .classicBug,
        bodyAspectRatio: 1.35,
        wheelSpacingMultiplier: 0.88,
        wheelSizeMultiplier: 0.95,
        renderVersion: .v1
    )
    HStack(spacing: 28) {
        VStack(spacing: 6) {
            CarView(car: Car(appearance: v1Appearance), size: frame)
            Text("Classic Bug v1")
                .font(.caption)
        }
        VStack(spacing: 6) {
            CarView(car: CarDesign.classicBug.makeCar(), size: frame)
            Text("Classic Bug v2")
                .font(.caption)
        }
    }
    .padding()
}

#Preview("Race car v1 vs v2") {
    let frame = CGSize(width: 96, height: 48)
    let v1Appearance = CarAppearance(
        bodyColor: HotWheelsTheme.hotRed,
        accentColor: HotWheelsTheme.trackBlack,
        scale: 1.0,
        silhouette: .raceCar,
        bodyAspectRatio: 1.6,
        wheelSpacingMultiplier: 0.78,
        wheelSizeMultiplier: 1.0,
        renderVersion: .v1
    )
    HStack(spacing: 28) {
        VStack(spacing: 6) {
            CarView(car: Car(appearance: v1Appearance), size: frame)
            Text("Race Car v1")
                .font(.caption)
        }
        VStack(spacing: 6) {
            CarView(car: CarDesign.raceCar.makeCar(), size: frame)
            Text("Race Car v2")
                .font(.caption)
        }
    }
    .padding()
}

#Preview("All 15 car designs") {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 5)
    ScrollView {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(CarDesign.allDesigns) { design in
                VStack(spacing: 6) {
                    CarView(car: design.makeCar(), size: CGSize(width: 72, height: 36))
                    Text(design.displayName)
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
    }
}
