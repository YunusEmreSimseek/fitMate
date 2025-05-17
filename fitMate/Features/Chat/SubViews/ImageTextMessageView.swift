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
                VStack(alignment: .leading, spacing: 2) {
                    Text(userSessionManager.currentUser?.name ?? LocaleKeys.Chat.userName.localized)
                        .font(.footnote)
                        .foregroundColor(.gray)

                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: .low))
                                .frame(maxHeight: .dynamicHeight(height: 0.3))
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
        }
    }
}
