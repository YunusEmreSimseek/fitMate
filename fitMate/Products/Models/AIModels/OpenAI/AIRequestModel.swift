//
//  AIRequestModel.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//

// İstek parametreleri modelini oluşturuyoruz
struct OpenAITextRequest: Encodable {
    let model: OpenAIModel
    let messages: [AIMessageModel]
    let max_tokens: Int
}

struct OpenAIImageRequest: Encodable {
    let model: OpenAIModel
    let messages: [AIImageMessageModel]
    let max_tokens: Int
}

enum OpenAIModel: String, Encodable {
    case gpt4o = "gpt-4o"
    case gpt4oMini = "gpt-4o-mini"
}
