//
//  Tight_Rope_CarUITests.swift
//  Tight Rope CarUITests
//
//  Created by Nathan Fennel on 5/22/26.
//

import XCTest

final class Tight_Rope_CarUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    /// Navigates to the Create Profile sheet and verifies the color picker is present.
    @MainActor
    func testProfileColorPickerVisible() throws {
        let app = XCUIApplication()
        app.launch()

        // Tap PLAY on the landing screen (accessibilityLabel is "Play")
        let playButton = app.buttons["Play"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 5), "Play button should exist")
        playButton.tap()

        // Profile selection screen — tap + to create a profile
        let addButton = app.buttons["Add profile"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Add profile button should exist")
        addButton.tap()

        // Create Profile sheet — verify "Profile color" section header exists
        let colorHeader = app.staticTexts["Profile color"]
        XCTAssertTrue(colorHeader.waitForExistence(timeout: 5), "Profile color section should be visible")

        // Tap a color (Electric Blue is default/selected, tap Crimson at index 0)
        let crimson = app.buttons["Crimson"]
        XCTAssertTrue(crimson.waitForExistence(timeout: 3), "Crimson color button should exist")
        crimson.tap()

        // Verify color picker has 32 buttons total (all palette entries)
        let colorButtons = app.buttons.matching(NSPredicate(format: "label IN %@",
            ["Crimson","Hot Pink","Coral","Salmon","Flame","Orange","Amber","Yellow",
             "Lime","Emerald","Teal","Cyan","Sky","Electric","Royal","Navy",
             "Violet","Purple","Lavender","Magenta","Gold","Bronze","Silver","White",
             "Charcoal","Midnight","Forest","Maroon","Neon","Turquoise","Rose","Mint"]))
        XCTAssertEqual(colorButtons.count, 32, "Palette should have exactly 32 color buttons")
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
