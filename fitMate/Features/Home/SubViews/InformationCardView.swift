//
//  InformationCardView.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//

import SwiftUI

struct InformationCardView: View {
    let title: String
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: .low2) {
            Text(title)
                .font(.subheadline)
                .bold()
                .foregroundStyle(.secondary)
            Text(text)
                .font(.headline)
                .bold()
        }
        .frame(width: .dynamicWidth(width: 0.35), alignment: .leading)
        .vPadding(.low3)
        .card(cornerRadius: .low, padding: .low)
    }
}

// #Preview {
//    InformationCardView()
// }
