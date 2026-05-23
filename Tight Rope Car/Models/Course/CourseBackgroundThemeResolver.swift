//
//  CourseBackgroundThemeResolver.swift
//  Tight Rope Car
//

import Foundation

/// Assigns a ``BackgroundTheme`` to catalog courses from ID keywords, explicit overrides, then a stable hash fallback.
enum CourseBackgroundThemeResolver {
    /// Hand-picked themes for iconic or tutorial courses (course `id` → theme).
    static let overrides: [String: BackgroundTheme] = [
        "tutorial": .garden,
        "jungleSwing": .forest,
        "rainForest": .forest,
        "bambooPath": .forest,
        "sandDunes": .beach,
        "desertDash": .beach,
        "desertCross": .beach,
        "tideRunner": .ocean,
        "lakesideLoop": .ocean,
        "sunkenShip": .ocean,
        "neonRush": .city,
        "neonGrid": .city,
        "pixelPath": .city,
        "pinballRun": .toyShop,
        "candyCane": .candyShop,
        "midnightRun": .bedroom,
        "moonWalk": .bedroom,
        "moonrise": .bedroom,
    ]

    /// Keyword fragments matched against lowercased course IDs (first match wins).
    private static let keywordRules: [(keywords: [String], theme: BackgroundTheme)] = [
        (["beach", "shore", "tide", "reef", "coast", "wave"], .beach),
        (["ocean", "aqua", "coral", "ship", "surf"], .ocean),
        (["jungle", "forest", "bamboo", "rain", "swamp", "garden", "vine"], .forest),
        (["city", "neon", "grid", "urban", "metro", "pixel"], .city),
        (["bedroom", "pillow", "plush", "moon", "night"], .bedroom),
        (["toy", "pinball", "playroom", "blocks"], .toyShop),
        (["candy", "sweet", "sugar", "gum"], .candyShop),
        (["desert", "sand", "dune", "canyon", "mesa"], .beach),
        (["ice", "frost", "arctic", "polar", "tundra", "glacier", "frozen", "snow"], .ocean),
        (["lava", "volcano", "magma", "inferno", "ember", "fire", "blaze"], .city),
        (["cosmic", "galaxy", "star", "solar", "comet", "nova", "orbit"], .city),
    ]

    /// Resolves the background theme for a course identifier.
    static func theme(forCourseID courseID: String) -> BackgroundTheme {
        if let override = overrides[courseID] {
            return override
        }
        let lowered = courseID.lowercased()
        for rule in keywordRules {
            if rule.keywords.contains(where: { lowered.contains($0) }) {
                return rule.theme
            }
        }
        return hashedTheme(forCourseID: courseID)
    }

    /// Stable distribution across all themes (matches legacy `previewTheme` behavior).
    static func hashedTheme(forCourseID courseID: String) -> BackgroundTheme {
        let themes = BackgroundTheme.allCases.sorted { $0.rawValue < $1.rawValue }
        guard !themes.isEmpty else { return .ocean }
        let index = abs(courseID.hashValue) % themes.count
        return themes[index]
    }
}
