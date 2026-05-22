//
//  ProgressShareBuilder.swift
//  Tight Rope Car
//

import Foundation

enum ProgressShareBuilder {
    static func shareText(
        profile: PlayerProfile,
        scoresByCourseID: [String: CourseHighScore]
    ) -> String {
        let name = profile.displayName.isEmpty ? "Racer" : profile.displayName
        let completedIDs = profile.completedCourseIDs.filter { CourseMapCatalog.node(courseID: $0) != nil }
        let completedNames = completedIDs.compactMap { CourseCatalog.course(id: $0)?.displayName }
        let sortedMapCourses = CourseMapCatalog.nodes.map(\.courseID)

        var lines: [String] = []
        lines.append("Tight Rope Car — \(name)'s progress")
        lines.append("")

        if completedNames.isEmpty {
            lines.append("Courses beaten: 0")
        } else {
            lines.append("Courses beaten: \(completedNames.count)")
            for courseName in completedNames {
                lines.append("• \(courseName)")
            }
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
        lines.append("Keep rolling on the rope!")
        return lines.joined(separator: "\n")
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
