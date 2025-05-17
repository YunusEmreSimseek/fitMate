//
//  GoalManager.swift
//  fitMate
//
//  Created by Emre Simsek on 29.04.2025.
//

import Foundation

@Observable
final class GoalManager {
    private let userDefaults = UserDefaults.standard

    var stepGoal: Double {
        get { userDefaults.double(forKey: "stepGoal") == 0 ? 10000 : userDefaults.double(forKey: "stepGoal") }
        set { userDefaults.set(newValue, forKey: "stepGoal") }
    }

    var calorieGoal: Double {
        get { userDefaults.double(forKey: "calorieGoal") == 0 ? 500 : userDefaults.double(forKey: "calorieGoal") }
        set { userDefaults.set(newValue, forKey: "calorieGoal") }
    }

    var sleepGoal: Double {
        get { userDefaults.double(forKey: "sleepGoal") == 0 ? 8 : userDefaults.double(forKey: "sleepGoal") }
        set { userDefaults.set(newValue, forKey: "sleepGoal") }
    }
}
