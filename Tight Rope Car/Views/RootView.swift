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
}

private enum FlowNavigation {
    case forward
    case backward
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

            switch flow {
            case .landing:
                LandingView(onPlay: goToProfileSelection)
                    .transition(landingTransition)
            case .profileSelection:
                ProfileSelectionView(
                    onContinue: goToCarSelection,
                    onBack: goToLanding
                )
                .transition(screenTransition)
            case .carSelection:
                CarSelectionView(
                    onContinue: goToCourseSelection,
                    onBack: goBackToProfileSelection
                )
                .transition(screenTransition)
            case .courseSelection:
                CourseSelectionView(
                    onBack: goBackToCarSelection,
                    onGoHome: goToLanding,
                    onPlayCourse: goToGameplay
                )
                .transition(screenTransition)
            case .gameplay(let courseID):
                GameplayView(
                    courseID: courseID,
                    onExitToMap: goBackToCourseSelection,
                    onExitToLanding: goToLanding,
                    onPlayAgain: { playAgain(courseID: courseID) },
                    onRetry: { retryGameplay(courseID: courseID) }
                )
                .id(gameplayRunID)
                .transition(gameplayTransition)
            }
        }
        .animation(flowAnimation, value: flow)
    }

    private var flowAnimation: Animation? {
        reduceMotion ? .easeOut(duration: 0.2) : .easeInOut(duration: 0.55)
    }

    private var screenTransition: AnyTransition {
        if reduceMotion {
            return .opacity
        }
        switch navigation {
        case .forward:
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .scale(scale: 0.96))
                    .combined(with: .offset(x: 56)),
                removal: .opacity
            )
        case .backward:
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .scale(scale: 0.96))
                    .combined(with: .offset(x: -56)),
                removal: .opacity
                    .combined(with: .scale(scale: 0.96))
                    .combined(with: .offset(x: 56))
            )
        }
    }

    private var gameplayTransition: AnyTransition {
        if reduceMotion {
            return .opacity
        }
        switch navigation {
        case .forward:
            return .asymmetric(
                insertion: .opacity.combined(with: .scale(scale: 0.98)),
                removal: .opacity
            )
        case .backward:
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .scale(scale: 0.96))
                    .combined(with: .offset(x: -56)),
                removal: .opacity.combined(with: .scale(scale: 1.02))
            )
        }
    }

    private var landingTransition: AnyTransition {
        if reduceMotion {
            return .opacity
        }
        switch navigation {
        case .forward:
            return .asymmetric(
                insertion: .opacity,
                removal: .opacity
                    .combined(with: .scale(scale: 0.94))
                    .combined(with: .offset(x: -48))
            )
        case .backward:
            return .asymmetric(
                insertion: .opacity
                    .combined(with: .scale(scale: 0.94))
                    .combined(with: .offset(x: -48)),
                removal: .opacity
            )
        }
    }

    // MARK: - Setup funnel

    private func goToProfileSelection() {
        navigation = .forward
        flow = .profileSelection
    }

    private func goToCarSelection() {
        navigation = .forward
        flow = .carSelection
    }

    private func goToCourseSelection() {
        navigation = .forward
        flow = .courseSelection
    }

    private func goBackToProfileSelection() {
        navigation = .backward
        flow = .profileSelection
    }

    private func goBackToCarSelection() {
        navigation = .backward
        flow = .carSelection
    }

    private func goToLanding() {
        navigation = .backward
        flow = .landing
    }

    // MARK: - Gameplay

    private func goToGameplay(courseID: String) {
        guard canStartGameplay(courseID: courseID) else { return }
        gameplayRunID = UUID()
        navigation = .forward
        flow = .gameplay(courseID: courseID)
    }

    private func goBackToCourseSelection() {
        navigation = .backward
        flow = .courseSelection
    }

    private func playAgain(courseID: String) {
        guard canStartGameplay(courseID: courseID) else {
            goBackToCourseSelection()
            return
        }
        gameplayRunID = UUID()
        navigation = .forward
        flow = .gameplay(courseID: courseID)
    }

    private func retryGameplay(courseID: String) {
        guard canStartGameplay(courseID: courseID) else {
            goBackToCourseSelection()
            return
        }
        gameplayRunID = UUID()
        flow = .gameplay(courseID: courseID)
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
