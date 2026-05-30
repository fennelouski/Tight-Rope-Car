//
//  CourseCatalog.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

enum CourseCatalog {
    static let all: [Course] = [
        tutorial,
        bumps,
        switchbacks,
        longHaul,
        narrowWire,
        bigDrop,
        zigZag,
        sunsetCruise,
        ropeBridge,
        windAlley,
        summitClimb,
        hairpins,
        canyonGap,
        checkerboard,
        loopDeLoop,
        tightropeWalk,
        spiralDrift,
        midnightRun,
        rollerCoast,
        desertDash,
        iceShelf,
        pendulumSwing,
        launchPad,
        whisperCanyon,
        // Batch 5
        rainbowRoad,
        wobblyBridge,
        sCurve,
        steepHill,
        mountainPass,
        // Batch 6
        gentleMeander,
        skyDance,
        canyonDive,
        plateauRun,
        lakesideLoop,
        // Batch 7
        gravityDrop,
        twinPeaks,
        spiralGalaxy,
        staircase,
        boomerang,
        // Batch 8
        pogoBounce,
        stormSurge,
        monkeyBars,
        slipSlide,
        speedBumps,
        // Batch 9
        corkscrew,
        highWire,
        rippleRun,
        dragonBack,
        spiralHill,
        // Batch 10
        waveRunner,
        cliffhanger,
        zigzagCanyon,
        thrillRide,
        breakaway,
        // Batch 11
        avalanche,
        thunderPass,
        cannonball,
        whiplash,
        moonrise,
        // Batch 12
        rocketLaunch,
        freeFall,
        rollerStorm,
        tripleDecker,
        galaxyExpress,
        // Batch 13
        neonRush,
        jungleSwing,
        icePath,
        tornadoAlley,
        stormChaser,
        // Batch 14
        fireWalk,
        crystalBridge,
        sandDunes,
        skyHook,
        mudSlide,
        // Batch 15
        volcanoPeak,
        frozenLake,
        desertCross,
        cloudSurfer,
        tideRunner,
        // Batch 16
        pinballRun,
        bambooPath,
        magmaFlow,
        arcticWind,
        thunderBolt,
        // Batch 17
        sunkenShip,
        glassWalk,
        dustDevil,
        rainForest,
        stoneBridge,
        // Batch 18
        spiderWeb,
        moonWalk,
        lavaRidge,
        frostBite,
        canyonWind,
        // Batch 19
        neonGrid,
        peakDive,
        coralReef,
        ironGate,
        swingLow,
        // Batch 20
        blazeTrail,
        silverStream,
        obsidianWay,
        prismPath,
        wildWest,
        // Batch 21
        phantomRoad,
        reedSwamp,
        crystalCave,
        jetStream,
        emberPath,
        // Batch 22
        shadowRun,
        comet,
        glacierGap,
        boulderPass,
        typhoonTrack,
        // Batch 23
        starfall,
        mudBog,
        diamondDust,
        infernoRun,
        tundraGlide,
        // Batch 24
        supernova,
        ashField,
        polarVortex,
        abyssWalk,
        fierceWind,
        // Batch 25 — Final 4 (reaches 128 total)
        grandFinale,
        eternityBridge,
        legendsRun,
        ultimateWire,
        // Batch 26
        sunnyMeadow,
        cloudWalk,
        bubblePop,
        rainbowBridge,
        starLane,
        // Batch 27
        pebblePath,
        zipLine,
        sandCastle,
        jellyRoad,
        cactusPass,
        // Batch 28
        mushroom,
        tidePool,
        snowDrift,
        cloverField,
        marbleRun,
        // Batch 29
        candyCane,
        forestLog,
        iceRink,
        lemonDrop,
        skySlide,
        // Batch 30
        rocketRide,
        butterflyPath,
        lavaLamp,
        tunnelRush,
        penguin,
        // Batch 31
        beanBounce,
        moonRiver,
        volcanoDash,
        kiteRun,
        glowWorm,
        // Batch 32
        cocoaRun,
        swampHop,
        crystalStream,
        hauntedPath,
        sugarRush,
        // Batch 33
        foggyMoor,
        pinwheelPark,
        archipelago,
        springCoil,
        auroraBend,
        // Batch 34
        tumbleweed,
        prairieWind,
        cobblestone,
        fireFly,
        deepSea,
        // Batch 35
        gemMine,
        torchRace,
        mountainGoat,
        oceanBreeze,
        sparkTrail,
        // Batch 36
        thunderCloud,
        goldenGate,
        boulderField,
        velvetRoad,
        magneticPole,
        // Batch 37
        pixelPath,
        noodleRoad,
        highTide,
        solarWind,
        ironBridge,
        // Batch 38
        crystalMaze,
        cosmicDrift,
        vortexRoad,
        horizonPath,
        stormBolt,
        // Batch 39
        lightningRun,
        silkRoad,
        frostWave,
        dawnRider,
        emberGlow,
        // Batch 40 — Final
        grandVista,
        apexRun,
    ].sorted { $0.unlockOrder < $1.unlockOrder }

    static func course(id: String) -> Course? {
        all.first { $0.id == id }
    }

    // MARK: - Levels

    static let tutorial = makeCourse(
        id: "tutorial",
        displayName: "First Steps",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 380, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 300, y: 14))
            ),
            CourseWaypoint(position: CGPoint(x: 560, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.6,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.6,
                endFraction: 1,
                ropeStroke: .electricBlue,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 72,
        forwardSpeed: 90
    )

    static let bumps = makeCourse(
        id: "bumps",
        displayName: "Roller Rope",
        unlockOrder: 1,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 90, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 230, y: -40),
                curveToNext: .quadratic(control: CGPoint(x: 340, y: 52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 460, y: 36),
                curveToNext: .quadratic(control: CGPoint(x: 570, y: -50))
            ),
            CourseWaypoint(
                position: CGPoint(x: 690, y: -32),
                curveToNext: .quadratic(control: CGPoint(x: 800, y: 38))
            ),
            CourseWaypoint(position: CGPoint(x: 960, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.35,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.35,
                endFraction: 0.72,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: [.skyBottom, .electricBlue]
            ),
            StyleDefinition(
                startFraction: 0.72,
                endFraction: 1,
                ropeStroke: .flameOrange,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.flameOrange, .skyTop]
            ),
        ],
        ropeWidth: 64,
        forwardSpeed: 110
    )

    static let switchbacks = makeCourse(
        id: "switchbacks",
        displayName: "Switchbacks",
        unlockOrder: 2,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 210, y: 12),
                curveToNext: .quadratic(control: CGPoint(x: 270, y: 95))
            ),
            CourseWaypoint(
                position: CGPoint(x: 400, y: -35),
                curveToNext: .quadratic(control: CGPoint(x: 460, y: -108))
            ),
            CourseWaypoint(
                position: CGPoint(x: 590, y: 30),
                curveToNext: .quadratic(control: CGPoint(x: 650, y: 102))
            ),
            CourseWaypoint(
                position: CGPoint(x: 780, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 840, y: -98))
            ),
            CourseWaypoint(
                position: CGPoint(x: 970, y: 18),
                curveToNext: .quadratic(control: CGPoint(x: 1030, y: 90))
            ),
            CourseWaypoint(position: CGPoint(x: 1100, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.25,
                ropeStroke: .trackBlack,
                ropeHighlight: nil,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.25,
                endFraction: 0.55,
                ropeStroke: .racingYellow,
                ropeHighlight: .hotRed,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.55,
                endFraction: 0.8,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.8,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 58
    )

    static let longHaul = makeCourse(
        id: "longHaul",
        displayName: "Long Haul",
        unlockOrder: 3,
        waypoints: longHaulWaypoints,
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.2,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.2,
                endFraction: 0.45,
                ropeStroke: .flameOrange,
                ropeHighlight: nil,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.45,
                endFraction: 0.7,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: [.electricBlue, .skyTop]
            ),
            StyleDefinition(
                startFraction: 0.7,
                endFraction: 1,
                ropeStroke: .hotRed,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.hotRed, .trackBlack]
            ),
        ],
        ropeWidth: 60,
        forwardSpeed: 108
    )

    static let narrowWire = makeCourse(
        id: "narrowWire",
        displayName: "Narrow Wire",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 80, y: 16))
            ),
            CourseWaypoint(
                position: CGPoint(x: 200, y: 20),
                curveToNext: .quadratic(control: CGPoint(x: 280, y: -22)),
                ropeWidth: 32
            ),
            CourseWaypoint(
                position: CGPoint(x: 400, y: -18),
                curveToNext: .quadratic(control: CGPoint(x: 480, y: 24)),
                ropeWidth: 28
            ),
            CourseWaypoint(
                position: CGPoint(x: 600, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 680, y: -20)),
                ropeWidth: 26
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: -14),
                curveToNext: .quadratic(control: CGPoint(x: 880, y: 12)),
                ropeWidth: 28
            ),
            CourseWaypoint(position: CGPoint(x: 960, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.35,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.35,
                endFraction: 0.7,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.7,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 40,
        forwardSpeed: 105,
        maxPitchRadians: .pi / 5
    )

    static let bigDrop = makeCourse(
        id: "bigDrop",
        displayName: "Big Drop",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 120, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 300, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 420, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 700, y: -8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 820, y: -48),
                curveToNext: .quadratic(control: CGPoint(x: 940, y: -62))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1020, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 1140, y: -10))
            ),
            CourseWaypoint(position: CGPoint(x: 1360, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.55,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.55,
                endFraction: 0.82,
                ropeStroke: .hotRed,
                ropeHighlight: .flameOrange,
                skyGradient: [.skyBottom, .hotRed]
            ),
            StyleDefinition(
                startFraction: 0.82,
                endFraction: 1,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: [.electricBlue, .skyTop]
            ),
        ],
        forwardSpeed: 115,
        maxPitchRadians: .pi / 3.2
    )

    static let zigZag = makeCourse(
        id: "zigZag",
        displayName: "Zig Zag",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 65, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 140, y: 36),
                curveToNext: .quadratic(control: CGPoint(x: 200, y: -46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 270, y: -36),
                curveToNext: .quadratic(control: CGPoint(x: 330, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 400, y: 36),
                curveToNext: .quadratic(control: CGPoint(x: 460, y: -46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 530, y: -36),
                curveToNext: .quadratic(control: CGPoint(x: 595, y: 46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 670, y: 34),
                curveToNext: .quadratic(control: CGPoint(x: 740, y: -44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 820, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 890, y: 30))
            ),
            CourseWaypoint(position: CGPoint(x: 1000, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.2,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.2,
                endFraction: 0.45,
                ropeStroke: .racingYellow,
                ropeHighlight: .hotRed,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.45,
                endFraction: 0.7,
                ropeStroke: .hotRed,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.7,
                endFraction: 1,
                ropeStroke: .racingYellow,
                ropeHighlight: .hotRed,
                skyGradient: [.flameOrange, .skyBottom]
            ),
        ],
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.5
    )

    static let sunsetCruise = makeCourse(
        id: "sunsetCruise",
        displayName: "Sunset Cruise",
        unlockOrder: 0,
        waypoints: sunsetCruiseWaypoints,
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.33,
                ropeStroke: .flameOrange,
                ropeHighlight: .racingYellow,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.33,
                endFraction: 0.66,
                ropeStroke: .electricBlue,
                ropeHighlight: nil,
                skyGradient: [.skyBottom, .electricBlue]
            ),
            StyleDefinition(
                startFraction: 0.66,
                endFraction: 1,
                ropeStroke: .hotRed,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.hotRed, .trackBlack]
            ),
        ],
        ropeWidth: 50,
        forwardSpeed: 88,
        maxPitchRadians: .pi / 6
    )

    static let ropeBridge = makeCourse(
        id: "ropeBridge",
        displayName: "Rope Bridge",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 70, y: 16))
            ),
            CourseWaypoint(
                position: CGPoint(x: 160, y: 20),
                curveToNext: .quadratic(control: CGPoint(x: 230, y: -22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: -22),
                curveToNext: .quadratic(control: CGPoint(x: 390, y: 36))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 38),
                curveToNext: .quadratic(control: CGPoint(x: 550, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 640, y: -50),
                curveToNext: .quadratic(control: CGPoint(x: 710, y: 50))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: 42),
                curveToNext: .quadratic(control: CGPoint(x: 870, y: -26))
            ),
            CourseWaypoint(
                position: CGPoint(x: 960, y: -24),
                curveToNext: .quadratic(control: CGPoint(x: 1020, y: 14))
            ),
            CourseWaypoint(position: CGPoint(x: 1100, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.25,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.25,
                endFraction: 0.5,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.5,
                endFraction: 0.72,
                ropeStroke: .flameOrange,
                ropeHighlight: .hotRed,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.72,
                endFraction: 1,
                ropeStroke: .racingYellow,
                ropeHighlight: .trackBlack,
                skyGradient: nil
            ),
        ],
        forwardSpeed: 112,
        maxPitchRadians: .pi / 4.5
    )

    static let windAlley = makeCourse(
        id: "windAlley",
        displayName: "Wind Alley",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 80, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 180, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 260, y: -20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 360, y: -18),
                curveToNext: .quadratic(control: CGPoint(x: 440, y: 22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 540, y: 20),
                curveToNext: .quadratic(control: CGPoint(x: 620, y: -22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 720, y: -20),
                curveToNext: .quadratic(control: CGPoint(x: 800, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 980, y: -20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1080, y: -18),
                curveToNext: .quadratic(control: CGPoint(x: 1160, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1260, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 1340, y: -16))
            ),
            CourseWaypoint(position: CGPoint(x: 1440, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.32,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.32,
                endFraction: 0.68,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: [.skyBottom, .electricBlue]
            ),
            StyleDefinition(
                startFraction: 0.68,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
        ],
        ropeWidth: 50,
        forwardSpeed: 140,
        maxPitchRadians: .pi / 7
    )

    static let summitClimb = makeCourse(
        id: "summitClimb",
        displayName: "Summit Climb",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 110, y: -14))
            ),
            CourseWaypoint(
                position: CGPoint(x: 260, y: -22),
                curveToNext: .quadratic(control: CGPoint(x: 370, y: -34))
            ),
            CourseWaypoint(
                position: CGPoint(x: 500, y: -38),
                curveToNext: .quadratic(control: CGPoint(x: 620, y: -46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 760, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 880, y: -40))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1020, y: -32),
                curveToNext: .quadratic(control: CGPoint(x: 1150, y: -16))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1300, y: -8),
                curveToNext: .quadratic(control: CGPoint(x: 1420, y: 4))
            ),
            CourseWaypoint(position: CGPoint(x: 1580, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.18,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.18,
                endFraction: 0.55,
                ropeStroke: .flameOrange,
                ropeHighlight: .hotRed,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.55,
                endFraction: 0.78,
                ropeStroke: .hotRed,
                ropeHighlight: .flameOrange,
                skyGradient: [.hotRed, .flameOrange]
            ),
            StyleDefinition(
                startFraction: 0.78,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 46,
        forwardSpeed: 108,
        maxPitchRadians: .pi / 3.8
    )

    static let hairpins = makeCourse(
        id: "hairpins",
        displayName: "Hairpins",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 55, y: 58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 130, y: 52),
                curveToNext: .quadratic(control: CGPoint(x: 195, y: -58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: -54),
                curveToNext: .quadratic(control: CGPoint(x: 345, y: 58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 430, y: 52),
                curveToNext: .quadratic(control: CGPoint(x: 495, y: -58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 580, y: -54),
                curveToNext: .quadratic(control: CGPoint(x: 650, y: 56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 740, y: 50),
                curveToNext: .quadratic(control: CGPoint(x: 820, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: -46),
                curveToNext: .quadratic(control: CGPoint(x: 980, y: 24))
            ),
            CourseWaypoint(position: CGPoint(x: 1080, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.3,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.3,
                endFraction: 0.6,
                ropeStroke: .hotRed,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.6,
                endFraction: 1,
                ropeStroke: .electricBlue,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.electricBlue, .skyTop]
            ),
        ],
        ropeWidth: 42,
        forwardSpeed: 125,
        maxPitchRadians: .pi / 3.2
    )

    static let canyonGap = makeCourse(
        id: "canyonGap",
        displayName: "Canyon Gap",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: 8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 240, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 360, y: 12))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 570, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 680, y: -50),
                curveToNext: .quadratic(control: CGPoint(x: 790, y: 14))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: 36),
                curveToNext: .quadratic(control: CGPoint(x: 990, y: -46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1080, y: -40),
                curveToNext: .quadratic(control: CGPoint(x: 1170, y: 8))
            ),
            CourseWaypoint(position: CGPoint(x: 1280, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.35,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.35,
                endFraction: 0.68,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.trackBlack, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.68,
                endFraction: 1,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3
    )

    static let checkerboard = makeCourse(
        id: "checkerboard",
        displayName: "Checkerboard",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 150, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 90, y: -44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 300, y: 30),
                curveToNext: .quadratic(control: CGPoint(x: 230, y: 46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 460, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 390, y: -44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 620, y: 30),
                curveToNext: .quadratic(control: CGPoint(x: 550, y: 46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 780, y: -26),
                curveToNext: .quadratic(control: CGPoint(x: 710, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 940, y: 28),
                curveToNext: .quadratic(control: CGPoint(x: 870, y: 42))
            ),
            CourseWaypoint(position: CGPoint(x: 1100, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.18,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.18,
                endFraction: 0.36,
                ropeStroke: .racingYellow,
                ropeHighlight: .hotRed,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.36,
                endFraction: 0.54,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.54,
                endFraction: 0.72,
                ropeStroke: .flameOrange,
                ropeHighlight: .hotRed,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.72,
                endFraction: 1,
                ropeStroke: .hotRed,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: nil
            ),
        ],
        forwardSpeed: 115
    )

    // MARK: - Batch 3 courses

    static let loopDeLoop = makeCourse(
        id: "loopDeLoop",
        displayName: "Loop de Loop",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: 6))
            ),
            CourseWaypoint(
                position: CGPoint(x: 240, y: 8),
                curveToNext: .quadratic(control: CGPoint(x: 340, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 570, y: 70))
            ),
            CourseWaypoint(
                position: CGPoint(x: 680, y: 52),
                curveToNext: .quadratic(control: CGPoint(x: 770, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 980, y: 68))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1080, y: 50),
                curveToNext: .quadratic(control: CGPoint(x: 1170, y: -16))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1260, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 1360, y: 0))
            ),
            CourseWaypoint(position: CGPoint(x: 1400, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.42,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.42,
                endFraction: 0.72,
                ropeStroke: .flameOrange,
                ropeHighlight: .racingYellow,
                skyGradient: [.flameOrange, .racingYellow]
            ),
            StyleDefinition(
                startFraction: 0.72,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 50,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 4.8
    )

    static let tightropeWalk = makeCourse(
        id: "tightropeWalk",
        displayName: "Tightrope Walk",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 70, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 160, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 230, y: -20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: -16),
                curveToNext: .quadratic(control: CGPoint(x: 390, y: 20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 18),
                curveToNext: .quadratic(control: CGPoint(x: 550, y: -20)),
                ropeWidth: 36
            ),
            CourseWaypoint(
                position: CGPoint(x: 640, y: -16),
                curveToNext: .quadratic(control: CGPoint(x: 710, y: 20)),
                ropeWidth: 34
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 870, y: -18)),
                ropeWidth: 36
            ),
            CourseWaypoint(
                position: CGPoint(x: 960, y: -14),
                curveToNext: .quadratic(control: CGPoint(x: 1030, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1120, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.35,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.35,
                endFraction: 0.7,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.7,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 44,
        forwardSpeed: 102,
        maxPitchRadians: .pi / 6
    )

    static let spiralDrift = makeCourse(
        id: "spiralDrift",
        displayName: "Spiral Drift",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 80, y: 22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 200, y: 20),
                curveToNext: .quadratic(control: CGPoint(x: 280, y: -38))
            ),
            CourseWaypoint(
                position: CGPoint(x: 380, y: -32),
                curveToNext: .quadratic(control: CGPoint(x: 460, y: 52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: 44),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: -58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 740, y: -48),
                curveToNext: .quadratic(control: CGPoint(x: 820, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 920, y: 36),
                curveToNext: .quadratic(control: CGPoint(x: 1000, y: -30))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1100, y: -20),
                curveToNext: .quadratic(control: CGPoint(x: 1170, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1240, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.22,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.22,
                endFraction: 0.44,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.44,
                endFraction: 0.66,
                ropeStroke: .flameOrange,
                ropeHighlight: .hotRed,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.66,
                endFraction: 1,
                ropeStroke: .racingYellow,
                ropeHighlight: .electricBlue,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 48,
        forwardSpeed: 116,
        maxPitchRadians: .pi / 5
    )

    static let midnightRun = makeCourse(
        id: "midnightRun",
        displayName: "Midnight Run",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: -32))
            ),
            CourseWaypoint(
                position: CGPoint(x: 240, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 340, y: 38))
            ),
            CourseWaypoint(
                position: CGPoint(x: 460, y: 32),
                curveToNext: .quadratic(control: CGPoint(x: 560, y: -36))
            ),
            CourseWaypoint(
                position: CGPoint(x: 680, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 780, y: 34))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: 28),
                curveToNext: .quadratic(control: CGPoint(x: 1000, y: -22))
            ),
            CourseWaypoint(position: CGPoint(x: 1120, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.28,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .trackBlack]
            ),
            StyleDefinition(
                startFraction: 0.28,
                endFraction: 0.55,
                ropeStroke: .electricBlue,
                ropeHighlight: nil,
                skyGradient: [.trackBlack, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.55,
                endFraction: 0.82,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .trackBlack]
            ),
            StyleDefinition(
                startFraction: 0.82,
                endFraction: 1,
                ropeStroke: .hotRed,
                ropeHighlight: .flameOrange,
                skyGradient: [.trackBlack, .skyBottom]
            ),
        ],
        ropeWidth: 49,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 5.5
    )

    static let rollerCoast = makeCourse(
        id: "rollerCoast",
        displayName: "Roller Coast",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 160, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 95, y: -48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: 22),
                curveToNext: .quadratic(control: CGPoint(x: 250, y: 42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: -24),
                curveToNext: .quadratic(control: CGPoint(x: 410, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 640, y: 18),
                curveToNext: .quadratic(control: CGPoint(x: 570, y: 36))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 720, y: -55))
            ),
            CourseWaypoint(
                position: CGPoint(x: 960, y: -20),
                curveToNext: .quadratic(control: CGPoint(x: 880, y: -32))
            ),
            CourseWaypoint(position: CGPoint(x: 1120, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.25,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.25,
                endFraction: 0.5,
                ropeStroke: .racingYellow,
                ropeHighlight: .hotRed,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.5,
                endFraction: 0.75,
                ropeStroke: .electricBlue,
                ropeHighlight: .flameOrange,
                skyGradient: [.electricBlue, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.75,
                endFraction: 1,
                ropeStroke: .hotRed,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
        ],
        forwardSpeed: 114,
        maxPitchRadians: .pi / 3.8
    )

    // MARK: - Batch 4 courses

    static let desertDash = makeCourse(
        id: "desertDash",
        displayName: "Desert Dash",
        unlockOrder: 0,
        waypoints: desertDashWaypoints,
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.3,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.3,
                endFraction: 0.65,
                ropeStroke: .flameOrange,
                ropeHighlight: .racingYellow,
                skyGradient: [.flameOrange, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.65,
                endFraction: 1,
                ropeStroke: .hotRed,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .flameOrange]
            ),
        ],
        ropeWidth: 50,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 6
    )

    static let iceShelf = makeCourse(
        id: "iceShelf",
        displayName: "Ice Shelf",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: -10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 260, y: -14),
                curveToNext: .quadratic(control: CGPoint(x: 370, y: -24))
            ),
            CourseWaypoint(
                position: CGPoint(x: 520, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: -38))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: -40),
                curveToNext: .quadratic(control: CGPoint(x: 940, y: -46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1100, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 1260, y: -44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1380, y: -42),
                curveToNext: .quadratic(control: CGPoint(x: 1500, y: -28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1600, y: -18),
                curveToNext: .quadratic(control: CGPoint(x: 1700, y: -4))
            ),
            CourseWaypoint(position: CGPoint(x: 1820, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.35,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .electricBlue]
            ),
            StyleDefinition(
                startFraction: 0.35,
                endFraction: 0.7,
                ropeStroke: .electricBlue,
                ropeHighlight: nil,
                skyGradient: [.electricBlue, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.7,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 49,
        forwardSpeed: 90,
        maxPitchRadians: .pi / 5.5
    )

    static let pendulumSwing = makeCourse(
        id: "pendulumSwing",
        displayName: "Pendulum Swing",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 60, y: 26))
            ),
            CourseWaypoint(
                position: CGPoint(x: 150, y: 22),
                curveToNext: .quadratic(control: CGPoint(x: 225, y: -32))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 400, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 500, y: 44),
                curveToNext: .quadratic(control: CGPoint(x: 590, y: -60))
            ),
            CourseWaypoint(
                position: CGPoint(x: 700, y: -56),
                curveToNext: .quadratic(control: CGPoint(x: 800, y: 60))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: 52),
                curveToNext: .quadratic(control: CGPoint(x: 990, y: -46))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1080, y: -36),
                curveToNext: .quadratic(control: CGPoint(x: 1150, y: 22))
            ),
            CourseWaypoint(position: CGPoint(x: 1200, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.18,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.18,
                endFraction: 0.42,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.42,
                endFraction: 0.68,
                ropeStroke: .flameOrange,
                ropeHighlight: .hotRed,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.68,
                endFraction: 0.88,
                ropeStroke: .racingYellow,
                ropeHighlight: .electricBlue,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.88,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 48,
        forwardSpeed: 114,
        maxPitchRadians: .pi / 5
    )

    static let launchPad = makeCourse(
        id: "launchPad",
        displayName: "Launch Pad",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: 4))
            ),
            CourseWaypoint(
                position: CGPoint(x: 240, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 340, y: 44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 50),
                curveToNext: .quadratic(control: CGPoint(x: 580, y: 54))
            ),
            CourseWaypoint(
                position: CGPoint(x: 680, y: 48),
                curveToNext: .quadratic(control: CGPoint(x: 780, y: -38))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 980, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1080, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.28,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.28,
                endFraction: 0.62,
                ropeStroke: .flameOrange,
                ropeHighlight: .hotRed,
                skyGradient: [.flameOrange, .racingYellow]
            ),
            StyleDefinition(
                startFraction: 0.62,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 50,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.2
    )

    static let whisperCanyon = makeCourse(
        id: "whisperCanyon",
        displayName: "Whisper Canyon",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 180, y: 5),
                curveToNext: .quadratic(control: CGPoint(x: 110, y: 8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 360, y: 8),
                curveToNext: .quadratic(control: CGPoint(x: 280, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 4),
                curveToNext: .line,
                ropeWidth: 30
            ),
            CourseWaypoint(
                position: CGPoint(x: 540, y: 2),
                curveToNext: .line,
                ropeWidth: 30
            ),
            CourseWaypoint(
                position: CGPoint(x: 620, y: -32),
                curveToNext: .quadratic(control: CGPoint(x: 565, y: -48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 710, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 980, y: 2),
                curveToNext: .quadratic(control: CGPoint(x: 900, y: 6))
            ),
            CourseWaypoint(position: CGPoint(x: 1140, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.32,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.32,
                endFraction: 0.58,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .trackBlack]
            ),
            StyleDefinition(
                startFraction: 0.58,
                endFraction: 1,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 48,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 4.2
    )

    // MARK: - Batch 5 courses

    static let rainbowRoad = makeCourse(
        id: "rainbowRoad",
        displayName: "Rainbow Road",
        unlockOrder: 25,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 90, y: 68))
            ),
            CourseWaypoint(
                position: CGPoint(x: 220, y: 58),
                curveToNext: .quadratic(control: CGPoint(x: 330, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 460, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 570, y: 60))
            ),
            CourseWaypoint(
                position: CGPoint(x: 700, y: 50),
                curveToNext: .quadratic(control: CGPoint(x: 820, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 940, y: -32),
                curveToNext: .quadratic(control: CGPoint(x: 1040, y: 16))
            ),
            CourseWaypoint(position: CGPoint(x: 1120, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.2, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.2, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.6, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .skyBottom]),
            StyleDefinition(startFraction: 0.6, endFraction: 0.8, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 54,
        forwardSpeed: 90
    )

    static let wobblyBridge = makeCourse(
        id: "wobblyBridge",
        displayName: "Wobbly Bridge",
        unlockOrder: 26,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 50, y: 42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 130, y: 38),
                curveToNext: .quadratic(control: CGPoint(x: 195, y: -32))
            ),
            CourseWaypoint(
                position: CGPoint(x: 270, y: -24),
                curveToNext: .quadratic(control: CGPoint(x: 330, y: 52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 420, y: 48),
                curveToNext: .quadratic(control: CGPoint(x: 490, y: -28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 580, y: -20),
                curveToNext: .quadratic(control: CGPoint(x: 645, y: 58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 730, y: 50),
                curveToNext: .quadratic(control: CGPoint(x: 800, y: -22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: -16),
                curveToNext: .quadratic(control: CGPoint(x: 945, y: 30))
            ),
            CourseWaypoint(position: CGPoint(x: 1040, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.67, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.67, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 50,
        forwardSpeed: 105,
        maxPitchRadians: .pi / 4.5
    )

    static let sCurve = makeCourse(
        id: "sCurve",
        displayName: "S-Curve",
        unlockOrder: 27,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 130, y: 62))
            ),
            CourseWaypoint(
                position: CGPoint(x: 340, y: 54),
                curveToNext: .quadratic(control: CGPoint(x: 500, y: 52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 620, y: 30),
                curveToNext: .quadratic(control: CGPoint(x: 740, y: -62))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: -56),
                curveToNext: .quadratic(control: CGPoint(x: 1040, y: -54))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1140, y: -28),
                curveToNext: .quadratic(control: CGPoint(x: 1230, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1280, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 48,
        forwardSpeed: 110,
        maxPitchRadians: .pi / 3.5
    )

    static let steepHill = makeCourse(
        id: "steepHill",
        displayName: "Steep Hill",
        unlockOrder: 28,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 90, y: 22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 220, y: 32),
                curveToNext: .quadratic(control: CGPoint(x: 310, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 440, y: -48),
                curveToNext: .quadratic(control: CGPoint(x: 540, y: 56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 660, y: 52),
                curveToNext: .quadratic(control: CGPoint(x: 760, y: -58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: -54),
                curveToNext: .quadratic(control: CGPoint(x: 980, y: 44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1100, y: 38),
                curveToNext: .quadratic(control: CGPoint(x: 1200, y: -24))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1300, y: -12),
                curveToNext: .quadratic(control: CGPoint(x: 1390, y: 6))
            ),
            CourseWaypoint(position: CGPoint(x: 1440, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.55, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.78, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 48,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 3.2
    )

    static let mountainPass = makeCourse(
        id: "mountainPass",
        displayName: "Mountain Pass",
        unlockOrder: 29,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: -36))
            ),
            CourseWaypoint(
                position: CGPoint(x: 240, y: -40),
                curveToNext: .quadratic(control: CGPoint(x: 360, y: 50))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 44),
                curveToNext: .quadratic(control: CGPoint(x: 590, y: -56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 720, y: -52),
                curveToNext: .quadratic(control: CGPoint(x: 840, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 960, y: 42),
                curveToNext: .quadratic(control: CGPoint(x: 1070, y: -54))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1200, y: -46),
                curveToNext: .quadratic(control: CGPoint(x: 1310, y: 22))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1420, y: 12),
                curveToNext: .quadratic(control: CGPoint(x: 1510, y: -6))
            ),
            CourseWaypoint(position: CGPoint(x: 1560, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyTop]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 115,
        maxPitchRadians: .pi / 3.8
    )

    // MARK: - Batch 6 courses

    static let gentleMeander = makeCourse(
        id: "gentleMeander",
        displayName: "Gentle Meander",
        unlockOrder: 30,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 140, y: 28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: 24),
                curveToNext: .quadratic(control: CGPoint(x: 460, y: -30))
            ),
            CourseWaypoint(
                position: CGPoint(x: 600, y: -26),
                curveToNext: .quadratic(control: CGPoint(x: 740, y: 32))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: 28),
                curveToNext: .quadratic(control: CGPoint(x: 1020, y: -26))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1160, y: -22),
                curveToNext: .quadratic(control: CGPoint(x: 1290, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1400, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 1510, y: -8))
            ),
            CourseWaypoint(position: CGPoint(x: 1580, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .electricBlue]),
        ],
        ropeWidth: 52,
        forwardSpeed: 95
    )

    static let skyDance = makeCourse(
        id: "skyDance",
        displayName: "Sky Dance",
        unlockOrder: 31,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 65, y: -56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 160, y: -52),
                curveToNext: .quadratic(control: CGPoint(x: 250, y: 60))
            ),
            CourseWaypoint(
                position: CGPoint(x: 340, y: 54),
                curveToNext: .quadratic(control: CGPoint(x: 430, y: -58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 520, y: -52),
                curveToNext: .quadratic(control: CGPoint(x: 610, y: 56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 700, y: 48),
                curveToNext: .quadratic(control: CGPoint(x: 790, y: -50))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: -42),
                curveToNext: .quadratic(control: CGPoint(x: 970, y: 36))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1060, y: 28),
                curveToNext: .quadratic(control: CGPoint(x: 1140, y: -14))
            ),
            CourseWaypoint(position: CGPoint(x: 1200, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .skyBottom]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.skyBottom, .hotRed]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 47,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.8
    )

    static let canyonDive = makeCourse(
        id: "canyonDive",
        displayName: "Canyon Dive",
        unlockOrder: 32,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 110, y: 14))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 390, y: -62))
            ),
            CourseWaypoint(
                position: CGPoint(x: 520, y: -58),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: -64)),
                ropeWidth: 40
            ),
            CourseWaypoint(
                position: CGPoint(x: 760, y: -56),
                curveToNext: .quadratic(control: CGPoint(x: 880, y: 60)),
                ropeWidth: 38
            ),
            CourseWaypoint(
                position: CGPoint(x: 1000, y: 54),
                curveToNext: .quadratic(control: CGPoint(x: 1110, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1220, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 1320, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1400, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.62, endFraction: 0.82, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.82, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 116,
        maxPitchRadians: .pi / 3
    )

    static let plateauRun = makeCourse(
        id: "plateauRun",
        displayName: "Plateau Run",
        unlockOrder: 33,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 130, y: 38))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: 44),
                curveToNext: .quadratic(control: CGPoint(x: 440, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: 44),
                curveToNext: .quadratic(control: CGPoint(x: 680, y: 44))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: 42),
                curveToNext: .quadratic(control: CGPoint(x: 920, y: -36))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1040, y: -46),
                curveToNext: .quadratic(control: CGPoint(x: 1160, y: 40))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1280, y: 36),
                curveToNext: .quadratic(control: CGPoint(x: 1390, y: -12))
            ),
            CourseWaypoint(position: CGPoint(x: 1480, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.68, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 47,
        forwardSpeed: 110,
        maxPitchRadians: .pi / 3.5
    )

    static let lakesideLoop = makeCourse(
        id: "lakesideLoop",
        displayName: "Lakeside Loop",
        unlockOrder: 34,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 180, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 108, y: 16))
            ),
            CourseWaypoint(
                position: CGPoint(x: 360, y: -25),
                curveToNext: .quadratic(control: CGPoint(x: 278, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 540, y: -55),
                curveToNext: .quadratic(control: CGPoint(x: 458, y: -64))
            ),
            CourseWaypoint(
                position: CGPoint(x: 720, y: -45),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: -55))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: -12),
                curveToNext: .quadratic(control: CGPoint(x: 818, y: -28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1080, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 998, y: 4))
            ),
            CourseWaypoint(position: CGPoint(x: 1260, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.67, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.67, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .electricBlue]),
        ],
        ropeWidth: 49,
        forwardSpeed: 108,
        maxPitchRadians: .pi / 4.2
    )

    // MARK: - Batch 7 courses

    static let gravityDrop = makeCourse(
        id: "gravityDrop",
        displayName: "Gravity Drop",
        unlockOrder: 35,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 110, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: 12),
                curveToNext: .quadratic(control: CGPoint(x: 390, y: -70))
            ),
            CourseWaypoint(
                position: CGPoint(x: 540, y: -65),
                curveToNext: .quadratic(control: CGPoint(x: 660, y: -68))
            ),
            CourseWaypoint(
                position: CGPoint(x: 780, y: -60),
                curveToNext: .quadratic(control: CGPoint(x: 890, y: 68))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1020, y: 62),
                curveToNext: .quadratic(control: CGPoint(x: 1140, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1260, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 1370, y: 20))
            ),
            CourseWaypoint(position: CGPoint(x: 1460, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.6, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.6, endFraction: 0.82, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.82, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 3
    )

    static let twinPeaks = makeCourse(
        id: "twinPeaks",
        displayName: "Twin Peaks",
        unlockOrder: 36,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 110, y: 64))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: 58),
                curveToNext: .quadratic(control: CGPoint(x: 390, y: -20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 520, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 630, y: 8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 760, y: -60),
                curveToNext: .quadratic(control: CGPoint(x: 870, y: -72))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1000, y: -10),
                curveToNext: .quadratic(control: CGPoint(x: 1110, y: 6))
            ),
            CourseWaypoint(position: CGPoint(x: 1200, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.2, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.2, endFraction: 0.5, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.8, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.skyBottom, .hotRed]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 48,
        forwardSpeed: 114,
        maxPitchRadians: .pi / 3.5
    )

    static let spiralGalaxy = makeCourse(
        id: "spiralGalaxy",
        displayName: "Spiral Galaxy",
        unlockOrder: 37,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 70, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 170, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 255, y: -42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 360, y: -38),
                curveToNext: .quadratic(control: CGPoint(x: 460, y: 62))
            ),
            CourseWaypoint(
                position: CGPoint(x: 580, y: 56),
                curveToNext: .quadratic(control: CGPoint(x: 690, y: -70))
            ),
            CourseWaypoint(
                position: CGPoint(x: 820, y: -62),
                curveToNext: .quadratic(control: CGPoint(x: 930, y: 60))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1060, y: 50),
                curveToNext: .quadratic(control: CGPoint(x: 1160, y: -34))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1260, y: -22),
                curveToNext: .quadratic(control: CGPoint(x: 1340, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1400, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.skyBottom, .racingYellow]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .hotRed, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .hotRed]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .electricBlue]),
        ],
        ropeWidth: 44,
        forwardSpeed: 122,
        maxPitchRadians: .pi / 3.2
    )

    static let staircase = makeCourse(
        id: "staircase",
        displayName: "Staircase",
        unlockOrder: 38,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 60, y: 0))
            ),
            CourseWaypoint(
                position: CGPoint(x: 160, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 200, y: -32)),
                ropeWidth: 44
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: -34),
                curveToNext: .quadratic(control: CGPoint(x: 360, y: -34))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: -34),
                curveToNext: .quadratic(control: CGPoint(x: 520, y: -54)),
                ropeWidth: 42
            ),
            CourseWaypoint(
                position: CGPoint(x: 640, y: -56),
                curveToNext: .quadratic(control: CGPoint(x: 680, y: -56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: -56),
                curveToNext: .quadratic(control: CGPoint(x: 840, y: -32)),
                ropeWidth: 44
            ),
            CourseWaypoint(
                position: CGPoint(x: 960, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 1000, y: -30))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1120, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 1160, y: 0)),
                ropeWidth: 46
            ),
            CourseWaypoint(position: CGPoint(x: 1300, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.44, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: nil),
            StyleDefinition(startFraction: 0.44, endFraction: 0.66, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: nil),
            StyleDefinition(startFraction: 0.66, endFraction: 0.88, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: nil),
            StyleDefinition(startFraction: 0.88, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 108,
        maxPitchRadians: .pi / 3.5
    )

    static let boomerang = makeCourse(
        id: "boomerang",
        displayName: "Boomerang",
        unlockOrder: 39,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 100, y: 8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 240, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 350, y: -60))
            ),
            CourseWaypoint(
                position: CGPoint(x: 500, y: -62),
                curveToNext: .quadratic(control: CGPoint(x: 620, y: -64))
            ),
            CourseWaypoint(
                position: CGPoint(x: 740, y: -56),
                curveToNext: .quadratic(control: CGPoint(x: 858, y: -20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 960, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 1070, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1200, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.55, ropeStroke: .electricBlue, ropeHighlight: .flameOrange, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .flameOrange, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 116,
        maxPitchRadians: .pi / 3.5
    )

    // MARK: - Batch 8 courses

    static let pogoBounce = makeCourse(
        id: "pogoBounce",
        displayName: "Pogo Bounce",
        unlockOrder: 40,
        waypoints: [
            CourseWaypoint(
                position: CGPoint(x: 0, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 45, y: -54))
            ),
            CourseWaypoint(
                position: CGPoint(x: 110, y: -48),
                curveToNext: .quadratic(control: CGPoint(x: 155, y: 6))
            ),
            CourseWaypoint(
                position: CGPoint(x: 220, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 265, y: -56))
            ),
            CourseWaypoint(
                position: CGPoint(x: 330, y: -50),
                curveToNext: .quadratic(control: CGPoint(x: 375, y: 6))
            ),
            CourseWaypoint(
                position: CGPoint(x: 440, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 490, y: -58))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: -52),
                curveToNext: .quadratic(control: CGPoint(x: 610, y: 6))
            ),
            CourseWaypoint(
                position: CGPoint(x: 680, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 730, y: -52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: -44),
                curveToNext: .quadratic(control: CGPoint(x: 855, y: 4))
            ),
            CourseWaypoint(
                position: CGPoint(x: 920, y: 2),
                curveToNext: .quadratic(control: CGPoint(x: 970, y: 0))
            ),
            CourseWaypoint(position: CGPoint(x: 1060, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.hotRed, .flameOrange]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.5
    )

    static let stormSurge = makeCourse(
        id: "stormSurge",
        displayName: "Storm Surge",
        unlockOrder: 41,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -18), curveToNext: .quadratic(control: CGPoint(x: 80, y: -26))),
            CourseWaypoint(position: CGPoint(x: 320, y: 6), curveToNext: .quadratic(control: CGPoint(x: 240, y: 18))),
            CourseWaypoint(position: CGPoint(x: 480, y: -36), curveToNext: .quadratic(control: CGPoint(x: 400, y: -48))),
            CourseWaypoint(position: CGPoint(x: 640, y: 10), curveToNext: .quadratic(control: CGPoint(x: 560, y: 22))),
            CourseWaypoint(position: CGPoint(x: 800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 720, y: -64))),
            CourseWaypoint(position: CGPoint(x: 960, y: 14), curveToNext: .quadratic(control: CGPoint(x: 880, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 30))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1340, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.7, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .electricBlue]),
        ],
        ropeWidth: 47,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 4
    )

    static let monkeyBars = makeCourse(
        id: "monkeyBars",
        displayName: "Monkey Bars",
        unlockOrder: 42,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 170, y: -52), curveToNext: .quadratic(control: CGPoint(x: 85, y: -62)), ropeWidth: 44),
            CourseWaypoint(position: CGPoint(x: 360, y: 4), curveToNext: .quadratic(control: CGPoint(x: 265, y: 16))),
            CourseWaypoint(position: CGPoint(x: 540, y: 50), curveToNext: .quadratic(control: CGPoint(x: 450, y: 62)), ropeWidth: 44),
            CourseWaypoint(position: CGPoint(x: 720, y: -2), curveToNext: .quadratic(control: CGPoint(x: 630, y: -14))),
            CourseWaypoint(position: CGPoint(x: 900, y: -54), curveToNext: .quadratic(control: CGPoint(x: 810, y: -64)), ropeWidth: 42),
            CourseWaypoint(position: CGPoint(x: 1080, y: 6), curveToNext: .quadratic(control: CGPoint(x: 990, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 58)), ropeWidth: 44),
            CourseWaypoint(position: CGPoint(x: 1420, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1340, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: nil),
            StyleDefinition(startFraction: 0.55, endFraction: 0.75, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: nil),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 3.5
    )

    static let slipSlide = makeCourse(
        id: "slipSlide",
        displayName: "Slip n Slide",
        unlockOrder: 43,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -14), curveToNext: .quadratic(control: CGPoint(x: 90, y: -8))),
            CourseWaypoint(position: CGPoint(x: 380, y: -38), curveToNext: .quadratic(control: CGPoint(x: 280, y: -28))),
            CourseWaypoint(position: CGPoint(x: 580, y: -58), curveToNext: .quadratic(control: CGPoint(x: 480, y: -50))),
            CourseWaypoint(position: CGPoint(x: 760, y: -60), curveToNext: .quadratic(control: CGPoint(x: 670, y: -64)), ropeWidth: 44),
            CourseWaypoint(position: CGPoint(x: 940, y: -56), curveToNext: .quadratic(control: CGPoint(x: 850, y: -62)), ropeWidth: 44),
            CourseWaypoint(position: CGPoint(x: 1120, y: -28), curveToNext: .quadratic(control: CGPoint(x: 1030, y: -46))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1210, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1460, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1380, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: nil, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 48,
        forwardSpeed: 116,
        maxPitchRadians: .pi / 4
    )

    static let speedBumps = makeCourse(
        id: "speedBumps",
        displayName: "Speed Bumps",
        unlockOrder: 44,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 130, y: -48), curveToNext: .quadratic(control: CGPoint(x: 65, y: -58))),
            CourseWaypoint(position: CGPoint(x: 260, y: 6), curveToNext: .quadratic(control: CGPoint(x: 195, y: 18))),
            CourseWaypoint(position: CGPoint(x: 390, y: -48), curveToNext: .quadratic(control: CGPoint(x: 325, y: -58))),
            CourseWaypoint(position: CGPoint(x: 520, y: 6), curveToNext: .quadratic(control: CGPoint(x: 455, y: 18))),
            CourseWaypoint(position: CGPoint(x: 650, y: -50), curveToNext: .quadratic(control: CGPoint(x: 585, y: -60))),
            CourseWaypoint(position: CGPoint(x: 780, y: 6), curveToNext: .quadratic(control: CGPoint(x: 715, y: 18))),
            CourseWaypoint(position: CGPoint(x: 910, y: -50), curveToNext: .quadratic(control: CGPoint(x: 845, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1040, y: 6), curveToNext: .quadratic(control: CGPoint(x: 975, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1170, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1105, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1235, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1420, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1520, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1470, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.67, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.67, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 47,
        forwardSpeed: 122,
        maxPitchRadians: .pi / 4
    )

    // MARK: - Batch 9 courses

    static let corkscrew = makeCourse(
        id: "corkscrew",
        displayName: "Corkscrew",
        unlockOrder: 45,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -28), curveToNext: .quadratic(control: CGPoint(x: 80, y: -38))),
            CourseWaypoint(position: CGPoint(x: 330, y: 18), curveToNext: .quadratic(control: CGPoint(x: 245, y: 30))),
            CourseWaypoint(position: CGPoint(x: 510, y: -48), curveToNext: .quadratic(control: CGPoint(x: 420, y: -60))),
            CourseWaypoint(position: CGPoint(x: 700, y: 30), curveToNext: .quadratic(control: CGPoint(x: 605, y: 44))),
            CourseWaypoint(position: CGPoint(x: 880, y: -60), curveToNext: .quadratic(control: CGPoint(x: 790, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1060, y: 42), curveToNext: .quadratic(control: CGPoint(x: 970, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1230, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1145, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1390, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1310, y: 36))),
            CourseWaypoint(position: CGPoint(x: 1540, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1465, y: 12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.6, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .hotRed]),
        ],
        ropeWidth: 44,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 3.2
    )

    static let highWire = makeCourse(
        id: "highWire",
        displayName: "High Wire",
        unlockOrder: 46,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 58), curveToNext: .quadratic(control: CGPoint(x: 90, y: 70))),
            CourseWaypoint(position: CGPoint(x: 360, y: -28), curveToNext: .quadratic(control: CGPoint(x: 270, y: -40))),
            CourseWaypoint(position: CGPoint(x: 540, y: 28), curveToNext: .quadratic(control: CGPoint(x: 450, y: 40))),
            CourseWaypoint(position: CGPoint(x: 720, y: -58), curveToNext: .quadratic(control: CGPoint(x: 630, y: -70))),
            CourseWaypoint(position: CGPoint(x: 900, y: 28), curveToNext: .quadratic(control: CGPoint(x: 810, y: 40))),
            CourseWaypoint(position: CGPoint(x: 1080, y: -28), curveToNext: .quadratic(control: CGPoint(x: 990, y: -40))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 28), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 40))),
            CourseWaypoint(position: CGPoint(x: 1420, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1340, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1560, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.18, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.18, endFraction: 0.82, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.82, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 48,
        forwardSpeed: 105,
        maxPitchRadians: .pi / 7
    )

    static let rippleRun = makeCourse(
        id: "rippleRun",
        displayName: "Ripple Run",
        unlockOrder: 47,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 100, y: -44), curveToNext: .quadratic(control: CGPoint(x: 50, y: -54))),
            CourseWaypoint(position: CGPoint(x: 200, y: 22), curveToNext: .quadratic(control: CGPoint(x: 150, y: 34))),
            CourseWaypoint(position: CGPoint(x: 300, y: -48), curveToNext: .quadratic(control: CGPoint(x: 250, y: -58))),
            CourseWaypoint(position: CGPoint(x: 400, y: 26), curveToNext: .quadratic(control: CGPoint(x: 350, y: 38))),
            CourseWaypoint(position: CGPoint(x: 500, y: -52), curveToNext: .quadratic(control: CGPoint(x: 450, y: -62))),
            CourseWaypoint(position: CGPoint(x: 600, y: 28), curveToNext: .quadratic(control: CGPoint(x: 550, y: 40))),
            CourseWaypoint(position: CGPoint(x: 700, y: -52), curveToNext: .quadratic(control: CGPoint(x: 650, y: -62))),
            CourseWaypoint(position: CGPoint(x: 800, y: 28), curveToNext: .quadratic(control: CGPoint(x: 750, y: 40))),
            CourseWaypoint(position: CGPoint(x: 900, y: -50), curveToNext: .quadratic(control: CGPoint(x: 850, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 26), curveToNext: .quadratic(control: CGPoint(x: 950, y: 38))),
            CourseWaypoint(position: CGPoint(x: 1100, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 22), curveToNext: .quadratic(control: CGPoint(x: 1150, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1320, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1260, y: -20))),
            CourseWaypoint(position: CGPoint(x: 1460, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1390, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1580, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.65, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
        ],
        ropeWidth: 48,
        forwardSpeed: 116,
        maxPitchRadians: .pi / 4
    )

    static let dragonBack = makeCourse(
        id: "dragonBack",
        displayName: "Dragon Back",
        unlockOrder: 48,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: -52), curveToNext: .quadratic(control: CGPoint(x: 75, y: -68))),
            CourseWaypoint(position: CGPoint(x: 300, y: 4), curveToNext: .quadratic(control: CGPoint(x: 225, y: -10))),
            CourseWaypoint(position: CGPoint(x: 450, y: -56), curveToNext: .quadratic(control: CGPoint(x: 375, y: -72))),
            CourseWaypoint(position: CGPoint(x: 600, y: 4), curveToNext: .quadratic(control: CGPoint(x: 525, y: -12))),
            CourseWaypoint(position: CGPoint(x: 760, y: -60), curveToNext: .quadratic(control: CGPoint(x: 680, y: -76))),
            CourseWaypoint(position: CGPoint(x: 920, y: 4), curveToNext: .quadratic(control: CGPoint(x: 840, y: -10))),
            CourseWaypoint(position: CGPoint(x: 1090, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1005, y: -74))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1175, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1350, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1520, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.55, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.78, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.5
    )

    static let spiralHill = makeCourse(
        id: "spiralHill",
        displayName: "Spiral Hill",
        unlockOrder: 49,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -24), curveToNext: .quadratic(control: CGPoint(x: 100, y: -14))),
            CourseWaypoint(position: CGPoint(x: 440, y: -52), curveToNext: .quadratic(control: CGPoint(x: 320, y: -44))),
            CourseWaypoint(position: CGPoint(x: 680, y: -60), curveToNext: .quadratic(control: CGPoint(x: 560, y: -60))),
            CourseWaypoint(position: CGPoint(x: 880, y: -38), curveToNext: .quadratic(control: CGPoint(x: 780, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1060, y: 6), curveToNext: .quadratic(control: CGPoint(x: 970, y: -16))),
            CourseWaypoint(position: CGPoint(x: 1240, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1150, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1340, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1620, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1530, y: 34))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.58, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyTop]),
            StyleDefinition(startFraction: 0.58, endFraction: 0.78, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .racingYellow]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 3.8
    )

    // MARK: - Batch 10 courses

    static let waveRunner = makeCourse(
        id: "waveRunner",
        displayName: "Wave Runner",
        unlockOrder: 50,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -56), curveToNext: .quadratic(control: CGPoint(x: 100, y: -66))),
            CourseWaypoint(position: CGPoint(x: 400, y: 14), curveToNext: .quadratic(control: CGPoint(x: 300, y: 24))),
            CourseWaypoint(position: CGPoint(x: 600, y: -58), curveToNext: .quadratic(control: CGPoint(x: 500, y: -68))),
            CourseWaypoint(position: CGPoint(x: 800, y: 14), curveToNext: .quadratic(control: CGPoint(x: 700, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -56), curveToNext: .quadratic(control: CGPoint(x: 900, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1560, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1480, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1600, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.7, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
        ],
        ropeWidth: 47,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.8
    )

    static let cliffhanger = makeCourse(
        id: "cliffhanger",
        displayName: "Cliffhanger",
        unlockOrder: 51,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 100, y: -66))),
            CourseWaypoint(position: CGPoint(x: 400, y: -60), curveToNext: .quadratic(control: CGPoint(x: 300, y: -64))),
            CourseWaypoint(position: CGPoint(x: 580, y: -58), curveToNext: .quadratic(control: CGPoint(x: 490, y: -62))),
            CourseWaypoint(position: CGPoint(x: 760, y: -20), curveToNext: .quadratic(control: CGPoint(x: 670, y: -48))),
            CourseWaypoint(position: CGPoint(x: 940, y: 30), curveToNext: .quadratic(control: CGPoint(x: 850, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1030, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1210, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1480, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1390, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1570, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.52, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.52, endFraction: 0.75, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 115,
        maxPitchRadians: .pi / 3.2
    )

    static let zigzagCanyon = makeCourse(
        id: "zigzagCanyon",
        displayName: "Zigzag Canyon",
        unlockOrder: 52,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: -58), curveToNext: .quadratic(control: CGPoint(x: 75, y: -68))),
            CourseWaypoint(position: CGPoint(x: 300, y: 10), curveToNext: .quadratic(control: CGPoint(x: 225, y: 22))),
            CourseWaypoint(position: CGPoint(x: 450, y: 62), curveToNext: .quadratic(control: CGPoint(x: 375, y: 72))),
            CourseWaypoint(position: CGPoint(x: 600, y: -8), curveToNext: .quadratic(control: CGPoint(x: 525, y: -20))),
            CourseWaypoint(position: CGPoint(x: 750, y: -60), curveToNext: .quadratic(control: CGPoint(x: 675, y: -70))),
            CourseWaypoint(position: CGPoint(x: 900, y: 10), curveToNext: .quadratic(control: CGPoint(x: 825, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1050, y: 60), curveToNext: .quadratic(control: CGPoint(x: 975, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1125, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1350, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1275, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1425, y: 20))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1590, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: nil),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: nil),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .flameOrange]),
        ],
        ropeWidth: 44,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 3.2
    )

    static let thrillRide = makeCourse(
        id: "thrillRide",
        displayName: "Thrill Ride",
        unlockOrder: 53,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -24), curveToNext: .quadratic(control: CGPoint(x: 90, y: -34))),
            CourseWaypoint(position: CGPoint(x: 360, y: 6), curveToNext: .quadratic(control: CGPoint(x: 270, y: -4))),
            CourseWaypoint(position: CGPoint(x: 540, y: -40), curveToNext: .quadratic(control: CGPoint(x: 450, y: -54))),
            CourseWaypoint(position: CGPoint(x: 720, y: 8), curveToNext: .quadratic(control: CGPoint(x: 630, y: -6))),
            CourseWaypoint(position: CGPoint(x: 900, y: -56), curveToNext: .quadratic(control: CGPoint(x: 810, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 10), curveToNext: .quadratic(control: CGPoint(x: 990, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1580, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1510, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1700, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1640, y: -18))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.58, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.58, endFraction: 0.8, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.5
    )

    static let breakaway = makeCourse(
        id: "breakaway",
        displayName: "Breakaway",
        unlockOrder: 54,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -10), curveToNext: .quadratic(control: CGPoint(x: 80, y: -14))),
            CourseWaypoint(position: CGPoint(x: 320, y: 12), curveToNext: .quadratic(control: CGPoint(x: 240, y: 18))),
            CourseWaypoint(position: CGPoint(x: 480, y: -24), curveToNext: .quadratic(control: CGPoint(x: 400, y: -32))),
            CourseWaypoint(position: CGPoint(x: 640, y: 28), curveToNext: .quadratic(control: CGPoint(x: 560, y: 38))),
            CourseWaypoint(position: CGPoint(x: 800, y: -42), curveToNext: .quadratic(control: CGPoint(x: 720, y: -56))),
            CourseWaypoint(position: CGPoint(x: 960, y: 46), curveToNext: .quadratic(control: CGPoint(x: 880, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1580, y: 22), curveToNext: .quadratic(control: CGPoint(x: 1510, y: 32))),
            CourseWaypoint(position: CGPoint(x: 1720, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .electricBlue, ropeHighlight: .flameOrange, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .flameOrange, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .flameOrange]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 122,
        maxPitchRadians: .pi / 3.5
    )

    // MARK: - Batch 11 courses

    static let avalanche = makeCourse(
        id: "avalanche",
        displayName: "Avalanche",
        unlockOrder: 55,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -18), curveToNext: .quadratic(control: CGPoint(x: 100, y: -22))),
            CourseWaypoint(position: CGPoint(x: 380, y: 8), curveToNext: .quadratic(control: CGPoint(x: 290, y: 14))),
            CourseWaypoint(position: CGPoint(x: 540, y: -36), curveToNext: .quadratic(control: CGPoint(x: 460, y: -44))),
            CourseWaypoint(position: CGPoint(x: 680, y: 16), curveToNext: .quadratic(control: CGPoint(x: 610, y: 24))),
            CourseWaypoint(position: CGPoint(x: 820, y: -54), curveToNext: .quadratic(control: CGPoint(x: 750, y: -64))),
            CourseWaypoint(position: CGPoint(x: 940, y: 18), curveToNext: .quadratic(control: CGPoint(x: 880, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1060, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1160, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1110, y: 30))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1210, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1360, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1310, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1460, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1410, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1560, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1510, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1640, y: -22), curveToNext: .quadratic(control: CGPoint(x: 1600, y: -32))),
            CourseWaypoint(position: CGPoint(x: 1740, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1690, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.2, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.2, endFraction: 0.55, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.78, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3
    )

    static let thunderPass = makeCourse(
        id: "thunderPass",
        displayName: "Thunder Pass",
        unlockOrder: 56,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 170, y: -56), curveToNext: .quadratic(control: CGPoint(x: 85, y: -70))),
            CourseWaypoint(position: CGPoint(x: 340, y: 8), curveToNext: .quadratic(control: CGPoint(x: 255, y: -14))),
            CourseWaypoint(position: CGPoint(x: 520, y: 60), curveToNext: .quadratic(control: CGPoint(x: 430, y: 74))),
            CourseWaypoint(position: CGPoint(x: 700, y: -8), curveToNext: .quadratic(control: CGPoint(x: 610, y: 22))),
            CourseWaypoint(position: CGPoint(x: 870, y: -60), curveToNext: .quadratic(control: CGPoint(x: 785, y: -74))),
            CourseWaypoint(position: CGPoint(x: 1040, y: 10), curveToNext: .quadratic(control: CGPoint(x: 955, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1220, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1130, y: 72))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1310, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1580, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1490, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1670, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
        ],
        ropeWidth: 46,
        forwardSpeed: 122,
        maxPitchRadians: .pi / 3.2
    )

    static let cannonball = makeCourse(
        id: "cannonball",
        displayName: "Cannonball",
        unlockOrder: 57,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 4), curveToNext: .quadratic(control: CGPoint(x: 100, y: 6))),
            CourseWaypoint(position: CGPoint(x: 400, y: 6), curveToNext: .quadratic(control: CGPoint(x: 300, y: 8))),
            CourseWaypoint(position: CGPoint(x: 600, y: -52), curveToNext: .quadratic(control: CGPoint(x: 500, y: -70))),
            CourseWaypoint(position: CGPoint(x: 800, y: -60), curveToNext: .quadratic(control: CGPoint(x: 700, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -20), curveToNext: .quadratic(control: CGPoint(x: 900, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1180, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1090, y: -4))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1280, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1580, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1480, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1780, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1680, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.62, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .trackBlack]),
            StyleDefinition(startFraction: 0.62, endFraction: 0.82, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.82, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 3
    )

    static let whiplash = makeCourse(
        id: "whiplash",
        displayName: "Whiplash",
        unlockOrder: 58,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 120, y: 44), curveToNext: .quadratic(control: CGPoint(x: 60, y: 54))),
            CourseWaypoint(position: CGPoint(x: 240, y: -52), curveToNext: .quadratic(control: CGPoint(x: 180, y: -62))),
            CourseWaypoint(position: CGPoint(x: 360, y: 56), curveToNext: .quadratic(control: CGPoint(x: 300, y: 66))),
            CourseWaypoint(position: CGPoint(x: 480, y: -54), curveToNext: .quadratic(control: CGPoint(x: 420, y: -64))),
            CourseWaypoint(position: CGPoint(x: 600, y: 56), curveToNext: .quadratic(control: CGPoint(x: 540, y: 66))),
            CourseWaypoint(position: CGPoint(x: 720, y: -52), curveToNext: .quadratic(control: CGPoint(x: 660, y: -62))),
            CourseWaypoint(position: CGPoint(x: 840, y: 54), curveToNext: .quadratic(control: CGPoint(x: 780, y: 64))),
            CourseWaypoint(position: CGPoint(x: 960, y: -54), curveToNext: .quadratic(control: CGPoint(x: 900, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1020, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1140, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1260, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -30), curveToNext: .quadratic(control: CGPoint(x: 1380, y: -42))),
            CourseWaypoint(position: CGPoint(x: 1560, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1680, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1620, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1740, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.55, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.flameOrange, .hotRed]),
        ],
        ropeWidth: 44,
        forwardSpeed: 122,
        maxPitchRadians: .pi / 3.2
    )

    static let moonrise = makeCourse(
        id: "moonrise",
        displayName: "Moonrise",
        unlockOrder: 59,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 230, y: -18), curveToNext: .quadratic(control: CGPoint(x: 115, y: -10))),
            CourseWaypoint(position: CGPoint(x: 480, y: -44), curveToNext: .quadratic(control: CGPoint(x: 355, y: -34))),
            CourseWaypoint(position: CGPoint(x: 730, y: -62), curveToNext: .quadratic(control: CGPoint(x: 605, y: -56))),
            CourseWaypoint(position: CGPoint(x: 980, y: -60), curveToNext: .quadratic(control: CGPoint(x: 855, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1240, y: -38), curveToNext: .quadratic(control: CGPoint(x: 1110, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1370, y: -22))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1590, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1820, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 2))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .trackBlack]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: nil, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 48,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 4.5
    )

    // MARK: - Batch 12 courses

    static let rocketLaunch = makeCourse(
        id: "rocketLaunch",
        displayName: "Rocket Launch",
        unlockOrder: 60,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 4), curveToNext: .quadratic(control: CGPoint(x: 100, y: 6))),
            CourseWaypoint(position: CGPoint(x: 400, y: 6), curveToNext: .quadratic(control: CGPoint(x: 300, y: 8))),
            CourseWaypoint(position: CGPoint(x: 600, y: -44), curveToNext: .quadratic(control: CGPoint(x: 500, y: -58))),
            CourseWaypoint(position: CGPoint(x: 800, y: -62), curveToNext: .quadratic(control: CGPoint(x: 700, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -60), curveToNext: .quadratic(control: CGPoint(x: 900, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1100, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 12))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1840, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1720, y: 34))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.58, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.58, endFraction: 0.78, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .racingYellow]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3
    )

    static let freeFall = makeCourse(
        id: "freeFall",
        displayName: "Free Fall",
        unlockOrder: 61,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: -20), curveToNext: .quadratic(control: CGPoint(x: 75, y: -12))),
            CourseWaypoint(position: CGPoint(x: 300, y: -56), curveToNext: .quadratic(control: CGPoint(x: 225, y: -42))),
            CourseWaypoint(position: CGPoint(x: 460, y: -62), curveToNext: .quadratic(control: CGPoint(x: 380, y: -64))),
            CourseWaypoint(position: CGPoint(x: 620, y: -60), curveToNext: .quadratic(control: CGPoint(x: 540, y: -64))),
            CourseWaypoint(position: CGPoint(x: 780, y: -40), curveToNext: .quadratic(control: CGPoint(x: 700, y: -58))),
            CourseWaypoint(position: CGPoint(x: 940, y: 8), curveToNext: .quadratic(control: CGPoint(x: 860, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1100, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1020, y: 36))),
            CourseWaypoint(position: CGPoint(x: 1280, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1190, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1460, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1370, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1550, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1860, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .trackBlack]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .trackBlack, ropeHighlight: .hotRed, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.78, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 3
    )

    static let rollerStorm = makeCourse(
        id: "rollerStorm",
        displayName: "Roller Storm",
        unlockOrder: 62,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -58), curveToNext: .quadratic(control: CGPoint(x: 80, y: -70))),
            CourseWaypoint(position: CGPoint(x: 320, y: 14), curveToNext: .quadratic(control: CGPoint(x: 240, y: 22))),
            CourseWaypoint(position: CGPoint(x: 480, y: -60), curveToNext: .quadratic(control: CGPoint(x: 400, y: -72))),
            CourseWaypoint(position: CGPoint(x: 640, y: 14), curveToNext: .quadratic(control: CGPoint(x: 560, y: 22))),
            CourseWaypoint(position: CGPoint(x: 800, y: -56), curveToNext: .quadratic(control: CGPoint(x: 720, y: -68))),
            CourseWaypoint(position: CGPoint(x: 960, y: 16), curveToNext: .quadratic(control: CGPoint(x: 880, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1210, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1480, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1390, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1570, y: 24))),
            CourseWaypoint(position: CGPoint(x: 1880, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1770, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 120,
        maxPitchRadians: .pi / 3.5
    )

    static let tripleDecker = makeCourse(
        id: "tripleDecker",
        displayName: "Triple Decker",
        unlockOrder: 63,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -36), curveToNext: .quadratic(control: CGPoint(x: 90, y: -48))),
            CourseWaypoint(position: CGPoint(x: 380, y: -36), curveToNext: .quadratic(control: CGPoint(x: 280, y: -36))),
            CourseWaypoint(position: CGPoint(x: 560, y: -60), curveToNext: .quadratic(control: CGPoint(x: 470, y: -72))),
            CourseWaypoint(position: CGPoint(x: 740, y: -60), curveToNext: .quadratic(control: CGPoint(x: 650, y: -60))),
            CourseWaypoint(position: CGPoint(x: 920, y: -34), curveToNext: .quadratic(control: CGPoint(x: 830, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1100, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1010, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1190, y: 38))),
            CourseWaypoint(position: CGPoint(x: 1460, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1370, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1550, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1780, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1710, y: -30))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1840, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.2, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.2, endFraction: 0.42, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: nil),
            StyleDefinition(startFraction: 0.42, endFraction: 0.6, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: nil),
            StyleDefinition(startFraction: 0.6, endFraction: 0.8, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: nil),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 3.5
    )

    static let galaxyExpress = makeCourse(
        id: "galaxyExpress",
        displayName: "Galaxy Express",
        unlockOrder: 64,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 56), curveToNext: .quadratic(control: CGPoint(x: 100, y: 68))),
            CourseWaypoint(position: CGPoint(x: 420, y: -8), curveToNext: .quadratic(control: CGPoint(x: 310, y: 20))),
            CourseWaypoint(position: CGPoint(x: 640, y: -58), curveToNext: .quadratic(control: CGPoint(x: 530, y: -70))),
            CourseWaypoint(position: CGPoint(x: 860, y: 4), curveToNext: .quadratic(control: CGPoint(x: 750, y: -22))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 58), curveToNext: .quadratic(control: CGPoint(x: 970, y: 72))),
            CourseWaypoint(position: CGPoint(x: 1300, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1190, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1720, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1610, y: -16))),
            CourseWaypoint(position: CGPoint(x: 1920, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1820, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .trackBlack]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .trackBlack]),
        ],
        ropeWidth: 48,
        forwardSpeed: 116,
        maxPitchRadians: .pi / 4.5
    )

    // MARK: - Batch 13 courses

    static let neonRush = makeCourse(
        id: "neonRush",
        displayName: "Neon Rush",
        unlockOrder: 65,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -28), curveToNext: .quadratic(control: CGPoint(x: 80, y: -34))),
            CourseWaypoint(position: CGPoint(x: 320, y: 20), curveToNext: .quadratic(control: CGPoint(x: 240, y: 28))),
            CourseWaypoint(position: CGPoint(x: 480, y: -38), curveToNext: .quadratic(control: CGPoint(x: 400, y: -46))),
            CourseWaypoint(position: CGPoint(x: 640, y: 26), curveToNext: .quadratic(control: CGPoint(x: 560, y: 34))),
            CourseWaypoint(position: CGPoint(x: 800, y: -50), curveToNext: .quadratic(control: CGPoint(x: 720, y: -60))),
            CourseWaypoint(position: CGPoint(x: 960, y: 34), curveToNext: .quadratic(control: CGPoint(x: 880, y: 44))),
            CourseWaypoint(position: CGPoint(x: 1100, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1030, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1240, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1380, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1310, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1520, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1450, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1660, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1590, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1730, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1940, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1870, y: 22))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.electricBlue, .hotRed]),
        ],
        ropeWidth: 46,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 4
    )

    static let jungleSwing = makeCourse(
        id: "jungleSwing",
        displayName: "Jungle Swing",
        unlockOrder: 66,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 220, y: 52), curveToNext: .quadratic(control: CGPoint(x: 110, y: 64))),
            CourseWaypoint(position: CGPoint(x: 480, y: -6), curveToNext: .quadratic(control: CGPoint(x: 350, y: 18))),
            CourseWaypoint(position: CGPoint(x: 740, y: -60), curveToNext: .quadratic(control: CGPoint(x: 610, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 4), curveToNext: .quadratic(control: CGPoint(x: 870, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1130, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1520, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1390, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1780, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1650, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1960, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1870, y: -18))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.6, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: nil),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .hotRed]),
        ],
        ropeWidth: 44,
        forwardSpeed: 118,
        maxPitchRadians: .pi / 3.2
    )

    static let icePath = makeCourse(
        id: "icePath",
        displayName: "Ice Path",
        unlockOrder: 67,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: -28), curveToNext: .quadratic(control: CGPoint(x: 120, y: -16))),
            CourseWaypoint(position: CGPoint(x: 500, y: -52), curveToNext: .quadratic(control: CGPoint(x: 370, y: -44))),
            CourseWaypoint(position: CGPoint(x: 700, y: -14), curveToNext: .quadratic(control: CGPoint(x: 600, y: -44))),
            CourseWaypoint(position: CGPoint(x: 880, y: 40), curveToNext: .quadratic(control: CGPoint(x: 790, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 54), curveToNext: .quadratic(control: CGPoint(x: 980, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 50))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1350, y: -4))),
            CourseWaypoint(position: CGPoint(x: 1640, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1540, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1840, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1740, y: -16))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1910, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.58, ropeStroke: .electricBlue, ropeHighlight: nil, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.58, endFraction: 0.82, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.82, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 112,
        maxPitchRadians: .pi / 4
    )

    static let tornadoAlley = makeCourse(
        id: "tornadoAlley",
        displayName: "Tornado Alley",
        unlockOrder: 68,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 140, y: 42), curveToNext: .quadratic(control: CGPoint(x: 70, y: 52))),
            CourseWaypoint(position: CGPoint(x: 300, y: -58), curveToNext: .quadratic(control: CGPoint(x: 220, y: -70))),
            CourseWaypoint(position: CGPoint(x: 440, y: -10), curveToNext: .quadratic(control: CGPoint(x: 370, y: -34))),
            CourseWaypoint(position: CGPoint(x: 580, y: 54), curveToNext: .quadratic(control: CGPoint(x: 510, y: 68))),
            CourseWaypoint(position: CGPoint(x: 720, y: 16), curveToNext: .quadratic(control: CGPoint(x: 650, y: 36))),
            CourseWaypoint(position: CGPoint(x: 860, y: -56), curveToNext: .quadratic(control: CGPoint(x: 790, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 4), curveToNext: .quadratic(control: CGPoint(x: 930, y: -26))),
            CourseWaypoint(position: CGPoint(x: 1140, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1070, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1280, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1210, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1420, y: 28), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1510, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1680, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1830, y: -26))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1950, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 122,
        maxPitchRadians: .pi / 3
    )

    static let stormChaser = makeCourse(
        id: "stormChaser",
        displayName: "Storm Chaser",
        unlockOrder: 69,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -22), curveToNext: .quadratic(control: CGPoint(x: 90, y: -28))),
            CourseWaypoint(position: CGPoint(x: 360, y: 10), curveToNext: .quadratic(control: CGPoint(x: 270, y: 18))),
            CourseWaypoint(position: CGPoint(x: 540, y: -38), curveToNext: .quadratic(control: CGPoint(x: 450, y: -48))),
            CourseWaypoint(position: CGPoint(x: 720, y: 14), curveToNext: .quadratic(control: CGPoint(x: 630, y: 22))),
            CourseWaypoint(position: CGPoint(x: 900, y: -50), curveToNext: .quadratic(control: CGPoint(x: 810, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 18), curveToNext: .quadratic(control: CGPoint(x: 990, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1250, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1165, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1420, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1335, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1580, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1740, y: 22), curveToNext: .quadratic(control: CGPoint(x: 1660, y: 30))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1820, y: -50))),
            CourseWaypoint(position: CGPoint(x: 2020, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1960, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .trackBlack]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.55, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.78, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.electricBlue, .hotRed]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 45,
        forwardSpeed: 124,
        maxPitchRadians: .pi / 3.5
    )

    // MARK: - Batch 14

    static let fireWalk = makeCourse(
        id: "fireWalk",
        displayName: "Fire Walk",
        unlockOrder: 70,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 140, y: -52), curveToNext: .quadratic(control: CGPoint(x: 70, y: -62))),
            CourseWaypoint(position: CGPoint(x: 280, y: 44), curveToNext: .quadratic(control: CGPoint(x: 210, y: 56))),
            CourseWaypoint(position: CGPoint(x: 420, y: -54), curveToNext: .quadratic(control: CGPoint(x: 350, y: -64))),
            CourseWaypoint(position: CGPoint(x: 560, y: 46), curveToNext: .quadratic(control: CGPoint(x: 490, y: 58))),
            CourseWaypoint(position: CGPoint(x: 700, y: -56), curveToNext: .quadratic(control: CGPoint(x: 630, y: -66))),
            CourseWaypoint(position: CGPoint(x: 840, y: 48), curveToNext: .quadratic(control: CGPoint(x: 770, y: 60))),
            CourseWaypoint(position: CGPoint(x: 980, y: -56), curveToNext: .quadratic(control: CGPoint(x: 910, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1050, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1190, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1330, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1560, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1480, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1720, y: 34), curveToNext: .quadratic(control: CGPoint(x: 1640, y: 44))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1810, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2040, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1970, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 126
    )

    static let crystalBridge = makeCourse(
        id: "crystalBridge",
        displayName: "Crystal Bridge",
        unlockOrder: 71,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -56), curveToNext: .quadratic(control: CGPoint(x: 90, y: -68))),
            CourseWaypoint(position: CGPoint(x: 360, y: 24), curveToNext: .quadratic(control: CGPoint(x: 270, y: 12))),
            CourseWaypoint(position: CGPoint(x: 560, y: 52), curveToNext: .quadratic(control: CGPoint(x: 460, y: 66))),
            CourseWaypoint(position: CGPoint(x: 760, y: -12), curveToNext: .quadratic(control: CGPoint(x: 660, y: 20))),
            CourseWaypoint(position: CGPoint(x: 940, y: -60), curveToNext: .quadratic(control: CGPoint(x: 850, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1030, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1220, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1520, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1420, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1720, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1620, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1810, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2060, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1980, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118
    )

    static let sandDunes = makeCourse(
        id: "sandDunes",
        displayName: "Sand Dunes",
        unlockOrder: 72,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -44), curveToNext: .quadratic(control: CGPoint(x: 100, y: -52))),
            CourseWaypoint(position: CGPoint(x: 400, y: 6), curveToNext: .quadratic(control: CGPoint(x: 300, y: -4))),
            CourseWaypoint(position: CGPoint(x: 580, y: -50), curveToNext: .quadratic(control: CGPoint(x: 490, y: -58))),
            CourseWaypoint(position: CGPoint(x: 760, y: 4), curveToNext: .quadratic(control: CGPoint(x: 670, y: -6))),
            CourseWaypoint(position: CGPoint(x: 960, y: -46), curveToNext: .quadratic(control: CGPoint(x: 860, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1160, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1060, y: -4))),
            CourseWaypoint(position: CGPoint(x: 1340, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1250, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1540, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1440, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1720, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1630, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1810, y: -4))),
            CourseWaypoint(position: CGPoint(x: 2080, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1990, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 122
    )

    static let skyHook = makeCourse(
        id: "skyHook",
        displayName: "Sky Hook",
        unlockOrder: 73,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -54), curveToNext: .quadratic(control: CGPoint(x: 80, y: -70))),
            CourseWaypoint(position: CGPoint(x: 320, y: 22), curveToNext: .quadratic(control: CGPoint(x: 240, y: 6))),
            CourseWaypoint(position: CGPoint(x: 500, y: 44), curveToNext: .quadratic(control: CGPoint(x: 410, y: 56))),
            CourseWaypoint(position: CGPoint(x: 680, y: -16), curveToNext: .quadratic(control: CGPoint(x: 590, y: 14))),
            CourseWaypoint(position: CGPoint(x: 860, y: -58), curveToNext: .quadratic(control: CGPoint(x: 770, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1040, y: 24), curveToNext: .quadratic(control: CGPoint(x: 950, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1240, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1140, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1420, y: -14), curveToNext: .quadratic(control: CGPoint(x: 1330, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1510, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1700, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 36), curveToNext: .quadratic(control: CGPoint(x: 1890, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2040, y: 18))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.6, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 124,
        maxPitchRadians: .pi / 3.5
    )

    static let mudSlide = makeCourse(
        id: "mudSlide",
        displayName: "Mud Slide",
        unlockOrder: 74,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 46), curveToNext: .quadratic(control: CGPoint(x: 90, y: 58))),
            CourseWaypoint(position: CGPoint(x: 360, y: -8), curveToNext: .quadratic(control: CGPoint(x: 270, y: 6))),
            CourseWaypoint(position: CGPoint(x: 540, y: 56), curveToNext: .quadratic(control: CGPoint(x: 450, y: 68))),
            CourseWaypoint(position: CGPoint(x: 720, y: -4), curveToNext: .quadratic(control: CGPoint(x: 630, y: 10))),
            CourseWaypoint(position: CGPoint(x: 920, y: 52), curveToNext: .quadratic(control: CGPoint(x: 820, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1020, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1220, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1410, y: 12))),
            CourseWaypoint(position: CGPoint(x: 1700, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1600, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1880, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1790, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2120, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2000, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.32, ropeStroke: .trackBlack, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.32, endFraction: 0.68, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 120
    )

    // MARK: - Batch 25 (Final)

    static let grandFinale = makeCourse(
        id: "grandFinale",
        displayName: "Grand Finale",
        unlockOrder: 125,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -24), curveToNext: .quadratic(control: CGPoint(x: 80, y: -30))),
            CourseWaypoint(position: CGPoint(x: 320, y: 24), curveToNext: .quadratic(control: CGPoint(x: 240, y: 30))),
            CourseWaypoint(position: CGPoint(x: 480, y: -26), curveToNext: .quadratic(control: CGPoint(x: 400, y: -32))),
            CourseWaypoint(position: CGPoint(x: 640, y: 26), curveToNext: .quadratic(control: CGPoint(x: 560, y: 32))),
            CourseWaypoint(position: CGPoint(x: 800, y: -24), curveToNext: .quadratic(control: CGPoint(x: 720, y: -30))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 54), curveToNext: .quadratic(control: CGPoint(x: 900, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1700, y: 70))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1950, y: 34))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -32), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2550, y: -34))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 2))),
            CourseWaypoint(position: CGPoint(x: 3140, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3070, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.22, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.22, endFraction: 0.44, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.44, endFraction: 0.66, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.66, endFraction: 0.88, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .hotRed]),
            StyleDefinition(startFraction: 0.88, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132
    )

    static let eternityBridge = makeCourse(
        id: "eternityBridge",
        displayName: "Eternity Bridge",
        unlockOrder: 126,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: -46), curveToNext: .quadratic(control: CGPoint(x: 150, y: -58))),
            CourseWaypoint(position: CGPoint(x: 600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 450, y: -12))),
            CourseWaypoint(position: CGPoint(x: 900, y: -44), curveToNext: .quadratic(control: CGPoint(x: 750, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1350, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1650, y: -14))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1950, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -14))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2550, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2960, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2830, y: -22))),
            CourseWaypoint(position: CGPoint(x: 3160, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3060, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132
    )

    static let legendsRun = makeCourse(
        id: "legendsRun",
        displayName: "Legends Run",
        unlockOrder: 127,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 220, y: -48), curveToNext: .quadratic(control: CGPoint(x: 110, y: -60))),
            CourseWaypoint(position: CGPoint(x: 440, y: 38), curveToNext: .quadratic(control: CGPoint(x: 330, y: 22))),
            CourseWaypoint(position: CGPoint(x: 660, y: 52), curveToNext: .quadratic(control: CGPoint(x: 550, y: 64))),
            CourseWaypoint(position: CGPoint(x: 880, y: -16), curveToNext: .quadratic(control: CGPoint(x: 770, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1100, y: -56), curveToNext: .quadratic(control: CGPoint(x: 990, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 36), curveToNext: .quadratic(control: CGPoint(x: 1210, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1540, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1430, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1980, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1870, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 34), curveToNext: .quadratic(control: CGPoint(x: 2090, y: 18))),
            CourseWaypoint(position: CGPoint(x: 2420, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2310, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2640, y: -12), curveToNext: .quadratic(control: CGPoint(x: 2530, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2860, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2750, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3060, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2960, y: 2))),
            CourseWaypoint(position: CGPoint(x: 3180, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3120, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .racingYellow]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132
    )

    static let ultimateWire = makeCourse(
        id: "ultimateWire",
        displayName: "Ultimate Wire",
        unlockOrder: 128,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -46), curveToNext: .quadratic(control: CGPoint(x: 90, y: -56))),
            CourseWaypoint(position: CGPoint(x: 360, y: 46), curveToNext: .quadratic(control: CGPoint(x: 270, y: 56))),
            CourseWaypoint(position: CGPoint(x: 540, y: -50), curveToNext: .quadratic(control: CGPoint(x: 450, y: -60))),
            CourseWaypoint(position: CGPoint(x: 720, y: 52), curveToNext: .quadratic(control: CGPoint(x: 630, y: 62))),
            CourseWaypoint(position: CGPoint(x: 900, y: -54), curveToNext: .quadratic(control: CGPoint(x: 810, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 54), curveToNext: .quadratic(control: CGPoint(x: 990, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1170, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1620, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1530, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1710, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1980, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1890, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2160, y: 54), curveToNext: .quadratic(control: CGPoint(x: 2070, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2340, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2520, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2430, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2610, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2900, y: 28), curveToNext: .quadratic(control: CGPoint(x: 2800, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3060, y: -16), curveToNext: .quadratic(control: CGPoint(x: 2980, y: -4))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3130, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.2, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.2, endFraction: 0.4, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.6, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .hotRed]),
            StyleDefinition(startFraction: 0.6, endFraction: 0.8, ropeStroke: .flameOrange, ropeHighlight: .electricBlue, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 134
    )

    // MARK: - Batch 24

    static let supernova = makeCourse(
        id: "supernova",
        displayName: "Supernova",
        unlockOrder: 120,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -24), curveToNext: .quadratic(control: CGPoint(x: 100, y: -30))),
            CourseWaypoint(position: CGPoint(x: 400, y: 24), curveToNext: .quadratic(control: CGPoint(x: 300, y: 30))),
            CourseWaypoint(position: CGPoint(x: 600, y: -36), curveToNext: .quadratic(control: CGPoint(x: 500, y: -44))),
            CourseWaypoint(position: CGPoint(x: 800, y: 38), curveToNext: .quadratic(control: CGPoint(x: 700, y: 46))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -50), curveToNext: .quadratic(control: CGPoint(x: 900, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -40), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 38), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -26), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -36))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -10), curveToNext: .quadratic(control: CGPoint(x: 2900, y: -16))),
            CourseWaypoint(position: CGPoint(x: 3040, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3020, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.55, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.hotRed, .racingYellow]),
            StyleDefinition(startFraction: 0.55, endFraction: 0.8, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132
    )

    static let ashField = makeCourse(
        id: "ashField",
        displayName: "Ash Field",
        unlockOrder: 121,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 350, y: 44), curveToNext: .quadratic(control: CGPoint(x: 175, y: 54))),
            CourseWaypoint(position: CGPoint(x: 700, y: 28), curveToNext: .quadratic(control: CGPoint(x: 525, y: 38))),
            CourseWaypoint(position: CGPoint(x: 1050, y: -22), curveToNext: .quadratic(control: CGPoint(x: 875, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1225, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1750, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1925, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2450, y: 30), curveToNext: .quadratic(control: CGPoint(x: 2275, y: 42))),
            CourseWaypoint(position: CGPoint(x: 2750, y: -26), curveToNext: .quadratic(control: CGPoint(x: 2600, y: 4))),
            CourseWaypoint(position: CGPoint(x: 3060, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2905, y: -10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.38, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.38, endFraction: 0.72, ropeStroke: .flameOrange, ropeHighlight: .trackBlack, skyGradient: [.flameOrange, .trackBlack]),
            StyleDefinition(startFraction: 0.72, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 128
    )

    static let polarVortex = makeCourse(
        id: "polarVortex",
        displayName: "Polar Vortex",
        unlockOrder: 122,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: -28), curveToNext: .quadratic(control: CGPoint(x: 250, y: -36))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 26), curveToNext: .quadratic(control: CGPoint(x: 750, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1300, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1150, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1450, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1375, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1525, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1750, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1675, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1825, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2050, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1975, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2350, y: -26), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -36))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2525, y: 4))),
            CourseWaypoint(position: CGPoint(x: 3080, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2890, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 130
    )

    static let abyssWalk = makeCourse(
        id: "abyssWalk",
        displayName: "Abyss Walk",
        unlockOrder: 123,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: -8), curveToNext: .quadratic(control: CGPoint(x: 200, y: -10))),
            CourseWaypoint(position: CGPoint(x: 600, y: -56), curveToNext: .quadratic(control: CGPoint(x: 500, y: -70))),
            CourseWaypoint(position: CGPoint(x: 800, y: -4), curveToNext: .quadratic(control: CGPoint(x: 700, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -16))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1800, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -58), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -70))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2300, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2550, y: -10))),
            CourseWaypoint(position: CGPoint(x: 2900, y: -54), curveToNext: .quadratic(control: CGPoint(x: 2800, y: -66))),
            CourseWaypoint(position: CGPoint(x: 3100, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3000, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132
    )

    static let fierceWind = makeCourse(
        id: "fierceWind",
        displayName: "Fierce Wind",
        unlockOrder: 124,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 250, y: -44), curveToNext: .quadratic(control: CGPoint(x: 125, y: -56))),
            CourseWaypoint(position: CGPoint(x: 400, y: 48), curveToNext: .quadratic(control: CGPoint(x: 325, y: 62))),
            CourseWaypoint(position: CGPoint(x: 600, y: -46), curveToNext: .quadratic(control: CGPoint(x: 500, y: -58))),
            CourseWaypoint(position: CGPoint(x: 850, y: -50), curveToNext: .quadratic(control: CGPoint(x: 725, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 52), curveToNext: .quadratic(control: CGPoint(x: 925, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1100, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1350, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1650, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1575, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1850, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1975, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2300, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2200, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2500, y: -46), curveToNext: .quadratic(control: CGPoint(x: 2400, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2750, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2625, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2950, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 58))),
            CourseWaypoint(position: CGPoint(x: 3120, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3035, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.32, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.skyTop, .racingYellow]),
            StyleDefinition(startFraction: 0.32, endFraction: 0.68, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 130
    )

    // MARK: - Batch 23

    static let starfall = makeCourse(
        id: "starfall",
        displayName: "Starfall",
        unlockOrder: 115,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -44), curveToNext: .quadratic(control: CGPoint(x: 100, y: -56))),
            CourseWaypoint(position: CGPoint(x: 400, y: -58), curveToNext: .quadratic(control: CGPoint(x: 300, y: -68))),
            CourseWaypoint(position: CGPoint(x: 580, y: -28), curveToNext: .quadratic(control: CGPoint(x: 490, y: -42))),
            CourseWaypoint(position: CGPoint(x: 760, y: 30), curveToNext: .quadratic(control: CGPoint(x: 670, y: 18))),
            CourseWaypoint(position: CGPoint(x: 940, y: -40), curveToNext: .quadratic(control: CGPoint(x: 850, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1030, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1300, y: -22), curveToNext: .quadratic(control: CGPoint(x: 1210, y: -36))),
            CourseWaypoint(position: CGPoint(x: 1480, y: 34), curveToNext: .quadratic(control: CGPoint(x: 1390, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1660, y: -38), curveToNext: .quadratic(control: CGPoint(x: 1570, y: -50))),
            CourseWaypoint(position: CGPoint(x: 1840, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -70))),
            CourseWaypoint(position: CGPoint(x: 2020, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1930, y: -32))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2110, y: 24))),
            CourseWaypoint(position: CGPoint(x: 2420, y: -32), curveToNext: .quadratic(control: CGPoint(x: 2310, y: -44))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 14), curveToNext: .quadratic(control: CGPoint(x: 2560, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2940, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2820, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .racingYellow]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 41,
        forwardSpeed: 132,
        maxPitchRadians: .pi / 3
    )

    static let mudBog = makeCourse(
        id: "mudBog",
        displayName: "Mud Bog",
        unlockOrder: 116,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: 52), curveToNext: .quadratic(control: CGPoint(x: 150, y: 62))),
            CourseWaypoint(position: CGPoint(x: 700, y: 46), curveToNext: .quadratic(control: CGPoint(x: 500, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -34), curveToNext: .quadratic(control: CGPoint(x: 850, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1300, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1150, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1450, y: 0))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 68))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 38), curveToNext: .quadratic(control: CGPoint(x: 2050, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2500, y: -30), curveToNext: .quadratic(control: CGPoint(x: 2350, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -46), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2960, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2830, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .flameOrange, ropeHighlight: .trackBlack, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 126
    )

    static let diamondDust = makeCourse(
        id: "diamondDust",
        displayName: "Diamond Dust",
        unlockOrder: 117,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -48), curveToNext: .quadratic(control: CGPoint(x: 100, y: -58))),
            CourseWaypoint(position: CGPoint(x: 400, y: 50), curveToNext: .quadratic(control: CGPoint(x: 300, y: 60))),
            CourseWaypoint(position: CGPoint(x: 600, y: -50), curveToNext: .quadratic(control: CGPoint(x: 500, y: -60))),
            CourseWaypoint(position: CGPoint(x: 800, y: 48), curveToNext: .quadratic(control: CGPoint(x: 700, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -52), curveToNext: .quadratic(control: CGPoint(x: 900, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -42), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 16), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2980, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2890, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 128
    )

    static let infernoRun = makeCourse(
        id: "infernoRun",
        displayName: "Inferno Run",
        unlockOrder: 118,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -56), curveToNext: .quadratic(control: CGPoint(x: 90, y: -68))),
            CourseWaypoint(position: CGPoint(x: 360, y: 28), curveToNext: .quadratic(control: CGPoint(x: 270, y: 12))),
            CourseWaypoint(position: CGPoint(x: 520, y: -60), curveToNext: .quadratic(control: CGPoint(x: 440, y: -72))),
            CourseWaypoint(position: CGPoint(x: 680, y: 24), curveToNext: .quadratic(control: CGPoint(x: 600, y: 8))),
            CourseWaypoint(position: CGPoint(x: 840, y: -48), curveToNext: .quadratic(control: CGPoint(x: 760, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 32), curveToNext: .quadratic(control: CGPoint(x: 920, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1160, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1080, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 26), curveToNext: .quadratic(control: CGPoint(x: 1240, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1480, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 30), curveToNext: .quadratic(control: CGPoint(x: 1560, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1820, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1730, y: -72))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 28), curveToNext: .quadratic(control: CGPoint(x: 1910, y: 14))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 26), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 22), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 6))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2900, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.6, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .hotRed]),
        ],
        ropeWidth: 42,
        forwardSpeed: 130
    )

    static let tundraGlide = makeCourse(
        id: "tundraGlide",
        displayName: "Tundra Glide",
        unlockOrder: 119,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: -38), curveToNext: .quadratic(control: CGPoint(x: 200, y: -48))),
            CourseWaypoint(position: CGPoint(x: 800, y: 14), curveToNext: .quadratic(control: CGPoint(x: 600, y: 2))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1000, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1400, y: 26))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1800, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2600, y: 46))),
            CourseWaypoint(position: CGPoint(x: 3020, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2910, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.38, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.38, endFraction: 0.72, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.72, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 128
    )

    // MARK: - Batch 22

    static let shadowRun = makeCourse(
        id: "shadowRun",
        displayName: "Shadow Run",
        unlockOrder: 110,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -56), curveToNext: .quadratic(control: CGPoint(x: 80, y: -68))),
            CourseWaypoint(position: CGPoint(x: 320, y: 18), curveToNext: .quadratic(control: CGPoint(x: 240, y: 4))),
            CourseWaypoint(position: CGPoint(x: 500, y: 50), curveToNext: .quadratic(control: CGPoint(x: 410, y: 62))),
            CourseWaypoint(position: CGPoint(x: 680, y: -12), curveToNext: .quadratic(control: CGPoint(x: 590, y: 14))),
            CourseWaypoint(position: CGPoint(x: 860, y: -58), curveToNext: .quadratic(control: CGPoint(x: 770, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1040, y: 14), curveToNext: .quadratic(control: CGPoint(x: 950, y: 2))),
            CourseWaypoint(position: CGPoint(x: 1220, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1130, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1310, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1580, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1490, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1670, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1960, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1860, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2160, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2060, y: 12))),
            CourseWaypoint(position: CGPoint(x: 2360, y: -58), curveToNext: .quadratic(control: CGPoint(x: 2260, y: -70))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2480, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2840, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2720, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 3.5
    )

    static let comet = makeCourse(
        id: "comet",
        displayName: "Comet",
        unlockOrder: 111,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: -12), curveToNext: .quadratic(control: CGPoint(x: 200, y: -16))),
            CourseWaypoint(position: CGPoint(x: 700, y: -56), curveToNext: .quadratic(control: CGPoint(x: 550, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 20), curveToNext: .quadratic(control: CGPoint(x: 850, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1700, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1550, y: 66))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -14), curveToNext: .quadratic(control: CGPoint(x: 1850, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -10))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -56), curveToNext: .quadratic(control: CGPoint(x: 2550, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2860, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2780, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 41,
        forwardSpeed: 136,
        maxPitchRadians: .pi / 3
    )

    static let glacierGap = makeCourse(
        id: "glacierGap",
        displayName: "Glacier Gap",
        unlockOrder: 112,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: -8), curveToNext: .quadratic(control: CGPoint(x: 120, y: -12))),
            CourseWaypoint(position: CGPoint(x: 440, y: -56), curveToNext: .quadratic(control: CGPoint(x: 340, y: -68))),
            CourseWaypoint(position: CGPoint(x: 640, y: 12), curveToNext: .quadratic(control: CGPoint(x: 540, y: 0))),
            CourseWaypoint(position: CGPoint(x: 920, y: 8), curveToNext: .quadratic(control: CGPoint(x: 780, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1020, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1220, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1460, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 0))),
            CourseWaypoint(position: CGPoint(x: 2280, y: 8), curveToNext: .quadratic(control: CGPoint(x: 2140, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2480, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2380, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2680, y: 14), curveToNext: .quadratic(control: CGPoint(x: 2580, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2880, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2780, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 126,
        maxPitchRadians: .pi / 3.5
    )

    static let boulderPass = makeCourse(
        id: "boulderPass",
        displayName: "Boulder Pass",
        unlockOrder: 113,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 52), curveToNext: .quadratic(control: CGPoint(x: 90, y: 64))),
            CourseWaypoint(position: CGPoint(x: 360, y: -16), curveToNext: .quadratic(control: CGPoint(x: 270, y: -4))),
            CourseWaypoint(position: CGPoint(x: 540, y: -58), curveToNext: .quadratic(control: CGPoint(x: 450, y: -70))),
            CourseWaypoint(position: CGPoint(x: 720, y: 14), curveToNext: .quadratic(control: CGPoint(x: 630, y: 2))),
            CourseWaypoint(position: CGPoint(x: 900, y: 54), curveToNext: .quadratic(control: CGPoint(x: 810, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1080, y: -14), curveToNext: .quadratic(control: CGPoint(x: 990, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1170, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 0))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1540, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1840, y: -14), curveToNext: .quadratic(control: CGPoint(x: 1740, y: -2))),
            CourseWaypoint(position: CGPoint(x: 2040, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1940, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 16), curveToNext: .quadratic(control: CGPoint(x: 2140, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2460, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2350, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2580, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2900, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2800, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 41,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 3
    )

    static let typhoonTrack = makeCourse(
        id: "typhoonTrack",
        displayName: "Typhoon Track",
        unlockOrder: 114,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -28), curveToNext: .quadratic(control: CGPoint(x: 80, y: -36))),
            CourseWaypoint(position: CGPoint(x: 320, y: 32), curveToNext: .quadratic(control: CGPoint(x: 240, y: 40))),
            CourseWaypoint(position: CGPoint(x: 480, y: -40), curveToNext: .quadratic(control: CGPoint(x: 400, y: -52))),
            CourseWaypoint(position: CGPoint(x: 640, y: 46), curveToNext: .quadratic(control: CGPoint(x: 560, y: 58))),
            CourseWaypoint(position: CGPoint(x: 800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 720, y: -64))),
            CourseWaypoint(position: CGPoint(x: 960, y: 58), curveToNext: .quadratic(control: CGPoint(x: 880, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1460, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1370, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1560, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1880, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1770, y: -48))),
            CourseWaypoint(position: CGPoint(x: 2120, y: 24), curveToNext: .quadratic(control: CGPoint(x: 2000, y: 34))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -12), curveToNext: .quadratic(control: CGPoint(x: 2260, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2720, y: 8), curveToNext: .quadratic(control: CGPoint(x: 2560, y: 0))),
            CourseWaypoint(position: CGPoint(x: 2920, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2820, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.32, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.32, endFraction: 0.68, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 41,
        forwardSpeed: 132,
        maxPitchRadians: .pi / 3
    )

    // MARK: - Batch 21

    static let phantomRoad = makeCourse(
        id: "phantomRoad",
        displayName: "Phantom Road",
        unlockOrder: 105,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: -8), curveToNext: .quadratic(control: CGPoint(x: 150, y: -12))),
            CourseWaypoint(position: CGPoint(x: 500, y: -54), curveToNext: .quadratic(control: CGPoint(x: 400, y: -66))),
            CourseWaypoint(position: CGPoint(x: 700, y: 8), curveToNext: .quadratic(control: CGPoint(x: 600, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 6), curveToNext: .quadratic(control: CGPoint(x: 850, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1550, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1800, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 10), curveToNext: .quadratic(control: CGPoint(x: 2000, y: -4))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2500, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2740, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2670, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .ropeHighlightGray, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .trackBlack, skyGradient: [.skyTop, .trackBlack]),
        ],
        ropeWidth: 42,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 3.5
    )

    static let reedSwamp = makeCourse(
        id: "reedSwamp",
        displayName: "Reed Swamp",
        unlockOrder: 106,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 44), curveToNext: .quadratic(control: CGPoint(x: 90, y: 56))),
            CourseWaypoint(position: CGPoint(x: 360, y: -8), curveToNext: .quadratic(control: CGPoint(x: 270, y: 4))),
            CourseWaypoint(position: CGPoint(x: 540, y: -52), curveToNext: .quadratic(control: CGPoint(x: 450, y: -64))),
            CourseWaypoint(position: CGPoint(x: 720, y: 12), curveToNext: .quadratic(control: CGPoint(x: 630, y: -2))),
            CourseWaypoint(position: CGPoint(x: 900, y: 56), curveToNext: .quadratic(control: CGPoint(x: 810, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1080, y: -6), curveToNext: .quadratic(control: CGPoint(x: 990, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1170, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 2))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1540, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1840, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1740, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2040, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1940, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 16), curveToNext: .quadratic(control: CGPoint(x: 2140, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2500, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2370, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2760, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2630, y: 14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .flameOrange]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 124
    )

    static let crystalCave = makeCourse(
        id: "crystalCave",
        displayName: "Crystal Cave",
        unlockOrder: 107,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -42), curveToNext: .quadratic(control: CGPoint(x: 100, y: -54))),
            CourseWaypoint(position: CGPoint(x: 400, y: 10), curveToNext: .quadratic(control: CGPoint(x: 300, y: -2))),
            CourseWaypoint(position: CGPoint(x: 600, y: 48), curveToNext: .quadratic(control: CGPoint(x: 500, y: 60))),
            CourseWaypoint(position: CGPoint(x: 800, y: -6), curveToNext: .quadratic(control: CGPoint(x: 700, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -44), curveToNext: .quadratic(control: CGPoint(x: 900, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 0))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1900, y: -2))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2100, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -40), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2780, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2690, y: -10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .skyBottom, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 126
    )

    static let jetStream = makeCourse(
        id: "jetStream",
        displayName: "Jet Stream",
        unlockOrder: 108,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 280, y: -50), curveToNext: .quadratic(control: CGPoint(x: 140, y: -62))),
            CourseWaypoint(position: CGPoint(x: 560, y: 12), curveToNext: .quadratic(control: CGPoint(x: 420, y: 0))),
            CourseWaypoint(position: CGPoint(x: 840, y: 54), curveToNext: .quadratic(control: CGPoint(x: 700, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -8), curveToNext: .quadratic(control: CGPoint(x: 980, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1260, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1540, y: 2))),
            CourseWaypoint(position: CGPoint(x: 1960, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1820, y: 68))),
            CourseWaypoint(position: CGPoint(x: 2240, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2100, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2520, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2380, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2660, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .racingYellow]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.6, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 134,
        maxPitchRadians: .pi / 3
    )

    static let emberPath = makeCourse(
        id: "emberPath",
        displayName: "Ember Path",
        unlockOrder: 109,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 24), curveToNext: .quadratic(control: CGPoint(x: 90, y: 32))),
            CourseWaypoint(position: CGPoint(x: 360, y: 50), curveToNext: .quadratic(control: CGPoint(x: 270, y: 60))),
            CourseWaypoint(position: CGPoint(x: 540, y: 44), curveToNext: .quadratic(control: CGPoint(x: 450, y: 56))),
            CourseWaypoint(position: CGPoint(x: 720, y: 8), curveToNext: .quadratic(control: CGPoint(x: 630, y: 26))),
            CourseWaypoint(position: CGPoint(x: 900, y: -42), curveToNext: .quadratic(control: CGPoint(x: 810, y: -28))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 22), curveToNext: .quadratic(control: CGPoint(x: 990, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1620, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1530, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1710, y: -30))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1890, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2160, y: 54), curveToNext: .quadratic(control: CGPoint(x: 2070, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2380, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2270, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -12), curveToNext: .quadratic(control: CGPoint(x: 2490, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2820, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2710, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.32, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.32, endFraction: 0.68, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 128
    )

    // MARK: - Batch 20

    static let blazeTrail = makeCourse(
        id: "blazeTrail",
        displayName: "Blaze Trail",
        unlockOrder: 100,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 44), curveToNext: .quadratic(control: CGPoint(x: 100, y: 56))),
            CourseWaypoint(position: CGPoint(x: 380, y: -16), curveToNext: .quadratic(control: CGPoint(x: 290, y: -4))),
            CourseWaypoint(position: CGPoint(x: 560, y: -58), curveToNext: .quadratic(control: CGPoint(x: 470, y: -70))),
            CourseWaypoint(position: CGPoint(x: 740, y: 8), curveToNext: .quadratic(control: CGPoint(x: 650, y: -6))),
            CourseWaypoint(position: CGPoint(x: 920, y: 52), curveToNext: .quadratic(control: CGPoint(x: 830, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1100, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1010, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1280, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1190, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1460, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1370, y: 0))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1560, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1860, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1760, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2060, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1960, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2260, y: 14), curveToNext: .quadratic(control: CGPoint(x: 2160, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2460, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2360, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2640, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 3.5
    )

    static let silverStream = makeCourse(
        id: "silverStream",
        displayName: "Silver Stream",
        unlockOrder: 101,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -36), curveToNext: .quadratic(control: CGPoint(x: 100, y: -46))),
            CourseWaypoint(position: CGPoint(x: 400, y: 14), curveToNext: .quadratic(control: CGPoint(x: 300, y: 4))),
            CourseWaypoint(position: CGPoint(x: 600, y: 50), curveToNext: .quadratic(control: CGPoint(x: 500, y: 62))),
            CourseWaypoint(position: CGPoint(x: 800, y: -8), curveToNext: .quadratic(control: CGPoint(x: 700, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -44), curveToNext: .quadratic(control: CGPoint(x: 900, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2220, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2110, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2460, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2340, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2660, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2560, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.42, ropeStroke: .ropeHighlightGray, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.42, endFraction: 0.78, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .ropeHighlightGray, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 120
    )

    static let obsidianWay = makeCourse(
        id: "obsidianWay",
        displayName: "Obsidian Way",
        unlockOrder: 102,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 140, y: -54), curveToNext: .quadratic(control: CGPoint(x: 70, y: -66))),
            CourseWaypoint(position: CGPoint(x: 280, y: -28), curveToNext: .quadratic(control: CGPoint(x: 210, y: -40))),
            CourseWaypoint(position: CGPoint(x: 440, y: 48), curveToNext: .quadratic(control: CGPoint(x: 360, y: 36))),
            CourseWaypoint(position: CGPoint(x: 600, y: 56), curveToNext: .quadratic(control: CGPoint(x: 520, y: 66))),
            CourseWaypoint(position: CGPoint(x: 760, y: -10), curveToNext: .quadratic(control: CGPoint(x: 680, y: 18))),
            CourseWaypoint(position: CGPoint(x: 920, y: -58), curveToNext: .quadratic(control: CGPoint(x: 840, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1080, y: -30), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -42))),
            CourseWaypoint(position: CGPoint(x: 1240, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1160, y: 38))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1320, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1560, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1480, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1720, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1640, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -26), curveToNext: .quadratic(control: CGPoint(x: 1810, y: -38))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2000, y: 32))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 16), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 28))),
            CourseWaypoint(position: CGPoint(x: 2680, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2540, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .electricBlue, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132,
        maxPitchRadians: .pi / 3
    )

    static let prismPath = makeCourse(
        id: "prismPath",
        displayName: "Prism Path",
        unlockOrder: 103,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: 30), curveToNext: .quadratic(control: CGPoint(x: 120, y: 38))),
            CourseWaypoint(position: CGPoint(x: 480, y: 52), curveToNext: .quadratic(control: CGPoint(x: 360, y: 62))),
            CourseWaypoint(position: CGPoint(x: 720, y: 42), curveToNext: .quadratic(control: CGPoint(x: 600, y: 54))),
            CourseWaypoint(position: CGPoint(x: 960, y: 10), curveToNext: .quadratic(control: CGPoint(x: 840, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -28), curveToNext: .quadratic(control: CGPoint(x: 1080, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1320, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1680, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1560, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1920, y: -16), curveToNext: .quadratic(control: CGPoint(x: 1800, y: -30))),
            CourseWaypoint(position: CGPoint(x: 2160, y: 24), curveToNext: .quadratic(control: CGPoint(x: 2040, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2280, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 18))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 126
    )

    static let wildWest = makeCourse(
        id: "wildWest",
        displayName: "Wild West",
        unlockOrder: 104,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: -18), curveToNext: .quadratic(control: CGPoint(x: 150, y: -24))),
            CourseWaypoint(position: CGPoint(x: 560, y: 12), curveToNext: .quadratic(control: CGPoint(x: 430, y: 4))),
            CourseWaypoint(position: CGPoint(x: 720, y: -56), curveToNext: .quadratic(control: CGPoint(x: 640, y: -70))),
            CourseWaypoint(position: CGPoint(x: 880, y: 54), curveToNext: .quadratic(control: CGPoint(x: 800, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1040, y: -8), curveToNext: .quadratic(control: CGPoint(x: 960, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1280, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1160, y: -28))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1520, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1680, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2020, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1890, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -58), curveToNext: .quadratic(control: CGPoint(x: 2110, y: -70))),
            CourseWaypoint(position: CGPoint(x: 2380, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2290, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2560, y: -10), curveToNext: .quadratic(control: CGPoint(x: 2470, y: 12))),
            CourseWaypoint(position: CGPoint(x: 2720, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2640, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 3.5
    )

    // MARK: - Batch 19

    static let neonGrid = makeCourse(
        id: "neonGrid",
        displayName: "Neon Grid",
        unlockOrder: 95,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -52), curveToNext: .quadratic(control: CGPoint(x: 80, y: -64))),
            CourseWaypoint(position: CGPoint(x: 320, y: 52), curveToNext: .quadratic(control: CGPoint(x: 240, y: 64))),
            CourseWaypoint(position: CGPoint(x: 480, y: -52), curveToNext: .quadratic(control: CGPoint(x: 400, y: -64))),
            CourseWaypoint(position: CGPoint(x: 640, y: 52), curveToNext: .quadratic(control: CGPoint(x: 560, y: 64))),
            CourseWaypoint(position: CGPoint(x: 800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 720, y: -64))),
            CourseWaypoint(position: CGPoint(x: 960, y: 52), curveToNext: .quadratic(control: CGPoint(x: 880, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1520, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1680, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1920, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1840, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -24), curveToNext: .quadratic(control: CGPoint(x: 2010, y: -36))),
            CourseWaypoint(position: CGPoint(x: 2320, y: 12), curveToNext: .quadratic(control: CGPoint(x: 2210, y: 0))),
            CourseWaypoint(position: CGPoint(x: 2540, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2430, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .trackBlack]),
        ],
        ropeWidth: 42,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 3.5
    )

    static let peakDive = makeCourse(
        id: "peakDive",
        displayName: "Peak Dive",
        unlockOrder: 96,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: 46), curveToNext: .quadratic(control: CGPoint(x: 80, y: 58))),
            CourseWaypoint(position: CGPoint(x: 340, y: -56), curveToNext: .quadratic(control: CGPoint(x: 250, y: -68))),
            CourseWaypoint(position: CGPoint(x: 520, y: 52), curveToNext: .quadratic(control: CGPoint(x: 430, y: 64))),
            CourseWaypoint(position: CGPoint(x: 700, y: -60), curveToNext: .quadratic(control: CGPoint(x: 610, y: -72))),
            CourseWaypoint(position: CGPoint(x: 880, y: 48), curveToNext: .quadratic(control: CGPoint(x: 790, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1060, y: -56), curveToNext: .quadratic(control: CGPoint(x: 970, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1240, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1150, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1420, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1330, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1510, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1780, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1690, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1960, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1870, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2080, y: -22))),
            CourseWaypoint(position: CGPoint(x: 2560, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2380, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.skyTop, .hotRed]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 132,
        maxPitchRadians: .pi / 3
    )

    static let coralReef = makeCourse(
        id: "coralReef",
        displayName: "Coral Reef",
        unlockOrder: 97,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 40), curveToNext: .quadratic(control: CGPoint(x: 90, y: 52))),
            CourseWaypoint(position: CGPoint(x: 340, y: -16), curveToNext: .quadratic(control: CGPoint(x: 260, y: -4))),
            CourseWaypoint(position: CGPoint(x: 500, y: -54), curveToNext: .quadratic(control: CGPoint(x: 420, y: -66))),
            CourseWaypoint(position: CGPoint(x: 680, y: 22), curveToNext: .quadratic(control: CGPoint(x: 590, y: 8))),
            CourseWaypoint(position: CGPoint(x: 860, y: 52), curveToNext: .quadratic(control: CGPoint(x: 770, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1040, y: -8), curveToNext: .quadratic(control: CGPoint(x: 950, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1220, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1130, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1310, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1580, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1490, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -12), curveToNext: .quadratic(control: CGPoint(x: 1670, y: 2))),
            CourseWaypoint(position: CGPoint(x: 1940, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1850, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2120, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2030, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2360, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2240, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2580, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2470, y: 14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .flameOrange]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .electricBlue]),
        ],
        ropeWidth: 44,
        forwardSpeed: 124
    )

    static let ironGate = makeCourse(
        id: "ironGate",
        displayName: "Iron Gate",
        unlockOrder: 98,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 100, y: -42), curveToNext: .quadratic(control: CGPoint(x: 50, y: -54))),
            CourseWaypoint(position: CGPoint(x: 200, y: 42), curveToNext: .quadratic(control: CGPoint(x: 150, y: 54))),
            CourseWaypoint(position: CGPoint(x: 300, y: -44), curveToNext: .quadratic(control: CGPoint(x: 250, y: -56))),
            CourseWaypoint(position: CGPoint(x: 400, y: 44), curveToNext: .quadratic(control: CGPoint(x: 350, y: 56))),
            CourseWaypoint(position: CGPoint(x: 500, y: -46), curveToNext: .quadratic(control: CGPoint(x: 450, y: -58))),
            CourseWaypoint(position: CGPoint(x: 600, y: 46), curveToNext: .quadratic(control: CGPoint(x: 550, y: 58))),
            CourseWaypoint(position: CGPoint(x: 740, y: -50), curveToNext: .quadratic(control: CGPoint(x: 670, y: -62))),
            CourseWaypoint(position: CGPoint(x: 900, y: 52), curveToNext: .quadratic(control: CGPoint(x: 820, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1100, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1210, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1560, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1440, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1680, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2040, y: -12), curveToNext: .quadratic(control: CGPoint(x: 1920, y: -22))),
            CourseWaypoint(position: CGPoint(x: 2320, y: 4), curveToNext: .quadratic(control: CGPoint(x: 2180, y: -2))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2460, y: 2))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .trackBlack]),
        ],
        ropeWidth: 42,
        forwardSpeed: 126
    )

    static let swingLow = makeCourse(
        id: "swingLow",
        displayName: "Swing Low",
        unlockOrder: 99,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: -16), curveToNext: .quadratic(control: CGPoint(x: 120, y: -22))),
            CourseWaypoint(position: CGPoint(x: 480, y: 0), curveToNext: .quadratic(control: CGPoint(x: 360, y: 4))),
            CourseWaypoint(position: CGPoint(x: 700, y: -32), curveToNext: .quadratic(control: CGPoint(x: 590, y: -40))),
            CourseWaypoint(position: CGPoint(x: 920, y: 0), curveToNext: .quadratic(control: CGPoint(x: 810, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1020, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1220, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1410, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1590, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1860, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1770, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2040, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1950, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2220, y: -30), curveToNext: .quadratic(control: CGPoint(x: 2130, y: -40))),
            CourseWaypoint(position: CGPoint(x: 2420, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2320, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2620, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2520, y: 0))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 128
    )

    // MARK: - Batch 18

    static let spiderWeb = makeCourse(
        id: "spiderWeb",
        displayName: "Spider Web",
        unlockOrder: 90,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: -48), curveToNext: .quadratic(control: CGPoint(x: 75, y: -62))),
            CourseWaypoint(position: CGPoint(x: 300, y: 30), curveToNext: .quadratic(control: CGPoint(x: 225, y: 18))),
            CourseWaypoint(position: CGPoint(x: 480, y: 54), curveToNext: .quadratic(control: CGPoint(x: 390, y: 66))),
            CourseWaypoint(position: CGPoint(x: 660, y: -18), curveToNext: .quadratic(control: CGPoint(x: 570, y: 12))),
            CourseWaypoint(position: CGPoint(x: 820, y: -58), curveToNext: .quadratic(control: CGPoint(x: 740, y: -70))),
            CourseWaypoint(position: CGPoint(x: 980, y: 12), curveToNext: .quadratic(control: CGPoint(x: 900, y: 0))),
            CourseWaypoint(position: CGPoint(x: 1160, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1070, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1340, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1250, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1420, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1580, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1840, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2020, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1930, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 2110, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2440, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2320, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.68, ropeStroke: .electricBlue, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 126
    )

    static let moonWalk = makeCourse(
        id: "moonWalk",
        displayName: "Moon Walk",
        unlockOrder: 91,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 260, y: -52), curveToNext: .quadratic(control: CGPoint(x: 130, y: -64))),
            CourseWaypoint(position: CGPoint(x: 520, y: 8), curveToNext: .quadratic(control: CGPoint(x: 390, y: -4))),
            CourseWaypoint(position: CGPoint(x: 780, y: 56), curveToNext: .quadratic(control: CGPoint(x: 650, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1040, y: -6), curveToNext: .quadratic(control: CGPoint(x: 910, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1300, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1170, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1560, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1430, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1820, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1690, y: 66))),
            CourseWaypoint(position: CGPoint(x: 2080, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1950, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2460, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2270, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .ropeHighlightGray, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .trackBlack]),
        ],
        ropeWidth: 43,
        forwardSpeed: 122
    )

    static let lavaRidge = makeCourse(
        id: "lavaRidge",
        displayName: "Lava Ridge",
        unlockOrder: 92,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -54), curveToNext: .quadratic(control: CGPoint(x: 80, y: -66))),
            CourseWaypoint(position: CGPoint(x: 300, y: -24), curveToNext: .quadratic(control: CGPoint(x: 230, y: -36))),
            CourseWaypoint(position: CGPoint(x: 460, y: -58), curveToNext: .quadratic(control: CGPoint(x: 380, y: -70))),
            CourseWaypoint(position: CGPoint(x: 620, y: 10), curveToNext: .quadratic(control: CGPoint(x: 540, y: -4))),
            CourseWaypoint(position: CGPoint(x: 780, y: 44), curveToNext: .quadratic(control: CGPoint(x: 700, y: 56))),
            CourseWaypoint(position: CGPoint(x: 960, y: -38), curveToNext: .quadratic(control: CGPoint(x: 870, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1140, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1220, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1460, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1380, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1640, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1550, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1820, y: -62), curveToNext: .quadratic(control: CGPoint(x: 1730, y: -74))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1910, y: -2))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2120, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2480, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2360, y: 14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 3
    )

    static let frostBite = makeCourse(
        id: "frostBite",
        displayName: "Frost Bite",
        unlockOrder: 93,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: -50), curveToNext: .quadratic(control: CGPoint(x: 75, y: -64))),
            CourseWaypoint(position: CGPoint(x: 300, y: 8), curveToNext: .quadratic(control: CGPoint(x: 225, y: -4))),
            CourseWaypoint(position: CGPoint(x: 460, y: 44), curveToNext: .quadratic(control: CGPoint(x: 380, y: 56))),
            CourseWaypoint(position: CGPoint(x: 600, y: -12), curveToNext: .quadratic(control: CGPoint(x: 530, y: 10))),
            CourseWaypoint(position: CGPoint(x: 740, y: -56), curveToNext: .quadratic(control: CGPoint(x: 670, y: -68))),
            CourseWaypoint(position: CGPoint(x: 880, y: 8), curveToNext: .quadratic(control: CGPoint(x: 810, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1040, y: 48), curveToNext: .quadratic(control: CGPoint(x: 960, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1120, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1360, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1280, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1520, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1440, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1700, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1610, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1880, y: -12), curveToNext: .quadratic(control: CGPoint(x: 1790, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2060, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1970, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2280, y: 14), curveToNext: .quadratic(control: CGPoint(x: 2170, y: 0))),
            CourseWaypoint(position: CGPoint(x: 2500, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2390, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 124,
        maxPitchRadians: .pi / 3.5
    )

    static let canyonWind = makeCourse(
        id: "canyonWind",
        displayName: "Canyon Wind",
        unlockOrder: 94,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -28), curveToNext: .quadratic(control: CGPoint(x: 100, y: -36))),
            CourseWaypoint(position: CGPoint(x: 420, y: -56), curveToNext: .quadratic(control: CGPoint(x: 310, y: -66))),
            CourseWaypoint(position: CGPoint(x: 640, y: -48), curveToNext: .quadratic(control: CGPoint(x: 530, y: -58))),
            CourseWaypoint(position: CGPoint(x: 860, y: -12), curveToNext: .quadratic(control: CGPoint(x: 750, y: -30))),
            CourseWaypoint(position: CGPoint(x: 1060, y: 36), curveToNext: .quadratic(control: CGPoint(x: 960, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1160, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1460, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1360, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1560, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1860, y: -40), curveToNext: .quadratic(control: CGPoint(x: 1760, y: -26))),
            CourseWaypoint(position: CGPoint(x: 2060, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1960, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2260, y: -30), curveToNext: .quadratic(control: CGPoint(x: 2160, y: -46))),
            CourseWaypoint(position: CGPoint(x: 2520, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2390, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.32, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.skyTop, .racingYellow]),
            StyleDefinition(startFraction: 0.32, endFraction: 0.68, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 126
    )

    // MARK: - Batch 17

    static let sunkenShip = makeCourse(
        id: "sunkenShip",
        displayName: "Sunken Ship",
        unlockOrder: 85,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 52), curveToNext: .quadratic(control: CGPoint(x: 100, y: 64))),
            CourseWaypoint(position: CGPoint(x: 400, y: -8), curveToNext: .quadratic(control: CGPoint(x: 300, y: 4))),
            CourseWaypoint(position: CGPoint(x: 580, y: -56), curveToNext: .quadratic(control: CGPoint(x: 490, y: -68))),
            CourseWaypoint(position: CGPoint(x: 760, y: 4), curveToNext: .quadratic(control: CGPoint(x: 670, y: -8))),
            CourseWaypoint(position: CGPoint(x: 960, y: 50), curveToNext: .quadratic(control: CGPoint(x: 860, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1160, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1060, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1360, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1260, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1560, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1460, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1660, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1960, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1860, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2160, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2060, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2340, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.32, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.32, endFraction: 0.68, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.68, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 124
    )

    static let glassWalk = makeCourse(
        id: "glassWalk",
        displayName: "Glass Walk",
        unlockOrder: 86,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -40), curveToNext: .quadratic(control: CGPoint(x: 90, y: -52))),
            CourseWaypoint(position: CGPoint(x: 360, y: 12), curveToNext: .quadratic(control: CGPoint(x: 270, y: 0))),
            CourseWaypoint(position: CGPoint(x: 560, y: 44), curveToNext: .quadratic(control: CGPoint(x: 460, y: 56))),
            CourseWaypoint(position: CGPoint(x: 760, y: -8), curveToNext: .quadratic(control: CGPoint(x: 660, y: 4))),
            CourseWaypoint(position: CGPoint(x: 940, y: -42), curveToNext: .quadratic(control: CGPoint(x: 850, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1030, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1220, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1520, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1420, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1610, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1880, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1790, y: 0))),
            CourseWaypoint(position: CGPoint(x: 2080, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1980, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2360, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2220, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.42, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.42, endFraction: 0.78, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.78, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 42,
        forwardSpeed: 120
    )

    static let dustDevil = makeCourse(
        id: "dustDevil",
        displayName: "Dust Devil",
        unlockOrder: 87,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -22), curveToNext: .quadratic(control: CGPoint(x: 100, y: -30))),
            CourseWaypoint(position: CGPoint(x: 380, y: 30), curveToNext: .quadratic(control: CGPoint(x: 290, y: 38))),
            CourseWaypoint(position: CGPoint(x: 520, y: -44), curveToNext: .quadratic(control: CGPoint(x: 450, y: -54))),
            CourseWaypoint(position: CGPoint(x: 640, y: 52), curveToNext: .quadratic(control: CGPoint(x: 580, y: 62))),
            CourseWaypoint(position: CGPoint(x: 740, y: -58), curveToNext: .quadratic(control: CGPoint(x: 690, y: -68))),
            CourseWaypoint(position: CGPoint(x: 840, y: 56), curveToNext: .quadratic(control: CGPoint(x: 790, y: 66))),
            CourseWaypoint(position: CGPoint(x: 940, y: -54), curveToNext: .quadratic(control: CGPoint(x: 890, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1060, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1000, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1130, y: -46))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1290, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -14), curveToNext: .quadratic(control: CGPoint(x: 1490, y: -20))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 0))),
            CourseWaypoint(position: CGPoint(x: 2180, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2040, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2380, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2280, y: 0))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 3.5
    )

    static let rainForest = makeCourse(
        id: "rainForest",
        displayName: "Rain Forest",
        unlockOrder: 88,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: 48), curveToNext: .quadratic(control: CGPoint(x: 80, y: 60))),
            CourseWaypoint(position: CGPoint(x: 320, y: 12), curveToNext: .quadratic(control: CGPoint(x: 240, y: 26))),
            CourseWaypoint(position: CGPoint(x: 480, y: -52), curveToNext: .quadratic(control: CGPoint(x: 400, y: -64))),
            CourseWaypoint(position: CGPoint(x: 640, y: 8), curveToNext: .quadratic(control: CGPoint(x: 560, y: -8))),
            CourseWaypoint(position: CGPoint(x: 800, y: 44), curveToNext: .quadratic(control: CGPoint(x: 720, y: 56))),
            CourseWaypoint(position: CGPoint(x: 980, y: -20), curveToNext: .quadratic(control: CGPoint(x: 890, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1160, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1070, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1340, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1520, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1430, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1610, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1880, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1790, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2060, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1970, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2150, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2320, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.38, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .flameOrange]),
            StyleDefinition(startFraction: 0.38, endFraction: 0.72, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.72, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 122
    )

    static let stoneBridge = makeCourse(
        id: "stoneBridge",
        displayName: "Stone Bridge",
        unlockOrder: 89,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -48), curveToNext: .quadratic(control: CGPoint(x: 100, y: -60))),
            CourseWaypoint(position: CGPoint(x: 400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 300, y: -12))),
            CourseWaypoint(position: CGPoint(x: 600, y: -48), curveToNext: .quadratic(control: CGPoint(x: 500, y: -60))),
            CourseWaypoint(position: CGPoint(x: 800, y: 0), curveToNext: .quadratic(control: CGPoint(x: 700, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -48), curveToNext: .quadratic(control: CGPoint(x: 900, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1100, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1900, y: -12))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2420, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2310, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.62, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.62, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
        ],
        ropeWidth: 44,
        forwardSpeed: 126
    )

    // MARK: - Batch 16

    static let pinballRun = makeCourse(
        id: "pinballRun",
        displayName: "Pinball Run",
        unlockOrder: 80,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 140, y: -44), curveToNext: .quadratic(control: CGPoint(x: 70, y: -56))),
            CourseWaypoint(position: CGPoint(x: 280, y: 40), curveToNext: .quadratic(control: CGPoint(x: 210, y: 52))),
            CourseWaypoint(position: CGPoint(x: 420, y: -48), curveToNext: .quadratic(control: CGPoint(x: 350, y: -60))),
            CourseWaypoint(position: CGPoint(x: 560, y: 44), curveToNext: .quadratic(control: CGPoint(x: 490, y: 56))),
            CourseWaypoint(position: CGPoint(x: 700, y: -50), curveToNext: .quadratic(control: CGPoint(x: 630, y: -62))),
            CourseWaypoint(position: CGPoint(x: 840, y: 46), curveToNext: .quadratic(control: CGPoint(x: 770, y: 58))),
            CourseWaypoint(position: CGPoint(x: 980, y: -52), curveToNext: .quadratic(control: CGPoint(x: 910, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1050, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1280, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1200, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1360, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1520, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1680, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1920, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1840, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2080, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2000, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2160, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.28, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.28, endFraction: 0.6, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .racingYellow]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130,
        maxPitchRadians: .pi / 3
    )

    static let bambooPath = makeCourse(
        id: "bambooPath",
        displayName: "Bamboo Path",
        unlockOrder: 81,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -46), curveToNext: .quadratic(control: CGPoint(x: 100, y: -58))),
            CourseWaypoint(position: CGPoint(x: 400, y: 8), curveToNext: .quadratic(control: CGPoint(x: 300, y: -4))),
            CourseWaypoint(position: CGPoint(x: 600, y: 50), curveToNext: .quadratic(control: CGPoint(x: 500, y: 62))),
            CourseWaypoint(position: CGPoint(x: 800, y: -10), curveToNext: .quadratic(control: CGPoint(x: 700, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -48), curveToNext: .quadratic(control: CGPoint(x: 900, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1100, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2060, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1930, y: -2))),
            CourseWaypoint(position: CGPoint(x: 2260, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2160, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .flameOrange]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 118
    )

    static let magmaFlow = makeCourse(
        id: "magmaFlow",
        displayName: "Magma Flow",
        unlockOrder: 82,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -20), curveToNext: .quadratic(control: CGPoint(x: 90, y: -28))),
            CourseWaypoint(position: CGPoint(x: 380, y: -46), curveToNext: .quadratic(control: CGPoint(x: 280, y: -56))),
            CourseWaypoint(position: CGPoint(x: 580, y: -58), curveToNext: .quadratic(control: CGPoint(x: 480, y: -68))),
            CourseWaypoint(position: CGPoint(x: 780, y: -28), curveToNext: .quadratic(control: CGPoint(x: 680, y: -42))),
            CourseWaypoint(position: CGPoint(x: 980, y: 40), curveToNext: .quadratic(control: CGPoint(x: 880, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1160, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1070, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1340, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1540, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1440, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1740, y: -60), curveToNext: .quadratic(control: CGPoint(x: 1640, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1940, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1840, y: -38))),
            CourseWaypoint(position: CGPoint(x: 2140, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2040, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2280, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2210, y: 14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .hotRed]),
        ],
        ropeWidth: 44,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 3.5
    )

    static let arcticWind = makeCourse(
        id: "arcticWind",
        displayName: "Arctic Wind",
        unlockOrder: 83,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -52), curveToNext: .quadratic(control: CGPoint(x: 80, y: -66))),
            CourseWaypoint(position: CGPoint(x: 320, y: 14), curveToNext: .quadratic(control: CGPoint(x: 240, y: 2))),
            CourseWaypoint(position: CGPoint(x: 500, y: -48), curveToNext: .quadratic(control: CGPoint(x: 410, y: -62))),
            CourseWaypoint(position: CGPoint(x: 680, y: 12), curveToNext: .quadratic(control: CGPoint(x: 590, y: -2))),
            CourseWaypoint(position: CGPoint(x: 880, y: -56), curveToNext: .quadratic(control: CGPoint(x: 780, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 16), curveToNext: .quadratic(control: CGPoint(x: 980, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1170, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1350, y: -4))),
            CourseWaypoint(position: CGPoint(x: 1620, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1530, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1820, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1720, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2060, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1940, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2300, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2180, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 126,
        maxPitchRadians: .pi / 3.5
    )

    static let thunderBolt = makeCourse(
        id: "thunderBolt",
        displayName: "Thunder Bolt",
        unlockOrder: 84,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 140, y: -58), curveToNext: .quadratic(control: CGPoint(x: 70, y: -72))),
            CourseWaypoint(position: CGPoint(x: 280, y: 18), curveToNext: .quadratic(control: CGPoint(x: 210, y: 4))),
            CourseWaypoint(position: CGPoint(x: 460, y: 52), curveToNext: .quadratic(control: CGPoint(x: 370, y: 64))),
            CourseWaypoint(position: CGPoint(x: 640, y: -14), curveToNext: .quadratic(control: CGPoint(x: 550, y: 16))),
            CourseWaypoint(position: CGPoint(x: 800, y: -60), curveToNext: .quadratic(control: CGPoint(x: 720, y: -72))),
            CourseWaypoint(position: CGPoint(x: 960, y: 20), curveToNext: .quadratic(control: CGPoint(x: 880, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1140, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1050, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1320, y: -12), curveToNext: .quadratic(control: CGPoint(x: 1230, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1480, y: -62), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -74))),
            CourseWaypoint(position: CGPoint(x: 1640, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1560, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1820, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1730, y: 66))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1910, y: 12))),
            CourseWaypoint(position: CGPoint(x: 2160, y: -56), curveToNext: .quadratic(control: CGPoint(x: 2080, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2320, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2240, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .racingYellow]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.6, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 43,
        forwardSpeed: 132,
        maxPitchRadians: .pi / 3
    )

    // MARK: - Batch 15

    static let volcanoPeak = makeCourse(
        id: "volcanoPeak",
        displayName: "Volcano Peak",
        unlockOrder: 75,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: -56), curveToNext: .quadratic(control: CGPoint(x: 75, y: -70))),
            CourseWaypoint(position: CGPoint(x: 300, y: 12), curveToNext: .quadratic(control: CGPoint(x: 225, y: -2))),
            CourseWaypoint(position: CGPoint(x: 450, y: -60), curveToNext: .quadratic(control: CGPoint(x: 375, y: -74))),
            CourseWaypoint(position: CGPoint(x: 600, y: 8), curveToNext: .quadratic(control: CGPoint(x: 525, y: -6))),
            CourseWaypoint(position: CGPoint(x: 750, y: 44), curveToNext: .quadratic(control: CGPoint(x: 675, y: 58))),
            CourseWaypoint(position: CGPoint(x: 900, y: -48), curveToNext: .quadratic(control: CGPoint(x: 825, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1060, y: 20), curveToNext: .quadratic(control: CGPoint(x: 980, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1220, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1140, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1540, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1460, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1620, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1860, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1780, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1930, y: -32))),
            CourseWaypoint(position: CGPoint(x: 2140, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2070, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.6, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 128,
        maxPitchRadians: .pi / 3.5
    )

    static let frozenLake = makeCourse(
        id: "frozenLake",
        displayName: "Frozen Lake",
        unlockOrder: 76,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: -38), curveToNext: .quadratic(control: CGPoint(x: 120, y: -50))),
            CourseWaypoint(position: CGPoint(x: 480, y: 6), curveToNext: .quadratic(control: CGPoint(x: 360, y: -4))),
            CourseWaypoint(position: CGPoint(x: 720, y: 42), curveToNext: .quadratic(control: CGPoint(x: 600, y: 54))),
            CourseWaypoint(position: CGPoint(x: 960, y: -6), curveToNext: .quadratic(control: CGPoint(x: 840, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -40), curveToNext: .quadratic(control: CGPoint(x: 1080, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1320, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1560, y: 50))),
            CourseWaypoint(position: CGPoint(x: 1920, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2160, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2040, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.45, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.45, endFraction: 0.8, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.8, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 46,
        forwardSpeed: 116
    )

    static let desertCross = makeCourse(
        id: "desertCross",
        displayName: "Desert Cross",
        unlockOrder: 77,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -32), curveToNext: .quadratic(control: CGPoint(x: 90, y: -42))),
            CourseWaypoint(position: CGPoint(x: 360, y: 18), curveToNext: .quadratic(control: CGPoint(x: 270, y: 6))),
            CourseWaypoint(position: CGPoint(x: 560, y: 48), curveToNext: .quadratic(control: CGPoint(x: 460, y: 60))),
            CourseWaypoint(position: CGPoint(x: 740, y: -22), curveToNext: .quadratic(control: CGPoint(x: 650, y: 8))),
            CourseWaypoint(position: CGPoint(x: 920, y: -52), curveToNext: .quadratic(control: CGPoint(x: 830, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1100, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1010, y: 2))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1480, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1390, y: 12))),
            CourseWaypoint(position: CGPoint(x: 1680, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1580, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1880, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1780, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2180, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2030, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 125
    )

    static let cloudSurfer = makeCourse(
        id: "cloudSurfer",
        displayName: "Cloud Surfer",
        unlockOrder: 78,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 220, y: 42), curveToNext: .quadratic(control: CGPoint(x: 110, y: 54))),
            CourseWaypoint(position: CGPoint(x: 440, y: -8), curveToNext: .quadratic(control: CGPoint(x: 330, y: 6))),
            CourseWaypoint(position: CGPoint(x: 660, y: -46), curveToNext: .quadratic(control: CGPoint(x: 550, y: -58))),
            CourseWaypoint(position: CGPoint(x: 880, y: 10), curveToNext: .quadratic(control: CGPoint(x: 770, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1100, y: 44), curveToNext: .quadratic(control: CGPoint(x: 990, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1320, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1210, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1540, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1430, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 12), curveToNext: .quadratic(control: CGPoint(x: 1650, y: -2))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1870, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2090, y: 12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 126,
        maxPitchRadians: .pi / 3.5
    )

    static let tideRunner = makeCourse(
        id: "tideRunner",
        displayName: "Tide Runner",
        unlockOrder: 79,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -48), curveToNext: .quadratic(control: CGPoint(x: 90, y: -60))),
            CourseWaypoint(position: CGPoint(x: 360, y: 6), curveToNext: .quadratic(control: CGPoint(x: 270, y: -6))),
            CourseWaypoint(position: CGPoint(x: 540, y: 52), curveToNext: .quadratic(control: CGPoint(x: 450, y: 64))),
            CourseWaypoint(position: CGPoint(x: 720, y: -4), curveToNext: .quadratic(control: CGPoint(x: 630, y: 8))),
            CourseWaypoint(position: CGPoint(x: 900, y: -50), curveToNext: .quadratic(control: CGPoint(x: 810, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 6), curveToNext: .quadratic(control: CGPoint(x: 990, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1260, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1170, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1620, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1530, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1710, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2020, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1910, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2220, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2120, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 122
    )

    // MARK: - Builders

    private struct StyleDefinition {
        let startFraction: Double
        let endFraction: Double
        let ropeStroke: CourseColor
        let ropeHighlight: CourseColor?
        let skyGradient: [CourseColor]?
    }

    private static let longHaulWaypoints: [CourseWaypoint] = {
        var points: [CourseWaypoint] = [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
        ]
        let segmentCount = 14
        let segmentLength: CGFloat = 140
        for index in 1 ... segmentCount {
            let x = CGFloat(index) * segmentLength
            let wave = sin(Double(index) * 0.9) * 32
            let y = CGFloat(wave)
            let controlOffset = CGFloat(cos(Double(index) * 0.7) * 44)
            if index < segmentCount {
                points.append(
                    CourseWaypoint(
                        position: CGPoint(x: x, y: y),
                        curveToNext: .quadratic(
                            control: CGPoint(x: x - segmentLength * 0.5, y: y + controlOffset)
                        )
                    )
                )
            } else {
                points.append(CourseWaypoint(position: CGPoint(x: x, y: 0)))
            }
        }
        return points
    }()

    private static let desertDashWaypoints: [CourseWaypoint] = {
        var points: [CourseWaypoint] = [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
        ]
        let segmentCount = 11
        let segmentLength: CGFloat = 155
        for index in 1 ... segmentCount {
            let x = CGFloat(index) * segmentLength
            let wave = sin(Double(index) * 0.8) * 24
            let y = CGFloat(wave)
            let controlOffset = CGFloat(cos(Double(index) * 0.65) * 32)
            if index < segmentCount {
                points.append(
                    CourseWaypoint(
                        position: CGPoint(x: x, y: y),
                        curveToNext: .quadratic(
                            control: CGPoint(x: x - segmentLength * 0.5, y: y + controlOffset)
                        )
                    )
                )
            } else {
                points.append(CourseWaypoint(position: CGPoint(x: x, y: 0)))
            }
        }
        return points
    }()

    private static let sunsetCruiseWaypoints: [CourseWaypoint] = {
        var points: [CourseWaypoint] = [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
        ]
        let segmentCount = 14
        let segmentLength: CGFloat = 120
        for index in 1 ... segmentCount {
            let x = CGFloat(index) * segmentLength
            let wave = sin(Double(index) * 0.55) * 14
            let y = CGFloat(wave)
            let controlOffset = CGFloat(cos(Double(index) * 0.45) * 22)
            if index < segmentCount {
                points.append(
                    CourseWaypoint(
                        position: CGPoint(x: x, y: y),
                        curveToNext: .quadratic(
                            control: CGPoint(x: x - segmentLength * 0.5, y: y + controlOffset)
                        )
                    )
                )
            } else {
                points.append(CourseWaypoint(position: CGPoint(x: x, y: 0)))
            }
        }
        return points
    }()

    // MARK: - Batch 37

    static let pixelPath = makeCourse(
        id: "pixelPath",
        displayName: "Pixel Path",
        unlockOrder: 184,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -42), curveToNext: .quadratic(control: CGPoint(x: 100, y: -52))),
            CourseWaypoint(position: CGPoint(x: 400, y: 42), curveToNext: .quadratic(control: CGPoint(x: 300, y: 52))),
            CourseWaypoint(position: CGPoint(x: 600, y: -44), curveToNext: .quadratic(control: CGPoint(x: 500, y: -54))),
            CourseWaypoint(position: CGPoint(x: 800, y: 44), curveToNext: .quadratic(control: CGPoint(x: 700, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -46), curveToNext: .quadratic(control: CGPoint(x: 900, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -42), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 54))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -20), curveToNext: .quadratic(control: CGPoint(x: 2900, y: -28))),
            CourseWaypoint(position: CGPoint(x: 4320, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3660, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .hotRed]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let noodleRoad = makeCourse(
        id: "noodleRoad",
        displayName: "Noodle Road",
        unlockOrder: 185,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 250, y: 36), curveToNext: .quadratic(control: CGPoint(x: 125, y: 44))),
            CourseWaypoint(position: CGPoint(x: 540, y: -30), curveToNext: .quadratic(control: CGPoint(x: 395, y: -40))),
            CourseWaypoint(position: CGPoint(x: 820, y: 44), curveToNext: .quadratic(control: CGPoint(x: 680, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -20), curveToNext: .quadratic(control: CGPoint(x: 970, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -40), curveToNext: .quadratic(control: CGPoint(x: 1280, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1600, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2040, y: -12), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2360, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2680, y: 40), curveToNext: .quadratic(control: CGPoint(x: 2520, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2980, y: -16), curveToNext: .quadratic(control: CGPoint(x: 2830, y: 2))),
            CourseWaypoint(position: CGPoint(x: 3320, y: -38), curveToNext: .quadratic(control: CGPoint(x: 3150, y: -50))),
            CourseWaypoint(position: CGPoint(x: 3660, y: 36), curveToNext: .quadratic(control: CGPoint(x: 3490, y: 48))),
            CourseWaypoint(position: CGPoint(x: 3980, y: 8), curveToNext: .quadratic(control: CGPoint(x: 3820, y: 20))),
            CourseWaypoint(position: CGPoint(x: 4340, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4160, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .skyTop]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.skyTop, .flameOrange]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyBottom]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let highTide = makeCourse(
        id: "highTide",
        displayName: "High Tide",
        unlockOrder: 186,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: 54), curveToNext: .quadratic(control: CGPoint(x: 150, y: 66))),
            CourseWaypoint(position: CGPoint(x: 600, y: -8), curveToNext: .quadratic(control: CGPoint(x: 450, y: 20))),
            CourseWaypoint(position: CGPoint(x: 900, y: -50), curveToNext: .quadratic(control: CGPoint(x: 750, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -20))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1950, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 8), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 56), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 68))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 20))),
            CourseWaypoint(position: CGPoint(x: 3300, y: -52), curveToNext: .quadratic(control: CGPoint(x: 3150, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3680, y: 6), curveToNext: .quadratic(control: CGPoint(x: 3490, y: -18))),
            CourseWaypoint(position: CGPoint(x: 4360, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4020, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let solarWind = makeCourse(
        id: "solarWind",
        displayName: "Solar Wind",
        unlockOrder: 187,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 350, y: -40), curveToNext: .quadratic(control: CGPoint(x: 175, y: -52))),
            CourseWaypoint(position: CGPoint(x: 700, y: -58), curveToNext: .quadratic(control: CGPoint(x: 525, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1050, y: 26), curveToNext: .quadratic(control: CGPoint(x: 875, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1225, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1750, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1925, y: 12))),
            CourseWaypoint(position: CGPoint(x: 2450, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2275, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -60), curveToNext: .quadratic(control: CGPoint(x: 2625, y: -70))),
            CourseWaypoint(position: CGPoint(x: 3150, y: 28), curveToNext: .quadratic(control: CGPoint(x: 2975, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3500, y: -40), curveToNext: .quadratic(control: CGPoint(x: 3325, y: -52))),
            CourseWaypoint(position: CGPoint(x: 3900, y: -14), curveToNext: .quadratic(control: CGPoint(x: 3700, y: -30))),
            CourseWaypoint(position: CGPoint(x: 4380, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4140, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let ironBridge = makeCourse(
        id: "ironBridge",
        displayName: "Iron Bridge",
        unlockOrder: 188,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: -58), curveToNext: .quadratic(control: CGPoint(x: 250, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -62), curveToNext: .quadratic(control: CGPoint(x: 750, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 16), curveToNext: .quadratic(control: CGPoint(x: 1250, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2500, y: -60), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -70))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2750, y: 4))),
            CourseWaypoint(position: CGPoint(x: 3500, y: -56), curveToNext: .quadratic(control: CGPoint(x: 3250, y: -68))),
            CourseWaypoint(position: CGPoint(x: 4000, y: -28), curveToNext: .quadratic(control: CGPoint(x: 3750, y: -44))),
            CourseWaypoint(position: CGPoint(x: 4400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4200, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 36

    static let thunderCloud = makeCourse(
        id: "thunderCloud",
        displayName: "Thunder Cloud",
        unlockOrder: 179,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 280, y: -56), curveToNext: .quadratic(control: CGPoint(x: 140, y: -68))),
            CourseWaypoint(position: CGPoint(x: 480, y: 30), curveToNext: .quadratic(control: CGPoint(x: 380, y: 18))),
            CourseWaypoint(position: CGPoint(x: 780, y: -52), curveToNext: .quadratic(control: CGPoint(x: 630, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1080, y: -62), curveToNext: .quadratic(control: CGPoint(x: 930, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 22), curveToNext: .quadratic(control: CGPoint(x: 1230, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1680, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1530, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 28), curveToNext: .quadratic(control: CGPoint(x: 1840, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2300, y: -56), curveToNext: .quadratic(control: CGPoint(x: 2150, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2640, y: -60), curveToNext: .quadratic(control: CGPoint(x: 2470, y: -70))),
            CourseWaypoint(position: CGPoint(x: 2960, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2800, y: 8))),
            CourseWaypoint(position: CGPoint(x: 3280, y: -50), curveToNext: .quadratic(control: CGPoint(x: 3120, y: -62))),
            CourseWaypoint(position: CGPoint(x: 3640, y: 14), curveToNext: .quadratic(control: CGPoint(x: 3460, y: 2))),
            CourseWaypoint(position: CGPoint(x: 4220, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3930, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: .trackBlack, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let goldenGate = makeCourse(
        id: "goldenGate",
        displayName: "Golden Gate",
        unlockOrder: 180,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 600, y: -56), curveToNext: .quadratic(control: CGPoint(x: 300, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -62), curveToNext: .quadratic(control: CGPoint(x: 900, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -40))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 30), curveToNext: .quadratic(control: CGPoint(x: 2100, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2700, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3600, y: -58), curveToNext: .quadratic(control: CGPoint(x: 3300, y: -68))),
            CourseWaypoint(position: CGPoint(x: 4000, y: -14), curveToNext: .quadratic(control: CGPoint(x: 3800, y: -36))),
            CourseWaypoint(position: CGPoint(x: 4240, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4120, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let boulderField = makeCourse(
        id: "boulderField",
        displayName: "Boulder Field",
        unlockOrder: 181,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 260, y: 46), curveToNext: .quadratic(control: CGPoint(x: 130, y: 56))),
            CourseWaypoint(position: CGPoint(x: 560, y: -38), curveToNext: .quadratic(control: CGPoint(x: 410, y: -50))),
            CourseWaypoint(position: CGPoint(x: 760, y: 10), curveToNext: .quadratic(control: CGPoint(x: 660, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1020, y: 50), curveToNext: .quadratic(control: CGPoint(x: 890, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1360, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1190, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1620, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1490, y: -10))),
            CourseWaypoint(position: CGPoint(x: 1920, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1770, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2280, y: -40), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2580, y: 12), curveToNext: .quadratic(control: CGPoint(x: 2430, y: -6))),
            CourseWaypoint(position: CGPoint(x: 2880, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2730, y: 60))),
            CourseWaypoint(position: CGPoint(x: 3240, y: -38), curveToNext: .quadratic(control: CGPoint(x: 3060, y: -50))),
            CourseWaypoint(position: CGPoint(x: 3600, y: 10), curveToNext: .quadratic(control: CGPoint(x: 3420, y: -8))),
            CourseWaypoint(position: CGPoint(x: 4000, y: 14), curveToNext: .quadratic(control: CGPoint(x: 3800, y: 6))),
            CourseWaypoint(position: CGPoint(x: 4260, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4130, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .trackBlack]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let velvetRoad = makeCourse(
        id: "velvetRoad",
        displayName: "Velvet Road",
        unlockOrder: 182,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: 50), curveToNext: .quadratic(control: CGPoint(x: 200, y: 62))),
            CourseWaypoint(position: CGPoint(x: 800, y: -6), curveToNext: .quadratic(control: CGPoint(x: 600, y: 20))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -20))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2200, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 6), curveToNext: .quadratic(control: CGPoint(x: 3000, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3600, y: 50), curveToNext: .quadratic(control: CGPoint(x: 3400, y: 62))),
            CourseWaypoint(position: CGPoint(x: 4000, y: -4), curveToNext: .quadratic(control: CGPoint(x: 3800, y: 20))),
            CourseWaypoint(position: CGPoint(x: 4280, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4140, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let magneticPole = makeCourse(
        id: "magneticPole",
        displayName: "Magnetic Pole",
        unlockOrder: 183,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: 46), curveToNext: .quadratic(control: CGPoint(x: 150, y: 56))),
            CourseWaypoint(position: CGPoint(x: 600, y: -30), curveToNext: .quadratic(control: CGPoint(x: 450, y: 8))),
            CourseWaypoint(position: CGPoint(x: 900, y: -56), curveToNext: .quadratic(control: CGPoint(x: 750, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1050, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1350, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 30))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1950, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 32))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2550, y: -62))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 40), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3300, y: -52), curveToNext: .quadratic(control: CGPoint(x: 3150, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3660, y: 16), curveToNext: .quadratic(control: CGPoint(x: 3480, y: 4))),
            CourseWaypoint(position: CGPoint(x: 4300, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3980, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 35

    static let gemMine = makeCourse(
        id: "gemMine",
        displayName: "Gem Mine",
        unlockOrder: 174,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -44), curveToNext: .quadratic(control: CGPoint(x: 100, y: -54))),
            CourseWaypoint(position: CGPoint(x: 460, y: 50), curveToNext: .quadratic(control: CGPoint(x: 330, y: 62))),
            CourseWaypoint(position: CGPoint(x: 680, y: -10), curveToNext: .quadratic(control: CGPoint(x: 570, y: 18))),
            CourseWaypoint(position: CGPoint(x: 920, y: -52), curveToNext: .quadratic(control: CGPoint(x: 800, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1060, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1320, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1720, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1580, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2020, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1870, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2280, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2150, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2560, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2420, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2860, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2710, y: 58))),
            CourseWaypoint(position: CGPoint(x: 3140, y: -4), curveToNext: .quadratic(control: CGPoint(x: 3000, y: 18))),
            CourseWaypoint(position: CGPoint(x: 3440, y: -48), curveToNext: .quadratic(control: CGPoint(x: 3290, y: -60))),
            CourseWaypoint(position: CGPoint(x: 3800, y: 14), curveToNext: .quadratic(control: CGPoint(x: 3620, y: 2))),
            CourseWaypoint(position: CGPoint(x: 4120, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3960, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let torchRace = makeCourse(
        id: "torchRace",
        displayName: "Torch Race",
        unlockOrder: 175,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: 50), curveToNext: .quadratic(control: CGPoint(x: 120, y: 62))),
            CourseWaypoint(position: CGPoint(x: 540, y: -10), curveToNext: .quadratic(control: CGPoint(x: 390, y: 18))),
            CourseWaypoint(position: CGPoint(x: 800, y: 54), curveToNext: .quadratic(control: CGPoint(x: 670, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1100, y: -4), curveToNext: .quadratic(control: CGPoint(x: 950, y: 20))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1240, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1540, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1850, y: 68))),
            CourseWaypoint(position: CGPoint(x: 2340, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2170, y: 20))),
            CourseWaypoint(position: CGPoint(x: 2660, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2500, y: 62))),
            CourseWaypoint(position: CGPoint(x: 3020, y: -10), curveToNext: .quadratic(control: CGPoint(x: 2840, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3380, y: 48), curveToNext: .quadratic(control: CGPoint(x: 3200, y: 60))),
            CourseWaypoint(position: CGPoint(x: 3760, y: -4), curveToNext: .quadratic(control: CGPoint(x: 3570, y: 18))),
            CourseWaypoint(position: CGPoint(x: 4140, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3950, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let mountainGoat = makeCourse(
        id: "mountainGoat",
        displayName: "Mountain Goat",
        unlockOrder: 176,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 52), curveToNext: .quadratic(control: CGPoint(x: 100, y: 64))),
            CourseWaypoint(position: CGPoint(x: 360, y: -26), curveToNext: .quadratic(control: CGPoint(x: 280, y: 8))),
            CourseWaypoint(position: CGPoint(x: 560, y: 54), curveToNext: .quadratic(control: CGPoint(x: 460, y: 66))),
            CourseWaypoint(position: CGPoint(x: 760, y: -22), curveToNext: .quadratic(control: CGPoint(x: 660, y: 10))),
            CourseWaypoint(position: CGPoint(x: 980, y: 56), curveToNext: .quadratic(control: CGPoint(x: 870, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -28), curveToNext: .quadratic(control: CGPoint(x: 1090, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1320, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1570, y: 8))),
            CourseWaypoint(position: CGPoint(x: 1960, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1830, y: 66))),
            CourseWaypoint(position: CGPoint(x: 2240, y: -26), curveToNext: .quadratic(control: CGPoint(x: 2100, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2520, y: 52), curveToNext: .quadratic(control: CGPoint(x: 2380, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2820, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2670, y: 8))),
            CourseWaypoint(position: CGPoint(x: 3140, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2980, y: 62))),
            CourseWaypoint(position: CGPoint(x: 3480, y: -10), curveToNext: .quadratic(control: CGPoint(x: 3310, y: 14))),
            CourseWaypoint(position: CGPoint(x: 3840, y: 8), curveToNext: .quadratic(control: CGPoint(x: 3660, y: -2))),
            CourseWaypoint(position: CGPoint(x: 4160, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4000, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .trackBlack]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let oceanBreeze = makeCourse(
        id: "oceanBreeze",
        displayName: "Ocean Breeze",
        unlockOrder: 177,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 350, y: -46), curveToNext: .quadratic(control: CGPoint(x: 175, y: -58))),
            CourseWaypoint(position: CGPoint(x: 700, y: 4), curveToNext: .quadratic(control: CGPoint(x: 525, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1050, y: 48), curveToNext: .quadratic(control: CGPoint(x: 875, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1225, y: 16))),
            CourseWaypoint(position: CGPoint(x: 1750, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1925, y: -16))),
            CourseWaypoint(position: CGPoint(x: 2450, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2275, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -12), curveToNext: .quadratic(control: CGPoint(x: 2625, y: 14))),
            CourseWaypoint(position: CGPoint(x: 3150, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2975, y: -60))),
            CourseWaypoint(position: CGPoint(x: 3500, y: 6), curveToNext: .quadratic(control: CGPoint(x: 3325, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3860, y: 44), curveToNext: .quadratic(control: CGPoint(x: 3680, y: 56))),
            CourseWaypoint(position: CGPoint(x: 4180, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4020, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let sparkTrail = makeCourse(
        id: "sparkTrail",
        displayName: "Spark Trail",
        unlockOrder: 178,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 20), curveToNext: .quadratic(control: CGPoint(x: 90, y: 26))),
            CourseWaypoint(position: CGPoint(x: 380, y: -30), curveToNext: .quadratic(control: CGPoint(x: 280, y: -38))),
            CourseWaypoint(position: CGPoint(x: 620, y: 42), curveToNext: .quadratic(control: CGPoint(x: 500, y: 52))),
            CourseWaypoint(position: CGPoint(x: 900, y: -48), curveToNext: .quadratic(control: CGPoint(x: 760, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1220, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1060, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1580, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1780, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2340, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2160, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2660, y: 40), curveToNext: .quadratic(control: CGPoint(x: 2500, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2940, y: -32), curveToNext: .quadratic(control: CGPoint(x: 2800, y: -44))),
            CourseWaypoint(position: CGPoint(x: 3180, y: 26), curveToNext: .quadratic(control: CGPoint(x: 3060, y: 36))),
            CourseWaypoint(position: CGPoint(x: 3400, y: -18), curveToNext: .quadratic(control: CGPoint(x: 3290, y: -26))),
            CourseWaypoint(position: CGPoint(x: 3680, y: 10), curveToNext: .quadratic(control: CGPoint(x: 3540, y: -4))),
            CourseWaypoint(position: CGPoint(x: 4200, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3940, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .hotRed]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 34

    static let tumbleweed = makeCourse(
        id: "tumbleweed",
        displayName: "Tumbleweed",
        unlockOrder: 169,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 260, y: 40), curveToNext: .quadratic(control: CGPoint(x: 130, y: 50))),
            CourseWaypoint(position: CGPoint(x: 580, y: -28), curveToNext: .quadratic(control: CGPoint(x: 420, y: -38))),
            CourseWaypoint(position: CGPoint(x: 820, y: 46), curveToNext: .quadratic(control: CGPoint(x: 700, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1160, y: 16), curveToNext: .quadratic(control: CGPoint(x: 990, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1780, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1610, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -14), curveToNext: .quadratic(control: CGPoint(x: 1940, y: -2))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2740, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2570, y: 56))),
            CourseWaypoint(position: CGPoint(x: 3060, y: 10), curveToNext: .quadratic(control: CGPoint(x: 2900, y: 24))),
            CourseWaypoint(position: CGPoint(x: 3380, y: -42), curveToNext: .quadratic(control: CGPoint(x: 3220, y: -54))),
            CourseWaypoint(position: CGPoint(x: 3720, y: 20), curveToNext: .quadratic(control: CGPoint(x: 3550, y: 4))),
            CourseWaypoint(position: CGPoint(x: 4020, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3870, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let prairieWind = makeCourse(
        id: "prairieWind",
        displayName: "Prairie Wind",
        unlockOrder: 170,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 350, y: -38), curveToNext: .quadratic(control: CGPoint(x: 175, y: -48))),
            CourseWaypoint(position: CGPoint(x: 700, y: -56), curveToNext: .quadratic(control: CGPoint(x: 525, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1050, y: -22), curveToNext: .quadratic(control: CGPoint(x: 875, y: -32))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1225, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1750, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1925, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2450, y: -16), curveToNext: .quadratic(control: CGPoint(x: 2275, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 28), curveToNext: .quadratic(control: CGPoint(x: 2625, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3150, y: -42), curveToNext: .quadratic(control: CGPoint(x: 2975, y: -52))),
            CourseWaypoint(position: CGPoint(x: 3500, y: -54), curveToNext: .quadratic(control: CGPoint(x: 3325, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3850, y: -8), curveToNext: .quadratic(control: CGPoint(x: 3675, y: -24))),
            CourseWaypoint(position: CGPoint(x: 4040, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3945, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .skyBottom, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .racingYellow]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .skyBottom, skyGradient: [.racingYellow, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let cobblestone = makeCourse(
        id: "cobblestone",
        displayName: "Cobblestone",
        unlockOrder: 171,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 140, y: 22), curveToNext: .quadratic(control: CGPoint(x: 70, y: 28))),
            CourseWaypoint(position: CGPoint(x: 300, y: -18), curveToNext: .quadratic(control: CGPoint(x: 220, y: -24))),
            CourseWaypoint(position: CGPoint(x: 480, y: 26), curveToNext: .quadratic(control: CGPoint(x: 390, y: 32))),
            CourseWaypoint(position: CGPoint(x: 680, y: -22), curveToNext: .quadratic(control: CGPoint(x: 580, y: -28))),
            CourseWaypoint(position: CGPoint(x: 900, y: 28), curveToNext: .quadratic(control: CGPoint(x: 790, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1140, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1020, y: -30))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 26), curveToNext: .quadratic(control: CGPoint(x: 1270, y: 32))),
            CourseWaypoint(position: CGPoint(x: 1680, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1540, y: -26))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1830, y: 30))),
            CourseWaypoint(position: CGPoint(x: 2300, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2140, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2640, y: 26), curveToNext: .quadratic(control: CGPoint(x: 2470, y: 32))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -18), curveToNext: .quadratic(control: CGPoint(x: 2820, y: -24))),
            CourseWaypoint(position: CGPoint(x: 3380, y: 22), curveToNext: .quadratic(control: CGPoint(x: 3190, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3780, y: -6), curveToNext: .quadratic(control: CGPoint(x: 3580, y: -10))),
            CourseWaypoint(position: CGPoint(x: 4060, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3920, y: -2))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let fireFly = makeCourse(
        id: "fireFly",
        displayName: "Firefly Trail",
        unlockOrder: 172,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: 34), curveToNext: .quadratic(control: CGPoint(x: 100, y: 42))),
            CourseWaypoint(position: CGPoint(x: 360, y: -12), curveToNext: .quadratic(control: CGPoint(x: 280, y: 4))),
            CourseWaypoint(position: CGPoint(x: 580, y: -48), curveToNext: .quadratic(control: CGPoint(x: 470, y: -60))),
            CourseWaypoint(position: CGPoint(x: 800, y: 38), curveToNext: .quadratic(control: CGPoint(x: 690, y: 50))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 6), curveToNext: .quadratic(control: CGPoint(x: 900, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1130, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1520, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1390, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1740, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1630, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1870, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2280, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2140, y: 48))),
            CourseWaypoint(position: CGPoint(x: 2520, y: 4), curveToNext: .quadratic(control: CGPoint(x: 2400, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -54), curveToNext: .quadratic(control: CGPoint(x: 2660, y: -66))),
            CourseWaypoint(position: CGPoint(x: 3100, y: 38), curveToNext: .quadratic(control: CGPoint(x: 2950, y: 50))),
            CourseWaypoint(position: CGPoint(x: 3380, y: -6), curveToNext: .quadratic(control: CGPoint(x: 3240, y: 8))),
            CourseWaypoint(position: CGPoint(x: 3700, y: -22), curveToNext: .quadratic(control: CGPoint(x: 3540, y: -14))),
            CourseWaypoint(position: CGPoint(x: 4080, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3890, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .racingYellow]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let deepSea = makeCourse(
        id: "deepSea",
        displayName: "Deep Sea",
        unlockOrder: 173,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: -52), curveToNext: .quadratic(control: CGPoint(x: 200, y: -64))),
            CourseWaypoint(position: CGPoint(x: 800, y: -62), curveToNext: .quadratic(control: CGPoint(x: 600, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -40))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1400, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1800, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -60), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -70))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -18), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -36))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 24), curveToNext: .quadratic(control: CGPoint(x: 3000, y: 10))),
            CourseWaypoint(position: CGPoint(x: 3600, y: -46), curveToNext: .quadratic(control: CGPoint(x: 3400, y: -58))),
            CourseWaypoint(position: CGPoint(x: 4100, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3850, y: -20))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 33

    static let foggyMoor = makeCourse(
        id: "foggyMoor",
        displayName: "Foggy Moor",
        unlockOrder: 164,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: -46), curveToNext: .quadratic(control: CGPoint(x: 250, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 8), curveToNext: .quadratic(control: CGPoint(x: 750, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -4), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 20))),
            CourseWaypoint(position: CGPoint(x: 2500, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -60))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2750, y: -16))),
            CourseWaypoint(position: CGPoint(x: 3500, y: 52), curveToNext: .quadratic(control: CGPoint(x: 3250, y: 64))),
            CourseWaypoint(position: CGPoint(x: 3920, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3710, y: 18))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyBottom, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let pinwheelPark = makeCourse(
        id: "pinwheelPark",
        displayName: "Pinwheel Park",
        unlockOrder: 165,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 18), curveToNext: .quadratic(control: CGPoint(x: 90, y: 24))),
            CourseWaypoint(position: CGPoint(x: 420, y: -34), curveToNext: .quadratic(control: CGPoint(x: 300, y: -44))),
            CourseWaypoint(position: CGPoint(x: 720, y: 48), curveToNext: .quadratic(control: CGPoint(x: 570, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1080, y: -54), curveToNext: .quadratic(control: CGPoint(x: 900, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1290, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1960, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1730, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2360, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2160, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -36), curveToNext: .quadratic(control: CGPoint(x: 2530, y: -48))),
            CourseWaypoint(position: CGPoint(x: 2980, y: 26), curveToNext: .quadratic(control: CGPoint(x: 2840, y: 36))),
            CourseWaypoint(position: CGPoint(x: 3220, y: -18), curveToNext: .quadratic(control: CGPoint(x: 3100, y: -26))),
            CourseWaypoint(position: CGPoint(x: 3940, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3580, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let archipelago = makeCourse(
        id: "archipelago",
        displayName: "Archipelago",
        unlockOrder: 166,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: 50), curveToNext: .quadratic(control: CGPoint(x: 150, y: 62))),
            CourseWaypoint(position: CGPoint(x: 600, y: -18), curveToNext: .quadratic(control: CGPoint(x: 450, y: 14))),
            CourseWaypoint(position: CGPoint(x: 900, y: -48), curveToNext: .quadratic(control: CGPoint(x: 750, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -16))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -12), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1950, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 52), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 64))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 14))),
            CourseWaypoint(position: CGPoint(x: 3300, y: -50), curveToNext: .quadratic(control: CGPoint(x: 3150, y: -62))),
            CourseWaypoint(position: CGPoint(x: 3640, y: 4), curveToNext: .quadratic(control: CGPoint(x: 3470, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3960, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3800, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let springCoil = makeCourse(
        id: "springCoil",
        displayName: "Spring Coil",
        unlockOrder: 167,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 120, y: 16), curveToNext: .quadratic(control: CGPoint(x: 60, y: 20))),
            CourseWaypoint(position: CGPoint(x: 280, y: -28), curveToNext: .quadratic(control: CGPoint(x: 200, y: -36))),
            CourseWaypoint(position: CGPoint(x: 500, y: 42), curveToNext: .quadratic(control: CGPoint(x: 390, y: 52))),
            CourseWaypoint(position: CGPoint(x: 780, y: -50), curveToNext: .quadratic(control: CGPoint(x: 640, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 54), curveToNext: .quadratic(control: CGPoint(x: 950, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1520, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1320, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1750, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2380, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2180, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2720, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 56))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -34), curveToNext: .quadratic(control: CGPoint(x: 2860, y: -44))),
            CourseWaypoint(position: CGPoint(x: 3240, y: 24), curveToNext: .quadratic(control: CGPoint(x: 3120, y: 32))),
            CourseWaypoint(position: CGPoint(x: 3440, y: -14), curveToNext: .quadratic(control: CGPoint(x: 3340, y: -20))),
            CourseWaypoint(position: CGPoint(x: 3980, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3710, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let auroraBend = makeCourse(
        id: "auroraBend",
        displayName: "Aurora Bend",
        unlockOrder: 168,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: 52), curveToNext: .quadratic(control: CGPoint(x: 250, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 4), curveToNext: .quadratic(control: CGPoint(x: 750, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1250, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -24))),
            CourseWaypoint(position: CGPoint(x: 2500, y: 56), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 68))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 2), curveToNext: .quadratic(control: CGPoint(x: 2750, y: 24))),
            CourseWaypoint(position: CGPoint(x: 3500, y: -52), curveToNext: .quadratic(control: CGPoint(x: 3250, y: -64))),
            CourseWaypoint(position: CGPoint(x: 4000, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3750, y: -22))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.6, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 32

    static let cocoaRun = makeCourse(
        id: "cocoaRun",
        displayName: "Cocoa Run",
        unlockOrder: 159,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: 46), curveToNext: .quadratic(control: CGPoint(x: 150, y: 56))),
            CourseWaypoint(position: CGPoint(x: 600, y: 8), curveToNext: .quadratic(control: CGPoint(x: 450, y: 24))),
            CourseWaypoint(position: CGPoint(x: 900, y: 44), curveToNext: .quadratic(control: CGPoint(x: 750, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2100, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1950, y: -12))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 10), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 26))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 54))),
            CourseWaypoint(position: CGPoint(x: 3300, y: -18), curveToNext: .quadratic(control: CGPoint(x: 3150, y: -6))),
            CourseWaypoint(position: CGPoint(x: 3820, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3560, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let swampHop = makeCourse(
        id: "swampHop",
        displayName: "Swamp Hop",
        unlockOrder: 160,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 38), curveToNext: .quadratic(control: CGPoint(x: 90, y: 48))),
            CourseWaypoint(position: CGPoint(x: 430, y: -44), curveToNext: .quadratic(control: CGPoint(x: 305, y: -56))),
            CourseWaypoint(position: CGPoint(x: 680, y: 16), curveToNext: .quadratic(control: CGPoint(x: 555, y: -8))),
            CourseWaypoint(position: CGPoint(x: 900, y: 52), curveToNext: .quadratic(control: CGPoint(x: 790, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1550, y: 10), curveToNext: .quadratic(control: CGPoint(x: 1375, y: -8))),
            CourseWaypoint(position: CGPoint(x: 1780, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1665, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2080, y: -40), curveToNext: .quadratic(control: CGPoint(x: 1930, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2380, y: 14), curveToNext: .quadratic(control: CGPoint(x: 2230, y: -4))),
            CourseWaypoint(position: CGPoint(x: 2640, y: 54), curveToNext: .quadratic(control: CGPoint(x: 2510, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2980, y: -38), curveToNext: .quadratic(control: CGPoint(x: 2810, y: -50))),
            CourseWaypoint(position: CGPoint(x: 3340, y: 12), curveToNext: .quadratic(control: CGPoint(x: 3160, y: -4))),
            CourseWaypoint(position: CGPoint(x: 3840, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3590, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .flameOrange, ropeHighlight: .trackBlack, skyGradient: [.flameOrange, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let crystalStream = makeCourse(
        id: "crystalStream",
        displayName: "Crystal Stream",
        unlockOrder: 161,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 350, y: -48), curveToNext: .quadratic(control: CGPoint(x: 175, y: -60))),
            CourseWaypoint(position: CGPoint(x: 700, y: 4), curveToNext: .quadratic(control: CGPoint(x: 525, y: -16))),
            CourseWaypoint(position: CGPoint(x: 1050, y: 50), curveToNext: .quadratic(control: CGPoint(x: 875, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1225, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1750, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 2), curveToNext: .quadratic(control: CGPoint(x: 1925, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2450, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2275, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2625, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3150, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2975, y: -62))),
            CourseWaypoint(position: CGPoint(x: 3500, y: 6), curveToNext: .quadratic(control: CGPoint(x: 3325, y: -14))),
            CourseWaypoint(position: CGPoint(x: 3860, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3680, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let hauntedPath = makeCourse(
        id: "hauntedPath",
        displayName: "Haunted Path",
        unlockOrder: 162,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: -42), curveToNext: .quadratic(control: CGPoint(x: 120, y: -52))),
            CourseWaypoint(position: CGPoint(x: 560, y: 36), curveToNext: .quadratic(control: CGPoint(x: 400, y: 46))),
            CourseWaypoint(position: CGPoint(x: 760, y: -16), curveToNext: .quadratic(control: CGPoint(x: 660, y: -4))),
            CourseWaypoint(position: CGPoint(x: 1060, y: -54), curveToNext: .quadratic(control: CGPoint(x: 910, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1220, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1490, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1900, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2260, y: 38), curveToNext: .quadratic(control: CGPoint(x: 2080, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2480, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2370, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2640, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3160, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2980, y: 54))),
            CourseWaypoint(position: CGPoint(x: 3440, y: -10), curveToNext: .quadratic(control: CGPoint(x: 3300, y: 8))),
            CourseWaypoint(position: CGPoint(x: 3880, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3660, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .electricBlue, ropeHighlight: .trackBlack, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let sugarRush = makeCourse(
        id: "sugarRush",
        displayName: "Sugar Rush",
        unlockOrder: 163,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: 44), curveToNext: .quadratic(control: CGPoint(x: 80, y: 54))),
            CourseWaypoint(position: CGPoint(x: 320, y: -46), curveToNext: .quadratic(control: CGPoint(x: 240, y: -58))),
            CourseWaypoint(position: CGPoint(x: 480, y: 42), curveToNext: .quadratic(control: CGPoint(x: 400, y: 52))),
            CourseWaypoint(position: CGPoint(x: 640, y: -48), curveToNext: .quadratic(control: CGPoint(x: 560, y: -60))),
            CourseWaypoint(position: CGPoint(x: 800, y: 44), curveToNext: .quadratic(control: CGPoint(x: 720, y: 54))),
            CourseWaypoint(position: CGPoint(x: 960, y: -42), curveToNext: .quadratic(control: CGPoint(x: 880, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1040, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1280, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1200, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1360, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1520, y: -56))),
            CourseWaypoint(position: CGPoint(x: 1760, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1680, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1920, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1840, y: -52))),
            CourseWaypoint(position: CGPoint(x: 2080, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2000, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2240, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2160, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2320, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2560, y: -46), curveToNext: .quadratic(control: CGPoint(x: 2480, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2720, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2640, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2880, y: -12), curveToNext: .quadratic(control: CGPoint(x: 2800, y: -20))),
            CourseWaypoint(position: CGPoint(x: 3900, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3390, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .racingYellow]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .hotRed]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 31

    static let beanBounce = makeCourse(
        id: "beanBounce",
        displayName: "Bean Bounce",
        unlockOrder: 154,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 34), curveToNext: .quadratic(control: CGPoint(x: 90, y: 42))),
            CourseWaypoint(position: CGPoint(x: 340, y: 4), curveToNext: .quadratic(control: CGPoint(x: 260, y: 12))),
            CourseWaypoint(position: CGPoint(x: 540, y: 48), curveToNext: .quadratic(control: CGPoint(x: 440, y: 60))),
            CourseWaypoint(position: CGPoint(x: 780, y: 8), curveToNext: .quadratic(control: CGPoint(x: 660, y: 20))),
            CourseWaypoint(position: CGPoint(x: 960, y: 28), curveToNext: .quadratic(control: CGPoint(x: 870, y: 36))),
            CourseWaypoint(position: CGPoint(x: 1160, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1060, y: 12))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1270, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1490, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1820, y: 36), curveToNext: .quadratic(control: CGPoint(x: 1710, y: 46))),
            CourseWaypoint(position: CGPoint(x: 2020, y: 2), curveToNext: .quadratic(control: CGPoint(x: 1920, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2260, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2140, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2480, y: 8), curveToNext: .quadratic(control: CGPoint(x: 2370, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 32), curveToNext: .quadratic(control: CGPoint(x: 2590, y: 42))),
            CourseWaypoint(position: CGPoint(x: 2940, y: -12), curveToNext: .quadratic(control: CGPoint(x: 2820, y: 0))),
            CourseWaypoint(position: CGPoint(x: 3160, y: 28), curveToNext: .quadratic(control: CGPoint(x: 3050, y: 38))),
            CourseWaypoint(position: CGPoint(x: 3420, y: -8), curveToNext: .quadratic(control: CGPoint(x: 3290, y: 4))),
            CourseWaypoint(position: CGPoint(x: 3720, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3570, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .racingYellow, ropeHighlight: .hotRed, skyGradient: [.racingYellow, .hotRed]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let moonRiver = makeCourse(
        id: "moonRiver",
        displayName: "Moon River",
        unlockOrder: 155,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 600, y: 44), curveToNext: .quadratic(control: CGPoint(x: 300, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -4), curveToNext: .quadratic(control: CGPoint(x: 900, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -2), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 56))),
            CourseWaypoint(position: CGPoint(x: 3600, y: -6), curveToNext: .quadratic(control: CGPoint(x: 3300, y: 12))),
            CourseWaypoint(position: CGPoint(x: 3740, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3670, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let volcanoDash = makeCourse(
        id: "volcanoDash",
        displayName: "Volcano Dash",
        unlockOrder: 156,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -38), curveToNext: .quadratic(control: CGPoint(x: 100, y: -48))),
            CourseWaypoint(position: CGPoint(x: 500, y: 54), curveToNext: .quadratic(control: CGPoint(x: 350, y: 66))),
            CourseWaypoint(position: CGPoint(x: 800, y: 4), curveToNext: .quadratic(control: CGPoint(x: 650, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -42), curveToNext: .quadratic(control: CGPoint(x: 900, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1150, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1450, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1820, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1710, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2120, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1970, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2420, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2270, y: 20))),
            CourseWaypoint(position: CGPoint(x: 2640, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2530, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2940, y: 56), curveToNext: .quadratic(control: CGPoint(x: 2790, y: 68))),
            CourseWaypoint(position: CGPoint(x: 3240, y: 4), curveToNext: .quadratic(control: CGPoint(x: 3090, y: 22))),
            CourseWaypoint(position: CGPoint(x: 3760, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3500, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let kiteRun = makeCourse(
        id: "kiteRun",
        displayName: "Kite Run",
        unlockOrder: 157,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: 52), curveToNext: .quadratic(control: CGPoint(x: 200, y: 64))),
            CourseWaypoint(position: CGPoint(x: 800, y: -8), curveToNext: .quadratic(control: CGPoint(x: 600, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 66))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2200, y: 20))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 6), curveToNext: .quadratic(control: CGPoint(x: 3000, y: -16))),
            CourseWaypoint(position: CGPoint(x: 3500, y: 48), curveToNext: .quadratic(control: CGPoint(x: 3350, y: 60))),
            CourseWaypoint(position: CGPoint(x: 3780, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3640, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .skyBottom, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .racingYellow]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let glowWorm = makeCourse(
        id: "glowWorm",
        displayName: "Glow Worm",
        unlockOrder: 158,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 220, y: 30), curveToNext: .quadratic(control: CGPoint(x: 110, y: 38))),
            CourseWaypoint(position: CGPoint(x: 440, y: -32), curveToNext: .quadratic(control: CGPoint(x: 330, y: -40))),
            CourseWaypoint(position: CGPoint(x: 660, y: 28), curveToNext: .quadratic(control: CGPoint(x: 550, y: 36))),
            CourseWaypoint(position: CGPoint(x: 880, y: -34), curveToNext: .quadratic(control: CGPoint(x: 770, y: -42))),
            CourseWaypoint(position: CGPoint(x: 1100, y: 32), curveToNext: .quadratic(control: CGPoint(x: 990, y: 40))),
            CourseWaypoint(position: CGPoint(x: 1320, y: -30), curveToNext: .quadratic(control: CGPoint(x: 1210, y: -38))),
            CourseWaypoint(position: CGPoint(x: 1540, y: 34), curveToNext: .quadratic(control: CGPoint(x: 1430, y: 42))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -28), curveToNext: .quadratic(control: CGPoint(x: 1650, y: -36))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 30), curveToNext: .quadratic(control: CGPoint(x: 1870, y: 38))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -32), curveToNext: .quadratic(control: CGPoint(x: 2090, y: -40))),
            CourseWaypoint(position: CGPoint(x: 2420, y: 28), curveToNext: .quadratic(control: CGPoint(x: 2310, y: 36))),
            CourseWaypoint(position: CGPoint(x: 2640, y: -34), curveToNext: .quadratic(control: CGPoint(x: 2530, y: -42))),
            CourseWaypoint(position: CGPoint(x: 2860, y: 32), curveToNext: .quadratic(control: CGPoint(x: 2750, y: 40))),
            CourseWaypoint(position: CGPoint(x: 3080, y: -30), curveToNext: .quadratic(control: CGPoint(x: 2970, y: -38))),
            CourseWaypoint(position: CGPoint(x: 3300, y: 28), curveToNext: .quadratic(control: CGPoint(x: 3190, y: 36))),
            CourseWaypoint(position: CGPoint(x: 3520, y: -8), curveToNext: .quadratic(control: CGPoint(x: 3410, y: -14))),
            CourseWaypoint(position: CGPoint(x: 3800, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3660, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 30

    static let rocketRide = makeCourse(
        id: "rocketRide",
        displayName: "Rocket Ride",
        unlockOrder: 149,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: 6), curveToNext: .quadratic(control: CGPoint(x: 250, y: 6))),
            CourseWaypoint(position: CGPoint(x: 700, y: 56), curveToNext: .quadratic(control: CGPoint(x: 600, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 8), curveToNext: .quadratic(control: CGPoint(x: 950, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -72))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1650, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 54), curveToNext: .quadratic(control: CGPoint(x: 2000, y: 68))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2350, y: 24))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -56), curveToNext: .quadratic(control: CGPoint(x: 2700, y: -70))),
            CourseWaypoint(position: CGPoint(x: 3300, y: 8), curveToNext: .quadratic(control: CGPoint(x: 3050, y: -10))),
            CourseWaypoint(position: CGPoint(x: 3620, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3460, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let butterflyPath = makeCourse(
        id: "butterflyPath",
        displayName: "Butterfly Path",
        unlockOrder: 150,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: 52), curveToNext: .quadratic(control: CGPoint(x: 200, y: 64))),
            CourseWaypoint(position: CGPoint(x: 800, y: 0), curveToNext: .quadratic(control: CGPoint(x: 600, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 2200, y: 18))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 24), curveToNext: .quadratic(control: CGPoint(x: 3000, y: 6))),
            CourseWaypoint(position: CGPoint(x: 3640, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3420, y: 12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let lavaLamp = makeCourse(
        id: "lavaLamp",
        displayName: "Lava Lamp",
        unlockOrder: 151,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 450, y: 46), curveToNext: .quadratic(control: CGPoint(x: 225, y: 58))),
            CourseWaypoint(position: CGPoint(x: 900, y: 10), curveToNext: .quadratic(control: CGPoint(x: 675, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1350, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1125, y: -22))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1575, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2250, y: 8), curveToNext: .quadratic(control: CGPoint(x: 2025, y: 24))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -40), curveToNext: .quadratic(control: CGPoint(x: 2475, y: -24))),
            CourseWaypoint(position: CGPoint(x: 3100, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2900, y: 54))),
            CourseWaypoint(position: CGPoint(x: 3660, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3380, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let tunnelRush = makeCourse(
        id: "tunnelRush",
        displayName: "Tunnel Rush",
        unlockOrder: 152,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -44), curveToNext: .quadratic(control: CGPoint(x: 80, y: -52))),
            CourseWaypoint(position: CGPoint(x: 320, y: 44), curveToNext: .quadratic(control: CGPoint(x: 240, y: 52))),
            CourseWaypoint(position: CGPoint(x: 480, y: -46), curveToNext: .quadratic(control: CGPoint(x: 400, y: -54))),
            CourseWaypoint(position: CGPoint(x: 640, y: 46), curveToNext: .quadratic(control: CGPoint(x: 560, y: 54))),
            CourseWaypoint(position: CGPoint(x: 800, y: -48), curveToNext: .quadratic(control: CGPoint(x: 720, y: -56))),
            CourseWaypoint(position: CGPoint(x: 960, y: 48), curveToNext: .quadratic(control: CGPoint(x: 880, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1520, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1680, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1920, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1840, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2080, y: -46), curveToNext: .quadratic(control: CGPoint(x: 2000, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 44), curveToNext: .quadratic(control: CGPoint(x: 2160, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -40), curveToNext: .quadratic(control: CGPoint(x: 2320, y: -48))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2500, y: 44))),
            CourseWaypoint(position: CGPoint(x: 2820, y: -28), curveToNext: .quadratic(control: CGPoint(x: 2710, y: -36))),
            CourseWaypoint(position: CGPoint(x: 3060, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2940, y: 26))),
            CourseWaypoint(position: CGPoint(x: 3320, y: -12), curveToNext: .quadratic(control: CGPoint(x: 3190, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3680, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3500, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .trackBlack, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let penguin = makeCourse(
        id: "penguin",
        displayName: "Penguin Slide",
        unlockOrder: 153,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 250, y: -48), curveToNext: .quadratic(control: CGPoint(x: 125, y: -60))),
            CourseWaypoint(position: CGPoint(x: 450, y: 16), curveToNext: .quadratic(control: CGPoint(x: 350, y: 2))),
            CourseWaypoint(position: CGPoint(x: 700, y: -52), curveToNext: .quadratic(control: CGPoint(x: 575, y: -64))),
            CourseWaypoint(position: CGPoint(x: 900, y: 18), curveToNext: .quadratic(control: CGPoint(x: 800, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1150, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1025, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1350, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1475, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1700, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2050, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1925, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2250, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2150, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2500, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2375, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2600, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2950, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2825, y: -56))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 16), curveToNext: .quadratic(control: CGPoint(x: 3075, y: 2))),
            CourseWaypoint(position: CGPoint(x: 3440, y: -38), curveToNext: .quadratic(control: CGPoint(x: 3320, y: -50))),
            CourseWaypoint(position: CGPoint(x: 3700, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3570, y: -14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .ropeHighlightGray, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyTop, .electricBlue]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 29

    static let candyCane = makeCourse(
        id: "candyCane",
        displayName: "Candy Cane",
        unlockOrder: 144,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -22), curveToNext: .quadratic(control: CGPoint(x: 90, y: -26))),
            CourseWaypoint(position: CGPoint(x: 360, y: 24), curveToNext: .quadratic(control: CGPoint(x: 270, y: 28))),
            CourseWaypoint(position: CGPoint(x: 540, y: -28), curveToNext: .quadratic(control: CGPoint(x: 450, y: -34))),
            CourseWaypoint(position: CGPoint(x: 720, y: 30), curveToNext: .quadratic(control: CGPoint(x: 630, y: 36))),
            CourseWaypoint(position: CGPoint(x: 900, y: -34), curveToNext: .quadratic(control: CGPoint(x: 810, y: -42))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 36), curveToNext: .quadratic(control: CGPoint(x: 990, y: 44))),
            CourseWaypoint(position: CGPoint(x: 1260, y: -40), curveToNext: .quadratic(control: CGPoint(x: 1170, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1440, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1620, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1530, y: -50))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1710, y: 48))),
            CourseWaypoint(position: CGPoint(x: 1980, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1890, y: -44))),
            CourseWaypoint(position: CGPoint(x: 2160, y: 32), curveToNext: .quadratic(control: CGPoint(x: 2070, y: 40))),
            CourseWaypoint(position: CGPoint(x: 2340, y: -28), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -36))),
            CourseWaypoint(position: CGPoint(x: 2520, y: 24), curveToNext: .quadratic(control: CGPoint(x: 2430, y: 30))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2610, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2900, y: 16), curveToNext: .quadratic(control: CGPoint(x: 2800, y: 20))),
            CourseWaypoint(position: CGPoint(x: 3100, y: -12), curveToNext: .quadratic(control: CGPoint(x: 3000, y: -16))),
            CourseWaypoint(position: CGPoint(x: 3300, y: 8), curveToNext: .quadratic(control: CGPoint(x: 3200, y: 10))),
            CourseWaypoint(position: CGPoint(x: 3520, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3410, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .ropeHighlightGray, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let forestLog = makeCourse(
        id: "forestLog",
        displayName: "Forest Log",
        unlockOrder: 145,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -48), curveToNext: .quadratic(control: CGPoint(x: 100, y: -60))),
            CourseWaypoint(position: CGPoint(x: 400, y: 18), curveToNext: .quadratic(control: CGPoint(x: 300, y: 4))),
            CourseWaypoint(position: CGPoint(x: 700, y: -52), curveToNext: .quadratic(control: CGPoint(x: 550, y: -64))),
            CourseWaypoint(position: CGPoint(x: 900, y: 20), curveToNext: .quadratic(control: CGPoint(x: 800, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1700, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1550, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 22), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 8))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 2050, y: -66))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 4))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2550, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2900, y: 22), curveToNext: .quadratic(control: CGPoint(x: 2800, y: 8))),
            CourseWaypoint(position: CGPoint(x: 3200, y: -44), curveToNext: .quadratic(control: CGPoint(x: 3050, y: -56))),
            CourseWaypoint(position: CGPoint(x: 3400, y: 16), curveToNext: .quadratic(control: CGPoint(x: 3300, y: 2))),
            CourseWaypoint(position: CGPoint(x: 3540, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3470, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .trackBlack, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .flameOrange]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .flameOrange, ropeHighlight: .trackBlack, skyGradient: [.flameOrange, .trackBlack]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let iceRink = makeCourse(
        id: "iceRink",
        displayName: "Ice Rink",
        unlockOrder: 146,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 280, y: -44), curveToNext: .quadratic(control: CGPoint(x: 140, y: -54))),
            CourseWaypoint(position: CGPoint(x: 560, y: 44), curveToNext: .quadratic(control: CGPoint(x: 420, y: 54))),
            CourseWaypoint(position: CGPoint(x: 840, y: -48), curveToNext: .quadratic(control: CGPoint(x: 700, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 48), curveToNext: .quadratic(control: CGPoint(x: 980, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1260, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1540, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1960, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1820, y: -58))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2100, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2520, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2380, y: -54))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2660, y: 52))),
            CourseWaypoint(position: CGPoint(x: 3080, y: -36), curveToNext: .quadratic(control: CGPoint(x: 2940, y: -46))),
            CourseWaypoint(position: CGPoint(x: 3360, y: 26), curveToNext: .quadratic(control: CGPoint(x: 3220, y: 34))),
            CourseWaypoint(position: CGPoint(x: 3560, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3460, y: 12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let lemonDrop = makeCourse(
        id: "lemonDrop",
        displayName: "Lemon Drop",
        unlockOrder: 147,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: 36), curveToNext: .quadratic(control: CGPoint(x: 120, y: 46))),
            CourseWaypoint(position: CGPoint(x: 460, y: 12), curveToNext: .quadratic(control: CGPoint(x: 350, y: 22))),
            CourseWaypoint(position: CGPoint(x: 680, y: 42), curveToNext: .quadratic(control: CGPoint(x: 570, y: 54))),
            CourseWaypoint(position: CGPoint(x: 900, y: -20), curveToNext: .quadratic(control: CGPoint(x: 790, y: -6))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1010, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1340, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1230, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1580, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1460, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1820, y: -22), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -8))),
            CourseWaypoint(position: CGPoint(x: 2060, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1940, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2300, y: 10), curveToNext: .quadratic(control: CGPoint(x: 2180, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2540, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2420, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2780, y: -18), curveToNext: .quadratic(control: CGPoint(x: 2660, y: -4))),
            CourseWaypoint(position: CGPoint(x: 3020, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2900, y: 48))),
            CourseWaypoint(position: CGPoint(x: 3280, y: 14), curveToNext: .quadratic(control: CGPoint(x: 3150, y: 24))),
            CourseWaypoint(position: CGPoint(x: 3580, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3430, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let skySlide = makeCourse(
        id: "skySlide",
        displayName: "Sky Slide",
        unlockOrder: 148,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: 54), curveToNext: .quadratic(control: CGPoint(x: 250, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -4), curveToNext: .quadratic(control: CGPoint(x: 750, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1600, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1850, y: -22))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 52), curveToNext: .quadratic(control: CGPoint(x: 2350, y: 64))),
            CourseWaypoint(position: CGPoint(x: 3100, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 20))),
            CourseWaypoint(position: CGPoint(x: 3600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3350, y: -10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 28

    static let mushroom = makeCourse(
        id: "mushroom",
        displayName: "Mushroom Lane",
        unlockOrder: 139,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 240, y: 48), curveToNext: .quadratic(control: CGPoint(x: 120, y: 58))),
            CourseWaypoint(position: CGPoint(x: 480, y: -4), curveToNext: .quadratic(control: CGPoint(x: 360, y: 14))),
            CourseWaypoint(position: CGPoint(x: 640, y: 22), curveToNext: .quadratic(control: CGPoint(x: 560, y: 28))),
            CourseWaypoint(position: CGPoint(x: 800, y: -8), curveToNext: .quadratic(control: CGPoint(x: 720, y: 6))),
            CourseWaypoint(position: CGPoint(x: 1060, y: 52), curveToNext: .quadratic(control: CGPoint(x: 930, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1320, y: -10), curveToNext: .quadratic(control: CGPoint(x: 1190, y: 12))),
            CourseWaypoint(position: CGPoint(x: 1480, y: 30), curveToNext: .quadratic(control: CGPoint(x: 1400, y: 38))),
            CourseWaypoint(position: CGPoint(x: 1720, y: 0), curveToNext: .quadratic(control: CGPoint(x: 1600, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1940, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1830, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2180, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2060, y: 12))),
            CourseWaypoint(position: CGPoint(x: 2360, y: 24), curveToNext: .quadratic(control: CGPoint(x: 2270, y: 32))),
            CourseWaypoint(position: CGPoint(x: 2600, y: 2), curveToNext: .quadratic(control: CGPoint(x: 2480, y: 14))),
            CourseWaypoint(position: CGPoint(x: 2820, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2710, y: 62))),
            CourseWaypoint(position: CGPoint(x: 3060, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2940, y: 10))),
            CourseWaypoint(position: CGPoint(x: 3240, y: 18), curveToNext: .quadratic(control: CGPoint(x: 3150, y: 26))),
            CourseWaypoint(position: CGPoint(x: 3420, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3330, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .hotRed, ropeHighlight: .ropeHighlightGray, skyGradient: [.hotRed, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let tidePool = makeCourse(
        id: "tidePool",
        displayName: "Tide Pool",
        unlockOrder: 140,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 450, y: 52), curveToNext: .quadratic(control: CGPoint(x: 225, y: 64))),
            CourseWaypoint(position: CGPoint(x: 900, y: -4), curveToNext: .quadratic(control: CGPoint(x: 675, y: 20))),
            CourseWaypoint(position: CGPoint(x: 1350, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1125, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2250, y: 52), curveToNext: .quadratic(control: CGPoint(x: 2025, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2475, y: 18))),
            CourseWaypoint(position: CGPoint(x: 3100, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2900, y: -62))),
            CourseWaypoint(position: CGPoint(x: 3440, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3270, y: -16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let snowDrift = makeCourse(
        id: "snowDrift",
        displayName: "Snow Drift",
        unlockOrder: 141,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: -36), curveToNext: .quadratic(control: CGPoint(x: 200, y: -44))),
            CourseWaypoint(position: CGPoint(x: 800, y: -8), curveToNext: .quadratic(control: CGPoint(x: 600, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -52))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -8))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 34), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 44))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2200, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -56))),
            CourseWaypoint(position: CGPoint(x: 3100, y: 2), curveToNext: .quadratic(control: CGPoint(x: 2950, y: -12))),
            CourseWaypoint(position: CGPoint(x: 3460, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3280, y: 2))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let cloverField = makeCourse(
        id: "cloverField",
        displayName: "Clover Field",
        unlockOrder: 142,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 280, y: 36), curveToNext: .quadratic(control: CGPoint(x: 140, y: 46))),
            CourseWaypoint(position: CGPoint(x: 530, y: 8), curveToNext: .quadratic(control: CGPoint(x: 405, y: 18))),
            CourseWaypoint(position: CGPoint(x: 800, y: 40), curveToNext: .quadratic(control: CGPoint(x: 665, y: 52))),
            CourseWaypoint(position: CGPoint(x: 1100, y: 12), curveToNext: .quadratic(control: CGPoint(x: 950, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1240, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1660, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1520, y: 18))),
            CourseWaypoint(position: CGPoint(x: 2040, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1850, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2340, y: 14), curveToNext: .quadratic(control: CGPoint(x: 2190, y: 26))),
            CourseWaypoint(position: CGPoint(x: 2640, y: 38), curveToNext: .quadratic(control: CGPoint(x: 2490, y: 50))),
            CourseWaypoint(position: CGPoint(x: 2940, y: -18), curveToNext: .quadratic(control: CGPoint(x: 2790, y: -4))),
            CourseWaypoint(position: CGPoint(x: 3240, y: 22), curveToNext: .quadratic(control: CGPoint(x: 3090, y: 30))),
            CourseWaypoint(position: CGPoint(x: 3480, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3360, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .skyTop]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyBottom]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let marbleRun = makeCourse(
        id: "marbleRun",
        displayName: "Marble Run",
        unlockOrder: 143,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -36), curveToNext: .quadratic(control: CGPoint(x: 100, y: -44))),
            CourseWaypoint(position: CGPoint(x: 400, y: 36), curveToNext: .quadratic(control: CGPoint(x: 300, y: 44))),
            CourseWaypoint(position: CGPoint(x: 600, y: -38), curveToNext: .quadratic(control: CGPoint(x: 500, y: -46))),
            CourseWaypoint(position: CGPoint(x: 800, y: 38), curveToNext: .quadratic(control: CGPoint(x: 700, y: 46))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -40), curveToNext: .quadratic(control: CGPoint(x: 900, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 50))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -42), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -50))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 42), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 50))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -38), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -46))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 38), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 46))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -36), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -44))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 34), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 42))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -30), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -38))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 26), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 34))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -20), curveToNext: .quadratic(control: CGPoint(x: 2900, y: -28))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 14), curveToNext: .quadratic(control: CGPoint(x: 3100, y: 20))),
            CourseWaypoint(position: CGPoint(x: 3380, y: -8), curveToNext: .quadratic(control: CGPoint(x: 3290, y: -14))),
            CourseWaypoint(position: CGPoint(x: 3500, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3440, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 27

    static let pebblePath = makeCourse(
        id: "pebblePath",
        displayName: "Pebble Path",
        unlockOrder: 134,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: -22), curveToNext: .quadratic(control: CGPoint(x: 90, y: -28))),
            CourseWaypoint(position: CGPoint(x: 340, y: 16), curveToNext: .quadratic(control: CGPoint(x: 260, y: 20))),
            CourseWaypoint(position: CGPoint(x: 480, y: -28), curveToNext: .quadratic(control: CGPoint(x: 410, y: -34))),
            CourseWaypoint(position: CGPoint(x: 700, y: 12), curveToNext: .quadratic(control: CGPoint(x: 590, y: 16))),
            CourseWaypoint(position: CGPoint(x: 860, y: -18), curveToNext: .quadratic(control: CGPoint(x: 780, y: -24))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 26), curveToNext: .quadratic(control: CGPoint(x: 930, y: 32))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -14), curveToNext: .quadratic(control: CGPoint(x: 1100, y: -18))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 28), curveToNext: .quadratic(control: CGPoint(x: 1300, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1620, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1510, y: -26))),
            CourseWaypoint(position: CGPoint(x: 1780, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1700, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1960, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1870, y: -30))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2080, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2380, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2290, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2560, y: 26), curveToNext: .quadratic(control: CGPoint(x: 2470, y: 32))),
            CourseWaypoint(position: CGPoint(x: 2780, y: -16), curveToNext: .quadratic(control: CGPoint(x: 2670, y: -22))),
            CourseWaypoint(position: CGPoint(x: 2980, y: 22), curveToNext: .quadratic(control: CGPoint(x: 2880, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3160, y: -14), curveToNext: .quadratic(control: CGPoint(x: 3070, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3320, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3240, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .ropeHighlightGray, ropeHighlight: .trackBlack, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .trackBlack, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .electricBlue]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let zipLine = makeCourse(
        id: "zipLine",
        displayName: "Zip Line",
        unlockOrder: 135,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: -38), curveToNext: .quadratic(control: CGPoint(x: 150, y: -48))),
            CourseWaypoint(position: CGPoint(x: 500, y: 20), curveToNext: .quadratic(control: CGPoint(x: 400, y: 8))),
            CourseWaypoint(position: CGPoint(x: 800, y: -44), curveToNext: .quadratic(control: CGPoint(x: 650, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 22), curveToNext: .quadratic(control: CGPoint(x: 900, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1300, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1150, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 18), curveToNext: .quadratic(control: CGPoint(x: 1400, y: 4))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1650, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 10))),
            CourseWaypoint(position: CGPoint(x: 2300, y: -46), curveToNext: .quadratic(control: CGPoint(x: 2150, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2500, y: 20), curveToNext: .quadratic(control: CGPoint(x: 2400, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2650, y: -54))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 22), curveToNext: .quadratic(control: CGPoint(x: 2900, y: 8))),
            CourseWaypoint(position: CGPoint(x: 3200, y: -38), curveToNext: .quadratic(control: CGPoint(x: 3100, y: -48))),
            CourseWaypoint(position: CGPoint(x: 3340, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3270, y: -12))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.5, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.5, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let sandCastle = makeCourse(
        id: "sandCastle",
        displayName: "Sand Castle",
        unlockOrder: 136,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 280, y: 40), curveToNext: .quadratic(control: CGPoint(x: 140, y: 50))),
            CourseWaypoint(position: CGPoint(x: 560, y: 8), curveToNext: .quadratic(control: CGPoint(x: 420, y: 18))),
            CourseWaypoint(position: CGPoint(x: 840, y: 46), curveToNext: .quadratic(control: CGPoint(x: 700, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1080, y: 12), curveToNext: .quadratic(control: CGPoint(x: 960, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1380, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1230, y: 56))),
            CourseWaypoint(position: CGPoint(x: 1680, y: 6), curveToNext: .quadratic(control: CGPoint(x: 1530, y: 18))),
            CourseWaypoint(position: CGPoint(x: 1960, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1820, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 16), curveToNext: .quadratic(control: CGPoint(x: 2080, y: 28))),
            CourseWaypoint(position: CGPoint(x: 2500, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2350, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2780, y: 10), curveToNext: .quadratic(control: CGPoint(x: 2640, y: 22))),
            CourseWaypoint(position: CGPoint(x: 3060, y: -20), curveToNext: .quadratic(control: CGPoint(x: 2920, y: -8))),
            CourseWaypoint(position: CGPoint(x: 3360, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3210, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let jellyRoad = makeCourse(
        id: "jellyRoad",
        displayName: "Jelly Road",
        unlockOrder: 137,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 200, y: -22), curveToNext: .quadratic(control: CGPoint(x: 100, y: -26))),
            CourseWaypoint(position: CGPoint(x: 400, y: 22), curveToNext: .quadratic(control: CGPoint(x: 300, y: 26))),
            CourseWaypoint(position: CGPoint(x: 600, y: -28), curveToNext: .quadratic(control: CGPoint(x: 500, y: -34))),
            CourseWaypoint(position: CGPoint(x: 800, y: 30), curveToNext: .quadratic(control: CGPoint(x: 700, y: 36))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -34), curveToNext: .quadratic(control: CGPoint(x: 900, y: -42))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 36), curveToNext: .quadratic(control: CGPoint(x: 1100, y: 44))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -40), curveToNext: .quadratic(control: CGPoint(x: 1300, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 48))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -36), curveToNext: .quadratic(control: CGPoint(x: 1700, y: -44))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 34), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 42))),
            CourseWaypoint(position: CGPoint(x: 2200, y: -28), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -36))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 26), curveToNext: .quadratic(control: CGPoint(x: 2300, y: 32))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2500, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 22))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2900, y: -18))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 10), curveToNext: .quadratic(control: CGPoint(x: 3100, y: 12))),
            CourseWaypoint(position: CGPoint(x: 3380, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3290, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .electricBlue]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let cactusPass = makeCourse(
        id: "cactusPass",
        displayName: "Cactus Pass",
        unlockOrder: 138,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 150, y: 54), curveToNext: .quadratic(control: CGPoint(x: 75, y: 66))),
            CourseWaypoint(position: CGPoint(x: 300, y: -22), curveToNext: .quadratic(control: CGPoint(x: 225, y: -8))),
            CourseWaypoint(position: CGPoint(x: 500, y: 52), curveToNext: .quadratic(control: CGPoint(x: 400, y: 64))),
            CourseWaypoint(position: CGPoint(x: 660, y: -24), curveToNext: .quadratic(control: CGPoint(x: 580, y: -10))),
            CourseWaypoint(position: CGPoint(x: 860, y: 56), curveToNext: .quadratic(control: CGPoint(x: 760, y: 68))),
            CourseWaypoint(position: CGPoint(x: 1020, y: -26), curveToNext: .quadratic(control: CGPoint(x: 940, y: -12))),
            CourseWaypoint(position: CGPoint(x: 1220, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1120, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1400, y: -28), curveToNext: .quadratic(control: CGPoint(x: 1310, y: -14))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1500, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1780, y: -24), curveToNext: .quadratic(control: CGPoint(x: 1690, y: -10))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1880, y: 70))),
            CourseWaypoint(position: CGPoint(x: 2160, y: -26), curveToNext: .quadratic(control: CGPoint(x: 2070, y: -12))),
            CourseWaypoint(position: CGPoint(x: 2360, y: 52), curveToNext: .quadratic(control: CGPoint(x: 2260, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2540, y: -22), curveToNext: .quadratic(control: CGPoint(x: 2450, y: -8))),
            CourseWaypoint(position: CGPoint(x: 2740, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2640, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2940, y: -20), curveToNext: .quadratic(control: CGPoint(x: 2840, y: -8))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 26), curveToNext: .quadratic(control: CGPoint(x: 3070, y: 14))),
            CourseWaypoint(position: CGPoint(x: 3400, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3300, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .flameOrange, ropeHighlight: .hotRed, skyGradient: [.flameOrange, .hotRed]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .hotRed, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .racingYellow]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 26

    static let sunnyMeadow = makeCourse(
        id: "sunnyMeadow",
        displayName: "Sunny Meadow",
        unlockOrder: 129,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 350, y: 38), curveToNext: .quadratic(control: CGPoint(x: 175, y: 48))),
            CourseWaypoint(position: CGPoint(x: 700, y: 14), curveToNext: .quadratic(control: CGPoint(x: 525, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1050, y: 46), curveToNext: .quadratic(control: CGPoint(x: 875, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1400, y: 20), curveToNext: .quadratic(control: CGPoint(x: 1225, y: 32))),
            CourseWaypoint(position: CGPoint(x: 1750, y: -22), curveToNext: .quadratic(control: CGPoint(x: 1575, y: 6))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 40), curveToNext: .quadratic(control: CGPoint(x: 1925, y: 52))),
            CourseWaypoint(position: CGPoint(x: 2450, y: 18), curveToNext: .quadratic(control: CGPoint(x: 2275, y: 30))),
            CourseWaypoint(position: CGPoint(x: 2750, y: -28), curveToNext: .quadratic(control: CGPoint(x: 2600, y: 4))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 36), curveToNext: .quadratic(control: CGPoint(x: 2875, y: 48))),
            CourseWaypoint(position: CGPoint(x: 3220, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3110, y: 14))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 128
    )

    static let cloudWalk = makeCourse(
        id: "cloudWalk",
        displayName: "Cloud Walk",
        unlockOrder: 130,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: 52), curveToNext: .quadratic(control: CGPoint(x: 200, y: 64))),
            CourseWaypoint(position: CGPoint(x: 800, y: -8), curveToNext: .quadratic(control: CGPoint(x: 600, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -18))),
            CourseWaypoint(position: CGPoint(x: 2000, y: 56), curveToNext: .quadratic(control: CGPoint(x: 1800, y: 68))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2200, y: 22))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3100, y: 12), curveToNext: .quadratic(control: CGPoint(x: 2950, y: -6))),
            CourseWaypoint(position: CGPoint(x: 3240, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3170, y: 6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 128
    )

    static let bubblePop = makeCourse(
        id: "bubblePop",
        displayName: "Bubble Pop",
        unlockOrder: 131,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -20), curveToNext: .quadratic(control: CGPoint(x: 80, y: -24))),
            CourseWaypoint(position: CGPoint(x: 320, y: 20), curveToNext: .quadratic(control: CGPoint(x: 240, y: 24))),
            CourseWaypoint(position: CGPoint(x: 480, y: -28), curveToNext: .quadratic(control: CGPoint(x: 400, y: -34))),
            CourseWaypoint(position: CGPoint(x: 640, y: 28), curveToNext: .quadratic(control: CGPoint(x: 560, y: 34))),
            CourseWaypoint(position: CGPoint(x: 800, y: -38), curveToNext: .quadratic(control: CGPoint(x: 720, y: -46))),
            CourseWaypoint(position: CGPoint(x: 960, y: 40), curveToNext: .quadratic(control: CGPoint(x: 880, y: 48))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -54))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -38), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -48))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 36), curveToNext: .quadratic(control: CGPoint(x: 1520, y: 44))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -28), curveToNext: .quadratic(control: CGPoint(x: 1680, y: -36))),
            CourseWaypoint(position: CGPoint(x: 1920, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1840, y: 30))),
            CourseWaypoint(position: CGPoint(x: 2080, y: -18), curveToNext: .quadratic(control: CGPoint(x: 2000, y: -22))),
            CourseWaypoint(position: CGPoint(x: 2280, y: 12), curveToNext: .quadratic(control: CGPoint(x: 2180, y: 14))),
            CourseWaypoint(position: CGPoint(x: 2500, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2390, y: -10))),
            CourseWaypoint(position: CGPoint(x: 2750, y: 6), curveToNext: .quadratic(control: CGPoint(x: 2625, y: 6))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2875, y: -6))),
            CourseWaypoint(position: CGPoint(x: 3260, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3130, y: -2))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.66, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.66, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let rainbowBridge = makeCourse(
        id: "rainbowBridge",
        displayName: "Rainbow Bridge",
        unlockOrder: 132,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: 30), curveToNext: .quadratic(control: CGPoint(x: 250, y: 40))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 50), curveToNext: .quadratic(control: CGPoint(x: 750, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 54), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1900, y: 50), curveToNext: .quadratic(control: CGPoint(x: 1700, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2300, y: 34), curveToNext: .quadratic(control: CGPoint(x: 2100, y: 44))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 10), curveToNext: .quadratic(control: CGPoint(x: 2500, y: 20))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -16), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 2))),
            CourseWaypoint(position: CGPoint(x: 3280, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3140, y: -8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let starLane = makeCourse(
        id: "starLane",
        displayName: "Star Lane",
        unlockOrder: 133,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: -4), curveToNext: .quadratic(control: CGPoint(x: 250, y: -6))),
            CourseWaypoint(position: CGPoint(x: 700, y: -50), curveToNext: .quadratic(control: CGPoint(x: 600, y: -62))),
            CourseWaypoint(position: CGPoint(x: 800, y: 46), curveToNext: .quadratic(control: CGPoint(x: 750, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1300, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1050, y: 22))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1400, y: -64))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1550, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 4), curveToNext: .quadratic(control: CGPoint(x: 1850, y: 18))),
            CourseWaypoint(position: CGPoint(x: 2300, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2400, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2350, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2600, y: 14))),
            CourseWaypoint(position: CGPoint(x: 3000, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2900, y: -60))),
            CourseWaypoint(position: CGPoint(x: 3100, y: 44), curveToNext: .quadratic(control: CGPoint(x: 3050, y: 56))),
            CourseWaypoint(position: CGPoint(x: 3300, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3200, y: 18))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.6, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 38

    static let crystalMaze = makeCourse(
        id: "crystalMaze",
        displayName: "Crystal Maze",
        unlockOrder: 189,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 180, y: 44), curveToNext: .quadratic(control: CGPoint(x: 90, y: 54))),
            CourseWaypoint(position: CGPoint(x: 360, y: -46), curveToNext: .quadratic(control: CGPoint(x: 270, y: -58))),
            CourseWaypoint(position: CGPoint(x: 580, y: 14), curveToNext: .quadratic(control: CGPoint(x: 470, y: -10))),
            CourseWaypoint(position: CGPoint(x: 840, y: -50), curveToNext: .quadratic(control: CGPoint(x: 710, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1120, y: 42), curveToNext: .quadratic(control: CGPoint(x: 980, y: 54))),
            CourseWaypoint(position: CGPoint(x: 1380, y: -6), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1680, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1530, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1980, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1830, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2260, y: -4), curveToNext: .quadratic(control: CGPoint(x: 2120, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2560, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2410, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2880, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2720, y: 54))),
            CourseWaypoint(position: CGPoint(x: 3200, y: -6), curveToNext: .quadratic(control: CGPoint(x: 3040, y: 14))),
            CourseWaypoint(position: CGPoint(x: 3560, y: -48), curveToNext: .quadratic(control: CGPoint(x: 3380, y: -60))),
            CourseWaypoint(position: CGPoint(x: 3940, y: 20), curveToNext: .quadratic(control: CGPoint(x: 3750, y: 8))),
            CourseWaypoint(position: CGPoint(x: 4420, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4180, y: 10))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyTop, .electricBlue]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let cosmicDrift = makeCourse(
        id: "cosmicDrift",
        displayName: "Cosmic Drift",
        unlockOrder: 190,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: 52), curveToNext: .quadratic(control: CGPoint(x: 250, y: 64))),
            CourseWaypoint(position: CGPoint(x: 1000, y: 2), curveToNext: .quadratic(control: CGPoint(x: 750, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1500, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1250, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -26))),
            CourseWaypoint(position: CGPoint(x: 2500, y: 54), curveToNext: .quadratic(control: CGPoint(x: 2250, y: 66))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 4), curveToNext: .quadratic(control: CGPoint(x: 2750, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3500, y: -54), curveToNext: .quadratic(control: CGPoint(x: 3250, y: -66))),
            CourseWaypoint(position: CGPoint(x: 4000, y: -2), curveToNext: .quadratic(control: CGPoint(x: 3750, y: -24))),
            CourseWaypoint(position: CGPoint(x: 4440, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4220, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .trackBlack, ropeHighlight: .electricBlue, skyGradient: [.trackBlack, .electricBlue]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.65, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .trackBlack]),
            StyleDefinition(startFraction: 0.65, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.trackBlack, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let vortexRoad = makeCourse(
        id: "vortexRoad",
        displayName: "Vortex Road",
        unlockOrder: 191,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: 18), curveToNext: .quadratic(control: CGPoint(x: 80, y: 24))),
            CourseWaypoint(position: CGPoint(x: 360, y: -30), curveToNext: .quadratic(control: CGPoint(x: 260, y: -40))),
            CourseWaypoint(position: CGPoint(x: 620, y: 48), curveToNext: .quadratic(control: CGPoint(x: 490, y: 60))),
            CourseWaypoint(position: CGPoint(x: 940, y: -56), curveToNext: .quadratic(control: CGPoint(x: 780, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1320, y: 58), curveToNext: .quadratic(control: CGPoint(x: 1130, y: 70))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1540, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2200, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1980, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2600, y: -44), curveToNext: .quadratic(control: CGPoint(x: 2400, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2940, y: 38), curveToNext: .quadratic(control: CGPoint(x: 2770, y: 50))),
            CourseWaypoint(position: CGPoint(x: 3240, y: -28), curveToNext: .quadratic(control: CGPoint(x: 3090, y: -40))),
            CourseWaypoint(position: CGPoint(x: 3500, y: 20), curveToNext: .quadratic(control: CGPoint(x: 3370, y: 30))),
            CourseWaypoint(position: CGPoint(x: 3740, y: -12), curveToNext: .quadratic(control: CGPoint(x: 3620, y: -20))),
            CourseWaypoint(position: CGPoint(x: 4460, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4100, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .flameOrange, ropeHighlight: .electricBlue, skyGradient: [.flameOrange, .electricBlue]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.electricBlue, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let horizonPath = makeCourse(
        id: "horizonPath",
        displayName: "Horizon Path",
        unlockOrder: 192,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 450, y: -50), curveToNext: .quadratic(control: CGPoint(x: 225, y: -62))),
            CourseWaypoint(position: CGPoint(x: 900, y: -60), curveToNext: .quadratic(control: CGPoint(x: 675, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1350, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1125, y: -36))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 24), curveToNext: .quadratic(control: CGPoint(x: 1575, y: 12))),
            CourseWaypoint(position: CGPoint(x: 2250, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2025, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2700, y: -58), curveToNext: .quadratic(control: CGPoint(x: 2475, y: -68))),
            CourseWaypoint(position: CGPoint(x: 3150, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2925, y: -32))),
            CourseWaypoint(position: CGPoint(x: 3600, y: 22), curveToNext: .quadratic(control: CGPoint(x: 3375, y: 10))),
            CourseWaypoint(position: CGPoint(x: 4080, y: -6), curveToNext: .quadratic(control: CGPoint(x: 3840, y: -18))),
            CourseWaypoint(position: CGPoint(x: 4480, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4280, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.racingYellow, .flameOrange]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .flameOrange, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let stormBolt = makeCourse(
        id: "stormBolt",
        displayName: "Storm Bolt",
        unlockOrder: 193,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 220, y: 50), curveToNext: .quadratic(control: CGPoint(x: 110, y: 62))),
            CourseWaypoint(position: CGPoint(x: 420, y: -28), curveToNext: .quadratic(control: CGPoint(x: 320, y: 8))),
            CourseWaypoint(position: CGPoint(x: 680, y: -56), curveToNext: .quadratic(control: CGPoint(x: 550, y: -68))),
            CourseWaypoint(position: CGPoint(x: 940, y: 46), curveToNext: .quadratic(control: CGPoint(x: 810, y: 34))),
            CourseWaypoint(position: CGPoint(x: 1180, y: -22), curveToNext: .quadratic(control: CGPoint(x: 1060, y: 10))),
            CourseWaypoint(position: CGPoint(x: 1480, y: -58), curveToNext: .quadratic(control: CGPoint(x: 1330, y: -70))),
            CourseWaypoint(position: CGPoint(x: 1780, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1630, y: 36))),
            CourseWaypoint(position: CGPoint(x: 2060, y: -18), curveToNext: .quadratic(control: CGPoint(x: 1920, y: 14))),
            CourseWaypoint(position: CGPoint(x: 2380, y: -56), curveToNext: .quadratic(control: CGPoint(x: 2220, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2540, y: 34))),
            CourseWaypoint(position: CGPoint(x: 3020, y: -20), curveToNext: .quadratic(control: CGPoint(x: 2860, y: 12))),
            CourseWaypoint(position: CGPoint(x: 3380, y: -52), curveToNext: .quadratic(control: CGPoint(x: 3200, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3760, y: 18), curveToNext: .quadratic(control: CGPoint(x: 3570, y: 6))),
            CourseWaypoint(position: CGPoint(x: 4500, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4130, y: 8))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .racingYellow, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .racingYellow]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.67, ropeStroke: .electricBlue, ropeHighlight: .racingYellow, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.67, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 39

    static let lightningRun = makeCourse(
        id: "lightningRun",
        displayName: "Lightning Run",
        unlockOrder: 194,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 160, y: -48), curveToNext: .quadratic(control: CGPoint(x: 80, y: -58))),
            CourseWaypoint(position: CGPoint(x: 320, y: 46), curveToNext: .quadratic(control: CGPoint(x: 240, y: 58))),
            CourseWaypoint(position: CGPoint(x: 480, y: -50), curveToNext: .quadratic(control: CGPoint(x: 400, y: -62))),
            CourseWaypoint(position: CGPoint(x: 640, y: 48), curveToNext: .quadratic(control: CGPoint(x: 560, y: 60))),
            CourseWaypoint(position: CGPoint(x: 800, y: -52), curveToNext: .quadratic(control: CGPoint(x: 720, y: -64))),
            CourseWaypoint(position: CGPoint(x: 960, y: 50), curveToNext: .quadratic(control: CGPoint(x: 880, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -48), curveToNext: .quadratic(control: CGPoint(x: 1040, y: -60))),
            CourseWaypoint(position: CGPoint(x: 1280, y: 46), curveToNext: .quadratic(control: CGPoint(x: 1200, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -50), curveToNext: .quadratic(control: CGPoint(x: 1360, y: -62))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 48), curveToNext: .quadratic(control: CGPoint(x: 1520, y: 60))),
            CourseWaypoint(position: CGPoint(x: 1760, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1680, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1920, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1840, y: 56))),
            CourseWaypoint(position: CGPoint(x: 2080, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2000, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2240, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2160, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -14), curveToNext: .quadratic(control: CGPoint(x: 2320, y: -22))),
            CourseWaypoint(position: CGPoint(x: 4520, y: 0), curveToNext: .quadratic(control: CGPoint(x: 3460, y: -4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .trackBlack, ropeHighlight: .racingYellow, skyGradient: [.trackBlack, .racingYellow]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.racingYellow, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let silkRoad = makeCourse(
        id: "silkRoad",
        displayName: "Silk Road",
        unlockOrder: 195,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 450, y: 52), curveToNext: .quadratic(control: CGPoint(x: 225, y: 64))),
            CourseWaypoint(position: CGPoint(x: 900, y: 2), curveToNext: .quadratic(control: CGPoint(x: 675, y: 26))),
            CourseWaypoint(position: CGPoint(x: 1350, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1125, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -2), curveToNext: .quadratic(control: CGPoint(x: 1575, y: -26))),
            CourseWaypoint(position: CGPoint(x: 2250, y: 54), curveToNext: .quadratic(control: CGPoint(x: 2025, y: 66))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 4), curveToNext: .quadratic(control: CGPoint(x: 2475, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3150, y: -54), curveToNext: .quadratic(control: CGPoint(x: 2925, y: -66))),
            CourseWaypoint(position: CGPoint(x: 3600, y: -2), curveToNext: .quadratic(control: CGPoint(x: 3375, y: -24))),
            CourseWaypoint(position: CGPoint(x: 4050, y: 50), curveToNext: .quadratic(control: CGPoint(x: 3825, y: 62))),
            CourseWaypoint(position: CGPoint(x: 4540, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4295, y: 22))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .skyBottom, skyGradient: [.racingYellow, .skyBottom]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .skyBottom, ropeHighlight: .ropeHighlightGray, skyGradient: [.skyBottom, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let frostWave = makeCourse(
        id: "frostWave",
        displayName: "Frost Wave",
        unlockOrder: 196,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 300, y: 54), curveToNext: .quadratic(control: CGPoint(x: 150, y: 66))),
            CourseWaypoint(position: CGPoint(x: 600, y: 58), curveToNext: .quadratic(control: CGPoint(x: 450, y: 68))),
            CourseWaypoint(position: CGPoint(x: 900, y: 12), curveToNext: .quadratic(control: CGPoint(x: 750, y: 30))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -38), curveToNext: .quadratic(control: CGPoint(x: 1050, y: -26))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1350, y: 40))),
            CourseWaypoint(position: CGPoint(x: 1800, y: 60), curveToNext: .quadratic(control: CGPoint(x: 1650, y: 70))),
            CourseWaypoint(position: CGPoint(x: 2100, y: 8), curveToNext: .quadratic(control: CGPoint(x: 1950, y: 28))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -42), curveToNext: .quadratic(control: CGPoint(x: 2250, y: -28))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2550, y: 38))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 58), curveToNext: .quadratic(control: CGPoint(x: 2850, y: 68))),
            CourseWaypoint(position: CGPoint(x: 3300, y: 10), curveToNext: .quadratic(control: CGPoint(x: 3150, y: 28))),
            CourseWaypoint(position: CGPoint(x: 3660, y: -12), curveToNext: .quadratic(control: CGPoint(x: 3480, y: -2))),
            CourseWaypoint(position: CGPoint(x: 4560, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4110, y: -6))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.35, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.electricBlue, .skyBottom]),
            StyleDefinition(startFraction: 0.35, endFraction: 0.7, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.7, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let dawnRider = makeCourse(
        id: "dawnRider",
        displayName: "Dawn Rider",
        unlockOrder: 197,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 400, y: -52), curveToNext: .quadratic(control: CGPoint(x: 200, y: -64))),
            CourseWaypoint(position: CGPoint(x: 800, y: -58), curveToNext: .quadratic(control: CGPoint(x: 600, y: -68))),
            CourseWaypoint(position: CGPoint(x: 1200, y: -20), curveToNext: .quadratic(control: CGPoint(x: 1000, y: -38))),
            CourseWaypoint(position: CGPoint(x: 1600, y: 14), curveToNext: .quadratic(control: CGPoint(x: 1400, y: 2))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -44), curveToNext: .quadratic(control: CGPoint(x: 1800, y: -56))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -54), curveToNext: .quadratic(control: CGPoint(x: 2200, y: -64))),
            CourseWaypoint(position: CGPoint(x: 2800, y: -8), curveToNext: .quadratic(control: CGPoint(x: 2600, y: -26))),
            CourseWaypoint(position: CGPoint(x: 3200, y: 32), curveToNext: .quadratic(control: CGPoint(x: 3000, y: 20))),
            CourseWaypoint(position: CGPoint(x: 3600, y: -42), curveToNext: .quadratic(control: CGPoint(x: 3400, y: -54))),
            CourseWaypoint(position: CGPoint(x: 4000, y: -6), curveToNext: .quadratic(control: CGPoint(x: 3800, y: -24))),
            CourseWaypoint(position: CGPoint(x: 4400, y: 36), curveToNext: .quadratic(control: CGPoint(x: 4200, y: 24))),
            CourseWaypoint(position: CGPoint(x: 4580, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4490, y: 16))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.4, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.4, endFraction: 0.75, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let emberGlow = makeCourse(
        id: "emberGlow",
        displayName: "Ember Glow",
        unlockOrder: 198,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 260, y: 44), curveToNext: .quadratic(control: CGPoint(x: 130, y: 54))),
            CourseWaypoint(position: CGPoint(x: 560, y: -40), curveToNext: .quadratic(control: CGPoint(x: 410, y: -52))),
            CourseWaypoint(position: CGPoint(x: 820, y: 48), curveToNext: .quadratic(control: CGPoint(x: 690, y: 58))),
            CourseWaypoint(position: CGPoint(x: 1120, y: -10), curveToNext: .quadratic(control: CGPoint(x: 970, y: 14))),
            CourseWaypoint(position: CGPoint(x: 1440, y: -46), curveToNext: .quadratic(control: CGPoint(x: 1280, y: -58))),
            CourseWaypoint(position: CGPoint(x: 1740, y: 44), curveToNext: .quadratic(control: CGPoint(x: 1590, y: 54))),
            CourseWaypoint(position: CGPoint(x: 2060, y: -8), curveToNext: .quadratic(control: CGPoint(x: 1900, y: 16))),
            CourseWaypoint(position: CGPoint(x: 2380, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2220, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2700, y: 42), curveToNext: .quadratic(control: CGPoint(x: 2540, y: 52))),
            CourseWaypoint(position: CGPoint(x: 3040, y: -6), curveToNext: .quadratic(control: CGPoint(x: 2870, y: 16))),
            CourseWaypoint(position: CGPoint(x: 3400, y: -44), curveToNext: .quadratic(control: CGPoint(x: 3220, y: -56))),
            CourseWaypoint(position: CGPoint(x: 3760, y: 40), curveToNext: .quadratic(control: CGPoint(x: 3580, y: 52))),
            CourseWaypoint(position: CGPoint(x: 4140, y: 8), curveToNext: .quadratic(control: CGPoint(x: 3950, y: 22))),
            CourseWaypoint(position: CGPoint(x: 4600, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4370, y: 4))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.33, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.33, endFraction: 0.67, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.67, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.flameOrange, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    // MARK: - Batch 40 (Final)

    static let grandVista = makeCourse(
        id: "grandVista",
        displayName: "Grand Vista",
        unlockOrder: 199,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 600, y: 54), curveToNext: .quadratic(control: CGPoint(x: 300, y: 66))),
            CourseWaypoint(position: CGPoint(x: 1200, y: 4), curveToNext: .quadratic(control: CGPoint(x: 900, y: 28))),
            CourseWaypoint(position: CGPoint(x: 1800, y: -56), curveToNext: .quadratic(control: CGPoint(x: 1500, y: -68))),
            CourseWaypoint(position: CGPoint(x: 2400, y: -2), curveToNext: .quadratic(control: CGPoint(x: 2100, y: -26))),
            CourseWaypoint(position: CGPoint(x: 3000, y: 58), curveToNext: .quadratic(control: CGPoint(x: 2700, y: 70))),
            CourseWaypoint(position: CGPoint(x: 3600, y: 6), curveToNext: .quadratic(control: CGPoint(x: 3300, y: 30))),
            CourseWaypoint(position: CGPoint(x: 4200, y: -54), curveToNext: .quadratic(control: CGPoint(x: 3900, y: -66))),
            CourseWaypoint(position: CGPoint(x: 4620, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4410, y: -24))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.3, ropeStroke: .skyBottom, ropeHighlight: .electricBlue, skyGradient: [.skyTop, .skyBottom]),
            StyleDefinition(startFraction: 0.3, endFraction: 0.6, ropeStroke: .electricBlue, ropeHighlight: .skyBottom, skyGradient: [.skyBottom, .electricBlue]),
            StyleDefinition(startFraction: 0.6, endFraction: 1, ropeStroke: .racingYellow, ropeHighlight: .ropeHighlightGray, skyGradient: [.electricBlue, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let apexRun = makeCourse(
        id: "apexRun",
        displayName: "Apex Run",
        unlockOrder: 200,
        waypoints: [
            // Act 1: Graceful opening — wide sweeping arcs to build momentum
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(position: CGPoint(x: 500, y: 50), curveToNext: .quadratic(control: CGPoint(x: 250, y: 62))),
            CourseWaypoint(position: CGPoint(x: 1000, y: -54), curveToNext: .quadratic(control: CGPoint(x: 750, y: -66))),
            CourseWaypoint(position: CGPoint(x: 1500, y: 52), curveToNext: .quadratic(control: CGPoint(x: 1250, y: 64))),
            CourseWaypoint(position: CGPoint(x: 2000, y: -52), curveToNext: .quadratic(control: CGPoint(x: 1750, y: -64))),
            // Act 2: Rapid fire — tight alternating zigzag at intensity
            CourseWaypoint(position: CGPoint(x: 2160, y: 46), curveToNext: .quadratic(control: CGPoint(x: 2080, y: 58))),
            CourseWaypoint(position: CGPoint(x: 2320, y: -48), curveToNext: .quadratic(control: CGPoint(x: 2240, y: -60))),
            CourseWaypoint(position: CGPoint(x: 2480, y: 48), curveToNext: .quadratic(control: CGPoint(x: 2400, y: 60))),
            CourseWaypoint(position: CGPoint(x: 2640, y: -50), curveToNext: .quadratic(control: CGPoint(x: 2560, y: -62))),
            CourseWaypoint(position: CGPoint(x: 2800, y: 50), curveToNext: .quadratic(control: CGPoint(x: 2720, y: 62))),
            CourseWaypoint(position: CGPoint(x: 2960, y: -52), curveToNext: .quadratic(control: CGPoint(x: 2880, y: -64))),
            CourseWaypoint(position: CGPoint(x: 3120, y: 48), curveToNext: .quadratic(control: CGPoint(x: 3040, y: 60))),
            CourseWaypoint(position: CGPoint(x: 3280, y: -48), curveToNext: .quadratic(control: CGPoint(x: 3200, y: -60))),
            // Act 3: Grand climax — soaring final arcs into glory
            CourseWaypoint(position: CGPoint(x: 3680, y: 54), curveToNext: .quadratic(control: CGPoint(x: 3480, y: 66))),
            CourseWaypoint(position: CGPoint(x: 4080, y: -56), curveToNext: .quadratic(control: CGPoint(x: 3880, y: -68))),
            CourseWaypoint(position: CGPoint(x: 4480, y: 50), curveToNext: .quadratic(control: CGPoint(x: 4280, y: 62))),
            CourseWaypoint(position: CGPoint(x: 4640, y: 0), curveToNext: .quadratic(control: CGPoint(x: 4560, y: 24))),
        ],
        styleDefinitions: [
            StyleDefinition(startFraction: 0, endFraction: 0.25, ropeStroke: .hotRed, ropeHighlight: .flameOrange, skyGradient: [.trackBlack, .hotRed]),
            StyleDefinition(startFraction: 0.25, endFraction: 0.5, ropeStroke: .flameOrange, ropeHighlight: .racingYellow, skyGradient: [.hotRed, .flameOrange]),
            StyleDefinition(startFraction: 0.5, endFraction: 0.75, ropeStroke: .racingYellow, ropeHighlight: .electricBlue, skyGradient: [.flameOrange, .racingYellow]),
            StyleDefinition(startFraction: 0.75, endFraction: 1, ropeStroke: .electricBlue, ropeHighlight: .ropeHighlightGray, skyGradient: [.racingYellow, .skyTop]),
        ],
        ropeWidth: 44,
        forwardSpeed: 130
    )

    private static func makeCourse(
        id: String,
        displayName: String,
        unlockOrder: Int,
        waypoints: [CourseWaypoint],
        styleDefinitions: [StyleDefinition],
        ropeWidth: Double = 48,
        forwardSpeed: Double = 120,
        maxPitchRadians: Double = .pi / 4,
        backgroundTheme: BackgroundTheme? = nil,
        windProfile: WindProfile? = nil
    ) -> Course {
        let ticketCount: Int
        switch unlockOrder {
        case 0 ..< 25:  ticketCount = 3
        case 25 ..< 75: ticketCount = 4
        default:        ticketCount = 5
        }

        let resolvedTheme = backgroundTheme ?? CourseBackgroundThemeResolver.theme(forCourseID: id)
        let resolvedWind = windProfile ?? CourseWindResolver.profile(forCourseID: id)

        let provisional = Course(
            id: id,
            displayName: displayName,
            waypoints: waypoints,
            styleSpans: [],
            ropeWidth: ropeWidth,
            forwardSpeed: forwardSpeed,
            maxPitchRadians: maxPitchRadians,
            unlockOrder: unlockOrder,
            ticketCount: ticketCount,
            backgroundTheme: resolvedTheme,
            windProfile: resolvedWind
        )
        let totalLength = CourseSampler(course: provisional).totalLength
        let styleSpans = styleDefinitions.map { definition in
            CourseStyleSpan(
                startS: definition.startFraction * totalLength,
                endS: definition.endFraction * totalLength,
                ropeStroke: definition.ropeStroke,
                ropeHighlight: definition.ropeHighlight,
                skyGradient: definition.skyGradient
            )
        }
        return Course(
            id: id,
            displayName: displayName,
            waypoints: waypoints,
            styleSpans: styleSpans,
            ropeWidth: ropeWidth,
            forwardSpeed: forwardSpeed,
            maxPitchRadians: maxPitchRadians,
            unlockOrder: unlockOrder,
            ticketCount: ticketCount,
            backgroundTheme: resolvedTheme,
            windProfile: resolvedWind
        )
    }
}
