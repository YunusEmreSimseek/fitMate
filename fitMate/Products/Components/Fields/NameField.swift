//
//  NameField.swift
//  fitMate
//
//  Created by Emre Simsek on 15.04.2025.
//

import SwiftUI

struct NameField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    var body: some View {
        HStack(spacing: .low2) {
            Image(systemName: "person.fill")
                .foregroundStyle(.cBlue)
            TextField("", text: $text)
//                .font(.normal)
                .submitLabel(.done)
                .keyboardType(.default)
                .textContentType(.name)
                .textInputAutocapitalization(.words)
                .focused($isFocused)
                .allPadding()
        }
        .hPadding()
        .background(
            RoundedRectangle(cornerRadius: .normal)
                .fill(Color(.cGray))
                .shadow(color: Color.black.opacity(0.1), radius: 6)
        )
        .contentShape(RoundedRectangle(cornerRadius: .normal))
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    ZStack {
        Image(.aiCoach2)
            .resizable()
            .opacity(0.85)

        NameField(text: .constant(""))
            .allPadding()
    }
}
