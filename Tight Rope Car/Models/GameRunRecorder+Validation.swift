//
//  GameRunRecorder+Validation.swift
//  Tight Rope Car
//

import Foundation

extension GameRunRecorder {
    /// Returns the catalog course when it exists on the map; used before persisting a run.
    static func validatedCourse(id courseID: String) -> Course? {
        guard let course = CourseCatalog.course(id: courseID),
              CourseMapCatalog.node(courseID: courseID) != nil else {
            return nil
        }
        return course
    }

    /// Clamps run stats to sane, course-aware bounds before persistence.
    static func sanitizedStats(_ stats: GameRunStats, for course: Course) -> GameRunStats {
        let maxTickets = max(0, course.ticketCount)
        return GameRunStats(
            elapsedSeconds: max(0, stats.elapsedSeconds),
            distanceMeters: max(0, stats.distanceMeters),
            ticketsCollected: min(max(0, stats.ticketsCollected), maxTickets)
        )
    }

    /// Tickets credited toward profile total: only the increase over the prior per-course best.
    static func ticketCreditDelta(collected: Int, priorBestOnCourse: Int?) -> Int {
        max(0, collected - (priorBestOnCourse ?? 0))
    }
}
