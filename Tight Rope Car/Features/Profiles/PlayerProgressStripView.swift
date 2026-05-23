//
//  PlayerProgressStripView.swift
//  Tight Rope Car
//

import SwiftUI

enum PlayerProgressMetrics {
    static var mapCourseCount: Int {
        CourseMapCatalog.nodes.count
    }

    static func completedMapCourseCount(for profile: PlayerProfile) -> Int {
        let validIDs = Set(CourseMapCatalog.nodes.map(\.courseID))
        return profile.completedCourseIDs.filter { validIDs.contains($0) }.count
    }
}

/// Ticket total and map completion for the active racer.
struct PlayerProgressStripView: View {
    let profile: PlayerProfile
    var style: Style = .banner

    enum Style {
        case banner
        case compact
    }

    private var pillSize: HotWheelsStatPill.Size {
        style == .banner ? .banner : .compact
    }

    private var completedCount: Int {
        PlayerProgressMetrics.completedMapCourseCount(for: profile)
    }

    private var totalCourses: Int {
        PlayerProgressMetrics.mapCourseCount
    }

    var body: some View {
        HStack(spacing: style == .banner ? 12 : 8) {
            HotWheelsStatPill(
                systemImage: "ticket.fill",
                value: "\(profile.totalTickets)",
                title: "Tickets",
                accent: HotWheelsTheme.flameOrange,
                isEmphasized: profile.totalTickets > 0,
                size: pillSize
            )

            HotWheelsStatPill(
                systemImage: "flag.checkered",
                value: "\(completedCount)/\(totalCourses)",
                title: "Courses",
                accent: HotWheelsTheme.electricBlue,
                isEmphasized: completedCount > 0,
                size: pillSize
            )
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilitySummary)
    }

    private var accessibilitySummary: String {
        let courseWord = completedCount == 1 ? "course" : "courses"
        let ticketWord = profile.totalTickets == 1 ? "ticket" : "tickets"
        return "\(profile.displayName): \(profile.totalTickets) \(ticketWord) collected, \(completedCount) of \(totalCourses) \(courseWord) beaten"
    }
}

#Preview("Banner") {
    ZStack {
        HotWheelsTheme.backgroundGradient.ignoresSafeArea()
        PlayerProgressStripView(
            profile: PlayerProfile(
                name: "Alex",
                age: 10,
                completedCourseIDs: ["tutorial", "bumps"],
                totalTickets: 42
            )
        )
        .padding()
    }
}

#Preview("Compact") {
    ZStack {
        HotWheelsTheme.backgroundGradient.ignoresSafeArea()
        PlayerProgressStripView(
            profile: PlayerProfile(name: "New Racer", age: 8),
            style: .compact
        )
        .padding()
    }
}
