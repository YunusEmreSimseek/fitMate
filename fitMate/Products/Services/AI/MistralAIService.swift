//
//  MistralAIService.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//

import Alamofire
import Foundation

final class MistralAIService: AIServiceProtocol {
    var userSessionManager: UserSessionManager

    init(userSessionManager: UserSessionManager) {
        self.userSessionManager = userSessionManager
    }

    private let url = "https://f242-35-247-156-102.ngrok-free.app/ask"

    func sendMessageOnSuggestionType(_ messages: [MessageModel]) async throws -> SuggestionPayload {
        guard let user = userSessionManager.currentUser else { return SuggestionPayload(answer: "No connection to Mistral AI, please try again later.", suggestion: nil) }
        let prompt = MistralAIPrompts.message.systemPrompt(user: user, messages: messages)
        let request = MistralAIRequest(prompt: prompt)
        let response = try await AF.request(
            url,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .serializingDecodable(MistralAIResponse.self).value
        return SuggestionPayload(answer: response.answer, suggestion: nil)
    }

    func sendMessage(_: [MessageModel]) async throws -> String {
//        guard let user = userSessionManager.currentUser else { return "" }
//        let prompt = buildFullPromptAsList(messages: messages)
//        let request = MistralAIRequest(messages: prompt, userProfile: user.toAIUserModel().toPrompt())
//        let response = try await AF.request(
//            url,
//            method: .post,
//            parameters: request,
//            encoder: JSONParameterEncoder.default
//        )
//        .validate()
//        .serializingDecodable(MistralAIResponse.self).value

//        return response.answer
        return ""
    }

    func sendMessageWithImage(imageUrl: String, messages: [MessageModel]) async throws -> String {
        guard let user = userSessionManager.currentUser else { return "No connection to Mistral AI, please try again later." }
        let prompt = MistralAIPrompts.messageWithImage.systemPrompt(user: user, messages: messages, imageURL: imageUrl)
        let request = MistralAIRequest(prompt: prompt)
        let response = try await AF.request(
            url,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .serializingDecodable(MistralAIResponse.self).value

        return response.answer
    }

    private func buildFullPromptAsList(messages: [MessageModel], limit: Int = 10) -> [String] {
        var prompt: [String] = []
        let lastMessages = messages.suffix(limit)

        for message in lastMessages {
            switch message.role {
            case .user:
                prompt.append("User: \(message.text)")
            case .assistant:
                prompt.append("AI: \(message.text)")
            case .system:
                continue
            }
        }

        return prompt
    }
}
