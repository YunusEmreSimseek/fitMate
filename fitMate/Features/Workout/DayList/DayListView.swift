//
//  DayListView.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

struct DayListView: View {
    @State private var viewModel: DayListViewModel = .init()
    @FocusState private var isEditingFocused: Bool
    var body: some View {
        LazyVStack(spacing: .zero) {
            ForEach(viewModel.userWorkoutManager.selectedProgram?.days ?? []) { day in
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { viewModel.isDayExpanded(day) },
                        set: { _ in viewModel.toggleDay(day) }
                    )
                ) {
                    ExerciseListView().topPadding(.low3)

                    AddExerciseButton()

                } label: {
                    if viewModel.editingDayId == day.id {
                        EditingDayField(isEditingFocused: _isEditingFocused, day: day)
                    } else {
                        Text(day.name).font(.subheadline).fontWeight(.semibold)
                            .tint(.primary)
                            .swipeActions(edge: .trailing) { SwipeDeleteButton { viewModel.onDeleteDay(day) }}
                            .alert(LocaleKeys.Workout.Day.deleteAlertTitle.localized, isPresented: $viewModel.showDeleteDayConfirmation) {
                                AlertDeleteButtons { await viewModel.deleteDay() }
                            }
                    }
                }
                .hPadding(.low)
                .vPadding(.low3)
                .contextMenu {
                    Button(LocaleKeys.Button.rename.localized) {
                        viewModel.editingDayId = day.id
                        isEditingFocused = true
                    }
                }
                if day != viewModel.userWorkoutManager.selectedProgram?.days.last {
                    Divider()
                }
            }
        }
//        .hPadding(.low)
        .sheet(isPresented: $viewModel.showAddExerciseSheet) {
            AddWorkoutExerciseView { newExercise in
                Task { await viewModel.addExercise(newExercise) }
            }
        }

        .environment(viewModel)
    }
}

private struct AddExerciseButton: View {
    @Environment(DayListViewModel.self) private var viewModel
    var body: some View {
        HStack {
            Button(LocaleKeys.Workout.Day.addExercise.localized) {
                viewModel.showAddExerciseSheet = true
            }
            .font(.footnote).fontWeight(.semibold)
            .bottomPadding(.normal)
            Spacer()
        }.hPadding(.low)
    }
}

private struct EditingDayField: View {
    @Environment(DayListViewModel.self) private var viewModel
    @FocusState var isEditingFocused: Bool
    let day: WorkoutDay
    var body: some View {
        TextField(LocaleKeys.Workout.Day.name.localized, text: Binding(
            get: { day.name },
            set: { newValue in
                var newDay = day
                newDay.name = newValue
                Task { await viewModel.updateDay(newDay) }
            }
        ))
        .font(.subheadline)
        .fontWeight(.semibold)
        .focused($isEditingFocused)
        .submitLabel(.done)
        .onSubmit {
            viewModel.editingDayId = nil
        }
        .allPadding(.zero)
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
    }
}

#Preview {
    DayListView()
}
