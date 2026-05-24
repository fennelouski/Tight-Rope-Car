//
//  BackgroundThemeGalleryView.swift
//  Tight Rope Car
//

import SwiftUI

/// Player-facing theme gallery: browse catalog themes and preview parallax + ambience.
struct BackgroundThemeGalleryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var selectedTheme: BackgroundTheme?
    @State private var contentAppeared = false

    private var themes: [BackgroundThemeMetadata] {
        BackgroundThemeCatalog.sortedForDisplay
    }

    private var ambienceThemeCount: Int {
        themes.filter { entry in
            guard let soundName = entry.ambienceSoundName else { return false }
            return ThemeAmbiencePlayer.isSoundAvailable(soundName)
        }.count
    }

    var body: some View {
        NavigationStack {
            ZStack {
                HotWheelsTheme.backgroundGradient
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        summaryHeader
                            .opacity(contentAppeared ? 1 : 0)
                            .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 8))

                        HotWheelsContentPanel(
                            title: "Theme Library",
                            trailingCaption: "\(themes.count) worlds",
                            accessibilityLabel: "Theme library",
                            accessibilityHint: "Tap a theme to open full-screen preview"
                        ) {
                            LazyVStack(spacing: 12) {
                                ForEach(Array(themes.enumerated()), id: \.element.theme) { index, entry in
                                    themeRowButton(entry)
                                        .opacity(contentAppeared ? 1 : 0)
                                        .offset(y: contentAppeared ? 0 : (reduceMotion ? 0 : 10))
                                        .animation(
                                            reduceMotion ? nil : .easeOut(duration: 0.35).delay(Double(index) * 0.03),
                                            value: contentAppeared
                                        )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("Backgrounds")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(HotWheelsTheme.trackBlack.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .font(HotWheelsTheme.bodyFont.weight(.bold))
                        .foregroundStyle(HotWheelsTheme.racingYellow)
                        .accessibilityHint("Close background gallery")
                }
            }
            .fullScreenCover(item: $selectedTheme) { theme in
                BackgroundThemePreviewScreen(theme: theme) {
                    selectedTheme = nil
                }
            }
        }
        .onAppear {
            if reduceMotion {
                contentAppeared = true
            } else {
                withAnimation(.easeOut(duration: 0.4)) {
                    contentAppeared = true
                }
            }
        }
    }

    private var summaryHeader: some View {
        VStack(alignment: .leading, spacing: 14) {
            HotWheelsScreenHeader(
                eyebrow: "Art Direction",
                eyebrowSystemImage: "photo.on.rectangle.angled",
                title: "Backgrounds",
                subtitle: "Parallax worlds used across the course map"
            )

            HStack(spacing: 12) {
                HotWheelsStatPill(
                    systemImage: "square.stack.3d.up.fill",
                    value: "\(themes.count)",
                    title: "Themes",
                    accent: HotWheelsTheme.electricBlue,
                    isEmphasized: true,
                    size: .compact
                )
                HotWheelsStatPill(
                    systemImage: "speaker.wave.2.fill",
                    value: "\(ambienceThemeCount)",
                    title: "Ambience",
                    accent: HotWheelsTheme.flameOrange,
                    isEmphasized: ambienceThemeCount > 0,
                    size: .compact
                )
            }
        }
    }

    private func themeRowButton(_ entry: BackgroundThemeMetadata) -> some View {
        Button {
            selectedTheme = entry.theme
        } label: {
            themeRow(entry)
        }
         .buttonStyle(.plain)
        .accessibilityHint("Opens parallax preview")
    }

    private func themeRow(_ entry: BackgroundThemeMetadata) -> some View {
        let accent = themeAccent(for: entry)
        let hasAmbience = entry.ambienceSoundName.map(ThemeAmbiencePlayer.isSoundAvailable) ?? false

        return HStack(spacing: 14) {
            BackgroundThemeThumbnailView(entry: entry, size: 64, accentColor: accent)

            VStack(alignment: .leading, spacing: 6) {
                Text(entry.displayName)
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.white)

                Text(entry.tagline)
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.78))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 12) {
                    HotWheelsInlineStat(
                        systemImage: "square.3.layers.3d",
                        text: "\(entry.parallaxLayers.count) layers",
                        accent: HotWheelsTheme.electricBlue
                    )

                    if hasAmbience {
                        HotWheelsInlineStat(
                            systemImage: "speaker.wave.2.fill",
                            text: "Ambience",
                            accent: HotWheelsTheme.flameOrange
                        )
                    }
                }
            }

            Spacer(minLength: 8)

            Image(systemName: "play.circle.fill")
                .font(.title2.weight(.black))
                .symbolRenderingMode(.palette)
                .foregroundStyle(HotWheelsTheme.racingYellow, accent.opacity(0.85))
                .accessibilityHidden(true)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.trackBlack.opacity(0.55),
                            accent.opacity(0.14),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(accent.opacity(0.65), lineWidth: 2)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(themeRowAccessibilityLabel(entry, hasAmbience: hasAmbience))
    }

    private func themeAccent(for entry: BackgroundThemeMetadata) -> Color {
        entry.skyGradient.first?.swiftUIColor ?? HotWheelsTheme.electricBlue
    }

    private func themeRowAccessibilityLabel(_ entry: BackgroundThemeMetadata, hasAmbience: Bool) -> String {
        var parts = [entry.displayName, entry.tagline, "\(entry.parallaxLayers.count) parallax layers"]
        if hasAmbience {
            parts.append("includes ambience sound")
        }
        return parts.joined(separator: ". ")
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
                    HotWheelsProminentIconButton(
                        systemImage: "xmark",
                        accessibilityLabel: "Close preview",
                        accessibilityHint: "Return to background gallery"
                    ) {
                        onClose()
                    }
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
                .font(.system(size: 20, weight: .black))
                .foregroundStyle(HotWheelsTheme.trackBlack)
                .frame(width: 48, height: 48)
                .background(
                    Circle()
                        .fill(isPlaying ? HotWheelsTheme.electricBlue : HotWheelsTheme.racingYellow)
                        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 3)
                )
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.hotRed, lineWidth: 3)
                )
        }
        .accessibilityLabel(isPlaying ? "Stop ambience" : "Play ambience")
        .accessibilityHint("Loops background sound for this theme")
    }

    private var previewCaption: some View {
        HotWheelsSelectionCard(
            overline: "Parallax preview",
            title: metadata.displayName,
            detail: metadata.tagline,
            systemImage: "play.circle.fill",
            accentColor: metadata.skyGradient.first?.swiftUIColor ?? HotWheelsTheme.electricBlue,
            accessibilityLabel: "\(metadata.displayName). \(metadata.tagline)"
        )
    }
}

#Preview {
    BackgroundThemeGalleryView()
}
