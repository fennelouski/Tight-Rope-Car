//
//  CourseMapPathView.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapPathView: View {
    let edges: [CourseMapEdge]
    let nodePositions: [String: CGPoint]
    let nodeStates: [String: CourseMapNodeState]
    var selectedCourseID: String?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0, paused: reduceMotion)) { timeline in
            Canvas { context, _ in
                let dashPhase = reduceMotion
                    ? 0
                    : CGFloat(timeline.date.timeIntervalSinceReferenceDate * 24)

                for style in CourseMapEdgeStyling.drawOrder {
                    for edge in edges {
                        guard CourseMapEdgeStyling.visualStyle(
                            for: edge,
                            nodeStates: nodeStates,
                            selectedCourseID: selectedCourseID
                        ) == style,
                            let from = nodePositions[edge.fromCourseID],
                            let to = nodePositions[edge.toCourseID]
                        else { continue }

                        let path = curvePath(from: from, to: to)
                        drawEdge(path: path, style: style, dashPhase: dashPhase, in: &context)
                    }
                }
            }
        }
        .drawingGroup(opaque: false, colorMode: .linear)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func curvePath(from: CGPoint, to: CGPoint) -> Path {
        var path = Path()
        path.move(to: from)
        let midY = (from.y + to.y) * 0.5
        path.addCurve(
            to: to,
            control1: CGPoint(x: from.x, y: midY),
            control2: CGPoint(x: to.x, y: midY)
        )
        return path
    }

    private func drawEdge(
        path: Path,
        style: CourseMapEdgeVisualStyle,
        dashPhase: CGFloat,
        in context: inout GraphicsContext
    ) {
        switch style {
        case .locked:
            stroke(
                path,
                color: HotWheelsTheme.trackBlack.opacity(0.85),
                lineWidth: 5,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.hotRed.opacity(0.22),
                lineWidth: 2.5,
                dash: [5, 9],
                dashPhase: 0,
                in: &context
            )

        case .completed:
            stroke(
                path,
                color: HotWheelsTheme.racingYellow.opacity(0.28),
                lineWidth: 12,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.flameOrange.opacity(0.45),
                lineWidth: 9,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.trackBlack.opacity(0.9),
                lineWidth: 6,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.racingYellow.opacity(0.92),
                lineWidth: 3.5,
                in: &context
            )

        case .frontier:
            stroke(
                path,
                color: HotWheelsTheme.trackBlack.opacity(0.9),
                lineWidth: 6,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.electricBlue.opacity(0.95),
                lineWidth: 4,
                dash: [10, 7],
                dashPhase: dashPhase,
                in: &context
            )

        case .selection:
            stroke(
                path,
                color: HotWheelsTheme.trackBlack.opacity(0.95),
                lineWidth: 8,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.racingYellow,
                lineWidth: 5,
                in: &context
            )
            stroke(
                path,
                color: HotWheelsTheme.hotRed.opacity(0.85),
                lineWidth: 2,
                in: &context
            )
        }
    }

    private func stroke(
        _ path: Path,
        color: Color,
        lineWidth: CGFloat,
        dash: [CGFloat] = [],
        dashPhase: CGFloat = 0,
        in context: inout GraphicsContext
    ) {
        var style = StrokeStyle(
            lineWidth: lineWidth,
            lineCap: .round,
            lineJoin: .round
        )
        if !dash.isEmpty {
            style.dash = dash
            style.dashPhase = dashPhase
        }
        context.stroke(path, with: .color(color), style: style)
    }
}

#Preview("Fresh — frontier from tutorial") {
    let size = CGSize(width: 300, height: 480)
    let positions = CourseMapLayout.positions(in: size)
    let states = CourseUnlockEvaluator.nodeStates(completedCourseIDs: [])

    return CourseMapPathView(
        edges: Array(CourseMapCatalog.edges.prefix(6)),
        nodePositions: positions,
        nodeStates: states,
        selectedCourseID: "tutorial"
    )
    .frame(width: size.width, height: size.height)
    .background(HotWheelsTheme.trackBlack.opacity(0.35))
}

#Preview("Beaten trail") {
    let size = CGSize(width: 300, height: 520)
    let positions = CourseMapLayout.positions(in: size)
    let states = CourseUnlockEvaluator.nodeStates(
        completedCourseIDs: ["tutorial", "bumps", "narrowWire", "switchbacks", "windAlley", "zigZag", "longHaul"]
    )

    return CourseMapPathView(
        edges: Array(CourseMapCatalog.edges.prefix(10)),
        nodePositions: positions,
        nodeStates: states,
        selectedCourseID: "longHaul"
    )
    .frame(width: size.width, height: size.height)
    .background(HotWheelsTheme.trackBlack.opacity(0.35))
}
