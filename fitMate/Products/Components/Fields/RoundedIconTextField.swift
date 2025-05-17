//
//  RoundedIconTextField.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import SwiftUI

struct RoundedIconTextField: View {
    @Binding var text: String
    var body: some View {
        HStack(spacing: .low2) {
            Image(systemName: "person.fill")
                .foregroundStyle(.foreground)
            TextField("", text: $text)
                .font(.normal)
                .submitLabel(.done)
                .keyboardType(.default)
                .textInputAutocapitalization(.words)
        }
        .allPadding()
        .background(.backgroundField.opacity(0.5))
        .shadow(color: .gray.opacity(0.5), radius: 6)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    RoundedIconTextField(text:.constant(""))
        .allPadding()
}
