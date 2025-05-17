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

    private let url = "none"

    func sendMessage(_ messages: [String]) async throws -> String {
        let request = MistralAIRequest(messages: messages, userProfile: userSessionManager.currentUser?.toAIServiceUserProfile() ?? AIServiceUserProfile.dummyUserProfile)
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

    func sendMessageWithImage(imageUrl: String, message: String) async throws -> String {
        return ""
    }
}
