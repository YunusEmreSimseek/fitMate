//
//  AIServiceProtocol.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//

import Foundation

protocol AIServiceProtocol {
    var userSessionManager: UserSessionManager { get }
    func sendMessage(_ messages: [String]) async throws -> String
    func sendMessageWithImage(imageUrl: String, message: String) async throws -> String
}
