//
//  HotWheelsComponents.swift
//  Tight Rope Car
//

import SwiftUI

// MARK: - Screen header

struct HotWheelsScreenHeader<Trailing: View>: View {
    let eyebrow: String
    let eyebrowSystemImage: String
    let title: String
    let subtitle: String
    @ViewBuilder var trailing: () -> Trailing

    init(
        eyebrow: String,
        eyebrowSystemImage: String,
        title: String,
        subtitle: String,
        @ViewBuilder trailing: @escaping () -> Trailing = { EmptyView() }
    ) {
        self.eyebrow = eyebrow
        self.eyebrowSystemImage = eyebrowSystemImage
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Label(eyebrow, systemImage: eyebrowSystemImage)
                    .font(HotWheelsTheme.captionFont.weight(.bold))
                    .foregroundStyle(HotWheelsTheme.racingYellow)
                    .labelStyle(.titleAndIcon)
                    .accessibilityHidden(true)

                Text(title)
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()
                    .accessibilityAddTraits(.isHeader)

                Text(subtitle)
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.9))
            }

            Spacer(minLength: 8)

            trailing()
        }
    }
}

struct HotWheelsRacerChip: View {
    let profile: PlayerProfile

    var body: some View {
        HStack(spacing: 8) {
            ProfileAvatarView(
                avatarJPEGData: profile.avatarJPEGData,
                size: 36,
                borderColor: profile.profileColor,
                isHighlighted: false
            )

            VStack(alignment: .leading, spacing: 0) {
                Text("Racing as")
                    .font(.system(size: 9, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))
                    .textCase(.uppercase)
                Text(profile.displayName)
                    .font(HotWheelsTheme.captionFont.weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.55))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(profile.profileColor.opacity(0.85), lineWidth: 2)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Racing as \(profile.displayName)")
    }
}

// MARK: - Toolbar rail

struct HotWheelsToolbarRail<Leading: View, Trailing: View>: View {
    var centerHint: String?
    @ViewBuilder let leading: () -> Leading
    @ViewBuilder let trailing: () -> Trailing

    init(
        centerHint: String? = nil,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder trailing: @escaping () -> Trailing = { EmptyView() }
    ) {
        self.centerHint = centerHint
        self.leading = leading
        self.trailing = trailing
    }

    var body: some View {
        HStack(spacing: 10) {
            leading()

            if let centerHint {
                Spacer(minLength: 0)
                Text(centerHint)
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.55))
                    .accessibilityHidden(true)
            }

            Spacer(minLength: 0)

            trailing()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.5))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(HotWheelsTheme.hotRed.opacity(0.45), lineWidth: 1.5)
        )
    }
}

// MARK: - Content panel

struct HotWheelsContentPanel<Content: View>: View {
    let title: String
    var trailingCaption: String?
    var trailingCaptionColor: Color = HotWheelsTheme.racingYellow
    var accessibilityLabel: String
    var accessibilityHint: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(HotWheelsTheme.captionFont.weight(.bold))
                    .foregroundStyle(.white.opacity(0.85))
                Spacer()
                if let trailingCaption {
                    Text(trailingCaption)
                        .font(HotWheelsTheme.captionFont.weight(.bold))
                        .foregroundStyle(trailingCaptionColor)
                        .lineLimit(1)
                }
            }
            .accessibilityHidden(true)

            content()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.25))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(HotWheelsTheme.hotRed.opacity(0.35), lineWidth: 1.5)
                )
        )
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }
}

// MARK: - Selection card

struct HotWheelsSelectionCard: View {
    let overline: String
    let title: String
    var detail: String?
    var detailColor: Color = HotWheelsTheme.electricBlue.opacity(0.95)
    let systemImage: String
    var accentColor: Color = HotWheelsTheme.hotRed
    var accessibilityLabel: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: systemImage)
                .font(.title2.weight(.black))
                .foregroundStyle(HotWheelsTheme.racingYellow)
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.45), radius: 0, x: 1, y: 2)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(overline)
                    .font(.system(size: 10, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))
                    .textCase(.uppercase)
                    .tracking(0.5)

                Text(title)
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)

                if let detail {
                    Text(detail)
                        .font(HotWheelsTheme.captionFont)
                        .foregroundStyle(detailColor)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            HotWheelsTheme.trackBlack.opacity(0.65),
                            accentColor.opacity(0.2),
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(HotWheelsTheme.racingYellow.opacity(0.85), lineWidth: 2.5)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
    }
}

// MARK: - Stat pill

struct HotWheelsStatPill: View {
    enum Size {
        case banner
        case compact
    }

    let systemImage: String
    let value: String
    let title: String
    let accent: Color
    let isEmphasized: Bool
    var size: Size = .banner

    var body: some View {
        HStack(spacing: size == .banner ? 10 : 6) {
            Image(systemName: systemImage)
                .font(.system(size: size == .banner ? 20 : 14, weight: .black))
                .foregroundStyle(isEmphasized ? accent : .white.opacity(0.7))
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.4), radius: 0, x: 0, y: 1)

            VStack(alignment: .leading, spacing: 1) {
                Text(value)
                    .font(size == .banner ? HotWheelsTheme.headlineFont : HotWheelsTheme.captionFont.weight(.bold))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)

                if size == .banner {
                    Text(title.uppercased())
                        .font(.system(size: 10, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                        .tracking(0.6)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, size == .banner ? 14 : 10)
        .padding(.vertical, size == .banner ? 12 : 8)
        .background(
            RoundedRectangle(cornerRadius: size == .banner ? 14 : 10, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(isEmphasized ? 0.65 : 0.45))
        )
        .overlay(
            RoundedRectangle(cornerRadius: size == .banner ? 14 : 10, style: .continuous)
                .strokeBorder(
                    isEmphasized ? accent : HotWheelsTheme.hotRed.opacity(0.45),
                    lineWidth: isEmphasized ? 2.5 : 1.5
                )
        )
        .shadow(
            color: isEmphasized ? accent.opacity(0.35) : .clear,
            radius: isEmphasized ? 6 : 0
        )
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(title): \(value)")
    }
}

/// Compact stat block for score sheets and record cards (time, distance, tickets).
struct HotWheelsMetricTile: View {
    let systemImage: String
    let label: String
    let value: String
    let accent: Color
    var detail: String? = nil
    var isFeatured: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: systemImage)
                .font(.system(size: isFeatured ? 16 : 14, weight: .black))
                .foregroundStyle(accent)
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 1)

            Text(label.uppercased())
                .font(.system(size: 9, weight: .heavy, design: .rounded))
                .foregroundStyle(.white.opacity(0.65))
                .tracking(0.4)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(value)
                .font(isFeatured ? HotWheelsTheme.headlineFont : HotWheelsTheme.bodyFont)
                .foregroundStyle(isFeatured ? accent : .white)
                .minimumScaleFactor(0.75)
                .lineLimit(1)

            if let detail {
                Text(detail)
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.65))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(isFeatured ? 0.5 : 0.35))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(
                    isFeatured ? accent.opacity(0.85) : Color.white.opacity(0.12),
                    lineWidth: isFeatured ? 2 : 1
                )
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
    }

    private var accessibilityLabel: String {
        if let detail {
            return "\(label): \(value). \(detail)"
        }
        return "\(label): \(value)"
    }
}

/// Single-line icon stat for list rows (tickets, tracks cleared, etc.).
struct HotWheelsInlineStat: View {
    let systemImage: String
    let text: String
    var accent: Color = HotWheelsTheme.racingYellow

    var body: some View {
        Label(text, systemImage: systemImage)
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundStyle(accent.opacity(0.95))
            .labelStyle(.titleAndIcon)
            .accessibilityHidden(true)
    }
}

/// Gradient card shell for selectable list rows.
struct HotWheelsSelectableRowCard<Content: View>: View {
    let isSelected: Bool
    let accentColor: Color
    var reduceMotion: Bool = false
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                HotWheelsTheme.trackBlack.opacity(isSelected ? 0.7 : 0.45),
                                accentColor.opacity(isSelected ? 0.22 : 0.08),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        isSelected ? accentColor : HotWheelsTheme.hotRed.opacity(0.55),
                        lineWidth: isSelected ? 3 : 2
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(
                                isSelected ? HotWheelsTheme.racingYellow : Color.clear,
                                lineWidth: 2
                            )
                            .padding(-3)
                    )
            )
            .scaleEffect(isSelected && !reduceMotion ? 1.02 : 1)
            .animation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.72), value: isSelected)
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

/// Full-width pill for run results and unlock celebrations.
struct HotWheelsAchievementBanner: View {
    enum Style {
        case unlock
        case record
    }

    let text: String
    var style: Style = .record

    private var fill: Color {
        switch style {
        case .unlock: HotWheelsTheme.electricBlue
        case .record: HotWheelsTheme.racingYellow
        }
    }

    private var foreground: Color {
        switch style {
        case .unlock: .white
        case .record: HotWheelsTheme.trackBlack
        }
    }

    private var systemImage: String {
        switch style {
        case .unlock: "map.fill"
        case .record: "star.fill"
        }
    }

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 12, weight: .black))
            Text(text)
                .font(HotWheelsTheme.captionFont.weight(.bold))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .foregroundStyle(foreground)
        .padding(.horizontal, 14)
        .padding(.vertical, 9)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Capsule(style: .continuous)
                .fill(fill)
                .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 2)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(text)
    }
}

struct HotWheelsEmptyMetricPlaceholder: View {
    let title: String
    let message: String
    var systemImage: String = "play.circle"

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white.opacity(0.5))
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(HotWheelsTheme.bodyFont)
                    .foregroundStyle(.white.opacity(0.85))
                Text(message)
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.65))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(HotWheelsTheme.trackBlack.opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(
                    Color.white.opacity(0.2),
                    style: StrokeStyle(lineWidth: 1.5, dash: [5, 4])
                )
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(message)")
    }
}

// MARK: - Form styling

struct HotWheelsFormSectionHeader: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(HotWheelsTheme.captionFont.weight(.bold))
            .foregroundStyle(HotWheelsTheme.racingYellow)
            .textCase(.uppercase)
            .tracking(0.4)
            .accessibilityAddTraits(.isHeader)
    }
}

struct HotWheelsFormPanel<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(HotWheelsTheme.trackBlack.opacity(0.48))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(HotWheelsTheme.hotRed.opacity(0.35), lineWidth: 1.5)
            )
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
}

struct HotWheelsFormValidationBanner: View {
    let message: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.body.weight(.bold))
                .foregroundStyle(HotWheelsTheme.racingYellow)
                .accessibilityHidden(true)

            Text(message)
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(HotWheelsTheme.hotRed.opacity(0.35))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(HotWheelsTheme.hotRed, lineWidth: 2)
        )
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .accessibilityLabel("Error: \(message)")
    }
}

extension View {
    func profileEditorSheetChrome(title: String, canSave: Bool, onCancel: @escaping () -> Void, onSave: @escaping () -> Void) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(HotWheelsTheme.trackBlack.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                        .font(HotWheelsTheme.bodyFont)
                        .foregroundStyle(.white)
                        .accessibilityHint("Close without saving")
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: onSave)
                        .font(HotWheelsTheme.bodyFont.weight(.bold))
                        .foregroundStyle(canSave ? HotWheelsTheme.racingYellow : .white.opacity(0.4))
                        .disabled(!canSave)
                        .accessibilityHint(canSave ? "Save profile changes" : "Enter a valid name to save")
                }
            }
    }
}

struct HotWheelsProminentIconButton: View {
    let systemImage: String
    let accessibilityLabel: String
    let accessibilityHint: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.title2.weight(.black))
                .foregroundStyle(HotWheelsTheme.trackBlack)
                .frame(width: 48, height: 48)
                .background(
                    Circle()
                        .fill(HotWheelsTheme.racingYellow)
                        .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 3)
                )
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.hotRed, lineWidth: 3)
                )
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }
}

#Preview("Components") {
    ScrollView {
        VStack(spacing: 20) {
            HotWheelsScreenHeader(
                eyebrow: "Garage",
                eyebrowSystemImage: "car.fill",
                title: "Choose Your Car",
                subtitle: "6 rides — tap one to claim it"
            ) {
                HotWheelsRacerChip(
                    profile: PlayerProfile(name: "Alex", age: 10, profileColorIndex: 13)
                )
            }

            HotWheelsToolbarRail(centerHint: "Swipe the lot below") {
                CourseMapToolbarButton(
                    systemImage: "chevron.left",
                    accessibilityLabel: "Back",
                    accessibilityHint: "Back",
                    action: {}
                )
            }

            HotWheelsSelectionCard(
                overline: "Your ride",
                title: "Volt Strike",
                detail: "Electric blue on the wire",
                systemImage: "checkmark.seal.fill",
                accentColor: HotWheelsTheme.electricBlue,
                accessibilityLabel: "Selected car Volt Strike"
            )

            HStack(spacing: 12) {
                HotWheelsStatPill(
                    systemImage: "ticket.fill",
                    value: "42",
                    title: "Tickets",
                    accent: HotWheelsTheme.flameOrange,
                    isEmphasized: true
                )
                HotWheelsStatPill(
                    systemImage: "flag.checkered",
                    value: "3/120",
                    title: "Courses",
                    accent: HotWheelsTheme.electricBlue,
                    isEmphasized: true
                )
            }

            HStack(spacing: 10) {
                HotWheelsMetricTile(
                    systemImage: "star.fill",
                    label: "Best time",
                    value: "0:42",
                    accent: HotWheelsTheme.racingYellow,
                    isFeatured: true
                )
                HotWheelsMetricTile(
                    systemImage: "ticket.fill",
                    label: "Tickets",
                    value: "3/3",
                    accent: HotWheelsTheme.flameOrange
                )
            }
        }
        .padding()
    }
    .background(HotWheelsTheme.backgroundGradient)
}
