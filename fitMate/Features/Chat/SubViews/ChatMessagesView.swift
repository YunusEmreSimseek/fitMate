//
//  ChatMessagesView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct ChatMessagesView: View {
    @Environment(ChatViewModel.self) private var viewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: .normal) {
                    Group {
                        ForEach(viewModel.chat?.messages ?? [], id: \.id) { message in
                            MessageBubbleView(message: message)
                                .id(message.id)
                        }
                        if viewModel.isLoadingResponse {
                            AIMessageLoadingView(aiImage: AnyView(AvatarView(image: Image(.aiCoach2))))
                        }

                    }.bottomPadding(.low3)
                }
                .topPadding()

                SuggestionCardView().bottomPadding(.low)
            }

            .onChange(of: viewModel.chat?.messages.count) {
                if let lastId = viewModel.chat?.messages.last?.id {
                    withAnimation {
                        proxy.scrollTo(lastId, anchor: .bottom)
                    }
                }
            }
            .onChange(of: viewModel.suggestion?.type) { _, newValue in
                if newValue == nil { return }
                withAnimation {
                    proxy.scrollTo("suggestionCard", anchor: .bottom)
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

private struct SuggestionCardView: View {
    @Environment(ChatViewModel.self) private var viewModel

    var body: some View {
        if let suggestion = viewModel.suggestion {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: .low2) {
                    Text(suggestion.title)
                        .font(.subheadline).bold()
                    Text(suggestion.description)
                        .font(.subheadline)

                    RoundedRectangelButton(title: LocaleKeys.Button.accept.localized, vPadding: .low2, onTap: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            switch suggestion.action.type {
                            case SuggestionActionType.setStepGoal.rawValue:
                                SuggestionActionType.setStepGoal.perform(with: suggestion.action.value)
                            case SuggestionActionType.setCalorieGoal.rawValue:
                                SuggestionActionType.setCalorieGoal.perform(with: suggestion.action.value)
                            case SuggestionActionType.setDietPlan.rawValue:
                                SuggestionActionType.setDietPlan.perform(with: suggestion.action.value)
                            case SuggestionActionType.setWorkoutProgram.rawValue:
                                SuggestionActionType.setWorkoutProgram.perform(with: suggestion.action.value)
                            default:
                                return
                            }
                            viewModel.suggestion = nil
                            viewModel.showSuggestionAppliedSnackbar = true
                        }
                    })
                    .hPadding()
                }
                .card(cornerRadius: .low)
                .id("suggestionCard")

                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.suggestion = nil
                    }
                }) {
                    Image(systemName: "xmark.app.fill")
                        .foregroundColor(.red)
                        .allPadding(.low3)
                }
            }
        }
    }
}
