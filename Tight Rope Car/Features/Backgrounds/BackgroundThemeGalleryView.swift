//
//  BackgroundThemeGalleryView.swift
//  Tight Rope Car
//

import SwiftUI

/// Dev/review screen: browse all catalog themes and open full-screen parallax preview.
struct BackgroundThemeGalleryView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var selectedTheme: BackgroundTheme?

    private var themes: [BackgroundThemeMetadata] {
        BackgroundThemeCatalog.sortedForDisplay
    }

    var body: some View {
        NavigationStack {
            List(themes, id: \.theme) { entry in
                Button {
                    selectedTheme = entry.theme
                } label: {
                    themeRow(entry)
                }
                .buttonStyle(.plain)
                .accessibilityHint("Opens parallax preview")
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Backgrounds")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .font(HotWheelsTheme.bodyFont)
                }
            }
            .fullScreenCover(item: $selectedTheme) { theme in
                BackgroundThemePreviewScreen(theme: theme) {
                    selectedTheme = nil
                }
            }
        }
    }

    private func themeRow(_ entry: BackgroundThemeMetadata) -> some View {
        HStack(spacing: 14) {
            BackgroundThemeThumbnailView(entry: entry)

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.displayName)
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.primary)
                Text(entry.tagline)
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer(minLength: 0)

            HStack(spacing: 8) {
                if let soundName = entry.ambienceSoundName,
                   ThemeAmbiencePlayer.isSoundAvailable(soundName) {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(HotWheelsTheme.electricBlue)
                        .accessibilityLabel("Has ambience sound")
                }

                Image(systemName: "play.circle.fill")
                    .font(.title2)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(HotWheelsTheme.racingYellow, HotWheelsTheme.hotRed.opacity(0.85))
                    .accessibilityHidden(true)
            }
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(entry.displayName). \(entry.tagline)")
    }
}

private struct BackgroundThemePreviewScreen: View {
    let theme: BackgroundTheme
    var onClose: () -> Void

    @StateObject private var ambiencePlayer = ThemeAmbiencePlayer()

    private var metadata: BackgroundThemeMetadata {
        BackgroundThemeCatalog.metadata(for: theme)
    }

    private var ambienceSoundName: String? {
        guard let name = metadata.ambienceSoundName,
              ThemeAmbiencePlayer.isSoundAvailable(name)
        else { return nil }
        return name
    }

    var body: some View {
        ZStack {
            ParallaxBackgroundPreviewView(theme: theme)

            VStack(spacing: 0) {
                HStack {
                    if let soundName = ambienceSoundName {
                        ambienceButton(soundName: soundName)
                    }
                    Spacer()
                    closeButton
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                Spacer(minLength: 0)

                previewCaption
                    .padding(.horizontal, 20)
                    .padding(.bottom, 28)
            }
        }
        .onDisappear {
            ambiencePlayer.stop()
        }
    }

    private func ambienceButton(soundName: String) -> some View {
        let isPlaying = ambiencePlayer.isPlaying(soundName: soundName)
        return Button {
            ambiencePlayer.toggle(soundName: soundName)
        } label: {
            Image(systemName: isPlaying ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                .font(.system(size: 22, weight: .bold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    HotWheelsTheme.racingYellow,
                    HotWheelsTheme.trackBlack.opacity(0.5)
                )
                .padding(10)
                .background(
                    Circle()
                        .fill(HotWheelsTheme.trackBlack.opacity(0.65))
                        .overlay(
                            Circle()
                                .strokeBorder(
                                    isPlaying ? HotWheelsTheme.electricBlue : HotWheelsTheme.racingYellow,
                                    lineWidth: 2
                                )
                        )
                )
        }
        .accessibilityLabel(isPlaying ? "Stop ambience" : "Play ambience")
        .accessibilityHint("Loops background sound for this theme")
    }

    private var closeButton: some View {
        Button(action: onClose) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 32, weight: .bold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, HotWheelsTheme.trackBlack.opacity(0.55))
        }
        .accessibilityLabel("Close preview")
    }

    private var previewCaption: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(metadata.displayName)
                .font(HotWheelsTheme.sectionTitleFont)
                .foregroundStyle(.white)
                .hotWheelsTitleShadow()

            Text(metadata.tagline)
                .font(HotWheelsTheme.bodyFont)
                .foregroundStyle(.white.opacity(0.92))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.78))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(HotWheelsTheme.racingYellow, lineWidth: 3)
                )
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(metadata.displayName). \(metadata.tagline)")
    }
}

#Preview {
    BackgroundThemeGalleryView()
}
