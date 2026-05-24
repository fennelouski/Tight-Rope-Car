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

    /// Walks Landing → Profile (Pit Lane) → Car → Course screens and captures
    /// a screenshot at each step to verify full-bleed backgrounds and safe-area layout.
    @MainActor
    func testSafeAreaLayoutFlow() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(2)

        // ── Landing screen ──────────────────────────────────────────────────
        attach(app, name: "01_Landing")

        let playButton = app.buttons["Play"]
        XCTAssertTrue(playButton.waitForExistence(timeout: 6), "PLAY button must be visible")
        playButton.tap()
        sleep(2)

        // ── Pit Lane / Profile Selection ─────────────────────────────────────
        attach(app, name: "02_PitLane_ProfileSelection")

        // Create a profile so we can continue
        let addProfile = app.buttons["Add profile"]
        XCTAssertTrue(addProfile.waitForExistence(timeout: 5), "Add profile button must exist")
        addProfile.tap()
        sleep(1)

        attach(app, name: "03_CreateProfile_Sheet")

        // Fill in name and save
        let nameField = app.textFields.firstMatch
        XCTAssertTrue(nameField.waitForExistence(timeout: 5), "Name field must exist")
        nameField.tap()
        nameField.typeText("TestRacer")

        // Dismiss keyboard, then save
        if app.keyboards.buttons["Done"].exists { app.keyboards.buttons["Done"].tap() }
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 3), "Save button must exist")
        saveButton.tap()
        sleep(1)

        // Select the newly created profile (tap it)
        let racerButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'TestRacer'")).firstMatch
        if racerButton.exists { racerButton.tap(); sleep(1) }

        attach(app, name: "04_PitLane_ProfileSelected")

        // Continue to Garage
        let continueToGarage = app.buttons["Continue to garage"]
        XCTAssertTrue(continueToGarage.waitForExistence(timeout: 5), "Continue to garage must be visible")
        continueToGarage.tap()
        sleep(2)

        // ── Car Selection ────────────────────────────────────────────────────
        attach(app, name: "05_CarSelection")

        // Select the first car in the grid
        let firstCar = app.buttons.element(boundBy: 1)  // skip back button
        if firstCar.waitForExistence(timeout: 5) { firstCar.tap(); sleep(1) }

        let headToMap = app.buttons["Head to track map"]
        XCTAssertTrue(headToMap.waitForExistence(timeout: 5), "Head to track map must be visible")
        attach(app, name: "06_CarSelection_CarChosen")
        headToMap.tap()
        sleep(2)

        // ── Course Selection ─────────────────────────────────────────────────
        attach(app, name: "07_CourseSelection")

        let playTrack = app.buttons["Play track"]
        if playTrack.waitForExistence(timeout: 5) {
            attach(app, name: "08_CourseSelection_CourseChosen")
            playTrack.tap()
            sleep(3)

            // ── Gameplay (Calibration overlay) ───────────────────────────────
            attach(app, name: "09_Gameplay_Calibration")

            // Skip calibration if present
            let skipBtn = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Continue'")).firstMatch
            if skipBtn.waitForExistence(timeout: 4) { skipBtn.tap(); sleep(2) }

            attach(app, name: "10_Gameplay_Running")

            // Pause
            let pauseBtn = app.buttons["Pause"]
            if pauseBtn.waitForExistence(timeout: 3) {
                pauseBtn.tap()
                sleep(1)
                attach(app, name: "11_Gameplay_Paused")
            }
        }
    }

    private func tapIfExists(_ element: XCUIElement) {
        if element.exists { element.tap() }
    }

    private func attach(_ app: XCUIApplication, name: String) {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
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
