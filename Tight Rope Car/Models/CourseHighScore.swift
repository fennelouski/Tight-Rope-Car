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
    /// Most tickets collected in a single run on this course.
    var bestTicketCount: Int?

    var profile: PlayerProfile?

    init(
        courseID: String,
        bestTimeSeconds: Double? = nil,
        bestDistance: Double? = nil,
        bestTicketCount: Int? = nil,
        profile: PlayerProfile? = nil
    ) {
        self.courseID = courseID
        self.bestTimeSeconds = bestTimeSeconds
        self.bestDistance = bestDistance
        self.bestTicketCount = bestTicketCount
        self.profile = profile
    }
}
