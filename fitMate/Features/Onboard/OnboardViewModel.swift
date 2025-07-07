//
//  OnboardViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import SwiftUI

@Observable
final class OnboardViewModel {
    let totalParts: Int = 2
    var progress: Int = 0
    var isLoading: Bool = false
    var currentUser: UserModel
    var selectedGender: Gender = .male
    var selectedDate: Date = .init()
    var selectedHeight: Int = 175
    var selectedWeight: Int = 75
    var selectedGoals: [String] = []

    private let userSessionManager: UserSessionManager
    private let navigationManager: NavigationManager
    private let userService: IUserService
    private let chatService: IChatService

    init(currentUser: UserModel,
         userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         navigationManager: NavigationManager = AppContainer.shared.navigationManager,
         userService: IUserService = AppContainer.shared.userService,
         chatService: IChatService = AppContainer.shared.chatService)
    {
        self.currentUser = currentUser
        self.userSessionManager = userSessionManager
        self.navigationManager = navigationManager
        self.userService = userService
        self.chatService = chatService
    }

    func inclineProgress() {
        guard progress < totalParts else {
            Task { await saveAndNavigateToHomeView() }
            return
        }
        progress += 1
    }

    func declineProgress() {
        guard progress > 0 else {
            return
        }
        progress -= 1
    }

    func saveAndNavigateToHomeView() async {
        isLoading = true
        defer { isLoading = false }
//        currentUser.gender = selectedGender
        currentUser.birthDate = selectedDate
        currentUser.height = selectedHeight
        currentUser.weight = selectedWeight
//        currentUser.goals = selectedGoals
        currentUser.stepGoal = 10000
        currentUser.calorieGoal = 500
        currentUser.sleepGoal = 8
        do {
            try await userService.updateUser(user: currentUser)
            print("Kullanıcı başarıyla güncellendi : \(currentUser)")
            userSessionManager.updateSession(currentUser)
            try await chatService.createInitialChats(for: currentUser.id!)
            navigationManager.navigate(to_: .tabRoot)
        } catch {
            print("Kullanıcı güncellenemedi: \(error.localizedDescription)")
        }
    }

    func changeGender(gender _: Gender) {
//        selectedGender = gender
    }

    func selectGoal(goal: GoalModel) {
        selectedGoals.append(goal.title)
    }

    func disSelectGoal(goal: GoalModel) {
        selectedGoals.removeAll { goalTitle in
            goalTitle == goal.title
        }
    }
}
