//
//  ProgressShareBuilder.swift
//  Tight Rope Car
//

import Foundation

enum ProgressShareBuilder {
    static func makeExport(
        profile: PlayerProfile,
        scoresByCourseID: [String: CourseHighScore]
    ) -> ProgressShareExport {
        let payload = ProgressExportV1.make(profile: profile, scoresByCourseID: scoresByCourseID)
        let jsonData = (try? payload.encodedJSON()) ?? Data("{}".utf8)
        let slug = sanitizedFileSlug(from: payload.profileDisplayName)
        return ProgressShareExport(
            plainText: shareText(profile: profile, scoresByCourseID: scoresByCourseID),
            jsonData: jsonData,
            jsonFileName: "tight-rope-car-\(slug)-progress.json"
        )
    }

    static func shareText(
        profile: PlayerProfile,
        scoresByCourseID: [String: CourseHighScore]
    ) -> String {
        let name = profile.displayName.isEmpty ? "Racer" : profile.displayName
        let completedIDs = completedCourseIDsInMapOrder(profile: profile)
        let completedNames = completedIDs.compactMap { CourseCatalog.course(id: $0)?.displayName }
        let sortedMapCourses = CourseMapCatalog.nodes.map(\.courseID)
        let completedCount = completedIDs.count
        let mapTotal = PlayerProgressMetrics.mapCourseCount

        var lines: [String] = []
        lines.append("Tight Rope Car — \(name)'s progress")
        lines.append("")
        lines.append("Map: \(completedCount)/\(mapTotal) tracks · \(profile.totalTickets) tickets")

        if completedNames.isEmpty {
            lines.append("Courses beaten: 0")
        } else {
            lines.append("Courses beaten: \(completedNames.count)")
            for courseName in completedNames {
                lines.append("• \(courseName)")
            }
            lines.append("")
            lines.append("Beat course IDs (map order):")
            lines.append(completedIDs.joined(separator: ", "))
        }

        let scoreLines = highScoreSummaryLines(
            courseIDs: sortedMapCourses,
            scoresByCourseID: scoresByCourseID
        )
        if !scoreLines.isEmpty {
            lines.append("")
            lines.append("High scores:")
            lines.append(contentsOf: scoreLines)
        }

        lines.append("")
        lines.append("JSON export v\(ProgressExportV1.formatVersion) attached when sharing from the app.")
        lines.append("Keep rolling on the rope!")
        return lines.joined(separator: "\n")
    }

    /// Completed courses that exist on the map, in ``CourseMapCatalog`` node order.
    static func completedCourseIDsInMapOrder(profile: PlayerProfile) -> [String] {
        let completed = Set(
            profile.completedCourseIDs.filter { CourseMapCatalog.node(courseID: $0) != nil }
        )
        return CourseMapCatalog.nodes.map(\.courseID).filter { completed.contains($0) }
    }

    private static func sanitizedFileSlug(from displayName: String) -> String {
        let lowered = displayName.lowercased()
        let allowed = lowered.map { character -> Character in
            if character.isLetter || character.isNumber { return character }
            return "-"
        }
        let collapsed = String(allowed)
            .split(separator: "-", omittingEmptySubsequences: true)
            .joined(separator: "-")
        if collapsed.isEmpty { return "racer" }
        return String(collapsed.prefix(24))
    }

    private static func highScoreSummaryLines(
        courseIDs: [String],
        scoresByCourseID: [String: CourseHighScore]
    ) -> [String] {
        courseIDs.compactMap { courseID in
            guard let score = scoresByCourseID[courseID],
                  CourseScoreStore.hasAnyScore(score),
                  let name = CourseCatalog.course(id: courseID)?.displayName
            else { return nil }

            var parts: [String] = []
            if let time = score.bestTimeSeconds {
                parts.append("time \(CourseScoreStore.formattedTime(time))")
            }
            if let distance = score.bestDistance {
                parts.append("distance \(CourseScoreStore.formattedDistance(distance))")
            }
            guard !parts.isEmpty else { return nil }
            return "• \(name): \(parts.joined(separator: ", "))"
        }
    }
}
