//
//  EditWorkoutExerciseView.swift
//  fitMate
//
//  Created by Emre Simsek on 11.06.2025.
//

import SwiftUI

struct EditWorkoutExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var sets: Int
    @State private var reps: Int
    @State private var weight: Double
    @State private var notes: String
    private let exerciseId: String

    var onSave: (WorkoutExercise) -> Void

    init(_ exercise: WorkoutExercise, _ onSave: @escaping (WorkoutExercise) -> Void) {
        _name = State(initialValue: exercise.name)
        _sets = State(initialValue: exercise.sets)
        _reps = State(initialValue: exercise.reps)
        _weight = State(initialValue: exercise.weight)
        _notes = State(initialValue: exercise.notes ?? "")
        exerciseId = exercise.id
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField(LocaleKeys.Workout.AddExercise.name.localized, text: $name)
                Stepper("\(LocaleKeys.Workout.AddExercise.sets.localized): \(sets)", value: $sets, in: 1 ... 10)
                Stepper("\(LocaleKeys.Workout.AddExercise.reps.localized): \(reps)", value: $reps, in: 1 ... 30)
                Stepper("\(LocaleKeys.Workout.AddExercise.weight.localized): \(weight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)", value: $weight, in: 0 ... 300, step: 2.5)
                TextField(LocaleKeys.Workout.AddExercise.notes.localized, text: $notes)
            }
            .navigationTitle(LocaleKeys.Workout.EditExercise.navTitle.localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        let exercise = WorkoutExercise(id: exerciseId, name: name, sets: sets, reps: reps, weight: weight, notes: notes.isEmpty ? nil : notes)
                        onSave(exercise)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocaleKeys.Button.cancel.localized) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EditWorkoutExerciseView(.dummyExercise1) { _ in }
}
