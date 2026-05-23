//
//  ProfileSelectionView.swift
//  Tight Rope Car
//

import SwiftUI
import SwiftData

struct ProfileSelectionView: View {
    var onContinue: () -> Void = {}
    var onBack: () -> Void = {}

    @Environment(\.modelContext) private var modelContext
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Query(sort: \PlayerProfile.createdAt, order: .reverse) private var profiles: [PlayerProfile]

    @AppStorage(ProfileConstants.selectedProfileIDKey) private var selectedProfileID = ""

    @State private var showCreateProfile = false
    @State private var editingProfile: PlayerProfile?
    @State private var headerAppeared = false
    @State private var contentAppeared = false
    @State private var footerAppeared = false

    private var hasSelection: Bool {
        !selectedProfileID.isEmpty
    }

    private var selectedProfile: PlayerProfile? {
        guard let uuid = UUID(uuidString: selectedProfileID) else { return nil }
        return profiles.first { $0.id == uuid }
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : (reduceMotion ? 0 : 12))

            mainContent
                .opacity(contentAppeared ? 1 : 0)
                .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

            selectedRacerCard
                .padding(.top, 12)

            Spacer(minLength: 16)

            continueButton
                .opacity(footerAppeared ? 1 : 0)
                .offset(y: footerAppeared ? 0 : (reduceMotion ? 0 : 16))
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.top, 16)
        .padding(.bottom, 32)
        .hotWheelsContentWidth()
        .sheet(isPresented: $showCreateProfile) {
            CreateProfileView()
        }
        .sheet(item: $editingProfile) { profile in
            EditProfileView(profile: profile)
        }
        .onAppear(perform: runEntranceAnimation)
    }

    private var horizontalPadding: CGFloat {
        horizontalSizeClass == .regular ? 40 : 24
    }

    private var subtitleText: String {
        if profiles.isEmpty {
            return "Every champion needs a pit pass — create yours"
        }
        let count = profiles.count
        let racerWord = count == 1 ? "racer" : "racers"
        return "\(count) \(racerWord) on the grid — tap one to drive"
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            HotWheelsScreenHeader(
                eyebrow: "Pit Lane",
                eyebrowSystemImage: "person.2.fill",
                title: "Choose Your Racer",
                subtitle: subtitleText
            ) {
                HotWheelsProminentIconButton(
                    systemImage: "plus",
                    accessibilityLabel: "Add profile",
                    accessibilityHint: "Create a new racer profile",
                    action: { showCreateProfile = true }
                )
            }

            HotWheelsToolbarRail(centerHint: profiles.isEmpty ? nil : "Swipe a row to edit or delete") {
                CourseMapToolbarButton(
                    systemImage: "chevron.left",
                    accessibilityLabel: "Back",
                    accessibilityHint: "Return to main menu",
                    action: onBack
                )
            }

            if let selectedProfile {
                PlayerProgressStripView(profile: selectedProfile)
                    .transition(reduceMotion ? .opacity : .scale(scale: 0.96).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 12)
    }

    // MARK: - Content

    @ViewBuilder
    private var mainContent: some View {
        if profiles.isEmpty {
            emptyState
        } else {
            HotWheelsContentPanel(
                title: "Your Racers",
                trailingCaption: selectedProfile?.displayName,
                accessibilityLabel: "Profile list",
                accessibilityHint: "Double tap a profile to select it. Swipe for edit or delete."
            ) {
                profileList
            }
        }
    }

    private var emptyState: some View {
        HotWheelsContentPanel(
            title: "Get Started",
            accessibilityLabel: "No profiles yet",
            accessibilityHint: "Create your first racer profile"
        ) {
            VStack(spacing: 24) {
                ProfileEmptyStateIllustration()
                    .frame(
                        width: horizontalSizeClass == .regular ? 200 : 160,
                        height: horizontalSizeClass == .regular ? 200 : 160
                    )
                    .accessibilityHidden(true)

                Text("No Racers Yet")
                    .font(HotWheelsTheme.headlineFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

                Text("Add your name, age, pick a team color, and snap a selfie for the winner's circle.")
                    .font(HotWheelsTheme.bodyFont)
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)

                Button {
                    showCreateProfile = true
                } label: {
                    Label("Create Profile", systemImage: "plus.circle.fill")
                }
                .buttonStyle(HotWheelsAccentButtonStyle())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
        }
    }

    private var profileList: some View {
        List {
            ForEach(profiles) { profile in
                Button {
                    let animation: Animation? = reduceMotion
                        ? nil
                        : .spring(response: 0.32, dampingFraction: 0.72)
                    withAnimation(animation) {
                        selectedProfileID = profile.id.uuidString
                    }
                } label: {
                    ProfileRowView(
                        profile: profile,
                        isSelected: selectedProfileID == profile.id.uuidString
                    )
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .swipeActions(edge: .leading) {
                    Button {
                        editingProfile = profile
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(HotWheelsTheme.electricBlue)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        deleteProfile(profile)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .frame(minHeight: min(420, CGFloat(profiles.count) * 130 + 24))
    }

    @ViewBuilder
    private var selectedRacerCard: some View {
        if let profile = selectedProfile, hasSelection {
            HotWheelsSelectionCard(
                overline: "Selected racer",
                title: profile.displayName,
                detail: "Age \(profile.age) · ready for the garage",
                detailColor: profile.profileColor,
                systemImage: "person.crop.circle.badge.checkmark",
                accentColor: profile.profileColor,
                accessibilityLabel: "Selected racer \(profile.displayName), age \(profile.age)"
            )
            .transition(reduceMotion ? .opacity : .move(edge: .bottom).combined(with: .opacity))
        }
    }

    // MARK: - Continue

    private var continueButton: some View {
        Button {
            onContinue()
        } label: {
            Label(
                hasSelection ? "Continue to Garage" : "Select a Racer",
                systemImage: hasSelection ? "car.fill" : "hand.tap.fill"
            )
        }
        .buttonStyle(HotWheelsAccentButtonStyle(
            fillColor: hasSelection ? HotWheelsTheme.racingYellow : HotWheelsTheme.racingYellow.opacity(0.35),
            strokeColor: hasSelection ? HotWheelsTheme.hotRed : HotWheelsTheme.hotRed.opacity(0.35)
        ))
        .disabled(!hasSelection)
        .accessibilityLabel(hasSelection ? "Continue to garage" : "Select a racer")
        .accessibilityHint(hasSelection ? "Continue to car selection" : "Select a profile first")
    }

    // MARK: - Actions

    private func deleteProfile(_ profile: PlayerProfile) {
        if selectedProfileID == profile.id.uuidString {
            selectedProfileID = ""
        }
        modelContext.delete(profile)
    }

    private func runEntranceAnimation() {
        if reduceMotion {
            headerAppeared = true
            contentAppeared = true
            footerAppeared = true
            return
        }

        withAnimation(.easeOut(duration: 0.4)) {
            headerAppeared = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeOut(duration: 0.45)) {
                contentAppeared = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeOut(duration: 0.45)) {
                footerAppeared = true
            }
        }
    }
}

// MARK: - Empty state art (SwiftUI shapes)

private struct ProfileEmptyStateIllustration: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(HotWheelsTheme.racingYellow.opacity(0.25))
                .frame(width: 140, height: 140)
                .offset(y: 8)

            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.electricBlue, HotWheelsTheme.electricBlue.opacity(0.75)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 100, height: 72)
                .offset(y: 36)
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .strokeBorder(HotWheelsTheme.trackBlack, lineWidth: 3)
                        .frame(width: 100, height: 72)
                        .offset(y: 36)
                )

            Circle()
                .fill(
                    LinearGradient(
                        colors: [HotWheelsTheme.racingYellow, HotWheelsTheme.flameOrange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 72, height: 72)
                .offset(y: -28)
                .overlay(
                    Circle()
                        .strokeBorder(HotWheelsTheme.trackBlack, lineWidth: 3)
                        .frame(width: 72, height: 72)
                        .offset(y: -28)
                )

            Capsule()
                .fill(HotWheelsTheme.hotRed)
                .frame(width: 88, height: 28)
                .offset(y: -52)
                .overlay(
                    Capsule()
                        .strokeBorder(HotWheelsTheme.trackBlack, lineWidth: 2)
                        .frame(width: 88, height: 28)
                        .offset(y: -52)
                )

            Image(systemName: "plus")
                .font(.system(size: 28, weight: .black))
                .foregroundStyle(HotWheelsTheme.hotRed)
                .offset(x: 52, y: 44)
                .background(
                    Circle()
                        .fill(HotWheelsTheme.racingYellow)
                        .frame(width: 44, height: 44)
                        .overlay(Circle().strokeBorder(HotWheelsTheme.trackBlack, lineWidth: 2))
                        .offset(x: 52, y: 44)
                )
        }
        .hotWheelsTitleShadow()
    }
}

#Preview("Empty") {
    ZStack {
        RacingStripeBackground()
        ProfileSelectionView()
    }
    .modelContainer(for: PlayerProfile.self, inMemory: true)
}

#Preview("With profiles") {
    let container = try! ModelContainer(
        for: PlayerProfile.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    context.insert(PlayerProfile(name: "Alex", age: 10, totalTickets: 12))
    context.insert(PlayerProfile(name: "Jordan", age: 12))

    return ZStack {
        RacingStripeBackground()
        ProfileSelectionView()
    }
    .modelContainer(container)
}

#Preview("Pit lane — iPad width") {
    let container = try! ModelContainer(
        for: PlayerProfile.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let context = container.mainContext
    context.insert(PlayerProfile(name: "Riley", age: 9, totalTickets: 5))

    return ZStack {
        RacingStripeBackground()
        ProfileSelectionView()
    }
    .modelContainer(container)
    .environment(\.horizontalSizeClass, .regular)
}
