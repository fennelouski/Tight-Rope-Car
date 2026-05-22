//
//  ProfileImageProcessor.swift
//  Tight Rope Car
//

import UIKit

enum ProfileImageProcessor {
    static func jpegData(from image: UIImage) -> Data? {
        let scaled = scaledImage(image, maxDimension: ProfileConstants.avatarMaxDimension)
        return scaled.jpegData(compressionQuality: ProfileConstants.avatarJPEGQuality)
    }

    private static func scaledImage(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        let size = image.size
        let longest = max(size.width, size.height)
        guard longest > maxDimension else { return image }

        let scale = maxDimension / longest
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
