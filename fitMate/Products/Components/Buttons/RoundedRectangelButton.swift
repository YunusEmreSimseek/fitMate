//
//  RoundedRectangeButton.swift
//  fitMate
//
//  Created by Emre Simsek on 1.11.2024.
//

import SwiftUI

struct RoundedRectangelButton: View {
    let title: String
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            HStack{
                Spacer()
                Text(title)
                    .allPadding()
                    .foregroundStyle(.foreground)
                    .fontWeight(.semibold)
                Spacer()
            }
            .background(.cBlue)
            .clipShape(.rect(cornerRadius: .normal))
            
        }
    }
}

#Preview {
    RoundedRectangelButton(title: "Get Started", onTap: { })
        .allPadding()
}
