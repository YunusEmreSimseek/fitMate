//
//  ProfileUserImage.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//
import SwiftUI

struct ProfileUserImage: View {
    var body: some View {
        Image(.profile1)
            .resizable()
            .scaledToFit()
            .frame(height: .dynamicHeight(height: 0.12))
            .allPadding(.low2)
            .background(Circle().fill(.cGray))
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 4)
    }
}
