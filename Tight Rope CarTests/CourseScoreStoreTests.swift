//
//  CourseScoreStoreTests.swift
//  Tight Rope CarTests
//

import Testing
@testable import Tight_Rope_Car

struct CourseScoreStoreTests {

    @Test func betterTimeIsStrictlyLower() {
        #expect(CourseScoreStore.isBetterTime(30, than: 45))
        #expect(!CourseScoreStore.isBetterTime(45, than: 30))
        #expect(CourseScoreStore.isBetterTime(30, than: nil))
        #expect(!CourseScoreStore.isBetterTime(30, than: 30))
    }

    @Test func betterDistanceIsStrictlyHigher() {
        #expect(CourseScoreStore.isBetterDistance(500, than: 400))
        #expect(!CourseScoreStore.isBetterDistance(400, than: 500))
        #expect(CourseScoreStore.isBetterDistance(100, than: nil))
        #expect(!CourseScoreStore.isBetterDistance(100, than: 100))
    }

    @Test func formattedTimeShowsDashWhenEmpty() {
        #expect(CourseScoreStore.formattedTime(nil) == "—")
        #expect(CourseScoreStore.formattedTime(42) == "0:42")
        #expect(CourseScoreStore.formattedTime(125) == "2:05")
    }

    @Test func formattedDistanceShowsDashWhenEmpty() {
        #expect(CourseScoreStore.formattedDistance(nil) == "—")
        #expect(CourseScoreStore.formattedDistance(512.4) == "512 m")
    }

    @Test func hasAnyScoreRequiresRecordedValue() {
        let empty = CourseHighScore(courseID: "tutorial")
        #expect(!CourseScoreStore.hasAnyScore(empty))
        #expect(!CourseScoreStore.hasAnyScore(nil))

        let timed = CourseHighScore(courseID: "tutorial", bestTimeSeconds: 40)
        #expect(CourseScoreStore.hasAnyScore(timed))
    }
}
