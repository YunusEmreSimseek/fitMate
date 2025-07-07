//
//  LogListView.swift
//  fitMate
//
//  Created by Emre Simsek on 13.06.2025.
//

import SwiftUI

struct LogListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: LogListViewModel = .init()
    var body: some View {
        LazyVStack(alignment: .leading, spacing: .low3) {
            ForEach(viewModel.userWorkoutManager.logs) { log in
                VStack(alignment: .leading, spacing: .low3) {
                    LogView(log)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectedLog = log
                            viewModel.showLogDetailsSheet = true
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.onDeleteLog(log)
                            } label: {
                                Label(LocaleKeys.Button.delete.localized, systemImage: "trash")
                            }
                        }
                        .alert(LocaleKeys.Workout.Log.deleteAlertTitle.localized, isPresented: $viewModel.showDeleteConfirmation) {
                            AlertDeleteButtons { await viewModel.deleteLog() }
                        }
                    if log != viewModel.userWorkoutManager.logs.last {
                        Divider()
                    }
                }
            }
        }
        .card(cornerRadius: .low, padding: .low)
        .sheet(isPresented: $viewModel.showLogDetailsSheet, content: {
            LogDetailView(viewModel.selectedLog!)
                .presentationDetents([.large, .fraction(0.8)]).presentationCornerRadius(.normal)
        })
    }
}

private struct LogView: View {
    let log: WorkoutLog
    init(_ log: WorkoutLog) {
        self.log = log
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(log.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline).bold()
                    .foregroundStyle(.primary)
                Text(log.programName ?? LocaleKeys.Workout.Log.noProgram.localized)
                    .foregroundColor(.secondary)
                    .font(.footnote)
                Text(log.dayName ?? LocaleKeys.Workout.Log.noDay.localized)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.footnote).bold()
        }
    }
}

private struct LogDetailView: View {
    let log: WorkoutLog
    init(_ log: WorkoutLog) {
        self.log = log
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(LocaleKeys.Workout.Log.date.localized) {
                    Text(log.date.formatted(date: .long, time: .omitted))
//                        .listr
                }.listSectionSpacing(.zero)

                if let program = log.programName {
                    Section(LocaleKeys.Workout.Log.program.localized) {
                        Text(program)
                    }.listSectionSpacing(.zero)
                }

                if let day = log.dayName {
                    Section(LocaleKeys.Workout.Log.day.localized) {
                        Text(day)
                    }.listSectionSpacing(.zero)
                }

                Section(LocaleKeys.Workout.Log.exercises.localized) {
                    ForEach(log.exercises) { ex in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ex.name).bold()
                            Text("\(ex.sets)x\(ex.reps) \(ex.weight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)")
                                .font(.caption).foregroundColor(.secondary)
                            if let note = ex.notes {
                                Text(note).font(.footnote).foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }.listSectionSpacing(.zero)
            }
            .navigationTitle(LocaleKeys.Workout.Log.navTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            LogListView()
        }
    }
}
