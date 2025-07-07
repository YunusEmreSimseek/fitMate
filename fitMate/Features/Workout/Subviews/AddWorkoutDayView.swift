//
//  AddWorkoutDayView.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

struct AddWorkoutDayView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var day: WorkoutDay
    @State private var isPresentingExerciseSheet: Bool = false
    var onSave: (_ program: WorkoutDay) -> Void
    init(
        dayIndex: Int,
        onSave: @escaping (_ program: WorkoutDay) -> Void
    ) {
        self.onSave = onSave
        day = WorkoutDay(id: UUID().uuidString, name: "\(LocaleKeys.Workout.AddDay.name.localized) \(dayIndex + 1)", order: dayIndex, exercises: [])
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocaleKeys.Workout.AddDay.title.localized)) {
                    VStack(alignment: .leading, spacing: 6) {
                        TextField(LocaleKeys.Workout.AddDay.namePlaceholder.localized, text: $day.name)
                            .font(.headline)

                        ForEach(day.exercises) { exercise in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(exercise.name).font(.subheadline).bold()
                                Text("\(exercise.sets)x\(exercise.reps) \(exercise.weight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                if let note = exercise.notes {
                                    Text(note).font(.footnote).foregroundColor(.gray)
                                }
                            }
                        }

                        Button {
                            isPresentingExerciseSheet = true
                        } label: {
                            Label(LocaleKeys.Workout.AddDay.addExercise.localized, systemImage: "plus.circle")
                        }
                        .padding(.top, 4)
                    }
                    .padding(.vertical, 4)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocaleKeys.Button.save.localized) {
                        onSave(day)
                        dismiss()
                    }
                    .disabled(day.exercises.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button(LocaleKeys.Button.cancel.localized) {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $isPresentingExerciseSheet) {
                AddWorkoutExerciseView { newExercise in
                    day.exercises.append(newExercise)
                }
            }
        }
    }
}

#Preview {
    AddWorkoutDayView(dayIndex: 0) { _ in
    }
}
