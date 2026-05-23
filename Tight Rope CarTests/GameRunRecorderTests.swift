//
//  GameRunRecorderTests.swift
//  Tight Rope CarTests
//

import SwiftData
import Testing
@testable import Tight_Rope_Car

struct GameRunRecorderTests {

    @Test @MainActor func successMarksCompleteWithoutSeedingSampleScores() throws {
        let container = try ModelContainer(
            for: PlayerProfile.self, CourseHighScore.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        let profile = PlayerProfile(name: "Test", age: 8)
        context.insert(profile)

        let stats = GameRunStats(elapsedSeconds: 41, distanceMeters: 512, ticketsCollected: 2)
        let result = try GameRunRecorder.record(
            .success(stats),
            courseID: "tutorial",
            for: profile,
            context: context
        )

        #expect(result.unlockedCourseNow)
        #expect(result.isNewBestTime)
        #expect(result.isNewBestDistance)
        #expect(result.ticketsCollected == 2)
        #expect(result.isNewBestTicketCount)
        #expect(result.newTotalTickets == 2)
        #expect(profile.totalTickets == 2)
        #expect(profile.completedCourseIDs.contains("tutorial"))

        let score = CourseScoreStore.score(for: "tutorial", on: profile)
        #expect(score?.bestTimeSeconds == 41)
        #expect(score?.bestDistance == 512)
        #expect(score?.bestTicketCount == 2)
    }

    @Test @MainActor func failureRecordsDistanceOnly() throws {
        let container = try ModelContainer(
            for: PlayerProfile.self, CourseHighScore.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        let profile = PlayerProfile(name: "Test", age: 8)
        context.insert(profile)
        let existing = CourseHighScore(courseID: "tutorial", bestTimeSeconds: 30, profile: profile)
        profile.highScores.append(existing)
        try context.save()

        let stats = GameRunStats(elapsedSeconds: 12, distanceMeters: 400, ticketsCollected: 1)
        let result = try GameRunRecorder.record(
            .failure(stats),
            courseID: "tutorial",
            for: profile,
            context: context
        )

        #expect(!result.unlockedCourseNow)
        #expect(!result.isNewBestTime)
        #expect(result.isNewBestDistance)
        #expect(result.ticketsCollected == 1)
        #expect(result.newTotalTickets == 1)
        #expect(profile.totalTickets == 1)
        #expect(profile.completedCourseIDs.isEmpty)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestTimeSeconds == 30)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestDistance == 400)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestTicketCount == 1)
    }
}
