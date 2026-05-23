//
//  BundledAudioLocator.swift
//  Tight Rope Car
//

import Foundation

/// Resolves clips under `Resources/Audio/` (or bundle root) by base name.
enum BundledAudioLocator {
    static func url(forResource name: String) -> URL? {
        for ext in ["caf", "wav", "m4a"] {
            if let url = Bundle.main.url(
                forResource: name,
                withExtension: ext,
                subdirectory: "Audio"
            ) {
                return url
            }
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                return url
            }
        }
        return nil
    }

    static func isAvailable(_ name: String) -> Bool {
        url(forResource: name) != nil
    }
}
