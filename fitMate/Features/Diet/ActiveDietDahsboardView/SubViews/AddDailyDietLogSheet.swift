//
//  AddDailyDietLogSheet.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct AddDailyDietLogSheet: View {
    @Environment(DietViewModel.self) private var viewModel

    @State private var date: Date = .now
    @State private var cardioMinutes: Int?
    @State private var caloriesTaken: Int?
    @State private var protein: Int?
    @State private var carbs: Int?
    @State private var fat: Int?
    @State private var weight: Double?
    @State private var note: String = ""
    @State private var stepCount: Int = 0

    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            Form {
                Section(LocaleKeys.Diet.AddLog.dateTitle.localized) {
                    DatePicker(LocaleKeys.Diet.AddLog.datePlaceholder.localized, selection: $date, displayedComponents: [.date])
                }
                Section(LocaleKeys.Diet.AddLog.stepsTitle.localized) {
                    HStack {
                        Label(LocaleKeys.Diet.AddLog.stepsPlaceholder.localized, systemImage: "figure.walk")
                        Spacer()
                        TextField("\(stepCount)", value: $stepCount, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                }

                Section(LocaleKeys.Diet.AddLog.dailyTitle.localized) {
                    DailyDietLogItem(label: LocaleKeys.Diet.AddLog.cardioTitle.localized, value: $cardioMinutes, unit: StringConstants.CardioMeasurement)
                    DailyDietLogItem(label: LocaleKeys.Diet.AddLog.caloriesTitle.localized, value: $caloriesTaken, unit: StringConstants.CalorieMeasurement)
                    DailyDietLogItem(label: LocaleKeys.Diet.AddLog.proteinTitle.localized, value: $protein, unit: StringConstants.MacroMeasurement)
                    DailyDietLogItem(label: LocaleKeys.Diet.AddLog.carbsTitle.localized, value: $carbs, unit: StringConstants.MacroMeasurement)
                    DailyDietLogItem(label: LocaleKeys.Diet.AddLog.fatsTitle.localized, value: $fat, unit: StringConstants.MacroMeasurement)
//                    LabeledDoubleField(label: "Kilo", value: $weight, unit: "kg")
                    TextField(LocaleKeys.Diet.AddLog.notesTitle.localized, text: $note)
                }
            }
            .navigationTitle(LocaleKeys.Diet.AddLog.navTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        Task {
                            let date = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
                                .replacingOccurrences(of: "/", with: "-")
                            let log = DailyDietModel(
                                id: date,
                                dateString: date,
                                stepCount: stepCount,
                                cardioMinutes: cardioMinutes,
                                caloriesTaken: caloriesTaken,
                                protein: protein,
                                carbs: carbs,
                                fat: fat,
                                weight: weight,
                                note: note
                            )

                            await viewModel.saveDailyLog(log: log)
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
            .task {
                stepCount = await viewModel.userDietManager.loadStepCount()
            }
        }
    }
}

private struct DailyDietLogItem: View {
    let label: String
    @Binding var value: Int?
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

extension AddDailyDietLogSheet {
    private func validateInputs() -> Bool {
        return stepCount >= 0 &&
            (cardioMinutes ?? 0) >= 0 &&
            (caloriesTaken ?? 0) >= 0 &&
            (protein ?? 0) >= 0 &&
            (carbs ?? 0) >= 0 &&
            (fat ?? 0) >= 0 &&
            weight.map { $0 >= 0 } ?? true
    }
}
