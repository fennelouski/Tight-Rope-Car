//
//  GameplayPlayfieldView.swift
//  Tight Rope Car
//

import SwiftUI

/// Preview / parity reference only — not used in production (`GameplayView` uses `GameSceneView`).
/// SwiftUI parallax + rope/car mock for canvas previews; behavior reference for `RopePathBuilder`.
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
                isScrollingEnabled: !reduceMotion
            )

            playfieldVignette

            GeometryReader { geometry in
                GameplayRopeSceneOverlay(
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
                colors: [
                    Color.black.opacity(0.45),
                    Color.clear,
                ],
                startPoint: .top,
                endPoint: UnitPoint(x: 0.5, y: 0.22)
            )
            LinearGradient(
                colors: [
                    Color.clear,
                    Color.black.opacity(0.35),
                ],
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

// MARK: - Rope path + mock gameplay elements

private enum GameplayRopeLayout {
    static func point(at fraction: CGFloat, in size: CGSize) -> CGPoint {
        let baseline = size.height * 0.58
        let amplitude = size.height * 0.065
        let x = size.width * (0.06 + fraction * 0.88)
        let wave = sin(fraction * .pi * 2.15) * amplitude
        return CGPoint(x: x, y: baseline + wave)
    }

    static func ropePath(in size: CGSize) -> Path {
        var path = Path()
        let steps = 48
        for step in 0 ... steps {
            let fraction = CGFloat(step) / CGFloat(steps)
            let point = point(at: fraction, in: size)
            if step == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        return path
    }
}

private struct GameplayRopeSceneOverlay: View {
    let course: Course?
    var profileColor: Color
    var carBobOffset: CGFloat
    var ticketsCollected: Int

    private var ropeStroke: Color {
        course?.styleSpans.first?.ropeStroke.swiftUIColor ?? HotWheelsTheme.trackBlack
    }

    private var ropeHighlight: Color {
        course?.styleSpans.first?.ropeHighlight?.swiftUIColor
            ?? Color.white.opacity(0.35)
    }

    private var ticketFractions: [Double] {
        course?.ticketFractions ?? [0.25, 0.5, 0.75]
    }

    var body: some View {
        ZStack {
            Canvas { context, size in
                let ropeWidth = CGFloat(course?.ropeWidth ?? 48) * 0.55
                let ropePath = GameplayRopeLayout.ropePath(in: size)

                context.stroke(
                    ropePath,
                    with: .color(ropeStroke.opacity(0.55)),
                    style: StrokeStyle(lineWidth: ropeWidth + 6, lineCap: .round, lineJoin: .round)
                )
                context.stroke(
                    ropePath,
                    with: .color(ropeStroke),
                    style: StrokeStyle(lineWidth: ropeWidth, lineCap: .round, lineJoin: .round)
                )
                context.stroke(
                    ropePath,
                    with: .color(ropeHighlight),
                    style: StrokeStyle(lineWidth: max(3, ropeWidth * 0.18), lineCap: .round, lineJoin: .round)
                )

                let carCenter = GameplayRopeLayout.point(at: 0.34, in: size)
                drawCarMock(in: &context, center: carCenter, bob: carBobOffset)
            }

            GeometryReader { geometry in
                ForEach(Array(ticketFractions.enumerated()), id: \.offset) { index, fraction in
                    let state: TicketPickupState = index < ticketsCollected ? .collected : .available
                    TicketPickupView(
                        state: state,
                        accentColor: profileColor,
                        displaySize: .playfield
                    )
                    .position(
                        GameplayRopeLayout.point(at: CGFloat(fraction), in: geometry.size)
                    )
                }
            }
        }
    }

    private func drawCarMock(in context: inout GraphicsContext, center: CGPoint, bob: CGFloat) {
        let y = center.y - 18 + bob
        let body = CGRect(x: center.x - 26, y: y - 10, width: 52, height: 20)
        context.fill(
            Path(roundedRect: body, cornerRadius: 6),
            with: .color(profileColor)
        )
        context.stroke(
            Path(roundedRect: body, cornerRadius: 6),
            with: .color(HotWheelsTheme.trackBlack),
            lineWidth: 2.5
        )
        for wheelX in [center.x - 16, center.x + 16] {
            let wheel = CGRect(x: wheelX - 7, y: y + 6, width: 14, height: 14)
            context.fill(Path(ellipseIn: wheel), with: .color(HotWheelsTheme.trackBlack))
            context.fill(
                Path(ellipseIn: wheel.insetBy(dx: 3, dy: 3)),
                with: .color(.white.opacity(0.85))
            )
        }
    }
}

#Preview("Tutorial playfield") {
    GameplayPlayfieldView(
        course: CourseCatalog.course(id: "tutorial"),
        profileColor: HotWheelsTheme.electricBlue
    )
}

#Preview("Jungle course playfield") {
    GameplayPlayfieldView(
        course: CourseCatalog.course(id: "jungleSwing"),
        profileColor: HotWheelsTheme.flameOrange
    )
}
