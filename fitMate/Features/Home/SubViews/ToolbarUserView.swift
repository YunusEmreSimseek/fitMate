//
//  ToolbarUserView.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//

import SwiftUI

struct ToolbarUserView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @Environment(UserSessionManager.self) private var userSessionManager
    var body: some View {
        HStack(spacing: 8) {
            Image(.profile1)
                .resizable()
                .scaledToFit()
                .frame(height: .dynamicHeight(height: 0.05))
                .clipShape(Circle())
                .allPadding(2)
                .background(Circle().fill(.cGray.opacity(0.95)))
                .shadow(color: .primary.opacity(0.1), radius: 4)
            VStack(alignment: .leading) {
                Text(viewModel.greetingMessage().localized + ",")
                    .font(.headline)
                    .bold()
                Text(userSessionManager.currentUser?.name ?? LocaleKeys.Placeholder.username.localized.capitalized)
                    .foregroundColor(.cBlue)
                    .font(.subheadline)
                    .bold()
            }
        }
    }
}

// #Preview {
//    ToolbarUserView()
// }
