//
//  ExerciseListViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

@Observable
final class ExerciseListViewModel {
    var showDeleteExerciseConfirmation = false
    var showEditExerciseSheet = false
    var showAddExerciseSheet = false
    var selectedExercise: WorkoutExercise?
    var exerciseToDelete: WorkoutExercise?
    let userWorkoutManager: UserWorkoutManager

    init(userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager) {
        self.userWorkoutManager = userWorkoutManager
    }

    func deleteExercise() async {
        guard exerciseToDelete != nil else { return }
        await userWorkoutManager.deleteExercise(exerciseToDelete!)
    }

    func updateExercise(_ exercise: WorkoutExercise) async { await userWorkoutManager.updateExercise(exercise) }

    func onTapExercise(_ ex: WorkoutExercise) {
        selectedExercise = ex
        showEditExerciseSheet = true
    }

    func onDeleteExercise(_ ex: WorkoutExercise) {
        exerciseToDelete = ex
        showDeleteExerciseConfirmation = true
    }
}
