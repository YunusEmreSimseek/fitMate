//
//  SnackBarModifier.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct SnackBarModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var isPresented: Bool
    let message: String

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer()
                    Text(message)
                        .font(.subheadline)
                        .allPadding()
                        .background(
                            RoundedRectangle(cornerRadius: .low)
                                .fill(colorScheme == .dark ? .blue : .cBlue)
                                .shadow(color: .black.opacity(0.1), radius: 4)
                        )
                        .foregroundColor(.primary)
//                        .clipShape(Capsule())
                        .bottomPadding(.medium3)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.3), value: isPresented)
                }
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func snackBar(isPresented: Binding<Bool>, message: String) -> some View {
        modifier(SnackBarModifier(isPresented: isPresented, message: message))
    }
}
