//
//  RunResultsView.swift
//  Tight Rope Car
//

import SwiftUI

/// Achievement pills shown on the run-results overlay.
enum RunResultsAchievementBanners {
    struct Item: Equatable {
        let text: String
        let style: HotWheelsAchievementBanner.Style
        let accessibilityLabel: String?

        init(
            text: String,
            style: HotWheelsAchievementBanner.Style,
            accessibilityLabel: String? = nil
        ) {
            self.text = text
            self.style = style
            self.accessibilityLabel = accessibilityLabel
        }
    }

    static func items(
        outcome: GameRunOutcome,
        recordResult: GameRunRecordResult
    ) -> [Item] {
        var items: [Item] = []

        if outcome.isSuccess, recordResult.unlockedCourseNow {
            items.append(Item(
                text: "New course unlocked on the map!",
                style: .unlock
            ))
        }

        let recordKinds = recordKinds(outcome: outcome, recordResult: recordResult)
        guard !recordKinds.isEmpty else { return items }

        if recordKinds.count >= 2 {
            items.append(Item(
                text: "New personal bests!",
                style: .record,
                accessibilityLabel: combinedRecordAccessibilityLabel(kinds: recordKinds)
            ))
        } else {
            items.append(Item(
                text: singleRecordText(for: recordKinds[0]),
                style: .record
            ))
        }

        return items
    }

    private static func recordKinds(
        outcome: GameRunOutcome,
        recordResult: GameRunRecordResult
    ) -> [RecordKind] {
        var kinds: [RecordKind] = []
        if outcome.isSuccess, recordResult.isNewBestTime {
            kinds.append(.time)
        }
        if recordResult.isNewBestDistance {
            kinds.append(.distance)
        }
        if recordResult.isNewBestTicketCount {
            kinds.append(.tickets)
        }
        return kinds
    }

    private enum RecordKind: String {
        case time
        case distance
        case tickets
    }

    private static func singleRecordText(for kind: RecordKind) -> String {
        switch kind {
        case .time: "New best time!"
        case .distance: "New best distance!"
        case .tickets: "New ticket record!"
        }
    }

    private static func combinedRecordAccessibilityLabel(kinds: [RecordKind]) -> String {
        let names = kinds.map { kind -> String in
            switch kind {
            case .time: "time"
            case .distance: "distance"
            case .tickets: "tickets"
            }
        }
        let list = names.formatted(.list(type: .and))
        return "New personal bests: \(list)"
    }
}

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

    private var badgeItems: [RunResultsAchievementBanners.Item] {
        RunResultsAchievementBanners.items(outcome: outcome, recordResult: recordResult)
    }

    var body: some View {
        ZStack {
            RunFlowOverlayBackdrop(accentColor: accentColor)

            ScrollView {
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
                .frame(maxWidth: .infinity)
            }
            .scrollBounceBehavior(.basedOnSize)
            .safeAreaPadding(.vertical, 12)
            .safeAreaPadding(.bottom, 8)
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
                HotWheelsAchievementBanner(
                    text: item.text,
                    style: item.style,
                    accessibilityLabel: item.accessibilityLabel
                )
                .opacity(contentAppeared ? 1 : 0)
                .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 8))
                .animation(
                    reduceMotion ? nil : .easeOut(duration: 0.35).delay(0.12 + Double(index) * 0.06),
                    value: contentAppeared
                )
            }
        }
    }

    private var actionItems: [(icon: String, title: String, subtitle: String?, style: HotWheelsOverlayActionButton.Style, action: () -> Void)] {
        if outcome.isSuccess {
            return [
                ("arrow.clockwise", "Play Again", "Run this course again", .primary, onPlayAgain),
                ("map.fill", "Course Map", "Back to the track map", .secondary, onMap),
            ]
        }
        return [
            ("arrow.clockwise", "Retry", "Give it another shot", .primary, onRetry),
            ("map.fill", "Course Map", "Pick a different course", .secondary, onMap),
        ]
    }

    private var actionButtons: some View {
        VStack(spacing: 10) {
            ForEach(Array(actionItems.enumerated()), id: \.offset) { index, item in
                HotWheelsOverlayActionButton(
                    systemImage: item.icon,
                    title: item.title,
                    subtitle: item.subtitle,
                    style: item.style,
                    action: item.action
                )
                .opacity(contentAppeared ? 1 : 0)
                .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 10))
                .animation(
                    reduceMotion ? nil : .easeOut(duration: 0.32).delay(0.08 + Double(index) * 0.05),
                    value: contentAppeared
                )
            }
        }
        .padding(.top, 4)
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
            isNewBestDistance: true,
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

#Preview("Success — busy", traits: .sizeThatFitsLayout) {
    RunResultsView(
        outcome: .success(
            GameRunStats(elapsedSeconds: 42.5, distanceMeters: 520, ticketsCollected: 3)
        ),
        recordResult: GameRunRecordResult(
            unlockedCourseNow: true,
            isNewBestTime: true,
            isNewBestDistance: true,
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
    .frame(width: 375, height: 667)
}

#Preview("Success — iPhone SE", traits: .fixedLayout(width: 375, height: 667)) {
    RunResultsView(
        outcome: .success(
            GameRunStats(elapsedSeconds: 42.5, distanceMeters: 520, ticketsCollected: 3)
        ),
        recordResult: GameRunRecordResult(
            unlockedCourseNow: true,
            isNewBestTime: true,
            isNewBestDistance: true,
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
            isNewBestTicketCount: true,
            newTotalTickets: 8,
            ticketsCreditedToProfile: 1
        ),
        courseDisplayName: "Roller Rope",
        onMap: {},
        onPlayAgain: {},
        onRetry: {}
    )
}
