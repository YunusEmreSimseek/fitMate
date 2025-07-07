//
//  ActiveDietDashboradViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//

import SwiftUI

@Observable
final class ActiveDietDashboradViewModel {
    var selectedLog: DailyDietModel?
    var showStartSheet = false
    var showLogSheet = false
    var showSuccessSnackBar = false
    var showDeleteLogConfirmation = false
    var deletingLog: DailyDietModel?
    var isLoading = false

    private let userSessionManager: UserSessionManager
    private let dietService: DietService
    private let navigationManager: NavigationManager
    private let healthKitManager: HealthKitManager
    let userDietManager: UserDietManager

    init(
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
        dietService: DietService = AppContainer.shared.dietService,
        navigationManager: NavigationManager = AppContainer.shared.navigationManager,
        healthKitManager: HealthKitManager = AppContainer.shared.healthKitManager,
        userDietManager: UserDietManager = AppContainer.shared.userDietManager
    ) {
        self.userSessionManager = userSessionManager
        self.dietService = dietService
        self.navigationManager = navigationManager
        self.healthKitManager = healthKitManager
        self.userDietManager = userDietManager
    }

    func saveDailyLog(log: DailyDietModel) async {
        isLoading = true
        defer { isLoading = false }
        await userDietManager.addDailyLog(log)
    }

    func onDeleteLog(_ log: DailyDietModel) {
        deletingLog = log
        showDeleteLogConfirmation = true
    }

    func deleteLog() async {
        guard let log = deletingLog else { return }
        isLoading = true
        defer { isLoading = false }
        await userDietManager.deletedailyLog(log)
    }
}
