//
//  UserModel.swift
//  fitMate
//
//  Created by Emre Simsek on 6.11.2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

struct UserModel: Identifiable, Equatable, Codable, Hashable {
    @DocumentID var id: String?
    var email: String
    var password: String
    var name: String
    var gender: Gender?
    var birthDate: Date?
    var height: Int?
    var weight: Int?
    var goals: [String]?
    var stepGoal: Int?
    var calorieGoal: Int?
    var sleepGoal: Int?
}

extension UserModel {
    static let dummyUser = UserModel(
        email: "dummy@dummy.com",
        password: "dummy",
        name: "Dummy User",
        gender: .male,
        birthDate: Calendar.current.date(from: DateComponents(year: 2001, month: 10, day: 11)),
        height: 180,
        weight: 75,
        goals: ["Lose weight", "Build muscle"],
        stepGoal: 10000,
        calorieGoal: 500,
        sleepGoal: 8
    )

    func toAIServiceUserProfile() -> AIServiceUserProfile {
        .init(gender: gender ?? .none, age: birthDate?.calculateAge() ?? 0, height: height ?? 0, weight: weight ?? 0, goals: goals ?? [], activityLevel: "moderately_active")
    }
}
