//
//  WelcomeView.swift
//  fitMate
//
//  Created by Emre Simsek on 1.11.2024.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(NavigationManager.self) private var navigationManager

    var body: some View {
        ZStack {
            DynamicBgImage()
            VStack {
                Spacer()
                VStack {
                    TitlesColumn()
                        .bottomPadding(.high)
                    RoundedRectangelButton(title: LocaleKeys.WelcomeView.getStarted.localized, onTap: {
                        navigationManager.navigate(to_: .signUp)
                    })
                }
            }
            .allPadding()
            .bottomPadding(.high)
        }
    }
}

#Preview {
    WelcomeView()
}

private struct TitlesColumn: View {
    var body: some View {
        VStack {
            AppNameText()
            Text(LocaleKeys.WelcomeView.subTitle.localized)
        }
    }
}
