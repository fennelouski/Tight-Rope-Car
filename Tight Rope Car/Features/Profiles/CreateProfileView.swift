//
//  CreateProfileView.swift
//  Tight Rope Car
//

import SwiftUI
import SwiftData

struct CreateProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var age = ProfileConstants.defaultAge
    @State private var avatarImage: UIImage?
    @State private var showCamera = false
    @State private var showCameraUnavailableAlert = false
    @State private var validationMessage: String?

    private var canSave: Bool {
        ProfileValidator.validate(name: name, age: age) == nil
    }

    var body: some View {
        NavigationStack {
            ZStack {
                HotWheelsTheme.backgroundGradient
                    .ignoresSafeArea()

                Form {
                    Section {
                        HStack {
                            Spacer()
                            Button {
                                openCamera()
                            } label: {
                                ZStack(alignment: .bottomTrailing) {
                                    if let avatarImage {
                                        ProfileAvatarView(
                                            avatarJPEGData: ProfileImageProcessor.jpegData(from: avatarImage),
                                            size: 120
                                        )
                                    } else {
                                        ProfileAvatarView(avatarJPEGData: nil, size: 120)
                                    }

                                    Image(systemName: "camera.fill")
                                        .font(.caption.weight(.bold))
                                        .padding(8)
                                        .background(Circle().fill(HotWheelsTheme.hotRed))
                                        .foregroundStyle(.white)
                                }
                            }
                            .buttonStyle(.plain)
                            Spacer()
                        }
                        .listRowBackground(Color.clear)

                        Text("Tap to take a selfie (optional)")
                            .font(HotWheelsTheme.captionFont)
                            .foregroundStyle(.white.opacity(0.85))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowBackground(Color.clear)
                    }

                    Section {
                        TextField("Name", text: $name)
                            .font(HotWheelsTheme.bodyFont)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .onChange(of: name) { _, newValue in
                                if newValue.count > ProfileConstants.maxNameLength {
                                    name = String(newValue.prefix(ProfileConstants.maxNameLength))
                                }
                            }
                    } header: {
                        Text("Your name")
                            .font(HotWheelsTheme.captionFont)
                            .foregroundStyle(HotWheelsTheme.racingYellow)
                    }

                    Section {
                        Picker("Age", selection: $age) {
                            ForEach(ProfileConstants.minAge...ProfileConstants.maxAge, id: \.self) { value in
                                Text("\(value)").tag(value)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 150)
                    } header: {
                        Text("Your age")
                            .font(HotWheelsTheme.captionFont)
                            .foregroundStyle(HotWheelsTheme.racingYellow)
                    }

                    if let validationMessage {
                        Section {
                            Text(validationMessage)
                                .font(HotWheelsTheme.captionFont)
                                .foregroundStyle(HotWheelsTheme.hotRed)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("New Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(HotWheelsTheme.trackBlack.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(HotWheelsTheme.bodyFont)
                    .foregroundStyle(.white)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveProfile()
                    }
                    .font(HotWheelsTheme.bodyFont.weight(.bold))
                    .foregroundStyle(canSave ? HotWheelsTheme.racingYellow : .white.opacity(0.4))
                    .disabled(!canSave)
                }
            }
            .sheet(isPresented: $showCamera) {
                CameraImagePicker(image: $avatarImage)
            }
            .alert("Camera Not Available", isPresented: $showCameraUnavailableAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Use a physical iPhone or iPad to take a profile selfie. The simulator does not have a camera.")
            }
        }
    }

    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showCameraUnavailableAlert = true
            return
        }
        showCamera = true
    }

    private func saveProfile() {
        if let error = ProfileValidator.validate(name: name, age: age) {
            validationMessage = message(for: error)
            return
        }

        let avatarData = avatarImage.flatMap { ProfileImageProcessor.jpegData(from: $0) }
        let profile = PlayerProfile(
            name: ProfileValidator.sanitizedName(name),
            age: age,
            avatarJPEGData: avatarData
        )
        modelContext.insert(profile)
        do {
            try modelContext.save()
            dismiss()
        } catch {
            validationMessage = "Could not save profile. Please try again."
        }
    }

    private func message(for error: ProfileValidationError) -> String {
        switch error {
        case .emptyName:
            return "Please enter a name."
        case .nameTooLong:
            return "Name is too long."
        case .ageOutOfRange:
            return "Please choose a valid age."
        }
    }
}

#Preview {
    CreateProfileView()
        .modelContainer(for: PlayerProfile.self, inMemory: true)
}
