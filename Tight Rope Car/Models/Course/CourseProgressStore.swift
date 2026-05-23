//
//  CourseProgressStore.swift
//  Tight Rope Car
//

import Foundation
import SwiftData

enum CourseProgressStore {
    static func completedSet(for profile: PlayerProfile?) -> Set<String> {
        Set(profile?.completedCourseIDs ?? [])
    }

    /// Marks a course beaten for the profile. Idempotent; does not remove other completions.
    /// - Parameter seedScores: When true, writes deterministic sample highs (map long-press dev tool only).
    static func markCompleted(
        courseID: String,
        for profile: PlayerProfile,
        context: ModelContext,
        seedScores: Bool = true
    ) throws {
        guard CourseCatalog.course(id: courseID) != nil else { return }
        guard CourseMapCatalog.node(courseID: courseID) != nil else { return }
        if !profile.completedCourseIDs.contains(courseID) {
            profile.completedCourseIDs.append(courseID)
        }
        deduplicateCompletedCourses(for: profile)
        if seedScores {
            try CourseScoreStore.seedSampleScore(courseID: courseID, for: profile, context: context)
        }
        try context.save()
    }

    /// Removes duplicate entries while preserving first-seen order.
    static func deduplicateCompletedCourses(for profile: PlayerProfile) {
        var seen = Set<String>()
        profile.completedCourseIDs = profile.completedCourseIDs.filter { courseID in
            guard !seen.contains(courseID) else { return false }
            seen.insert(courseID)
            return true
        }
    }
}
