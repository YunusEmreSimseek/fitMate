//
//  DietSummaryCard.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct DietSummaryCard: View {
    @Environment(UserDietManager.self) private var userDietManager
    var body: some View {
        if let dietPlan = userDietManager.dietPlan {
            VStack(alignment: .leading, spacing: .medium) {
                HStack {
                    VStack(alignment: .leading, spacing: .low2) {
                        Text(LocaleKeys.Diet.ActiveState.Summary.title.localized)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("\(dietPlan.durationInDays) \(LocaleKeys.Diet.ActiveState.Summary.plan.localized)")
                            .font(.title3.bold())
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: .low2) {
                        Text(LocaleKeys.Diet.ActiveState.Summary.remainingDays.localized)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("\(userDietManager.calculateRemainingDays())")
                            .font(.title3.bold())
                            .foregroundStyle(.cBlue)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: .low) {
                    HStack {
                        Image(systemName: "scalemass")
                        Text("\(LocaleKeys.Diet.ActiveState.Summary.weightGoal.localized): \(dietPlan.targetWeight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)")
                    }

                    HStack {
                        Image(systemName: "flame")
                        Text("\(LocaleKeys.Diet.ActiveState.Summary.calorieLimit.localized): \(dietPlan.dailyCalorieLimit) \(StringConstants.CalorieMeasurement)")
                    }

                    HStack {
                        Image(systemName: "figure.walk")
                        Text("\(LocaleKeys.Diet.ActiveState.Summary.stepGoal.localized): \(dietPlan.dailyStepGoal)")
                    }

                    HStack {
                        Image(systemName: "bolt")
                        Text("\(LocaleKeys.Diet.ActiveState.Summary.proteinGoal.localized): \(dietPlan.dailyProteinGoal) \(StringConstants.MacroMeasurement)")
                    }
                }
                .font(.subheadline)
            }
            .card()
        }
    }
}
