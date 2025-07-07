//
//  UserDietManager.swift
//  fitMate
//
//  Created by Emre Simsek on 16.06.2025.
//
import SwiftUI

@Observable
final class UserDietManager {
    private let userSessionManager: UserSessionManager
    private let dietService: DietService
    private let healthKitManager: HealthKitManager

    var dietPlan: DietModel?
    var dailyLogs: [DailyDietModel]?
    var isLoaded: Bool = false

    init(userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         dietService: DietService = AppContainer.shared.dietService,
         healthKitManager: HealthKitManager = AppContainer.shared.healthKitManager)
    {
        self.userSessionManager = userSessionManager
        self.dietService = dietService
        self.healthKitManager = healthKitManager
        if AppMode.isPreview {
            dietPlan = DietModel.dummyDiet
            dailyLogs = DailyDietModel.dummyLogs
        }
    }

    func loadManager() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        guard !isLoaded else { return }
        dietPlan = await dietService.fetchDiet(for: userId)
        dailyLogs = await dietService.fetchDailyDietLogs(for: userId, lastDays: 30)
        isLoaded = true
    }

    func clearManager() {
        dietPlan = nil
        dailyLogs = nil
        isLoaded = false
    }

    func loadDietPlan() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        dietPlan = await dietService.fetchDiet(for: userId)
    }

    func loadDailyLogs() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        dailyLogs = await dietService.fetchDailyDietLogs(for: userId, lastDays: 30)
    }

    func addDietPlan(_ diet: DietModel) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        await dietService.saveDiet(diet, for: userId)
        await loadDietPlan()
    }

    func addDailyLog(_ log: DailyDietModel) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        await dietService.saveOrUpdateDailyDietLog(log, for: userId)
        await loadDailyLogs()
    }

    func deletedailyLog(_ log: DailyDietModel) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        await dietService.deleteDailyDietLog(for: userId, dateString: log.dateString)
        await loadDailyLogs()
    }

    func calculateRemainingDays() -> Int {
        guard dietPlan != nil else { return 0 }
        return Calendar.current.dateComponents([.day], from: .now, to: dietPlan!.endDate).day ?? 0
    }

    func calculateAverageCalories() -> Int {
        guard let dailyLogs = dailyLogs else { return 0 }
        let values = dailyLogs.compactMap { $0.caloriesTaken }
        return values.isEmpty ? 0 : values.reduce(0, +) / values.count
    }

    func calculateAverageSteps() -> Int {
        guard let dailyLogs = dailyLogs else { return 0 }
        let values = dailyLogs.compactMap { $0.stepCount }
        return values.isEmpty ? 0 : values.reduce(0, +) / values.count
    }

    func loadStepCount() async -> Int {
        await healthKitManager.fetchAllData()
        return Int(healthKitManager.stepCount)
    }

    func calculateThisWeeksLogCount() -> Int {
        guard let logs = dailyLogs else { return 0 }

        let calendar = Calendar.current
        let now = Date()

        return logs.filter { log in
            guard let date = log.dateFromString() else {
                return false
            }
            return calendar.isDate(date, equalTo: now, toGranularity: .weekOfYear)
        }.count
    }

    func weeklyStepCount() -> Int {
        guard let dailyLogs = dailyLogs else { return 0 }

        let calendar = Calendar.current
        let now = Date()
        guard let weekAgo = calendar.date(byAdding: .day, value: -6, to: now) else { return 0 }

        return dailyLogs.compactMap { log in
            guard let date = log.dateFromString() else { return 0 }
            return (date >= weekAgo && date <= now) ? log.stepCount : nil
        }
        .reduce(0, +)
    }
}
