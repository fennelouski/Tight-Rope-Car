//
//  CourseMapCatalogIntegrity.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

/// A single catalog/map consistency problem (for tests and future CI scripts).
struct CourseMapIntegrityIssue: Equatable, Sendable {
    let code: String
    let detail: String
}

/// Validates that ``CourseMapCatalog`` and ``CourseCatalog`` stay in sync.
enum CourseMapCatalogIntegrity {
    static func validate(
        nodes: [CourseMapNode] = CourseMapCatalog.nodes,
        edges: [CourseMapEdge] = CourseMapCatalog.edges,
        courses: [Course] = CourseCatalog.all,
        startCourseIDs: [String] = CourseMapConstants.startCourseIDs
    ) -> [CourseMapIntegrityIssue] {
        var issues: [CourseMapIntegrityIssue] = []
        let nodeIDs = nodes.map(\.courseID)
        let nodeIDSet = Set(nodeIDs)
        let catalogIDs = Set(courses.map(\.id))

        if nodeIDs.count != nodeIDSet.count {
            let duplicates = Dictionary(grouping: nodeIDs, by: { $0 })
                .filter { $1.count > 1 }
                .map(\.key)
            issues.append(.init(
                code: "duplicate_map_nodes",
                detail: "Duplicate map course IDs: \(duplicates.sorted().joined(separator: ", "))"
            ))
        }

        for node in nodes {
            if CourseCatalog.course(id: node.courseID) == nil {
                issues.append(.init(
                    code: "map_node_missing_catalog",
                    detail: "Map node '\(node.courseID)' has no CourseCatalog entry"
                ))
            }
            if node.mapPosition.x < 0 || node.mapPosition.x > 1
                || node.mapPosition.y < 0 || node.mapPosition.y > 1 {
                issues.append(.init(
                    code: "map_position_out_of_range",
                    detail: "Node '\(node.courseID)' position \(node.mapPosition) outside 0…1"
                ))
            }
        }

        let orphanCatalog = catalogIDs.subtracting(nodeIDSet).sorted()
        if !orphanCatalog.isEmpty {
            issues.append(.init(
                code: "catalog_course_missing_map",
                detail: "Catalog courses not on map: \(orphanCatalog.prefix(8).joined(separator: ", "))\(orphanCatalog.count > 8 ? "…" : "")"
            ))
        }

        for edge in edges {
            if edge.fromCourseID == edge.toCourseID {
                issues.append(.init(
                    code: "edge_self_loop",
                    detail: "Edge loops on '\(edge.fromCourseID)'"
                ))
            }
            if !nodeIDSet.contains(edge.fromCourseID) {
                issues.append(.init(
                    code: "edge_unknown_from",
                    detail: "Edge from unknown '\(edge.fromCourseID)' → '\(edge.toCourseID)'"
                ))
            }
            if !nodeIDSet.contains(edge.toCourseID) {
                issues.append(.init(
                    code: "edge_unknown_to",
                    detail: "Edge from '\(edge.fromCourseID)' → unknown '\(edge.toCourseID)'"
                ))
            }
        }

        var edgeKeys = Set<String>()
        for edge in edges {
            let key = "\(edge.fromCourseID)→\(edge.toCourseID)"
            if edgeKeys.contains(key) {
                issues.append(.init(
                    code: "duplicate_edge",
                    detail: "Duplicate edge \(key)"
                ))
            }
            edgeKeys.insert(key)
        }

        let startsWithNoIncoming = nodeIDSet.filter { incomingEdges(to: $0, in: edges).isEmpty }.sorted()
        let declaredStarts = Set(startCourseIDs)
        let undeclaredStarts = Set(startsWithNoIncoming).subtracting(declaredStarts)
        if !undeclaredStarts.isEmpty {
            issues.append(.init(
                code: "undeclared_start_node",
                detail: "Nodes without incoming edges not in startCourseIDs: \(undeclaredStarts.sorted().joined(separator: ", "))"
            ))
        }
        let missingDeclaredStarts = declaredStarts.subtracting(nodeIDSet)
        if !missingDeclaredStarts.isEmpty {
            issues.append(.init(
                code: "start_not_on_map",
                detail: "startCourseIDs missing from map: \(missingDeclaredStarts.sorted().joined(separator: ", "))"
            ))
        }

        for courseID in nodeIDSet.subtracting(declaredStarts) {
            if incomingEdges(to: courseID, in: edges).isEmpty {
                issues.append(.init(
                    code: "non_start_without_incoming",
                    detail: "Non-start node '\(courseID)' has no incoming edges"
                ))
            }
        }

        issues.append(contentsOf: unreachableNodeIssues(from: "tutorial", nodeIDSet: nodeIDSet, edges: edges))

        for course in courses where nodeIDSet.contains(course.id) {
            if course.waypoints.count < 2 {
                issues.append(.init(
                    code: "course_too_few_waypoints",
                    detail: "'\(course.id)' has \(course.waypoints.count) waypoints"
                ))
            }
            let length = CourseSampler(course: course).totalLength
            if length <= 0 {
                issues.append(.init(
                    code: "course_zero_length",
                    detail: "'\(course.id)' sampler totalLength is \(length)"
                ))
            }
        }

        return issues
    }

    /// Nodes not reachable from `originID` following directed map edges.
    static func unreachableCourseIDs(
        from originID: String,
        nodes: [CourseMapNode] = CourseMapCatalog.nodes,
        edges: [CourseMapEdge] = CourseMapCatalog.edges
    ) -> Set<String> {
        let nodeIDSet = Set(nodes.map(\.courseID))
        var visited: Set<String> = [originID]
        guard nodeIDSet.contains(originID) else { return nodeIDSet }
        var queue = [originID]
        while let current = queue.first {
            queue.removeFirst()
            for edge in outgoingEdges(from: current, in: edges) {
                if visited.insert(edge.toCourseID).inserted {
                    queue.append(edge.toCourseID)
                }
            }
        }
        return nodeIDSet.subtracting(visited)
    }

    // MARK: - Private

    private static func incomingEdges(to courseID: String, in edges: [CourseMapEdge]) -> [CourseMapEdge] {
        edges.filter { $0.toCourseID == courseID }
    }

    private static func outgoingEdges(from courseID: String, in edges: [CourseMapEdge]) -> [CourseMapEdge] {
        edges.filter { $0.fromCourseID == courseID }
    }

    private static func unreachableNodeIssues(
        from originID: String,
        nodeIDSet: Set<String>,
        edges: [CourseMapEdge]
    ) -> [CourseMapIntegrityIssue] {
        guard nodeIDSet.contains(originID) else {
            return [.init(
                code: "missing_origin",
                detail: "Origin '\(originID)' is not on the map"
            )]
        }

        var visited: Set<String> = [originID]
        var queue = [originID]
        while let current = queue.first {
            queue.removeFirst()
            for edge in outgoingEdges(from: current, in: edges) {
                if visited.insert(edge.toCourseID).inserted {
                    queue.append(edge.toCourseID)
                }
            }
        }

        let unreachable = nodeIDSet.subtracting(visited).sorted()
        guard !unreachable.isEmpty else { return [] }
        return [.init(
            code: "unreachable_map_node",
            detail: "Unreachable from '\(originID)': \(unreachable.joined(separator: ", "))"
        )]
    }
}
