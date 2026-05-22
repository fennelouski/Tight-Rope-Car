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

    private var highlightIDs: Set<String> {
        guard let selectedCourseID else { return [] }
        return [selectedCourseID]
    }

    var body: some View {
        let size = CourseMapLayout.canvasSize

        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.42))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(HotWheelsTheme.hotRed.opacity(0.5), lineWidth: 2)
                )

            CourseMapPathView(
                edges: CourseMapCatalog.edges,
                nodePositions: positions,
                highlightCourseIDs: highlightIDs
            )
            .frame(width: size.width, height: size.height)

            ForEach(CourseMapCatalog.nodes) { node in
                nodeButton(for: node)
            }
        }
        .frame(width: size.width, height: size.height)
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
