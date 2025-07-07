//
//  ProgramListViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

@Observable
final class ProgramListViewModel {
    var expandedProgram: WorkoutProgram?
    var editingProgramId: String?
    var showDeleteProgramConfirmation = false
    var showAddDaySheet = false
    var deletingProgram: WorkoutProgram?
    let userWorkoutManager: UserWorkoutManager

    init(userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager) {
        self.userWorkoutManager = userWorkoutManager
    }

    func toggleProgram(_ program: WorkoutProgram) {
        if expandedProgram == program {
            expandedProgram = nil
            userWorkoutManager.selectedProgram = nil
            return
        } else {
            expandedProgram = program
            userWorkoutManager.selectedProgram = program
            return
        }
    }

    func updateProgram(_ updatedProgram: WorkoutProgram) async {
        await userWorkoutManager.updateProgram(updatedProgram)
    }

    func deleteProgram() async {
        guard deletingProgram != nil else { return }
        await userWorkoutManager.deleteProgram(deletingProgram!)
    }

    func addDay(_ day: WorkoutDay) async { await userWorkoutManager.addDay(day) }

    func onDeleteProgram(_ program: WorkoutProgram) {
        deletingProgram = program
        showDeleteProgramConfirmation = true
    }
}
