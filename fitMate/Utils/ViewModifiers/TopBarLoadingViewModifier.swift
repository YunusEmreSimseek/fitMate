//
//  loadingModifier.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//
import SwiftUI

struct TopBarLoadingViewModifier: ViewModifier {
    var isLoading: Bool
    func body(content: Content) -> some View {
        return
            content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    LoadingView(isLoading: isLoading)
                }
            }
    }
}
