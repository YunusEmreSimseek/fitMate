//
//  WorkoutViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 9.06.2025.
//

import Foundation

@Observable
final class WorkoutViewModel {
    var isLoading: Bool = false
    var showAddProgramSuccessSnackbar = false
    var showAddLogSuccessSnackbar = false
    var activeSheet: ActiveSheet?

    private let userSessionManager: UserSessionManager
    private let workoutService: IWorkoutService
    let userWorkoutManager: UserWorkoutManager

    init(
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
        workoutService: IWorkoutService = AppContainer.shared.workoutService,
        userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager
    ) {
        self.workoutService = workoutService
        self.userSessionManager = userSessionManager
        self.userWorkoutManager = userWorkoutManager
    }

    func addProgram(_ program: WorkoutProgram) async {
        await userWorkoutManager.addProgram(program)
        showAddProgramSuccessSnackbar = true
    }

    func addLog(_ log: WorkoutLog) async {
        await userWorkoutManager.addLog(log)
        showAddLogSuccessSnackbar = true
    }

    enum ActiveSheet: Identifiable {
        case addProgram
        case addLog

        var id: String {
            switch self {
            case .addProgram: return "addProgram"
            case .addLog: return "addLog"
            }
        }
    }
}
