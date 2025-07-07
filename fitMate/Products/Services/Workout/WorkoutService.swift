//
//  WorkoutService.swift
//  fitMate
//
//  Created by Emre Simsek on 9.06.2025.
//

import FirebaseFirestore

protocol IWorkoutService {
    func addProgram(_ program: WorkoutProgram, for userId: String) async throws
    func updateProgram(_ program: WorkoutProgram, for userId: String) async throws
    func fetchPrograms(for userId: String) async throws -> [WorkoutProgram]
    func deleteProgram(_ programId: String, for userId: String) async throws
    func saveWorkoutLog(_ log: WorkoutLog, for userId: String) async throws
    func fetchWorkoutLogs(for userId: String) async throws -> [WorkoutLog]
    func deleteLog(_ log: WorkoutLog, for userId: String) async throws
}

final class WorkoutService: IWorkoutService {
    private var db: Firestore { Firestore.firestore() }
    private let usersCollection = FirebaseCollections.users.rawValue
    private let workoutsCollection = FirebaseCollections.workouts.rawValue
    private let logManager = AppContainer.shared.logManager

    func addProgram(_ program: WorkoutProgram, for userId: String) async throws {
        do {
            try db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("programs")
                .collection("list")
                .addDocument(from: program)
            logManager.info("[WorkoutService] Workour program saved for \(userId)")
        } catch {
            logManager.error("[WorkoutService] Failed to save workout program: \(error.localizedDescription)")
        }
    }

    func updateProgram(_ program: WorkoutProgram, for userId: String) async throws {
        do {
            guard let programId = program.id else {
                throw NSError(domain: "WorkoutService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Program ID is nil"])
            }

            try db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("programs")
                .collection("list")
                .document(programId)
                .setData(from: program, merge: true)

            logManager.info("[WorkoutService] Workout program \(programId) updated for user \(userId)")
        } catch {
            logManager.error("[WorkoutService] Failed to update workout program: \(error.localizedDescription)")
            throw error
        }
    }

    func fetchPrograms(for userId: String) async throws -> [WorkoutProgram] {
        do {
            let snapshot = try await db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("programs")
                .collection("list")
                .order(by: "createdAt", descending: true)
                .getDocuments()
            let programs = try snapshot.documents.map { try $0.data(as: WorkoutProgram.self) }
            logManager.info("[WorkoutService] Fetched \(programs.count) workout programs for user \(userId)")
            return programs
        } catch {
            logManager.error("[WorkoutService] Failed to fetch workout programs: \(error.localizedDescription)")
            throw error
        }
    }

    func deleteProgram(_ programId: String, for userId: String) async throws {
        do {
            try await db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("programs")
                .collection("list")
                .document(programId)
                .delete()
            logManager.info("[WorkoutService] Workout program \(programId) deleted for user \(userId)")
        } catch {
            logManager.error("[WorkoutService] Failed to delete workout program: \(error.localizedDescription)")
            throw error
        }
    }

    func saveWorkoutLog(_ log: WorkoutLog, for userId: String) async throws {
        let dateKey = log.date.formatAsKey()

        do {
            try db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("dailyLogs")
                .collection("list")
                .document(dateKey)
                .setData(from: log)
            logManager.info("[WorkoutService] Workout log saved for user \(userId) on \(dateKey)")

        } catch {
            logManager.error("[WorkoutService] Failed to save workout log: \(error.localizedDescription)")
            throw error
        }
    }

    func fetchWorkoutLogs(for userId: String) async throws -> [WorkoutLog] {
        do {
            let snapshot = try await db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("dailyLogs")
                .collection("list")
                .order(by: "date", descending: true)
                .getDocuments()
            let logs = try snapshot.documents.map { try $0.data(as: WorkoutLog.self) }
            logManager.info("[WorkoutService] Fetched \(logs.count) workout logs for user \(userId)")
            return logs

        } catch {
            logManager.error("[WorkoutService] Failed to fetch workout logs: \(error.localizedDescription)")
            throw error
        }
    }

    func deleteLog(_ log: WorkoutLog, for userId: String) async throws {
        do {
            try await db.collection(usersCollection)
                .document(userId)
                .collection(workoutsCollection)
                .document("dailyLogs")
                .collection("list")
                .document(log.date.formatAsKey())
                .delete()
            logManager.info("[WorkoutService] Deleted  workout log for user \(userId)")
        } catch {
            logManager.error("[WorkoutService] Failed to delete workout log: \(error.localizedDescription)")
            throw error
        }
    }
}
