//
//  GameScene.swift
//  Tight Rope Car
//

import SpriteKit
#if canImport(UIKit)
import UIKit
#endif

final class GameScene: SKScene {
    // Callbacks — set by GameSceneView before the scene is presented.
    var onTicketCollected: (Int) -> Void = { _ in }
    var onOutcome: (GameRunOutcome) -> Void = { _ in }

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

    private let tiltProvider: TiltRollProviding
    private var tiltProcessor: TiltInputProcessor
    private var windSimulator: WindGustSimulator?
    /// When true, device roll is ignored (pause / menu); filtered tilt decays toward level.
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
    private var ropeNode: SKShapeNode!
    private var carNode: CarSpriteNode!
    private var ticketNodes: [SKNode] = []

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

    /// Applies run-start neutral calibration (see ``GameplayTiltSession``).
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
            dt = min(currentTime - last, 1.0 / 30.0)
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        guard dt > 0 else { return }

        elapsedSeconds += dt
        applyMotion(dt: dt)
        progressS = min(progressS + course.forwardSpeed * dt, sampler.totalLength)
        lateralOffset += lateralVelocity * dt

        let sample = sampler.sample(at: progressS)
        updateVisuals(sample: sample)
        collectNearbyTickets()
        evaluateOutcome(sample: sample)
    }

    // MARK: - Build

    private func buildScene() {
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        camera = cameraNode

        rebuildBackground()

        ropeNode = SKShapeNode()
        ropeNode.lineCap = .round
        ropeNode.lineJoin = .round
        ropeNode.zPosition = 10
        addChild(ropeNode)

        carNode = CarSpriteNode(appearance: carAppearance, texture: carTexture)
        carNode.zPosition = 20
        cameraNode.addChild(carNode)

        buildTicketNodes()
        cameraNode.position = sampler.sample(at: 0).position
    }

    private func rebuildBackground() {
        backgroundNode?.removeFromParent()
        guard size.width > 0, size.height > 0 else { return }
        let bg = GameBackgroundNode(theme: theme, layoutSize: size)
        bg.zPosition = -100
        cameraNode.addChild(bg)
        backgroundNode = bg
        backgroundNode?.setCameraX(sampler.sample(at: progressS).position.x)
    }

    private func buildTicketNodes() {
        ticketNodes.forEach { $0.removeFromParent() }
        ticketNodes = []
        for fraction in course.ticketFractions {
            let pt = sampler.sample(at: fraction * sampler.totalLength).position
            let node = TicketPickupSKNode.make(texture: ticketTexture)
            node.position = pt
            node.zPosition = 15
            addChild(node)
            ticketNodes.append(node)
        }
    }

    // MARK: - Physics & motion

    private func applyMotion(dt: Double) {
        let rawRoll = isTiltInputPaused ? nil : tiltProvider.latestRollRadians
        tiltProcessor.maxPitchRadians = course.maxPitchRadians
        tiltProcessor.acceptsDeviceInput = !isTiltInputPaused
        tiltProcessor.onScreenBalanceActive = onScreenBalanceActive
        tiltRadians = tiltProcessor.update(rawRoll: rawRoll, dt: dt)

        lateralVelocity += tiltRadians * GameBalanceConstants.lateralAccelerationFromTilt * dt
        applyWind(deltaTime: dt)
        lateralVelocity *= pow(
            GameBalanceConstants.lateralVelocityDampingPerFrame,
            dt * GameBalanceConstants.tiltInputNominalHz
        )
    }

    private func applyWind(deltaTime dt: Double) {
        guard !isTiltInputPaused, var simulator = windSimulator else { return }
        simulator.advance(by: dt)
        lateralVelocity += simulator.lateralAcceleration() * dt
        windSimulator = simulator
    }

    // MARK: - Visuals

    private func updateVisuals(sample: RopeSample) {
        // Camera sits at rope center; car drifts in camera space perpendicular to rope
        cameraNode.position = sample.position

        carNode.position = CGPoint(
            x: CGFloat(lateralOffset) * sample.normal.dx,
            y: CGFloat(lateralOffset) * sample.normal.dy
        )
        carNode.zRotation = sample.tangentAngle + CGFloat(tiltRadians)

        backgroundNode?.setCameraX(sample.position.x)
        rebuildRopePath(sample: sample)
    }

    private func rebuildRopePath(sample: RopeSample) {
        let startS = max(0, progressS - 300)
        let endS   = min(sampler.totalLength, progressS + 700)
        guard endS > startS else { return }

        let stepCount = 60
        let step = (endS - startS) / Double(stepCount)
        let path = CGMutablePath()
        for i in 0 ... stepCount {
            let pt = sampler.sample(at: startS + Double(i) * step).position
            if i == 0 { path.move(to: pt) } else { path.addLine(to: pt) }
        }

        ropeNode.path        = path
        ropeNode.lineWidth   = CGFloat(sample.ropeWidth)
        ropeNode.strokeColor = skColor(sample.style.ropeStroke)
    }

    // MARK: - Tickets

    private func collectNearbyTickets() {
        for (index, fraction) in course.ticketFractions.enumerated() {
            guard !collectedTicketIndices.contains(index) else { continue }
            let ticketS = fraction * sampler.totalLength
            guard progressS + 25 >= ticketS else { continue }
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
            onOutcome(.failure(GameRunStats(
                elapsedSeconds: elapsedSeconds,
                distanceMeters: sample.progress * sampler.totalLength,
                ticketsCollected: collectedTicketIndices.count
            )))
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
        }

        if sampler.isFinished(s: progressS) {
            isGameOver = true
            playSFX(.runSuccess, volume: 0.9)
            onOutcome(.success(GameRunStats(
                elapsedSeconds: elapsedSeconds,
                distanceMeters: sampler.totalLength,
                ticketsCollected: collectedTicketIndices.count
            )))
        }
    }

    // MARK: - Helpers

    private func skColor(_ c: CourseColor) -> SKColor {
        SKColor(red: CGFloat(c.red), green: CGFloat(c.green), blue: CGFloat(c.blue), alpha: CGFloat(c.alpha))
    }

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
}
