//
//  CardViewModifier.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct CardViewModifier: ViewModifier {
    let bgColor: Color
    let cornerRadius: CGFloat
    let padding: CGFloat

    func body(content: Content) -> some View {
        content
            .allPadding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(bgColor)
                    .shadow(color: .black.opacity(0.1), radius: 6)
            )
    }
}

extension View {
    func card(bgColor: Color = .cGray, cornerRadius: CGFloat = .normal, padding: CGFloat = .normal) -> some View {
        modifier(CardViewModifier(bgColor: bgColor, cornerRadius: cornerRadius, padding: padding))
    }
}
