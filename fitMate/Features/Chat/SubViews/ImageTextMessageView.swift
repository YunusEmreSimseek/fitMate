//
//  ImageTextMessageView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct ImageTextMessageView: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    let imageUrl: String
    let userImage: AnyView
    let message: MessageModel
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(userSessionManager.currentUser?.name ?? LocaleKeys.Chat.userName.localized)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)

                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: .low))
                                .frame(maxHeight: .dynamicHeight(height: 0.25))
                        case .failure:
                            Image(systemName: "xmark.octagon")
                                .foregroundColor(.red)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .bottomPadding(.low3)
                }
            }

            HStack(alignment: .bottom) {
                Spacer()
                userImage
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
