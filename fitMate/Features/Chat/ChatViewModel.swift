//
//  ChatViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import PhotosUI
import SwiftUI

@Observable
final class ChatViewModel {
    var chat: ChatModel?
    var inputText = ""
    var isLoading = false
    var isLoadingResponse = false
    var hasAppeared: Bool = false
    var selectedImage: UIImage?
    var selectedImageUrl: String?
    var selectedAIModel: AIModel = .mistralAI
    var suggestion: Suggestion?
    var showDeleteChatSheet: Bool = false
    var showPremiumAlert: Bool = false
    var showSuggestionAppliedSnackbar: Bool = false
    var showDeleteSuccessSnackbar: Bool = false
    var chatToDelete: ChatModel?

    private let userSessionManager: UserSessionManager
    private let openAIService: AIServiceProtocol
    private let mistralAIService: AIServiceProtocol
    private let chatService: ChatService
    private let storageService: StorageService

    init(
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
//        openAIService: AIServiceProtocol = AppContainer.shared.openAIService,
        openAIService: AIServiceProtocol = OpenAIServicee(),
        mistralAIService: AIServiceProtocol = AppContainer.shared.mistralAIService,
        chatService: ChatService = AppContainer.shared.chatService,
        storageService: StorageService = AppContainer.shared.storageService
    ) {
        self.userSessionManager = userSessionManager
        self.openAIService = openAIService
        self.mistralAIService = mistralAIService
        self.chatService = chatService
        self.storageService = storageService
        if AppMode.isPreview {
            suggestion = .dummy
        }
    }

    func changeSelectedAIModel(to model: AIModel) async {
        guard let user = userSessionManager.currentUser else { return }
        if model == .openAI, user.isPremium != true {
            showPremiumAlert = true
            return
        }

        selectedAIModel = model
        hasAppeared = false
        await getChatHistory()
    }

    func getChatHistory() async {
        guard !AppMode.isPreview else {
            chat = ChatModel(
                userId: "",
                aiModel: selectedAIModel,
                messages: MessageModel.exampleMessages
            )
            return
        }

        guard !hasAppeared else { return }

        hasAppeared = true
        isLoading = true
        defer { isLoading = false }

        guard let userId = userSessionManager.currentUser?.id else {
            return
        }
        let chatId = "\(userId)_\(selectedAIModel.rawValue)"
        do {
            let existingChat = try await chatService.fetchChat(for: chatId)
            withAnimation(.easeInOut(duration: 0.2)) {
                chat = existingChat
            }

        } catch {
            chat = ChatModel(userId: userId, aiModel: selectedAIModel)
        }
    }

    func sendMessage() async {
        guard !inputText.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        guard chat != nil else { return }

        if AppMode.isPreview {
            chat?.messages.append(MessageModel(role: .user, text: inputText))
            return
        }

        var aiReply = ""
        isLoadingResponse = true
        defer {
            isLoadingResponse = false
        }
        do {
            if selectedImageUrl != nil {
                aiReply = try await sendMessageWithImage()
            } else {
                aiReply = try await sendMessageOnSuggestionType()
            }
            // 4. AI mesajını ekle
            let aiMessage = MessageModel(role: .assistant, text: aiReply)
            withAnimation(.easeInOut(duration: 0.2)) {
                chat!.addMessage(aiMessage)
            }

            // 5. Sohbeti kaydet
            try await chatService.addChat(chat: chat!)
        } catch {
            print("❌ Hata oluştu:", error.localizedDescription)
        }
        // 6. Temizle
        inputText = ""
        selectedImage = nil
        selectedImageUrl = nil
    }

    private func sendOnlyMessage() async throws -> String {
        // Sadece metinle cevap al
        let aiService = currentAIService()
//        let prompt = buildFullPromptAsList()
        let message = MessageModel(role: .user, text: inputText)
        chat!.addMessage(message)
        inputText = ""
        do {
//            let result = try await aiService.sendMessage(prompt)
            let result = try await aiService.sendMessage(chat!.messages)
            return result
        } catch {
            print("Error: \(error)")
            return "Sorry, I couldn't process your request."
        }
    }

    private func sendMessageOnSuggestionType() async throws -> String {
        let aiService = currentAIService()
        let message = MessageModel(role: .user, text: inputText)
        chat!.addMessage(message)
        inputText = ""
        do {
            let result = try await aiService.sendMessageOnSuggestionType(chat!.messages)
            if let suggestion = result.suggestion { self.suggestion = suggestion }
            return result.answer
        } catch {
            print("Error: \(error)")
            return "Sorry, I couldn't process your request."
        }
    }

    private func sendMessageWithImage() async throws -> String {
        // Görsel + mesaj birlikte gönder
        let aiService = currentAIService()
        let message = MessageModel(
            role: .user,
            text: inputText,
            imageUrl: selectedImageUrl
        )
        chat!.addMessage(message)
        inputText = ""
        do {
            let result = try await aiService.sendMessageWithImage(
                imageUrl: selectedImageUrl!,
                messages: chat!.messages
            )
            print("Mesaj + metin gonderildi")
            return result
        } catch {
            print("Error: \(error)")
            return "Sorry, I couldn't process your request."
        }
    }

    func selectImageAndPrepareUpload(_ item: PhotosPickerItem?) async {
        guard let item else { return }
        isLoading = true
        do {
            if let image = try await item.loadTransferable(type: UIImage.self) {
                selectedImage = image
                selectedImageUrl = try await storageService.uploadImage(image)
                    .absoluteString
                print("✅ Yüklenen URL: \(selectedImageUrl ?? "")")
            }
        } catch {
            print("❌ Görsel yükleme hatası: \(error.localizedDescription)")
        }
        isLoading = false
    }

    private func currentAIService() -> AIServiceProtocol {
        switch selectedAIModel {
        case .openAI:
            return openAIService
        case .mistralAI:
            return mistralAIService
        }
    }

    private func buildFullPrompt(limit: Int = 10) -> String {
        var prompt = ""
        let lastMessages = chat!.messages.suffix(limit)

        for message in lastMessages {
            switch message.role {
            case .user:
                prompt += "User: \(message.text)\n"
            case .assistant:
                prompt += "AI: \(message.text)\n"
            case .system:
                continue
            }
        }
        prompt += "User: \(inputText)\nAI:"
        return prompt
    }

    func deleteChatHistory() async {
        guard chatToDelete != nil else { return }
        isLoading = true
        defer { isLoading = false }
        chatToDelete!.messages.removeAll()
        chatToDelete!.messages = [.welcomeMessage]
        try? await chatService.updateChat(chat: chatToDelete!)
        withAnimation(.easeInOut(duration: 0.2)) {
            chat = chatToDelete
            showDeleteSuccessSnackbar = true
        }
    }
}
