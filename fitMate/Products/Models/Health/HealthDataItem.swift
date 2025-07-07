//
//  HealthDataItem.swift
//  fitMate
//
//  Created by Emre Simsek on 29.04.2025.
//

import Foundation

struct HealthDataItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let unit: String
}
