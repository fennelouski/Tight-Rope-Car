//
//  LandingRopeCurveTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Foundation
import Testing
@testable import Tight_Rope_Car

struct LandingRopeCurveTests {
    private let curve = LandingRopeCurve()

    @Test func centerSagsBelowAnchors() {
        let sagAmount: CGFloat = 0
        let left = curve.point(at: 0, sagAmount: sagAmount)
        let center = curve.point(at: 0.5, sagAmount: sagAmount)
        let right = curve.point(at: 1, sagAmount: sagAmount)
        #expect(center.y > left.y)
        #expect(center.y > right.y)
    }

    @Test func tangentAnglesMatchSaggingRope() {
        let sagAmount: CGFloat = 0
        let leftAngle = curve.tangentAngle(at: 0, sagAmount: sagAmount)
        let centerAngle = curve.tangentAngle(at: 0.5, sagAmount: sagAmount)
        let rightAngle = curve.tangentAngle(at: 1, sagAmount: sagAmount)
        #expect(leftAngle > 0)
        #expect(rightAngle < 0)
        #expect(abs(centerAngle) < 0.05)
    }

    @Test func worldPositionCentersHorizontallyAtMidspan() {
        let world = curve.worldPosition(at: 0.5, sagAmount: 0)
        #expect(abs(world.x) < 0.01)
    }
}
