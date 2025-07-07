//
//  OpenAIService.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import Alamofire
import Foundation

final class OpenAIService: AIServiceProtocol {
    func sendMessageOnSuggestionType(_: [MessageModel]) async throws -> SuggestionPayload {
        return SuggestionPayload(answer: "Not implemented", suggestion: nil)
    }

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

    func sendMessage(_ messages: [MessageModel]) async throws -> String {
        let prompt = buildFullPromptasList(messages)
        let request = OpenAITextRequest(
            model: .gpt4oMini,
            messages: prompt,
            max_tokens: 200,
            temperature: 0.7,
            response_format: "json"
        )

        let response = try await AF.request(
            url,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
//        .serializingDecodable(AIResponseModel.self).value
//            .serializingDecodable(AIResponseModel.self).value
        guard response.error == nil else {
            throw response.error ?? AFError.responseValidationFailed(reason: .dataFileNil)
        }
        let decodedResponse = try JSONDecoder().decode(AIResponseModel2.self, from: response.data!)

//        let assistantMessage =
//            response.choices.first?.message.content ?? "No response"
//        print("Assistant: \(assistantMessage)")
        print("Full response: \(decodedResponse)")
        return decodedResponse.answer
    }

    func sendMessageWithImage(imageUrl: String, messages: [MessageModel]) async throws -> String {
//        let userMessage = AIImageMessageModel(role: "user", content: [
//            .init(text: message),
//            .init(imageUrl: imageUrl),
//        ])
//
//        let request = OpenAIImageRequest(
//            model: .gpt4o,
//            messages: [userMessage],
//            max_tokens: 300
//        )
//
//        let response = try await AF.request(
//            url,
//            method: .post,
//            parameters: request,
//            encoder: JSONParameterEncoder.default,
//            headers: headers
//        )
//        .validate()
//        .serializingDecodable(AIImageResponseModel.self).value
//
//        let assistantMessage =
//            response.choices.first?.message.content ?? "No response"
//        print("Assistant: \(assistantMessage)")
//        return assistantMessage
        return ""
    }

    private func buildFullPromptasList(_ messages: [MessageModel]) -> [AIMessageModel] {
        var prompt: [AIMessageModel] = [buildSystemPrompt()]
        let lastMessages = messages.suffix(5)
        for message in lastMessages {
            switch message.role {
            case .user:
                prompt.append(AIMessageModel(role: "user", content: message.text))
            case .assistant:
                prompt.append(AIMessageModel(role: "assistant", content: message.text))
            case .system:
                continue
            }
        }

        return prompt
    }

    private func buildSystemPrompt() -> AIMessageModel {
        guard let user = userSessionManager.currentUser else { return AIMessageModel.systemMessage }
        let prompt = "You are FitMate, a personalized AI health and fitness assistant.\nYou are helping a user with the following profile:\n\(user.toAIUserModel().toPrompt())\nUse this profile to offer personalized advice on fitness, workouts, training schedules, diet, and nutrition. Tailor your recommendations to this user's goal and level.\nOnly answer questions related to fitness, diet, nutrition, and workout planning. If the user asks unrelated questions, kindly refuse and remind them of your purpose.\nBe concise, supportive, and motivational in your tone. You are part of a mobile fitness app, so responses should be practical and user-friendly."

        let profilePrompt = user.toAIUserModel().toPrompt()

        let systemPrompt = """
        You are a helpful and specialized fitness AI assistant inside a mobile fitness app. Use the user's profile below to tailor your responses.
        User Profile:
        \(profilePrompt)
        Your primary job is to respond to user questions about fitness, diet, and health, and also give suggestions for features the user may want to enable in the app.
        Only answer questions related to health, diet, fitness or training. If not, politely decline.
        When applicable, include a `suggestion` field in your response like this:
        {
          "answer": "To reach your goal, a daily step goal of 8000 is a good start.",
          "suggestion": {
            "type": "stepGoal",
            "title": "Set Daily Step Goal",
            "description": "Would you like to set a daily goal of 8000 steps to track your activity?",
            "action": {
              "type": "setStepGoal",
              "value": 8000
            }
          }
        }
        """

        return AIMessageModel(role: "system", content: systemPrompt)
    }
}
