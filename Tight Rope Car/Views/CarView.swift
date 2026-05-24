//
//  CarView.swift
//  Tight Rope Car
//
//  Created by Nathan Fennel on 5/22/26.
//

import SwiftUI

/// SwiftUI car art for a ``Car``; routes ``CarAppearance`` / ``CarSilhouette`` to `Views/Cars/*`.
/// Used in the garage (`CarRowView`), design picker, and previews; rasterized by ``CarAppearanceTextureRenderer`` for SpriteKit runs.
struct CarView: View {
    let car: Car
    var size: CGSize = CGSize(width: 80, height: 40)

    private var appearance: CarAppearance { car.appearance }

    private var scaledSize: CGSize {
        CGSize(
            width: size.width * appearance.scale * appearance.bodyAspectRatio,
            height: size.height * appearance.scale
        )
    }

    var body: some View {
        let s = scaledSize

        ZStack(alignment: .bottom) {
            switch appearance.silhouette {
            case .raceCar:
                RaceCarView(appearance: appearance, size: s)
            case .classicBug:
                ClassicBugView(appearance: appearance, size: s)
            case .sports:
                SportsView(appearance: appearance, size: s)
            case .pickup:
                PickupView(appearance: appearance, size: s)
            case .van:
                VanView(appearance: appearance, size: s)
            case .micro:
                MicroView(appearance: appearance, size: s)
            case .convertible:
                ConvertibleView(appearance: appearance, size: s)
            case .suv:
                SUVView(appearance: appearance, size: s)
            case .iceCreamTruck:
                IceCreamTruckView(appearance: appearance, size: s)
            case .taxi:
                TaxiView(appearance: appearance, size: s)
            case .fireTruck:
                FireTruckView(appearance: appearance, size: s)
            case .schoolBus:
                SchoolBusView(appearance: appearance, size: s)
            case .policeCar:
                PoliceCarView(appearance: appearance, size: s)
            case .ambulance:
                AmbulanceView(appearance: appearance, size: s)
            case .motorcycle:
                MotorcycleView(appearance: appearance, size: s)
            }
        }
        .frame(width: s.width, height: s.height)
        .offset(x: car.lateralOffset * s.width, y: 0)
        .rotationEffect(car.tiltAngle, anchor: .bottom)
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
