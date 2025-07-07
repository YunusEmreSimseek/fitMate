//
//  WorkoutModels.swift
//  fitMate
//
//  Created by Emre Simsek on 9.06.2025.
//

import FirebaseFirestore
import Foundation

struct WorkoutProgram: Identifiable, Codable, Hashable, Equatable {
    @DocumentID var id: String?
    var name: String
    var days: [WorkoutDay]
    var createdAt: Date = .init()
}

struct PartialWorkoutProgram: Decodable {
    var name: String
    var days: [PartialDay]
}

struct PartialDay: Decodable {
    var name: String
    var order: Int
    var exercises: [PartialExercise]
}

struct PartialExercise: Decodable {
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double
}

extension WorkoutProgram {
    static let dummyProgram1 = WorkoutProgram(
        id: "dummyProgram1",
        name: "Güç Antrenmanı",
        days: [
            WorkoutDay.dummyDay1,
            WorkoutDay.dummyDay2,
        ]
    )
    static let dummyProgram2 = WorkoutProgram(
        id: "dummyProgram2",
        name: "Hipertrofi Antrenmanı",
        days: [
            WorkoutDay.dummyDay1,
            WorkoutDay.dummyDay2,
        ]
    )
    static let dummyProgram3 = WorkoutProgram(
        id: "dummyProgram3",
        name: "Yağ Yakım Antrenmanı",
        days: [
            WorkoutDay.dummyDay1,
            WorkoutDay.dummyDay2,
        ]
    )
    static let dummyPrograms: [WorkoutProgram] = [
        dummyProgram1,
        dummyProgram2,
        dummyProgram3,
    ]
}

struct WorkoutDay: Codable, Identifiable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var name: String // Örnek: "İtiş Günü"
    var order: Int // Haftalık sıradaki günü belirtir (1, 2, 3...)
    var exercises: [WorkoutExercise]
}

extension WorkoutDay {
    static let dummyDay1 = WorkoutDay(
        id: "dummyDay1",
        name: "İtiş Günü",
        order: 1,
        exercises: [
            WorkoutExercise.dummyExercise1,
            WorkoutExercise.dummyExercise2,
        ]
    )
    static let dummyDay2 = WorkoutDay(
        id: "dummyDay2",
        name: "Çekiş Günü",
        order: 2,
        exercises: [
            WorkoutExercise.dummyExercise3,
        ]
    )
    static let dummyDays = [dummyDay1, dummyDay2]
}

struct WorkoutExercise: Codable, Identifiable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var name: String // Örnek: "Bench Press"
    var sets: Int
    var reps: Int
    var weight: Double
    var notes: String? // Örnek: "Dumbbell kullan"
}

extension WorkoutExercise {
    static let dummyExercise1 = WorkoutExercise(
        id: "dummyExercise1",
        name: "Bench Press",
        sets: 4,
        reps: 8,
        weight: 70.0,
        notes: "Dumbbell kullan"
    )
    static let dummyExercise2 = WorkoutExercise(
        id: "dummyExercise2",
        name: "Squat",
        sets: 4,
        reps: 10,
        weight: 80.0,
        notes: nil
    )
    static let dummyExercise3 = WorkoutExercise(
        id: "dummyExercise3",
        name: "Deadlift",
        sets: 3,
        reps: 6,
        weight: 100.0,
        notes: "Forma dikkat et"
    )
    static let dummyExercises = [
        dummyExercise1,
        dummyExercise2,
        dummyExercise3,
    ]
}

struct WorkoutLog: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var date: Date
    var programId: String?
    var programName: String?
    var dayId: String?
    var dayName: String?
    var exercises: [WorkoutExercise]
}

extension WorkoutLog {
    static let dummyLog = WorkoutLog(
        id: "dummyLog",
        date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 5))!,
        programId: "dummyProgram1",
        programName: "Güç Antrenmanı",
        dayId: "dummyDay1",
        dayName: "İtiş Günü",
        exercises: [
            WorkoutExercise.dummyExercise1,
            WorkoutExercise.dummyExercise2,
        ]
    )
    static let dummyLog2 = WorkoutLog(
        id: "dummyLog2",
        date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 6))!,
        programId: "dummyProgram1",
        programName: "Güç Antrenmanı",
        dayId: "dummyDay2",
        dayName: "Çekiş Günü",
        exercises: [
            WorkoutExercise.dummyExercise3,
        ]
    )
    static let dummyLog3 = WorkoutLog(
        id: "dummyLog3",
        date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 7))!,
        programId: "dummyProgram2",
        programName: "Hipertrofi Antrenmanı",
        dayId: "dummyDay1",
        dayName: "İtiş Günü",
        exercises: [
            WorkoutExercise.dummyExercise1,
            WorkoutExercise.dummyExercise2,
        ]
    )
    static let dummyLog4 = WorkoutLog(
        id: "dummyLog4",
        date: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 8))!,
        programId: "dummyProgram2",
        programName: "Hipertrofi Antrenmanı",
        dayId: "dummyDay2",
        dayName: "Çekiş Günü",
        exercises: [
            WorkoutExercise.dummyExercise3,
        ]
    )
    static let dummyLogs: [WorkoutLog] = [
        dummyLog,
        dummyLog2,
        dummyLog3,
        dummyLog4,
    ]

    func calculateTotalSets() -> Int {
        exercises.reduce(0) { $0 + $1.sets }
    }
}
