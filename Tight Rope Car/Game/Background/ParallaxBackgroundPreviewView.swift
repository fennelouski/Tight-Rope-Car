//
//  ParallaxBackgroundPreviewView.swift
//  Tight Rope Car
//

import SpriteKit
import SwiftUI

/// SwiftUI host for scroll-parallax background preview (simulator / dev).
struct ParallaxBackgroundPreviewView: View {
    var theme: BackgroundTheme = .ocean

    @State private var scene = ParallaxBackgroundPreviewScene()

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .onAppear {
                scene.previewTheme = theme
                scene.scaleMode = .resizeFill
            }
            .onChange(of: theme) { _, newTheme in
                scene.setTheme(newTheme)
            }
    }
}

#Preview("Ocean parallax") {
    ParallaxBackgroundPreviewView(theme: .ocean)
}

#Preview("Forest parallax") {
    ParallaxBackgroundPreviewView(theme: .forest)
}

#Preview("Beach parallax") {
    ParallaxBackgroundPreviewView(theme: .beach)
}

#Preview("City parallax") {
    ParallaxBackgroundPreviewView(theme: .city)
}

#Preview("Bedroom parallax") {
    ParallaxBackgroundPreviewView(theme: .bedroom)
}

#Preview("Toy Shop parallax") {
    ParallaxBackgroundPreviewView(theme: .toyShop)
}

#Preview("Candy Shop parallax") {
    ParallaxBackgroundPreviewView(theme: .candyShop)
}

#Preview("Garden parallax") {
    ParallaxBackgroundPreviewView(theme: .garden)
}

#Preview("All themes gallery") {
    BackgroundThemeGalleryView()
}
