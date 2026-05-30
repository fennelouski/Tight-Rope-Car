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
    /// Number of tickets collectible on this course. Placed evenly along the rope at 1/(n+1) arc-length intervals.
    let ticketCount: Int
    /// Parallax environment for gameplay (`BackgroundTheme.rawValue` in persistence).
    let backgroundTheme: BackgroundTheme
    /// Lateral wind preset (`WindProfile.rawValue`); `.calm` on most courses.
    let windProfile: WindProfile
    let obstacles: [CourseObstacle]

    init(
        id: String,
        displayName: String,
        waypoints: [CourseWaypoint],
        styleSpans: [CourseStyleSpan],
        ropeWidth: Double = 48,
        forwardSpeed: Double = 120,
        maxPitchRadians: Double = .pi / 4,
        unlockOrder: Int = 0,
        ticketCount: Int = 3,
        backgroundTheme: BackgroundTheme = .ocean,
        windProfile: WindProfile = .calm,
        obstacles: [CourseObstacle] = []
    ) {
        self.id = id
        self.displayName = displayName
        self.waypoints = waypoints
        self.styleSpans = styleSpans
        self.ropeWidth = ropeWidth
        self.forwardSpeed = forwardSpeed
        self.maxPitchRadians = maxPitchRadians
        self.unlockOrder = unlockOrder
        self.ticketCount = ticketCount
        self.backgroundTheme = backgroundTheme
        self.windProfile = windProfile
        self.obstacles = obstacles
    }

    /// Arc-length fractions [0,1] where tickets appear, evenly spaced so they're always on-path.
    var ticketFractions: [Double] {
        guard ticketCount > 0 else { return [] }
        return (1 ... ticketCount).map { Double($0) / Double(ticketCount + 1) }
    }
}
