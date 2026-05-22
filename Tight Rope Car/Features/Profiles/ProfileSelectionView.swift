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
    @State private var headerAppeared = false
    @State private var contentAppeared = false
    @State private var footerAppeared = false

    private var hasSelection: Bool {
        !selectedProfileID.isEmpty
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : (reduceMotion ? 0 : 12))

            Group {
                if profiles.isEmpty {
                    emptyState
                } else {
                    profileList
                }
            }
            .opacity(contentAppeared ? 1 : 0)
            .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

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
        .onAppear(perform: runEntranceAnimation)
    }

    private var horizontalPadding: CGFloat {
        horizontalSizeClass == .regular ? 40 : 24
    }

    // MARK: - Header

    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            CourseMapToolbarButton(
                systemImage: "chevron.left",
                accessibilityLabel: "Back",
                accessibilityHint: "Return to main menu"
            ) {
                onBack()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Choose Your Racer")
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

                Text(profiles.isEmpty ? "Create a profile to get started" : "Tap a profile to select it")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.9))
            }

            Spacer()

            Button {
                showCreateProfile = true
            } label: {
                Image(systemName: "plus")
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
            .accessibilityLabel("Add profile")
        }
        .padding(.bottom, 20)
    }

    // MARK: - Empty state

    private var emptyState: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 24)

            Image(systemName: "person.crop.circle.badge.plus")
                .font(.system(size: 72, weight: .bold))
                .foregroundStyle(HotWheelsTheme.racingYellow)
                .hotWheelsTitleShadow()

            Text("No Profiles Yet")
                .font(HotWheelsTheme.headlineFont)
                .foregroundStyle(.white)
                .hotWheelsTitleShadow()

            Text("Create a profile with your name, age, and an optional selfie.")
                .font(HotWheelsTheme.bodyFont)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)

            Button {
                showCreateProfile = true
            } label: {
                Text("Create Profile")
            }
            .buttonStyle(HotWheelsAccentButtonStyle())

            Spacer(minLength: 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Profile list

    private var profileList: some View {
        List {
            ForEach(profiles) { profile in
                Button {
                    selectedProfileID = profile.id.uuidString
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
        .background(Color.clear)
    }

    // MARK: - Continue

    private var continueButton: some View {
        Button {
            onContinue()
        } label: {
            Text("Continue")
        }
        .buttonStyle(HotWheelsAccentButtonStyle(
            fillColor: hasSelection ? HotWheelsTheme.racingYellow : HotWheelsTheme.racingYellow.opacity(0.35),
            strokeColor: hasSelection ? HotWheelsTheme.hotRed : HotWheelsTheme.hotRed.opacity(0.35)
        ))
        .disabled(!hasSelection)
        .accessibilityLabel("Continue")
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
    context.insert(PlayerProfile(name: "Alex", age: 10))
    context.insert(PlayerProfile(name: "Jordan", age: 12))

    return ZStack {
        RacingStripeBackground()
        ProfileSelectionView()
    }
    .modelContainer(container)
}
