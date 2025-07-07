//
//  Gender.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//

enum Gender: String, Codable, Identifiable, Pickable, CaseIterable {
//    case none
    case male
    case female

    var id: String { rawValue }

    var title: String {
        switch self {
//        case .none: return "None"
        case .male: return "Male"
        case .female: return "Female"
        }
    }
}
