//
//  StorageService.swift
//  fitMate
//
//  Created by Emre Simsek on 17.04.2025.
//

import FirebaseStorage
import Foundation
import SwiftUI

final class StorageService {
    private let storage = Storage.storage()

    func uploadImage(_ image: UIImage, path: String = "chat_images") async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.85) else {
            throw NSError(domain: "StorageService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Image conversion to JPEG failed."])
        }

        let fileName = UUID().uuidString + ".jpg"
        let imageRef = storage.reference().child("\(path)/\(fileName)")

        _ = try await imageRef.putDataAsync(imageData)

        let url = try await imageRef.downloadURL()
        return url
    }
}

extension StorageReference {
    func putDataAsync(_ data: Data) async throws -> StorageMetadata {
        return try await withCheckedThrowingContinuation { continuation in
            self.putData(data, metadata: nil) { metadata, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let metadata = metadata {
                    continuation.resume(returning: metadata)
                } else {
                    continuation.resume(throwing: NSError(domain: "StorageError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Unknown upload error"]))
                }
            }
        }
    }

    func downloadURL() async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            self.downloadURL { url, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let url = url {
                    continuation.resume(returning: url)
                } else {
                    continuation.resume(throwing: NSError(domain: "StorageError", code: -3, userInfo: [NSLocalizedDescriptionKey: "URL is nil"]))
                }
            }
        }
    }
}
