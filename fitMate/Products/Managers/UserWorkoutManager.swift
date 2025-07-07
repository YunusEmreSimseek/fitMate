//
//  UserWorkoutManager.swift
//  fitMate
//
//  Created by Emre Simsek on 10.06.2025.
//

import SwiftUI

@Observable
final class UserWorkoutManager {
    private let userSessionManager: UserSessionManager
    private let workoutService: IWorkoutService
    var programs: [WorkoutProgram] = []
    var logs: [WorkoutLog] = []
    var selectedProgram: WorkoutProgram?
    var selectedDay: WorkoutDay?
    var isLoaded: Bool = false

    init(
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
        workoutService: IWorkoutService = AppContainer.shared.workoutService
    ) {
        self.userSessionManager = userSessionManager
        self.workoutService = workoutService
        if AppMode.isPreview {
            programs = WorkoutProgram.dummyPrograms
            logs = WorkoutLog.dummyLogs
        }
    }

    func selectProgram(_ program: WorkoutProgram) {
        selectedProgram = program
        selectedDay = nil
    }

    func selectDay(_ day: WorkoutDay) {
        selectedDay = day
    }

    func clearManager() {
        programs.removeAll()
        logs.removeAll()
        selectedProgram = nil
        selectedDay = nil
        isLoaded = false
    }

    func loadManager() async {
        if AppMode.isPreview {
            programs = WorkoutProgram.dummyPrograms
            logs = [WorkoutLog.dummyLog]
            return
        } else {
            guard !isLoaded else { return }
            guard let userId = userSessionManager.currentUser?.id else { return }
            if let fetchedPrograms = try? await workoutService.fetchPrograms(for: userId) {
                programs = fetchedPrograms
            }
            if let fetchedLogs = try? await workoutService.fetchWorkoutLogs(for: userId) {
                logs = fetchedLogs
            }
            isLoaded = true
        }
    }

    func refreshManager() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        if let fetchedPrograms = try? await workoutService.fetchPrograms(for: userId) {
            programs = fetchedPrograms
        }
        if let fetchedLogs = try? await workoutService.fetchWorkoutLogs(for: userId) {
            logs = fetchedLogs
        }
    }

    func refreshPrograms() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        if let fetchedPrograms = try? await workoutService.fetchPrograms(for: userId) {
            programs = fetchedPrograms
        }
    }

    func refreshLogs() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        if let fetchedLogs = try? await workoutService.fetchWorkoutLogs(for: userId) {
            logs = fetchedLogs
        }
    }

    func addProgram(_ program: WorkoutProgram) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        try? await workoutService.addProgram(program, for: userId)
        await refreshPrograms()
    }

    func updateProgram(_ program: WorkoutProgram) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        try? await workoutService.updateProgram(program, for: userId)
        await refreshPrograms()
    }

    func deleteProgram(_ program: WorkoutProgram) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        try? await workoutService.deleteProgram(program.id!, for: userId)
        await refreshPrograms()
    }

    func updateDay(_ day: WorkoutDay) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        guard let dayIndex = selectedProgram?.days.firstIndex(where: { $0.id == day.id }) else { return }
        selectedDay = day
        selectedProgram!.days[dayIndex] = day
        try? await workoutService.updateProgram(selectedProgram!, for: userId)
        await refreshPrograms()
    }

    func deleteDay(_ day: WorkoutDay) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        guard let dayIndex = selectedProgram?.days.firstIndex(where: { $0.id == day.id }) else { return }
        selectedProgram!.days.remove(at: dayIndex)
        try? await workoutService.updateProgram(selectedProgram!, for: userId)
        selectedDay = nil
        await refreshPrograms()
    }

    func addDay(_ day: WorkoutDay) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        selectedProgram!.days.append(day)
        try? await workoutService.updateProgram(selectedProgram!, for: userId)
        await refreshPrograms()
    }

    func deleteExercise(_ exercise: WorkoutExercise) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        guard let dayIndex = selectedProgram?.days.firstIndex(where: { $0.id == selectedDay?.id }) else { return }
        guard let exerciseIndex = selectedDay?.exercises.firstIndex(where: { $0.id == exercise.id }) else { return }
        selectedDay!.exercises.remove(at: exerciseIndex)
        selectedProgram!.days[dayIndex] = selectedDay!
        try? await workoutService.updateProgram(selectedProgram!, for: userId)
        await refreshPrograms()
    }

    func updateExercise(_ exercise: WorkoutExercise) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        guard let dayIndex = selectedProgram?.days.firstIndex(where: { $0.id == selectedDay?.id }) else { return }
        guard let exerciseIndex = selectedDay?.exercises.firstIndex(where: { $0.id == exercise.id }) else { return }

        selectedDay!.exercises[exerciseIndex] = exercise
        selectedProgram!.days[dayIndex] = selectedDay!
        try? await workoutService.updateProgram(selectedProgram!, for: userId)
        await refreshPrograms()
    }

    func addExercise(_ exercise: WorkoutExercise) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        guard let dayIndex = selectedProgram?.days.firstIndex(where: { $0.id == selectedDay?.id }) else { return }
        selectedDay!.exercises.append(exercise)
        selectedProgram!.days[dayIndex] = selectedDay!
        try? await workoutService.updateProgram(selectedProgram!, for: userId)
        await refreshPrograms()
    }

    func addLog(_ log: WorkoutLog) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        try? await workoutService.saveWorkoutLog(log, for: userId)
        await refreshLogs()
    }

    func deleteLog(_ log: WorkoutLog) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        try? await workoutService.deleteLog(log, for: userId)
        await refreshLogs()
    }

    func calculateWorkoutThisWeek() -> Int {
        let calendar = Calendar.current
        let now = Date()

        return logs.filter { log in
            calendar.isDate(log.date, equalTo: now, toGranularity: .weekOfYear)
        }.count
    }
}
