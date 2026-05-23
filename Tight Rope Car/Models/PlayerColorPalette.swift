//
//  PlayerColorPalette.swift
//  Tight Rope Car
//

import SwiftUI

/// The 32 selectable profile colors available to every player.
struct PlayerColorPalette {
    struct Entry: Identifiable {
        let id: Int
        let name: String
        let color: Color
    }

    // 32 entries — 8 columns × 4 rows in the picker grid.
    static let all: [Entry] = [
        // Reds / Pinks
        Entry(id:  0, name: "Crimson",   color: Color(red: 0.86, green: 0.08, blue: 0.24)),
        Entry(id:  1, name: "Hot Pink",  color: Color(red: 1.00, green: 0.08, blue: 0.58)),
        Entry(id:  2, name: "Coral",     color: Color(red: 1.00, green: 0.35, blue: 0.33)),
        Entry(id:  3, name: "Salmon",    color: Color(red: 0.98, green: 0.50, blue: 0.45)),
        // Oranges / Yellows
        Entry(id:  4, name: "Flame",     color: Color(red: 1.00, green: 0.40, blue: 0.00)),
        Entry(id:  5, name: "Orange",    color: Color(red: 1.00, green: 0.60, blue: 0.00)),
        Entry(id:  6, name: "Amber",     color: Color(red: 1.00, green: 0.75, blue: 0.00)),
        Entry(id:  7, name: "Yellow",    color: Color(red: 1.00, green: 0.90, blue: 0.00)),
        // Greens
        Entry(id:  8, name: "Lime",      color: Color(red: 0.50, green: 1.00, blue: 0.00)),
        Entry(id:  9, name: "Emerald",   color: Color(red: 0.00, green: 0.80, blue: 0.40)),
        Entry(id: 10, name: "Teal",      color: Color(red: 0.00, green: 0.70, blue: 0.60)),
        Entry(id: 11, name: "Cyan",      color: Color(red: 0.00, green: 0.90, blue: 0.90)),
        // Blues
        Entry(id: 12, name: "Sky",       color: Color(red: 0.20, green: 0.70, blue: 1.00)),
        Entry(id: 13, name: "Electric",  color: Color(red: 0.00, green: 0.40, blue: 1.00)),
        Entry(id: 14, name: "Royal",     color: Color(red: 0.10, green: 0.20, blue: 0.80)),
        Entry(id: 15, name: "Navy",      color: Color(red: 0.05, green: 0.10, blue: 0.50)),
        // Purples
        Entry(id: 16, name: "Violet",    color: Color(red: 0.50, green: 0.00, blue: 1.00)),
        Entry(id: 17, name: "Purple",    color: Color(red: 0.60, green: 0.10, blue: 0.80)),
        Entry(id: 18, name: "Lavender",  color: Color(red: 0.70, green: 0.50, blue: 1.00)),
        Entry(id: 19, name: "Magenta",   color: Color(red: 0.90, green: 0.00, blue: 0.70)),
        // Metallic
        Entry(id: 20, name: "Gold",      color: Color(red: 1.00, green: 0.82, blue: 0.00)),
        Entry(id: 21, name: "Bronze",    color: Color(red: 0.80, green: 0.50, blue: 0.20)),
        Entry(id: 22, name: "Silver",    color: Color(red: 0.75, green: 0.75, blue: 0.80)),
        Entry(id: 23, name: "White",     color: Color(red: 1.00, green: 1.00, blue: 1.00)),
        // Dark
        Entry(id: 24, name: "Charcoal",  color: Color(red: 0.30, green: 0.30, blue: 0.35)),
        Entry(id: 25, name: "Midnight",  color: Color(red: 0.05, green: 0.05, blue: 0.20)),
        Entry(id: 26, name: "Forest",    color: Color(red: 0.10, green: 0.40, blue: 0.15)),
        Entry(id: 27, name: "Maroon",    color: Color(red: 0.50, green: 0.05, blue: 0.10)),
        // Vibrant / Neon
        Entry(id: 28, name: "Neon",      color: Color(red: 0.10, green: 1.00, blue: 0.10)),
        Entry(id: 29, name: "Turquoise", color: Color(red: 0.00, green: 0.90, blue: 0.70)),
        Entry(id: 30, name: "Rose",      color: Color(red: 1.00, green: 0.40, blue: 0.70)),
        Entry(id: 31, name: "Mint",      color: Color(red: 0.50, green: 1.00, blue: 0.75)),
    ]

    static func color(at index: Int) -> Color {
        let clamped = max(0, min(index, all.count - 1))
        return all[clamped].color
    }
}
