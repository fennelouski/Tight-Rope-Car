//
//  RacingStripeBackground.swift
//  Tight Rope Car
//

import SwiftUI

struct RacingStripeBackground: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private let stripeWidth: CGFloat = 28
    @State private var stripeOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let diagonal = sqrt(
                geometry.size.width * geometry.size.width +
                geometry.size.height * geometry.size.height
            )

            ZStack {
                HotWheelsTheme.backgroundGradient

                Canvas { context, size in
                    let stripeCount = Int(diagonal / stripeWidth) + 6
                    let baseOffset = -diagonal / 2 + stripeOffset

                    for index in 0..<stripeCount {
                        let x = baseOffset + CGFloat(index) * stripeWidth
                        var path = Path()
                        path.move(to: CGPoint(x: x, y: -size.height))
                        path.addLine(to: CGPoint(x: x + size.height, y: size.height))
                        path.addLine(to: CGPoint(x: x + stripeWidth + size.height, y: size.height))
                        path.addLine(to: CGPoint(x: x + stripeWidth, y: -size.height))
                        path.closeSubpath()

                        let isOrange = index.isMultiple(of: 2)
                        context.fill(
                            path,
                            with: .color(
                                isOrange
                                    ? HotWheelsTheme.flameOrange.opacity(0.35)
                                    : HotWheelsTheme.electricBlue.opacity(0.3)
                            )
                        )
                    }
                }
                .rotationEffect(.degrees(-25))
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: startStripeScroll)
    }

    private func startStripeScroll() {
        guard !reduceMotion else { return }
        stripeOffset = 0
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
            stripeOffset = stripeWidth * 2
        }
    }
}

#Preview {
    RacingStripeBackground()
}
