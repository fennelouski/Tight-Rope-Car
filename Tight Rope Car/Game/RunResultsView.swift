//
//  RunResultsView.swift
//  Tight Rope Car
//

import SwiftUI

struct RunResultsView: View {
    let outcome: GameRunOutcome
    let recordResult: GameRunRecordResult
    let courseDisplayName: String
    var profileColor: Color = HotWheelsTheme.racingYellow
    var onMap: () -> Void
    var onPlayAgain: () -> Void
    var onRetry: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var contentAppeared = false
    @State private var celebratePulse = false

    private var stats: GameRunStats { outcome.stats }

    private var accentColor: Color {
        outcome.isSuccess ? HotWheelsTheme.racingYellow : HotWheelsTheme.hotRed
    }

    private var badgeItems: [(text: String, style: HotWheelsAchievementBanner.Style)] {
        var items: [(String, HotWheelsAchievementBanner.Style)] = []
        if outcome.isSuccess {
            if recordResult.unlockedCourseNow {
                items.append(("New course unlocked on the map!", .unlock))
            }
            if recordResult.isNewBestTime {
                items.append(("New best time!", .record))
            }
            if recordResult.isNewBestDistance {
                items.append(("New best distance!", .record))
            }
            if recordResult.isNewBestTicketCount {
                items.append(("New ticket record!", .record))
            }
        } else {
            if recordResult.isNewBestDistance {
                items.append(("New best distance!", .record))
            }
            if recordResult.isNewBestTicketCount {
                items.append(("New ticket record!", .record))
            }
        }
        return items
    }

    var body: some View {
        ZStack {
            RunFlowOverlayBackdrop(accentColor: accentColor)

            RunFlowOverlayCard(borderColor: accentColor) {
                VStack(spacing: 18) {
                    header
                    statsSection
                    if !badgeItems.isEmpty {
                        badgesSection
                    }
                    actionButtons
                }
            }
            .padding(.horizontal, 24)
            .hotWheelsContentWidth()
            .opacity(contentAppeared ? 1 : 0)
            .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.94))
        }
        .onAppear(perform: runEntranceAnimation)
    }

    private var header: some View {
        VStack(spacing: 10) {
            Image(systemName: outcome.isSuccess ? "flag.checkered.2.crossed" : "exclamationmark.triangle.fill")
                .font(.system(size: 44, weight: .bold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    outcome.isSuccess ? HotWheelsTheme.racingYellow : HotWheelsTheme.flameOrange,
                    outcome.isSuccess ? HotWheelsTheme.hotRed : HotWheelsTheme.trackBlack.opacity(0.4)
                )
                .scaleEffect(outcome.isSuccess && celebratePulse && !reduceMotion ? 1.08 : 1)
                .accessibilityHidden(true)

            Text(outcome.isSuccess ? "Course Clear!" : "Fell Off!")
                .font(HotWheelsTheme.sectionTitleFont)
                .foregroundStyle(accentColor)
                .hotWheelsTitleShadow()

            Text(courseDisplayName)
                .font(HotWheelsTheme.headlineFont)
                .foregroundStyle(.white.opacity(0.95))

            Text(outcome.isSuccess ? "You made it across!" : "Try again — you've got this!")
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(.white.opacity(0.75))
                .multilineTextAlignment(.center)
        }
        .multilineTextAlignment(.center)
    }

    private var statsSection: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                HotWheelsMetricTile(
                    systemImage: "clock.fill",
                    label: "Time",
                    value: CourseScoreStore.formattedTime(stats.elapsedSeconds),
                    accent: HotWheelsTheme.electricBlue
                )
                HotWheelsMetricTile(
                    systemImage: "point.topleft.down.to.point.bottomright.curvepath.fill",
                    label: "Distance",
                    value: CourseScoreStore.formattedDistance(stats.distanceMeters),
                    accent: HotWheelsTheme.flameOrange
                )
            }

            ticketMetricTile
        }
    }

    private var ticketMetricTile: some View {
        HotWheelsMetricTile(
            systemImage: "ticket.fill",
            label: "Tickets",
            value: "+\(recordResult.ticketsCollected)",
            accent: profileColor,
            detail: "Total: \(recordResult.newTotalTickets)",
            isFeatured: recordResult.ticketsCollected > 0
        )
    }

    private var badgesSection: some View {
        VStack(spacing: 8) {
            ForEach(Array(badgeItems.enumerated()), id: \.offset) { index, item in
                HotWheelsAchievementBanner(text: item.text, style: item.style)
                    .opacity(contentAppeared ? 1 : 0)
                    .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 8))
                    .animation(
                        reduceMotion ? nil : .easeOut(duration: 0.35).delay(0.12 + Double(index) * 0.06),
                        value: contentAppeared
                    )
            }
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            if outcome.isSuccess {
                resultsButton("Course Map", fillColor: HotWheelsTheme.racingYellow, action: onMap)
                resultsButton("Play Again", fillColor: .white.opacity(0.92), action: onPlayAgain)
            } else {
                resultsButton("Retry", fillColor: HotWheelsTheme.racingYellow, action: onRetry)
                resultsButton("Course Map", fillColor: .white.opacity(0.92), action: onMap)
            }
        }
        .padding(.top, 4)
    }

    private func resultsButton(
        _ title: String,
        fillColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(HotWheelsAccentButtonStyle(fillColor: fillColor))
        .frame(maxWidth: .infinity)
    }

    private func runEntranceAnimation() {
        if reduceMotion {
            contentAppeared = true
            return
        }
        withAnimation(.easeOut(duration: 0.35)) {
            contentAppeared = true
        }
        guard outcome.isSuccess else { return }
        withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
            celebratePulse = true
        }
    }
}

#Preview("Success") {
    RunResultsView(
        outcome: .success(
            GameRunStats(elapsedSeconds: 42.5, distanceMeters: 520, ticketsCollected: 3)
        ),
        recordResult: GameRunRecordResult(
            unlockedCourseNow: true,
            isNewBestTime: true,
            isNewBestDistance: false,
            ticketsCollected: 3,
            isNewBestTicketCount: true,
            newTotalTickets: 12,
            ticketsCreditedToProfile: 3
        ),
        courseDisplayName: "First Steps",
        onMap: {},
        onPlayAgain: {},
        onRetry: {}
    )
}

#Preview("Failure") {
    RunResultsView(
        outcome: .failure(
            GameRunStats(elapsedSeconds: 18.2, distanceMeters: 210, ticketsCollected: 1)
        ),
        recordResult: GameRunRecordResult(
            unlockedCourseNow: false,
            isNewBestTime: false,
            isNewBestDistance: true,
            ticketsCollected: 1,
            isNewBestTicketCount: false,
            newTotalTickets: 8,
            ticketsCreditedToProfile: 1
        ),
        courseDisplayName: "Roller Rope",
        onMap: {},
        onPlayAgain: {},
        onRetry: {}
    )
}
