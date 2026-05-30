//
//  CourseObstacle.swift
//  Tight Rope Car
//

import Foundation

/// A static obstacle placed on the rope at a specific arc-length position and lateral offset.
/// The player must steer to the opposite side to avoid it.
struct CourseObstacle: Codable, Sendable, Equatable {
    /// Arc-length fraction [0, 1] where the obstacle sits on the rope.
    let fraction: Double
    /// Lateral offset from the rope center in world units (+right, −left).
    /// Should stay within ±(ropeHalfWidth * 0.6) so a clear path exists on the other side.
    let lateralOffset: Double
}
