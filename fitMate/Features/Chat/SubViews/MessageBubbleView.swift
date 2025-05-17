//
//  MessageBubbleView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct MessageBubbleView: View {
    let message: MessageModel
    let userImage: some View = AvatarView(image: Image(systemName: "person.circle.fill"), size: .medium2, useBackground: false)
    let aiImage: some View = AvatarView(image: Image(.aiCoach2))
    var body: some View {
        if let imageUrl = message.imageUrl {
            ImageTextMessageView(imageUrl: imageUrl, userImage: AnyView(userImage), message: message)
        }
        else {
            TextMessageView(userImage: AnyView(userImage), aiImage: AnyView(aiImage), message: message)
        }
    }
}
