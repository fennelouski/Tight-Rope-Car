//
//  SelectableCar.swift
//  Tight Rope Car
//

import SwiftUI

/// Static catalog entry for the car picker (not the runtime ``Car`` entity).
struct SelectableCar: Identifiable, Equatable {
    let id: String
    let displayName: String
    let tagline: String?
    let appearance: CarAppearance
    let sortOrder: Int

    init(
        id: String,
        displayName: String,
        tagline: String? = nil,
        appearance: CarAppearance,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.displayName = displayName
        self.tagline = tagline
        self.appearance = appearance
        self.sortOrder = sortOrder
    }

    /// Preview/runtime car for ``CarView`` (neutral pose).
    var previewCar: Car {
        Car(appearance: appearance)
    }
}
