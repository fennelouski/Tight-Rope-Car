//
//  CourseBackgroundThemeTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Foundation
import Testing
@testable import Tight_Rope_Car

struct CourseBackgroundThemeTests {

    @Test func catalogCoursesExposeBackgroundTheme() {
        for course in CourseCatalog.all {
            #expect(BackgroundTheme.allCases.contains(course.backgroundTheme))
        }
    }

    @Test func catalogThemeAssignmentIsStable() {
        let tutorial = CourseCatalog.course(id: "tutorial")
        #expect(tutorial != nil)
        let first = tutorial?.backgroundTheme
        let second = CourseCatalog.course(id: "tutorial")?.backgroundTheme
        #expect(first == second)
        #expect(first == .garden)
    }

    @Test func keywordRulesPreferSemanticThemes() {
        #expect(CourseCatalog.course(id: "jungleSwing")?.backgroundTheme == .forest)
        #expect(CourseCatalog.course(id: "sandDunes")?.backgroundTheme == .beach)
        #expect(CourseCatalog.course(id: "neonRush")?.backgroundTheme == .city)
        #expect(CourseCatalog.course(id: "sunkenShip")?.backgroundTheme == .ocean)
    }

    @Test func hashedFallbackMatchesLegacyDistribution() {
        let courseID = "checkerboard"
        let fromCourse = CourseCatalog.course(id: courseID)?.backgroundTheme
        let fromResolver = CourseBackgroundThemeResolver.hashedTheme(forCourseID: courseID)
        #expect(fromCourse == fromResolver)
    }

    @Test func catalogUsesEveryBackgroundTheme() {
        let used = Set(CourseCatalog.all.map(\.backgroundTheme))
        #expect(used == Set(BackgroundTheme.allCases))
    }

    @Test func courseEncodesBackgroundThemeRawValue() throws {
        let course = try #require(CourseCatalog.course(id: "tutorial"))
        let data = try JSONEncoder().encode(course)
        let json = try #require(String(data: data, encoding: .utf8))
        #expect(json.contains("backgroundTheme"))
        #expect(json.contains(BackgroundTheme.garden.rawValue))

        let decoded = try JSONDecoder().decode(Course.self, from: data)
        #expect(decoded.backgroundTheme == course.backgroundTheme)
    }

    @Test func explicitMakeCourseThemeOverridesResolver() {
        let custom = Course(
            id: "test",
            displayName: "Test",
            waypoints: [
                CourseWaypoint(position: CGPoint(x: 0, y: 0)),
                CourseWaypoint(position: CGPoint(x: 100, y: 0)),
            ],
            styleSpans: [],
            backgroundTheme: .candyShop
        )
        #expect(custom.backgroundTheme == .candyShop)
    }
}
