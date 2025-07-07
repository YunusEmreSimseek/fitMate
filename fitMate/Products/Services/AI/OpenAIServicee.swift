//
//  OpenAIServicee.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//
import Foundation
import OpenAI

final class OpenAIServicee: AIServiceProtocol {
    private lazy var userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager
    let openAI = OpenAI(apiToken: AppContainer.shared.secretsManager.getAPIKey(.OPENAI_API_KEY))

    func sendMessage(_: [MessageModel]) async throws -> String { "" }

    func sendMessageOnSuggestionType(_ messages: [MessageModel]) async throws -> SuggestionPayload {
        let query = ChatQuery(
            messages: convertToMessages(messages, for: .suggestion),
            model: .gpt4_o,
            maxTokens: 1000,
            temperature: 0.2,
        )
        let result = try await openAI.chats(query: query)

        guard let content = result.choices.first?.message.content else {
            return SuggestionPayload(answer: "No response from AI", suggestion: nil)
        }
        print("-----------Content: \(content)")
        let suggestion: SuggestionPayload = parseJsonResponse(content)
        return suggestion
    }

    func sendMessageWithImage(imageUrl: String, messages: [MessageModel]) async throws -> String {
        let imageContent = ChatQuery.ChatCompletionMessageParam.user(.init(content: .vision(
            [
                ChatQuery.ChatCompletionMessageParam.UserMessageParam.Content.VisionContent(chatCompletionContentPartImageParam: .init(imageUrl: .init(url: imageUrl, detail: .auto))),
            ]
        )))

        var messages = convertToMessages(messages, for: .imageMessage)
        messages.append(imageContent)
        let query = ChatQuery(
            messages: messages,
            model: .gpt4_o,
            maxTokens: 1000,
            temperature: 0.2,
        )
        let result = try await openAI.chats(query: query)
        guard let content = result.choices.first?.message.content else {
            return "No response from AI"
        }
        print("-----------Content: \(content)")
        return content
    }

    private func parseJsonResponse(_ content: String) -> SuggestionPayload {
        guard let start = content.range(of: "```json")?.upperBound,
              let end = content.range(of: "```", range: start ..< content.endIndex)?.lowerBound else
        {
            print("Kod bloğu bulunamadı")
            return SuggestionPayload(answer: "No response from AI", suggestion: nil)
        }

        let jsonText = content[start ..< end].trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            let data = Data(jsonText.utf8)
            let decoder = JSONDecoder()
            let suggestion = try decoder.decode(SuggestionPayload.self, from: data)
            print("✅ Answer:", suggestion.answer)
            print("💡 Suggestion:", suggestion.suggestion ?? "No suggestion")
            return suggestion
        } catch {
            print("❌ JSON ayrıştırılamadı:", error)
            return SuggestionPayload(answer: "No response from AI", suggestion: nil)
        }
    }

    private func convertToMessages(_ messages: [MessageModel], for type: OpenAIPromptsType) -> [ChatQuery.ChatCompletionMessageParam] {
        let user = userSessionManager.currentUser
        let prompt = type.systemPrompt(user: user)
        var chatMessages: [ChatQuery.ChatCompletionMessageParam] = [.developer(.init(content: prompt))]
        let lastMessages = messages.suffix(5)
        for message in lastMessages {
            let role: ChatQuery.ChatCompletionMessageParam.Role = message.role.rawValue == "user" ? .user : .assistant
            let content = message.text
            let messageParam = ChatQuery.ChatCompletionMessageParam(role: role, content: content)
            chatMessages.append(messageParam!)
        }
        return chatMessages
    }
}
