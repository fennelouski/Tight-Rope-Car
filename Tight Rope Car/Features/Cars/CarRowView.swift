//
//  CarRowView.swift
//  Tight Rope Car
//

import SwiftUI

struct CarRowView: View {
    let car: SelectableCar
    let isSelected: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HotWheelsSelectableRowCard(
            isSelected: isSelected,
            accentColor: car.appearance.bodyColor,
            reduceMotion: reduceMotion
        ) {
            VStack(spacing: 12) {
                CarView(
                    car: car.previewCar,
                    size: CGSize(width: 96, height: 48)
                )
                .frame(height: 56)
                .padding(.top, 4)

                VStack(spacing: 4) {
                    Text(car.displayName)
                        .font(HotWheelsTheme.headlineFont)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)

                    if let tagline = car.tagline {
                        Text(tagline)
                            .font(HotWheelsTheme.captionFont)
                            .foregroundStyle(.white.opacity(0.85))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.85)
                    }
                }
                .padding(.horizontal, 8)

                if isSelected {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title3.weight(.black))
                        .foregroundStyle(HotWheelsTheme.racingYellow)
                        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 1, y: 2)
                        .accessibilityHidden(true)
                } else {
                    Color.clear
                        .frame(height: 22)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(car.displayName)
        .accessibilityHint(isSelected ? "Selected" : "Double tap to select")
    }
}

#Preview {
    ZStack {
        RacingStripeBackground()
        CarRowView(car: CarCatalog.defaultCar, isSelected: true)
            .padding()
    }
}
