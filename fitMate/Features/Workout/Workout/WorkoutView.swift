//
//  WorkoutView.swift
//  fitMate
//
//  Created by Emre Simsek on 9.06.2025.
//

import SwiftUI

struct WorkoutView: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        Group {
            if viewModel.userWorkoutManager.programs.isEmpty && viewModel.userWorkoutManager.logs.isEmpty {
                VStack(alignment: .center) {
                    Spacer()
                    EmptyProgramState()
                    Spacer()
                    Divider()
                    Spacer()
                    EmptyLogState()
                    Spacer()
                }
            } else {
                ScrollView {
                    WorkoutSummarySection()
                    Spacer().frame(minHeight: .medium)
                    WorkoutProgramsSection()
                    Spacer().frame(minHeight: .medium)
                    WorkoutHistorySection()
                        .bottomPadding(.low3)
                }
            }
        }
        .hPadding()
        .topPadding()
        .background(.cBackground)
        .sheet(item: $viewModel.activeSheet) { _ in MenuSheet() }
        .snackBar(isPresented: $viewModel.showAddProgramSuccessSnackbar, message: LocaleKeys.Workout.Snackbar.workoutAddedTitle.localized)
        .snackBar(isPresented: $viewModel.showAddLogSuccessSnackbar, message: LocaleKeys.Workout.Snackbar.logAddedTitle.localized)
    }
}

private struct EmptyProgramState: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        VStack(alignment: .center, spacing: .medium3) {
            Text(LocaleKeys.Workout.programsTitle.localized).font(.title3).bold()

            Image(systemName: "dumbbell")
                .resizable()
                .scaledToFit()
                .frame(height: .dynamicHeight(height: 0.04))
                .foregroundStyle(.cBlue)

            Text(LocaleKeys.Workout.noProgramsTitle.localized)
                .multilineTextAlignment(.center)

            Button(LocaleKeys.Workout.addProgramsTitle.localized) {
                viewModel.activeSheet = .addProgram
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

private struct EmptyProgramStateLow: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        Section {
            Text(LocaleKeys.Workout.noProgramsTitle.localized)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .card(cornerRadius: .low, padding: .low)
        } header: {
            HStack {
                Spacer()
                Text(LocaleKeys.Workout.programsTitle.localized)
                    .font(.subheadline).bold().foregroundStyle(.secondary)
                Spacer()
            }
        }
        .hPadding(2)
    }
}

private struct EmptyLogState: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        VStack(alignment: .center, spacing: .medium3) {
            Text(LocaleKeys.Workout.historyTitle.localized).font(.title3).bold()

            Image(systemName: "plus.rectangle.on.rectangle")
                .resizable()
                .scaledToFit()
                .frame(height: .dynamicHeight(height: 0.04))
                .foregroundStyle(.cBlue)

            Text(LocaleKeys.Workout.noLogsTitle.localized)
                .multilineTextAlignment(.center)

            Button(LocaleKeys.Workout.addLogTitle.localized) {
                viewModel.activeSheet = .addLog
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

private struct EmptyLogStateLow: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        Section {
            Text(LocaleKeys.Workout.noLogsTitle.localized)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .card(cornerRadius: .low, padding: .low)
        } header: {
            HStack {
                Spacer()
                Text(LocaleKeys.Workout.historyTitle.localized)
                    .font(.subheadline).bold().foregroundStyle(.secondary)
                Spacer()
            }
        }
        .hPadding(2)
    }
}

private struct WorkoutSummarySection: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        if !viewModel.userWorkoutManager.logs.isEmpty {
            Section {
                WorkoutSummaryView()
            } header: {
                HStack {
                    Spacer()
                    Text(LocaleKeys.Workout.summaryTitle.localized)
                        .font(.subheadline).bold().foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .hPadding(2)
        }
    }
}

private struct WorkoutProgramsSection: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        if viewModel.isLoading {
            ProgressView(LocaleKeys.General.loading.localized).frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if viewModel.userWorkoutManager.programs.isEmpty {
            EmptyProgramStateLow()
        } else {
            Section {
                ProgramListView()
            } header: {
                HStack {
                    Spacer()
                    Text(LocaleKeys.Workout.programsTitle.localized)
                        .font(.subheadline).bold().foregroundStyle(.secondary)
                    Spacer()
                }
            }
            .hPadding(2)
        }
    }
}

private struct WorkoutHistorySection: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        if viewModel.userWorkoutManager.logs.isEmpty {
            EmptyLogState()
        } else {
            Section {
                LogListView()
            } header: {
                HStack {
                    Spacer()
                    Text(LocaleKeys.Workout.historyTitle.localized)
                        .font(.subheadline).bold().foregroundStyle(.secondary)
                    Spacer()
                }
            }.hPadding(2)
        }
    }
}

struct WorkoutToolbarMenu: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        Menu {
            Button(LocaleKeys.Workout.addProgramsTitle.localized) {
                viewModel.activeSheet = .addProgram
            }
            Button(LocaleKeys.Workout.addLogTitle.localized) {
                viewModel.activeSheet = .addLog
            }
        } label: {
            Image(systemName: "plus")
                .imageScale(.large)
        }
    }
}

private struct MenuSheet: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    var body: some View {
        if let activeSheet = viewModel.activeSheet {
            switch activeSheet {
            case .addProgram:
                AddWorkoutProgramSheetView { newProgram in
                    Task { await viewModel.addProgram(newProgram) }
                }
            case .addLog:
                AddWorkoutLogSheetView()
            }
        }
    }
}

private struct NoContentView: View {
    var body: some View {
        ContentUnavailableView {
            Label(LocaleKeys.Workout.noProgramsTitle.localized, systemImage: "figure.strengthtraining.traditional")
        } description: {
            Text(LocaleKeys.Workout.noProgramsSubTitle.localized)
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutView()
            .environment(AppContainer.shared.userWorkoutManager)
            .environment(WorkoutViewModel())
    }
}
