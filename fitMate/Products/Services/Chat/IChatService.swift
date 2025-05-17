//
//  IChatService.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import Foundation

protocol IChatService {
    func addChat(chat: ChatModel) async throws
    func fetchAllChats(for userId: String) async throws -> [ChatModel]
    func fetchChat(for chatId: String) async throws -> ChatModel?
}

extension IChatService {
    func createInitialChats(for userId: String) async throws {
        for model in AIModel.allCases {
            let initialChat = ChatModel(
                userId: userId,
                aiModel: model,
                messages: [.welcomeMessage]
            )
            try await addChat(chat: initialChat)
        }
    }
}
