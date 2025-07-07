//
//  SuggestionModels.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//

struct SuggestionPayload: Decodable {
    let answer: String
    let suggestion: Suggestion?
}

struct Suggestion: Decodable {
    let type: String
    let title: String
    let description: String
    let action: SuggestionAction
}

struct SuggestionAction: Decodable {
    let type: String
    let value: SuggestionActionValue
}

extension Suggestion {
    static let dummy = Suggestion(
        type: "example",
        title: "This is an AI-generated suggestion.This is an AI-generated suggestion.This is an AI-generated suggestion.",
        description: "Apply",
        action: SuggestionAction(type: "example", value: .int(1))
    )
}
