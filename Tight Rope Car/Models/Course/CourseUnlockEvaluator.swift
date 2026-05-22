//
//  CourseUnlockEvaluator.swift
//  Tight Rope Car
//

import Foundation

enum CourseUnlockEvaluator {
    /// Whether the course appears on the map and has at least one unlock path satisfied.
    static func isUnlocked(courseID: String, completedCourseIDs: Set<String>) -> Bool {
        let incoming = CourseMapCatalog.incomingEdges(to: courseID)
        guard !incoming.isEmpty else {
            return CourseMapConstants.startCourseIDs.contains(courseID)
        }
        return incoming.contains { completedCourseIDs.contains($0.fromCourseID) }
    }

    static func nodeState(courseID: String, completedCourseIDs: Set<String>) -> CourseMapNodeState {
        let completed = completedCourseIDs.contains(courseID)
        if completed {
            return .beaten
        }
        if isUnlocked(courseID: courseID, completedCourseIDs: completedCourseIDs) {
            return .available
        }
        return .locked
    }

    static func nodeStates(completedCourseIDs: Set<String>) -> [String: CourseMapNodeState] {
        var result: [String: CourseMapNodeState] = [:]
        for node in CourseMapCatalog.nodes {
            result[node.courseID] = nodeState(
                courseID: node.courseID,
                completedCourseIDs: completedCourseIDs
            )
        }
        return result
    }
}
