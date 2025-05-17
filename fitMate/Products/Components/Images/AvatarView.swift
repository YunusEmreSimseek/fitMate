//
//  AvatarView.swift
//  fitMate
//
//  Created by Emre Simsek on 15.04.2025.
//

import SwiftUI

struct AvatarView: View {
    let image: Image
    var size: AvatarSize = .medium
    var useBackground: Bool = true
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size.value, height: size.value)
            .clipShape(Circle())
            .if(useBackground) { view in
                view
                    .padding(2)
                    .background(Circle().fill(Color.gray.opacity(0.2)))
            }
    }
}

#Preview {
    AvatarView(image: Image(.aiCoach2))
}

enum AvatarSize {
    case small,small2, medium, medium2, large, large2

    var value: CGFloat {
        switch self {
        case .small: return .medium3
        case .small2: return .medium3 + 2
        case .medium: return .high3
        case .medium2: return .high3 + 2
        case .large: return .high2
        case .large2: return .high2 + 2
        }
    }
}
