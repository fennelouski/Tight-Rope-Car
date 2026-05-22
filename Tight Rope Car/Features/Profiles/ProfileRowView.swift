//
//  ProfileRowView.swift
//  Tight Rope Car
//

import SwiftUI

struct ProfileRowView: View {
    let profile: PlayerProfile
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 16) {
            ProfileAvatarView(avatarJPEGData: profile.avatarJPEGData, size: 56)
                .overlay(
                    Circle()
                        .strokeBorder(
                            isSelected ? HotWheelsTheme.racingYellow : Color.white.opacity(0.4),
                            lineWidth: isSelected ? 3 : 2
                        )
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(profile.displayName)
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.white)
                Text("Age \(profile.age)")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.85))
            }

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.5), radius: 0, x: 1, y: 2)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
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
    }
}

#Preview {
    ZStack {
        HotWheelsTheme.backgroundGradient
        ProfileRowView(
            profile: PlayerProfile(name: "Speed Racer", age: 9),
            isSelected: true
        )
        .padding()
    }
}
