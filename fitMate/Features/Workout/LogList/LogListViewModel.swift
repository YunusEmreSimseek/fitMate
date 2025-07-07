//
//  LogListViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 13.06.2025.
//

import SwiftUI

@Observable
final class LogListViewModel {
    var showDeleteConfirmation: Bool = false
    var showLogDetailsSheet: Bool = false
    var logToDelete: WorkoutLog?
    var selectedLog: WorkoutLog?
    let userWorkoutManager: UserWorkoutManager

    init(userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager) {
        self.userWorkoutManager = userWorkoutManager
    }

    func deleteLog() async {
        guard logToDelete != nil else { return }
        await userWorkoutManager.deleteLog(logToDelete!)
    }

    func onDeleteLog(_ log: WorkoutLog) {
        logToDelete = log
        showDeleteConfirmation = true
    }
}
