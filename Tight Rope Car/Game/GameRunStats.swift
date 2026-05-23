//
//  GameRunStats.swift
//  Tight Rope Car
//

import Foundation

struct GameRunStats: Equatable {
    var elapsedSeconds: Double
    var distanceMeters: Double
    var ticketsCollected: Int
}

enum GameRunOutcome: Equatable {
    case success(GameRunStats)
    case failure(GameRunStats)

    var stats: GameRunStats {
        switch self {
        case .success(let stats), .failure(let stats):
            return stats
        }
    }

    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
}
