//
//  DietService.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//

import FirebaseFirestore

final class DietService {
    private var db: Firestore { Firestore.firestore() }
    private let dietsCollection = FirebaseCollections.diets.rawValue
    private let usersCollection = FirebaseCollections.users.rawValue
    private let logManager = AppContainer.shared.logManager

    func saveDiet(_ diet: DietModel, for userId: String) async {
        do {
            try db.collection(usersCollection)
                .document(userId)
                .collection(dietsCollection)
                .document("activePlan")
                .setData(from: diet)
            logManager.info("[DietService] Diet plan saved for \(userId)")
        } catch {
            logManager.error("[DietService] Failed to save diet plan: \(error.localizedDescription)")
        }
    }

    func fetchDiet(for userId: String) async -> DietModel? {
        do {
            let snapshot = try await db.collection(usersCollection)
                .document(userId)
                .collection(dietsCollection)
                .document("activePlan")
                .getDocument()
            logManager.info("[DietService] Diet plan fetched successfully for \(userId)")
            return try snapshot.data(as: DietModel.self)
        } catch {
            logManager.error("[DietService] Failed to fetch diet plan: \(error.localizedDescription)")
            return nil
        }
    }

    func deleteDiet(for userId: String) async {
        do {
            try await db.collection(usersCollection)
                .document(userId)
                .collection(dietsCollection)
                .document("activePlan")
                .delete()
            logManager.info("[DietService] Diet plan deleted successfully for \(userId)")
        } catch {
            logManager.error("[DietService] Failed to delete diet plan: \(error.localizedDescription)")
        }
    }

    func saveOrUpdateDailyDietLog(_ log: DailyDietModel, for userId: String) async {
        do {
            try db.collection(usersCollection)
                .document(userId)
                .collection(dietsCollection)
                .document("activePlan")
                .collection("dailyLogs")
                .document(log.dateString)
                .setData(from: log, merge: true)

            logManager.info("[DietService] Daily Diet log saved succesfully for \(log.dateString)")
        } catch {
            logManager.error("[DietService] Daily Diet log Failed to save : \(error.localizedDescription)")
        }
    }

    func fetchDailyDietLogs(for userId: String, lastDays: Int = 7) async -> [DailyDietModel] {
        do {
            let snapshot = try await db.collection(usersCollection)
                .document(userId)
                .collection(dietsCollection)
                .order(by: "dateString", descending: true)
                .limit(to: lastDays)
                .getDocuments()
            logManager.info("[DietService] Daily Diet logs fetched successfully for \(userId)")
            return snapshot.documents.compactMap {
                try? $0.data(as: DailyDietModel.self)
            }
        } catch {
            logManager.error("[DietService] Daily Diet logs fetch failed: \(error.localizedDescription)")
            return []
        }
    }
}
