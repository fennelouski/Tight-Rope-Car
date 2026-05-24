//
//  CourseMapCatalog.swift
//  Tight Rope Car
//

import CoreGraphics
import Foundation

// Map layout: canvas width follows container (min 340pt), height 10_000pt; row spacing 0.022 (≈87 px), three columns at x=0.18/0.50/0.82.
// Row y values: 0.020 + row_index × 0.022.
enum CourseMapCatalog {
    static let nodes: [CourseMapNode] = [
        // Row 0 — tutorial
        CourseMapNode(courseID: "tutorial",       mapPosition: CGPoint(x: 0.50, y: 0.012)),
        // Row 1
        CourseMapNode(courseID: "bumps",          mapPosition: CGPoint(x: 0.18, y: 0.025)),
        CourseMapNode(courseID: "narrowWire",     mapPosition: CGPoint(x: 0.82, y: 0.025)),
        // Row 2
        CourseMapNode(courseID: "switchbacks",    mapPosition: CGPoint(x: 0.18, y: 0.038)),
        CourseMapNode(courseID: "windAlley",      mapPosition: CGPoint(x: 0.50, y: 0.038)),
        CourseMapNode(courseID: "zigZag",         mapPosition: CGPoint(x: 0.82, y: 0.038)),
        // Row 3
        CourseMapNode(courseID: "longHaul",       mapPosition: CGPoint(x: 0.50, y: 0.052)),
        // Row 4
        CourseMapNode(courseID: "bigDrop",        mapPosition: CGPoint(x: 0.18, y: 0.065)),
        CourseMapNode(courseID: "sunsetCruise",   mapPosition: CGPoint(x: 0.82, y: 0.065)),
        // Row 5
        CourseMapNode(courseID: "summitClimb",   mapPosition: CGPoint(x: 0.18, y: 0.078)),
        CourseMapNode(courseID: "ropeBridge",    mapPosition: CGPoint(x: 0.50, y: 0.078)),
        CourseMapNode(courseID: "canyonGap",     mapPosition: CGPoint(x: 0.82, y: 0.078)),
        // Row 6
        CourseMapNode(courseID: "hairpins",      mapPosition: CGPoint(x: 0.18, y: 0.091)),
        CourseMapNode(courseID: "checkerboard",  mapPosition: CGPoint(x: 0.82, y: 0.091)),
        // Row 7
        CourseMapNode(courseID: "loopDeLoop",    mapPosition: CGPoint(x: 0.18, y: 0.104)),
        CourseMapNode(courseID: "tightropeWalk", mapPosition: CGPoint(x: 0.50, y: 0.104)),
        CourseMapNode(courseID: "spiralDrift",   mapPosition: CGPoint(x: 0.82, y: 0.104)),
        // Row 8
        CourseMapNode(courseID: "midnightRun",   mapPosition: CGPoint(x: 0.18, y: 0.118)),
        CourseMapNode(courseID: "rollerCoast",   mapPosition: CGPoint(x: 0.82, y: 0.118)),
        // Row 9
        CourseMapNode(courseID: "desertDash",    mapPosition: CGPoint(x: 0.18, y: 0.131)),
        CourseMapNode(courseID: "iceShelf",      mapPosition: CGPoint(x: 0.50, y: 0.131)),
        CourseMapNode(courseID: "pendulumSwing", mapPosition: CGPoint(x: 0.82, y: 0.131)),
        // Row 10
        CourseMapNode(courseID: "launchPad",     mapPosition: CGPoint(x: 0.18, y: 0.144)),
        CourseMapNode(courseID: "whisperCanyon", mapPosition: CGPoint(x: 0.82, y: 0.144)),
        // Row 11 — Batch 5 start
        CourseMapNode(courseID: "rainbowRoad",   mapPosition: CGPoint(x: 0.50, y: 0.157)),
        // Row 12
        CourseMapNode(courseID: "wobblyBridge",  mapPosition: CGPoint(x: 0.18, y: 0.170)),
        CourseMapNode(courseID: "sCurve",        mapPosition: CGPoint(x: 0.82, y: 0.170)),
        // Row 13
        CourseMapNode(courseID: "steepHill",     mapPosition: CGPoint(x: 0.18, y: 0.184)),
        CourseMapNode(courseID: "mountainPass",  mapPosition: CGPoint(x: 0.82, y: 0.184)),
        // Row 14 — Batch 6 (rows 14+ use 0.021 spacing)
        CourseMapNode(courseID: "gentleMeander", mapPosition: CGPoint(x: 0.18, y: 0.196)),
        CourseMapNode(courseID: "skyDance",      mapPosition: CGPoint(x: 0.50, y: 0.196)),
        CourseMapNode(courseID: "canyonDive",    mapPosition: CGPoint(x: 0.82, y: 0.196)),
        // Row 15
        CourseMapNode(courseID: "plateauRun",    mapPosition: CGPoint(x: 0.18, y: 0.209)),
        CourseMapNode(courseID: "lakesideLoop",  mapPosition: CGPoint(x: 0.82, y: 0.209)),
        // Row 16 — Batch 7
        CourseMapNode(courseID: "gravityDrop",   mapPosition: CGPoint(x: 0.18, y: 0.221)),
        CourseMapNode(courseID: "twinPeaks",     mapPosition: CGPoint(x: 0.50, y: 0.221)),
        CourseMapNode(courseID: "spiralGalaxy",  mapPosition: CGPoint(x: 0.82, y: 0.221)),
        // Row 17
        CourseMapNode(courseID: "staircase",     mapPosition: CGPoint(x: 0.18, y: 0.234)),
        CourseMapNode(courseID: "boomerang",     mapPosition: CGPoint(x: 0.82, y: 0.234)),
        // Row 18 — Batch 8
        CourseMapNode(courseID: "pogoBounce",    mapPosition: CGPoint(x: 0.18, y: 0.247)),
        CourseMapNode(courseID: "stormSurge",    mapPosition: CGPoint(x: 0.50, y: 0.247)),
        CourseMapNode(courseID: "monkeyBars",    mapPosition: CGPoint(x: 0.82, y: 0.247)),
        // Row 19
        CourseMapNode(courseID: "slipSlide",     mapPosition: CGPoint(x: 0.18, y: 0.259)),
        CourseMapNode(courseID: "speedBumps",    mapPosition: CGPoint(x: 0.82, y: 0.259)),
        // Row 20 — Batch 9
        CourseMapNode(courseID: "corkscrew",     mapPosition: CGPoint(x: 0.18, y: 0.272)),
        CourseMapNode(courseID: "highWire",      mapPosition: CGPoint(x: 0.50, y: 0.272)),
        CourseMapNode(courseID: "rippleRun",     mapPosition: CGPoint(x: 0.82, y: 0.272)),
        // Row 21
        CourseMapNode(courseID: "dragonBack",    mapPosition: CGPoint(x: 0.18, y: 0.284)),
        CourseMapNode(courseID: "spiralHill",    mapPosition: CGPoint(x: 0.82, y: 0.284)),
        // Row 22 — Batch 10
        CourseMapNode(courseID: "waveRunner",    mapPosition: CGPoint(x: 0.18, y: 0.297)),
        CourseMapNode(courseID: "cliffhanger",   mapPosition: CGPoint(x: 0.50, y: 0.297)),
        CourseMapNode(courseID: "zigzagCanyon",  mapPosition: CGPoint(x: 0.82, y: 0.297)),
        // Row 23
        CourseMapNode(courseID: "thrillRide",    mapPosition: CGPoint(x: 0.18, y: 0.310)),
        CourseMapNode(courseID: "breakaway",     mapPosition: CGPoint(x: 0.82, y: 0.310)),
        // Row 24 — Batch 11
        CourseMapNode(courseID: "avalanche",     mapPosition: CGPoint(x: 0.18, y: 0.322)),
        CourseMapNode(courseID: "thunderPass",   mapPosition: CGPoint(x: 0.50, y: 0.322)),
        CourseMapNode(courseID: "cannonball",    mapPosition: CGPoint(x: 0.82, y: 0.322)),
        // Row 25
        CourseMapNode(courseID: "whiplash",      mapPosition: CGPoint(x: 0.18, y: 0.335)),
        CourseMapNode(courseID: "moonrise",      mapPosition: CGPoint(x: 0.82, y: 0.335)),
        // Row 26 — Batch 12
        CourseMapNode(courseID: "rocketLaunch",  mapPosition: CGPoint(x: 0.18, y: 0.347)),
        CourseMapNode(courseID: "freeFall",      mapPosition: CGPoint(x: 0.50, y: 0.347)),
        CourseMapNode(courseID: "rollerStorm",   mapPosition: CGPoint(x: 0.82, y: 0.347)),
        // Row 27
        CourseMapNode(courseID: "tripleDecker",  mapPosition: CGPoint(x: 0.18, y: 0.360)),
        CourseMapNode(courseID: "galaxyExpress", mapPosition: CGPoint(x: 0.82, y: 0.360)),
        // Row 28 — Batch 13 (rows 28+ use 0.015 spacing on 6000-px canvas → ~89 px gap)
        CourseMapNode(courseID: "neonRush",      mapPosition: CGPoint(x: 0.18, y: 0.369)),
        CourseMapNode(courseID: "jungleSwing",   mapPosition: CGPoint(x: 0.50, y: 0.369)),
        CourseMapNode(courseID: "icePath",       mapPosition: CGPoint(x: 0.82, y: 0.369)),
        // Row 29
        CourseMapNode(courseID: "tornadoAlley",  mapPosition: CGPoint(x: 0.18, y: 0.378)),
        CourseMapNode(courseID: "stormChaser",   mapPosition: CGPoint(x: 0.82, y: 0.378)),
        // Row 30 — Batch 14
        CourseMapNode(courseID: "fireWalk",      mapPosition: CGPoint(x: 0.18, y: 0.387)),
        CourseMapNode(courseID: "crystalBridge", mapPosition: CGPoint(x: 0.50, y: 0.387)),
        CourseMapNode(courseID: "sandDunes",     mapPosition: CGPoint(x: 0.82, y: 0.387)),
        // Row 31
        CourseMapNode(courseID: "skyHook",       mapPosition: CGPoint(x: 0.18, y: 0.396)),
        CourseMapNode(courseID: "mudSlide",      mapPosition: CGPoint(x: 0.82, y: 0.396)),
        // Row 32 — Batch 15
        CourseMapNode(courseID: "volcanoPeak",   mapPosition: CGPoint(x: 0.18, y: 0.405)),
        CourseMapNode(courseID: "frozenLake",    mapPosition: CGPoint(x: 0.50, y: 0.405)),
        CourseMapNode(courseID: "desertCross",   mapPosition: CGPoint(x: 0.82, y: 0.405)),
        // Row 33
        CourseMapNode(courseID: "cloudSurfer",   mapPosition: CGPoint(x: 0.18, y: 0.414)),
        CourseMapNode(courseID: "tideRunner",    mapPosition: CGPoint(x: 0.82, y: 0.414)),
        // Row 34 — Batch 16
        CourseMapNode(courseID: "pinballRun",    mapPosition: CGPoint(x: 0.18, y: 0.423)),
        CourseMapNode(courseID: "bambooPath",    mapPosition: CGPoint(x: 0.50, y: 0.423)),
        CourseMapNode(courseID: "magmaFlow",     mapPosition: CGPoint(x: 0.82, y: 0.423)),
        // Row 35
        CourseMapNode(courseID: "arcticWind",    mapPosition: CGPoint(x: 0.18, y: 0.432)),
        CourseMapNode(courseID: "thunderBolt",   mapPosition: CGPoint(x: 0.82, y: 0.432)),
        // Row 36 — Batch 17
        CourseMapNode(courseID: "sunkenShip",    mapPosition: CGPoint(x: 0.18, y: 0.441)),
        CourseMapNode(courseID: "glassWalk",     mapPosition: CGPoint(x: 0.50, y: 0.441)),
        CourseMapNode(courseID: "dustDevil",     mapPosition: CGPoint(x: 0.82, y: 0.441)),
        // Row 37
        CourseMapNode(courseID: "rainForest",    mapPosition: CGPoint(x: 0.18, y: 0.450)),
        CourseMapNode(courseID: "stoneBridge",   mapPosition: CGPoint(x: 0.82, y: 0.450)),
        // Row 38 — Batch 18
        CourseMapNode(courseID: "spiderWeb",     mapPosition: CGPoint(x: 0.18, y: 0.459)),
        CourseMapNode(courseID: "moonWalk",      mapPosition: CGPoint(x: 0.50, y: 0.459)),
        CourseMapNode(courseID: "lavaRidge",     mapPosition: CGPoint(x: 0.82, y: 0.459)),
        // Row 39
        CourseMapNode(courseID: "frostBite",     mapPosition: CGPoint(x: 0.18, y: 0.468)),
        CourseMapNode(courseID: "canyonWind",    mapPosition: CGPoint(x: 0.82, y: 0.468)),
        // Row 40 — Batch 19
        CourseMapNode(courseID: "neonGrid",      mapPosition: CGPoint(x: 0.18, y: 0.477)),
        CourseMapNode(courseID: "peakDive",      mapPosition: CGPoint(x: 0.50, y: 0.477)),
        CourseMapNode(courseID: "coralReef",     mapPosition: CGPoint(x: 0.82, y: 0.477)),
        // Row 41
        CourseMapNode(courseID: "ironGate",      mapPosition: CGPoint(x: 0.18, y: 0.486)),
        CourseMapNode(courseID: "swingLow",      mapPosition: CGPoint(x: 0.82, y: 0.486)),
        // Row 42 — Batch 20
        CourseMapNode(courseID: "blazeTrail",    mapPosition: CGPoint(x: 0.18, y: 0.495)),
        CourseMapNode(courseID: "silverStream",  mapPosition: CGPoint(x: 0.50, y: 0.495)),
        CourseMapNode(courseID: "obsidianWay",   mapPosition: CGPoint(x: 0.82, y: 0.495)),
        // Row 43
        CourseMapNode(courseID: "prismPath",     mapPosition: CGPoint(x: 0.18, y: 0.504)),
        CourseMapNode(courseID: "wildWest",      mapPosition: CGPoint(x: 0.82, y: 0.504)),
        // Row 44 — Batch 21
        CourseMapNode(courseID: "phantomRoad",   mapPosition: CGPoint(x: 0.18, y: 0.513)),
        CourseMapNode(courseID: "reedSwamp",     mapPosition: CGPoint(x: 0.50, y: 0.513)),
        CourseMapNode(courseID: "crystalCave",   mapPosition: CGPoint(x: 0.82, y: 0.513)),
        // Row 45
        CourseMapNode(courseID: "jetStream",     mapPosition: CGPoint(x: 0.18, y: 0.522)),
        CourseMapNode(courseID: "emberPath",     mapPosition: CGPoint(x: 0.82, y: 0.522)),
        // Row 46 — Batch 22
        CourseMapNode(courseID: "shadowRun",     mapPosition: CGPoint(x: 0.18, y: 0.531)),
        CourseMapNode(courseID: "comet",         mapPosition: CGPoint(x: 0.50, y: 0.531)),
        CourseMapNode(courseID: "glacierGap",    mapPosition: CGPoint(x: 0.82, y: 0.531)),
        // Row 47
        CourseMapNode(courseID: "boulderPass",   mapPosition: CGPoint(x: 0.18, y: 0.540)),
        CourseMapNode(courseID: "typhoonTrack",  mapPosition: CGPoint(x: 0.82, y: 0.540)),
        // Row 48 — Batch 23
        CourseMapNode(courseID: "starfall",      mapPosition: CGPoint(x: 0.18, y: 0.549)),
        CourseMapNode(courseID: "mudBog",        mapPosition: CGPoint(x: 0.50, y: 0.549)),
        CourseMapNode(courseID: "diamondDust",   mapPosition: CGPoint(x: 0.82, y: 0.549)),
        // Row 49
        CourseMapNode(courseID: "infernoRun",    mapPosition: CGPoint(x: 0.18, y: 0.558)),
        CourseMapNode(courseID: "tundraGlide",   mapPosition: CGPoint(x: 0.82, y: 0.558)),
        // Row 50 — Batch 24
        CourseMapNode(courseID: "supernova",     mapPosition: CGPoint(x: 0.18, y: 0.567)),
        CourseMapNode(courseID: "ashField",      mapPosition: CGPoint(x: 0.50, y: 0.567)),
        CourseMapNode(courseID: "polarVortex",   mapPosition: CGPoint(x: 0.82, y: 0.567)),
        // Row 51
        CourseMapNode(courseID: "abyssWalk",     mapPosition: CGPoint(x: 0.18, y: 0.576)),
        CourseMapNode(courseID: "fierceWind",    mapPosition: CGPoint(x: 0.82, y: 0.576)),
        // Row 52 — Batch 25 (Final)
        CourseMapNode(courseID: "grandFinale",   mapPosition: CGPoint(x: 0.18, y: 0.585)),
        CourseMapNode(courseID: "eternityBridge",mapPosition: CGPoint(x: 0.82, y: 0.585)),
        // Row 53
        CourseMapNode(courseID: "legendsRun",    mapPosition: CGPoint(x: 0.18, y: 0.594)),
        CourseMapNode(courseID: "ultimateWire",  mapPosition: CGPoint(x: 0.82, y: 0.594)),
        // Row 54 — Batch 26
        CourseMapNode(courseID: "sunnyMeadow",   mapPosition: CGPoint(x: 0.18, y: 0.606)),
        CourseMapNode(courseID: "cloudWalk",     mapPosition: CGPoint(x: 0.50, y: 0.606)),
        CourseMapNode(courseID: "bubblePop",     mapPosition: CGPoint(x: 0.82, y: 0.606)),
        // Row 55
        CourseMapNode(courseID: "rainbowBridge", mapPosition: CGPoint(x: 0.18, y: 0.618)),
        CourseMapNode(courseID: "starLane",      mapPosition: CGPoint(x: 0.82, y: 0.618)),
        // Row 56 — Batch 27
        CourseMapNode(courseID: "pebblePath",    mapPosition: CGPoint(x: 0.18, y: 0.630)),
        CourseMapNode(courseID: "zipLine",       mapPosition: CGPoint(x: 0.50, y: 0.630)),
        CourseMapNode(courseID: "sandCastle",    mapPosition: CGPoint(x: 0.82, y: 0.630)),
        // Row 57
        CourseMapNode(courseID: "jellyRoad",     mapPosition: CGPoint(x: 0.18, y: 0.642)),
        CourseMapNode(courseID: "cactusPass",    mapPosition: CGPoint(x: 0.82, y: 0.642)),
        // Row 58 — Batch 28
        CourseMapNode(courseID: "mushroom",      mapPosition: CGPoint(x: 0.18, y: 0.654)),
        CourseMapNode(courseID: "tidePool",      mapPosition: CGPoint(x: 0.50, y: 0.654)),
        CourseMapNode(courseID: "snowDrift",     mapPosition: CGPoint(x: 0.82, y: 0.654)),
        // Row 59
        CourseMapNode(courseID: "cloverField",   mapPosition: CGPoint(x: 0.18, y: 0.666)),
        CourseMapNode(courseID: "marbleRun",     mapPosition: CGPoint(x: 0.82, y: 0.666)),
        // Row 60 — Batch 29
        CourseMapNode(courseID: "candyCane",     mapPosition: CGPoint(x: 0.18, y: 0.678)),
        CourseMapNode(courseID: "forestLog",     mapPosition: CGPoint(x: 0.50, y: 0.678)),
        CourseMapNode(courseID: "iceRink",       mapPosition: CGPoint(x: 0.82, y: 0.678)),
        // Row 61
        CourseMapNode(courseID: "lemonDrop",     mapPosition: CGPoint(x: 0.18, y: 0.690)),
        CourseMapNode(courseID: "skySlide",      mapPosition: CGPoint(x: 0.82, y: 0.690)),
        // Row 62 — Batch 30
        CourseMapNode(courseID: "rocketRide",    mapPosition: CGPoint(x: 0.18, y: 0.702)),
        CourseMapNode(courseID: "butterflyPath", mapPosition: CGPoint(x: 0.50, y: 0.702)),
        CourseMapNode(courseID: "lavaLamp",      mapPosition: CGPoint(x: 0.82, y: 0.702)),
        // Row 63
        CourseMapNode(courseID: "tunnelRush",    mapPosition: CGPoint(x: 0.18, y: 0.714)),
        CourseMapNode(courseID: "penguin",       mapPosition: CGPoint(x: 0.82, y: 0.714)),
        // Row 64 — Batch 31
        CourseMapNode(courseID: "beanBounce",    mapPosition: CGPoint(x: 0.18, y: 0.726)),
        CourseMapNode(courseID: "moonRiver",     mapPosition: CGPoint(x: 0.50, y: 0.726)),
        CourseMapNode(courseID: "volcanoDash",   mapPosition: CGPoint(x: 0.82, y: 0.726)),
        // Row 65
        CourseMapNode(courseID: "kiteRun",       mapPosition: CGPoint(x: 0.18, y: 0.738)),
        CourseMapNode(courseID: "glowWorm",      mapPosition: CGPoint(x: 0.82, y: 0.738)),
        // Row 66 — Batch 32
        CourseMapNode(courseID: "cocoaRun",      mapPosition: CGPoint(x: 0.18, y: 0.750)),
        CourseMapNode(courseID: "swampHop",      mapPosition: CGPoint(x: 0.50, y: 0.750)),
        CourseMapNode(courseID: "crystalStream", mapPosition: CGPoint(x: 0.82, y: 0.750)),
        // Row 67
        CourseMapNode(courseID: "hauntedPath",   mapPosition: CGPoint(x: 0.18, y: 0.762)),
        CourseMapNode(courseID: "sugarRush",     mapPosition: CGPoint(x: 0.82, y: 0.762)),
        // Row 68 — Batch 33
        CourseMapNode(courseID: "foggyMoor",     mapPosition: CGPoint(x: 0.18, y: 0.774)),
        CourseMapNode(courseID: "pinwheelPark",  mapPosition: CGPoint(x: 0.50, y: 0.774)),
        CourseMapNode(courseID: "archipelago",   mapPosition: CGPoint(x: 0.82, y: 0.774)),
        // Row 69
        CourseMapNode(courseID: "springCoil",    mapPosition: CGPoint(x: 0.18, y: 0.786)),
        CourseMapNode(courseID: "auroraBend",    mapPosition: CGPoint(x: 0.82, y: 0.786)),
        // Row 70 — Batch 34
        CourseMapNode(courseID: "tumbleweed",    mapPosition: CGPoint(x: 0.18, y: 0.798)),
        CourseMapNode(courseID: "prairieWind",   mapPosition: CGPoint(x: 0.50, y: 0.798)),
        CourseMapNode(courseID: "cobblestone",   mapPosition: CGPoint(x: 0.82, y: 0.798)),
        // Row 71
        CourseMapNode(courseID: "fireFly",       mapPosition: CGPoint(x: 0.18, y: 0.810)),
        CourseMapNode(courseID: "deepSea",       mapPosition: CGPoint(x: 0.82, y: 0.810)),
        // Row 72 — Batch 35
        CourseMapNode(courseID: "gemMine",       mapPosition: CGPoint(x: 0.18, y: 0.822)),
        CourseMapNode(courseID: "torchRace",     mapPosition: CGPoint(x: 0.50, y: 0.822)),
        CourseMapNode(courseID: "mountainGoat",  mapPosition: CGPoint(x: 0.82, y: 0.822)),
        // Row 73
        CourseMapNode(courseID: "oceanBreeze",   mapPosition: CGPoint(x: 0.18, y: 0.834)),
        CourseMapNode(courseID: "sparkTrail",    mapPosition: CGPoint(x: 0.82, y: 0.834)),
        // Row 74 — Batch 36
        CourseMapNode(courseID: "thunderCloud",  mapPosition: CGPoint(x: 0.18, y: 0.846)),
        CourseMapNode(courseID: "goldenGate",    mapPosition: CGPoint(x: 0.50, y: 0.846)),
        CourseMapNode(courseID: "boulderField",  mapPosition: CGPoint(x: 0.82, y: 0.846)),
        // Row 75
        CourseMapNode(courseID: "velvetRoad",    mapPosition: CGPoint(x: 0.18, y: 0.858)),
        CourseMapNode(courseID: "magneticPole",  mapPosition: CGPoint(x: 0.82, y: 0.858)),
        // Row 76 — Batch 37
        CourseMapNode(courseID: "pixelPath",     mapPosition: CGPoint(x: 0.18, y: 0.870)),
        CourseMapNode(courseID: "noodleRoad",    mapPosition: CGPoint(x: 0.50, y: 0.870)),
        CourseMapNode(courseID: "highTide",      mapPosition: CGPoint(x: 0.82, y: 0.870)),
        // Row 77
        CourseMapNode(courseID: "solarWind",     mapPosition: CGPoint(x: 0.18, y: 0.882)),
        CourseMapNode(courseID: "ironBridge",    mapPosition: CGPoint(x: 0.82, y: 0.882)),
        // Row 78 — Batch 38
        CourseMapNode(courseID: "crystalMaze",   mapPosition: CGPoint(x: 0.18, y: 0.894)),
        CourseMapNode(courseID: "cosmicDrift",   mapPosition: CGPoint(x: 0.50, y: 0.894)),
        CourseMapNode(courseID: "vortexRoad",    mapPosition: CGPoint(x: 0.82, y: 0.894)),
        // Row 79
        CourseMapNode(courseID: "horizonPath",   mapPosition: CGPoint(x: 0.18, y: 0.906)),
        CourseMapNode(courseID: "stormBolt",     mapPosition: CGPoint(x: 0.82, y: 0.906)),
        // Row 80 — Batch 39
        CourseMapNode(courseID: "lightningRun",  mapPosition: CGPoint(x: 0.18, y: 0.918)),
        CourseMapNode(courseID: "silkRoad",      mapPosition: CGPoint(x: 0.50, y: 0.918)),
        CourseMapNode(courseID: "frostWave",     mapPosition: CGPoint(x: 0.82, y: 0.918)),
        // Row 81
        CourseMapNode(courseID: "dawnRider",     mapPosition: CGPoint(x: 0.18, y: 0.930)),
        CourseMapNode(courseID: "emberGlow",     mapPosition: CGPoint(x: 0.82, y: 0.930)),
        // Row 82 — Batch 40 (final)
        CourseMapNode(courseID: "grandVista",    mapPosition: CGPoint(x: 0.18, y: 0.942)),
        CourseMapNode(courseID: "apexRun",       mapPosition: CGPoint(x: 0.82, y: 0.942)),
    ]

    static let edges: [CourseMapEdge] = [
        // World 1 — The Beginning
        CourseMapEdge(fromCourseID: "tutorial",      toCourseID: "bumps"),
        CourseMapEdge(fromCourseID: "tutorial",      toCourseID: "narrowWire"),
        CourseMapEdge(fromCourseID: "bumps",         toCourseID: "switchbacks"),
        CourseMapEdge(fromCourseID: "narrowWire",    toCourseID: "windAlley"),
        CourseMapEdge(fromCourseID: "narrowWire",    toCourseID: "zigZag"),
        CourseMapEdge(fromCourseID: "switchbacks",   toCourseID: "longHaul"),
        CourseMapEdge(fromCourseID: "windAlley",     toCourseID: "longHaul"),
        CourseMapEdge(fromCourseID: "zigZag",        toCourseID: "longHaul"),

        // World 2 — Getting Harder
        CourseMapEdge(fromCourseID: "longHaul",      toCourseID: "bigDrop"),
        CourseMapEdge(fromCourseID: "longHaul",      toCourseID: "sunsetCruise"),
        CourseMapEdge(fromCourseID: "bigDrop",       toCourseID: "summitClimb"),
        CourseMapEdge(fromCourseID: "bigDrop",       toCourseID: "ropeBridge"),
        CourseMapEdge(fromCourseID: "sunsetCruise",  toCourseID: "ropeBridge"),
        CourseMapEdge(fromCourseID: "sunsetCruise",  toCourseID: "canyonGap"),
        CourseMapEdge(fromCourseID: "summitClimb",   toCourseID: "hairpins"),
        CourseMapEdge(fromCourseID: "ropeBridge",    toCourseID: "tightropeWalk"),
        CourseMapEdge(fromCourseID: "canyonGap",     toCourseID: "checkerboard"),

        // World 3 — Advanced
        CourseMapEdge(fromCourseID: "hairpins",      toCourseID: "loopDeLoop"),
        CourseMapEdge(fromCourseID: "tightropeWalk", toCourseID: "spiralDrift"),
        CourseMapEdge(fromCourseID: "checkerboard",  toCourseID: "spiralDrift"),
        CourseMapEdge(fromCourseID: "loopDeLoop",    toCourseID: "midnightRun"),
        CourseMapEdge(fromCourseID: "spiralDrift",   toCourseID: "rollerCoast"),
        CourseMapEdge(fromCourseID: "midnightRun",   toCourseID: "desertDash"),
        CourseMapEdge(fromCourseID: "rollerCoast",   toCourseID: "iceShelf"),

        // World 4 — Expert
        CourseMapEdge(fromCourseID: "desertDash",    toCourseID: "pendulumSwing"),
        CourseMapEdge(fromCourseID: "iceShelf",      toCourseID: "pendulumSwing"),
        CourseMapEdge(fromCourseID: "pendulumSwing", toCourseID: "launchPad"),
        CourseMapEdge(fromCourseID: "pendulumSwing", toCourseID: "whisperCanyon"),

        // Batch 5 — New courses
        CourseMapEdge(fromCourseID: "launchPad",     toCourseID: "rainbowRoad"),
        CourseMapEdge(fromCourseID: "whisperCanyon", toCourseID: "rainbowRoad"),
        CourseMapEdge(fromCourseID: "rainbowRoad",   toCourseID: "wobblyBridge"),
        CourseMapEdge(fromCourseID: "rainbowRoad",   toCourseID: "sCurve"),
        CourseMapEdge(fromCourseID: "wobblyBridge",  toCourseID: "steepHill"),
        CourseMapEdge(fromCourseID: "sCurve",        toCourseID: "mountainPass"),

        // Batch 6
        CourseMapEdge(fromCourseID: "steepHill",     toCourseID: "gentleMeander"),
        CourseMapEdge(fromCourseID: "steepHill",     toCourseID: "skyDance"),
        CourseMapEdge(fromCourseID: "mountainPass",  toCourseID: "skyDance"),
        CourseMapEdge(fromCourseID: "mountainPass",  toCourseID: "canyonDive"),
        CourseMapEdge(fromCourseID: "gentleMeander", toCourseID: "plateauRun"),
        CourseMapEdge(fromCourseID: "skyDance",      toCourseID: "plateauRun"),
        CourseMapEdge(fromCourseID: "canyonDive",    toCourseID: "lakesideLoop"),

        // Batch 7
        CourseMapEdge(fromCourseID: "plateauRun",    toCourseID: "gravityDrop"),
        CourseMapEdge(fromCourseID: "plateauRun",    toCourseID: "twinPeaks"),
        CourseMapEdge(fromCourseID: "lakesideLoop",  toCourseID: "twinPeaks"),
        CourseMapEdge(fromCourseID: "lakesideLoop",  toCourseID: "spiralGalaxy"),
        CourseMapEdge(fromCourseID: "gravityDrop",   toCourseID: "staircase"),
        CourseMapEdge(fromCourseID: "twinPeaks",     toCourseID: "staircase"),
        CourseMapEdge(fromCourseID: "spiralGalaxy",  toCourseID: "boomerang"),

        // Batch 8
        CourseMapEdge(fromCourseID: "staircase",     toCourseID: "pogoBounce"),
        CourseMapEdge(fromCourseID: "staircase",     toCourseID: "stormSurge"),
        CourseMapEdge(fromCourseID: "boomerang",     toCourseID: "stormSurge"),
        CourseMapEdge(fromCourseID: "boomerang",     toCourseID: "monkeyBars"),
        CourseMapEdge(fromCourseID: "pogoBounce",    toCourseID: "slipSlide"),
        CourseMapEdge(fromCourseID: "stormSurge",    toCourseID: "slipSlide"),
        CourseMapEdge(fromCourseID: "monkeyBars",    toCourseID: "speedBumps"),

        // Batch 9
        CourseMapEdge(fromCourseID: "slipSlide",     toCourseID: "corkscrew"),
        CourseMapEdge(fromCourseID: "slipSlide",     toCourseID: "highWire"),
        CourseMapEdge(fromCourseID: "speedBumps",    toCourseID: "highWire"),
        CourseMapEdge(fromCourseID: "speedBumps",    toCourseID: "rippleRun"),
        CourseMapEdge(fromCourseID: "corkscrew",     toCourseID: "dragonBack"),
        CourseMapEdge(fromCourseID: "highWire",      toCourseID: "dragonBack"),
        CourseMapEdge(fromCourseID: "rippleRun",     toCourseID: "spiralHill"),

        // Batch 10
        CourseMapEdge(fromCourseID: "dragonBack",    toCourseID: "waveRunner"),
        CourseMapEdge(fromCourseID: "dragonBack",    toCourseID: "cliffhanger"),
        CourseMapEdge(fromCourseID: "spiralHill",    toCourseID: "cliffhanger"),
        CourseMapEdge(fromCourseID: "spiralHill",    toCourseID: "zigzagCanyon"),
        CourseMapEdge(fromCourseID: "waveRunner",    toCourseID: "thrillRide"),
        CourseMapEdge(fromCourseID: "cliffhanger",   toCourseID: "thrillRide"),
        CourseMapEdge(fromCourseID: "zigzagCanyon",  toCourseID: "breakaway"),

        // Batch 11
        CourseMapEdge(fromCourseID: "thrillRide",    toCourseID: "avalanche"),
        CourseMapEdge(fromCourseID: "thrillRide",    toCourseID: "thunderPass"),
        CourseMapEdge(fromCourseID: "breakaway",     toCourseID: "thunderPass"),
        CourseMapEdge(fromCourseID: "breakaway",     toCourseID: "cannonball"),
        CourseMapEdge(fromCourseID: "avalanche",     toCourseID: "whiplash"),
        CourseMapEdge(fromCourseID: "thunderPass",   toCourseID: "whiplash"),
        CourseMapEdge(fromCourseID: "cannonball",    toCourseID: "moonrise"),

        // Batch 12
        CourseMapEdge(fromCourseID: "whiplash",      toCourseID: "rocketLaunch"),
        CourseMapEdge(fromCourseID: "whiplash",      toCourseID: "freeFall"),
        CourseMapEdge(fromCourseID: "moonrise",      toCourseID: "freeFall"),
        CourseMapEdge(fromCourseID: "moonrise",      toCourseID: "rollerStorm"),
        CourseMapEdge(fromCourseID: "rocketLaunch",  toCourseID: "tripleDecker"),
        CourseMapEdge(fromCourseID: "freeFall",      toCourseID: "tripleDecker"),
        CourseMapEdge(fromCourseID: "rollerStorm",   toCourseID: "galaxyExpress"),

        // Batch 13
        CourseMapEdge(fromCourseID: "tripleDecker",  toCourseID: "neonRush"),
        CourseMapEdge(fromCourseID: "tripleDecker",  toCourseID: "jungleSwing"),
        CourseMapEdge(fromCourseID: "galaxyExpress", toCourseID: "jungleSwing"),
        CourseMapEdge(fromCourseID: "galaxyExpress", toCourseID: "icePath"),
        CourseMapEdge(fromCourseID: "neonRush",      toCourseID: "tornadoAlley"),
        CourseMapEdge(fromCourseID: "jungleSwing",   toCourseID: "tornadoAlley"),
        CourseMapEdge(fromCourseID: "icePath",       toCourseID: "stormChaser"),

        // Batch 14
        CourseMapEdge(fromCourseID: "tornadoAlley",  toCourseID: "fireWalk"),
        CourseMapEdge(fromCourseID: "tornadoAlley",  toCourseID: "crystalBridge"),
        CourseMapEdge(fromCourseID: "stormChaser",   toCourseID: "crystalBridge"),
        CourseMapEdge(fromCourseID: "stormChaser",   toCourseID: "sandDunes"),
        CourseMapEdge(fromCourseID: "fireWalk",      toCourseID: "skyHook"),
        CourseMapEdge(fromCourseID: "crystalBridge", toCourseID: "skyHook"),
        CourseMapEdge(fromCourseID: "sandDunes",     toCourseID: "mudSlide"),

        // Batch 15
        CourseMapEdge(fromCourseID: "skyHook",       toCourseID: "volcanoPeak"),
        CourseMapEdge(fromCourseID: "skyHook",       toCourseID: "frozenLake"),
        CourseMapEdge(fromCourseID: "mudSlide",      toCourseID: "frozenLake"),
        CourseMapEdge(fromCourseID: "mudSlide",      toCourseID: "desertCross"),
        CourseMapEdge(fromCourseID: "volcanoPeak",   toCourseID: "cloudSurfer"),
        CourseMapEdge(fromCourseID: "frozenLake",    toCourseID: "cloudSurfer"),
        CourseMapEdge(fromCourseID: "desertCross",   toCourseID: "tideRunner"),

        // Batch 16
        CourseMapEdge(fromCourseID: "cloudSurfer",   toCourseID: "pinballRun"),
        CourseMapEdge(fromCourseID: "cloudSurfer",   toCourseID: "bambooPath"),
        CourseMapEdge(fromCourseID: "tideRunner",    toCourseID: "bambooPath"),
        CourseMapEdge(fromCourseID: "tideRunner",    toCourseID: "magmaFlow"),
        CourseMapEdge(fromCourseID: "pinballRun",    toCourseID: "arcticWind"),
        CourseMapEdge(fromCourseID: "bambooPath",    toCourseID: "arcticWind"),
        CourseMapEdge(fromCourseID: "magmaFlow",     toCourseID: "thunderBolt"),

        // Batch 17
        CourseMapEdge(fromCourseID: "arcticWind",    toCourseID: "sunkenShip"),
        CourseMapEdge(fromCourseID: "arcticWind",    toCourseID: "glassWalk"),
        CourseMapEdge(fromCourseID: "thunderBolt",   toCourseID: "glassWalk"),
        CourseMapEdge(fromCourseID: "thunderBolt",   toCourseID: "dustDevil"),
        CourseMapEdge(fromCourseID: "sunkenShip",    toCourseID: "rainForest"),
        CourseMapEdge(fromCourseID: "glassWalk",     toCourseID: "rainForest"),
        CourseMapEdge(fromCourseID: "dustDevil",     toCourseID: "stoneBridge"),

        // Batch 18
        CourseMapEdge(fromCourseID: "rainForest",    toCourseID: "spiderWeb"),
        CourseMapEdge(fromCourseID: "rainForest",    toCourseID: "moonWalk"),
        CourseMapEdge(fromCourseID: "stoneBridge",   toCourseID: "moonWalk"),
        CourseMapEdge(fromCourseID: "stoneBridge",   toCourseID: "lavaRidge"),
        CourseMapEdge(fromCourseID: "spiderWeb",     toCourseID: "frostBite"),
        CourseMapEdge(fromCourseID: "moonWalk",      toCourseID: "frostBite"),
        CourseMapEdge(fromCourseID: "lavaRidge",     toCourseID: "canyonWind"),

        // Batch 19
        CourseMapEdge(fromCourseID: "frostBite",     toCourseID: "neonGrid"),
        CourseMapEdge(fromCourseID: "frostBite",     toCourseID: "peakDive"),
        CourseMapEdge(fromCourseID: "canyonWind",    toCourseID: "peakDive"),
        CourseMapEdge(fromCourseID: "canyonWind",    toCourseID: "coralReef"),
        CourseMapEdge(fromCourseID: "neonGrid",      toCourseID: "ironGate"),
        CourseMapEdge(fromCourseID: "peakDive",      toCourseID: "ironGate"),
        CourseMapEdge(fromCourseID: "coralReef",     toCourseID: "swingLow"),

        // Batch 20
        CourseMapEdge(fromCourseID: "ironGate",      toCourseID: "blazeTrail"),
        CourseMapEdge(fromCourseID: "ironGate",      toCourseID: "silverStream"),
        CourseMapEdge(fromCourseID: "swingLow",      toCourseID: "silverStream"),
        CourseMapEdge(fromCourseID: "swingLow",      toCourseID: "obsidianWay"),
        CourseMapEdge(fromCourseID: "blazeTrail",    toCourseID: "prismPath"),
        CourseMapEdge(fromCourseID: "silverStream",  toCourseID: "prismPath"),
        CourseMapEdge(fromCourseID: "obsidianWay",   toCourseID: "wildWest"),

        // Batch 21
        CourseMapEdge(fromCourseID: "prismPath",     toCourseID: "phantomRoad"),
        CourseMapEdge(fromCourseID: "prismPath",     toCourseID: "reedSwamp"),
        CourseMapEdge(fromCourseID: "wildWest",      toCourseID: "reedSwamp"),
        CourseMapEdge(fromCourseID: "wildWest",      toCourseID: "crystalCave"),
        CourseMapEdge(fromCourseID: "phantomRoad",   toCourseID: "jetStream"),
        CourseMapEdge(fromCourseID: "reedSwamp",     toCourseID: "jetStream"),
        CourseMapEdge(fromCourseID: "crystalCave",   toCourseID: "emberPath"),

        // Batch 22
        CourseMapEdge(fromCourseID: "jetStream",     toCourseID: "shadowRun"),
        CourseMapEdge(fromCourseID: "jetStream",     toCourseID: "comet"),
        CourseMapEdge(fromCourseID: "emberPath",     toCourseID: "comet"),
        CourseMapEdge(fromCourseID: "emberPath",     toCourseID: "glacierGap"),
        CourseMapEdge(fromCourseID: "shadowRun",     toCourseID: "boulderPass"),
        CourseMapEdge(fromCourseID: "comet",         toCourseID: "boulderPass"),
        CourseMapEdge(fromCourseID: "glacierGap",    toCourseID: "typhoonTrack"),

        // Batch 23
        CourseMapEdge(fromCourseID: "boulderPass",   toCourseID: "starfall"),
        CourseMapEdge(fromCourseID: "boulderPass",   toCourseID: "mudBog"),
        CourseMapEdge(fromCourseID: "typhoonTrack",  toCourseID: "mudBog"),
        CourseMapEdge(fromCourseID: "typhoonTrack",  toCourseID: "diamondDust"),
        CourseMapEdge(fromCourseID: "starfall",      toCourseID: "infernoRun"),
        CourseMapEdge(fromCourseID: "mudBog",        toCourseID: "infernoRun"),
        CourseMapEdge(fromCourseID: "diamondDust",   toCourseID: "tundraGlide"),

        // Batch 24
        CourseMapEdge(fromCourseID: "infernoRun",    toCourseID: "supernova"),
        CourseMapEdge(fromCourseID: "infernoRun",    toCourseID: "ashField"),
        CourseMapEdge(fromCourseID: "tundraGlide",   toCourseID: "ashField"),
        CourseMapEdge(fromCourseID: "tundraGlide",   toCourseID: "polarVortex"),
        CourseMapEdge(fromCourseID: "supernova",     toCourseID: "abyssWalk"),
        CourseMapEdge(fromCourseID: "ashField",      toCourseID: "abyssWalk"),
        CourseMapEdge(fromCourseID: "polarVortex",   toCourseID: "fierceWind"),

        // Batch 25 — Final
        CourseMapEdge(fromCourseID: "abyssWalk",     toCourseID: "grandFinale"),
        CourseMapEdge(fromCourseID: "fierceWind",    toCourseID: "eternityBridge"),
        CourseMapEdge(fromCourseID: "grandFinale",   toCourseID: "legendsRun"),
        CourseMapEdge(fromCourseID: "eternityBridge",toCourseID: "ultimateWire"),

        // Batch 26
        CourseMapEdge(fromCourseID: "legendsRun",    toCourseID: "sunnyMeadow"),
        CourseMapEdge(fromCourseID: "legendsRun",    toCourseID: "cloudWalk"),
        CourseMapEdge(fromCourseID: "ultimateWire",  toCourseID: "cloudWalk"),
        CourseMapEdge(fromCourseID: "ultimateWire",  toCourseID: "bubblePop"),
        CourseMapEdge(fromCourseID: "sunnyMeadow",   toCourseID: "rainbowBridge"),
        CourseMapEdge(fromCourseID: "cloudWalk",     toCourseID: "rainbowBridge"),
        CourseMapEdge(fromCourseID: "bubblePop",     toCourseID: "starLane"),

        // Batch 27
        CourseMapEdge(fromCourseID: "rainbowBridge", toCourseID: "pebblePath"),
        CourseMapEdge(fromCourseID: "rainbowBridge", toCourseID: "zipLine"),
        CourseMapEdge(fromCourseID: "starLane",      toCourseID: "zipLine"),
        CourseMapEdge(fromCourseID: "starLane",      toCourseID: "sandCastle"),
        CourseMapEdge(fromCourseID: "pebblePath",    toCourseID: "jellyRoad"),
        CourseMapEdge(fromCourseID: "zipLine",       toCourseID: "jellyRoad"),
        CourseMapEdge(fromCourseID: "sandCastle",    toCourseID: "cactusPass"),

        // Batch 28
        CourseMapEdge(fromCourseID: "jellyRoad",     toCourseID: "mushroom"),
        CourseMapEdge(fromCourseID: "jellyRoad",     toCourseID: "tidePool"),
        CourseMapEdge(fromCourseID: "cactusPass",    toCourseID: "tidePool"),
        CourseMapEdge(fromCourseID: "cactusPass",    toCourseID: "snowDrift"),
        CourseMapEdge(fromCourseID: "mushroom",      toCourseID: "cloverField"),
        CourseMapEdge(fromCourseID: "tidePool",      toCourseID: "cloverField"),
        CourseMapEdge(fromCourseID: "snowDrift",     toCourseID: "marbleRun"),

        // Batch 29
        CourseMapEdge(fromCourseID: "cloverField",   toCourseID: "candyCane"),
        CourseMapEdge(fromCourseID: "cloverField",   toCourseID: "forestLog"),
        CourseMapEdge(fromCourseID: "marbleRun",     toCourseID: "forestLog"),
        CourseMapEdge(fromCourseID: "marbleRun",     toCourseID: "iceRink"),
        CourseMapEdge(fromCourseID: "candyCane",     toCourseID: "lemonDrop"),
        CourseMapEdge(fromCourseID: "forestLog",     toCourseID: "lemonDrop"),
        CourseMapEdge(fromCourseID: "iceRink",       toCourseID: "skySlide"),

        // Batch 30
        CourseMapEdge(fromCourseID: "lemonDrop",     toCourseID: "rocketRide"),
        CourseMapEdge(fromCourseID: "lemonDrop",     toCourseID: "butterflyPath"),
        CourseMapEdge(fromCourseID: "skySlide",      toCourseID: "butterflyPath"),
        CourseMapEdge(fromCourseID: "skySlide",      toCourseID: "lavaLamp"),
        CourseMapEdge(fromCourseID: "rocketRide",    toCourseID: "tunnelRush"),
        CourseMapEdge(fromCourseID: "butterflyPath", toCourseID: "tunnelRush"),
        CourseMapEdge(fromCourseID: "lavaLamp",      toCourseID: "penguin"),

        // Batch 31
        CourseMapEdge(fromCourseID: "tunnelRush",    toCourseID: "beanBounce"),
        CourseMapEdge(fromCourseID: "tunnelRush",    toCourseID: "moonRiver"),
        CourseMapEdge(fromCourseID: "penguin",       toCourseID: "moonRiver"),
        CourseMapEdge(fromCourseID: "penguin",       toCourseID: "volcanoDash"),
        CourseMapEdge(fromCourseID: "beanBounce",    toCourseID: "kiteRun"),
        CourseMapEdge(fromCourseID: "moonRiver",     toCourseID: "kiteRun"),
        CourseMapEdge(fromCourseID: "volcanoDash",   toCourseID: "glowWorm"),

        // Batch 32
        CourseMapEdge(fromCourseID: "kiteRun",       toCourseID: "cocoaRun"),
        CourseMapEdge(fromCourseID: "kiteRun",       toCourseID: "swampHop"),
        CourseMapEdge(fromCourseID: "glowWorm",      toCourseID: "swampHop"),
        CourseMapEdge(fromCourseID: "glowWorm",      toCourseID: "crystalStream"),
        CourseMapEdge(fromCourseID: "cocoaRun",      toCourseID: "hauntedPath"),
        CourseMapEdge(fromCourseID: "swampHop",      toCourseID: "hauntedPath"),
        CourseMapEdge(fromCourseID: "crystalStream", toCourseID: "sugarRush"),

        // Batch 33
        CourseMapEdge(fromCourseID: "hauntedPath",   toCourseID: "foggyMoor"),
        CourseMapEdge(fromCourseID: "hauntedPath",   toCourseID: "pinwheelPark"),
        CourseMapEdge(fromCourseID: "sugarRush",     toCourseID: "pinwheelPark"),
        CourseMapEdge(fromCourseID: "sugarRush",     toCourseID: "archipelago"),
        CourseMapEdge(fromCourseID: "foggyMoor",     toCourseID: "springCoil"),
        CourseMapEdge(fromCourseID: "pinwheelPark",  toCourseID: "springCoil"),
        CourseMapEdge(fromCourseID: "archipelago",   toCourseID: "auroraBend"),

        // Batch 34
        CourseMapEdge(fromCourseID: "springCoil",    toCourseID: "tumbleweed"),
        CourseMapEdge(fromCourseID: "springCoil",    toCourseID: "prairieWind"),
        CourseMapEdge(fromCourseID: "auroraBend",    toCourseID: "prairieWind"),
        CourseMapEdge(fromCourseID: "auroraBend",    toCourseID: "cobblestone"),
        CourseMapEdge(fromCourseID: "tumbleweed",    toCourseID: "fireFly"),
        CourseMapEdge(fromCourseID: "prairieWind",   toCourseID: "fireFly"),
        CourseMapEdge(fromCourseID: "cobblestone",   toCourseID: "deepSea"),

        // Batch 35
        CourseMapEdge(fromCourseID: "fireFly",       toCourseID: "gemMine"),
        CourseMapEdge(fromCourseID: "fireFly",       toCourseID: "torchRace"),
        CourseMapEdge(fromCourseID: "deepSea",       toCourseID: "torchRace"),
        CourseMapEdge(fromCourseID: "deepSea",       toCourseID: "mountainGoat"),
        CourseMapEdge(fromCourseID: "gemMine",       toCourseID: "oceanBreeze"),
        CourseMapEdge(fromCourseID: "torchRace",     toCourseID: "oceanBreeze"),
        CourseMapEdge(fromCourseID: "mountainGoat",  toCourseID: "sparkTrail"),

        // Batch 36
        CourseMapEdge(fromCourseID: "oceanBreeze",   toCourseID: "thunderCloud"),
        CourseMapEdge(fromCourseID: "oceanBreeze",   toCourseID: "goldenGate"),
        CourseMapEdge(fromCourseID: "sparkTrail",    toCourseID: "goldenGate"),
        CourseMapEdge(fromCourseID: "sparkTrail",    toCourseID: "boulderField"),
        CourseMapEdge(fromCourseID: "thunderCloud",  toCourseID: "velvetRoad"),
        CourseMapEdge(fromCourseID: "goldenGate",    toCourseID: "velvetRoad"),
        CourseMapEdge(fromCourseID: "boulderField",  toCourseID: "magneticPole"),

        // Batch 37
        CourseMapEdge(fromCourseID: "velvetRoad",    toCourseID: "pixelPath"),
        CourseMapEdge(fromCourseID: "velvetRoad",    toCourseID: "noodleRoad"),
        CourseMapEdge(fromCourseID: "magneticPole",  toCourseID: "noodleRoad"),
        CourseMapEdge(fromCourseID: "magneticPole",  toCourseID: "highTide"),
        CourseMapEdge(fromCourseID: "pixelPath",     toCourseID: "solarWind"),
        CourseMapEdge(fromCourseID: "noodleRoad",    toCourseID: "solarWind"),
        CourseMapEdge(fromCourseID: "highTide",      toCourseID: "ironBridge"),

        // Batch 38
        CourseMapEdge(fromCourseID: "solarWind",     toCourseID: "crystalMaze"),
        CourseMapEdge(fromCourseID: "solarWind",     toCourseID: "cosmicDrift"),
        CourseMapEdge(fromCourseID: "ironBridge",    toCourseID: "cosmicDrift"),
        CourseMapEdge(fromCourseID: "ironBridge",    toCourseID: "vortexRoad"),
        CourseMapEdge(fromCourseID: "crystalMaze",   toCourseID: "horizonPath"),
        CourseMapEdge(fromCourseID: "cosmicDrift",   toCourseID: "horizonPath"),
        CourseMapEdge(fromCourseID: "vortexRoad",    toCourseID: "stormBolt"),

        // Batch 39
        CourseMapEdge(fromCourseID: "horizonPath",   toCourseID: "lightningRun"),
        CourseMapEdge(fromCourseID: "horizonPath",   toCourseID: "silkRoad"),
        CourseMapEdge(fromCourseID: "stormBolt",     toCourseID: "silkRoad"),
        CourseMapEdge(fromCourseID: "stormBolt",     toCourseID: "frostWave"),
        CourseMapEdge(fromCourseID: "lightningRun",  toCourseID: "dawnRider"),
        CourseMapEdge(fromCourseID: "silkRoad",      toCourseID: "dawnRider"),
        CourseMapEdge(fromCourseID: "frostWave",     toCourseID: "emberGlow"),

        // Batch 40 — Final
        CourseMapEdge(fromCourseID: "dawnRider",     toCourseID: "grandVista"),
        CourseMapEdge(fromCourseID: "emberGlow",     toCourseID: "apexRun"),
    ]

    static func node(courseID: String) -> CourseMapNode? {
        nodes.first { $0.courseID == courseID }
    }

    static func incomingEdges(to courseID: String) -> [CourseMapEdge] {
        edges.filter { $0.toCourseID == courseID }
    }

    static func outgoingEdges(from courseID: String) -> [CourseMapEdge] {
        edges.filter { $0.fromCourseID == courseID }
    }
}
