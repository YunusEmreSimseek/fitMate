//
//  OpenAIService.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import Alamofire
import Foundation

final class OpenAIService: AIServiceProtocol {
    var userSessionManager: UserSessionManager

    init(userSessionManager: UserSessionManager) {
        self.userSessionManager = userSessionManager
    }

    private let apiKey = AppContainer.shared.secretsManager.getAPIKey(.OPENAI_API_KEY)
    private let url = "https://api.openai.com/v1/chat/completions"

    private var headers: HTTPHeaders {
        [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json",
        ]
    }

    func sendMessage(_ messages: [String]) async throws -> String {
        let request = OpenAITextRequest(
            model: .gpt4oMini,
            messages: [
                AIMessageModel.systemMessage,
                AIMessageModel(role: "user", content: messages.last!),
            ],
            max_tokens: 200
        )

        let response = try await AF.request(
            url,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .serializingDecodable(AIResponseModel.self).value

        let assistantMessage =
            response.choices.first?.message.content ?? "No response"
        print("Assistant: \(assistantMessage)")
        return assistantMessage
    }

    func sendMessageWithImage(imageUrl: String, message: String) async throws -> String {
        let userMessage = AIImageMessageModel(role: "user", content: [
            .init(text: message),
            .init(imageUrl: imageUrl),
        ])

        let request = OpenAIImageRequest(
            model: .gpt4o,
            messages: [userMessage],
            max_tokens: 300
        )

        let response = try await AF.request(
            url,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .serializingDecodable(AIImageResponseModel.self).value

        let assistantMessage =
            response.choices.first?.message.content ?? "No response"
        print("Assistant: \(assistantMessage)")
        return assistantMessage
    }
}
