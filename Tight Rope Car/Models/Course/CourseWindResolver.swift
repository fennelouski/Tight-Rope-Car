//
//  CourseWindResolver.swift
//  Tight Rope Car
//

import Foundation

/// Assigns ``WindProfile`` presets from course IDs (wind-themed levels, storms, etc.).
enum CourseWindResolver {
    static let overrides: [String: WindProfile] = [
        "windAlley": .alley,
        "fierceWind": .fierce,
        "canyonWind": .gusty,
        "arcticWind": .gusty,
        "prairieWind": .alley,
        "solarWind": .gusty,
        "typhoonTrack": .fierce,
        "tornadoAlley": .fierce,
        "stormChaser": .gusty,
        "stormSurge": .gusty,
        "stormBolt": .fierce,
    ]

    private static let keywordRules: [(keywords: [String], profile: WindProfile)] = [
        (["typhoon", "tornado", "hurricane"], .fierce),
        (["storm", "thunder", "cyclone"], .gusty),
        (["wind", "gale", "breeze"], .alley),
    ]

    static func profile(forCourseID courseID: String) -> WindProfile {
        if let override = overrides[courseID] {
            return override
        }
        let lowered = courseID.lowercased()
        for rule in keywordRules {
            if rule.keywords.contains(where: { lowered.contains($0) }) {
                return rule.profile
            }
        }
        return .calm
    }
}
