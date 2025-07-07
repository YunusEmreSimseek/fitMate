//
//  StartDietPlanSheet.swift
//  fitMate
//
//  Created by Emre Simsek on 9.06.2025.
//

import SwiftUI

struct StartDietPlanSheet: View {
    @Environment(DietViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var duration = 30
    @State private var weightLoss = 5.0
    @State private var targetWeight = 70.0
    @State private var dailySteps = 10000
    @State private var dailyCalories = 2200
    @State private var dailyProtein = 100
    @State private var dailyWater = 2.5

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocaleKeys.Diet.AddDiet.durationTitle.localized)) {
                    Stepper("\(LocaleKeys.Diet.AddDiet.duration.localized): \(duration) \(LocaleKeys.Measurement.days.localized)", value: $duration, in: 7 ... 120)
                }

                Section(header: Text(LocaleKeys.Diet.AddDiet.weightGoalTitle.localized)) {
                    HStack {
                        Text("\(LocaleKeys.Diet.AddDiet.loseWeightGoal.localized):")
                        Spacer()
                        TextField("kg", value: $weightLoss, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }

                    HStack {
                        Text("\(LocaleKeys.Diet.AddDiet.weightGoal.localized):")
                        Spacer()
                        TextField("kg", value: $targetWeight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                }

                Section(header: Text(LocaleKeys.Diet.AddDiet.dailyGoalsTitle.localized)) {
                    LabeledIntField(label: LocaleKeys.Diet.AddDiet.stepCount.localized, value: $dailySteps, unit: LocaleKeys.Measurement.steps.localized)
                    LabeledIntField(label: LocaleKeys.Diet.AddDiet.calorieLimit.localized, value: $dailyCalories, unit: "kcal")
                    LabeledIntField(label: LocaleKeys.Diet.AddDiet.proteinGoal.localized, value: $dailyProtein, unit: "gram")
                }
            }
            .navigationTitle(LocaleKeys.Diet.AddDiet.navTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        Task {
                            let plan = DietModel(
                                startDate: .now,
                                durationInDays: duration,
                                weightLossGoalKg: weightLoss,
                                targetWeight: targetWeight,
                                dailyStepGoal: dailySteps,
                                dailyCalorieLimit: dailyCalories,
                                dailyProteinGoal: dailyProtein
                            )
                            await viewModel.saveDietPlan(plan)
                            viewModel.activeSheet = nil
                        }
                    }
                    .disabled(!validateInputs())
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button(LocaleKeys.Button.cancel.localized) {
                        viewModel.activeSheet = nil
                    }
                }
            }
        }
    }
}

private struct LabeledIntField: View {
    let label: String
    @Binding var value: Int
    let unit: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            TextField(unit, value: $value, format: .number)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 80)
        }
    }
}

extension StartDietPlanSheet {
    private func validateInputs() -> Bool {
        guard duration > 0, weightLoss >= 0, targetWeight > 0, dailySteps > 0, dailyCalories > 0, dailyProtein > 0 else {
            return false
        }
        return true
    }
}
