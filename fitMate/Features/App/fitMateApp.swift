//
//  fitMateApp.swift
//  fitMate
//
//  Created by Emre Simsek on 31.10.2024.
//

import FirebaseAuth
import FirebaseCore
import SwiftUI

@Observable
final class AppStartupStateManager {
    enum LaunchState {
        case loading
        case loaded
    }

    var state: LaunchState = .loading
}

@main
struct fitMateApp: App {
    // App delegate for Initialize
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private var startupState = AppContainer.shared.appStartupStateManager

    // App environments
    @State var userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager
    @State var navigationManager: NavigationManager = AppContainer.shared.navigationManager
    @State var healthKitManager: HealthKitManager = AppContainer.shared.healthKitManager
    @State var goalManager: GoalManager = AppContainer.shared.goalManager
    @State var userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager
    @State var userDietManager: UserDietManager = AppContainer.shared.userDietManager
    @State var unitManager: UnitManager = AppContainer.shared.unitManager

    var body: some Scene {
        WindowGroup {
            NavigationContainer(navigationManager: navigationManager) {
                Group {
                    switch startupState.state {
                    case .loading:
                        SplashView()
                    case .loaded:
                        RootRouterView()
                    }
                }
            }
        }
        .environment(userSessionManager)
        .environment(healthKitManager)
        .environment(goalManager)
        .environment(userWorkoutManager)
        .environment(userDietManager)
        .environment(unitManager)
        .environment(startupState)
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
                        isFirstLaunch = false
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
