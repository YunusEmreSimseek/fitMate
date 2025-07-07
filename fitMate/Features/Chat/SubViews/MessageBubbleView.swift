//
//  MessageBubbleView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct MessageBubbleView: View {
    let message: MessageModel
    let userImage: some View = AvatarView(image: Image(.profile1), size: .medium2, useBackground: true, bgColor: .white.opacity(0.95))
    let aiImage: some View = AvatarView(image: Image(.aiCoach2))
    var body: some View {
        if let imageUrl = message.imageUrl {
            ImageTextMessageView(imageUrl: imageUrl, userImage: AnyView(userImage), message: message)
        } else if message.role == .user {
            UserMessageView(userImage: AnyView(userImage), message: message)
        } else if message.role == .assistant {
            AIMessageView(aiImage: AnyView(aiImage), message: message)
        }
    }
}
