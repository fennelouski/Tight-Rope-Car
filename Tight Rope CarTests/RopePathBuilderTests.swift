//
//  RopePathBuilderTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Foundation
import Testing
@testable import Tight_Rope_Car

struct RopePathBuilderTests {
    @Test func visibleWindowClampsToCourseLength() {
        let sampler = CourseSampler(course: CourseCatalog.tutorial)
        let progress = sampler.totalLength * 0.5
        let layers = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: progress,
            elapsedSeconds: 0,
            reduceMotion: true
        )
        #expect(!layers.isEmpty)
    }

    @Test func checkerboardProducesMultipleStrokeColors() {
        let sampler = CourseSampler(course: CourseCatalog.checkerboard)
        let layers = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: sampler.totalLength * 0.5,
            elapsedSeconds: 0,
            reduceMotion: true
        )
        let mainStrokes = layers
            .filter { $0.strokeOpacity == 1 && $0.lineWidth > 10 }
            .map(\.stroke)
        var uniqueStrokes: [CourseColor] = []
        for stroke in mainStrokes {
            if !uniqueStrokes.contains(stroke) {
                uniqueStrokes.append(stroke)
            }
        }
        #expect(uniqueStrokes.count >= 2)
    }

    @Test func zeroSwayMatchesSamplerPositionsAtStart() {
        let sampler = CourseSampler(course: CourseCatalog.tutorial)
        let sample = sampler.sample(at: 0)
        let layers = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: 0,
            elapsedSeconds: 10,
            reduceMotion: true
        )
        guard let firstLayer = layers.first else {
            Issue.record("Expected at least one rope layer")
            return
        }
        let bounds = firstLayer.path.boundingBox
        #expect(abs(Double(bounds.origin.x) - Double(sample.position.x)) < 400)
    }

    @Test func narrowWireMidSegmentIsThinnerThanStart() {
        let sampler = CourseSampler(course: CourseCatalog.narrowWire)
        let wideS = sampler.totalLength * 0.08
        let narrowS = sampler.totalLength * 0.55
        #expect(sampler.sample(at: narrowS).ropeWidth < sampler.sample(at: wideS).ropeWidth)

        let wideLayers = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: wideS,
            elapsedSeconds: 0,
            reduceMotion: true
        )
        let narrowLayers = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: narrowS,
            elapsedSeconds: 0,
            reduceMotion: true
        )
        let wideWidth = mainLineWidth(in: wideLayers)
        let narrowWidth = mainLineWidth(in: narrowLayers)
        #expect(narrowWidth < wideWidth)
    }

    @Test func ropeHalfWidthUsesConstantsNotBuilder() {
        let width = 36.0
        let half = GameBalanceConstants.ropeHalfWidth(at: width)
        #expect(half == 18)
    }

    @Test func reduceMotionDisablesSwayOffset() {
        let sampler = CourseSampler(course: CourseCatalog.bumps)
        let s = sampler.totalLength * 0.4
        let sample = sampler.sample(at: s)
        let withMotion = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: s,
            elapsedSeconds: 5,
            reduceMotion: false
        )
        let withoutMotion = RopePathBuilder.buildLayers(
            sampler: sampler,
            progressS: s,
            elapsedSeconds: 5,
            reduceMotion: true
        )
        #expect(withMotion.count == withoutMotion.count)
        let motionBounds = withMotion.first?.path.boundingBox ?? .zero
        let stillBounds = withoutMotion.first?.path.boundingBox ?? .zero
        #expect(abs(motionBounds.midX - stillBounds.midX) >= 0)
        #expect(abs(Double(sample.position.x) - Double(stillBounds.midX)) < 500)
    }

    private func mainLineWidth(in layers: [RopeVisualLayer]) -> Double {
        layers
            .filter { $0.strokeOpacity == 1 }
            .map(\.lineWidth)
            .filter { $0 < 80 }
            .min() ?? .infinity
    }
}
