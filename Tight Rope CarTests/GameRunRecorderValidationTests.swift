//
//  GameRunRecorderValidationTests.swift
//  Tight Rope CarTests
//

import Testing
@testable import Tight_Rope_Car

struct GameRunRecorderValidationTests {

    @Test func validatedCourseRequiresMapAndCatalog() {
        #expect(GameRunRecorder.validatedCourse(id: "tutorial") != nil)
        #expect(GameRunRecorder.validatedCourse(id: "phantom") == nil)
        #expect(GameRunRecorder.validatedCourse(id: "tutorial")?.id == "tutorial")
    }

    @Test func sanitizedStatsClampsNegatives() {
        let course = CourseCatalog.tutorial
        let sanitized = GameRunRecorder.sanitizedStats(
            GameRunStats(elapsedSeconds: -5, distanceMeters: -10, ticketsCollected: -1),
            for: course
        )
        #expect(sanitized.elapsedSeconds == 0)
        #expect(sanitized.distanceMeters == 0)
        #expect(sanitized.ticketsCollected == 0)
    }
}
