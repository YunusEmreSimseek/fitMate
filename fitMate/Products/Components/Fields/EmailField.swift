//
//  EmailField.swift
//  fitMate
//
//  Created by Emre Simsek on 2.11.2024.
//

import SwiftUI

struct EmailField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var body: some View {
        HStack(spacing: .zero) {
            Image(systemName: "envelope.fill")
                .foregroundStyle(.cBlue)

            TextField("", text: $text)
                .submitLabel(.done)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .allPadding()
        }
        .hPadding()
        .background(
            RoundedRectangle(cornerRadius: .normal)
                .fill(Color(.cGray))
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
        )
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    EmailField(text: .constant("Email"))
        .allPadding()
}
