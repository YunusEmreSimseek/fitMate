//
//  DayListViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

@Observable
final class DayListViewModel {
    var showAddExerciseSheet = false
    var showAddDaySheet = false
    var showDeleteDayConfirmation = false
    var deletingDay: WorkoutDay?
    var expandedDayIds: Set<String> = []
    var expandedDay: WorkoutDay?
    var editingDayId: String?
    let userWorkoutManager: UserWorkoutManager
    init(userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager) {
        self.userWorkoutManager = userWorkoutManager
    }

    func isDayExpanded(_ day: WorkoutDay) -> Bool {
        return expandedDay == day
//        expandedDayIds.contains("\(userWorkoutManager.selectedProgram!.id ?? "")-\(dayId)")
    }

    func toggleDay(_ day: WorkoutDay) {
//        let fullId = "\(userWorkoutManager.selectedProgram!.id ?? "")-\(dayId)"
//        if expandedDayIds.contains(fullId) {
//            expandedDayIds.remove(fullId)
//        } else {
//            expandedDayIds.insert(fullId)
//        }
        if expandedDay == day {
            expandedDay = nil
            userWorkoutManager.selectedDay = nil
            return
        } else {
            expandedDay = day
            userWorkoutManager.selectedDay = day
            return
        }
    }

    func addExercise(_ exercise: WorkoutExercise) async { await userWorkoutManager.addExercise(exercise) }

    func updateProgram(_ program: WorkoutProgram) async { await userWorkoutManager.updateProgram(program) }

    func updateDay(_ day: WorkoutDay) async { await userWorkoutManager.updateDay(day) }

    func deleteDay() async {
        guard deletingDay != nil else { return }
        await userWorkoutManager.deleteDay(deletingDay!)
    }

    func onDeleteDay(_ day: WorkoutDay) {
        deletingDay = day
        showDeleteDayConfirmation = true
    }
}
