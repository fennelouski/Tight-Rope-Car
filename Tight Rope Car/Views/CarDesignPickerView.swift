//
//  CarDesignPickerView.swift
//  Tight Rope Car
//

import SwiftUI

/// Preview-only silhouette gallery; production garage uses ``CarSelectionView`` + ``CarCatalog``.
struct CarDesignPickerView: View {
    @Binding var selectedDesign: CarDesign

    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var contentAppeared = false

    var body: some View {
        NavigationStack {
            ZStack {
                HotWheelsTheme.backgroundGradient
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        summaryHeader
                            .opacity(contentAppeared ? 1 : 0)
                            .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 8))

                        heroPreview
                            .opacity(contentAppeared ? 1 : 0)
                            .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

                        designGrid
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("Car Designs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(HotWheelsTheme.trackBlack.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .font(HotWheelsTheme.bodyFont.weight(.bold))
                        .foregroundStyle(HotWheelsTheme.racingYellow)
                        .accessibilityHint("Close car design gallery")
                }
            }
        }
        .onAppear(perform: runEntranceAnimation)
    }

    private var summaryHeader: some View {
        HotWheelsScreenHeader(
            eyebrow: "Dev Gallery",
            eyebrowSystemImage: "car.side.fill",
            title: "Car Designs",
            subtitle: "\(CarDesign.allDesigns.count) body silhouettes for art review — not the gameplay garage"
        )
    }

    private var heroPreview: some View {
        VStack(spacing: 14) {
            CarView(
                car: selectedDesign.makeCar(),
                size: CGSize(width: 140, height: 64)
            )
            .frame(height: 72)
            .animation(.easeInOut(duration: 0.2), value: selectedDesign)

            HotWheelsSelectionCard(
                overline: "Selected silhouette",
                title: selectedDesign.displayName,
                detail: "Tap a design below to preview",
                systemImage: "checkmark.seal.fill",
                accentColor: selectedDesign.appearance.bodyColor,
                accessibilityLabel: "Selected design \(selectedDesign.displayName)"
            )
        }
    }

    private var designGrid: some View {
        HotWheelsContentPanel(
            title: "All Silhouettes",
            trailingCaption: selectedDesign.displayName,
            accessibilityLabel: "Car design grid",
            accessibilityHint: "Double tap a design to select it for preview"
        ) {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 5),
                spacing: 12
            ) {
                ForEach(Array(CarDesign.allDesigns.enumerated()), id: \.element.id) { index, design in
                    designCell(design)
                        .opacity(contentAppeared ? 1 : 0)
                        .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 10))
                        .animation(
                            reduceMotion ? nil : .easeOut(duration: 0.35).delay(Double(index) * 0.02),
                            value: contentAppeared
                        )
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
    }

    private func designCell(_ design: CarDesign) -> some View {
        let isSelected = design == selectedDesign
        let accent = design.appearance.bodyColor

        return Button {
            withAnimation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.78)) {
                selectedDesign = design
            }
        } label: {
            HotWheelsSelectableRowCard(
                isSelected: isSelected,
                accentColor: accent,
                reduceMotion: reduceMotion
            ) {
                VStack(spacing: 8) {
                    CarView(
                        car: design.makeCar(),
                        size: CGSize(width: 64, height: 32)
                    )
                    .frame(height: 36)

                    Text(design.displayName)
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundStyle(isSelected ? .white : .white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.75)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
            }
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(design.displayName)
        .accessibilityHint(isSelected ? "Selected for preview" : "Double tap to preview")
    }

    private func runEntranceAnimation() {
        if reduceMotion {
            contentAppeared = true
            return
        }
        withAnimation(.easeOut(duration: 0.4)) {
            contentAppeared = true
        }
    }
}

#Preview("Car design picker") {
    struct PreviewHost: View {
        @State private var selected: CarDesign = .classicBug

        var body: some View {
            CarDesignPickerView(selectedDesign: $selected)
        }
    }

    return PreviewHost()
}
