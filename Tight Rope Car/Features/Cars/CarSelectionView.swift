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

    private var hasSelection: Bool {
        !selectedCarID.isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : (reduceMotion ? 0 : 12))

            carGrid
                .opacity(contentAppeared ? 1 : 0)
                .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

            Spacer(minLength: 16)

            continueButton
                .opacity(footerAppeared ? 1 : 0)
                .offset(y: footerAppeared ? 0 : (reduceMotion ? 0 : 16))
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.top, 16)
        .padding(.bottom, 32)
        .hotWheelsContentWidth()
        .onAppear {
            syncSelectionFromProfile()
            runEntranceAnimation()
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
        HStack(alignment: .top, spacing: 12) {
            CourseMapToolbarButton(
                systemImage: "chevron.left",
                accessibilityLabel: "Back",
                accessibilityHint: "Return to profile selection"
            ) {
                onBack()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Choose Your Car")
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

                Text("Tap a ride to select it")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.9))
            }

            Spacer(minLength: 0)
        }
        .padding(.bottom, 20)
    }

    // MARK: - Grid

    private var carGrid: some View {
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
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
    }

    private var gridColumns: [GridItem] {
        let minimum: CGFloat = horizontalSizeClass == .regular ? 200 : 150
        return [GridItem(.adaptive(minimum: minimum), spacing: 16)]
    }

    // MARK: - Continue

    private var continueButton: some View {
        Button {
            onContinue()
        } label: {
            Text("Continue")
        }
        .buttonStyle(HotWheelsAccentButtonStyle(
            fillColor: hasSelection ? HotWheelsTheme.racingYellow : HotWheelsTheme.racingYellow.opacity(0.35),
            strokeColor: hasSelection ? HotWheelsTheme.hotRed : HotWheelsTheme.hotRed.opacity(0.35)
        ))
        .disabled(!hasSelection)
        .accessibilityLabel("Continue")
        .accessibilityHint(hasSelection ? "Continue to course map" : "Select a car first")
    }

    // MARK: - Actions

    private func selectCar(_ car: SelectableCar) {
        selectedCarID = car.id
        activeProfile?.selectedCarID = car.id
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
        selectedCarID = savedID
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
    let profile = PlayerProfile(name: "Alex", age: 10, selectedCarID: "volt")
    container.mainContext.insert(profile)
    UserDefaults.standard.set(profile.id.uuidString, forKey: ProfileConstants.selectedProfileIDKey)

    return ZStack {
        RacingStripeBackground()
        CarSelectionView()
    }
    .modelContainer(container)
}
