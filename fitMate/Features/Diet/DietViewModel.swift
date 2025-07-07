//
//  DietViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//

import Foundation

@Observable
final class DietViewModel {
    var isLoading = false
    var showStartSheet = false
    var activeSheet: ActiveSheet?
    var showAddDietPlanSuccessSnackbar = false
    var showAddDailyLogSuccessSnackbar = false

    let userDietManager: UserDietManager

    init(
        userDietManager: UserDietManager = AppContainer.shared.userDietManager
    ) {
        self.userDietManager = userDietManager
    }

    func saveDietPlan(_ plan: DietModel) async {
        isLoading = true
        defer { isLoading = false }
        await userDietManager.addDietPlan(plan)
        showAddDietPlanSuccessSnackbar = true
    }

    func saveDailyLog(log: DailyDietModel) async {
        isLoading = true
        defer { isLoading = false }
        await userDietManager.addDailyLog(log)
        showAddDailyLogSuccessSnackbar = true
    }

    enum ActiveSheet: Identifiable {
        case addDietPlan
        case addDailyLog

        var id: String {
            switch self {
            case .addDietPlan: return "addDietPlan"
            case .addDailyLog: return "addDailyLog"
            }
        }
    }
}
