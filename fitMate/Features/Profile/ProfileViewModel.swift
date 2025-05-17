//
//  ProfileViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//

import Foundation

@Observable
final class ProfileViewModel {
    var currentUser: UserModel?
    var showLogoutAlert: Bool = false
    var stepGoal: Double
    var calorieGoal: Double
    var sleepGoal: Double

    private let userSessionManager: UserSessionManager
    private let navigationManager: NavigationManager
    private let goalManager: GoalManager
    private let userAuthService: IUserAuthService

    init(userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         navigationManager: NavigationManager = AppContainer.shared.navigationManager,
         goalManager: GoalManager = AppContainer.shared.goalManager,
         userAuthService: IUserAuthService = AppContainer.shared.userAuthService)
    {
        self.userSessionManager = userSessionManager
        self.navigationManager = navigationManager
        self.goalManager = goalManager
        self.userAuthService = userAuthService
        currentUser = userSessionManager.currentUser
        stepGoal = goalManager.stepGoal
        calorieGoal = goalManager.calorieGoal
        sleepGoal = goalManager.sleepGoal
    }

    func saveGoals() {
        goalManager.stepGoal = stepGoal
        goalManager.calorieGoal = calorieGoal
        goalManager.sleepGoal = sleepGoal
    }

    func calculateAge(from birthDate: Date) -> Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        return ageComponents.year ?? 0
    }

    func logout() {
        let response = userAuthService.signOut()
        if response {
            print("Çıkış başarılı")
            userSessionManager.clearSession()
            navigationManager.navigate(to_: .login)
        } else {
            print("Çıkış hatası")
        }
    }
}
