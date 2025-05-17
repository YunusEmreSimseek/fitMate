//
//  PasswordField.swift
//  fitMate
//
//  Created by Emre Simsek on 2.11.2024.
//

import SwiftUI

struct PasswordField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var body: some View {
        HStack(spacing: .zero) {
            Image(systemName: "lock.fill")
                .foregroundStyle(.cBlue)
            SecureField("", text: $text)
                .font(.normal)
                .keyboardType(.asciiCapable)
                .textContentType(.password)
                .submitLabel(.done)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .focused($isFocused)
                .allPadding(.medium3)
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
    PasswordField(text: .constant("Password"))
}
