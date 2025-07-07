//
//  AddWorkoutProgramSheetView.swift
//  fitMate
//
//  Created by Emre Simsek on 15.06.2025.
//

import SwiftUI

struct AddWorkoutProgramSheetView: View {
    @Environment(WorkoutViewModel.self) private var viewModel
    @State private var programName: String = ""
    @State private var numberOfDays: Int = 1
    @State private var workoutDays: [WorkoutDay] = [WorkoutDay(name: "", order: 1, exercises: [])]

    @State private var selectedDayIndex: Int?
    @State private var isPresentingExerciseSheet: Bool = false

    var onSave: (_ program: WorkoutProgram) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocaleKeys.Workout.CreateWorkout.name.localized)) {
                    TextField(LocaleKeys.Workout.CreateWorkout.exampleName.localized, text: $programName)
                }

                Section(header: Text(LocaleKeys.Workout.CreateWorkout.daysNumber.localized)) {
                    Stepper(value: $numberOfDays, in: 1 ... 7) {
                        Text("\(numberOfDays) \(LocaleKeys.Workout.CreateWorkout.daysNumberDay.localized)")
                    }
                    .onChange(of: numberOfDays) { _, _ in
                        updateWorkoutDays()
                    }
                }

                Section(header: Text(LocaleKeys.Workout.CreateWorkout.daysAndExercises.localized)) {
                    ForEach(Array(workoutDays.enumerated()), id: \.offset) { index, day in
                        VStack(alignment: .leading, spacing: 6) {
                            TextField(LocaleKeys.Workout.CreateWorkout.dayName.localized, text: $workoutDays[index].name)
                                .font(.headline)

                            ForEach(day.exercises) { exercise in
                                Text("• \(exercise.name) (\(exercise.sets)x\(exercise.reps), \(exercise.weight, specifier: "%.1f")\(StringConstants.bodyWeightMeasurement))")
                                    .font(.subheadline)
                            }

                            Button {
                                selectedDayIndex = index
                                isPresentingExerciseSheet = true
                            } label: {
                                Label(LocaleKeys.Workout.CreateWorkout.addExercise.localized, systemImage: "plus.circle")
                            }
                            .padding(.top, 4)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle(LocaleKeys.Workout.CreateWorkout.navTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        let program = WorkoutProgram(
                            name: programName,
                            days: workoutDays,
                            createdAt: Date()
                        )
                        onSave(program)
                        viewModel.activeSheet = nil
                    }
                    .disabled(programName.isEmpty || workoutDays.contains(where: { $0.name.isEmpty }))
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button(LocaleKeys.Button.cancel.localized) {
                        viewModel.activeSheet = nil
                    }
                }
            }
            .sheet(isPresented: $isPresentingExerciseSheet) {
                if let index = selectedDayIndex {
                    AddWorkoutExerciseView { newExercise in
                        workoutDays[index].exercises.append(newExercise)
                    }
                }
            }
            .onAppear {
                updateWorkoutDays()
            }
        }
    }

    private func updateWorkoutDays() {
        if numberOfDays > workoutDays.count {
            for i in workoutDays.count ..< numberOfDays {
                workoutDays.append(WorkoutDay(name: "", order: i + 1, exercises: []))
            }
        } else if numberOfDays < workoutDays.count {
            workoutDays = Array(workoutDays.prefix(numberOfDays))
        }
    }
}

#Preview {
    AddWorkoutProgramSheetView { _ in }
}
