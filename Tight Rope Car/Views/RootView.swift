//
//  RootView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

enum AppFlow: Equatable {
    case landing
    case profileSelection
    case carSelection
    case courseSelection
    case gameplay(courseID: String)

    /// Menu funnel ordering; gameplay sits above course selection.
    var depth: Int {
        switch self {
        case .landing: return 0
        case .profileSelection: return 1
        case .carSelection: return 2
        case .courseSelection: return 3
        case .gameplay: return 4
        }
    }

    /// Stable identity for transition animations (course id only — run resets use ``gameplayRunID``).
    var screenKey: String {
        switch self {
        case .landing: return "landing"
        case .profileSelection: return "profileSelection"
        case .carSelection: return "carSelection"
        case .courseSelection: return "courseSelection"
        case .gameplay(let courseID): return "gameplay-\(courseID)"
        }
    }
}

private enum FlowNavigation: Equatable {
    case forward
    case backward
    /// Same ``AppFlow`` tier (e.g. retry run) — crossfade without horizontal slide.
    case replace
}

struct RootView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @Query(sort: \PlayerProfile.createdAt, order: .reverse) private var profiles: [PlayerProfile]
    @AppStorage(ProfileConstants.selectedProfileIDKey) private var selectedProfileID = ""

    @State private var flow: AppFlow = .landing
    @State private var navigation: FlowNavigation = .forward
    @State private var gameplayRunID = UUID()

    private var activeProfile: PlayerProfile? {
        guard let uuid = UUID(uuidString: selectedProfileID) else { return nil }
        return profiles.first { $0.id == uuid }
    }

    var body: some View {
        ZStack {
            RacingStripeBackground()

            flowContent
                .id(flow.screenKey)
                .transition(activeTransition)
                .clipped()
        }
        .animation(flowAnimation, value: flow.screenKey)
        .animation(flowAnimation, value: navigation)
    }

    @ViewBuilder
    private var flowContent: some View {
        switch flow {
        case .landing:
            LandingView(onPlay: goToProfileSelection)
        case .profileSelection:
            ProfileSelectionView(
                onContinue: goToCarSelection,
                onBack: goToLanding
            )
        case .carSelection:
            CarSelectionView(
                onContinue: goToCourseSelection,
                onBack: goBackToProfileSelection
            )
        case .courseSelection:
            CourseSelectionView(
                onBack: goBackToCarSelection,
                onGoHome: goToLanding,
                onPlayCourse: goToGameplay
            )
        case .gameplay(let courseID):
            GameplayView(
                courseID: courseID,
                onExitToMap: goBackToCourseSelection,
                onExitToLanding: goToLanding,
                onPlayAgain: { playAgain(courseID: courseID) },
                onRetry: { retryGameplay(courseID: courseID) }
            )
            .id(gameplayRunID)
        }
    }

    private var activeTransition: AnyTransition {
        if reduceMotion {
            return .opacity
        }

        let enteringGameplay = if case .gameplay = flow { navigation == .forward } else { false }
        let leavingGameplay = navigation == .backward && flow.depth == 3

        if enteringGameplay {
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .move(edge: .bottom))
                    .combined(with: .scale(scale: 0.98)),
                removal: .opacity
                    .combined(with: .scale(scale: 0.96))
            )
        }

        if leavingGameplay {
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .scale(scale: 0.97))
                    .combined(with: .offset(x: -32)),
                removal: .opacity
                    .combined(with: .move(edge: .bottom))
                    .combined(with: .scale(scale: 1.02))
            )
        }

        if flow == .landing {
            return landingTransition
        }

        switch navigation {
        case .replace:
            return .opacity
        case .forward:
            return menuTransition(forward: true)
        case .backward:
            return menuTransition(forward: false)
        }
    }

    private var flowAnimation: Animation? {
        if reduceMotion {
            return .easeOut(duration: 0.2)
        }
        switch navigation {
        case .replace:
            return .easeInOut(duration: 0.28)
        case .forward, .backward:
            return .spring(response: 0.44, dampingFraction: 0.86)
        }
    }

    private func menuTransition(forward: Bool) -> AnyTransition {
        let enterOffset: CGFloat = forward ? 48 : -48
        let exitOffset: CGFloat = forward ? -28 : 28

        return .asymmetric(
            insertion: .opacity
                .combined(with: .offset(x: enterOffset))
                .combined(with: .scale(scale: 0.97)),
            removal: .opacity
                .combined(with: .offset(x: exitOffset))
                .combined(with: .scale(scale: 0.98))
        )
    }

    private var landingTransition: AnyTransition {
        switch navigation {
        case .forward:
            return .asymmetric(
                insertion: .opacity.combined(with: .scale(scale: 0.98)),
                removal: .opacity
                    .combined(with: .scale(scale: 0.94))
                    .combined(with: .offset(x: -40))
            )
        case .backward, .replace:
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .scale(scale: 0.94))
                    .combined(with: .offset(x: -40)),
                removal: .opacity.combined(with: .scale(scale: 0.98))
            )
        }
    }

    // MARK: - Flow transitions

    private func applyFlow(_ newFlow: AppFlow, navigation override: FlowNavigation? = nil) {
        let intent = override ?? navigationIntent(from: flow, to: newFlow)
        navigation = intent
        flow = newFlow
    }

    private func navigationIntent(from old: AppFlow, to new: AppFlow) -> FlowNavigation {
        if old == new {
            if case .gameplay = new { return .replace }
            return .replace
        }
        if new == .landing { return .backward }
        if old == .landing { return .forward }
        return new.depth > old.depth ? .forward : .backward
    }

    // MARK: - Setup funnel

    private func goToProfileSelection() {
        applyFlow(.profileSelection)
    }

    private func goToCarSelection() {
        applyFlow(.carSelection)
    }

    private func goToCourseSelection() {
        applyFlow(.courseSelection)
    }

    private func goBackToProfileSelection() {
        applyFlow(.profileSelection)
    }

    private func goBackToCarSelection() {
        applyFlow(.carSelection)
    }

    private func goToLanding() {
        applyFlow(.landing)
    }

    // MARK: - Gameplay

    private func goToGameplay(courseID: String) {
        guard canStartGameplay(courseID: courseID) else { return }
        gameplayRunID = UUID()
        applyFlow(.gameplay(courseID: courseID))
    }

    private func goBackToCourseSelection() {
        applyFlow(.courseSelection)
    }

    private func playAgain(courseID: String) {
        guard canStartGameplay(courseID: courseID) else {
            goBackToCourseSelection()
            return
        }
        gameplayRunID = UUID()
        applyFlow(.gameplay(courseID: courseID), navigation: .replace)
    }

    private func retryGameplay(courseID: String) {
        guard canStartGameplay(courseID: courseID) else {
            goBackToCourseSelection()
            return
        }
        gameplayRunID = UUID()
        applyFlow(.gameplay(courseID: courseID), navigation: .replace)
    }

    private func canStartGameplay(courseID: String) -> Bool {
        guard CourseCatalog.course(id: courseID) != nil,
              CourseMapCatalog.node(courseID: courseID) != nil,
              let profile = activeProfile
        else { return false }

        let state = CourseUnlockEvaluator.nodeState(
            courseID: courseID,
            completedCourseIDs: CourseProgressStore.completedSet(for: profile)
        )
        return state == .available || state == .beaten
    }
}

#Preview {
    RootView()
        .modelContainer(for: [PlayerProfile.self, CourseHighScore.self], inMemory: true)
}
