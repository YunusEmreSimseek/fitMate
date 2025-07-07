//
//  AIResponseModel.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//

struct AIResponseModel: Decodable {
    let choices: [Choice]
    let usage: Usage
    let id: String
    let object: String
    let model: String
    let created: Int

    // Yanıtın choices içindeki her bir öğeyi temsil eden model
    struct Choice: Decodable {
        let message: AIMessageModel
        let finish_reason: String
        let index: Int
    }

    // Kullanım istatistiklerini temsil eden model
    struct Usage: Decodable {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
    }
}

struct AIResponseModel2: Decodable {
    let answer: String
    let suggestion: AISuggestion?

    struct AISuggestion: Decodable {
        let title: String
        let description: String
        let action: String
    }
}

//struct AISuggestionPayload: Decodable {
//    let answer: String
//    let suggestion: Suggestion?
//}
//
//struct Suggestion: Decodable {
//    let type: String
//    let title: String
//    let description: String
//    let action: SuggestionAction
//}
//
//struct SuggestionAction: Decodable {
//    let type: String
//    let value: Int
//}

struct AIImageResponseModel: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: AIMessageModel
    }
}
