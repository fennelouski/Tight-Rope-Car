//
//  CarDesignPickerView.swift
//  Tight Rope Car
//

import SwiftUI
#if canImport(CoreMotion)
import CoreMotion
#endif

/// Preview-only silhouette gallery; production garage uses ``CarSelectionView`` + ``CarCatalog``.
struct CarDesignPickerView: View {
    @Binding var selectedDesign: CarDesign

    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var contentAppeared = false
    @State private var previewLateralOffset: CGFloat = 0

    #if canImport(CoreMotion)
    private let motionManager = CMMotionManager()
    #endif

    var body: some View {
        NavigationStack {
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
        .hotWheelsSheetBackground()
        .hotWheelsSafeAreaPolicy()
        .onAppear(perform: runEntranceAnimation)
        .onDisappear(perform: stopMotion)
    }

    private var summaryHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Label("Dev Gallery", systemImage: "car.side.fill")
                .font(HotWheelsTheme.captionFont.weight(.bold))
                .foregroundStyle(HotWheelsTheme.racingYellow)
            Text("\(CarDesign.allDesigns.count) body silhouettes for art review — not the gameplay garage")
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var heroPreview: some View {
        VStack(spacing: 14) {
            RearViewCarView(
                appearance: selectedDesign.makeCar().appearance,
                size: CGSize(width: 160, height: 120)
            )
            .offset(x: previewLateralOffset)
            .frame(height: 120)
            .animation(.easeInOut(duration: 0.2), value: selectedDesign)

            Text(selectedDesign.displayName)
                .font(HotWheelsTheme.sectionTitleFont)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.4), radius: 0, x: 1, y: 2)
                .animation(.easeInOut(duration: 0.15), value: selectedDesign)
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
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
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
                    RearViewCarView(
                        appearance: design.makeCar().appearance,
                        size: CGSize(width: 80, height: 80)
                    )
                    .frame(height: 80)

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
        } else {
            withAnimation(.easeOut(duration: 0.4)) {
                contentAppeared = true
            }
        }
        startMotion()
    }

    private func startMotion() {
        #if canImport(CoreMotion)
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0 / 30.0
        motionManager.startDeviceMotionUpdates(to: .main) { [self] motion, _ in
            guard let motion else { return }
            withAnimation(.interactiveSpring(response: 0.25, dampingFraction: 0.7)) {
                previewLateralOffset = CGFloat(motion.attitude.roll) * 50
            }
        }
        #endif
    }

    private func stopMotion() {
        #if canImport(CoreMotion)
        motionManager.stopDeviceMotionUpdates()
        #endif
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
