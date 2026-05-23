//
//  GameSFX.swift
//  Tight Rope Car
//

import Foundation

/// One-shot gameplay sounds (`Resources/Audio/{rawValue}.caf|wav|m4a`).
enum GameSFX: String, Sendable, CaseIterable {
    case fall = "fall_sting"
    case runSuccess = "run_success"
    case ticketPickup = "ticket_pickup"
}
