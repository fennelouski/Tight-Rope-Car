//
//  CourseSelectionView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

struct CourseSelectionView: View {
    var onBack: () -> Void = {}
    var onGoHome: () -> Void = {}

    @Environment(\.modelContext) private var modelContext
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Query(sort: \PlayerProfile.createdAt, order: .reverse) private var profiles: [PlayerProfile]

    @AppStorage(ProfileConstants.selectedProfileIDKey) private var selectedProfileID = ""

    @State private var selectedCourseID = ""
    @State private var headerAppeared = false
    @State private var contentAppeared = false
    @State private var footerAppeared = false
    @State private var showHighScores = false
    @State private var showGoHomeConfirmation = false

    private var activeProfile: PlayerProfile? {
        guard let uuid = UUID(uuidString: selectedProfileID) else { return nil }
        return profiles.first { $0.id == uuid }
    }

    private var scoresByCourseID: [String: CourseHighScore] {
        guard let profile = activeProfile else { return [:] }
        return CourseScoreStore.scoresByCourseID(for: profile)
    }

    private var shareText: String {
        guard let profile = activeProfile else {
            return "Tight Rope Car — pick a profile to share progress."
        }
        return ProgressShareBuilder.shareText(
            profile: profile,
            scoresByCourseID: scoresByCourseID
        )
    }

    private var completedSet: Set<String> {
        CourseProgressStore.completedSet(for: activeProfile)
    }

    private var nodeStates: [String: CourseMapNodeState] {
        CourseUnlockEvaluator.nodeStates(completedCourseIDs: completedSet)
    }

    private var hasPlayableSelection: Bool {
        guard !selectedCourseID.isEmpty,
              let state = nodeStates[selectedCourseID]
        else { return false }
        return state == .available || state == .beaten
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : (reduceMotion ? 0 : 12))

            mapScroll
                .opacity(contentAppeared ? 1 : 0)
                .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

            selectedCourseCaption

            Spacer(minLength: 12)

            playButton
                .opacity(footerAppeared ? 1 : 0)
                .offset(y: footerAppeared ? 0 : (reduceMotion ? 0 : 16))
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.top, 16)
        .padding(.bottom, 32)
        .hotWheelsContentWidth()
        .sheet(isPresented: $showHighScores) {
            if let profile = activeProfile {
                HighScoresView(
                    profile: profile,
                    scoresByCourseID: scoresByCourseID
                )
            }
        }
        .alert("Return to main menu?", isPresented: $showGoHomeConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Main Menu", role: .destructive) {
                onGoHome()
            }
        } message: {
            Text("Your profiles and progress stay saved on this device.")
        }
        .onAppear {
            selectDefaultCourseIfNeeded()
            runEntranceAnimation()
        }
        .onChange(of: selectedProfileID) { _, _ in
            selectedCourseID = ""
            selectDefaultCourseIfNeeded()
        }
        .onChange(of: activeProfile?.completedCourseIDs.count) { _, _ in
            pruneSelectionIfLocked()
        }
    }

    private var horizontalPadding: CGFloat {
        horizontalSizeClass == .regular ? 40 : 24
    }

    // MARK: - Header

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                CourseMapToolbarButton(
                    systemImage: "chevron.left",
                    accessibilityLabel: "Back",
                    accessibilityHint: "Return to car selection"
                ) {
                    onBack()
                }

                CourseMapToolbarButton(
                    systemImage: "house.fill",
                    accessibilityLabel: "Main menu",
                    accessibilityHint: "Return to the landing screen"
                ) {
                    showGoHomeConfirmation = true
                }

                Spacer(minLength: 0)

                CourseMapToolbarButton(
                    systemImage: "trophy.fill",
                    accessibilityLabel: "High scores",
                    accessibilityHint: "View best times and distances for this profile"
                ) {
                    showHighScores = true
                }
                .disabled(activeProfile == nil)

                if activeProfile != nil {
                    ShareLink(item: shareText) {
                        toolbarShareLabel
                    }
                    .accessibilityLabel("Share progress")
                    .accessibilityHint("Share this profile's course progress and high scores")
                } else {
                    toolbarShareLabel
                        .opacity(0.4)
                        .accessibilityLabel("Share progress")
                        .accessibilityHint("Select a profile to share progress")
                        .accessibilityAddTraits(.isButton)
                        .allowsHitTesting(false)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Pick Your Course")
                    .font(HotWheelsTheme.sectionTitleFont)
                    .foregroundStyle(.white)
                    .hotWheelsTitleShadow()

                Text("Follow the rope road — beat levels to open new paths")
                    .font(HotWheelsTheme.captionFont)
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 16)
    }

    private var toolbarShareLabel: some View {
        Image(systemName: "square.and.arrow.up")
            .font(.body.weight(.black))
            .foregroundStyle(HotWheelsTheme.trackBlack)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .fill(HotWheelsTheme.racingYellow)
                    .shadow(color: HotWheelsTheme.trackBlack.opacity(0.35), radius: 0, x: 0, y: 2)
            )
            .overlay(
                Circle()
                    .strokeBorder(HotWheelsTheme.hotRed, lineWidth: 2)
            )
    }

    // MARK: - Map

    private var mapScroll: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            CourseMapCanvasView(
                nodeStates: nodeStates,
                selectedCourseID: selectedCourseID.isEmpty ? nil : selectedCourseID,
                onSelect: selectCourse,
                onMarkComplete: markCompleteForTesting
            )
            .padding(20)
        }
        .frame(maxHeight: horizontalSizeClass == .regular ? 620 : 480)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.black.opacity(0.15))
        )
    }

    @ViewBuilder
    private var selectedCourseCaption: some View {
        if let course = CourseCatalog.course(id: selectedCourseID),
           hasPlayableSelection {
            Text(course.displayName)
                .font(HotWheelsTheme.headlineFont)
                .foregroundStyle(HotWheelsTheme.racingYellow)
                .padding(.top, 12)
                .transition(.opacity)
        }
    }

    // MARK: - Play

    private var playButton: some View {
        Button {
            // Gameplay scene coming later
        } label: {
            Text("Play")
        }
        .buttonStyle(HotWheelsAccentButtonStyle(
            fillColor: hasPlayableSelection
                ? HotWheelsTheme.racingYellow
                : HotWheelsTheme.racingYellow.opacity(0.35),
            strokeColor: hasPlayableSelection
                ? HotWheelsTheme.hotRed
                : HotWheelsTheme.hotRed.opacity(0.35)
        ))
        .disabled(!hasPlayableSelection)
        .accessibilityLabel("Play")
        .accessibilityHint(
            hasPlayableSelection
                ? "Start the selected course when gameplay is available"
                : "Select an unlocked course first"
        )
    }

    // MARK: - Actions

    private func selectCourse(_ courseID: String) {
        guard let state = nodeStates[courseID], state != .locked else { return }
        selectedCourseID = courseID
    }

    private func markCompleteForTesting(_ courseID: String) {
        guard let profile = activeProfile else { return }
        try? CourseProgressStore.markCompleted(
            courseID: courseID,
            for: profile,
            context: modelContext
        )
    }

    private func selectDefaultCourseIfNeeded() {
        guard selectedCourseID.isEmpty else { return }
        if let firstAvailable = CourseMapCatalog.nodes.first(where: {
            nodeStates[$0.courseID] == .available
        }) {
            selectedCourseID = firstAvailable.courseID
        }
    }

    private func pruneSelectionIfLocked() {
        guard !selectedCourseID.isEmpty,
              nodeStates[selectedCourseID] == .locked
        else { return }
        selectedCourseID = ""
        selectDefaultCourseIfNeeded()
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

#Preview("Tutorial only") {
    ZStack {
        RacingStripeBackground()
        CourseSelectionView()
    }
    .modelContainer(for: [PlayerProfile.self, CourseHighScore.self], inMemory: true)
}

#Preview("Branch unlocked") {
    let container = try! ModelContainer(
        for: PlayerProfile.self, CourseHighScore.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(
        name: "Riley",
        age: 10,
        completedCourseIDs: ["tutorial", "bumps", "narrowWire"]
    )
    container.mainContext.insert(profile)
    UserDefaults.standard.set(profile.id.uuidString, forKey: ProfileConstants.selectedProfileIDKey)

    return ZStack {
        RacingStripeBackground()
        CourseSelectionView()
    }
    .modelContainer(container)
}
