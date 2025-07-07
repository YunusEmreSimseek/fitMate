//
//  FirebaseSetup.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SwiftUI

/// Firebase setup class
final class AppDelegate: NSObject, UIApplicationDelegate {
    private var startupStateManager = AppContainer.shared.appStartupStateManager
    func application(
        _: UIApplication,

        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        Task {
            let result = await self.checkUserSessionOnLaunch()
            if result {
                await self.loadUserWorkoutManager()
                await self.loadUserDietManager()
            }
            startupStateManager.state = .loaded
        }
        return true
    }

    private func checkUserSessionOnLaunch(
        userService: IUserService = AppContainer.shared.userService,
        userAuthService: IUserAuthService = AppContainer.shared.userAuthService,
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
        userWorkoutManager _: UserWorkoutManager = AppContainer.shared.userWorkoutManager
    ) async -> Bool {
        guard let user = userAuthService.checkAuthUser() else {
            return false
        }

        do {
            let user = try await userService.fetchUser(by: user.uid)
            userSessionManager.updateSession(user)
            return true
        } catch {
            return false
        }
    }

    private func loadUserWorkoutManager(
        userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager,
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager
    ) async {
        guard userSessionManager.currentUser?.id != nil else { return }
        await userWorkoutManager.loadManager()
    }

    private func loadUserDietManager(
        userDietManager: UserDietManager = AppContainer.shared.userDietManager,
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager
    ) async {
        guard userSessionManager.currentUser?.id != nil else { return }
        await userDietManager.loadManager()
    }
}
