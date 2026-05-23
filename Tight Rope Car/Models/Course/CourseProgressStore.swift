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
        if seedScores {
            try CourseScoreStore.seedSampleScore(courseID: courseID, for: profile, context: context)
        }
        try context.save()
    }
}
