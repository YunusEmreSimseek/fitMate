//
//  DailyDietLogList.swift
//  fitMate
//
//  Created by Emre Simsek on 18.05.2025.
//
import SwiftUI

struct DailyDietLogList: View {
    @Environment(ActiveDietDashboradViewModel.self) private var viewModel
    @Environment(UserDietManager.self) private var userDietManager
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(alignment: .leading, spacing: .low) {
            Text(LocaleKeys.Diet.ActiveState.dailyLogsTitle.localized)
                .font(.headline)

            ForEach(userDietManager.dailyLogs ?? []) { log in
                DietLogListItem(log: log)
                    .onTapGesture {
                        viewModel.selectedLog = log
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.onDeleteLog(log)
                        } label: {
                            Label(LocaleKeys.Button.delete.localized, systemImage: "trash")
                        }
                    }
            }
        }
        .alert(LocaleKeys.Diet.ActiveState.deleteLogConfirmation.localized, isPresented: $viewModel.showDeleteLogConfirmation) {
            AlertDeleteButtons { await viewModel.deleteLog() }
        }
    }
}

private struct DietLogListItem: View {
    let log: DailyDietModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(log.dateString)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                HStack(spacing: 12) {
                    Label("\(log.stepCount ?? 0)", systemImage: "figure.walk")
                    Label("\(log.caloriesTaken ?? 0) \(StringConstants.CalorieMeasurement)", systemImage: "flame")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .card()
    }
}
