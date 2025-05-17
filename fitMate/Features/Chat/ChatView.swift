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
        VStack {
            ChatSectionView()
        }
        .onAppear {
            Task {
                await viewModel.getChatHistory()
            }
        }
        .modifier(ToolbarViewModifier(view: AnyView(toolbarAddButton), placement: .topBarLeading))
        .modifier(ToolbarViewModifier(view: AnyView(toolbarModelMenuButton), placement: .topBarTrailing))
        .environment(viewModel)
        .navigationTitle(viewModel.selectedAIModel.displayName.localized)
        .navigationBarTitleDisplayMode(.inline)
        .background(.cBackground)
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
        @Bindable var viewModelBindable = viewModel
        VStack {
            ChatMessagesView(
                messages: viewModel.chat?.messages ?? [],
                isLoading: viewModel.isLoading
            )
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            ChatInputView()
        }
        .hPadding()
    }
}

extension ChatView {
    var toolbarAddButton: some View {
        Image(systemName: "plus.app")
            .foregroundColor(.cBlue)
            .font(.title2)
            .padding(.leading, .low)
    }

    var toolbarModelMenuButton: some View {
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
                .font(.title2)
                .padding(.trailing, .low)
        }
    }
}
