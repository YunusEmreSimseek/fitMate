//
//  HomeTabView.swift
//  fitMate
//
//  Created by Emre Simsek on 14.04.2025.
//

import SwiftUI

struct HomeTabView: View {
    @Environment(NavigationManager.self) private var navigationManager
    @Namespace private var animation
    var body: some View {
        @Bindable var navigationManager = navigationManager
        TabView(selection: $navigationManager.selectedTab) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label(LocaleKeys.HomeTabView.home.localized, systemImage: "house")
            }
            .tag(TabDestination.home)
            NavigationView {
                ChatView()
            }

            .tabItem {
                Label(LocaleKeys.HomeTabView.chat.localized, systemImage: "brain.head.profile")
            }
            .tag(TabDestination.chat)
            NavigationView {
                ProfileView()
            }

            .tabItem {
                Label(LocaleKeys.HomeTabView.profile.localized, systemImage: "person.circle")
            }
            .tag(TabDestination.profile)
        }
        .tint(.primary)
    }
}
