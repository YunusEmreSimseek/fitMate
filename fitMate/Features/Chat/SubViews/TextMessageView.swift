//
//  TextMessageView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct TextMessageView: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    let userImage: AnyView
    let aiImage: AnyView
    let message: MessageModel
    var body: some View {
        HStack(alignment: .bottom) {
            if message.role == .user {
                Spacer()
                userImage
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(message.role == .user
                    ? (userSessionManager.currentUser?.name ?? LocaleKeys.Chat.userName.localized)
                    : LocaleKeys.Chat.aiName.localized)
                    .font(.footnote)
                    .foregroundColor(.gray)

                Text(message.text)
                    .allPadding()
                    .foregroundColor(.primary)
                    .background(
                        message.role == .user
                            ? Color.cBlue : Color(.cGray)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: .low))
                    .shadow(color: .primary.opacity(0.1), radius: 8, x: 0, y: 4)
            }

            if message.role != .user {
                aiImage
                Spacer()
            }
        }
    }
}
