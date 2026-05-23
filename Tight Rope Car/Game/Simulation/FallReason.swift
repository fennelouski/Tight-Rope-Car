//
//  FallReason.swift
//  Tight Rope Car
//

import Foundation

/// Why a run ended in failure (README: lateral offset or pitch stability).
enum FallReason: String, Codable, Sendable, Equatable {
    /// Center of mass left the rope (|lateral offset| > half rope width).
    case offRope
    /// Car pitch exceeded the course stability limit.
    case excessivePitch
}
