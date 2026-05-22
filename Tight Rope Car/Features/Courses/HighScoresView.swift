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
                score: scoresByCourseID[node.courseID]
            )
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                HotWheelsTheme.backgroundGradient
                    .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(Array(rows.enumerated()), id: \.element.courseID) { index, row in
                            scoreCard(row)
                                .opacity(contentAppeared ? 1 : 0)
                                .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 10))
                                .animation(
                                    reduceMotion ? nil : .easeOut(duration: 0.35).delay(Double(index) * 0.04),
                                    value: contentAppeared
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
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

    private func scoreCard(_ row: HighScoreRow) -> some View {
        let hasScore = CourseScoreStore.hasAnyScore(row.score)

        return VStack(alignment: .leading, spacing: 8) {
            Text(row.displayName)
                .font(HotWheelsTheme.headlineFont)
                .foregroundStyle(.white)

            if hasScore {
                HStack(spacing: 16) {
                    metric(label: "Best time", value: CourseScoreStore.formattedTime(row.score?.bestTimeSeconds))
                    metric(label: "Best distance", value: CourseScoreStore.formattedDistance(row.score?.bestDistance))
                }
            } else {
                Text("No run yet")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.75))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.55))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(
                    hasScore ? HotWheelsTheme.racingYellow.opacity(0.7) : HotWheelsTheme.hotRed.opacity(0.45),
                    lineWidth: 2
                )
        )
    }

    private func metric(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(.white.opacity(0.7))
            Text(value)
                .font(HotWheelsTheme.bodyFont)
                .foregroundStyle(HotWheelsTheme.racingYellow)
        }
    }
}

private struct HighScoreRow {
    let courseID: String
    let displayName: String
    let score: CourseHighScore?
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
        completedCourseIDs: ["tutorial", "bumps"]
    )
    let score = CourseHighScore(courseID: "tutorial", bestTimeSeconds: 42.5, bestDistance: 680, profile: profile)
    profile.highScores = [score]
    container.mainContext.insert(profile)

    return HighScoresView(
        profile: profile,
        scoresByCourseID: CourseScoreStore.scoresByCourseID(for: profile)
    )
    .modelContainer(container)
}
