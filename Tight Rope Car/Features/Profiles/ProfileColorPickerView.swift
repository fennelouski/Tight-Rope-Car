//
//  ProfileColorPickerView.swift
//  Tight Rope Car
//

import SwiftUI

/// 8×4 grid of the 32 selectable profile colors.
struct ProfileColorPickerView: View {
    @Binding var selectedIndex: Int

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 8)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            selectedColorRow

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(PlayerColorPalette.all) { entry in
                    colorSwatch(entry)
                }
            }

            Text("Tap a swatch to set your team color")
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.55))
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Profile color")
    }

    private var selectedColorRow: some View {
        let entry = PlayerColorPalette.entry(at: selectedIndex)

        return HStack(spacing: 10) {
            Circle()
                .fill(entry.color)
                .frame(width: 22, height: 22)
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.trackBlack.opacity(0.35), lineWidth: 1)
                )
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.racingYellow, lineWidth: 2)
                        .padding(-2)
                )
                .accessibilityHidden(true)

            Text(entry.name)
                .font(HotWheelsTheme.captionFont.weight(.bold))
                .foregroundStyle(.white.opacity(0.95))

            Spacer(minLength: 0)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Selected color \(entry.name)")
    }

    private func colorSwatch(_ entry: PlayerColorPalette.Entry) -> some View {
        let isSelected = selectedIndex == entry.id

        return Button {
            selectedIndex = entry.id
        } label: {
            Circle()
                .fill(entry.color)
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.trackBlack.opacity(0.35), lineWidth: 1)
                )
                .overlay(
                    Circle()
                        .strokeBorder(
                            isSelected ? HotWheelsTheme.racingYellow : Color.clear,
                            lineWidth: 3
                        )
                        .padding(-2)
                )
                .overlay {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .black))
                            .foregroundStyle(HotWheelsTheme.trackBlack)
                            .shadow(color: .white.opacity(0.85), radius: 0, x: 0, y: 0)
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .shadow(
                    color: isSelected ? entry.color.opacity(0.55) : .clear,
                    radius: isSelected ? 4 : 0
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(entry.name)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

}

#Preview {
    ZStack {
        HotWheelsTheme.backgroundGradient.ignoresSafeArea()
        ProfileColorPickerView(selectedIndex: .constant(13))
            .padding()
    }
}
