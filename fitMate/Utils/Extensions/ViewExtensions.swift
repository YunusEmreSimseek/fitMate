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

    func dynamicHeight(_ ratio: CGFloat) -> some View {
        GeometryReader { geometry in
            self.frame(height: geometry.size.height * ratio)
        }
    }

    func dynamicWidth(_ ratio: CGFloat) -> some View {
        GeometryReader { geometry in
            self.frame(width: geometry.size.width * ratio)
        }
    }

    func dynamicSize(width ratioWidth: CGFloat, height ratioHeight: CGFloat) -> some View {
        GeometryReader { geometry in
            self.frame(width: geometry.size.width * ratioWidth, height: geometry.size.height * ratioHeight)
        }
    }
}
