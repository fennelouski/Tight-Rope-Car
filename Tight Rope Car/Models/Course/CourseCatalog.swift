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
            CourseWaypoint(position: CGPoint(x: 520, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
        ],
        ropeWidth: 52,
        forwardSpeed: 100
    )

    static let bumps = makeCourse(
        id: "bumps",
        displayName: "Roller Rope",
        unlockOrder: 1,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 220, y: -55),
                curveToNext: .quadratic(control: CGPoint(x: 330, y: -95))
            ),
            CourseWaypoint(
                position: CGPoint(x: 440, y: 40),
                curveToNext: .quadratic(control: CGPoint(x: 550, y: 75))
            ),
            CourseWaypoint(
                position: CGPoint(x: 660, y: -35),
                curveToNext: .quadratic(control: CGPoint(x: 770, y: -70))
            ),
            CourseWaypoint(position: CGPoint(x: 900, y: 0)),
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
        forwardSpeed: 110
    )

    static let switchbacks = makeCourse(
        id: "switchbacks",
        displayName: "Switchbacks",
        unlockOrder: 2,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 200, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 260, y: 80))
            ),
            CourseWaypoint(
                position: CGPoint(x: 380, y: -30),
                curveToNext: .quadratic(control: CGPoint(x: 440, y: -100))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: 25),
                curveToNext: .quadratic(control: CGPoint(x: 620, y: 95))
            ),
            CourseWaypoint(
                position: CGPoint(x: 740, y: -20),
                curveToNext: .quadratic(control: CGPoint(x: 800, y: -90))
            ),
            CourseWaypoint(position: CGPoint(x: 980, y: 0)),
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
        ]
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
        ropeWidth: 44,
        forwardSpeed: 130
    )

    static let narrowWire = makeCourse(
        id: "narrowWire",
        displayName: "Narrow Wire",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 160, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 80, y: 8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 320, y: -2),
                curveToNext: .line,
                ropeWidth: 30
            ),
            CourseWaypoint(
                position: CGPoint(x: 500, y: 3),
                curveToNext: .line,
                ropeWidth: 28
            ),
            CourseWaypoint(
                position: CGPoint(x: 680, y: -1),
                curveToNext: .quadratic(control: CGPoint(x: 750, y: 6)),
                ropeWidth: 32
            ),
            CourseWaypoint(position: CGPoint(x: 820, y: 0)),
        ],
        styleDefinitions: [
            StyleDefinition(
                startFraction: 0,
                endFraction: 0.4,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyTop, .skyBottom]
            ),
            StyleDefinition(
                startFraction: 0.4,
                endFraction: 0.75,
                ropeStroke: .electricBlue,
                ropeHighlight: .racingYellow,
                skyGradient: nil
            ),
            StyleDefinition(
                startFraction: 0.75,
                endFraction: 1,
                ropeStroke: .trackBlack,
                ropeHighlight: .ropeHighlightGray,
                skyGradient: [.skyBottom, .skyTop]
            ),
        ],
        ropeWidth: 48,
        forwardSpeed: 105,
        maxPitchRadians: .pi / 5
    )

    static let bigDrop = makeCourse(
        id: "bigDrop",
        displayName: "Big Drop",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 240, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 120, y: 18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 480, y: 12),
                curveToNext: .quadratic(control: CGPoint(x: 360, y: 14))
            ),
            CourseWaypoint(
                position: CGPoint(x: 720, y: 8),
                curveToNext: .quadratic(control: CGPoint(x: 600, y: 5))
            ),
            CourseWaypoint(
                position: CGPoint(x: 900, y: -150),
                curveToNext: .quadratic(control: CGPoint(x: 960, y: -240))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1080, y: -70),
                curveToNext: .quadratic(control: CGPoint(x: 1180, y: 20))
            ),
            CourseWaypoint(position: CGPoint(x: 1320, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 130, y: 18),
                curveToNext: .quadratic(control: CGPoint(x: 85, y: 75))
            ),
            CourseWaypoint(
                position: CGPoint(x: -100, y: -22),
                curveToNext: .quadratic(control: CGPoint(x: 25, y: -85))
            ),
            CourseWaypoint(
                position: CGPoint(x: 210, y: 28),
                curveToNext: .quadratic(control: CGPoint(x: 115, y: 95))
            ),
            CourseWaypoint(
                position: CGPoint(x: -85, y: -18),
                curveToNext: .quadratic(control: CGPoint(x: 45, y: -75))
            ),
            CourseWaypoint(
                position: CGPoint(x: 250, y: 22),
                curveToNext: .quadratic(control: CGPoint(x: 165, y: 88))
            ),
            CourseWaypoint(
                position: CGPoint(x: -60, y: -12),
                curveToNext: .quadratic(control: CGPoint(x: 75, y: -65))
            ),
            CourseWaypoint(position: CGPoint(x: 340, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 140, y: 22),
                curveToNext: .quadratic(control: CGPoint(x: 95, y: 42))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: 0),
                curveToNext: .quadratic(control: CGPoint(x: 210, y: -18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 420, y: 28),
                curveToNext: .quadratic(control: CGPoint(x: 350, y: 48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: 5),
                curveToNext: .quadratic(control: CGPoint(x: 490, y: -145))
            ),
            CourseWaypoint(
                position: CGPoint(x: 720, y: 32),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: 52))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: 8),
                curveToNext: .quadratic(control: CGPoint(x: 800, y: -12))
            ),
            CourseWaypoint(position: CGPoint(x: 1020, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 160, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 95, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 310, y: -3),
                curveToNext: .quadratic(control: CGPoint(x: 240, y: -8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 470, y: 5),
                curveToNext: .quadratic(control: CGPoint(x: 400, y: 12))
            ),
            CourseWaypoint(
                position: CGPoint(x: 620, y: -2),
                curveToNext: .quadratic(control: CGPoint(x: 555, y: -7))
            ),
            CourseWaypoint(
                position: CGPoint(x: 780, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 710, y: 9))
            ),
            CourseWaypoint(
                position: CGPoint(x: 940, y: -3),
                curveToNext: .quadratic(control: CGPoint(x: 870, y: -6))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1100, y: 2),
                curveToNext: .quadratic(control: CGPoint(x: 1030, y: 6))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1260, y: -2),
                curveToNext: .quadratic(control: CGPoint(x: 1190, y: -5))
            ),
            CourseWaypoint(position: CGPoint(x: 1420, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 180, y: -25),
                curveToNext: .quadratic(control: CGPoint(x: 110, y: -18))
            ),
            CourseWaypoint(
                position: CGPoint(x: 360, y: -58),
                curveToNext: .quadratic(control: CGPoint(x: 280, y: -48))
            ),
            CourseWaypoint(
                position: CGPoint(x: 540, y: -92),
                curveToNext: .quadratic(control: CGPoint(x: 460, y: -82))
            ),
            CourseWaypoint(
                position: CGPoint(x: 720, y: -118),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: -108))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: -125),
                curveToNext: .line
            ),
            CourseWaypoint(
                position: CGPoint(x: 1040, y: -124),
                curveToNext: .line
            ),
            CourseWaypoint(position: CGPoint(x: 1180, y: -124)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 95, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 55, y: 55))
            ),
            CourseWaypoint(
                position: CGPoint(x: -110, y: -12),
                curveToNext: .quadratic(control: CGPoint(x: -20, y: -48)),
                ropeWidth: 36
            ),
            CourseWaypoint(
                position: CGPoint(x: 105, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 10, y: 58))
            ),
            CourseWaypoint(
                position: CGPoint(x: -95, y: -10),
                curveToNext: .quadratic(control: CGPoint(x: -15, y: -45))
            ),
            CourseWaypoint(
                position: CGPoint(x: 100, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 15, y: 52))
            ),
            CourseWaypoint(
                position: CGPoint(x: -85, y: -8),
                curveToNext: .quadratic(control: CGPoint(x: -5, y: -40))
            ),
            CourseWaypoint(position: CGPoint(x: 145, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 200, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 120, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 400, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 320, y: 12))
            ),
            CourseWaypoint(
                position: CGPoint(x: 620, y: -105),
                curveToNext: .quadratic(control: CGPoint(x: 510, y: -135))
            ),
            CourseWaypoint(
                position: CGPoint(x: 860, y: 10),
                curveToNext: .quadratic(control: CGPoint(x: 750, y: -125))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1040, y: 2),
                curveToNext: .quadratic(control: CGPoint(x: 960, y: 8))
            ),
            CourseWaypoint(position: CGPoint(x: 1180, y: 0)),
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
                position: CGPoint(x: 140, y: -14),
                curveToNext: .quadratic(control: CGPoint(x: 85, y: -28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: 16),
                curveToNext: .quadratic(control: CGPoint(x: 220, y: 30))
            ),
            CourseWaypoint(
                position: CGPoint(x: 420, y: -12),
                curveToNext: .quadratic(control: CGPoint(x: 360, y: -24))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 500, y: 26))
            ),
            CourseWaypoint(
                position: CGPoint(x: 700, y: -10),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: -20))
            ),
            CourseWaypoint(
                position: CGPoint(x: 840, y: 12),
                curveToNext: .quadratic(control: CGPoint(x: 780, y: 22))
            ),
            CourseWaypoint(position: CGPoint(x: 960, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 220, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 130, y: 8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 440, y: 8),
                curveToNext: .quadratic(control: CGPoint(x: 350, y: 12))
            ),
            CourseWaypoint(
                position: CGPoint(x: 660, y: 14),
                curveToNext: .quadratic(control: CGPoint(x: 560, y: 95))
            ),
            CourseWaypoint(
                position: CGPoint(x: 880, y: 18),
                curveToNext: .quadratic(control: CGPoint(x: 780, y: 88))
            ),
            CourseWaypoint(
                position: CGPoint(x: 1100, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 1000, y: 10))
            ),
            CourseWaypoint(position: CGPoint(x: 1280, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 200, y: 2),
                curveToNext: .quadratic(control: CGPoint(x: 105, y: 5))
            ),
            CourseWaypoint(
                position: CGPoint(x: 400, y: -1),
                curveToNext: .line
            ),
            CourseWaypoint(
                position: CGPoint(x: 600, y: 1),
                curveToNext: .line
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: -2),
                curveToNext: .line,
                ropeWidth: 28
            ),
            CourseWaypoint(
                position: CGPoint(x: 1000, y: 0),
                curveToNext: .line,
                ropeWidth: 26
            ),
            CourseWaypoint(
                position: CGPoint(x: 1200, y: 1),
                curveToNext: .line
            ),
            CourseWaypoint(
                position: CGPoint(x: 1400, y: -1),
                curveToNext: .quadratic(control: CGPoint(x: 1320, y: 3))
            ),
            CourseWaypoint(position: CGPoint(x: 1520, y: 0)),
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
        ropeWidth: 48,
        forwardSpeed: 102,
        maxPitchRadians: .pi / 6
    )

    static let spiralDrift = makeCourse(
        id: "spiralDrift",
        displayName: "Spiral Drift",
        unlockOrder: 0,
        waypoints: [
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 150, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 105, y: 32))
            ),
            CourseWaypoint(
                position: CGPoint(x: 280, y: -4),
                curveToNext: .quadratic(control: CGPoint(x: 220, y: -28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 420, y: 8),
                curveToNext: .quadratic(control: CGPoint(x: 360, y: 35))
            ),
            CourseWaypoint(
                position: CGPoint(x: 560, y: -6),
                curveToNext: .quadratic(control: CGPoint(x: 500, y: -30))
            ),
            CourseWaypoint(
                position: CGPoint(x: 700, y: 5),
                curveToNext: .quadratic(control: CGPoint(x: 640, y: 28))
            ),
            CourseWaypoint(
                position: CGPoint(x: 840, y: -4),
                curveToNext: .quadratic(control: CGPoint(x: 780, y: -22))
            ),
            CourseWaypoint(position: CGPoint(x: 980, y: 0)),
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
            CourseWaypoint(position: CGPoint(x: 0, y: 0)),
            CourseWaypoint(
                position: CGPoint(x: 200, y: -8),
                curveToNext: .quadratic(control: CGPoint(x: 120, y: -5))
            ),
            CourseWaypoint(
                position: CGPoint(x: 400, y: 6),
                curveToNext: .quadratic(control: CGPoint(x: 320, y: 10))
            ),
            CourseWaypoint(
                position: CGPoint(x: 600, y: -5),
                curveToNext: .quadratic(control: CGPoint(x: 520, y: -8))
            ),
            CourseWaypoint(
                position: CGPoint(x: 800, y: 4),
                curveToNext: .quadratic(control: CGPoint(x: 720, y: 7))
            ),
            CourseWaypoint(position: CGPoint(x: 1000, y: 0)),
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
        let segmentCount = 12
        let segmentLength: CGFloat = 140
        for index in 1 ... segmentCount {
            let x = CGFloat(index) * segmentLength
            let wave = sin(Double(index) * 0.9) * 28
            let y = CGFloat(wave)
            let controlOffset = CGFloat(cos(Double(index) * 0.7) * 40)
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

    private static func makeCourse(
        id: String,
        displayName: String,
        unlockOrder: Int,
        waypoints: [CourseWaypoint],
        styleDefinitions: [StyleDefinition],
        ropeWidth: Double = 48,
        forwardSpeed: Double = 120,
        maxPitchRadians: Double = .pi / 4
    ) -> Course {
        let provisional = Course(
            id: id,
            displayName: displayName,
            waypoints: waypoints,
            styleSpans: [],
            ropeWidth: ropeWidth,
            forwardSpeed: forwardSpeed,
            maxPitchRadians: maxPitchRadians,
            unlockOrder: unlockOrder
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
            unlockOrder: unlockOrder
        )
    }
}
