//
//  RunFlowOverlayBackdrop.swift
//  Tight Rope Car
//

import SwiftUI

/// Dimmed playfield behind pause and results overlays.
struct RunFlowOverlayBackdrop: View {
    var accentColor: Color = HotWheelsTheme.racingYellow

    var body: some View {
        ZStack {
            Color.black.opacity(0.58)

            LinearGradient(
                colors: [
                    accentColor.opacity(0.22),
                    Color.clear,
                    HotWheelsTheme.trackBlack.opacity(0.45),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        .ignoresSafeArea()
    }
}

/// Toy-racing card chrome shared by pause and results overlays.
struct RunFlowOverlayCard<Content: View>: View {
    var borderColor: Color
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            RunFlowRacingStripeBar()
            content()
                .padding(24)
        }
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.94))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(borderColor, lineWidth: 3)
        )
        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.55), radius: 0, x: 0, y: 6)
    }
}

struct RunFlowRacingStripeBar: View {
    var body: some View {
        HStack(spacing: 0) {
            stripe(HotWheelsTheme.hotRed)
            stripe(HotWheelsTheme.racingYellow)
            stripe(HotWheelsTheme.electricBlue)
            stripe(HotWheelsTheme.flameOrange)
        }
        .frame(height: 6)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 18,
                topTrailingRadius: 18
            )
        )
    }

    private func stripe(_ color: Color) -> some View {
        color.frame(maxWidth: .infinity)
    }
}

#Preview("Backdrop") {
    RunFlowOverlayBackdrop(accentColor: HotWheelsTheme.racingYellow)
}
