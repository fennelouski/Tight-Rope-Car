//
//  CarCatalog.swift
//  Tight Rope Car
//

import SwiftUI

/// Static registry of every selectable car in the garage.
///
/// IDs match ``CarDesign`` raw values. Legacy color-car IDs (`blaze`, `volt`, …) resolve via ``legacyIDMap``.
enum CarCatalog {
    /// Used when a profile has no saved car or the saved id is invalid.
    static let defaultCarID = "classicBug"

    /// Maps pre–15-car catalog IDs to current catalog IDs (SwiftData migration).
    static let legacyIDMap: [String: String] = [
        "blaze": "classicBug",
        "volt": "raceCar",
        "sunset": "sports",
        "midnight": "pickup",
        "citrus": "micro",
        "glacier": "suv",
    ]

    static let all: [SelectableCar] = CarDesign.allDesigns.enumerated().map { index, design in
        entry(for: design, sortOrder: index)
    }

    static var defaultCar: SelectableCar {
        car(id: defaultCarID) ?? all[0]
    }

    /// Resolves legacy garage IDs to current catalog IDs.
    static func canonicalCarID(_ id: String) -> String {
        legacyIDMap[id] ?? id
    }

    static func car(id: String) -> SelectableCar? {
        let canonical = canonicalCarID(id)
        return all.first { $0.id == canonical }
    }

    // MARK: - Entries

    private static func entry(for design: CarDesign, sortOrder: Int) -> SelectableCar {
        SelectableCar(
            id: design.rawValue,
            displayName: displayName(for: design),
            tagline: tagline(for: design),
            appearance: design.appearance,
            sortOrder: sortOrder
        )
    }

    private static func displayName(for design: CarDesign) -> String {
        switch design {
        case .classicBug: "Blaze Runner"
        case .pickup: "Midnight Hauler"
        case .sports: "Sunset Drift"
        case .van: "Cloud Cruiser"
        case .micro: "Citrus Bolt"
        case .convertible: "Coral Coast"
        case .suv: "Glacier Edge"
        case .raceCar: "Volt Strike"
        case .iceCreamTruck: "Sprinkle Express"
        case .taxi: "Checker Champ"
        case .fireTruck: "Ladder Flash"
        case .schoolBus: "Hall Pass"
        case .policeCar: "Badge Pursuit"
        case .ambulance: "Rescue Rush"
        case .motorcycle: "Wire Rider"
        }
    }

    private static func tagline(for design: CarDesign) -> String {
        switch design {
        case .classicBug: "Classic flame red speed"
        case .pickup: "Stealth hauler, red trim"
        case .sports: "Orange glow, golden wheels"
        case .van: "Room to roll on the wire"
        case .micro: "Small body, big nerve"
        case .convertible: "Top down, wind up"
        case .suv: "Cool blue, silver wheels"
        case .raceCar: "Electric blue on the wire"
        case .iceCreamTruck: "Sweet wheels, cold nerves"
        case .taxi: "Fare game, fair balance"
        case .fireTruck: "Hot red, steady line"
        case .schoolBus: "Yellow convoy, tight turns"
        case .policeCar: "Blue lights, tight rope"
        case .ambulance: "White coat, red cross"
        case .motorcycle: "Two wheels, one rope"
        }
    }
}
