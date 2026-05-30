//
//  ProfileEditorForm.swift
//  Tight Rope Car
//

import SwiftUI

/// Shared create/edit profile fields — camera row, name, age, color, validation.
struct ProfileEditorForm: View {
    @Binding var name: String
    @Binding var age: Int
    @Binding var selectedColorIndex: Int

    let previewAvatarData: Data?
    let cameraHint: String
    let validationMessage: String?
    let onCameraTap: () -> Void

    @FocusState private var isNameFocused: Bool
    @State private var isAgeExpanded = false

    var body: some View {
        Form {
            Section {
                cameraRow
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)

            Section {
                HotWheelsFormPanel {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("", text: $name, prompt: Text("Racer name").foregroundColor(.white.opacity(0.75)))
                            .font(HotWheelsTheme.bodyFont)
                            .foregroundStyle(.white)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .submitLabel(.done)
                            .focused($isNameFocused)
                            .onChange(of: name) { _, newValue in
                                if newValue.count > ProfileConstants.maxNameLength {
                                    name = String(newValue.prefix(ProfileConstants.maxNameLength))
                                }
                            }
                            .accessibilityLabel("Racer name")
                            .accessibilityHint("Enter the name shown on your profile")
                    }
                }
            } header: {
                HotWheelsFormSectionHeader("Your name")
            }

            Section {
                if isAgeExpanded {
                    HotWheelsFormPanel {
                        Picker("Age", selection: $age) {
                            ForEach(ProfileConstants.minAge...ProfileConstants.maxAge, id: \.self) { value in
                                Text("\(value)").tag(value)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 150)
                        .accessibilityLabel("Age")
                        .accessibilityHint("Swipe to choose your age")
                    }
                }
            } header: {
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isAgeExpanded.toggle()
                    }
                } label: {
                    HStack(spacing: 6) {
                        Text("Your age")
                            .font(HotWheelsTheme.captionFont.weight(.bold))
                            .foregroundStyle(HotWheelsTheme.racingYellow)
                            .textCase(.uppercase)
                            .tracking(0.4)
                        if !isAgeExpanded {
                            Text("·")
                                .foregroundStyle(HotWheelsTheme.racingYellow.opacity(0.6))
                                .font(HotWheelsTheme.captionFont)
                            Text("\(age)")
                                .font(HotWheelsTheme.captionFont.weight(.bold))
                                .foregroundStyle(HotWheelsTheme.racingYellow)
                        }
                        Spacer()
                        Image(systemName: isAgeExpanded ? "chevron.up" : "chevron.down")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(HotWheelsTheme.racingYellow.opacity(0.8))
                    }
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Your age, \(age). \(isAgeExpanded ? "Collapse" : "Expand")")
                .accessibilityAddTraits(.isHeader)
            }

            Section {
                HotWheelsFormPanel {
                    ProfileColorPickerView(selectedIndex: $selectedColorIndex)
                        .padding(.vertical, 4)
                }
            } header: {
                HotWheelsFormSectionHeader("Team color")
            }

            if let validationMessage {
                Section {
                    HotWheelsFormValidationBanner(message: validationMessage)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .scrollDismissesKeyboard(.interactively)
    }

    private var cameraRow: some View {
        Button(action: onCameraTap) {
            ZStack(alignment: .bottomTrailing) {
                ProfileAvatarView(
                    avatarJPEGData: previewAvatarData,
                    size: 120,
                    borderColor: PlayerColorPalette.color(at: selectedColorIndex),
                    isHighlighted: true
                )

                Image(systemName: "camera.fill")
                    .font(.caption.weight(.bold))
                    .padding(8)
                    .background(
                        Circle()
                            .fill(HotWheelsTheme.hotRed)
                            .overlay(Circle().strokeBorder(.white.opacity(0.85), lineWidth: 1.5))
                    )
                    .foregroundStyle(.white)
                    .offset(x: 4, y: 4)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Profile photo")
        .accessibilityHint(cameraHint)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationStack {
        ZStack {
            HotWheelsTheme.backgroundGradient.ignoresSafeArea()
            ProfileEditorForm(
                name: .constant("Alex"),
                age: .constant(10),
                selectedColorIndex: .constant(13),
                previewAvatarData: nil,
                cameraHint: "Tap to take a selfie (optional)",
                validationMessage: "Please enter a name.",
                onCameraTap: {}
            )
        }
        .navigationTitle("New Profile")
    }
}
