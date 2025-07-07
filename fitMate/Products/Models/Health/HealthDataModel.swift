//
//  HealthDataModel.swift
//  fitMate
//
//  Created by Emre Simsek on 29.04.2025.
//

import Foundation

struct HealthDataModel: Codable, Identifiable {
    var id: String { dateString }
    let dateString: String
    let stepCount: Double
    let activeEnergyBurned: Double
    let distanceWalkingRunning: Double
    let averageHeartRate: Double
    let sleepHours: Double
}
