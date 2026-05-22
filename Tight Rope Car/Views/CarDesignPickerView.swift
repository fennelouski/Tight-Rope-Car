//
//  CarDesignPickerView.swift
//  Tight Rope Car
//

import SwiftUI

/// Horizontal gallery for choosing a ``CarDesign`` before play.
struct CarDesignPickerView: View {
    @Binding var selectedDesign: CarDesign

    var body: some View {
        VStack(spacing: 20) {
            CarView(
                car: selectedDesign.makeCar(),
                size: CGSize(width: 120, height: 56)
            )
            .animation(.easeInOut(duration: 0.2), value: selectedDesign)

            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 5),
                    spacing: 12
                ) {
                    ForEach(CarDesign.allDesigns) { design in
                        designCell(design)
                    }
                }
            }
            .frame(maxHeight: 400)
            .padding(.horizontal)
        }
    }

    private func designCell(_ design: CarDesign) -> some View {
        let isSelected = design == selectedDesign

        return Button {
            selectedDesign = design
        } label: {
            VStack(spacing: 8) {
                CarView(
                    car: design.makeCar(),
                    size: CGSize(width: 64, height: 32)
                )
                Text(design.displayName)
                    .font(.caption)
                    .foregroundStyle(isSelected ? .primary : .secondary)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(design.displayName)
    }
}

#Preview("Car design picker") {
    struct PreviewHost: View {
        @State private var selected: CarDesign = .classicBug

        var body: some View {
            CarDesignPickerView(selectedDesign: $selected)
                .padding()
        }
    }

    return PreviewHost()
}
