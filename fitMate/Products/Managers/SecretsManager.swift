//
//  SecretsManager.swift
//  fitMate
//
//  Created by Emre Simsek on 14.05.2025.
//

import Foundation

final class SecretsManager {
    func getAPIKey(_ secret: Secrets) -> String {
        guard let key = Bundle.main.infoDictionary?[secret.rawValue] as? String else {
            fatalError("API key not found in Info.plist")
        }
        return key
    }
}

enum Secrets: String, Decodable {
    case OPENAI_API_KEY
}
