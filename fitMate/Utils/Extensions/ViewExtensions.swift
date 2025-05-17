//
//  ViewExtensions.swift
//  fitMate
//
//  Created by Emre Simsek on 15.04.2025.
//
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
