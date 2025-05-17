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
            HealthDataItem(title: "Steps", value: "\(Int(healthKitManager.stepCount))", unit: "steps"),
            HealthDataItem(title: "Calories", value: String(format: "%.0f", healthKitManager.activeEnergyBurned), unit: "kcal"),
            HealthDataItem(title: "Distance", value: String(format: "%.2f", healthKitManager.distanceWalkingRunning / 1000), unit: "km"),
            HealthDataItem(title: "Heart Rate", value: String(format: "%.0f", healthKitManager.averageHeartRate), unit: "bpm"),
            HealthDataItem(title: "Sleep", value: String(format: "%.1f", healthKitManager.sleepHours), unit: "hrs"),
        ]
    }

    let motivationMessages: [String] = [
        "Discipline is doing it even when you don’t feel like it.",
        "A little progress each day adds up to big results.",
        "Sweat. Smile. Repeat.",
        "Train your mind and your body will follow.",
    ]

    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5 ..< 12:
            return LocaleKeys.Home.goodMorning
        case 12 ..< 17:
            return LocaleKeys.Home.goodAfternoon
        case 17 ..< 22:
            return LocaleKeys.Home.goodEvening
        default:
            return LocaleKeys.Home.goodNight
        }
    }
}
