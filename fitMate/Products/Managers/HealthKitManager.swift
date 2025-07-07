//
//  HealthKitManager.swift
//  fitMate
//
//  Created by Emre Simsek on 29.04.2025.
//

import Foundation
import HealthKit

@Observable
final class HealthKitManager {
    private let healthStore = HKHealthStore()
    private let healthDataService = AppContainer.shared.healthDataService
    private let userSessionManager = AppContainer.shared.userSessionManager
    var stepCount: Double = 0
    var activeEnergyBurned: Double = 0
    var distanceWalkingRunning: Double = 0
    var averageHeartRate: Double = 0
    var sleepHours: Double = 0

    init() { Task { await requestAuthorization() } }

    func clearManager() {
        stepCount = 0
        activeEnergyBurned = 0
        distanceWalkingRunning = 0
        averageHeartRate = 0
        sleepHours = 0
    }

    private func requestAuthorization() async {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data not available.")
            return
        }

        let typesToRead: Set<HKObjectType> = [
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMass)!,
            HKQuantityType.quantityType(forIdentifier: .height)!,
            HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!,
        ]

        do {
            try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
            await fetchAllData()
        } catch {
            print("Authorization error: \(error.localizedDescription)")
        }
    }

    func fetchAllData() async {
        async let steps = fetchStepCountToday()
        async let energy = fetchActiveEnergyBurnedToday()
        async let distance = fetchDistanceWalkingRunningToday()
        async let heartRate = fetchAverageHeartRateToday()
        async let sleep = fetchSleepHoursToday()

        stepCount = await steps
        activeEnergyBurned = await energy
        distanceWalkingRunning = await distance
        averageHeartRate = await heartRate
        sleepHours = await sleep
    }

    private func fetchStepCountToday() async -> Double {
        await fetchSum(for: .stepCount, unit: .count())
    }

    private func fetchActiveEnergyBurnedToday() async -> Double {
        await fetchSum(for: .activeEnergyBurned, unit: .kilocalorie())
    }

    private func fetchDistanceWalkingRunningToday() async -> Double {
        await fetchSum(for: .distanceWalkingRunning, unit: .meter())
    }

    private func fetchAverageHeartRateToday() async -> Double {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let now = Date()

        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        return await withCheckedContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
                guard let result = result, let avg = result.averageQuantity() else {
                    continuation.resume(returning: 0)
                    return
                }
                continuation.resume(returning: avg.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())))
            }
            healthStore.execute(query)
        }
    }

    private func fetchSleepHoursToday() async -> Double {
        let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let now = Date()

        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        return await withCheckedContinuation { continuation in
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, _ in
                guard let samples = samples as? [HKCategorySample] else {
                    continuation.resume(returning: 0)
                    return
                }

                let sleepSeconds = samples
                    .filter { $0.value == HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue }
                    .reduce(0) { $0 + $1.endDate.timeIntervalSince($1.startDate) }

                continuation.resume(returning: sleepSeconds / 3600) // saate çeviriyoruz
            }
            healthStore.execute(query)
        }
    }

    private func fetchSum(for identifier: HKQuantityTypeIdentifier, unit: HKUnit) async -> Double {
        let quantityType = HKQuantityType.quantityType(forIdentifier: identifier)!

        let startOfDay = Calendar.current.startOfDay(for: Date())
        let now = Date()

        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        return await withCheckedContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
                guard let result = result, let sum = result.sumQuantity() else {
                    continuation.resume(returning: 0)
                    return
                }
                continuation.resume(returning: sum.doubleValue(for: unit))
            }
            healthStore.execute(query)
        }
    }

    func saveTodayHealthData() async {
        guard let userID = userSessionManager.currentUser?.id else {
            return
        }

        let todayDateString = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
            .replacingOccurrences(of: "/", with: "-")

        let healthData = HealthDataModel(
            dateString: todayDateString,
            stepCount: stepCount,
            activeEnergyBurned: activeEnergyBurned,
            distanceWalkingRunning: distanceWalkingRunning,
            averageHeartRate: averageHeartRate,
            sleepHours: sleepHours
        )

        healthDataService.saveHealthData(healthData, for: userID)
    }

    func fetchWeeklySteps() async -> Double {
        await withCheckedContinuation { continuation in
            guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                continuation.resume(returning: 0)
                return
            }

            let calendar = Calendar.current
            let now = Date()
            guard let startDate = calendar.date(byAdding: .day, value: -6, to: now) else {
                continuation.resume(returning: 0)
                return
            }

            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)

            var interval = DateComponents()
            interval.day = 1

            let query = HKStatisticsCollectionQuery(
                quantityType: stepType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: startDate,
                intervalComponents: interval
            )

            query.initialResultsHandler = { _, results, _ in
                var totalSteps: Double = 0
                results?.enumerateStatistics(from: startDate, to: now) { stat, _ in
                    if let quantity = stat.sumQuantity() {
                        totalSteps += quantity.doubleValue(for: .count())
                    }
                }
                continuation.resume(returning: totalSteps)
            }

            HKHealthStore().execute(query)
        }
    }
}
