//
//  MessageModel.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//
import Foundation

struct AIMessageModel: Codable, Hashable {
    let role: String
    let content: String
}

struct AIImageMessageModel: Encodable {
    let role: String
    let content: [AIImageContent]
}

struct AIImageContent: Encodable {
    let type: String
    let text: String?
    let image_url: ImageURL?

    init(text: String) {
        self.type = "text"
        self.text = text
        self.image_url = nil
    }

    init(imageUrl: String) {
        self.type = "image_url"
        self.text = nil
        self.image_url = ImageURL(url: imageUrl)
    }

    struct ImageURL: Encodable {
        let url: String
    }
}

extension AIMessageModel {
    static let systemMessage: Self = .init(
        role: "system",
        content: "You are an AI fitness trainer. Give users short, motivating, simple and descriptive answers. Avoid unnecessary conversations."
    )
    static let welcomeMessage: Self = .init(
        role: "assistant",
        content: "Welcome to FitMate! I'm here to help you with your fitness journey. How can I assist you today?"
    )
    static let exampleUserMessage: Self = .init(
        role: "user",
        content: "Hi there! I need help with my workout plan."
    )
    static let exampleAIMessage: Self = .init(
        role: "assistant",
        content: "Sure! What are your fitness goals?"
    )
    static let exampleUserMessage2: Self = .init(
        role: "user",
        content: "Building muscles"
    )
    static let exampleMessages: [Self] = [
        .welcomeMessage,
        .exampleUserMessage,
        .exampleAIMessage,
        .exampleUserMessage2
    ]
}
