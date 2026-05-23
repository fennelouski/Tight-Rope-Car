//
//  GameRunRecorder.swift
//  Tight Rope Car
//

import Foundation
import SwiftData

struct GameRunRecordResult: Equatable {
    var unlockedCourseNow: Bool
    var isNewBestTime: Bool
    var isNewBestDistance: Bool
    var ticketsCollected: Int
    var isNewBestTicketCount: Bool
    var newTotalTickets: Int
}

enum GameRunRecorder {
    @discardableResult
    static func record(
        _ outcome: GameRunOutcome,
        courseID: String,
        for profile: PlayerProfile,
        context: ModelContext
    ) throws -> GameRunRecordResult {
        let stats = outcome.stats

        let isNewBestTicketCount = try CourseScoreStore.recordBestTicketCount(
            stats.ticketsCollected,
            courseID: courseID,
            for: profile,
            context: context
        )
        profile.totalTickets += stats.ticketsCollected

        switch outcome {
        case .success:
            let isNewBestTime = try CourseScoreStore.recordBestTime(
                stats.elapsedSeconds,
                courseID: courseID,
                for: profile,
                context: context
            )
            let isNewBestDistance = try CourseScoreStore.recordBestDistance(
                stats.distanceMeters,
                courseID: courseID,
                for: profile,
                context: context
            )
            let unlockedCourseNow = !profile.completedCourseIDs.contains(courseID)
            try CourseProgressStore.markCompleted(
                courseID: courseID,
                for: profile,
                context: context,
                seedScores: false
            )
            return GameRunRecordResult(
                unlockedCourseNow: unlockedCourseNow,
                isNewBestTime: isNewBestTime,
                isNewBestDistance: isNewBestDistance,
                ticketsCollected: stats.ticketsCollected,
                isNewBestTicketCount: isNewBestTicketCount,
                newTotalTickets: profile.totalTickets
            )

        case .failure:
            let isNewBestDistance = try CourseScoreStore.recordBestDistance(
                stats.distanceMeters,
                courseID: courseID,
                for: profile,
                context: context
            )
            try context.save()
            return GameRunRecordResult(
                unlockedCourseNow: false,
                isNewBestTime: false,
                isNewBestDistance: isNewBestDistance,
                ticketsCollected: stats.ticketsCollected,
                isNewBestTicketCount: isNewBestTicketCount,
                newTotalTickets: profile.totalTickets
            )
        }
    }
}
