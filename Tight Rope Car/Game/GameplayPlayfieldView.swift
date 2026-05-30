//
//  GameplayPlayfieldView.swift
//  Tight Rope Car
//

import SwiftUI

/// Preview / parity reference — not used in production (`GameplayView` uses `GameSceneView`).
/// Shows a pseudo-3D perspective road mock matching the behind-the-car gameplay view.
struct GameplayPlayfieldView: View {
    let course: Course?
    var profileColor: Color = HotWheelsTheme.racingYellow
    var ticketsCollected: Int = 0

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var carBobOffset: CGFloat = 0

    private var theme: BackgroundTheme {
        course?.backgroundTheme ?? .ocean
    }

    var body: some View {
        ZStack {
            ParallaxBackgroundPreviewView(
                theme: theme,
                isScrollingEnabled: false  // Static in perspective preview
            )

            playfieldVignette

            GeometryReader { geometry in
                PerspectiveRoadPreview(
                    course: course,
                    profileColor: profileColor,
                    carBobOffset: carBobOffset,
                    ticketsCollected: ticketsCollected
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .allowsHitTesting(false)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityHidden(true)
        .onAppear(perform: runCarBobAnimation)
    }

    private var playfieldVignette: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black.opacity(0.45), Color.clear],
                startPoint: .top,
                endPoint: UnitPoint(x: 0.5, y: 0.22)
            )
            LinearGradient(
                colors: [Color.clear, Color.black.opacity(0.35)],
                startPoint: UnitPoint(x: 0.5, y: 0.78),
                endPoint: .bottom
            )
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }

    private func runCarBobAnimation() {
        guard !reduceMotion else { return }
        withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) {
            carBobOffset = 4
        }
    }
}

// MARK: - Perspective road preview

/// Draws a pseudo-3D perspective road converging to a vanishing point, with a rear-view car mock.
private struct PerspectiveRoadPreview: View {
    let course: Course?
    var profileColor: Color
    var carBobOffset: CGFloat
    var ticketsCollected: Int

    private var ropeStroke: Color {
        course?.styleSpans.first?.ropeStroke.swiftUIColor ?? HotWheelsTheme.trackBlack
    }

    private var ropeHighlight: Color {
        course?.styleSpans.first?.ropeHighlight?.swiftUIColor ?? Color.white.opacity(0.35)
    }

    private var ticketFractions: [Double] {
        course?.ticketFractions ?? [0.25, 0.5, 0.75]
    }

    var body: some View {
        ZStack {
            Canvas { context, size in
                let vanishX = size.width * 0.50
                let vanishY = size.height * 0.42
                let bottomY = size.height * 0.88
                let bottomHalfW = size.width * 0.13

                // Underlay shadow
                var roadPath = Path()
                roadPath.move(to: CGPoint(x: vanishX, y: vanishY))
                roadPath.addLine(to: CGPoint(x: vanishX + bottomHalfW, y: bottomY))
                roadPath.addLine(to: CGPoint(x: vanishX - bottomHalfW, y: bottomY))
                roadPath.closeSubpath()
                context.fill(roadPath, with: .color(ropeStroke.opacity(0.55)))

                // Main rope/road fill
                var innerPath = Path()
                innerPath.move(to: CGPoint(x: vanishX, y: vanishY))
                innerPath.addLine(to: CGPoint(x: vanishX + bottomHalfW * 0.85, y: bottomY))
                innerPath.addLine(to: CGPoint(x: vanishX - bottomHalfW * 0.85, y: bottomY))
                innerPath.closeSubpath()
                context.fill(innerPath, with: .color(ropeStroke))

                // Highlight stripe
                var highlightPath = Path()
                highlightPath.move(to: CGPoint(x: vanishX, y: vanishY))
                highlightPath.addLine(to: CGPoint(x: vanishX, y: bottomY))
                context.stroke(
                    highlightPath,
                    with: .color(ropeHighlight),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )

                // Rear-view car mock at bottom-center
                let carCenterX = size.width * 0.50
                let carCenterY = bottomY - 28 + carBobOffset
                let carW: CGFloat = 54
                let carH: CGFloat = 36

                let bodyRect = CGRect(
                    x: carCenterX - carW / 2,
                    y: carCenterY - carH / 2,
                    width: carW,
                    height: carH
                )
                context.fill(
                    Path(roundedRect: bodyRect, cornerRadius: 5),
                    with: .color(profileColor)
                )
                // Rear window
                let winRect = CGRect(x: carCenterX - carW * 0.28, y: carCenterY - carH * 0.38, width: carW * 0.56, height: carH * 0.38)
                context.fill(Path(roundedRect: winRect, cornerRadius: 3), with: .color(.black.opacity(0.75)))
                // Tail lights
                for lx in [bodyRect.minX + 3, bodyRect.maxX - 11] {
                    let lr = CGRect(x: lx, y: carCenterY + carH * 0.05, width: 8, height: carH * 0.28)
                    context.fill(Path(roundedRect: lr, cornerRadius: 2), with: .color(.red.opacity(0.85)))
                }
                context.stroke(
                    Path(roundedRect: bodyRect, cornerRadius: 5),
                    with: .color(.black.opacity(0.3)),
                    lineWidth: 1.5
                )
            }

            // Tickets projected onto perspective road
            GeometryReader { geometry in
                let size = geometry.size
                let vanishX = size.width * 0.50
                let vanishY = size.height * 0.42
                let bottomY = size.height * 0.88
                let perspStr: CGFloat = 8.0

                ForEach(Array(ticketFractions.enumerated()), id: \.offset) { index, fraction in
                    let t = CGFloat(fraction)
                    let ps = 1.0 / (1.0 + t * perspStr)
                    let sy = vanishY + (bottomY - vanishY) * ps
                    let state: TicketPickupState = index < ticketsCollected ? .collected : .available
                    TicketPickupView(
                        state: state,
                        accentColor: HotWheelsTheme.racingYellow,
                        displaySize: .playfield
                    )
                    .position(x: vanishX, y: sy)
                }
            }
        }
    }
}

#Preview("Tutorial playfield – perspective") {
    GameplayPlayfieldView(
        course: CourseCatalog.course(id: "tutorial"),
        profileColor: HotWheelsTheme.electricBlue
    )
}

#Preview("Jungle playfield – perspective") {
    GameplayPlayfieldView(
        course: CourseCatalog.course(id: "jungleSwing"),
        profileColor: HotWheelsTheme.flameOrange
    )
}
