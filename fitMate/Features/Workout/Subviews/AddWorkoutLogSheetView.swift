//
//  WorkoutLogSheetView.swift
//  fitMate
//
//  Created by Emre Simsek on 13.06.2025.
//

import SwiftUI

struct AddWorkoutLogSheetView: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    @State private var selectedProgram: WorkoutProgram?
    @State private var selectedDay: WorkoutDay?
    @State private var editedDay: WorkoutDay?
    @State private var workoutDate: Date = .now
    @State private var customExercises: [WorkoutExercise] = []

    private var userWorkoutManager: UserWorkoutManager

    init(userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager) {
        self.userWorkoutManager = userWorkoutManager
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(LocaleKeys.Workout.AddLog.dateTitle.localized) {
                    DatePicker(LocaleKeys.Workout.AddLog.dayPlaceholder.localized, selection: $workoutDate, displayedComponents: [.date])
                }
                Section(LocaleKeys.Workout.AddLog.workoutTitle.localized) {
                    Picker(LocaleKeys.Workout.AddLog.workoutPlaceholder.localized, selection: $selectedProgram) {
                        Text(LocaleKeys.Workout.AddLog.noPlaceholder.localized).tag(nil as WorkoutProgram?)
                        ForEach(userWorkoutManager.programs) { program in
                            Text(program.name).tag(Optional(program))
                        }
                    }
                    if let selectedProgram {
                        Picker(LocaleKeys.Workout.AddLog.dayPlaceholder.localized, selection: $selectedDay) {
                            Text(LocaleKeys.Workout.AddLog.noPlaceholder.localized).tag(nil as WorkoutDay?)
                            ForEach(selectedProgram.days) { day in
                                Text(day.name).tag(Optional(day))
                            }
                        }
                        .onChange(of: selectedDay) { _, newValue in
                            editedDay = newValue
                        }
                    }
                }
                Section(LocaleKeys.Workout.AddLog.exerciseTitle.localized) {
                    if editedDay != nil {
                        ForEach(editedDay!.exercises.indices, id: \.self) { index in
                            ExerciseEditRow(exercise: Binding(
                                get: { editedDay!.exercises[index] },
                                set: { editedDay!.exercises[index] = $0 }
                            ))
                        }
                    } else {
                        ForEach(customExercises.indices, id: \.self) { index in
                            ExerciseEditRow(exercise: Binding(
                                get: { customExercises[index] },
                                set: { customExercises[index] = $0 }
                            ))
                        }

                        Button(LocaleKeys.Workout.AddLog.addExercise.localized) {
                            customExercises.append(.init(name: "", sets: 3, reps: 10, weight: 0))
                        }
                    }
                }
            }

            .navigationTitle(LocaleKeys.Workout.AddLog.navTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocaleKeys.Button.cancel.localized) { viewModel.activeSheet = nil }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        Task { await saveWorkoutLog() }
                        viewModel.activeSheet = nil
                    }
                }
            }
        }
    }
}

extension AddWorkoutLogSheetView {
    private func saveWorkoutLog() async {
        let exercisesToSave = editedDay?.exercises ?? customExercises
        let log = WorkoutLog(
            date: workoutDate,
            programId: selectedProgram?.id,
            programName: selectedProgram?.name,
            dayId: selectedDay?.id,
            dayName: selectedDay?.name,
            exercises: exercisesToSave
        )
        await viewModel.addLog(log)
        // Burada WorkoutLog'u Firestore veya local manager üzerinden kaydedebilirsin
    }
}

private struct ExerciseEditRow: View {
    @Binding var exercise: WorkoutExercise

    var body: some View {
        VStack(alignment: .leading) {
            TextField(LocaleKeys.Workout.AddExercise.name.localized, text: $exercise.name).bold()
            Stepper("\(LocaleKeys.Workout.AddExercise.sets.localized): \(exercise.sets)", value: $exercise.sets, in: 1 ... 10)
            Stepper("\(LocaleKeys.Workout.AddExercise.reps.localized): \(exercise.reps)", value: $exercise.reps, in: 1 ... 30)
            Stepper("\(LocaleKeys.Workout.AddExercise.weight.localized): \(exercise.weight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)", value: $exercise.weight, in: 0 ... 300, step: 2.5)
            TextField(LocaleKeys.Workout.AddExercise.notes.localized, text: $exercise.notes.unwrap(default: ""))
        }
    }
}

#Preview {
    NavigationStack {
        AddWorkoutLogSheetView()
    }
}
