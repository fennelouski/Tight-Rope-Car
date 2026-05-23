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
            .navigationTitle("Backgrounds")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
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
        HStack(spacing: 12) {
            themeSwatch(entry)
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.displayName)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(entry.tagline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }

    private func themeSwatch(_ entry: BackgroundThemeMetadata) -> some View {
        let top = entry.skyGradient.first?.swiftUIColor ?? .blue
        let bottom = entry.skyGradient.last?.swiftUIColor ?? top
        let ground = entry.groundColor.swiftUIColor

        return RoundedRectangle(cornerRadius: 8)
            .fill(
                LinearGradient(
                    colors: [top, bottom, ground],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 44, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.quaternary, lineWidth: 1)
            )
    }
}

private struct BackgroundThemePreviewScreen: View {
    let theme: BackgroundTheme
    var onClose: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ParallaxBackgroundPreviewView(theme: theme)
            Button(action: onClose) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white, .black.opacity(0.35))
                    .padding()
            }
            .accessibilityLabel("Close preview")
        }
    }
}

#Preview {
    BackgroundThemeGalleryView()
}
