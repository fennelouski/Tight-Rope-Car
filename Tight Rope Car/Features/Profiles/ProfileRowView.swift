//
//  ProfileRowView.swift
//  Tight Rope Car
//

import SwiftUI

struct ProfileRowView: View {
    let profile: PlayerProfile
    let isSelected: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var completedCount: Int {
        PlayerProgressMetrics.completedMapCourseCount(for: profile)
    }

    private var totalCourses: Int {
        PlayerProgressMetrics.mapCourseCount
    }

    private var hasProgress: Bool {
        profile.totalTickets > 0 || completedCount > 0
    }

    var body: some View {
        HotWheelsSelectableRowCard(
            isSelected: isSelected,
            accentColor: profile.profileColor,
            reduceMotion: reduceMotion
        ) {
            HStack(spacing: 16) {
                ProfileAvatarView(
                    avatarJPEGData: profile.avatarJPEGData,
                    size: 56,
                    borderColor: profile.profileColor,
                    isHighlighted: isSelected
                )

                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.displayName)
                        .font(HotWheelsTheme.headlineFont)
                        .foregroundStyle(.white)
                        .hotWheelsShowsFullText()

                    Text("Age \(profile.age)")
                        .font(HotWheelsTheme.captionFont)
                        .foregroundStyle(.white.opacity(0.85))
                        .hotWheelsShowsFullText()

                    if hasProgress {
                        profileProgressStats
                    } else {
                        Text("New racer — no runs yet")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.55))
                    }
                }

                Spacer(minLength: 8)

                if isSelected {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title3.weight(.black))
                        .foregroundStyle(HotWheelsTheme.racingYellow)
                        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 1, y: 2)
                        .accessibilityHidden(true)
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(rowAccessibilityLabel)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityHint(isSelected ? "Selected racer" : "Double tap to select")
    }

    @ViewBuilder
    private var profileProgressStats: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 14) {
                profileTicketStat
                profileCourseStat
            }

            VStack(alignment: .leading, spacing: 4) {
                profileTicketStat
                profileCourseStat
            }
        }
    }

    @ViewBuilder
    private var profileTicketStat: some View {
        if profile.totalTickets > 0 {
            HotWheelsInlineStat(
                systemImage: "ticket.fill",
                text: "\(profile.totalTickets)",
                accent: HotWheelsTheme.flameOrange
            )
        }
    }

    @ViewBuilder
    private var profileCourseStat: some View {
        if completedCount > 0 {
            HotWheelsInlineStat(
                systemImage: "flag.checkered",
                text: "\(completedCount)/\(totalCourses)",
                accent: HotWheelsTheme.electricBlue
            )
        }
    }

    private var rowAccessibilityLabel: String {
        var parts = ["\(profile.displayName)", "age \(profile.age)"]
        if profile.totalTickets > 0 {
            parts.append("\(profile.totalTickets) tickets")
        }
        if completedCount > 0 {
            parts.append("\(completedCount) of \(totalCourses) courses beaten")
        } else if !hasProgress {
            parts.append("no runs yet")
        }
        return parts.joined(separator: ", ")
    }
}

#Preview("Selected") {
    ZStack {
        HotWheelsTheme.backgroundGradient
        ProfileRowView(
            profile: PlayerProfile(
                name: "Speed Racer",
                age: 9,
                completedCourseIDs: ["tutorial", "bumps", "narrowWire"],
                totalTickets: 27,
                profileColorIndex: 4
            ),
            isSelected: true
        )
        .padding()
    }
}

#Preview("Unselected") {
    ZStack {
        HotWheelsTheme.backgroundGradient
        ProfileRowView(
            profile: PlayerProfile(name: "Jordan", age: 12, profileColorIndex: 13),
            isSelected: false
        )
        .padding()
    }
}

#Preview("New racer") {
    ZStack {
        HotWheelsTheme.backgroundGradient
        ProfileRowView(
            profile: PlayerProfile(name: "Sam", age: 8, profileColorIndex: 6),
            isSelected: false
        )
        .padding()
    }
}
