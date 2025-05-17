//
//  ChatInputView.swift
//  fitMate
//
//  Created by Emre Simsek on 25.04.2025.
//

import PhotosUI
import SwiftUI

struct ChatInputView: View {
    @Environment(ChatViewModel.self) private var viewModel
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        @Bindable var viewModelBindable = viewModel
        HStack(spacing: .low) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(height: .dynamicHeight(height: 0.045))

            ZStack {
                RoundedRectangle(cornerRadius: .normal)
                    .fill(.cGray)
                    .clipShape(.rect(cornerRadius: .low))
                    .shadow(color: .primary.opacity(0.1), radius: 8, x: 0, y: 4)
                HStack {
                    TextField(LocaleKeys.Chat.placeholder.localized, text: $viewModelBindable.inputText)
                        .hPadding()
                        .vPadding()
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Image(systemName: "photo.on.rectangle")
                            .foregroundColor(.cBlue)
                    }
                    .onChange(of: selectedItem) { _, newItem in
                        Task { await viewModel.selectImageAndPrepareUpload(newItem) }
                    }
                    .hPadding()
                }
            }

            Button {
                Task { await viewModel.sendMessage() }
            }
            label: {
                Image(systemName: "paperplane.fill")
                    .rotationEffect(.degrees(45))
                    .foregroundColor(.cBlue)
            }
            .disabled(viewModel.isLoading)
        }
        .frame(height: .dynamicHeight(height: 0.055))
        .vPadding()
    }
}
