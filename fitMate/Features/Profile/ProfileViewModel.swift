//
//  NewProfileViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//

import SwiftUI

@Observable
final class ProfileViewModel {
    var showGeneralSheet = false
    var showLogoutAlert = false
    var showNotificationSheet = false
    var showUnitsSheet = false
    var showUserUpdateSuccessSnackbar = false
    var updatedUser: UserModel?
    var checkForUpdates: Bool {
        guard let user = userSessionManager.currentUser else { return false }
        if user != updatedUser {
            return true
        }
        return false
    }

    private let userSessionManager: UserSessionManager
    private let navigationManager: NavigationManager
    private let userAuthService: IUserAuthService
    let userWorkoutManager: UserWorkoutManager
    let userDietManager: UserDietManager
    private let healthKitManager: HealthKitManager

    init(userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         navigationManager: NavigationManager = AppContainer.shared.navigationManager,
         userAuthService: IUserAuthService = AppContainer.shared.userAuthService,
         userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager,
         userDietManager: UserDietManager = AppContainer.shared.userDietManager,
         healthKitManager: HealthKitManager = AppContainer.shared.healthKitManager)
    {
        self.userSessionManager = userSessionManager
        self.navigationManager = navigationManager
        self.userAuthService = userAuthService
        self.userWorkoutManager = userWorkoutManager
        self.userDietManager = userDietManager
        self.healthKitManager = healthKitManager
        if AppMode.isPreview {
            updatedUser = .dummyUser
        } else {
            updatedUser = userSessionManager.currentUser
        }
    }

    func signOut() {
        let result = userAuthService.signOut()
        guard result else { return }
        navigationManager.navigate(to_: .login)
        userWorkoutManager.clearManager()
        userDietManager.clearManager()
        healthKitManager.clearManager()
        userSessionManager.clearSession()
    }

    func updateUser() async -> Bool {
        guard userSessionManager.currentUser != nil else { return false }
        guard updatedUser != nil else { return false }
        await userSessionManager.updateUser(updatedUser!)
        return true
    }
}
