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
    @State private var selectedColorIndex = ProfileConstants.defaultProfileColorIndex
    @State private var avatarImage: UIImage?
    @State private var showCamera = false
    @State private var showCameraUnavailableAlert = false
    @State private var validationMessage: String?

    private var canSave: Bool {
        ProfileValidator.validate(name: name, age: age) == nil
    }

    private var previewAvatarData: Data? {
        avatarImage.flatMap { ProfileImageProcessor.jpegData(from: $0) }
    }

    var body: some View {
        NavigationStack {
            ProfileEditorForm(
                name: $name,
                age: $age,
                selectedColorIndex: $selectedColorIndex,
                previewAvatarData: previewAvatarData,
                cameraHint: "Tap to take a selfie (optional)",
                validationMessage: validationMessage,
                onCameraTap: openCamera
            )
            .profileEditorSheetChrome(
                title: "New Profile",
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
        .hotWheelsSheetBackground()
        .hotWheelsSafeAreaPolicy()
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
        let avatarData = previewAvatarData
        let profile = PlayerProfile(
            name: ProfileValidator.sanitizedName(name),
            age: age,
            avatarJPEGData: avatarData,
            profileColorIndex: selectedColorIndex
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
