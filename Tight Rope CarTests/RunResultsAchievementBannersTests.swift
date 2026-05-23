//
//  RunResultsAchievementBannersTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct RunResultsAchievementBannersTests {

    private func recordResult(
        unlocked: Bool = false,
        bestTime: Bool = false,
        bestDistance: Bool = false,
        bestTickets: Bool = false
    ) -> GameRunRecordResult {
        GameRunRecordResult(
            unlockedCourseNow: unlocked,
            isNewBestTime: bestTime,
            isNewBestDistance: bestDistance,
            ticketsCollected: 3,
            isNewBestTicketCount: bestTickets,
            newTotalTickets: 12,
            ticketsCreditedToProfile: 3
        )
    }

    @Test func firstClearWithMultipleRecordsConsolidatesToTwoBanners() {
        let items = RunResultsAchievementBanners.items(
            outcome: .success(
                GameRunStats(elapsedSeconds: 40, distanceMeters: 500, ticketsCollected: 3)
            ),
            recordResult: recordResult(
                unlocked: true,
                bestTime: true,
                bestDistance: true,
                bestTickets: true
            )
        )

        #expect(items.count == 2)
        #expect(items[0].text == "New course unlocked on the map!")
        #expect(items[1].text == "New personal bests!")
        #expect(items[1].accessibilityLabel == "New personal bests: time, distance, and tickets")
    }

    @Test func singleBestTimeShowsSpecificBanner() {
        let items = RunResultsAchievementBanners.items(
            outcome: .success(
                GameRunStats(elapsedSeconds: 40, distanceMeters: 500, ticketsCollected: 3)
            ),
            recordResult: recordResult(bestTime: true)
        )

        #expect(items.count == 1)
        #expect(items[0].text == "New best time!")
        #expect(items[0].accessibilityLabel == nil)
    }

    @Test func failureWithTwoRecordsConsolidates() {
        let items = RunResultsAchievementBanners.items(
            outcome: .failure(
                GameRunStats(elapsedSeconds: 18, distanceMeters: 200, ticketsCollected: 2)
            ),
            recordResult: recordResult(bestDistance: true, bestTickets: true)
        )

        #expect(items.count == 1)
        #expect(items[0].text == "New personal bests!")
        #expect(items[0].accessibilityLabel == "New personal bests: distance and tickets")
    }

    @Test func failureIgnoresBestTimeFlag() {
        let items = RunResultsAchievementBanners.items(
            outcome: .failure(
                GameRunStats(elapsedSeconds: 18, distanceMeters: 200, ticketsCollected: 1)
            ),
            recordResult: recordResult(bestTime: true, bestDistance: true)
        )

        #expect(items.count == 1)
        #expect(items[0].text == "New best distance!")
    }
}
