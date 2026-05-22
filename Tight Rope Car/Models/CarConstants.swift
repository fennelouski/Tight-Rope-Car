//
//  CarConstants.swift
//  Tight Rope Car
//

import Foundation

enum CarConstants {
    /// Per-profile car choice is stored on ``PlayerProfile/selectedCarID``.
    /// ``CarCatalog/defaultCarID`` is used at runtime when that field is nil or invalid.
    static let defaultCarID = CarCatalog.defaultCarID
}
