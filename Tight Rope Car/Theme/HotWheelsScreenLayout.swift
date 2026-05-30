//
//  HotWheelsScreenLayout.swift
//  Tight Rope Car
//

import SwiftUI

// MARK: - Layout experiment

enum HotWheelsLayoutExperiment {
    /// Flip to `false` to restore normal safe-area layout.
    static let ignoresSafeArea = false
}

// MARK: - Reusable backgrounds

/// Dark fade behind menu funnel bottom bars (play / continue).
struct HotWheelsMenuBottomChromeBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                HotWheelsTheme.trackBlack.opacity(0),
                HotWheelsTheme.trackBlack.opacity(0.72),
                HotWheelsTheme.trackBlack.opacity(0.92),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Funnel navigation

/// Top-of-screen back control plus trailing actions for menu funnel screens.
struct HotWheelsFunnelTopBar<Trailing: View>: View {
    let backAccessibilityHint: String
    let onBack: () -> Void
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            CourseMapToolbarButton(
                systemImage: "chevron.left",
                accessibilityLabel: "Back",
                accessibilityHint: backAccessibilityHint,
                action: onBack
            )

            Spacer(minLength: 8)

            trailing()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension View {
    /// Racing stripes fill safe areas; content may stay inset on top.
    func hotWheelsMenuScreenBackground() -> some View {
        background {
            RacingStripeBackground()
        }
    }

    /// Theme gradient for modal sheets — avoids system gray in safe areas.
    func hotWheelsSheetBackground() -> some View {
        background {
            HotWheelsTheme.backgroundGradient
                .ignoresSafeArea()
        }
        .presentationBackground {
            HotWheelsTheme.backgroundGradient
                .ignoresSafeArea()
        }
    }

    /// Bottom safe-area chrome matching the course map play bar.
    func hotWheelsMenuBottomChromeBackground() -> some View {
        background(
            LinearGradient(
                colors: [
                    HotWheelsTheme.trackBlack.opacity(0),
                    HotWheelsTheme.trackBlack.opacity(0.72),
                    HotWheelsTheme.trackBlack.opacity(0.92),
                ],
                startPoint: .top,
                endPoint: .bottom
            ),
            ignoresSafeAreaEdges: .bottom
        )
    }

    /// Applies edge-to-edge layout when ``HotWheelsLayoutExperiment/ignoresSafeArea`` is enabled.
    @ViewBuilder
    func hotWheelsSafeAreaPolicy() -> some View {
        if HotWheelsLayoutExperiment.ignoresSafeArea {
            ignoresSafeArea()
        } else {
            self
        }
    }

    /// Bottom chrome that respects safe area insets, or overlays at the physical bottom when experimenting.
    @ViewBuilder
    func hotWheelsBottomChromeInset<Content: View>(
        spacing: CGFloat = 0,
        @ViewBuilder content: () -> Content
    ) -> some View {
        if HotWheelsLayoutExperiment.ignoresSafeArea {
            overlay(alignment: .bottom) {
                content()
            }
        } else {
            safeAreaInset(edge: .bottom, spacing: spacing) {
                content()
            }
        }
    }

    /// Safe-area padding that becomes fixed padding when ignoring safe areas.
    @ViewBuilder
    func hotWheelsSafeAreaPadding(_ edges: Edge.Set, _ length: CGFloat? = nil) -> some View {
        if HotWheelsLayoutExperiment.ignoresSafeArea {
            padding(edges, length)
        } else {
            safeAreaPadding(edges, length)
        }
    }
}
