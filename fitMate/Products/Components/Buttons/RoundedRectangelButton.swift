//
//  RoundedRectangeButton.swift
//  fitMate
//
//  Created by Emre Simsek on 1.11.2024.
//

import SwiftUI

struct RoundedRectangelButton: View {
    let title: String
    var background: Color = .cBlue
    var vPadding: CGFloat = .normal
    var hPadding: CGFloat = .normal
    var disabled: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Spacer()
                Text(title)
                    .hPadding(hPadding)
                    .vPadding(vPadding)
                    .foregroundStyle(.foreground)
                    .fontWeight(.semibold)
                Spacer()
            }
            .background(disabled ? .secondary : background)
            .clipShape(.rect(cornerRadius: .low))
        }
        .disabled(disabled)
    }
}

struct RoundedRectangelButton2: View {
    let title: String
    var background: Color?
    var foreground: Color?
    var disabled: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .frame(maxWidth: .infinity)
                .vPadding(.low3)
                .fontWeight(.semibold)
                .if(background != nil) { view in
                    view.background(background!)
                }
                .if(foreground != nil) { view in
                    view.foregroundStyle(foreground!)
                }
        }
        .disabled(disabled)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    RoundedRectangelButton(title: "Get Started", onTap: {})
        .allPadding()
}
