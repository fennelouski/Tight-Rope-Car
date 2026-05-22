//
//  CarRowView.swift
//  Tight Rope Car
//

import SwiftUI

struct CarRowView: View {
    let car: SelectableCar
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 12) {
            CarView(
                car: car.previewCar,
                size: CGSize(width: 96, height: 48)
            )
            .frame(height: 56)
            .padding(.top, 8)

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
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 1, y: 2)
            } else {
                Color.clear
                    .frame(height: 22)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(isSelected ? 0.55 : 0.4))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(
                    isSelected ? HotWheelsTheme.racingYellow : HotWheelsTheme.hotRed.opacity(0.6),
                    lineWidth: isSelected ? 3 : 2
                )
        )
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
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
