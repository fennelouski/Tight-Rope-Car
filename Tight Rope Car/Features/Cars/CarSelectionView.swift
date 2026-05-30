//
//  CarSelectionView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

struct CarSelectionView: View {
    var onContinue: () -> Void = {}
    var onBack: () -> Void = {}

    @Environment(\.modelContext) private var modelContext
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Query(sort: \PlayerProfile.createdAt, order: .reverse) private var profiles: [PlayerProfile]

    @AppStorage(ProfileConstants.selectedProfileIDKey) private var selectedProfileID = ""

    @State private var selectedCarID = ""
    @State private var headerAppeared = false
    @State private var contentAppeared = false
    @State private var footerAppeared = false

    private var activeProfile: PlayerProfile? {
        guard let uuid = UUID(uuidString: selectedProfileID) else { return nil }
        return profiles.first { $0.id == uuid }
    }

    private var selectedCar: SelectableCar? {
        CarCatalog.car(id: selectedCarID)
    }

    private var hasSelection: Bool {
        selectedCar != nil
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : (reduceMotion ? 0 : 12))

            garageSection
                .opacity(contentAppeared ? 1 : 0)
                .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

            selectedCarCard
                .padding(.top, 12)

            Spacer(minLength: 0)
        }
        .padding(.horizontal, horizontalPadding)
        .hotWheelsScreenContentPadding()
        .hotWheelsContentWidth()
        .hotWheelsMenuScreenBackground()
        .hotWheelsBottomChromeInset(spacing: 0) {
            continueButton
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity)
                .hotWheelsContentWidth()
                .hotWheelsMenuBottomChromeBackground()
                .opacity(footerAppeared ? 1 : 0)
                .offset(y: footerAppeared ? 0 : (reduceMotion ? 0 : 16))
        }
        .hotWheelsSafeAreaPolicy()
        .onAppear {
            syncSelectionFromProfile()
            runEntranceAnimation()
            if let car = selectedCar {
                CarAppearanceTextureRenderer.prewarm(appearance: car.appearance)
            }
        }
        .onChange(of: selectedProfileID) { _, _ in
            syncSelectionFromProfile()
        }
    }

    private var horizontalPadding: CGFloat {
        horizontalSizeClass == .regular ? 40 : 24
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HotWheelsFunnelTopBar(
                backAccessibilityHint: "Return to profile selection",
                onBack: onBack
            ) {
                if let profile = activeProfile {
                    HotWheelsRacerChip(profile: profile)
                }
            }

            HotWheelsScreenHeader(
                eyebrow: "Garage",
                eyebrowSystemImage: "car.fill",
                title: "Choose Your Car",
                subtitle: headerSubtitle
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 12)
    }

    private var headerSubtitle: String {
        let count = CarCatalog.all.count
        let rideWord = count == 1 ? "ride" : "rides"
        if hasSelection {
            return "\(count) \(rideWord) in the garage — yours is locked in"
        }
        return "\(count) \(rideWord) — tap one to claim it"
    }

    // MARK: - Garage grid

    private var garageSection: some View {
        HotWheelsContentPanel(
            title: "The Lot",
            trailingCaption: selectedCar?.displayName,
            accessibilityLabel: "Car garage",
            accessibilityHint: "Scroll to browse rides. Double tap a car to select it."
        ) {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 16) {
                    ForEach(CarCatalog.all) { car in
                        Button {
                            selectCar(car)
                        } label: {
                            CarRowView(
                                car: car,
                                isSelected: selectedCarID == car.id
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
            }
            .frame(maxHeight: horizontalSizeClass == .regular ? 560 : 440)
        }
    }

    private var gridColumns: [GridItem] {
        let minimum: CGFloat = horizontalSizeClass == .regular ? 200 : 150
        return [GridItem(.adaptive(minimum: minimum), spacing: 16)]
    }

    // MARK: - Selection card

    @ViewBuilder
    private var selectedCarCard: some View {
        if let car = selectedCar {
            HotWheelsSelectionCard(
                overline: "Your ride",
                title: car.displayName,
                detail: car.tagline,
                systemImage: "checkmark.seal.fill",
                accentColor: HotWheelsTheme.electricBlue,
                accessibilityLabel: "Selected car \(car.displayName)\(car.tagline.map { ", \($0)" } ?? "")"
            )
            .transition(reduceMotion ? .opacity : .move(edge: .bottom).combined(with: .opacity))
        }
    }

    // MARK: - Continue

    private var continueButton: some View {
        Button {
            onContinue()
        } label: {
            Label(
                hasSelection ? "Head to Track Map" : "Pick a Car",
                systemImage: hasSelection ? "map.fill" : "hand.tap.fill"
            )
        }
        .buttonStyle(HotWheelsAccentButtonStyle(
            fillColor: hasSelection ? HotWheelsTheme.racingYellow : HotWheelsTheme.racingYellow.opacity(0.35),
            strokeColor: hasSelection ? HotWheelsTheme.hotRed : HotWheelsTheme.hotRed.opacity(0.35)
        ))
        .disabled(!hasSelection)
        .accessibilityLabel(hasSelection ? "Head to track map" : "Pick a car")
        .accessibilityHint(hasSelection ? "Continue to course selection" : "Select a car from the garage first")
    }

    // MARK: - Actions

    private func selectCar(_ car: SelectableCar) {
        let animation: Animation? = reduceMotion
            ? nil
            : .spring(response: 0.32, dampingFraction: 0.78)
        withAnimation(animation) {
            selectedCarID = car.id
        }
        activeProfile?.selectedCarID = car.id
        CarAppearanceTextureRenderer.prewarm(appearance: car.appearance)
        try? modelContext.save()
    }

    private func syncSelectionFromProfile() {
        guard let profile = activeProfile,
              let savedID = profile.selectedCarID,
              CarCatalog.car(id: savedID) != nil
        else {
            selectedCarID = ""
            return
        }
        selectedCarID = CarCatalog.canonicalCarID(savedID)
    }

    private func runEntranceAnimation() {
        if reduceMotion {
            headerAppeared = true
            contentAppeared = true
            footerAppeared = true
            return
        }

        withAnimation(.easeOut(duration: 0.4)) {
            headerAppeared = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeOut(duration: 0.45)) {
                contentAppeared = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeOut(duration: 0.45)) {
                footerAppeared = true
            }
        }
    }
}

#Preview("No selection") {
    ZStack {
        RacingStripeBackground()
        CarSelectionView()
    }
    .modelContainer(for: PlayerProfile.self, inMemory: true)
}

#Preview("With saved car") {
    let container = try! ModelContainer(
        for: PlayerProfile.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(name: "Alex", age: 10, selectedCarID: "raceCar")
    container.mainContext.insert(profile)
    UserDefaults.standard.set(profile.id.uuidString, forKey: ProfileConstants.selectedProfileIDKey)

    return ZStack {
        RacingStripeBackground()
        CarSelectionView()
    }
    .modelContainer(container)
}

#Preview("Garage — iPad width") {
    let container = try! ModelContainer(
        for: PlayerProfile.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(name: "Jordan", age: 12, selectedCarID: "classicBug")
    container.mainContext.insert(profile)
    UserDefaults.standard.set(profile.id.uuidString, forKey: ProfileConstants.selectedProfileIDKey)

    return ZStack {
        RacingStripeBackground()
        CarSelectionView()
    }
    .modelContainer(container)
    .environment(\.horizontalSizeClass, .regular)
}
