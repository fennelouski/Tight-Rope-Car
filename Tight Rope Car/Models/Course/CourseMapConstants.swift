//
//  CourseMapConstants.swift
//  Tight Rope Car
//

import Foundation

enum CourseMapConstants {
    /// First-time players: only nodes with no incoming edges in ``CourseMapCatalog`` are available.
    /// Today that is `tutorial` alone.
    static let startCourseIDs: [String] = ["tutorial"]

    // MARK: - Unlock rules (level-select graph)
    //
    // - Source of truth for unlock paths is ``CourseMapCatalog`` (not ``Course/unlockOrder``).
    // - A node is *unlocked* when it has no incoming edges (start) OR when **any** incoming edge’s
    //   source course is in the profile’s completed set (OR-merge on prerequisites).
    // - *Available* = unlocked and not yet completed; *beaten* = completed at least once.
    // - Replaying a beaten course does not remove completion or re-lock downstream nodes.
}
