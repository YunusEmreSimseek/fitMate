//
//  UIImageExtensions.swift
//  fitMate
//
//  Created by Emre Simsek on 17.04.2025.
//

import SwiftUI

extension UIImage: @retroactive Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .jpeg) { data in
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "TransferError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Image conversion failed"])
            }
            return image
        }
    }
}
