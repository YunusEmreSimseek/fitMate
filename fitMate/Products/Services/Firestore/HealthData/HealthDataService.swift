//
//  HealthDataService.swift
//  fitMate
//
//  Created by Emre Simsek on 29.04.2025.
//

import FirebaseFirestore
import Foundation

final class HealthDataService {
    private var db: Firestore { Firestore.firestore() }
    private let healthsCollection = FirebaseCollections.healths.rawValue
    private let logManager = AppContainer.shared.logManager

    func saveHealthData(_ healthData: HealthDataModel, for userId: String) {
        do {
            try db.collection(healthsCollection)
                .document(userId)
                .collection("dailyData")
                .document(healthData.dateString)
                .setData(from: healthData)
            logManager.info("Health data saved successfully for user: \(userId)")
        } catch {
            logManager.error("Error saving health data: \(error.localizedDescription)")
        }
    }
}
