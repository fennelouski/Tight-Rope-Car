//
//  EditProfileView.swift
//  Tight Rope Car
//

import SwiftUI
import SwiftData

struct EditProfileView: View {
    @Bindable var profile: PlayerProfile
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var age: Int
    @State private var selectedColorIndex: Int
    @State private var avatarImage: UIImage?
    @State private var showCamera = false
    @State private var showCameraUnavailableAlert = false
    @State private var validationMessage: String?

    init(profile: PlayerProfile) {
        self.profile = profile
        self._name = State(initialValue: profile.name)
        self._age = State(initialValue: profile.age)
        self._selectedColorIndex = State(initialValue: profile.profileColorIndex)
    }

    private var canSave: Bool {
        ProfileValidator.validate(name: name, age: age) == nil
    }

    private var previewAvatarData: Data? {
        if let avatarImage {
            return ProfileImageProcessor.jpegData(from: avatarImage)
        }
        return profile.avatarJPEGData
    }

    var body: some View {
        NavigationStack {
            ZStack {
                HotWheelsTheme.backgroundGradient
                    .ignoresSafeArea()

                ProfileEditorForm(
                    name: $name,
                    age: $age,
                    selectedColorIndex: $selectedColorIndex,
                    previewAvatarData: previewAvatarData,
                    cameraHint: "Tap to change photo (optional)",
                    validationMessage: validationMessage,
                    onCameraTap: openCamera
                )
            }
            .profileEditorSheetChrome(
                title: "Edit Profile",
                canSave: canSave,
                onCancel: { dismiss() },
                onSave: saveProfile
            )
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

        validationMessage = nil
        profile.name = ProfileValidator.sanitizedName(name)
        profile.age = age
        profile.profileColorIndex = selectedColorIndex
        if let avatarImage, let data = ProfileImageProcessor.jpegData(from: avatarImage) {
            profile.avatarJPEGData = data
        }
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
    let container = try! ModelContainer(
        for: PlayerProfile.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    let profile = PlayerProfile(name: "Speed Racer", age: 9, profileColorIndex: 13)
    container.mainContext.insert(profile)

    return EditProfileView(profile: profile)
        .modelContainer(container)
}
