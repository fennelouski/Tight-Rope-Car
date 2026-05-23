//
//  ProfileAvatarView.swift
//  Tight Rope Car
//

import SwiftUI
import UIKit

struct ProfileAvatarView: View {
    let avatarJPEGData: Data?
    var size: CGFloat = 56
    var borderColor: Color = HotWheelsTheme.electricBlue
    /// Stronger racing-yellow outer ring — use for selected profiles and sheet previews.
    var isHighlighted: Bool = false

    private var accentRingWidth: CGFloat { isHighlighted ? 4 : 3 }
    private var outerRingWidth: CGFloat { isHighlighted ? 3 : 0 }

    var body: some View {
        Group {
            if let data = avatarJPEGData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(borderColor.opacity(0.95))
                    .padding(size * 0.14)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        borderColor.opacity(0.35),
                                        HotWheelsTheme.trackBlack.opacity(0.5),
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            Circle()
                .strokeBorder(HotWheelsTheme.trackBlack, lineWidth: 2)
        )
        .padding(2)
        .overlay(
            Circle()
                .strokeBorder(borderColor, lineWidth: accentRingWidth)
        )
        .padding(isHighlighted ? 3 : 1)
        .overlay(
            Circle()
                .strokeBorder(
                    isHighlighted ? HotWheelsTheme.racingYellow : Color.clear,
                    lineWidth: outerRingWidth
                )
        )
        .shadow(
            color: isHighlighted ? borderColor.opacity(0.45) : .clear,
            radius: isHighlighted ? 6 : 0
        )
        .accessibilityHidden(true)
    }
}

#Preview("Default") {
    HStack(spacing: 24) {
        ProfileAvatarView(avatarJPEGData: nil, size: 56)
        ProfileAvatarView(
            avatarJPEGData: nil,
            size: 56,
            borderColor: HotWheelsTheme.hotRed,
            isHighlighted: true
        )
    }
    .padding()
    .background(HotWheelsTheme.backgroundGradient)
}
