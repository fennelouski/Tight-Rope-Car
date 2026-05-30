//
//  GameScene.swift
//  Tight Rope Car
//

import QuartzCore
import SpriteKit
#if canImport(UIKit)
import UIKit
#endif

final class GameScene: SKScene {
    // Callbacks — set by GameSceneView before the scene is presented.
    var onTicketCollected: (Int) -> Void = { _ in }
    var onOutcome: (GameRunOutcome) -> Void = { _ in }
    var onBalanceUpdate: (Double) -> Void = { _ in }

    private let course: Course
    private let sampler: CourseSampler
    private let carAppearance: CarAppearance
    private let carTexture: SKTexture
    private let ticketTexture: SKTexture
    private let theme: BackgroundTheme

    // Game state
    private var progressS: Double = 0
    private var lateralOffset: Double = 0
    private var lateralVelocity: Double = 0
    private var tiltRadians: Double = 0
    private var elapsedSeconds: Double = 0
    private var collectedTicketIndices = Set<Int>()
    private var isGameOver = false
    private var lastUpdateTime: TimeInterval?
    private var lastNearFallCreakTime: TimeInterval = 0

    private let tiltProvider: TiltRollProviding
    private var tiltProcessor: TiltInputProcessor
    private var windSimulator: WindGustSimulator?
    var isTiltInputPaused = false
    var reduceMotion = false {
        didSet {
            tiltProcessor.reduceMotion = reduceMotion
            syncHapticsConfiguration()
        }
    }
    var onScreenBalanceActive = false {
        didSet { tiltProcessor.onScreenBalanceActive = onScreenBalanceActive }
    }

    // Nodes
    private var cameraNode: SKCameraNode!
    private var backgroundNode: GameBackgroundNode?
    private var ropeContainerNode: SKNode!
    private var carNode: CarSpriteNode!
    private var ticketNodes: [SKNode] = []
    private var obstacleNodes: [SKShapeNode] = []

    // Perspective layout constants (in camera/screen space, SpriteKit Y-up)
    private var horizonY: CGFloat { size.height * 0.10 }
    private var bottomCarY: CGFloat { -size.height * 0.26 }
    init(
        course: Course,
        carAppearance: CarAppearance,
        carTexture: SKTexture,
        ticketTexture: SKTexture,
        theme: BackgroundTheme,
        tiltProvider: TiltRollProviding? = nil,
        reduceMotion: Bool = false
    ) {
        self.course = course
        self.sampler = CourseSampler(course: course)
        self.carAppearance = carAppearance
        self.carTexture = carTexture
        self.ticketTexture = ticketTexture
        self.theme = theme
        self.tiltProvider = tiltProvider ?? TiltInputFactory.makeDefaultProvider()
        self.tiltProcessor = TiltInputProcessor(
            maxPitchRadians: course.maxPitchRadians,
            reduceMotion: reduceMotion
        )
        self.reduceMotion = reduceMotion
        if let windParameters = course.windProfile.parameters {
            self.windSimulator = WindGustSimulator(parameters: windParameters)
        }
        super.init(size: .zero)
        scaleMode = .resizeFill
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Scene lifecycle

    override func didMove(to view: SKView) {
        backgroundColor = .black
        buildScene()
        syncHapticsConfiguration()
        prepareHaptics()
    }

    func applyNeutralCalibration(_ neutralRoll: Double) {
        tiltProcessor.calibrateNeutral(using: neutralRoll)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        guard size.width > 0, size.height > 0, cameraNode != nil else { return }
        rebuildBackground()
    }

    // MARK: - Game loop

    override func update(_ currentTime: TimeInterval) {
        guard !isGameOver else { return }

        let dt: Double
        if let last = lastUpdateTime {
            dt = min(currentTime - last, GameBalanceConstants.maxSimulationDeltaTime)
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        guard dt > 0 else { return }

        elapsedSeconds += dt
        applyMotion(dt: dt)

        // Centrifugal drift: path curvature deflects the car outward.
        // Player must lean into the curve to stay on the rope.
        let curvature = sampler.curvature(at: progressS)
        lateralVelocity += -course.forwardSpeed * course.forwardSpeed
            * curvature * GameBalanceConstants.curvatureDriftStrength * dt

        progressS = min(progressS + course.forwardSpeed * dt, sampler.totalLength)
        lateralOffset += lateralVelocity * dt

        let sample = sampler.sample(at: progressS)
        updateVisuals(sample: sample)
        collectNearbyTickets()
        #if targetEnvironment(simulator)
        simulatorForceFall(sample: sample)
        #endif
        evaluateOutcome(sample: sample)
    }

    // MARK: - Build

    private func buildScene() {
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = .zero  // Camera is fixed; all nodes in camera space.

        rebuildBackground()

        // Rope and gameplay nodes live in camera space (= screen space with fixed camera).
        ropeContainerNode = SKNode()
        ropeContainerNode.zPosition = 10
        cameraNode.addChild(ropeContainerNode)

        carNode = CarSpriteNode(
            appearance: carAppearance,
            texture: carTexture,
            artboardSize: CarAppearanceTextureRenderer.rearViewArtboardSize,
            anchorPoint: CGPoint(x: 0.5, y: 0.5)
        )
        carNode.zPosition = 20
        cameraNode.addChild(carNode)

        buildTicketNodes()
        buildObstacleNodes()
    }

    private func rebuildBackground() {
        backgroundNode?.removeFromParent()
        guard size.width > 0, size.height > 0 else { return }
        let bg = GameBackgroundNode(theme: theme, layoutSize: size)
        bg.zPosition = -100
        cameraNode.addChild(bg)
        backgroundNode = bg
    }

    private func buildTicketNodes() {
        ticketNodes.forEach { $0.removeFromParent() }
        ticketNodes = []
        for _ in course.ticketFractions {
            let node = TicketPickupSKNode.make(texture: ticketTexture)
            node.zPosition = 15
            node.isHidden = true  // Shown when projected into view ahead.
            cameraNode.addChild(node)
            ticketNodes.append(node)
        }
    }

    private func buildObstacleNodes() {
        obstacleNodes.forEach { $0.removeFromParent() }
        obstacleNodes = []
        for _ in course.obstacles {
            let node = makeObstacleShape()
            node.zPosition = 16
            node.isHidden = true
            cameraNode.addChild(node)
            obstacleNodes.append(node)
        }
    }

    private func makeObstacleShape() -> SKShapeNode {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 7))
        path.addLine(to: CGPoint(x: -6, y: -7))
        path.addLine(to: CGPoint(x: 6, y: -7))
        path.closeSubpath()
        let node = SKShapeNode(path: path)
        node.fillColor = UIColor(red: 1.0, green: 0.45, blue: 0.0, alpha: 1.0)
        node.strokeColor = UIColor.white.withAlphaComponent(0.6)
        node.lineWidth = 1.0
        return node
    }

    private func updateObstaclePositions(horizonY: CGFloat, bottomY: CGFloat, ropeHalfWidth: Double) {
        for (i, obstacle) in course.obstacles.enumerated() {
            if let result = PerspectiveRopeRenderer.obstacleScreenPosition(
                sampler: sampler,
                progressS: progressS,
                obstacleFraction: obstacle.fraction,
                obstacleLateralOffset: obstacle.lateralOffset,
                ropeHalfWidth: ropeHalfWidth,
                sceneSize: size,
                horizonY: horizonY,
                bottomY: bottomY
            ) {
                obstacleNodes[i].position = result.position
                obstacleNodes[i].setScale(max(0.2, result.scale * 2.5))
                obstacleNodes[i].isHidden = false
            } else {
                obstacleNodes[i].isHidden = true
            }
        }
    }

    // MARK: - Physics & motion

    private func applyMotion(dt: Double) {
        let rawRoll = isTiltInputPaused ? nil : tiltProvider.latestRollRadians
        tiltProcessor.maxPitchRadians = course.maxPitchRadians
        tiltProcessor.acceptsDeviceInput = !isTiltInputPaused
        tiltProcessor.onScreenBalanceActive = onScreenBalanceActive
        tiltRadians = tiltProcessor.update(rawRoll: rawRoll, dt: dt)

        let windAcceleration = windLateralAcceleration(deltaTime: dt)
        GameRunPhysics.integrateLateral(
            tiltRadians: tiltRadians,
            lateralVelocity: &lateralVelocity,
            windLateralAcceleration: windAcceleration,
            dt: dt
        )
    }

    private func windLateralAcceleration(deltaTime dt: Double) -> Double {
        guard !isTiltInputPaused, var simulator = windSimulator else { return 0 }
        simulator.advance(by: dt)
        let acceleration = simulator.lateralAcceleration()
        windSimulator = simulator
        return acceleration
    }

    // MARK: - Visuals

    private func updateVisuals(sample: RopeSample) {
        let hz = horizonY
        let bcy = bottomCarY

        // Camera is fixed at (0,0). Car position is in screen/camera space.
        let ropeHalfWidth = GameBalanceConstants.ropeHalfWidth(at: sample.ropeWidth)
        let posScale = size.width / 2 * PerspectiveRopeRenderer.ropeScreenWidthFraction / CGFloat(ropeHalfWidth)

        carNode.position = CGPoint(
            x: CGFloat(lateralOffset) * posScale,
            y: bcy
        )
        // Lean only (no tangent angle — car always faces into the screen).
        carNode.zRotation = -CGFloat(tiltRadians)

        backgroundNode?.setForwardProgress(progressS)
        rebuildRopePath(sample: sample, horizonY: hz, bottomY: bcy, ropeHalfWidth: ropeHalfWidth)
        updateTicketPositions(horizonY: hz, bottomY: bcy, ropeHalfWidth: ropeHalfWidth)
        updateObstaclePositions(horizonY: hz, bottomY: bcy, ropeHalfWidth: ropeHalfWidth)
        let norm = BalanceStabilityEvaluator.normalizedLateralOffset(lateralOffset, ropeHalfWidth: ropeHalfWidth)
        onBalanceUpdate(norm)
    }

    private func rebuildRopePath(sample: RopeSample, horizonY: CGFloat, bottomY: CGFloat, ropeHalfWidth: Double) {
        _ = sample
        ropeContainerNode.removeAllChildren()
        let nodes = PerspectiveRopeRenderer.buildNodes(
            sampler: sampler,
            progressS: progressS,
            lateralOffset: lateralOffset,
            ropeHalfWidth: ropeHalfWidth,
            sceneSize: size,
            horizonY: horizonY,
            bottomY: bottomY
        )
        for node in nodes {
            ropeContainerNode.addChild(node)
        }
    }

    private func updateTicketPositions(horizonY: CGFloat, bottomY: CGFloat, ropeHalfWidth: Double) {
        for (index, fraction) in course.ticketFractions.enumerated() {
            guard !collectedTicketIndices.contains(index) else { continue }
            let ticketS = fraction * sampler.totalLength
            if let screenPos = PerspectiveRopeRenderer.ticketScreenPosition(
                sampler: sampler,
                progressS: progressS,
                ticketS: ticketS,
                ropeHalfWidth: ropeHalfWidth,
                sceneSize: size,
                horizonY: horizonY,
                bottomY: bottomY
            ) {
                ticketNodes[index].position = screenPos
                ticketNodes[index].isHidden = false
            } else {
                ticketNodes[index].isHidden = true
            }
        }
    }

    // MARK: - Tickets

    private func collectNearbyTickets() {
        for (index, fraction) in course.ticketFractions.enumerated() {
            guard !collectedTicketIndices.contains(index) else { continue }
            let ticketS = fraction * sampler.totalLength
            guard progressS + GameBalanceConstants.ticketCollectionLookaheadArcLength >= ticketS else { continue }
            collectedTicketIndices.insert(index)
            ticketNodes[index].isHidden = true
            onTicketCollected(collectedTicketIndices.count)
            playSFX(.ticketPickup, volume: 0.85)
        }
    }

    // MARK: - Outcome

    private func evaluateOutcome(sample: RopeSample) {
        let ropeHalfWidth = GameBalanceConstants.ropeHalfWidth(at: sample.ropeWidth)
        if let fallReason = BalanceStabilityEvaluator.fallReason(
            lateralOffset: lateralOffset,
            pitchRadians: tiltRadians,
            ropeHalfWidth: ropeHalfWidth,
            maxPitchRadians: course.maxPitchRadians
        ) {
            isGameOver = true
            playSFX(.fall)
            playFallHaptic(fallReason)
            let stats = GameRunStats(
                elapsedSeconds: elapsedSeconds,
                distanceMeters: sample.progress * sampler.totalLength,
                ticketsCollected: collectedTicketIndices.count
            )
            playFallAnimation(lateral: lateralOffset) { [weak self] in
                self?.onOutcome(.failure(stats))
            }
            return
        }

        // Obstacle collision
        for (i, obstacle) in course.obstacles.enumerated() {
            let obstacleS = obstacle.fraction * sampler.totalLength
            let arcDist = abs(obstacleS - progressS)
            guard arcDist <= GameBalanceConstants.obstacleCollisionArcLength else { continue }
            let lateralDiff = abs(lateralOffset - obstacle.lateralOffset)
            guard lateralDiff < GameBalanceConstants.obstacleCollisionLateralRadius else { continue }
            isGameOver = true
            obstacleNodes[i].isHidden = true
            playSFX(.fall)
            playFallHaptic(.offRope)
            let obstacleStats = GameRunStats(
                elapsedSeconds: elapsedSeconds,
                distanceMeters: sample.progress * sampler.totalLength,
                ticketsCollected: collectedTicketIndices.count
            )
            playFallAnimation(lateral: lateralOffset) { [weak self] in
                self?.onOutcome(.failure(obstacleStats))
            }
            return
        }

        let severity = BalanceStabilityEvaluator.instabilitySeverity(
            lateralOffset: lateralOffset,
            pitchRadians: tiltRadians,
            ropeHalfWidth: ropeHalfWidth,
            maxPitchRadians: course.maxPitchRadians
        )
        if BalanceStabilityEvaluator.isNearFall(severity: severity) {
            playNearFallHaptic()
            playNearFallRopeCreak()
        } else if severity >= GameBalanceConstants.nearFallEarlyWarningThreshold {
            playEarlyWarningHaptic()
        }

        if sampler.isFinished(s: progressS) {
            isGameOver = true
            playSFX(.runSuccess, volume: 0.9)
            let stats = GameRunStats(
                elapsedSeconds: elapsedSeconds,
                distanceMeters: sampler.totalLength,
                ticketsCollected: collectedTicketIndices.count
            )
            playWinAnimation { [weak self] in
                self?.onOutcome(.success(stats))
            }
        }
    }

    // MARK: - End animations

    private func playFallAnimation(lateral: Double, completion: @escaping () -> Void) {
        let dir = CGFloat(lateral >= 0 ? 1.0 : -1.0)
        let tumble = SKAction.group([
            SKAction.rotate(toAngle: dir * .pi * 0.55, duration: 0.5),
            SKAction.moveBy(x: dir * 90, y: -45, duration: 0.5),
            SKAction.scale(to: 0.45, duration: 0.5),
            SKAction.sequence([
                SKAction.wait(forDuration: 0.15),
                SKAction.fadeOut(withDuration: 0.35)
            ])
        ])
        carNode.run(SKAction.sequence([tumble, SKAction.wait(forDuration: 0.1), SKAction.run(completion)]))
    }

    private func playWinAnimation(completion: @escaping () -> Void) {
        let pulse = SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.15),
            SKAction.scale(to: 1.0, duration: 0.15)
        ])
        carNode.run(SKAction.sequence([pulse, SKAction.wait(forDuration: 0.2), SKAction.run(completion)]))
    }

    // MARK: - Helpers

    private func playSFX(_ sfx: GameSFX, volume: Float = 1) {
        Task { @MainActor in
            GameSFXPlayer.shared.play(sfx, volume: volume)
        }
    }

    private func prepareHaptics() {
        Task { @MainActor in
            GameplayHaptics.shared.prepare()
        }
    }

    private func syncHapticsConfiguration() {
        Task { @MainActor in
            GameplayHaptics.shared.respectsReduceMotion = reduceMotion
        }
    }

    private func playFallHaptic(_ reason: FallReason) {
        Task { @MainActor in
            GameplayHaptics.shared.playFall(reason)
        }
    }

    private func playNearFallHaptic() {
        Task { @MainActor in
            GameplayHaptics.shared.playNearFall()
        }
    }

    private func playEarlyWarningHaptic() {
        Task { @MainActor in
            GameplayHaptics.shared.playEarlyWarning()
        }
    }

    private func playNearFallRopeCreak() {
        let now = CACurrentMediaTime()
        guard now - lastNearFallCreakTime >= GameBalanceConstants.nearFallHapticCooldownSeconds else { return }
        lastNearFallCreakTime = now
        playSFX(.ropeCreak, volume: 0.62)
    }

    func resetNearFallCreakCooldown() {
        lastNearFallCreakTime = 0
    }

    #if targetEnvironment(simulator)
    private func simulatorForceFall(sample: RopeSample) {
        guard elapsedSeconds > 1.5, !isGameOver else { return }
        isGameOver = true
        playSFX(.fall)
        playFallHaptic(.offRope)
        let stats = GameRunStats(
            elapsedSeconds: elapsedSeconds,
            distanceMeters: sample.progress * sampler.totalLength,
            ticketsCollected: collectedTicketIndices.count
        )
        playFallAnimation(lateral: 1.0) { [weak self] in
            self?.onOutcome(.failure(stats))
        }
    }
    #endif
}
