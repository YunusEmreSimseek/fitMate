//
//  MistralModels.swift
//  fitMate
//
//  Created by Emre Simsek on 23.04.2025.
//

import Foundation

struct AIServiceUserProfile: Encodable {
    let gender: Gender
    let age: Int
    let height: Int
    let weight: Int
    let goals: [String]
    let activityLevel: String
}

//struct MistralAIRequest: Encodable {
//    let message: String
//    let userProfile: AIServiceUserProfile
//}

struct MistralAIRequest: Encodable {
    let messages: [String]
    let userProfile: AIServiceUserProfile
}

struct MistralAIResponse: Decodable {
    let answer: String
}

extension AIServiceUserProfile {
    static let dummyUserProfile: AIServiceUserProfile = .init(
        gender: .female,
        age: 25,
        height: 160,
        weight: 60,
        goals: ["weight_loss"],
        activityLevel: "moderately_active"
    )
}
