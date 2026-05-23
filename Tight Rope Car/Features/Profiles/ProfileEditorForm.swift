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

    private var nameCharacterCount: Int {
        name.count
    }

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
                        TextField("Racer name", text: $name)
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

                        HStack {
                            Text("Letters and spaces only")
                                .font(.system(size: 11, weight: .medium, design: .rounded))
                                .foregroundStyle(.white.opacity(0.55))
                            Spacer()
                            Text("\(nameCharacterCount)/\(ProfileConstants.maxNameLength)")
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    nameCharacterCount >= ProfileConstants.maxNameLength
                                        ? HotWheelsTheme.racingYellow
                                        : .white.opacity(0.65)
                                )
                                .accessibilityLabel("\(nameCharacterCount) of \(ProfileConstants.maxNameLength) characters")
                        }
                    }
                }
            } header: {
                HotWheelsFormSectionHeader("Your name")
            }

            Section {
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
            } header: {
                HotWheelsFormSectionHeader("Your age")
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
        VStack(spacing: 12) {
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

            Text(cameraHint)
                .font(HotWheelsTheme.captionFont)
                .foregroundStyle(.white.opacity(0.85))
                .multilineTextAlignment(.center)
        }
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
