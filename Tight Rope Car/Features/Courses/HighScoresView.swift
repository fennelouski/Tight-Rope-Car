//
//  HighScoresView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

struct HighScoresView: View {
    let profile: PlayerProfile
    let scoresByCourseID: [String: CourseHighScore]

    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var contentAppeared = false

    private var rows: [HighScoreRow] {
        CourseMapCatalog.nodes.compactMap { node in
            guard let course = CourseCatalog.course(id: node.courseID) else { return nil }
            return HighScoreRow(
                courseID: node.courseID,
                displayName: course.displayName,
                maxTickets: course.ticketCount,
                score: scoresByCourseID[node.courseID],
                isBeaten: profile.completedCourseIDs.contains(node.courseID)
            )
        }
    }

    private var scoredCount: Int {
        rows.filter { CourseScoreStore.hasAnyScore($0.score) || hasTicketScore($0.score) }.count
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    summaryHeader
                        .opacity(contentAppeared ? 1 : 0)
                        .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 8))

                    LazyVStack(spacing: 12) {
                        HotWheelsFormSectionHeader("All Tracks")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 4)

                        ForEach(Array(rows.enumerated()), id: \.element.courseID) { index, row in
                            scoreCard(row)
                                .opacity(contentAppeared ? 1 : 0)
                                .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 10))
                                .animation(
                                    reduceMotion ? nil : .easeOut(duration: 0.35).delay(Double(index) * 0.03),
                                    value: contentAppeared
                                )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .navigationTitle("High Scores")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(HotWheelsTheme.trackBlack.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .font(HotWheelsTheme.bodyFont.weight(.bold))
                        .foregroundStyle(HotWheelsTheme.racingYellow)
                        .accessibilityLabel("Done")
                        .accessibilityHint("Close high scores")
                }
            }
        }
        .hotWheelsSheetBackground()
        .hotWheelsSafeAreaPolicy()
        .onAppear {
            if reduceMotion {
                contentAppeared = true
            } else {
                withAnimation(.easeOut(duration: 0.4)) {
                    contentAppeared = true
                }
            }
        }
    }

    // MARK: - Summary

    private var summaryHeader: some View {
        VStack(alignment: .leading, spacing: 14) {
            HotWheelsScreenHeader(
                eyebrow: "Hall of Fame",
                eyebrowSystemImage: "trophy.fill",
                title: "High Scores",
                subtitle: "\(profile.displayName) · \(scoredCount) of \(rows.count) personal bests"
            ) {
                HotWheelsRacerChip(profile: profile)
            }

            PlayerProgressStripView(profile: profile)

            HotWheelsFormPanel {
                HStack(spacing: 12) {
                    HotWheelsStatPill(
                        systemImage: "medal.fill",
                        value: "\(scoredCount)",
                        title: "PB Tracks",
                        accent: HotWheelsTheme.racingYellow,
                        isEmphasized: scoredCount > 0,
                        size: .compact
                    )
                    HotWheelsStatPill(
                        systemImage: "flag.checkered",
                        value: "\(beatenCount)",
                        title: "Cleared",
                        accent: HotWheelsTheme.electricBlue,
                        isEmphasized: beatenCount > 0,
                        size: .compact
                    )
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(profile.displayName), \(scoredCount) of \(rows.count) tracks with personal bests, \(beatenCount) tracks cleared")
    }

    private var beatenCount: Int {
        rows.filter(\.isBeaten).count
    }

    // MARK: - Cards

    private func scoreCard(_ row: HighScoreRow) -> some View {
        let hasScore = CourseScoreStore.hasAnyScore(row.score) || hasTicketScore(row.score)
        let hasTime = row.score?.bestTimeSeconds != nil

        return VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 10) {
                courseBadge(hasScore: hasScore, hasTime: hasTime, isBeaten: row.isBeaten)

                VStack(alignment: .leading, spacing: 4) {
                    Text(row.displayName)
                        .font(HotWheelsTheme.headlineFont)
                        .foregroundStyle(.white)
                        .fixedSize(horizontal: false, vertical: true)

                    if row.isBeaten {
                        Label("Track cleared", systemImage: "flag.checkered")
                            .font(HotWheelsTheme.captionFont.weight(.bold))
                            .foregroundStyle(HotWheelsTheme.racingYellow.opacity(0.95))
                            .labelStyle(.titleAndIcon)
                    }
                }

                Spacer(minLength: 0)
            }

            if hasScore {
                HStack(alignment: .top, spacing: 10) {
                    HotWheelsMetricTile(
                        systemImage: hasTime ? "star.fill" : "stopwatch",
                        label: "Best time",
                        value: CourseScoreStore.formattedTime(row.score?.bestTimeSeconds),
                        accent: hasTime ? HotWheelsTheme.racingYellow : HotWheelsTheme.electricBlue,
                        isFeatured: hasTime
                    )

                    HotWheelsMetricTile(
                        systemImage: "ruler",
                        label: "Distance",
                        value: CourseScoreStore.formattedDistance(row.score?.bestDistance),
                        accent: HotWheelsTheme.electricBlue
                    )

                    HotWheelsMetricTile(
                        systemImage: "ticket.fill",
                        label: "Tickets",
                        value: formattedTickets(row),
                        accent: HotWheelsTheme.flameOrange,
                        isFeatured: row.score?.bestTicketCount != nil
                    )
                }
            } else {
                HotWheelsEmptyMetricPlaceholder(
                    title: row.isBeaten ? "No times saved yet" : "No score yet",
                    message: row.isBeaten
                        ? "You cleared this track — play again to set a personal best."
                        : "Finish a run to post your best time, distance, and tickets.",
                    systemImage: row.isBeaten ? "clock.badge.questionmark" : "play.circle"
                )
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground(hasScore: hasScore))
        .overlay(cardBorder(hasScore: hasScore))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(cardAccessibilityLabel(row, hasScore: hasScore))
    }

    @ViewBuilder
    private func courseBadge(hasScore: Bool, hasTime: Bool, isBeaten: Bool) -> some View {
        ZStack {
            Circle()
                .fill(HotWheelsTheme.trackBlack.opacity(0.65))
                .frame(width: 44, height: 44)

            if hasTime {
                Image(systemName: "medal.fill")
                    .font(.title2.weight(.black))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [HotWheelsTheme.racingYellow, HotWheelsTheme.flameOrange],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 0, y: 2)
            } else if isBeaten {
                Image(systemName: "flag.checkered")
                    .font(.body.weight(.black))
                    .foregroundStyle(HotWheelsTheme.racingYellow)
            } else if hasScore {
                Image(systemName: "trophy.fill")
                    .font(.body.weight(.black))
                    .foregroundStyle(HotWheelsTheme.electricBlue)
            } else {
                Image(systemName: "road.lanes")
                    .font(.body.weight(.bold))
                    .foregroundStyle(.white.opacity(0.45))
            }
        }
        .overlay(
            Circle()
                .strokeBorder(
                    hasScore ? HotWheelsTheme.racingYellow : HotWheelsTheme.hotRed.opacity(0.4),
                    lineWidth: 2
                )
        )
        .accessibilityHidden(true)
    }

    private func cardBackground(hasScore: Bool) -> some View {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        HotWheelsTheme.trackBlack.opacity(hasScore ? 0.62 : 0.42),
                        HotWheelsTheme.trackBlack.opacity(hasScore ? 0.48 : 0.32),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }

    private func cardBorder(hasScore: Bool) -> some View {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
            .strokeBorder(
                hasScore ? HotWheelsTheme.racingYellow.opacity(0.75) : HotWheelsTheme.hotRed.opacity(0.35),
                lineWidth: hasScore ? 2.5 : 1.5
            )
    }

    // MARK: - Helpers

    private func hasTicketScore(_ score: CourseHighScore?) -> Bool {
        guard let score else { return false }
        return score.bestTicketCount != nil
    }

    private func formattedTickets(_ row: HighScoreRow) -> String {
        guard let count = row.score?.bestTicketCount else { return "—" }
        if row.maxTickets > 0 {
            return "\(count)/\(row.maxTickets)"
        }
        return "\(count)"
    }

    private func cardAccessibilityLabel(_ row: HighScoreRow, hasScore: Bool) -> String {
        var parts = [row.displayName]
        if row.isBeaten { parts.append("track cleared") }
        if hasScore {
            parts.append("best time \(CourseScoreStore.formattedTime(row.score?.bestTimeSeconds))")
            parts.append("distance \(CourseScoreStore.formattedDistance(row.score?.bestDistance))")
            parts.append("tickets \(formattedTickets(row))")
        } else {
            parts.append("no personal best yet")
        }
        return parts.joined(separator: ", ")
    }
}

private struct HighScoreRow {
    let courseID: String
    let displayName: String
    let maxTickets: Int
    let score: CourseHighScore?
    let isBeaten: Bool
}

#Preview("Empty scores") {
    let container = try! ModelContainer(
        for: PlayerProfile.self, CourseHighScore.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(name: "Alex", age: 9)
    container.mainContext.insert(profile)

    return HighScoresView(profile: profile, scoresByCourseID: [:])
        .modelContainer(container)
}

#Preview("With scores") {
    let container = try! ModelContainer(
        for: PlayerProfile.self, CourseHighScore.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(
        name: "Riley",
        age: 10,
        completedCourseIDs: ["tutorial", "bumps", "narrowWire"],
        totalTickets: 24
    )
    let tutorial = CourseHighScore(
        courseID: "tutorial",
        bestTimeSeconds: 42.5,
        bestDistance: 680,
        bestTicketCount: 3,
        profile: profile
    )
    let bumps = CourseHighScore(
        courseID: "bumps",
        bestDistance: 512,
        bestTicketCount: 2,
        profile: profile
    )
    profile.highScores = [tutorial, bumps]
    container.mainContext.insert(profile)

    return HighScoresView(
        profile: profile,
        scoresByCourseID: CourseScoreStore.scoresByCourseID(for: profile)
    )
    .modelContainer(container)
}

#Preview("Mixed — cleared without PB") {
    let container = try! ModelContainer(
        for: PlayerProfile.self, CourseHighScore.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(
        name: "Sam",
        age: 11,
        completedCourseIDs: ["tutorial"],
        totalTickets: 5
    )
    container.mainContext.insert(profile)

    return HighScoresView(profile: profile, scoresByCourseID: [:])
        .modelContainer(container)
}
