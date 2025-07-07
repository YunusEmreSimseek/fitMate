//
//  HomeViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//
import Foundation

@Observable
final class HomeViewModel {
    private var healthKitManager: HealthKitManager

    init(healthKitManager: HealthKitManager) {
        self.healthKitManager = healthKitManager
    }

    var healthDataItems: [HealthDataItem] {
        [
            HealthDataItem(title: LocaleKeys.Home.HealthItems.steps.localized, value: "\(Int(healthKitManager.stepCount))", unit: LocaleKeys.Measurement.steps.localized),
            HealthDataItem(title: LocaleKeys.Home.HealthItems.calories.localized, value: String(format: "%.0f", healthKitManager.activeEnergyBurned), unit: LocaleKeys.Measurement.calories.localized),
            HealthDataItem(title: LocaleKeys.Home.HealthItems.distance.localized, value: String(format: "%.2f", healthKitManager.distanceWalkingRunning / 1000), unit: StringConstants.kmMeasurement),
            HealthDataItem(title: LocaleKeys.Home.HealthItems.heartRate.localized, value: String(format: "%.0f", healthKitManager.averageHeartRate), unit: LocaleKeys.Measurement.bpm.localized),
        ]
    }

    let motivationMessages: [String] = [
        LocaleKeys.Home.Motivation.first.localized,
        LocaleKeys.Home.Motivation.second.localized,
        LocaleKeys.Home.Motivation.third.localized,
        LocaleKeys.Home.Motivation.fourth.localized,
    ]

    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5 ..< 12:
            return LocaleKeys.Home.NavTime.goodMorning
        case 12 ..< 17:
            return LocaleKeys.Home.NavTime.goodAfternoon
        case 17 ..< 22:
            return LocaleKeys.Home.NavTime.goodEvening
        default:
            return LocaleKeys.Home.NavTime.goodNight
        }
    }
}
