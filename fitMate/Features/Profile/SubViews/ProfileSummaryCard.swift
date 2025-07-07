//
//  ProfileSummaryCard.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//
import SwiftUI

struct ProfileSummaryCard: View {
    let icon: String
    let value: String
    let title: String
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: .dynamicWidth(width: 0.06), height: .dynamicHeight(height: 0.03))
                .foregroundStyle(.primary)
                .allPadding(.low2)
                .background(Circle().fill(.cBlue.opacity(0.6)))
                .clipShape(Circle())
//                .shadow(radius: 5)
            Text(value).font(.subheadline).bold()
            Text(title).font(.footnote).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .allPadding(.low)
        .frame(width: .dynamicWidth(width: 0.275))
        .background(.cGray)
        .clipShape(.rect(cornerRadius: .low))
        .shadow(color: .black.opacity(0.1), radius: 6)
    }
}
