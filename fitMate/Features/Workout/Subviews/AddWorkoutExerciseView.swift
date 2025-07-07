//
//  AddWorkoutExerciseView.swift
//  fitMate
//
//  Created by Emre Simsek on 11.06.2025.
//

import SwiftUI

struct AddWorkoutExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var sets = 3
    @State private var reps = 10
    @State private var weight = 0.0
    @State private var notes = ""

    var onSave: (WorkoutExercise) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField(LocaleKeys.Workout.AddExercise.name.localized, text: $name)
                Stepper("\(LocaleKeys.Workout.AddExercise.sets.localized): \(sets)", value: $sets, in: 1 ... 10)
                Stepper("\(LocaleKeys.Workout.AddExercise.reps.localized): \(reps)", value: $reps, in: 1 ... 30)
                Stepper("\(LocaleKeys.Workout.AddExercise.weight.localized): \(weight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)", value: $weight, in: 0 ... 300, step: 2.5)
                TextField(LocaleKeys.Workout.AddExercise.notes.localized, text: $notes)
            }
            .navigationTitle(LocaleKeys.Workout.AddExercise.navTitle.localized)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        let exercise = WorkoutExercise(name: name, sets: sets, reps: reps, weight: weight, notes: notes.isEmpty ? nil : notes)
                        onSave(exercise)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
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
    AddWorkoutExerciseView { _ in }
}
