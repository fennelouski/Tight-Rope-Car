//
//  PlayerProfile.swift
//  Tight Rope Car
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class PlayerProfile {
    var id: UUID
    var name: String
    var age: Int
    var avatarJPEGData: Data?
    var createdAt: Date
    /// Catalog car id (see ``CarCatalog``); nil until the player picks a car.
    var selectedCarID: String?
    /// Course ids beaten at least once (see ``CourseMapCatalog`` for unlock graph).
    var completedCourseIDs: [String]
    /// Cumulative tickets collected across all runs on all courses.
    var totalTickets: Int
    /// Index into ``PlayerColorPalette/all``; defaults to Electric Blue (13).
    var profileColorIndex: Int
    /// Last calibrated device roll (radians) used as neutral tilt; updated at run start.
    var tiltNeutralRollRadians: Double?
    @Relationship(deleteRule: .cascade, inverse: \CourseHighScore.profile)
    var highScores: [CourseHighScore]

    init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        avatarJPEGData: Data? = nil,
        createdAt: Date = Date(),
        selectedCarID: String? = nil,
        completedCourseIDs: [String] = [],
        totalTickets: Int = 0,
        profileColorIndex: Int = ProfileConstants.defaultProfileColorIndex,
        tiltNeutralRollRadians: Double? = nil,
        highScores: [CourseHighScore] = []
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.avatarJPEGData = avatarJPEGData
        self.createdAt = createdAt
        self.selectedCarID = selectedCarID
        self.completedCourseIDs = completedCourseIDs
        self.totalTickets = totalTickets
        self.profileColorIndex = profileColorIndex
        self.tiltNeutralRollRadians = tiltNeutralRollRadians
        self.highScores = highScores
    }

    var displayName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var hasAvatar: Bool {
        avatarJPEGData != nil
    }

    var profileColor: Color {
        PlayerColorPalette.color(at: profileColorIndex)
    }

    /// Saved catalog id when valid; otherwise ``CarConstants/defaultCarID``.
    var resolvedCarID: String {
        guard let selectedCarID, CarCatalog.car(id: selectedCarID) != nil else {
            return CarConstants.defaultCarID
        }
        return selectedCarID
    }
}
