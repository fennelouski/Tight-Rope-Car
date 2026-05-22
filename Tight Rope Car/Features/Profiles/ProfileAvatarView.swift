//
//  ProfileAvatarView.swift
//  Tight Rope Car
//

import SwiftUI
import UIKit

struct ProfileAvatarView: View {
    let avatarJPEGData: Data?
    var size: CGFloat = 56

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
                    .foregroundStyle(HotWheelsTheme.electricBlue.opacity(0.9))
                    .padding(size * 0.12)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .background(Circle().fill(HotWheelsTheme.trackBlack.opacity(0.5)))
    }
}
