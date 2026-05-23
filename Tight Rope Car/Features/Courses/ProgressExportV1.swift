//
//  ProgressExportV1.swift
//  Tight Rope Car
//

import Foundation

/// Machine-readable progress snapshot for share sheets and backup reference.
struct ProgressExportV1: Codable, Equatable, Sendable {
    static let formatVersion = 1

    let formatVersion: Int
    let exportedAt: Date
    let profileDisplayName: String
    let profileID: UUID
    let totalTickets: Int
    /// Completed courses in map scroll order (``CourseMapCatalog``).
    let completedCourseIDs: [String]
    let mapCoursesTotal: Int
    let highScores: [ExportedHighScore]

    struct ExportedHighScore: Codable, Equatable, Sendable {
        let courseID: String
        let bestTimeSeconds: Double?
        let bestDistance: Double?
        let bestTicketCount: Int?
    }

    static func make(
        profile: PlayerProfile,
        scoresByCourseID: [String: CourseHighScore],
        exportedAt: Date = Date()
    ) -> ProgressExportV1 {
        let name = profile.displayName.isEmpty ? "Racer" : profile.displayName
        let completedIDs = ProgressShareBuilder.completedCourseIDsInMapOrder(profile: profile)
        let mapCourseIDs = CourseMapCatalog.nodes.map(\.courseID)

        let highScores = mapCourseIDs.compactMap { courseID -> ExportedHighScore? in
            guard let score = scoresByCourseID[courseID],
                  CourseScoreStore.hasAnyScore(score)
            else { return nil }
            return ExportedHighScore(
                courseID: courseID,
                bestTimeSeconds: score.bestTimeSeconds,
                bestDistance: score.bestDistance,
                bestTicketCount: score.bestTicketCount
            )
        }

        return ProgressExportV1(
            formatVersion: Self.formatVersion,
            exportedAt: exportedAt,
            profileDisplayName: name,
            profileID: profile.id,
            totalTickets: profile.totalTickets,
            completedCourseIDs: completedIDs,
            mapCoursesTotal: PlayerProgressMetrics.mapCourseCount,
            highScores: highScores
        )
    }

    func encodedJSON(prettyPrinted: Bool = true) throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if prettyPrinted {
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        }
        return try encoder.encode(self)
    }
}
