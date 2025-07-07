//
//  TextMessageView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct UserMessageView: View {
    let userImage: AnyView
    let message: MessageModel
    @Environment(UserSessionManager.self) private var userSessionManager
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            userImage

            VStack(alignment: .trailing, spacing: 2) {
                Text(userSessionManager.currentUser?.name ?? LocaleKeys.Chat.userName.localized)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

                ZStack(alignment: .bottomTrailing) {
                    Text(message.text)
                        .font(.callout)
                        .foregroundColor(.primary)
                        .trailingPadding(.dynamicWidth(width: 0.06))
                        .card(cornerRadius: .low, padding: .low)

                    Text(message.createdAt.formattedTime())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .trailingPadding(4)
                        .bottomPadding(2)
                }
            }
        }
    }
}

struct AIMessageView: View {
    let aiImage: AnyView
    let message: MessageModel
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text(LocaleKeys.Chat.aiName.localized)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

                ZStack(alignment: .bottomTrailing) {
                    Text(message.text)
                        .font(.callout)
                        .foregroundColor(.primary)
                        .trailingPadding(.dynamicWidth(width: 0.06))
                        .card(cornerRadius: .low, padding: .low)

                    Text(message.createdAt.formattedTime())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .trailingPadding(4)
                        .bottomPadding(2)
                }
            }

            aiImage
            Spacer()
        }
    }
}

struct AIMessageLoadingView: View {
    let aiImage: AnyView
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 2) {
                Text(LocaleKeys.Chat.aiName.localized)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)

                ZStack(alignment: .bottomTrailing) {
                    ProgressView()
                        .hPadding(.dynamicWidth(width: 0.1))
                        .card(cornerRadius: .low, padding: .low)

                    Text(Date.now.formattedTime())
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .trailingPadding(4)
                        .bottomPadding(2)
                }
            }

            aiImage
            Spacer()
        }
    }
}
