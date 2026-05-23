//
//  BalanceStabilityEvaluatorTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct BalanceStabilityEvaluatorTests {

    @Test func centeredCarOnRopeIsStable() {
        let reason = BalanceStabilityEvaluator.fallReason(
            lateralOffset: 0,
            pitchRadians: 0,
            ropeHalfWidth: 24,
            maxPitchRadians: .pi / 4
        )
        #expect(reason == nil)
    }

    @Test func lateralOffsetBeyondHalfWidthFallsOffRope() {
        let half = GameBalanceConstants.ropeHalfWidth(at: 48)
        #expect(BalanceStabilityEvaluator.isOffRope(lateralOffset: half + 0.01, ropeHalfWidth: half))
        #expect(!BalanceStabilityEvaluator.isOffRope(lateralOffset: half, ropeHalfWidth: half))
        #expect(
            BalanceStabilityEvaluator.fallReason(
                lateralOffset: half + 0.01,
                pitchRadians: 0,
                ropeHalfWidth: half,
                maxPitchRadians: .pi / 4
            ) == .offRope
        )
    }

    @Test func pitchAtCourseLimitFalls() {
        let maxPitch = CourseCatalog.tutorial.maxPitchRadians
        #expect(
            BalanceStabilityEvaluator.fallReason(
                lateralOffset: 0,
                pitchRadians: maxPitch,
                ropeHalfWidth: 26,
                maxPitchRadians: maxPitch
            ) == .excessivePitch
        )
        #expect(
            BalanceStabilityEvaluator.fallReason(
                lateralOffset: 0,
                pitchRadians: maxPitch - 0.01,
                ropeHalfWidth: 26,
                maxPitchRadians: maxPitch
            ) == nil
        )
    }

    @Test func offRopeTakesPriorityOverPitch() {
        let reason = BalanceStabilityEvaluator.fallReason(
            lateralOffset: 50,
            pitchRadians: .pi,
            ropeHalfWidth: 24,
            maxPitchRadians: .pi / 6
        )
        #expect(reason == .offRope)
    }

    @Test func samplerProvidesRopeWidthAlongCourse() throws {
        let course = try #require(CourseCatalog.course(id: "narrowWire"))
        let sampler = CourseSampler(course: course)
        let start = sampler.sample(at: 0)
        let midS = sampler.totalLength * 0.5
        let mid = sampler.sample(at: midS)
        let half = GameBalanceConstants.ropeHalfWidth(at: mid.ropeWidth)

        #expect(start.ropeWidth == 48)
        #expect(mid.ropeWidth < 40)

        let stable = BalanceStabilityEvaluator.fallReason(
            lateralOffset: half - 0.01,
            pitchRadians: 0,
            arcLength: midS,
            course: course,
            sampler: sampler
        )
        #expect(stable == nil)

        let fallen = BalanceStabilityEvaluator.fallReason(
            lateralOffset: half + 0.01,
            pitchRadians: 0,
            arcLength: midS,
            course: course,
            sampler: sampler
        )
        #expect(fallen == .offRope)
    }

    @Test func normalizedLateralOffsetClampsToUnitInterval() {
        let n = BalanceStabilityEvaluator.normalizedLateralOffset(80, ropeHalfWidth: 24)
        #expect(n == 1)
        #expect(BalanceStabilityEvaluator.normalizedLateralOffset(-12, ropeHalfWidth: 24) == -0.5)
    }

    @Test func gameBalanceConstantsMatchREADMEStabilityRule() {
        let ropeWidth = 48.0
        let half = GameBalanceConstants.ropeHalfWidth(at: ropeWidth)
        #expect(half == ropeWidth / 2)
        #expect(GameBalanceConstants.lateralFallThresholdOfHalfWidth == 1.0)
    }

    @Test func nearFallUsesInstabilitySeverityBand() {
        let half = 24.0
        let maxPitch = Double.pi / 4
        let safeSeverity = BalanceStabilityEvaluator.instabilitySeverity(
            lateralOffset: half * 0.5,
            pitchRadians: 0,
            ropeHalfWidth: half,
            maxPitchRadians: maxPitch
        )
        #expect(safeSeverity == 0.5)
        #expect(!BalanceStabilityEvaluator.isNearFall(severity: safeSeverity))

        let warnSeverity = BalanceStabilityEvaluator.instabilitySeverity(
            lateralOffset: half * 0.85,
            pitchRadians: 0,
            ropeHalfWidth: half,
            maxPitchRadians: maxPitch
        )
        #expect(BalanceStabilityEvaluator.isNearFall(severity: warnSeverity))
        #expect(
            BalanceStabilityEvaluator.fallReason(
                lateralOffset: half * 0.85,
                pitchRadians: 0,
                ropeHalfWidth: half,
                maxPitchRadians: maxPitch
            ) == nil
        )

        let fallSeverity = BalanceStabilityEvaluator.instabilitySeverity(
            lateralOffset: half + 1,
            pitchRadians: 0,
            ropeHalfWidth: half,
            maxPitchRadians: maxPitch
        )
        #expect(fallSeverity > 1)
        #expect(!BalanceStabilityEvaluator.isNearFall(severity: fallSeverity))
    }
}
