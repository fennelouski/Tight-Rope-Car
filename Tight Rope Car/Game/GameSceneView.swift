//
//  GameSceneView.swift
//  Tight Rope Car
//

import SpriteKit
import SwiftUI

/// SwiftUI host for the live SpriteKit game scene.
struct GameSceneView: View {
    let course: Course
    let carAppearance: CarAppearance
    let neutralRollOffset: Double
    var isPaused: Bool = false
    var reduceMotion: Bool = false
    var onScreenBalanceActive: Bool = false
    var onTicketCollected: (Int) -> Void = { _ in }
    var onOutcome: (GameRunOutcome) -> Void = { _ in }

    @State private var scene: GameScene

    init(
        course: Course,
        carAppearance: CarAppearance,
        tiltProvider: TiltRollProviding,
        neutralRollOffset: Double,
        isPaused: Bool = false,
        reduceMotion: Bool = false,
        onScreenBalanceActive: Bool = false,
        onTicketCollected: @escaping (Int) -> Void = { _ in },
        onOutcome: @escaping (GameRunOutcome) -> Void = { _ in }
    ) {
        self.course = course
        self.carAppearance = carAppearance
        self.neutralRollOffset = neutralRollOffset
        self.isPaused = isPaused
        self.reduceMotion = reduceMotion
        self.onScreenBalanceActive = onScreenBalanceActive
        self.onTicketCollected = onTicketCollected
        self.onOutcome = onOutcome

        let gameScene = GameScene(
            course: course,
            carAppearance: carAppearance,
            theme: course.backgroundTheme,
            tiltProvider: tiltProvider,
            reduceMotion: reduceMotion
        )
        gameScene.applyNeutralCalibration(neutralRollOffset)
        gameScene.onTicketCollected = onTicketCollected
        gameScene.onOutcome = onOutcome
        gameScene.isTiltInputPaused = isPaused
        gameScene.onScreenBalanceActive = onScreenBalanceActive
        _scene = State(initialValue: gameScene)
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .onChange(of: isPaused) { _, paused in
                scene.isPaused = paused
                scene.isTiltInputPaused = paused
            }
            .onChange(of: reduceMotion) { _, enabled in
                scene.reduceMotion = enabled
            }
            .onChange(of: onScreenBalanceActive) { _, active in
                scene.onScreenBalanceActive = active
            }
            .onChange(of: neutralRollOffset) { _, offset in
                scene.applyNeutralCalibration(offset)
            }
    }
}
