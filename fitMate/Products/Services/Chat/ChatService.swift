//
//  ChatService.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import FirebaseFirestore

final class ChatService: IChatService {
    private lazy var db = Firestore.firestore()
    private let chatsCollection = FirebaseCollections.chats.rawValue

    func addChat(chat: ChatModel) async throws {
        do {
            try db.collection(chatsCollection).document(chat.chatId).setData(from: chat)
        } catch {
            throw ChatServiceError.networkError(error)
        }
    }

    func fetchAllChats(for userId: String) async throws -> [ChatModel] {
        do {
            let snapshot = try await db.collection(chatsCollection).whereField("userId", isEqualTo: userId).getDocuments()
            return try snapshot.documents.compactMap { doc in
                try doc.data(as: ChatModel.self)
            }
        } catch _ as DecodingError {
            throw ChatServiceError.decodingError
        } catch {
            throw ChatServiceError.networkError(error)
        }
    }

    func fetchChat(for chatId: String) async throws -> ChatModel? {
        do {
            let doc = try await db.collection(chatsCollection).document(chatId).getDocument()
            guard doc.exists else { throw ChatServiceError.chatNotFound }
            let chat = try doc.data(as: ChatModel.self)
            return chat
        } catch _ as DecodingError {
            throw ChatServiceError.decodingError
        } catch {
            throw ChatServiceError.networkError(error)
        }
    }
    
    func updateChat(chat: ChatModel) async throws {
        do {
            try db.collection(chatsCollection).document(chat.chatId).setData(from: chat, merge: true)
        } catch {
            throw ChatServiceError.networkError(error)
        }
    }
}

enum ChatServiceError: LocalizedError {
    case chatNotFound
    case decodingError
    case networkError(Error)
    case unknownError(Error)

    var errorDescription: String? {
        switch self {
        case .chatNotFound:
            return "Chat could not be found."
        case .decodingError:
            return "Failed to decode chat data."
        case let .networkError(error):
            return "Network error: \(error.localizedDescription)"
        case let .unknownError(error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
