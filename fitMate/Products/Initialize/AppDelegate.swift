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
    func application(
        _: UIApplication,

        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        Task {
            await self.checkUserSessionOnLaunch()
        }
        return true
    }

    private func checkUserSessionOnLaunch(
        userService: IUserService = AppContainer.shared.userService,
        userAuthService: IUserAuthService = AppContainer.shared.userAuthService,
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager
    ) async {
        guard let user = userAuthService.checkAuthUser() else {
            return
        }

        do {
            let user = try await userService.fetchUser(by: user.uid)
            userSessionManager.updateSession(user)
        } catch {}
    }
}
