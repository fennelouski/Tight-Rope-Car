//
//  CourseMapEdgeVisualStyle.swift
//  Tight Rope Car
//

import Foundation

/// Visual tier for a map connection; drawn back-to-front (locked → completed → frontier → selection).
enum CourseMapEdgeVisualStyle: Equatable, Sendable {
    case locked
    case completed
    case frontier
    case selection
}

enum CourseMapEdgeStyling {
    static func visualStyle(
        for edge: CourseMapEdge,
        nodeStates: [String: CourseMapNodeState],
        selectedCourseID: String?
    ) -> CourseMapEdgeVisualStyle {
        if let selectedCourseID,
           edge.fromCourseID == selectedCourseID || edge.toCourseID == selectedCourseID {
            return .selection
        }

        let from = nodeStates[edge.fromCourseID] ?? .locked
        let to = nodeStates[edge.toCourseID] ?? .locked

        if from == .beaten, to == .beaten {
            return .completed
        }
        if from == .beaten, to == .available {
            return .frontier
        }
        return .locked
    }

    /// Draw order so brighter segments paint above dim locked ropes.
    static let drawOrder: [CourseMapEdgeVisualStyle] = [
        .locked, .completed, .frontier, .selection,
    ]
}
