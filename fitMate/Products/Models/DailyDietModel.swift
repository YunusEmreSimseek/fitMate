//
//  DailyDietModel.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//
import FirebaseFirestore

struct DailyDietModel: Codable, Identifiable {
    @DocumentID var id: String?
    let dateString: String

    let stepCount: Int?
    let cardioMinutes: Int?
    let caloriesTaken: Int?

    let protein: Int?
    let carbs: Int?
    let fat: Int?

    let weight: Double?

    var note: String?
}
