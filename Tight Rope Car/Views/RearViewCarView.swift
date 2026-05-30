//
//  RearViewCarView.swift
//  Tight Rope Car
//

import SwiftUI

/// Generic rear-view silhouette of a car, rendered from directly behind.
/// Differentiated by ``CarAppearance`` color and body proportions.
/// Per-design rear-view art is a future pass; this covers all 15 silhouettes.
struct RearViewCarView: View {
    let appearance: CarAppearance
    let size: CGSize

    var body: some View {
        Canvas { context, canvasSize in
            let w = canvasSize.width
            let h = canvasSize.height

            // Wheel geometry sized to fit within the canvas on any aspect ratio
            let wheelRadius: CGFloat = min(w, h) * 0.20
            let wheelY: CGFloat = h - wheelRadius - 3
            let leftWheelX = wheelRadius + 6
            let rightWheelX = w - wheelRadius - 6

            // Wheels (drawn first so body overlaps the top halves)
            for wx in [leftWheelX, rightWheelX] {
                let wr = CGRect(x: wx - wheelRadius, y: wheelY - wheelRadius,
                                width: wheelRadius * 2, height: wheelRadius * 2)
                context.fill(Path(ellipseIn: wr), with: .color(.black.opacity(0.88)))
                context.fill(
                    Path(ellipseIn: wr.insetBy(dx: wheelRadius * 0.35, dy: wheelRadius * 0.35)),
                    with: .color(.white.opacity(0.55))
                )
            }

            // Body — wider proportion driven by bodyAspectRatio
            let bodyH: CGFloat = h * 0.62
            let bodyTopY: CGFloat = h * 0.06
            let bodyW: CGFloat = w * 0.82 * min(max(CGFloat(appearance.bodyAspectRatio), 0.7), 1.3)
            let bodyX: CGFloat = (w - bodyW) / 2
            let bodyRect = CGRect(x: bodyX, y: bodyTopY, width: bodyW, height: bodyH)
            context.fill(
                Path(roundedRect: bodyRect, cornerRadius: bodyH * 0.14),
                with: .color(appearance.bodyColor)
            )

            // Rear window
            let windowH: CGFloat = bodyH * 0.38
            let windowW: CGFloat = bodyW * 0.62
            let windowRect = CGRect(
                x: bodyRect.midX - windowW / 2,
                y: bodyRect.minY + bodyH * 0.07,
                width: windowW,
                height: windowH
            )
            context.fill(
                Path(roundedRect: windowRect, cornerRadius: windowH * 0.22),
                with: .color(.black.opacity(0.82))
            )
            // Glass reflection
            context.fill(
                Path(roundedRect: CGRect(
                    x: windowRect.minX + windowW * 0.08,
                    y: windowRect.minY + windowH * 0.10,
                    width: windowW * 0.30,
                    height: windowH * 0.20
                ), cornerRadius: 3),
                with: .color(.white.opacity(0.18))
            )

            // Tail lights
            let lightH: CGFloat = bodyH * 0.20
            let lightW: CGFloat = bodyW * 0.18
            let lightY: CGFloat = bodyRect.maxY - lightH - bodyH * 0.06
            for lx in [bodyRect.minX + bodyW * 0.03, bodyRect.maxX - lightW - bodyW * 0.03] {
                let lr = CGRect(x: lx, y: lightY, width: lightW, height: lightH)
                context.fill(
                    Path(roundedRect: lr, cornerRadius: lightH * 0.25),
                    with: .color(appearance.accentColor.opacity(0.95))
                )
                context.fill(
                    Path(roundedRect: lr.insetBy(dx: 2, dy: 2), cornerRadius: lightH * 0.25),
                    with: .color(.white.opacity(0.30))
                )
            }

            // Bumper
            let bumperH: CGFloat = bodyH * 0.13
            let bumperRect = CGRect(
                x: bodyRect.minX - 3, y: bodyRect.maxY - bumperH * 0.6,
                width: bodyW + 6, height: bumperH
            )
            context.fill(
                Path(roundedRect: bumperRect, cornerRadius: 4),
                with: .color(appearance.bodyColor.opacity(0.65))
            )

            // Body outline
            context.stroke(
                Path(roundedRect: bodyRect, cornerRadius: bodyH * 0.14),
                with: .color(.black.opacity(0.35)),
                lineWidth: 1.5
            )
        }
        .frame(width: size.width, height: size.height)
    }
}


#Preview("Rear view – classic bug") {
    let appearance = CarAppearance(
        bodyColor: .red,
        accentColor: .yellow,
        scale: 1.0,
        silhouette: .classicBug,
        bodyAspectRatio: 1.0,
        wheelSpacingMultiplier: 1.0,
        wheelSizeMultiplier: 1.0
    )
    RearViewCarView(appearance: appearance, size: CGSize(width: 160, height: 160))
}
