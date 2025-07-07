//
//  UnitManager.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//
import SwiftUI

@Observable
final class UnitManager {
    var weightUnit: WeightUnit = .kilogram
    var heightUnit: HeightUnit = .centimeter
    var distanceUnit: DistanceUnit = .kilometer
}

enum WeightUnit: String, CaseIterable, Identifiable, UnitPreference, Hashable {
    case kilogram, pound
    var id: String { rawValue }
    var title: String {
        switch self {
        case .kilogram: "kilogram"
        case .pound: "pound"
        }
    }

    var shorTitle: String {
        switch self {
        case .kilogram: "kg"
        case .pound: "lb"
        }
    }
}

enum HeightUnit: String, CaseIterable, Identifiable, UnitPreference, Hashable {
    case centimeter, feet
    var id: String { rawValue }
    var title: String {
        switch self {
        case .centimeter: "centimeter"
        case .feet: "feet"
        }
    }

    var shorTitle: String {
        switch self {
        case .centimeter: "cm"
        case .feet: "ft"
        }
    }
}

enum DistanceUnit: String, CaseIterable, Identifiable, UnitPreference, Hashable {
    case kilometer, mile
    var id: String { rawValue }
    var title: String {
        switch self {
        case .kilometer: "kilometer"
        case .mile: "mile"
        }
    }

    var shorTitle: String {
        switch self {
        case .kilometer: "km"
        case .mile: "mile"
        }
    }
}

protocol UnitPreference: Equatable {
    var title: String { get }
}
