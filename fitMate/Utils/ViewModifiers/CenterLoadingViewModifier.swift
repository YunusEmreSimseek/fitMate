//
//  CenterLoadingViewModifier.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//
import SwiftUI

struct CenterLoadingViewModifier: ViewModifier {
    let isLoading: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 1 : 0)

            if isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}
