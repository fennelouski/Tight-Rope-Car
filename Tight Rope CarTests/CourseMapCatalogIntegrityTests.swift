//
//  CourseMapCatalogIntegrityTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Testing
@testable import Tight_Rope_Car

struct CourseMapCatalogIntegrityTests {

    @Test func catalogAndMapHaveNoIntegrityIssues() {
        let issues = CourseMapCatalogIntegrity.validate()
        #expect(
            issues.isEmpty,
            "Course map/catalog issues: \(issues.map(\.detail).joined(separator: "; "))"
        )
    }

    @Test func mapAndCatalogCourseCountsMatch() {
        #expect(CourseMapCatalog.nodes.count == CourseCatalog.all.count)
        #expect(CourseMapCatalog.nodes.count == 200)
    }

    @Test func allMapNodesReachableFromTutorial() {
        let unreachable = CourseMapCatalogIntegrity.unreachableCourseIDs(from: "tutorial")
        #expect(unreachable.isEmpty)
    }

    @Test func startNodesMatchConstants() {
        let noIncoming = Set(
            CourseMapCatalog.nodes
                .map(\.courseID)
                .filter { CourseMapCatalog.incomingEdges(to: $0).isEmpty }
        )
        #expect(noIncoming == Set(CourseMapConstants.startCourseIDs))
    }

    @Test func validatorDetectsMissingCatalogEntry() {
        let issues = CourseMapCatalogIntegrity.validate(
            nodes: [CourseMapNode(courseID: "phantom", mapPosition: .zero)],
            edges: [],
            courses: []
        )
        #expect(issues.contains { $0.code == "map_node_missing_catalog" })
    }

    @Test func validatorDetectsUnknownEdgeEndpoint() {
        let issues = CourseMapCatalogIntegrity.validate(
            nodes: [
                CourseMapNode(courseID: "tutorial", mapPosition: .zero),
                CourseMapNode(courseID: "bumps", mapPosition: CGPoint(x: 0.2, y: 0.1)),
            ],
            edges: [CourseMapEdge(fromCourseID: "tutorial", toCourseID: "missing")],
            courses: [CourseCatalog.tutorial, CourseCatalog.bumps]
        )
        #expect(issues.contains { $0.code == "edge_unknown_to" })
    }

    @Test func validatorDetectsOrphanCatalogCourse() {
        let issues = CourseMapCatalogIntegrity.validate(
            nodes: [CourseMapNode(courseID: "tutorial", mapPosition: .zero)],
            edges: [],
            courses: [CourseCatalog.tutorial, CourseCatalog.bumps]
        )
        #expect(issues.contains { $0.code == "catalog_course_missing_map" })
    }
}
