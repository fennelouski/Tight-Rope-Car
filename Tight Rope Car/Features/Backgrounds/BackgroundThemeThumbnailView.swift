//
//  BackgroundThemeThumbnailView.swift
//  Tight Rope Car
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// List-row preview of a background theme using its far parallax asset.
struct BackgroundThemeThumbnailView: View {
    let entry: BackgroundThemeMetadata
    var size: CGFloat = 52
    var accentColor: Color = HotWheelsTheme.racingYellow

    private var assetName: String { entry.galleryThumbnailAssetName }

    private var hasAssetImage: Bool {
        #if canImport(UIKit)
        UIImage(named: assetName) != nil
        #else
        false
        #endif
    }

    var body: some View {
        ZStack {
            skyGradientFallback

            if hasAssetImage {
                Image(assetName)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(accentColor.opacity(0.95), lineWidth: 2)
        )
        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 2)
        .accessibilityHidden(true)
    }

    private var skyGradientFallback: some View {
        let top = entry.skyGradient.first?.swiftUIColor ?? .blue
        let bottom = entry.skyGradient.last?.swiftUIColor ?? top
        let ground = entry.groundColor.swiftUIColor

        return LinearGradient(
            colors: [top, bottom, ground],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview("Ocean thumbnail") {
    BackgroundThemeThumbnailView(entry: BackgroundThemeCatalog.metadata(for: .ocean))
        .padding()
}
