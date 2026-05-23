//
//  ProgressShareBuilderTests.swift
//  Tight Rope CarTests
//

import Testing
@testable import Tight_Rope_Car

struct ProgressShareBuilderTests {

    @Test func shareTextIncludesProfileAndBranding() {
        let profile = PlayerProfile(name: "Alex", age: 8, completedCourseIDs: ["tutorial"])
        let text = ProgressShareBuilder.shareText(profile: profile, scoresByCourseID: [:])

        #expect(text.contains("Tight Rope Car"))
        #expect(text.contains("Alex"))
        #expect(text.contains("First Steps"))
        #expect(text.contains("Courses beaten: 1"))
    }

    @Test func shareTextIncludesHighScoresWhenPresent() {
        let profile = PlayerProfile(name: "Riley", age: 10)
        let score = CourseHighScore(
            courseID: "tutorial",
            bestTimeSeconds: 33,
            bestDistance: 600
        )
        let text = ProgressShareBuilder.shareText(
            profile: profile,
            scoresByCourseID: ["tutorial": score]
        )

        #expect(text.contains("High scores:"))
        #expect(text.contains("First Steps"))
        #expect(text.contains("0:33"))
        #expect(text.contains("600 m"))
    }

    @Test func shareTextOmitsHighScoreSectionWhenEmpty() {
        let profile = PlayerProfile(name: "Sam", age: 7)
        let text = ProgressShareBuilder.shareText(profile: profile, scoresByCourseID: [:])

        #expect(!text.contains("High scores:"))
        #expect(text.contains("Courses beaten: 0"))
    }

    @Test func shareTextIncludesMapSummaryAndCourseIDs() {
        let profile = PlayerProfile(
            name: "Alex",
            age: 8,
            completedCourseIDs: ["tutorial"],
            totalTickets: 5
        )
        let text = ProgressShareBuilder.shareText(profile: profile, scoresByCourseID: [:])

        #expect(text.contains("Map:"))
        #expect(text.contains("5 tickets"))
        #expect(text.contains("Beat course IDs (map order):"))
        #expect(text.contains("tutorial"))
    }

    @Test func completedCourseIDsInMapOrderIgnoresUnknownIDs() {
        let profile = PlayerProfile(
            name: "Test",
            age: 6,
            completedCourseIDs: ["not_on_map", "tutorial"]
        )
        let ordered = ProgressShareBuilder.completedCourseIDsInMapOrder(profile: profile)

        #expect(ordered == ["tutorial"])
    }
}
