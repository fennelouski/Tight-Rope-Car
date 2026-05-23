//
//  Tight_Rope_CarTests.swift
//  Tight Rope CarTests
//
//  Created by Nathan Fennel on 5/22/26.
//

import CoreGraphics
import SwiftData
import Foundation
import Testing
@testable import Tight_Rope_Car

struct Tight_Rope_CarTests {

    @Test func appFlowDepthOrdersSetupFunnel() {
        #expect(AppFlow.landing.depth == 0)
        #expect(AppFlow.profileSelection.depth < AppFlow.carSelection.depth)
        #expect(AppFlow.carSelection.depth < AppFlow.courseSelection.depth)
        #expect(AppFlow.courseSelection.depth < AppFlow.gameplay(courseID: "tutorial").depth)
    }

    @Test func appFlowScreenKeySeparatesCourses() {
        #expect(AppFlow.gameplay(courseID: "tutorial").screenKey != AppFlow.gameplay(courseID: "bumps").screenKey)
        #expect(AppFlow.profileSelection.screenKey == AppFlow.profileSelection.screenKey)
    }

    @Test func carDefaultsAreNeutral() {
        let car = Car()
        #expect(car.progressAlongRope == 0)
        #expect(car.lateralOffset == 0)
        #expect(car.tiltRadians == 0)
    }

    @Test func carEqualityUsesIdAndState() {
        let id = UUID()
        let a = Car(id: id, progressAlongRope: 0.5, lateralOffset: 0.1, tiltRadians: 0.2)
        let b = Car(id: id, progressAlongRope: 0.5, lateralOffset: 0.1, tiltRadians: 0.2)
        let c = Car(id: UUID(), progressAlongRope: 0.5, lateralOffset: 0.1, tiltRadians: 0.2)

        #expect(a == b)
        #expect(a != c)
    }

    @Test func playerProfilePersistsInSwiftData() throws {
        let schema = Schema([PlayerProfile.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        let context = ModelContext(container)

        let profile = PlayerProfile(name: "Alex", age: 9)
        context.insert(profile)
        try context.save()

        let descriptor = FetchDescriptor<PlayerProfile>()
        let fetched = try context.fetch(descriptor)

        #expect(fetched.count == 1)
        #expect(fetched.first?.name == "Alex")
        #expect(fetched.first?.age == 9)
    }

    @Test func profileValidatorRejectsEmptyName() {
        #expect(ProfileValidator.validate(name: "   ", age: 8) == .emptyName)
        #expect(ProfileValidator.validate(name: "Sam", age: 8) == nil)
    }

    @Test func profileValidatorSanitizesName() {
        #expect(ProfileValidator.sanitizedName("  Riley  ") == "Riley")
    }

    @Test func catalogCoversEveryBackgroundTheme() {
        let catalogThemes = Set(BackgroundThemeCatalog.all.map(\.theme))
        let allThemes = Set(BackgroundTheme.allCases)
        #expect(catalogThemes == allThemes)
    }

    @Test func catalogDisplayNamesAreNonEmpty() {
        for entry in BackgroundThemeCatalog.all {
            #expect(!entry.displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            #expect(!entry.tagline.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }

    @Test func catalogSortOrdersAreUnique() {
        let orders = BackgroundThemeCatalog.all.map(\.sortOrder)
        #expect(Set(orders).count == orders.count)
    }

    @Test func backgroundThemeMetadataRoundTripsThroughJSON() throws {
        let original = BackgroundThemeCatalog.metadata(for: .ocean)
        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(BackgroundThemeMetadata.self, from: data)
        #expect(decoded == original)
    }

    @Test func ticketPickupSpriteKitSizeMatchesLayout() {
        #expect(TicketPickupLayout.spriteKitSize.width == 44)
        #expect(TicketPickupLayout.spriteKitSize.height == 56)
        #expect(TicketPickupLayout.spriteKitAnchor == CGPoint(x: 0.5, y: 0.5))
    }

    @Test func courseTicketFractionsAreEvenlySpaced() throws {
        let course = try #require(CourseCatalog.course(id: "tutorial"))
        #expect(course.ticketFractions.count == course.ticketCount)
        #expect(course.ticketFractions == [0.25, 0.5, 0.75])
    }

    @Test func carDesignCaseIterableCountIsFifteen() {
        #expect(CarDesign.allCases.count == 15)
        #expect(CarDesign.allDesigns.count == 15)
    }

    @Test func newCarDesignsDistinctFromOriginalFive() {
        let original: [CarDesign] = [.classicBug, .pickup, .sports, .van, .micro]
        let originalSilhouettes = Set(original.map(\.appearance.silhouette))
        let newDesigns: [CarDesign] = [.convertible, .suv, .raceCar, .iceCreamTruck, .taxi]
        let originalAppearances = original.map(\.appearance)

        for design in newDesigns {
            #expect(!originalSilhouettes.contains(design.appearance.silhouette))
            #expect(!originalAppearances.contains(design.appearance))
        }
    }

    @Test func serviceCarDesignsDistinctFromPriorBatches() {
        let original: [CarDesign] = [.classicBug, .pickup, .sports, .van, .micro]
        let middle: [CarDesign] = [.convertible, .suv, .raceCar, .iceCreamTruck, .taxi]
        let service: [CarDesign] = [.fireTruck, .schoolBus, .policeCar, .ambulance, .motorcycle]
        let priorAppearances = (original + middle).map(\.appearance)

        for design in service {
            #expect(!priorAppearances.contains(design.appearance))
        }
    }

    @Test func policeCarMakeCarUsesDesignAppearance() {
        let car = CarDesign.policeCar.makeCar(progressAlongRope: 0.5, lateralOffset: 0.1, tiltRadians: 0.2)
        #expect(car.appearance == CarDesign.policeCar.appearance)
        #expect(car.appearance.silhouette == .policeCar)
        #expect(car.progressAlongRope == 0.5)
        #expect(car.lateralOffset == 0.1)
        #expect(car.tiltRadians == 0.2)
    }

    @Test func allCarDesignsProduceDistinctAppearances() {
        let appearances = CarDesign.allDesigns.map(\.appearance)
        for i in appearances.indices {
            for j in appearances.indices where j > i {
                #expect(appearances[i] != appearances[j])
            }
        }
    }

    @Test func makeCarAppearanceMatchesDesign() {
        for design in CarDesign.allDesigns {
            let car = design.makeCar(progressAlongRope: 0.4, lateralOffset: 0.2, tiltRadians: 0.1)
            #expect(car.appearance == design.appearance)
            #expect(car.progressAlongRope == 0.4)
            #expect(car.lateralOffset == 0.2)
            #expect(car.tiltRadians == 0.1)
        }
    }

    @Test func allCarDesignsUseV2RenderVersion() {
        for design in CarDesign.allDesigns {
            #expect(design.renderVersion == .v2)
            #expect(design.appearance.renderVersion == .v2)
        }
    }

    @Test func carAppearanceDefaultsToV1RenderVersion() {
        #expect(CarAppearance.default.renderVersion == .v1)
        #expect(CarCatalog.defaultCar.appearance.renderVersion == .v2)
    }
}
