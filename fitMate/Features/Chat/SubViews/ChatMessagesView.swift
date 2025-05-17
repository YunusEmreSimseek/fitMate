//
//  ChatMessagesView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//
import SwiftUI

struct ChatMessagesView: View {
    let messages: [MessageModel]
    let isLoading: Bool

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: .normal) {
                    ForEach(messages, id: \.id) { message in
                        MessageBubbleView(message: message)
                            .id(message.id)
                    }

//                    if isLoading {
//                        ProgressView()
//                            .frame(maxWidth: .infinity, alignment: .center)
//                    }
                }
                .topPadding()
            }
            .onChange(of: messages.count) {
                if let lastId = messages.last?.id {
                    withAnimation {
                        proxy.scrollTo(lastId, anchor: .bottom)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}
