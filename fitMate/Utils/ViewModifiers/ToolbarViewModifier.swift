//
//  toolbarModifier.swift
//  fitMate
//
//  Created by Emre Simsek on 15.04.2025.
//

import SwiftUI

struct ToolbarViewModifier: ViewModifier {
    let view: AnyView
    let placement: ToolbarItemPlacement
    func body(content: Content) -> some View {
        return
            content
                .toolbar {
                    ToolbarItem(placement: placement) {
                        view
                    }
                }
    }
}
