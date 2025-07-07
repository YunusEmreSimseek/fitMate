//
//  DietLogDetailSheet.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct DietLogDetailSheet: View {
    let log: DailyDietModel

    var body: some View {
        VStack(spacing: 12) {
            Text(log.dateString)
                .font(.title3.bold())
                .padding(.top)

            Divider()

            Group {
                DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.steps.localized, value: "\(log.stepCount ?? 0)")
                DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.calories.localized, value: "\(log.caloriesTaken ?? 0) \(StringConstants.CalorieMeasurement)")
                DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.cardio.localized, value: "\(log.cardioMinutes ?? 0) \(LocaleKeys.General.shortMinutes.localized)")
                DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.protein.localized, value: "\(log.protein ?? 0) \(StringConstants.MacroMeasurement)")
                DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.carbs.localized, value: "\(log.carbs ?? 0) \(StringConstants.MacroMeasurement)")
                DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.fats.localized, value: "\(log.fat ?? 0) \(StringConstants.MacroMeasurement)")
//                if let weight = log.weight {
//                    DetailRow(title: "Kilo", value: "\(weight, specifier: "%.1f") kg")
//                }
                if let note = log.note, !note.isEmpty {
                    DetailRow(title: LocaleKeys.Diet.ActiveState.LogDetail.notes.localized, value: note)
                }
            }

            Spacer()
        }
        .padding()
    }
}

private struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.caption)
            Spacer()
            Text(value)
        }
    }
}
