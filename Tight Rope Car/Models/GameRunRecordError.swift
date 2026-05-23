//
//  GameRunRecordError.swift
//  Tight Rope Car
//

import Foundation

enum GameRunRecordError: Error, Equatable {
    /// Course id is missing from ``CourseCatalog`` or ``CourseMapCatalog``.
    case invalidCourse(String)
}
