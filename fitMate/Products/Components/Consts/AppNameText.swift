//
//  AppNameText.swift
//  fitMate
//
//  Created by Emre Simsek on 2.11.2024.
//

import SwiftUI

struct AppNameText: View {
    var body: some View {
        HStack(spacing: .low3) {
            Text(LocaleKeys.App.nameFirst.localized)
                .foregroundStyle(.primary)
            Text(LocaleKeys.App.nameLast.localized)
                .foregroundStyle(.cBlue)
        }
        .font(.system(size: .high))
        .fontWeight(.black)
    }
}

#Preview {
    AppNameText()
}
