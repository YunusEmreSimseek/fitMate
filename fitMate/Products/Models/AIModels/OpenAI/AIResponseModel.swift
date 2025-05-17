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

struct AIImageResponseModel: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: AIMessageModel
    }
}
