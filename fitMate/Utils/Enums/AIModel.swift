//
//  AIModel.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//

import Foundation

enum AIModel: String, Codable, CaseIterable, Identifiable {
    case mistralAI
    case openAI
    
    var id: String { rawValue }

        var displayName: String {
            switch self {
            case .openAI: return LocaleKeys.Chat.openAIName
            case .mistralAI: return LocaleKeys.Chat.mistralAIName
            }
        }

        var icon: String {
            switch self {
            case .openAI: return "circle.grid.cross" // örnek ikon
            case .mistralAI: return "wind"             // örnek ikon
            }
        }
}
