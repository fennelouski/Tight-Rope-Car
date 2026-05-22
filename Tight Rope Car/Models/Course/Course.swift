//
//  Course.swift
//  Tight Rope Car
//

import Foundation

struct Course: Identifiable, Codable, Sendable, Equatable {
    let id: String
    let displayName: String
    let waypoints: [CourseWaypoint]
    let styleSpans: [CourseStyleSpan]
    let ropeWidth: Double
    let forwardSpeed: Double
    let maxPitchRadians: Double
    let unlockOrder: Int

    init(
        id: String,
        displayName: String,
        waypoints: [CourseWaypoint],
        styleSpans: [CourseStyleSpan],
        ropeWidth: Double = 48,
        forwardSpeed: Double = 120,
        maxPitchRadians: Double = .pi / 4,
        unlockOrder: Int = 0
    ) {
        self.id = id
        self.displayName = displayName
        self.waypoints = waypoints
        self.styleSpans = styleSpans
        self.ropeWidth = ropeWidth
        self.forwardSpeed = forwardSpeed
        self.maxPitchRadians = maxPitchRadians
        self.unlockOrder = unlockOrder
    }
}
