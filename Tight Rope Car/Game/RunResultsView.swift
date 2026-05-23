//
//  RunResultsView.swift
//  Tight Rope Car
//

import SwiftUI

struct RunResultsView: View {
    let outcome: GameRunOutcome
    let recordResult: GameRunRecordResult
    let courseDisplayName: String
    var onMap: () -> Void
    var onPlayAgain: () -> Void
    var onRetry: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var contentAppeared = false

    private var stats: GameRunStats { outcome.stats }

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                header
                statsSection
                badgesSection
                actionButtons
            }
            .padding(28)
            .background(cardBackground)
            .padding(.horizontal, 24)
            .opacity(contentAppeared ? 1 : 0)
            .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.94))
        }
        .onAppear(perform: runEntranceAnimation)
    }

    private var header: some View {
        VStack(spacing: 6) {
            Text(outcome.isSuccess ? "Course Clear!" : "Fell Off!")
                .font(HotWheelsTheme.sectionTitleFont)
                .foregroundStyle(outcome.isSuccess ? HotWheelsTheme.racingYellow : HotWheelsTheme.hotRed)
                .hotWheelsTitleShadow()

            Text(courseDisplayName)
                .font(HotWheelsTheme.headlineFont)
                .foregroundStyle(.white.opacity(0.95))
        }
        .multilineTextAlignment(.center)
    }

    private var statsSection: some View {
        VStack(spacing: 10) {
            statRow(
                label: "Time",
                value: CourseScoreStore.formattedTime(stats.elapsedSeconds)
            )
            statRow(
                label: "Distance",
                value: CourseScoreStore.formattedDistance(stats.distanceMeters)
            )
            ticketStatRow
        }
    }

    private var ticketStatRow: some View {
        HStack {
            HStack(spacing: 4) {
                Image(systemName: "ticket.fill")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                Text("Tickets")
                    .font(HotWheelsTheme.bodyFont)
                    .foregroundStyle(.white.opacity(0.85))
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("+\(recordResult.ticketsCollected)")
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                Text("Total: \(recordResult.newTotalTickets)")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.65))
            }
        }
    }

    @ViewBuilder
    private var badgesSection: some View {
        if outcome.isSuccess {
            VStack(spacing: 6) {
                if recordResult.unlockedCourseNow {
                    badge("New course unlocked on the map!")
                }
                if recordResult.isNewBestTime {
                    badge("New best time!")
                }
                if recordResult.isNewBestDistance {
                    badge("New best distance!")
                }
                if recordResult.isNewBestTicketCount {
                    badge("New ticket record!")
                }
            }
        } else {
            VStack(spacing: 6) {
                if recordResult.isNewBestDistance {
                    badge("New best distance!")
                }
                if recordResult.isNewBestTicketCount {
                    badge("New ticket record!")
                }
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
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(HotWheelsTheme.trackBlack.opacity(0.94))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        outcome.isSuccess ? HotWheelsTheme.racingYellow : HotWheelsTheme.hotRed,
                        lineWidth: 3
                    )
            )
    }

    private func statRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(HotWheelsTheme.bodyFont)
                .foregroundStyle(.white.opacity(0.85))
            Spacer()
            Text(value)
                .font(HotWheelsTheme.headlineFont)
                .foregroundStyle(.white)
        }
    }

    private func badge(_ text: String) -> some View {
        Text(text)
            .font(HotWheelsTheme.captionFont.weight(.bold))
            .foregroundStyle(HotWheelsTheme.trackBlack)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(HotWheelsTheme.racingYellow)
            )
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
    }
}
