//
//  ProgramListView.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

struct ProgramListView: View {
    @State private var viewModel: ProgramListViewModel = .init()
    @FocusState private var isEditingFocused: Bool
    var body: some View {
        VStack(spacing: .zero) {
            ForEach(viewModel.userWorkoutManager.programs) { program in
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { viewModel.expandedProgram == program },
                        set: { _ in viewModel.toggleProgram(program) }
                    )
                ) {
                    DayListView().topPadding(.low3)

                } label: {
                    if viewModel.editingProgramId == program.id {
                        EditingProgramField(isEditingFocused: _isEditingFocused, program: program)
                    } else {
                        Text(program.name).font(.callout).bold()
                            .tint(.primary)
                            .swipeActions(edge: .trailing) { SwipeDeleteButton { viewModel.onDeleteProgram(program) }}
                            .alert(LocaleKeys.Workout.Program.deleteAlertTitle.localized, isPresented: $viewModel.showDeleteProgramConfirmation) {
                                AlertDeleteButtons { await viewModel.deleteProgram() }
                            }
                    }
                }
                .allPadding(.low)
                .contextMenu {
                    Button(LocaleKeys.Button.rename.localized) {
                        viewModel.editingProgramId = program.id
                        isEditingFocused = true
                    }
                    Button(LocaleKeys.Workout.Program.addDay.localized) {
                        viewModel.userWorkoutManager.selectedProgram = program
                        viewModel.showAddDaySheet = true
                    }
                    Button(role: .destructive) {
                        viewModel.deletingProgram = program
                        viewModel.showDeleteProgramConfirmation = true
                    } label: {
                        Label(LocaleKeys.Button.delete.localized, systemImage: "trash")
                    }
                }

                if program != viewModel.userWorkoutManager.programs.last {
                    Divider()
                }
            }
        }
//        .hPadding(.low)
        .card(cornerRadius: .low, padding: .zero)
        .environment(viewModel)
        .sheet(isPresented: $viewModel.showAddDaySheet) {
            AddWorkoutDayView(dayIndex: viewModel.userWorkoutManager.selectedProgram?.days.count ?? 0) { newDay in
                Task { await viewModel.addDay(newDay) }
            }
        }
        .alert(LocaleKeys.Workout.Program.deleteAlertTitle.localized, isPresented: $viewModel.showDeleteProgramConfirmation) {
            AlertDeleteButtons { await viewModel.deleteProgram() }
        }
    }
}

private struct EditingProgramField: View {
    @Environment(ProgramListViewModel.self) private var viewModel
    @FocusState var isEditingFocused: Bool
    let program: WorkoutProgram
    var body: some View {
        TextField(LocaleKeys.Workout.Program.name.localized, text: Binding(
            get: { program.name },
            set: { newValue in
                var updatedProgram = program
                updatedProgram.name = newValue
                Task { await viewModel.updateProgram(updatedProgram) }
            }
        ))
        .multilineTextAlignment(.leading)
        .font(.callout)
        .bold()
        .focused($isEditingFocused)
        .submitLabel(.done)
        .onSubmit {
            viewModel.editingProgramId = nil
        }
        .allPadding(.zero)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        List {
            ProgramListView()
        }
    }
}
