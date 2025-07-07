//
//  AverageProgressCard.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct AverageProgressCard: View {
    @Environment(UserDietManager.self) private var userDietManager
    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text(LocaleKeys.Diet.ActiveState.Average.title.localized)
                .font(.headline)

            HStack(spacing: .medium2) {
                ProgressStatView(title: LocaleKeys.Diet.ActiveState.Average.remainingDays.localized, value: "\(userDietManager.calculateRemainingDays())", icon: "calendar.badge.clock")
                ProgressStatView(title: LocaleKeys.Diet.ActiveState.Average.averageCalories.localized, value: "\(userDietManager.calculateAverageCalories()) \(StringConstants.CalorieMeasurement)", icon: "flame.fill")
                ProgressStatView(title: LocaleKeys.Diet.ActiveState.Average.averageSteps.localized, value: "\(userDietManager.calculateAverageSteps())", icon: "figure.walk")
            }
        }
        .card()
    }
}

struct ProgressStatView: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: .low3) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.cBlue)

            Text(value)
                .font(.headline)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
