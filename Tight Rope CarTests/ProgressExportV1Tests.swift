//
//  ProgressExportV1Tests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct ProgressExportV1Tests {

    @Test func exportUsesMapOrderForCompletedIDs() throws {
        let profile = PlayerProfile(
            name: "Alex",
            age: 8,
            completedCourseIDs: ["course_050", "tutorial", "course_010"]
        )
        let export = ProgressExportV1.make(profile: profile, scoresByCourseID: [:])

        let mapOrder = CourseMapCatalog.nodes.map(\.courseID)
        let expected = mapOrder.filter { ["tutorial", "course_010", "course_050"].contains($0) }
        #expect(export.completedCourseIDs == expected)
    }

    @Test func exportJSONRoundTrips() throws {
        let profile = PlayerProfile(
            name: "Riley",
            age: 10,
            completedCourseIDs: ["tutorial"],
            totalTickets: 12
        )
        let score = CourseHighScore(
            courseID: "tutorial",
            bestTimeSeconds: 40,
            bestDistance: 500,
            bestTicketCount: 3
        )
        let payload = ProgressExportV1.make(
            profile: profile,
            scoresByCourseID: ["tutorial": score],
            exportedAt: Date(timeIntervalSince1970: 1_700_000_000)
        )

        let data = try payload.encodedJSON(prettyPrinted: false)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(ProgressExportV1.self, from: data)

        #expect(decoded.formatVersion == ProgressExportV1.formatVersion)
        #expect(decoded.profileDisplayName == "Riley")
        #expect(decoded.profileID == profile.id)
        #expect(decoded.totalTickets == 12)
        #expect(decoded.completedCourseIDs.contains("tutorial"))
        #expect(decoded.highScores.count == 1)
        #expect(decoded.highScores[0].courseID == "tutorial")
        #expect(decoded.highScores[0].bestTimeSeconds == 40)
    }

    @Test func makeExportProducesJSONAndSluggedFileName() {
        let profile = PlayerProfile(name: "Sam O'Neil", age: 7, completedCourseIDs: ["tutorial"])
        let export = ProgressShareBuilder.makeExport(profile: profile, scoresByCourseID: [:])

        #expect(!export.jsonData.isEmpty)
        #expect(export.jsonFileName.hasPrefix("tight-rope-car-"))
        #expect(export.jsonFileName.hasSuffix("-progress.json"))
        #expect(export.plainText.contains("Beat course IDs"))
        #expect(export.plainText.contains("tutorial"))
    }
}
