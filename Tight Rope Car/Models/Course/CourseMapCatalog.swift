//
//  CourseMapCatalog.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

enum CourseMapCatalog {
    static let nodes: [CourseMapNode] = [
        CourseMapNode(courseID: "tutorial", mapPosition: CGPoint(x: 0.5, y: 0.06)),
        CourseMapNode(courseID: "bumps", mapPosition: CGPoint(x: 0.28, y: 0.22)),
        CourseMapNode(courseID: "narrowWire", mapPosition: CGPoint(x: 0.72, y: 0.22)),
        CourseMapNode(courseID: "switchbacks", mapPosition: CGPoint(x: 0.28, y: 0.40)),
        CourseMapNode(courseID: "zigZag", mapPosition: CGPoint(x: 0.72, y: 0.40)),
        CourseMapNode(courseID: "longHaul", mapPosition: CGPoint(x: 0.5, y: 0.54)),
        CourseMapNode(courseID: "bigDrop", mapPosition: CGPoint(x: 0.28, y: 0.72)),
        CourseMapNode(courseID: "sunsetCruise", mapPosition: CGPoint(x: 0.72, y: 0.72)),
        CourseMapNode(courseID: "ropeBridge", mapPosition: CGPoint(x: 0.5, y: 0.90)),
    ]

    static let edges: [CourseMapEdge] = [
        CourseMapEdge(fromCourseID: "tutorial", toCourseID: "bumps"),
        CourseMapEdge(fromCourseID: "tutorial", toCourseID: "narrowWire"),
        CourseMapEdge(fromCourseID: "bumps", toCourseID: "switchbacks"),
        CourseMapEdge(fromCourseID: "narrowWire", toCourseID: "zigZag"),
        CourseMapEdge(fromCourseID: "switchbacks", toCourseID: "longHaul"),
        CourseMapEdge(fromCourseID: "zigZag", toCourseID: "longHaul"),
        CourseMapEdge(fromCourseID: "longHaul", toCourseID: "bigDrop"),
        CourseMapEdge(fromCourseID: "longHaul", toCourseID: "sunsetCruise"),
        CourseMapEdge(fromCourseID: "bigDrop", toCourseID: "ropeBridge"),
        CourseMapEdge(fromCourseID: "sunsetCruise", toCourseID: "ropeBridge"),
    ]

    static func node(courseID: String) -> CourseMapNode? {
        nodes.first { $0.courseID == courseID }
    }

    static func incomingEdges(to courseID: String) -> [CourseMapEdge] {
        edges.filter { $0.toCourseID == courseID }
    }

    static func outgoingEdges(from courseID: String) -> [CourseMapEdge] {
        edges.filter { $0.fromCourseID == courseID }
    }
}
