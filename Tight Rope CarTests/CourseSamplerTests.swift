//
//  CourseSamplerTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Testing
@testable import Tight_Rope_Car

struct CourseSamplerTests {
    private let epsilon = 1.0

    @Test func totalLengthIncreasesWithMoreWaypoints() {
        let short = CourseSampler(course: CourseCatalog.tutorial)
        let long = CourseSampler(course: CourseCatalog.longHaul)
        #expect(long.totalLength > short.totalLength)
    }

    @Test func sampleAtStartAndEndMatchWaypoints() {
        let course = CourseCatalog.tutorial
        let sampler = CourseSampler(course: course)
        let start = sampler.sample(at: 0)
        let end = sampler.sample(at: sampler.totalLength)

        #expect(abs(start.position.x - course.waypoints[0].position.x) < epsilon)
        #expect(abs(start.position.y - course.waypoints[0].position.y) < epsilon)
        #expect(abs(end.position.x - course.waypoints.last!.position.x) < epsilon)
        #expect(abs(end.position.y - course.waypoints.last!.position.y) < epsilon)
    }

    @Test func progressIsZeroAtStartAndOneAtFinish() {
        let sampler = CourseSampler(course: CourseCatalog.bumps)
        #expect(sampler.sample(at: 0).progress == 0)
        #expect(sampler.sample(at: sampler.totalLength).progress == 1)
    }

    @Test func isFinishedAtTotalLength() {
        let sampler = CourseSampler(course: CourseCatalog.tutorial)
        #expect(sampler.isFinished(s: sampler.totalLength))
        #expect(!sampler.isFinished(s: sampler.totalLength * 0.5))
    }

    @Test func bumpsMidCourseUsesBlueStyleSpan() {
        let course = CourseCatalog.bumps
        let sampler = CourseSampler(course: course)
        let midS = sampler.totalLength * 0.5
        let style = sampler.style(at: midS)
        #expect(style.ropeStroke == .electricBlue)
    }

    @Test func switchbacksFinishXDiffersFromStart() {
        let course = CourseCatalog.switchbacks
        let sampler = CourseSampler(course: course)
        let start = sampler.sample(at: 0)
        let end = sampler.sample(at: sampler.totalLength)
        #expect(end.position.x > start.position.x + 200)
    }

    @Test func catalogContainsNineteenDistinctCourses() {
        #expect(CourseCatalog.all.count == 19)
        let ids = Set(CourseCatalog.all.map(\.id))
        #expect(ids.contains("narrowWire"))
        #expect(ids.contains("bigDrop"))
        #expect(ids.contains("zigZag"))
        #expect(ids.contains("sunsetCruise"))
        #expect(ids.contains("ropeBridge"))
        #expect(ids.contains("windAlley"))
        #expect(ids.contains("summitClimb"))
        #expect(ids.contains("hairpins"))
        #expect(ids.contains("canyonGap"))
        #expect(ids.contains("checkerboard"))
        #expect(ids.contains("loopDeLoop"))
        #expect(ids.contains("tightropeWalk"))
        #expect(ids.contains("spiralDrift"))
        #expect(ids.contains("midnightRun"))
        #expect(ids.contains("rollerCoast"))
    }

    @Test(arguments: [
        CourseCatalog.narrowWire,
        CourseCatalog.bigDrop,
        CourseCatalog.zigZag,
        CourseCatalog.sunsetCruise,
        CourseCatalog.ropeBridge,
    ])
    func newCourseHasPositiveLengthAndEndpointSamples(course: Course) {
        let sampler = CourseSampler(course: course)
        #expect(sampler.totalLength > 0)

        let start = sampler.sample(at: 0)
        let end = sampler.sample(at: sampler.totalLength)
        #expect(abs(start.position.x - course.waypoints[0].position.x) < epsilon)
        #expect(abs(start.position.y - course.waypoints[0].position.y) < epsilon)
        #expect(abs(end.position.x - course.waypoints.last!.position.x) < epsilon)
        #expect(abs(end.position.y - course.waypoints.last!.position.y) < epsilon)
    }

    @Test func narrowWireMidCourseHasTightRopeWidth() {
        let sampler = CourseSampler(course: CourseCatalog.narrowWire)
        let mid = sampler.sample(at: sampler.totalLength * 0.5)
        #expect(mid.ropeWidth < 40)
    }

    @Test func bigDropMidCourseDipsBelowHorizon() {
        let sampler = CourseSampler(course: CourseCatalog.bigDrop)
        let dropSample = sampler.sample(at: sampler.totalLength * 0.68)
        #expect(dropSample.position.y < -40)
    }

    @Test func zigZagFinishXFarFromStart() {
        let sampler = CourseSampler(course: CourseCatalog.zigZag)
        let start = sampler.sample(at: 0)
        let end = sampler.sample(at: sampler.totalLength)
        #expect(end.position.x > start.position.x + 200)
    }

    @Test func sunsetCruiseUsesGraduatedSkySpans() {
        let course = CourseCatalog.sunsetCruise
        let gradients = course.styleSpans.compactMap(\.skyGradient)
        #expect(gradients.count >= 3)
        #expect(course.forwardSpeed < 100)
    }

    @Test func ropeBridgeSagDipsBelowChord() {
        let sampler = CourseSampler(course: CourseCatalog.ropeBridge)
        let sagSample = sampler.sample(at: sampler.totalLength * 0.58)
        #expect(sagSample.position.y < -30)
    }

    @Test func courseLookupById() {
        #expect(CourseCatalog.course(id: "tutorial")?.displayName == "First Steps")
        #expect(CourseCatalog.course(id: "missing") == nil)
    }

    @Test func longerCourseHasMoreWaypointsThanTutorial() {
        #expect(CourseCatalog.longHaul.waypoints.count > CourseCatalog.tutorial.waypoints.count)
    }

    // MARK: - Batch 2 courses

    @Test(arguments: [
        CourseCatalog.windAlley,
        CourseCatalog.summitClimb,
        CourseCatalog.hairpins,
        CourseCatalog.canyonGap,
        CourseCatalog.checkerboard,
    ])
    func batch2CourseHasPositiveLengthAndEndpointSamples(course: Course) {
        let sampler = CourseSampler(course: course)
        #expect(sampler.totalLength > 0)

        let start = sampler.sample(at: 0)
        let end = sampler.sample(at: sampler.totalLength)
        #expect(abs(start.position.x - course.waypoints[0].position.x) < epsilon)
        #expect(abs(start.position.y - course.waypoints[0].position.y) < epsilon)
        #expect(abs(end.position.x - course.waypoints.last!.position.x) < epsilon)
        #expect(abs(end.position.y - course.waypoints.last!.position.y) < epsilon)
    }

    @Test func windAlleyMidCourseUsesElectricBlueSpan() {
        let sampler = CourseSampler(course: CourseCatalog.windAlley)
        let style = sampler.style(at: sampler.totalLength * 0.5)
        #expect(style.ropeStroke == .electricBlue)
        #expect(CourseCatalog.windAlley.forwardSpeed >= 140)
    }

    @Test func summitClimbMidSampleIsHigherThanStart() {
        let sampler = CourseSampler(course: CourseCatalog.summitClimb)
        let start = sampler.sample(at: 0)
        let mid = sampler.sample(at: sampler.totalLength * 0.55)
        #expect(mid.position.y < start.position.y - 40)
    }

    @Test func hairpinsPathSwingsLeftAndRightOfStart() {
        let sampler = CourseSampler(course: CourseCatalog.hairpins)
        let sampleCount = 24
        var minX = Double.infinity
        var maxX = -Double.infinity
        for index in 0 ... sampleCount {
            let s = sampler.totalLength * Double(index) / Double(sampleCount)
            let x = sampler.sample(at: s).position.x
            minX = min(minX, x)
            maxX = max(maxX, x)
        }
        #expect(minX < -20)
        #expect(maxX > 20)
    }

    @Test func canyonGapSagDipsDeepBelowPlatforms() {
        let sampler = CourseSampler(course: CourseCatalog.canyonGap)
        let sampleCount = 20
        var minY = Double.infinity
        for index in 1 ..< sampleCount {
            let s = sampler.totalLength * Double(index) / Double(sampleCount)
            minY = min(minY, sampler.sample(at: s).position.y)
        }
        #expect(minY < -80)
    }

    @Test func checkerboardAlternatesStrokeColorsAlongPath() {
        let course = CourseCatalog.checkerboard
        let sampler = CourseSampler(course: course)
        let fractions = [0.09, 0.27, 0.45, 0.63, 0.81]
        let strokes = fractions.map { sampler.style(at: sampler.totalLength * $0).ropeStroke }
        let uniqueStrokeCount = strokes.reduce(into: [CourseColor]()) { acc, color in
            if !acc.contains(color) { acc.append(color) }
        }.count
        #expect(uniqueStrokeCount >= 4)
        #expect(course.styleSpans.count >= 5)
    }

    // MARK: - Batch 3 courses

    @Test(arguments: [
        CourseCatalog.loopDeLoop,
        CourseCatalog.tightropeWalk,
        CourseCatalog.spiralDrift,
        CourseCatalog.midnightRun,
        CourseCatalog.rollerCoast,
    ])
    func batch3CourseHasPositiveLengthAndEndpointSamples(course: Course) {
        let sampler = CourseSampler(course: course)
        #expect(sampler.totalLength > 0)

        let start = sampler.sample(at: 0)
        let end = sampler.sample(at: sampler.totalLength)
        #expect(abs(start.position.x - course.waypoints[0].position.x) < epsilon)
        #expect(abs(start.position.y - course.waypoints[0].position.y) < epsilon)
        #expect(abs(end.position.x - course.waypoints.last!.position.x) < epsilon)
        #expect(abs(end.position.y - course.waypoints.last!.position.y) < epsilon)
    }

    @Test func loopDeLoopMidCourseArcsAboveStart() {
        let sampler = CourseSampler(course: CourseCatalog.loopDeLoop)
        let start = sampler.sample(at: 0)
        let mid = sampler.sample(at: sampler.totalLength * 0.55)
        #expect(mid.position.y > start.position.y + 25)
    }

    @Test func tightropeWalkMidCourseHasTightRopeWidth() {
        let sampler = CourseSampler(course: CourseCatalog.tightropeWalk)
        let mid = sampler.sample(at: sampler.totalLength * 0.55)
        #expect(mid.ropeWidth < 40)
        #expect(sampler.totalLength >= 900)
        #expect(sampler.totalLength <= 1100)
    }

    @Test func spiralDriftPathSwingsLeftAndRightOfStart() {
        let sampler = CourseSampler(course: CourseCatalog.spiralDrift)
        let startX = sampler.sample(at: 0).position.x
        let sampleCount = 24
        var minX = Double.infinity
        var maxX = -Double.infinity
        for index in 0 ... sampleCount {
            let s = sampler.totalLength * Double(index) / Double(sampleCount)
            let x = sampler.sample(at: s).position.x
            minX = min(minX, x)
            maxX = max(maxX, x)
        }
        #expect(minX < startX - 15)
        #expect(maxX > startX + 15)
    }

    @Test func midnightRunUsesFastSpeedAndDarkSkySpans() {
        let course = CourseCatalog.midnightRun
        let gradients = course.styleSpans.compactMap(\.skyGradient)
        #expect(course.forwardSpeed >= 125)
        #expect(gradients.count >= 3)
    }

    @Test func rollerCoastHumpsDipBelowThreshold() {
        let sampler = CourseSampler(course: CourseCatalog.rollerCoast)
        let sampleCount = 32
        var minY = Double.infinity
        for index in 1 ..< sampleCount {
            let s = sampler.totalLength * Double(index) / Double(sampleCount)
            minY = min(minY, sampler.sample(at: s).position.y)
        }
        #expect(minY < -25)
    }
}
