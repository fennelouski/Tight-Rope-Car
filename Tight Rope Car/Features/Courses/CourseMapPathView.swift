//
//  CourseMapPathView.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapPathView: View {
    let edges: [CourseMapEdge]
    let nodePositions: [String: CGPoint]
    var highlightCourseIDs: Set<String> = []

    var body: some View {
        Canvas { context, size in
            for edge in edges {
                guard let from = nodePositions[edge.fromCourseID],
                      let to = nodePositions[edge.toCourseID]
                else { continue }

                let isHighlighted = highlightCourseIDs.contains(edge.fromCourseID)
                    || highlightCourseIDs.contains(edge.toCourseID)

                var path = Path()
                path.move(to: from)
                let midY = (from.y + to.y) * 0.5
                path.addCurve(
                    to: to,
                    control1: CGPoint(x: from.x, y: midY),
                    control2: CGPoint(x: to.x, y: midY)
                )

                context.stroke(
                    path,
                    with: .color(
                        isHighlighted
                            ? HotWheelsTheme.racingYellow.opacity(0.9)
                            : HotWheelsTheme.hotRed.opacity(0.55)
                    ),
                    style: StrokeStyle(
                        lineWidth: isHighlighted ? 5 : 3.5,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    let size = CGSize(width: 300, height: 480)
    let positions = CourseMapLayout.positions(in: size)
    CourseMapPathView(edges: CourseMapCatalog.edges, nodePositions: positions)
        .frame(width: size.width, height: size.height)
        .background(HotWheelsTheme.trackBlack.opacity(0.35))
}
