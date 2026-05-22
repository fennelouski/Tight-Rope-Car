//
//  CourseMapUnlockTests.swift
//  Tight Rope CarTests
//

import Testing
@testable import Tight_Rope_Car

struct CourseMapUnlockTests {

    @Test func freshProfileOnlyTutorialAvailable() {
        let states = CourseUnlockEvaluator.nodeStates(completedCourseIDs: [])
        #expect(states["tutorial"] == .available)
        #expect(states["bumps"] == .locked)
        #expect(states["ropeBridge"] == .locked)
    }

    @Test func completingTutorialUnlocksBranches() {
        let completed: Set<String> = ["tutorial"]
        let states = CourseUnlockEvaluator.nodeStates(completedCourseIDs: completed)
        #expect(states["tutorial"] == .beaten)
        #expect(states["bumps"] == .available)
        #expect(states["narrowWire"] == .available)
        #expect(states["switchbacks"] == .locked)
    }

    @Test func mergeLongHaulUsesOrSemantics() {
        let onlyLeft: Set<String> = ["tutorial", "bumps", "switchbacks"]
        #expect(CourseUnlockEvaluator.isUnlocked(courseID: "longHaul", completedCourseIDs: onlyLeft))

        let onlyRight: Set<String> = ["tutorial", "narrowWire", "zigZag"]
        #expect(CourseUnlockEvaluator.isUnlocked(courseID: "longHaul", completedCourseIDs: onlyRight))

        let neither: Set<String> = ["tutorial", "bumps"]
        #expect(!CourseUnlockEvaluator.isUnlocked(courseID: "longHaul", completedCourseIDs: neither))
    }

    @Test func mergeRopeBridgeUsesOrSemantics() {
        let leftPath: Set<String> = [
            "tutorial", "bumps", "switchbacks", "longHaul", "bigDrop",
        ]
        #expect(CourseUnlockEvaluator.isUnlocked(courseID: "ropeBridge", completedCourseIDs: leftPath))

        let rightPath: Set<String> = [
            "tutorial", "narrowWire", "zigZag", "longHaul", "sunsetCruise",
        ]
        #expect(CourseUnlockEvaluator.isUnlocked(courseID: "ropeBridge", completedCourseIDs: rightPath))
    }

    @Test func beatenCoursesStaySelectableState() {
        let completed: Set<String> = ["tutorial", "bumps"]
        #expect(CourseUnlockEvaluator.nodeState(courseID: "bumps", completedCourseIDs: completed) == .beaten)
        #expect(CourseUnlockEvaluator.nodeState(courseID: "switchbacks", completedCourseIDs: completed) == .available)
    }

    @Test func mapNodesReferenceCatalogCourses() {
        for node in CourseMapCatalog.nodes {
            #expect(CourseCatalog.course(id: node.courseID) != nil)
        }
    }
}
