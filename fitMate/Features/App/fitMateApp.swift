//
//  fitMateApp.swift
//  fitMate
//
//  Created by Emre Simsek on 31.10.2024.
//

import FirebaseAuth
import FirebaseCore
import SwiftUI

@main
struct fitMateApp: App {
    // App delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // App launch check
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true

    // App environments
    @State var userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager
    @State var navigationManager: NavigationManager = AppContainer.shared.navigationManager
    @State var healthKitManager: HealthKitManager = AppContainer.shared.healthKitManager
    @State var goalManager: GoalManager = AppContainer.shared.goalManager

    var body: some Scene {
        WindowGroup {
            NavigationContainer(navigationManager: navigationManager) {
                RootRouterView()
            }
        }
        .environment(userSessionManager)
        .environment(healthKitManager)
        .environment(goalManager)
    }
}

private struct RootRouterView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @Environment(UserSessionManager.self) private var userSessionManager

    var body: some View {
        if isFirstLaunch {
            if userSessionManager.isLoggedIn {
                TabRootView()
            } else {
                WelcomeView()
                    .onAppear {
                        // isFirstLaunch = false // use when ready to disable onboarding
                    }
            }
        } else {
            if userSessionManager.isLoggedIn {
                TabRootView()
            } else {
                LoginView()
            }
        }
    }
}

private struct NavigationContainer<Content: View>: View {
    @State var navigationManager: NavigationManager
    @ViewBuilder var content: () -> Content
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            content()
                .navigationDestination(
                    for: NavigationManager.PushDestination.self
                ) { destination in
                    switch destination {
                    case .login:
                        LoginView().navigationBarBackButtonHidden()
                    case .signUp:
                        SignUpView().navigationBarBackButtonHidden()
                    case let .onboard(user):
                        OnboardView(user: user)
                            .navigationBarBackButtonHidden()
                    case .tabRoot:
                        TabRootView().navigationBarBackButtonHidden()
                    }
                }
        }
        .environment(navigationManager)
    }
}
