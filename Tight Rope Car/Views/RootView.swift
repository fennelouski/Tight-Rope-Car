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
}

private enum FlowNavigation {
    case forward
    case backward
}

struct RootView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var flow: AppFlow = .landing
    @State private var navigation: FlowNavigation = .forward

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
                    onGoHome: goToLanding
                )
                .transition(screenTransition)
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
}

#Preview {
    RootView()
        .modelContainer(for: [PlayerProfile.self, CourseHighScore.self], inMemory: true)
}
