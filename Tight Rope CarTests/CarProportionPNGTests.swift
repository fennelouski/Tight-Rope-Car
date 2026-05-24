//
//  CarProportionPNGTests.swift
//  Tight Rope CarTests
//
//  Generates after-state PNG exports of all 15 car designs for the proportion audit.
//  Run this test, then extract PNGs from the xcresult:
//    xcrun xcresulttool export --path <path.xcresult> --output-path ~/tmp/car-proportions/after --type directory
//

import XCTest
import SwiftUI
import UIKit
@testable import Tight_Rope_Car

@MainActor
class CarProportionPNGTests: XCTestCase {

    private let artboardSize = CGSize(width: 120, height: 60)
    private let renderScale: CGFloat = 3.0

    func test_generateAllCarPNGs() throws {
        for design in CarDesign.allCases {
            let data = try renderPNG(for: design)
            let attachment = XCTAttachment(data: data, uniformTypeIdentifier: "public.png")
            attachment.name = "\(design.rawValue).png"
            attachment.lifetime = .keepAlways
            add(attachment)
        }
        XCTAssertEqual(CarDesign.allCases.count, 15)
    }

    private func renderPNG(for design: CarDesign) throws -> Data {
        let car = design.makeCar()
        let view = CarView(car: car, size: artboardSize)
        let renderer = ImageRenderer(content: view)
        renderer.scale = renderScale
        renderer.isOpaque = false
        guard let uiImage = renderer.uiImage,
              let data = uiImage.pngData() else {
            XCTFail("ImageRenderer returned nil for \(design.displayName)")
            throw RenderError.renderFailed(design.displayName)
        }
        return data
    }

    enum RenderError: Error {
        case renderFailed(String)
    }
}
