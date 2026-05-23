//
//  CourseSelectionView.swift
//  Tight Rope Car
//

import SwiftData
import SwiftUI

struct CourseSelectionView: View {
    var onBack: () -> Void = {}
    var onGoHome: () -> Void = {}
    var onPlayCourse: (String) -> Void = { _ in }

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

    private var shareExport: ProgressShareExport? {
        guard let profile = activeProfile else { return nil }
        return ProgressShareBuilder.makeExport(
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

    private var selectedCourseState: CourseMapNodeState? {
        guard !selectedCourseID.isEmpty else { return nil }
        return nodeStates[selectedCourseID]
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(headerAppeared ? 1 : 0)
                .offset(y: headerAppeared ? 0 : (reduceMotion ? 0 : 12))

            mapSection
                .opacity(contentAppeared ? 1 : 0)
                .scaleEffect(contentAppeared ? 1 : (reduceMotion ? 1 : 0.96))

            selectedCourseCard
                .padding(.top, 12)

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
        VStack(alignment: .leading, spacing: 14) {
            HotWheelsScreenHeader(
                eyebrow: "Track Map",
                eyebrowSystemImage: "map.fill",
                title: "Pick Your Course",
                subtitle: headerSubtitle
            ) {
                if let profile = activeProfile {
                    HotWheelsRacerChip(profile: profile)
                }
            }

            HotWheelsToolbarRail {
                HStack(spacing: 8) {
                    CourseMapToolbarButton(
                        systemImage: "chevron.left",
                        accessibilityLabel: "Back",
                        accessibilityHint: "Return to car selection",
                        action: onBack
                    )

                    CourseMapToolbarButton(
                        systemImage: "house.fill",
                        accessibilityLabel: "Main menu",
                        accessibilityHint: "Return to the landing screen",
                        action: { showGoHomeConfirmation = true }
                    )
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Navigation")
            } trailing: {
                HStack(spacing: 8) {
                    CourseMapToolbarButton(
                        systemImage: "trophy.fill",
                        accessibilityLabel: "High scores",
                        accessibilityHint: "View best times and distances for this profile",
                        style: .accent,
                        isEnabled: activeProfile != nil,
                        action: { showHighScores = true }
                    )

                    shareControl
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Map actions")
            }

            if let profile = activeProfile {
                PlayerProgressStripView(profile: profile)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 12)
    }

    private var headerSubtitle: String {
        guard let profile = activeProfile else {
            return "Scroll the map · tap an open node · play below"
        }
        return progressSubtitle(for: profile)
    }

    @ViewBuilder
    private var shareControl: some View {
        if let shareExport {
            ShareLink(
                item: shareExport,
                preview: SharePreview("Tight Rope Car progress", image: Image(systemName: "map.fill"))
            ) {
                CourseMapToolbarIcon(systemImage: "square.and.arrow.up")
            }
            .accessibilityLabel("Share progress")
            .accessibilityHint("Share progress summary, course IDs, and a JSON backup file")
        } else {
            CourseMapToolbarIcon(systemImage: "square.and.arrow.up", isEnabled: false)
                .accessibilityLabel("Share progress")
                .accessibilityHint("Select a profile to share progress")
                .accessibilityAddTraits(.isButton)
                .allowsHitTesting(false)
        }
    }

    // MARK: - Map

    private var mapSection: some View {
        HotWheelsContentPanel(
            title: "Rope Road",
            trailingCaption: "Pinch & drag to explore",
            trailingCaptionColor: .white.opacity(0.55),
            accessibilityLabel: "Course map",
            accessibilityHint: "Scroll to explore tracks. Double tap an unlocked node to select it."
        ) {
            mapScroll
        }
    }

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
        .scrollIndicatorsFlash(onAppear: false)
        .frame(maxHeight: horizontalSizeClass == .regular ? 620 : 480)
    }

    @ViewBuilder
    private var selectedCourseCard: some View {
        if let course = CourseCatalog.course(id: selectedCourseID),
           let state = selectedCourseState,
           hasPlayableSelection {
            HotWheelsSelectionCard(
                overline: "Ready to race",
                title: course.displayName,
                detail: selectionStatusText(state: state),
                detailColor: selectionStatusColor(state: state),
                systemImage: "flag.checkered.circle.fill",
                accentColor: HotWheelsTheme.hotRed,
                accessibilityLabel: "Selected track \(course.displayName), \(selectionStatusText(state: state))"
            )
            .transition(reduceMotion ? .opacity : .move(edge: .bottom).combined(with: .opacity))
        }
    }

    // MARK: - Play

    private var playButton: some View {
        Button {
            onPlayCourse(selectedCourseID)
        } label: {
            Label(
                hasPlayableSelection ? "Play Track" : "Select a Track",
                systemImage: hasPlayableSelection ? "play.fill" : "hand.tap.fill"
            )
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
        .accessibilityLabel(hasPlayableSelection ? "Play track" : "Select a track")
        .accessibilityHint(
            hasPlayableSelection
                ? "Start the selected course"
                : "Select an unlocked course on the map first"
        )
    }

    private func selectionStatusText(state: CourseMapNodeState) -> String {
        switch state {
        case .beaten:
            return "Track cleared — race again for a better run"
        case .available:
            return "Open track — tap Play when you're ready"
        case .locked:
            return "Locked"
        }
    }

    private func selectionStatusColor(state: CourseMapNodeState) -> Color {
        switch state {
        case .beaten:
            return HotWheelsTheme.racingYellow
        case .available:
            return HotWheelsTheme.electricBlue.opacity(0.95)
        case .locked:
            return .white.opacity(0.6)
        }
    }

    private func progressSubtitle(for profile: PlayerProfile) -> String {
        let completed = PlayerProgressMetrics.completedMapCourseCount(for: profile)
        let total = PlayerProgressMetrics.mapCourseCount
        if profile.totalTickets > 0 || completed > 0 {
            return "\(profile.totalTickets) tickets · \(completed)/\(total) tracks cleared"
        }
        return "Scroll the map · tap an open node · play below"
    }

    // MARK: - Actions

    private func selectCourse(_ courseID: String) {
        guard let state = nodeStates[courseID], state != .locked else { return }
        let animation: Animation? = reduceMotion
            ? nil
            : .spring(response: 0.32, dampingFraction: 0.78)
        withAnimation(animation) {
            selectedCourseID = courseID
        }
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
        completedCourseIDs: ["tutorial", "bumps", "narrowWire"],
        totalTickets: 18
    )
    container.mainContext.insert(profile)
    UserDefaults.standard.set(profile.id.uuidString, forKey: ProfileConstants.selectedProfileIDKey)

    return ZStack {
        RacingStripeBackground()
        CourseSelectionView()
    }
    .modelContainer(container)
}

#Preview("Shell — iPad width") {
    let container = try! ModelContainer(
        for: PlayerProfile.self, CourseHighScore.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(name: "Jordan", age: 12, totalTickets: 9)
    container.mainContext.insert(profile)
    UserDefaults.standard.set(profile.id.uuidString, forKey: ProfileConstants.selectedProfileIDKey)

    return ZStack {
        RacingStripeBackground()
        CourseSelectionView()
    }
    .modelContainer(container)
    .environment(\.horizontalSizeClass, .regular)
}
