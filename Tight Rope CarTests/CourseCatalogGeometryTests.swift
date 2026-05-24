//
//  CourseCatalogGeometryTests.swift
//  Tight Rope CarTests
//

import CoreGraphics
import Testing
@testable import Tight_Rope_Car

struct CourseCatalogGeometryTests {

    @Test func testMonotonicX() {
        for course in CourseCatalog.all {
            for i in 0 ..< course.waypoints.count - 1 {
                let cx = Double(course.waypoints[i].position.x)
                let nx = Double(course.waypoints[i + 1].position.x)
                #expect(nx > cx,
                    "\(course.id): waypoint[\(i + 1)].x \(nx) <= waypoint[\(i)].x \(cx)")
            }
        }
    }

    @Test func testMaxSegmentAngle() {
        let maxAngle = 52.0 * Double.pi / 180.0
        for course in CourseCatalog.all {
            for i in 0 ..< course.waypoints.count - 1 {
                let a = course.waypoints[i].position
                let b = course.waypoints[i + 1].position
                let dx = Double(b.x - a.x)
                let dy = Double(b.y - a.y)
                let angle = atan2(abs(dy), dx)
                #expect(angle <= maxAngle,
                    "\(course.id): segment[\(i)] angle \(angle * 180 / .pi)deg > 52deg")
            }
        }
    }

    @Test func testMinArcLength() {
        for course in CourseCatalog.all {
            let length = CourseSampler(course: course).totalLength
            #expect(length >= 380,
                "\(course.id): totalLength \(length) < 380")
        }
    }

    @Test func testLateralRangeByTier() {
        for course in CourseCatalog.all {
            let absYs = course.waypoints.map { abs(Double($0.position.y)) }
            if course.unlockOrder <= 14 {
                for (i, absY) in absYs.enumerated() {
                    #expect(absY <= 45.0,
                        "\(course.id) [beginner]: waypoint[\(i)] abs(y)=\(absY) > 45")
                }
            } else if course.unlockOrder <= 59 {
                #expect(absYs.contains { $0 >= 55.0 },
                    "\(course.id) [intermediate]: no waypoint with abs(y) >= 55")
            } else {
                #expect(absYs.contains { $0 >= 95.0 },
                    "\(course.id) [advanced]: no waypoint with abs(y) >= 95")
            }
        }
    }

    @Test func testStyleSpanCoverage() {
        for course in CourseCatalog.all {
            let sampler = CourseSampler(course: course)
            let spans = course.styleSpans
            guard let first = spans.first, let last = spans.last else {
                Issue.record("\(course.id): no style spans")
                continue
            }
            #expect(first.startS == 0.0,
                "\(course.id): first span startS=\(first.startS) != 0")
            #expect(abs(last.endS - sampler.totalLength) < 0.01,
                "\(course.id): last span endS=\(last.endS) != totalLength=\(sampler.totalLength)")
            for i in 0 ..< spans.count - 1 {
                #expect(abs(spans[i].endS - spans[i + 1].startS) < 0.01,
                    "\(course.id): span[\(i)].endS != span[\(i + 1)].startS")
            }
        }
    }
}
