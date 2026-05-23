//
//  CarCatalog.swift
//  Tight Rope Car
//

import SwiftUI

/// Static registry of every selectable car.
enum CarCatalog {
    /// Used when a profile has no saved car or the saved id is invalid.
    static let defaultCarID = "blaze"

    static let all: [SelectableCar] = [
        blaze,
        volt,
        sunset,
        midnight,
        citrus,
        glacier,
    ].sorted { $0.sortOrder < $1.sortOrder }

    static var defaultCar: SelectableCar {
        car(id: defaultCarID) ?? all[0]
    }

    static func car(id: String) -> SelectableCar? {
        all.first { $0.id == id }
    }

    // MARK: - Cars

    private static let blaze = SelectableCar(
        id: "blaze",
        displayName: "Blaze Runner",
        tagline: "Classic flame red speed",
        appearance: CarAppearance(
            bodyColor: HotWheelsTheme.hotRed,
            accentColor: HotWheelsTheme.trackBlack,
            scale: 1.0,
            renderVersion: .v2
        ),
        sortOrder: 0
    )

    private static let volt = SelectableCar(
        id: "volt",
        displayName: "Volt Strike",
        tagline: "Electric blue on the wire",
        appearance: CarAppearance(
            bodyColor: HotWheelsTheme.electricBlue,
            accentColor: HotWheelsTheme.racingYellow,
            scale: 1.05
        ),
        sortOrder: 1
    )

    private static let sunset = SelectableCar(
        id: "sunset",
        displayName: "Sunset Drift",
        tagline: "Orange glow, golden wheels",
        appearance: CarAppearance(
            bodyColor: HotWheelsTheme.flameOrange,
            accentColor: HotWheelsTheme.racingYellow,
            scale: 1.0
        ),
        sortOrder: 2
    )

    private static let midnight = SelectableCar(
        id: "midnight",
        displayName: "Midnight Flash",
        tagline: "Stealth black, red trim",
        appearance: CarAppearance(
            bodyColor: HotWheelsTheme.trackBlack,
            accentColor: HotWheelsTheme.hotRed,
            scale: 0.95
        ),
        sortOrder: 3
    )

    private static let citrus = SelectableCar(
        id: "citrus",
        displayName: "Citrus Bolt",
        tagline: "Yellow body, red accents",
        appearance: CarAppearance(
            bodyColor: HotWheelsTheme.racingYellow,
            accentColor: HotWheelsTheme.hotRed,
            scale: 1.08
        ),
        sortOrder: 4
    )

    private static let glacier = SelectableCar(
        id: "glacier",
        displayName: "Glacier Edge",
        tagline: "Cool blue, silver wheels",
        appearance: CarAppearance(
            bodyColor: Color(red: 0.75, green: 0.92, blue: 1.0),
            accentColor: Color(red: 0.55, green: 0.6, blue: 0.65),
            scale: 1.0
        ),
        sortOrder: 5
    )
}
