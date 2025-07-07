//
//  ChatView.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import PhotosUI
import SwiftUI

struct ChatView: View {
    @State private var viewModel: ChatViewModel = .init()

    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            ChatSectionView()
        }

        .task { await viewModel.getChatHistory() }
        .modifier(ToolbarViewModifier(view: AnyView(ToolbarDeleteButton()), placement: .topBarLeading))
        .modifier(ToolbarViewModifier(view: AnyView(ToolbarModelSelectionMenu()), placement: .topBarTrailing))
        .modifier(CenterLoadingViewModifier(isLoading: viewModel.isLoading))
        .alert(LocaleKeys.Chat.Alert.deleteTitle.localized, isPresented: $viewModel.showDeleteChatSheet, actions: {
            AlertDeleteButtons { await viewModel.deleteChatHistory() }
        })
        .alert(LocaleKeys.Chat.Alert.premiumTitle.localized, isPresented: $viewModel.showPremiumAlert, actions: {
            Button(LocaleKeys.Button.ok.localized, role: .cancel) { viewModel.showPremiumAlert = false }
            Button(LocaleKeys.Chat.Alert.premiumButtonTitle.localized) { viewModel.showPremiumAlert = false }
        })
        .snackBar(isPresented: $viewModel.showSuggestionAppliedSnackbar, message: LocaleKeys.Chat.Snackbar.suggestionApplied.localized)
        .snackBar(isPresented: $viewModel.showDeleteSuccessSnackbar, message: LocaleKeys.Chat.Snackbar.deleteSuccess.localized)
        .navigationTitle(viewModel.selectedAIModel.displayName.localized)
        .navigationBarTitleDisplayMode(.inline)
        .background(.cBackground)
        .environment(viewModel)
    }
}

#Preview {
    NavigationView {
        ChatView()
            .environment(AppContainer.shared.userSessionManager)
            .environment(AppContainer.shared.navigationManager)
    }
}

private struct ChatSectionView: View {
    @Environment(ChatViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            ChatMessagesView()
            ChatInputView()
        }
        .hPadding()
    }
}

private struct ToolbarModelSelectionMenu: View {
    @Environment(ChatViewModel.self) private var viewModel
    var body: some View {
        Menu {
            ForEach(AIModel.allCases) { aiModel in
                Button {
                    Task {
                        await viewModel.changeSelectedAIModel(to: aiModel)
                    }
                } label: {
                    Label(aiModel.displayName.localized, systemImage: aiModel.icon)
                }
            }
        } label: {
            Image(systemName: viewModel.selectedAIModel.icon)
                .foregroundColor(.cBlue)
                .imageScale(.large)
                .padding(.trailing, .low)
        }
    }
}

private struct ToolbarDeleteButton: View {
    @Environment(ChatViewModel.self) private var viewModel
    var body: some View {
        Button {
            viewModel.chatToDelete = viewModel.chat
            viewModel.showDeleteChatSheet = true
        } label: {
            Image(systemName: "minus.square")
                .foregroundColor(.cBlue)
                .imageScale(.large)
                .padding(.leading, .low)
        }
    }
}
