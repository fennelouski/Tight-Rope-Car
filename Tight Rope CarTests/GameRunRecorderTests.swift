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
        #expect(result.ticketsCreditedToProfile == 2)
        #expect(result.newTotalTickets == 2)
        #expect(profile.totalTickets == 2)
        #expect(profile.completedCourseIDs == ["tutorial"])

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
        #expect(result.ticketsCreditedToProfile == 1)
        #expect(result.newTotalTickets == 1)
        #expect(profile.totalTickets == 1)
        #expect(profile.completedCourseIDs.isEmpty)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestTimeSeconds == 30)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestDistance == 400)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestTicketCount == 1)
    }

    @Test @MainActor func repeatSuccessDoesNotDoubleCreditTickets() throws {
        let container = try ModelContainer(
            for: PlayerProfile.self, CourseHighScore.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        let profile = PlayerProfile(name: "Test", age: 8)
        context.insert(profile)

        let stats = GameRunStats(elapsedSeconds: 40, distanceMeters: 500, ticketsCollected: 3)
        _ = try GameRunRecorder.record(.success(stats), courseID: "tutorial", for: profile, context: context)
        let second = try GameRunRecorder.record(.success(stats), courseID: "tutorial", for: profile, context: context)

        #expect(!second.unlockedCourseNow)
        #expect(second.ticketsCreditedToProfile == 0)
        #expect(profile.totalTickets == 3)
        #expect(profile.completedCourseIDs.filter { $0 == "tutorial" }.count == 1)
    }

    @Test @MainActor func invalidCourseThrowsWithoutMutatingProfile() throws {
        let container = try ModelContainer(
            for: PlayerProfile.self, CourseHighScore.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        let profile = PlayerProfile(name: "Test", age: 8, totalTickets: 5)
        context.insert(profile)

        let stats = GameRunStats(elapsedSeconds: 10, distanceMeters: 100, ticketsCollected: 2)
        #expect(throws: GameRunRecordError.invalidCourse("not_a_real_course")) {
            try GameRunRecorder.record(
                .success(stats),
                courseID: "not_a_real_course",
                for: profile,
                context: context
            )
        }
        #expect(profile.totalTickets == 5)
        #expect(profile.completedCourseIDs.isEmpty)
        #expect(profile.highScores.isEmpty)
    }

    @Test @MainActor func ticketsAreClampedToCourseMaximum() throws {
        let container = try ModelContainer(
            for: PlayerProfile.self, CourseHighScore.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        let profile = PlayerProfile(name: "Test", age: 8)
        context.insert(profile)
        let ticketCap = CourseCatalog.tutorial.ticketCount

        let stats = GameRunStats(elapsedSeconds: 30, distanceMeters: 200, ticketsCollected: 99)
        let result = try GameRunRecorder.record(
            .failure(stats),
            courseID: "tutorial",
            for: profile,
            context: context
        )

        #expect(result.ticketsCollected == ticketCap)
        #expect(CourseScoreStore.score(for: "tutorial", on: profile)?.bestTicketCount == ticketCap)
    }

    @Test func ticketCreditDeltaHelper() {
        #expect(GameRunRecorder.ticketCreditDelta(collected: 3, priorBestOnCourse: nil) == 3)
        #expect(GameRunRecorder.ticketCreditDelta(collected: 3, priorBestOnCourse: 3) == 0)
        #expect(GameRunRecorder.ticketCreditDelta(collected: 4, priorBestOnCourse: 3) == 1)
    }

    @Test @MainActor func markCompletedDeduplicatesCompletedList() throws {
        let container = try ModelContainer(
            for: PlayerProfile.self, CourseHighScore.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        let profile = PlayerProfile(name: "Test", age: 8, completedCourseIDs: ["tutorial", "tutorial", "bumps"])
        context.insert(profile)

        try CourseProgressStore.markCompleted(courseID: "bumps", for: profile, context: context, seedScores: false)

        #expect(profile.completedCourseIDs == ["tutorial", "bumps"])
    }
}
