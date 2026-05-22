//
//  CourseHighScore.swift
//  Tight Rope Car
//

import Foundation
import SwiftData

@Model
final class CourseHighScore {
    var courseID: String
    /// Elapsed seconds; lower is better. Nil until the player finishes a run.
    var bestTimeSeconds: Double?
    /// Distance along the rope; higher is better. Nil until recorded.
    var bestDistance: Double?

    var profile: PlayerProfile?

    init(
        courseID: String,
        bestTimeSeconds: Double? = nil,
        bestDistance: Double? = nil,
        profile: PlayerProfile? = nil
    ) {
        self.courseID = courseID
        self.bestTimeSeconds = bestTimeSeconds
        self.bestDistance = bestDistance
        self.profile = profile
    }
}
