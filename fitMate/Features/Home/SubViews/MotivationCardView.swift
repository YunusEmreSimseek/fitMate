//
//  MotivationCardView.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//

import SwiftUI

struct MotivationCardView: View {
    let message: String
    let image: ImageResource
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [.black.opacity(0.1), .black.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                )
                .shadow(radius: 5)

            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .allPadding()
        }
    }
}

// #Preview {
//    MotivationCardView()
// }
