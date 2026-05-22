//
//  CourseMapNode.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

struct CourseMapNode: Identifiable, Equatable, Sendable {
    let courseID: String
    /// Normalized map coordinates in 0…1 (x left→right, y top→bottom).
    let mapPosition: CGPoint

    var id: String { courseID }
}
