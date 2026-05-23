//
//  WindGustSimulatorTests.swift
//  Tight Rope CarTests
//

import Foundation
import Testing
@testable import Tight_Rope_Car

struct WindGustSimulatorTests {

    @Test func calmProfileProducesNoParameters() {
        #expect(WindProfile.calm.parameters == nil)
        #expect(CourseWindResolver.profile(forCourseID: "tutorial") == .calm)
    }

    @Test func windAlleyCourseUsesAlleyPreset() {
        let course = CourseCatalog.windAlley
        #expect(course.windProfile == .alley)
        #expect(course.windProfile.parameters != nil)
    }

    @Test func simulatorAccelerationIsBounded() throws {
        let params = try #require(WindProfile.alley.parameters)
        var simulator = WindGustSimulator(parameters: params)
        var maxObserved = 0.0
        let dt = 1.0 / 60.0
        for _ in 0 ..< 600 {
            simulator.advance(by: dt)
            maxObserved = max(maxObserved, abs(simulator.lateralAcceleration()))
        }
        #expect(maxObserved <= simulator.peakAccelerationMagnitude + 1)
        #expect(maxObserved > 0)
    }

    @Test func windForceVariesOverTime() {
        let params = WindParameters(
            steadyAmplitude: 10,
            gustAmplitude: 20,
            basePeriodSeconds: 2,
            gustHarmonic: 2
        )
        var simulator = WindGustSimulator(parameters: params)
        simulator.advance(by: 0.5)
        let first = simulator.lateralAcceleration()
        simulator.advance(by: 1.0)
        let second = simulator.lateralAcceleration()
        #expect(first != second)
    }

    @Test func courseEncodesWindProfileRawValue() throws {
        let course = try #require(CourseCatalog.course(id: "windAlley"))
        let data = try JSONEncoder().encode(course)
        let json = try #require(String(data: data, encoding: .utf8))
        #expect(json.contains("windProfile"))
        #expect(json.contains(WindProfile.alley.rawValue))

        let decoded = try JSONDecoder().decode(Course.self, from: data)
        #expect(decoded.windProfile == course.windProfile)
    }

    @Test func fierceWindKeywordCoursesResolveStrongPreset() {
        #expect(CourseCatalog.fierceWind.windProfile == .fierce)
        #expect(CourseWindResolver.profile(forCourseID: "tornadoAlley") == .fierce)
    }
}
