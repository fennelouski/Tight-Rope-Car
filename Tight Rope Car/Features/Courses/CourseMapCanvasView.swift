//
//  CourseMapCanvasView.swift
//  Tight Rope Car
//

import SwiftUI

struct CourseMapCanvasView: View {
    let nodeStates: [String: CourseMapNodeState]
    let selectedCourseID: String?
    var onSelect: (String) -> Void = { _ in }
    var onMarkComplete: (String) -> Void = { _ in }

    private var positions: [String: CGPoint] {
        CourseMapLayout.positions(in: CourseMapLayout.canvasSize)
    }

    var body: some View {
        let size = CourseMapLayout.canvasSize

        ZStack {
            mapBoardBackground

            CourseMapPathView(
                edges: CourseMapCatalog.edges,
                nodePositions: positions,
                nodeStates: nodeStates,
                selectedCourseID: selectedCourseID
            )
            .frame(width: size.width, height: size.height)

            ForEach(CourseMapCatalog.nodes) { node in
                nodeButton(for: node)
            }
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var mapBoardBackground: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        HotWheelsTheme.trackBlack.opacity(0.52),
                        HotWheelsTheme.trackBlack.opacity(0.38),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay {
                Canvas { context, canvasSize in
                    drawProgressGlows(in: &context, canvasSize: canvasSize)

                    let laneSpacing: CGFloat = 28
                    var y: CGFloat = laneSpacing * 0.5
                    while y < canvasSize.height {
                        var path = Path()
                        path.move(to: CGPoint(x: 16, y: y))
                        path.addLine(to: CGPoint(x: canvasSize.width - 16, y: y))
                        context.stroke(
                            path,
                            with: .color(Color.white.opacity(0.04)),
                            style: StrokeStyle(lineWidth: 1, dash: [4, 12])
                        )
                        y += laneSpacing
                    }
                }
                .allowsHitTesting(false)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                HotWheelsTheme.hotRed.opacity(0.65),
                                HotWheelsTheme.flameOrange.opacity(0.45),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2.5
                    )
            )
    }

    @ViewBuilder
    private func nodeButton(for node: CourseMapNode) -> some View {
        let state = nodeStates[node.courseID] ?? .locked
        let course = CourseCatalog.course(id: node.courseID)
        let displayName = course?.displayName ?? node.courseID

        if let center = positions[node.courseID] {
            Button {
                onSelect(node.courseID)
            } label: {
                CourseMapNodeView(
                    displayName: displayName,
                    state: state,
                    isSelected: selectedCourseID == node.courseID
                )
            }
            .buttonStyle(.plain)
            .disabled(state == .locked)
            .position(center)
            .zIndex(nodeZIndex(state: state, courseID: node.courseID))
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.8)
                    .onEnded { _ in
                        if state == .available || state == .beaten {
                            onMarkComplete(node.courseID)
                        }
                    }
            )
            .accessibilityLabel(accessibilityLabel(displayName: displayName, state: state))
            .accessibilityHint(accessibilityHint(state: state))
            .accessibilityAddTraits(selectedCourseID == node.courseID ? .isSelected : [])
        }
    }

    private func drawProgressGlows(in context: inout GraphicsContext, canvasSize: CGSize) {
        let glowRadius = CourseMapLayout.nodeDiameter * 0.62
        for node in CourseMapCatalog.nodes {
            guard nodeStates[node.courseID] == .beaten,
                  let center = positions[node.courseID]
            else { continue }

            let rect = CGRect(
                x: center.x - glowRadius,
                y: center.y - glowRadius,
                width: glowRadius * 2,
                height: glowRadius * 2
            )
            context.fill(
                Path(ellipseIn: rect),
                with: .color(HotWheelsTheme.racingYellow.opacity(0.07))
            )
        }
    }

    private func nodeZIndex(state: CourseMapNodeState, courseID: String) -> Double {
        if selectedCourseID == courseID { return 3 }
        switch state {
        case .available: return 2
        case .beaten: return 1
        case .locked: return 0
        }
    }

    private func accessibilityLabel(displayName: String, state: CourseMapNodeState) -> String {
        switch state {
        case .locked:
            return "\(displayName), locked"
        case .available:
            return "\(displayName), available"
        case .beaten:
            return "\(displayName), completed"
        }
    }

    private func accessibilityHint(state: CourseMapNodeState) -> String {
        switch state {
        case .locked:
            return "Complete a prerequisite course to unlock"
        case .available, .beaten:
            return "Double tap to select. Long press to mark complete for testing."
        }
    }
}

#Preview("Fresh profile") {
    ScrollView {
        CourseMapCanvasView(
            nodeStates: CourseUnlockEvaluator.nodeStates(completedCourseIDs: []),
            selectedCourseID: "tutorial"
        )
        .padding()
    }
    .background(Color.gray.opacity(0.3))
}

#Preview("Progress trail") {
    ScrollView {
        CourseMapCanvasView(
            nodeStates: CourseUnlockEvaluator.nodeStates(
                completedCourseIDs: ["tutorial", "bumps", "narrowWire"]
            ),
            selectedCourseID: "switchbacks"
        )
        .padding()
    }
    .background(Color.gray.opacity(0.3))
}
