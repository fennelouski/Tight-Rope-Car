//
//  GameplayView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

/// SwiftUI shell for an in-run session: SpriteKit host (later), pause menu, and results.
struct GameplayView: View {
    let courseID: String
    var onExitToMap: () -> Void = {}
    var onExitToLanding: () -> Void = {}
    var onPlayAgain: () -> Void = {}
    var onRetry: () -> Void = {}

    @Environment(\.modelContext) private var modelContext
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.scenePhase) private var scenePhase

    @Query(sort: \PlayerProfile.createdAt, order: .reverse) private var profiles: [PlayerProfile]
    @AppStorage(ProfileConstants.selectedProfileIDKey) private var selectedProfileID = ""

    @State private var phase: GameplayPhase = .running
    @State private var recordResult = GameRunRecordResult(
        unlockedCourseNow: false,
        isNewBestTime: false,
        isNewBestDistance: false,
        ticketsCollected: 0,
        isNewBestTicketCount: false,
        newTotalTickets: 0
    )
    @State private var hudAppeared = false
    /// Tickets collected so far in the current run; updated by the game scene.
    @State private var ticketsCollected: Int = 0

    private enum GameplayPhase: Equatable {
        case running
        case paused
        case results(GameRunOutcome)
    }

    private var activeProfile: PlayerProfile? {
        guard let uuid = UUID(uuidString: selectedProfileID) else { return nil }
        return profiles.first { $0.id == uuid }
    }

    private var course: Course? {
        CourseCatalog.course(id: courseID)
    }

    private var courseDisplayName: String {
        course?.displayName ?? courseID
    }

    private var courseTicketCount: Int {
        course?.ticketCount ?? 3
    }

    private var isPlayableCourse: Bool {
        guard let profile = activeProfile, course != nil else { return false }
        let state = CourseUnlockEvaluator.nodeState(
            courseID: courseID,
            completedCourseIDs: CourseProgressStore.completedSet(for: profile)
        )
        return state == .available || state == .beaten
    }

    var body: some View {
        Group {
            if isPlayableCourse {
                playableContent
            } else {
                invalidCourseContent
            }
        }
        .onAppear {
            if !isPlayableCourse {
                onExitToMap()
            } else {
                runHUDEntranceAnimation()
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard isPlayableCourse, case .running = phase else { return }
            if newPhase == .background {
                phase = .paused
            }
        }
    }

    // MARK: - Playable run

    private var playableContent: some View {
        ZStack {
            gameLayer
                .opacity(hudAppeared ? 1 : 0)

            VStack(spacing: 0) {
                runHUD
                    .opacity(hudAppeared ? 1 : 0)
                    .offset(y: hudAppeared ? 0 : (reduceMotion ? 0 : 12))
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 32)

            overlayForPhase
        }
        .hotWheelsContentWidth()
    }

    private var gameLayer: some View {
        ZStack {
            Color.black.opacity(0.35)
            VStack(spacing: 12) {
                Image(systemName: "car.side")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(HotWheelsTheme.racingYellow.opacity(0.85))
                Text("SpriteKit scene coming soon")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.75))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityHidden(true)
    }

    private var runHUD: some View {
        HStack(alignment: .top, spacing: 12) {
            CourseMapToolbarButton(
                systemImage: "pause.fill",
                accessibilityLabel: "Pause",
                accessibilityHint: "Pause the run"
            ) {
                guard case .running = phase else { return }
                phase = .paused
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(courseDisplayName)
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

                Text("Tilt to balance")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.9))
            }

            Spacer(minLength: 0)

            ticketHUD

            #if DEBUG
            debugOutcomeButtons
            #endif
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var ticketHUD: some View {
        VStack(alignment: .trailing, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "ticket.fill")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                Text("\(ticketsCollected)/\(courseTicketCount)")
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.white)
                    .monospacedDigit()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.5))
                    .overlay(
                        Capsule()
                            .strokeBorder(HotWheelsTheme.racingYellow.opacity(0.6), lineWidth: 1)
                    )
            )
        }
        .accessibilityLabel("Tickets: \(ticketsCollected) of \(courseTicketCount)")
    }

    #if DEBUG
    private var debugOutcomeButtons: some View {
        HStack(spacing: 6) {
            debugChip("Win") {
                let stats = GameRunStats.sample(for: courseID)
                ticketsCollected = stats.ticketsCollected
                finishRun(outcome: .success(stats))
            }
            debugChip("Fall") {
                let stats = GameRunStats.sampleFall(for: courseID)
                ticketsCollected = stats.ticketsCollected
                finishRun(outcome: .failure(stats))
            }
        }
    }

    private func debugChip(_ title: String, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .font(.system(size: 11, weight: .bold, design: .rounded))
            .foregroundStyle(HotWheelsTheme.trackBlack)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Capsule().fill(HotWheelsTheme.racingYellow.opacity(0.9)))
            .accessibilityLabel("Simulate \(title)")
    }
    #endif

    @ViewBuilder
    private var overlayForPhase: some View {
        switch phase {
        case .running:
            EmptyView()
        case .paused:
            GameplayPauseOverlay(
                onResume: { phase = .running },
                onQuitToMap: onExitToMap,
                onMainMenu: onExitToLanding
            )
            .transition(.opacity)
        case .results(let outcome):
            RunResultsView(
                outcome: outcome,
                recordResult: recordResult,
                courseDisplayName: courseDisplayName,
                onMap: onExitToMap,
                onPlayAgain: onPlayAgain,
                onRetry: onRetry
            )
            .transition(.opacity)
        }
    }

    // MARK: - Invalid course guard

    private var invalidCourseContent: some View {
        Color.clear
            .accessibilityLabel("Course unavailable")
    }

    // MARK: - Run completion

    private func finishRun(outcome: GameRunOutcome) {
        guard let profile = activeProfile else {
            phase = .results(outcome)
            return
        }

        recordResult = (try? GameRunRecorder.record(
            outcome,
            courseID: courseID,
            for: profile,
            context: modelContext
        )) ?? recordResult

        withAnimation(reduceMotion ? .easeOut(duration: 0.2) : .easeInOut(duration: 0.35)) {
            phase = .results(outcome)
        }
    }

    private func runHUDEntranceAnimation() {
        if reduceMotion {
            hudAppeared = true
            return
        }
        withAnimation(.easeOut(duration: 0.35)) {
            hudAppeared = true
        }
    }
}

// MARK: - Sample stats (DEBUG simulation until GameScene reports outcomes)

extension GameRunStats {
    static func sample(for courseID: String) -> GameRunStats {
        let hash = abs(courseID.hashValue)
        let ticketCount = CourseCatalog.course(id: courseID)?.ticketCount ?? 3
        return GameRunStats(
            elapsedSeconds: 32.0 + Double(hash % 40),
            distanceMeters: 480.0 + Double(hash % 220),
            ticketsCollected: ticketCount
        )
    }

    static func sampleFall(for courseID: String) -> GameRunStats {
        let hash = abs(courseID.hashValue)
        let ticketCount = CourseCatalog.course(id: courseID)?.ticketCount ?? 3
        let distanceFraction = min(1.0, (180.0 + Double(hash % 160)) / 700.0)
        return GameRunStats(
            elapsedSeconds: 18.0 + Double(hash % 25),
            distanceMeters: 180.0 + Double(hash % 160),
            ticketsCollected: Int(Double(ticketCount) * distanceFraction)
        )
    }
}

#Preview {
    ZStack {
        RacingStripeBackground()
        GameplayView(courseID: "tutorial")
    }
    .modelContainer(for: [PlayerProfile.self, CourseHighScore.self], inMemory: true)
}
