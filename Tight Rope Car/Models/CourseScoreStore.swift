//
//  CourseScoreStore.swift
//  Tight Rope Car
//

import Foundation
import SwiftData

enum CourseScoreStore {
    static func score(for courseID: String, on profile: PlayerProfile) -> CourseHighScore? {
        profile.highScores.first { $0.courseID == courseID }
    }

    static func scoresByCourseID(for profile: PlayerProfile) -> [String: CourseHighScore] {
        Dictionary(uniqueKeysWithValues: profile.highScores.map { ($0.courseID, $0) })
    }

    /// Updates best time when `timeSeconds` is strictly faster than the saved value.
    @discardableResult
    static func recordBestTime(
        _ timeSeconds: Double,
        courseID: String,
        for profile: PlayerProfile,
        context: ModelContext
    ) throws -> Bool {
        guard timeSeconds > 0, CourseCatalog.course(id: courseID) != nil else { return false }
        let entry = existingOrNew(courseID: courseID, for: profile)
        guard isBetterTime(timeSeconds, than: entry.bestTimeSeconds) else { return false }
        entry.bestTimeSeconds = timeSeconds
        try context.save()
        return true
    }

    /// Updates best distance when `distance` is strictly farther than the saved value.
    @discardableResult
    static func recordBestDistance(
        _ distance: Double,
        courseID: String,
        for profile: PlayerProfile,
        context: ModelContext
    ) throws -> Bool {
        guard distance > 0, CourseCatalog.course(id: courseID) != nil else { return false }
        let entry = existingOrNew(courseID: courseID, for: profile)
        guard isBetterDistance(distance, than: entry.bestDistance) else { return false }
        entry.bestDistance = distance
        try context.save()
        return true
    }

    /// Deterministic sample values for dev/testing when a course is marked complete without gameplay.
    static func seedSampleScore(
        courseID: String,
        for profile: PlayerProfile,
        context: ModelContext
    ) throws {
        let hash = abs(courseID.hashValue)
        let time = 28.0 + Double(hash % 90)
        let distance = 420.0 + Double(hash % 380)
        _ = try recordBestTime(time, courseID: courseID, for: profile, context: context)
        _ = try recordBestDistance(distance, courseID: courseID, for: profile, context: context)
    }

    static func isBetterTime(_ candidate: Double, than existing: Double?) -> Bool {
        guard let existing else { return true }
        return candidate < existing
    }

    static func isBetterDistance(_ candidate: Double, than existing: Double?) -> Bool {
        guard let existing else { return true }
        return candidate > existing
    }

    static func formattedTime(_ seconds: Double?) -> String {
        guard let seconds else { return "—" }
        let total = max(0, Int(seconds.rounded()))
        let minutes = total / 60
        let remainder = total % 60
        if minutes > 0 {
            return String(format: "%d:%02d", minutes, remainder)
        }
        return String(format: "0:%02d", remainder)
    }

    static func formattedDistance(_ distance: Double?) -> String {
        guard let distance else { return "—" }
        return String(format: "%.0f m", distance)
    }

    static func hasAnyScore(_ score: CourseHighScore?) -> Bool {
        guard let score else { return false }
        return score.bestTimeSeconds != nil || score.bestDistance != nil
    }

    private static func existingOrNew(courseID: String, for profile: PlayerProfile) -> CourseHighScore {
        if let existing = score(for: courseID, on: profile) {
            return existing
        }
        let created = CourseHighScore(courseID: courseID, profile: profile)
        profile.highScores.append(created)
        return created
    }
}
