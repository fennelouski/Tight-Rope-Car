//
//  CarDesign.swift
//  Tight Rope Car
//

import SwiftUI

/// Canonical silhouettes and default paint; player-facing list is ``CarCatalog``.
///
/// Case order: original five, middle five (convertible…taxi), service vehicles (fireTruck…motorcycle).
enum CarDesign: String, CaseIterable, Identifiable, Equatable, Sendable {
    case classicBug
    case pickup
    case sports
    case van
    case micro
    case convertible
    case suv
    case raceCar
    case iceCreamTruck
    case taxi
    case fireTruck
    case schoolBus
    case policeCar
    case ambulance
    case motorcycle

    var id: String { rawValue }

    static let allDesigns: [CarDesign] = Array(allCases)

    var displayName: String {
        switch self {
        case .classicBug: "Classic Bug"
        case .pickup: "Pickup"
        case .sports: "Sports"
        case .van: "Van"
        case .micro: "Micro"
        case .convertible: "Convertible"
        case .suv: "SUV"
        case .raceCar: "Race Car"
        case .iceCreamTruck: "Ice Cream Truck"
        case .taxi: "Taxi"
        case .fireTruck: "Fire Truck"
        case .schoolBus: "School Bus"
        case .policeCar: "Police Car"
        case .ambulance: "Ambulance"
        case .motorcycle: "Motorcycle"
        }
    }

    var appearance: CarAppearance {
        switch self {
        case .classicBug:
            CarAppearance(
                bodyColor: Color(red: 0.82, green: 0.22, blue: 0.18),
                accentColor: Color(red: 0.15, green: 0.12, blue: 0.12),
                scale: 0.85,
                silhouette: .classicBug,
                bodyAspectRatio: 1.35,
                wheelSpacingMultiplier: 0.88,
                wheelSizeMultiplier: 0.95
            )
        case .pickup:
            CarAppearance(
                bodyColor: Color(red: 0.2, green: 0.45, blue: 0.78),
                accentColor: Color(red: 0.45, green: 0.48, blue: 0.52),
                scale: 1.1,
                silhouette: .pickup,
                bodyAspectRatio: 1.2,
                wheelSpacingMultiplier: 1.05,
                wheelSizeMultiplier: 1.0            )
        case .sports:
            CarAppearance(
                bodyColor: Color(red: 0.95, green: 0.82, blue: 0.1),
                accentColor: .black,
                scale: 1.0,
                silhouette: .sports,
                bodyAspectRatio: 1.55,
                wheelSpacingMultiplier: 1.28,
                wheelSizeMultiplier: 1.0            )
        case .van:
            CarAppearance(
                bodyColor: .white,
                accentColor: Color(red: 0.28, green: 0.3, blue: 0.32),
                scale: 1.15,
                silhouette: .van,
                bodyAspectRatio: 0.92,
                wheelSpacingMultiplier: 0.95,
                wheelSizeMultiplier: 1.0            )
        case .micro:
            CarAppearance(
                bodyColor: Color(red: 0.45, green: 0.88, blue: 0.72),
                accentColor: Color(red: 0.2, green: 0.35, blue: 0.3),
                scale: 0.7,
                silhouette: .micro,
                bodyAspectRatio: 1.1,
                wheelSpacingMultiplier: 0.82,
                wheelSizeMultiplier: 0.78            )
        case .convertible:
            CarAppearance(
                bodyColor: Color(red: 0.95, green: 0.42, blue: 0.38),
                accentColor: Color(red: 0.72, green: 0.74, blue: 0.76),
                scale: 0.95,
                silhouette: .convertible,
                bodyAspectRatio: 1.25,
                wheelSpacingMultiplier: 0.95,
                wheelSizeMultiplier: 0.95            )
        case .suv:
            CarAppearance(
                bodyColor: Color(red: 0.18, green: 0.42, blue: 0.24),
                accentColor: .black,
                scale: 1.2,
                silhouette: .suv,
                bodyAspectRatio: 0.95,
                wheelSpacingMultiplier: 0.98,
                wheelSizeMultiplier: 1.05            )
        case .raceCar:
            CarAppearance(
                bodyColor: HotWheelsTheme.hotRed,
                accentColor: HotWheelsTheme.trackBlack,
                scale: 1.0,
                silhouette: .raceCar,
                bodyAspectRatio: 1.6,
                wheelSpacingMultiplier: 0.78,
                wheelSizeMultiplier: 1.0            )
        case .iceCreamTruck:
            CarAppearance(
                bodyColor: Color(red: 0.95, green: 0.55, blue: 0.72),
                accentColor: .white,
                scale: 1.1,
                silhouette: .iceCreamTruck,
                bodyAspectRatio: 0.9,
                wheelSpacingMultiplier: 0.92,
                wheelSizeMultiplier: 1.0            )
        case .taxi:
            CarAppearance(
                bodyColor: Color(red: 0.95, green: 0.82, blue: 0.12),
                accentColor: .black,
                scale: 1.0,
                silhouette: .taxi,
                bodyAspectRatio: 1.3,
                wheelSpacingMultiplier: 1.05,
                wheelSizeMultiplier: 1.0            )
        case .fireTruck:
            CarAppearance(
                bodyColor: Color(red: 0.88, green: 0.14, blue: 0.12),
                accentColor: .black,
                scale: 1.15,
                silhouette: .fireTruck,
                bodyAspectRatio: 1.1,
                wheelSpacingMultiplier: 0.9,
                wheelSizeMultiplier: 1.0            )
        case .schoolBus:
            CarAppearance(
                bodyColor: Color(red: 0.92, green: 0.78, blue: 0.12),
                accentColor: .black,
                scale: 1.1,
                silhouette: .schoolBus,
                bodyAspectRatio: 1.45,
                wheelSpacingMultiplier: 1.22,
                wheelSizeMultiplier: 1.0            )
        case .policeCar:
            CarAppearance(
                bodyColor: Color(red: 0.12, green: 0.28, blue: 0.62),
                accentColor: .white,
                scale: 1.0,
                silhouette: .policeCar,
                bodyAspectRatio: 1.28,
                wheelSpacingMultiplier: 1.02,
                wheelSizeMultiplier: 1.0            )
        case .ambulance:
            CarAppearance(
                bodyColor: .white,
                accentColor: Color(red: 0.9, green: 0.15, blue: 0.18),
                scale: 1.05,
                silhouette: .ambulance,
                bodyAspectRatio: 1.05,
                wheelSpacingMultiplier: 0.96,
                wheelSizeMultiplier: 1.0            )
        case .motorcycle:
            CarAppearance(
                bodyColor: Color(red: 0.22, green: 0.24, blue: 0.28),
                accentColor: Color(red: 0.55, green: 0.58, blue: 0.62),
                scale: 0.75,
                silhouette: .motorcycle,
                bodyAspectRatio: 0.55,
                wheelSpacingMultiplier: 0.58,
                wheelSizeMultiplier: 0.88            )
        }
    }

    func makeCar(
        progressAlongRope: Double = 0,
        lateralOffset: Double = 0,
        tiltRadians: Double = 0
    ) -> Car {
        Car(
            progressAlongRope: progressAlongRope,
            lateralOffset: lateralOffset,
            tiltRadians: tiltRadians,
            appearance: appearance
        )
    }
}
