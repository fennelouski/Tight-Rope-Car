//
//  GameplayView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

/// SwiftUI shell for an in-run session: ``GameSceneView`` playfield, pause menu, results, and theme ambience.
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

    @State private var phase: GameplayPhase = .calibrating
    @State private var tiltSession = GameplayTiltSession()
    @State private var recordResult = GameRunRecordResult(
        unlockedCourseNow: false,
        isNewBestTime: false,
        isNewBestDistance: false,
        ticketsCollected: 0,
        isNewBestTicketCount: false,
        newTotalTickets: 0,
        ticketsCreditedToProfile: 0
    )
    @State private var hudAppeared = false
    /// Tickets collected so far in the current run; updated by the game scene.
    @State private var ticketsCollected: Int = 0
    @StateObject private var ambiencePlayer = ThemeAmbiencePlayer()
    @StateObject private var gameplayLoopPlayer = GameplayLoopSFXPlayer()

    private enum GameplayPhase: Equatable {
        case calibrating
        case running
        case paused
        case results(GameRunOutcome)
    }

    private var isRunActive: Bool {
        if case .running = phase { return true }
        return false
    }

    private var canRecordRunOutcome: Bool {
        switch phase {
        case .running, .paused:
            return true
        case .calibrating, .results:
            return false
        }
    }

    private var balanceHintText: String {
        if !isRunActive { return "Hold device level" }
        if showsOnScreenBalance { return "Use balance buttons" }
        return "Tilt to balance"
    }

    private var isSimulator: Bool {
        #if targetEnvironment(simulator)
        true
        #else
        false
        #endif
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
                tiltSession.configureForAccessibility(reduceMotion: reduceMotion, isSimulator: isSimulator)
                beginSessionIfNeeded()
                runHUDEntranceAnimation()
            }
        }
        .onDisappear {
            ambiencePlayer.stop()
            gameplayLoopPlayer.stop()
            tiltSession.endSession()
        }
        .onChange(of: scenePhase) { _, newPhase in
            guard isPlayableCourse, isRunActive else { return }
            if newPhase == .background {
                phase = .paused
            }
        }
        .task(id: phase) {
            await runCalibrationLoop()
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
            .hotWheelsScreenContentPadding()

            overlayForPhase

            if showsOnScreenBalancePad, let course {
                VStack {
                    Spacer(minLength: 0)
                    GameplayOnScreenBalanceControls(
                        maxRollRadians: course.maxPitchRadians,
                        onNudgeLeft: { nudgeOnScreenBalance(left: true) },
                        onNudgeRight: { nudgeOnScreenBalance(left: false) },
                        onCenter: { tiltSession.centerOnScreenBalance() }
                    )
                }
            }
        }
        .hotWheelsContentWidth()
        .onChange(of: reduceMotion) { _, enabled in
            tiltSession.configureForAccessibility(reduceMotion: enabled, isSimulator: isSimulator)
        }
        .onChange(of: phase) { _, newPhase in
            syncThemeAmbience()
            syncGameplayLoops()
            if case .paused = newPhase {
                Task { @MainActor in
                    GameSFXPlayer.shared.stopAll()
                    GameplayHaptics.shared.resetNearFallCooldown()
                }
            }
        }
    }

    private func syncThemeAmbience() {
        guard let course else {
            ambiencePlayer.stop()
            return
        }
        guard case .running = phase else {
            ambiencePlayer.stop()
            return
        }
        guard let soundName = BackgroundThemeCatalog.metadata(for: course.backgroundTheme).ambienceSoundName,
              ThemeAmbiencePlayer.isSoundAvailable(soundName)
        else {
            ambiencePlayer.stop()
            return
        }
        if !ambiencePlayer.isPlaying(soundName: soundName) {
            ambiencePlayer.play(soundName: soundName)
        }
    }

    private func syncGameplayLoops() {
        guard case .running = phase else {
            gameplayLoopPlayer.stop()
            return
        }
        gameplayLoopPlayer.playEngine(duckedForThemeAmbience: ambiencePlayer.isPlaying)
    }

    private var showsOnScreenBalance: Bool {
        tiltSession.preferOnScreenBalance
    }

    private var showsOnScreenBalancePad: Bool {
        isRunActive && showsOnScreenBalance && course != nil
    }

    private func nudgeOnScreenBalance(left: Bool) {
        guard let course else { return }
        tiltSession.nudgeOnScreenBalance(left: left, maxRoll: course.maxPitchRadians)
    }

    @ViewBuilder
    private var gameLayer: some View {
        if let course = course, let profile = activeProfile {
            let appearance = CarCatalog.car(id: profile.resolvedCarID)?.appearance ?? .default
            GameSceneView(
                course: course,
                carAppearance: appearance,
                ticketAccentColor: profile.profileColor,
                tiltProvider: tiltSession.tiltProvider,
                neutralRollOffset: tiltSession.neutralRollOffset,
                isPaused: !isRunActive,
                reduceMotion: reduceMotion,
                onScreenBalanceActive: tiltSession.preferOnScreenBalance,
                onTicketCollected: { total in ticketsCollected = total },
                onOutcome: { outcome in finishRun(outcome: outcome) }
            )
        } else {
            Color.black
        }
    }

    private var runHUD: some View {
        HStack(alignment: .top, spacing: 12) {
            CourseMapToolbarButton(
                systemImage: "pause.fill",
                accessibilityLabel: "Pause",
                accessibilityHint: "Pause the run"
            ) {
                guard isRunActive else { return }
                phase = .paused
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(courseDisplayName)
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

                Text(balanceHintText)
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
        let accentColor = activeProfile?.profileColor ?? HotWheelsTheme.racingYellow
        return HStack(spacing: 6) {
            TicketPickupView(
                state: .available,
                accentColor: accentColor,
                displaySize: .compact
            )

            VStack(alignment: .leading, spacing: 0) {
                Text("TICKETS")
                    .font(.system(size: 9, weight: .black, design: .rounded))
                    .foregroundStyle(HotWheelsTheme.racingYellow.opacity(0.9))
                Text("\(ticketsCollected)/\(courseTicketCount)")
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.white)
                    .monospacedDigit()
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(HotWheelsTheme.trackBlack.opacity(0.72))
                .overlay(
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                colors: [accentColor, HotWheelsTheme.racingYellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                )
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 0, y: 3)
        )
        .accessibilityElement(children: .ignore)
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
        case .calibrating:
            GameplayCalibrationOverlay(
                progress: tiltSession.calibrationProgress,
                courseDisplayName: courseDisplayName,
                profile: activeProfile,
                usesOnScreenBalance: showsOnScreenBalance,
                showsSkipControl: reduceMotion || isSimulator,
                onSkip: skipCalibrationAndStartRun
            )
            .transition(.opacity)
        case .running:
            EmptyView()
        case .paused:
            GameplayPauseOverlay(
                courseDisplayName: courseDisplayName,
                profile: activeProfile,
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
                profileColor: activeProfile?.profileColor ?? HotWheelsTheme.racingYellow,
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
        guard canRecordRunOutcome else { return }

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

    private func beginSessionIfNeeded() {
        guard case .calibrating = phase else { return }
        if reduceMotion {
            skipCalibrationAndStartRun()
            return
        }
        tiltSession.beginCalibration()
    }

    private func skipCalibrationAndStartRun() {
        tiltSession.skipCalibration(using: activeProfile?.tiltNeutralRollRadians)
        finishCalibrationAndStartRun()
    }

    private func finishCalibrationAndStartRun() {
        guard case .calibrating = phase else { return }
        tiltSession.commitCalibration()
        if let profile = activeProfile {
            profile.tiltNeutralRollRadians = tiltSession.neutralRollOffset
            try? modelContext.save()
        }
        withAnimation(reduceMotion ? nil : .easeOut(duration: 0.25)) {
            phase = .running
        }
    }

    private func runCalibrationLoop() async {
        guard case .calibrating = phase else { return }
        let interval = GameBalanceConstants.calibrationSampleInterval
        while !Task.isCancelled {
            guard case .calibrating = phase else { return }
            tiltSession.ingestCalibrationSample()
            if tiltSession.isCalibrationComplete {
                finishCalibrationAndStartRun()
                return
            }
            try? await Task.sleep(for: .seconds(interval))
        }
    }
}

// MARK: - Sample stats (#if DEBUG chips only; production uses GameScene.onOutcome)

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
