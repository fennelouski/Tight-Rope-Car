//
//  ProfileValidator.swift
//  Tight Rope Car
//

import Foundation

enum ProfileValidationError: Equatable {
    case emptyName
    case nameTooLong
    case ageOutOfRange
}

struct ProfileValidator {
    static func validate(name: String, age: Int) -> ProfileValidationError? {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return .emptyName
        }
        if trimmed.count > ProfileConstants.maxNameLength {
            return .nameTooLong
        }
        if age < ProfileConstants.minAge || age > ProfileConstants.maxAge {
            return .ageOutOfRange
        }
        return nil
    }

    static func sanitizedName(_ name: String) -> String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return String(trimmed.prefix(ProfileConstants.maxNameLength))
    }
}
