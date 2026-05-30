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
            TicketStatPill(
                value: "\(profile.totalTickets)",
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

// MARK: - Animated ticket stat pill

private struct TicketStatPill: View {
    let value: String
    let isEmphasized: Bool
    var size: HotWheelsStatPill.Size = .banner

    var body: some View {
        HStack(spacing: size == .banner ? 10 : 6) {
            TicketPickupView(
                displaySize: .compact,
                animatesAtAllSizes: true
            )
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 1) {
                Text(value)
                    .font(size == .banner ? HotWheelsTheme.headlineFont : HotWheelsTheme.captionFont.weight(.bold))
                    .foregroundStyle(.white)
                    .hotWheelsShowsFullText()

                if size == .banner {
                    Text("TICKETS")
                        .font(.system(size: 10, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                        .tracking(0.6)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, size == .banner ? 14 : 10)
        .padding(.vertical, size == .banner ? 12 : 8)
        .background(
            RoundedRectangle(cornerRadius: size == .banner ? 14 : 10, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(isEmphasized ? 0.65 : 0.45))
        )
        .overlay(
            RoundedRectangle(cornerRadius: size == .banner ? 14 : 10, style: .continuous)
                .strokeBorder(
                    isEmphasized ? HotWheelsTheme.flameOrange : HotWheelsTheme.hotRed.opacity(0.45),
                    lineWidth: isEmphasized ? 2.5 : 1.5
                )
        )
        .shadow(
            color: isEmphasized ? HotWheelsTheme.flameOrange.opacity(0.35) : .clear,
            radius: isEmphasized ? 6 : 0
        )
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Tickets: \(value)")
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
