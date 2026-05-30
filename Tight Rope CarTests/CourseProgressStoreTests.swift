//
//  CourseProgressStoreTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Testing
@testable import Tight_Rope_Car

struct CourseProgressStoreTests {

    @Test func furthestCompletedMapCourseIDReturnsNilForNilProfile() {
        #expect(CourseProgressStore.furthestCompletedMapCourseID(for: nil) == nil)
    }

    @Test func furthestCompletedMapCourseIDReturnsNilWhenNothingBeaten() {
        let profile = PlayerProfile(name: "Fresh", age: 8)
        #expect(CourseProgressStore.furthestCompletedMapCourseID(for: profile) == nil)
    }

    @Test func furthestCompletedMapCourseIDUsesCatalogOrderNotCompletionOrder() {
        let profile = PlayerProfile(
            name: "Branch",
            age: 10,
            completedCourseIDs: ["narrowWire", "tutorial", "bumps"]
        )
        #expect(CourseProgressStore.furthestCompletedMapCourseID(for: profile) == "narrowWire")
    }

    @Test func furthestCompletedMapCourseIDIgnoresUnknownIDs() {
        let profile = PlayerProfile(
            name: "Mixed",
            age: 9,
            completedCourseIDs: ["not_on_map", "tutorial", "legacy_course"]
        )
        #expect(CourseProgressStore.furthestCompletedMapCourseID(for: profile) == "tutorial")
    }

    @Test func scrollOffsetToCenterClampsWithinCanvas() {
        let canvasSize = CourseMapLayout.canvasSize(containerWidth: 390)
        let viewportSize = CGSize(width: 390, height: 700)

        let offset = CourseMapLayout.scrollOffsetToCenter(
            courseID: "tutorial",
            canvasSize: canvasSize,
            viewportSize: viewportSize,
            contentPadding: 12
        )

        #expect(offset != nil)
        #expect(offset!.x >= 0)
        #expect(offset!.y >= 0)
        #expect(offset!.x <= max(0, canvasSize.width - viewportSize.width))
        #expect(offset!.y <= max(0, canvasSize.height + 24 - viewportSize.height))
    }
}
