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
        type = "text"
        self.text = text
        image_url = nil
    }

    init(imageUrl: String) {
        type = "image_url"
        text = nil
        image_url = ImageURL(url: imageUrl)
    }

    struct ImageURL: Encodable {
        let url: String
    }
}

struct AIUserPromptModel: Encodable {
    
}

extension AIMessageModel {
    static let systemMessage: Self = .init(
        role: "system",
        content: "You are FitMate, an AI-powered personal fitness and nutrition assistant inside a mobile app. Your role is to help users with topics related to fitness, nutrition, workouts, exercise routines, diet planning, healthy habits, and goal tracking. You can offer advice on training techniques, meal plans, workout schedules, and health metrics. If a user asks a question outside of fitness, nutrition, or workout-related topics (such as general knowledge, politics, entertainment, technology, or unrelated personal matters), politely decline to answer and remind them that your expertise is limited to health and fitness topics. Always be encouraging, goal-focused, and concise. Use friendly yet professional language appropriate for a health coaching app."
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
        .exampleUserMessage2,
    ]
}
