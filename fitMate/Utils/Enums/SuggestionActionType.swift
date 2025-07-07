//
//  SuggestionActionType.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//

enum SuggestionActionType: String, CaseIterable {
    case setStepGoal
    case setCalorieGoal
    case setDietPlan
    case setWorkoutProgram

    func perform(with value: SuggestionActionValue) {
        guard let user = userSessionManager.currentUser else { return }

        switch self {
        case .setStepGoal:
            if case let .int(stepGoal) = value {
                var updatedUser = user
                updatedUser.stepGoal = stepGoal
                Task {
                    await userSessionManager.updateUser(updatedUser)
                }
            }
        case .setCalorieGoal:
            if case let .int(calorieGoal) = value {
                var updatedUser = user
                updatedUser.calorieGoal = calorieGoal
                Task {
                    await userSessionManager.updateUser(updatedUser)
                }
            }
        case .setDietPlan:
            if case let .diet(dietModel) = value {
                Task {
                    await userDietManager.addDietPlan(dietModel)
                }
            }
        case .setWorkoutProgram:
            if case let .workout(workoutProgram) = value {
                Task {
                    await userWorkoutManager.addProgram(workoutProgram)
                }
            }
        }
    }

    private var userSessionManager: UserSessionManager {
        AppContainer.shared.userSessionManager
    }

    private var userDietManager: UserDietManager {
        AppContainer.shared.userDietManager
    }

    private var userWorkoutManager: UserWorkoutManager {
        AppContainer.shared.userWorkoutManager
    }
}

enum SuggestionActionValue: Decodable {
    case int(Int)
    case diet(DietModel)
    case workout(WorkoutProgram)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
            return
        }

        if let dietValue = try? container.decode(PartialDietModel.self) {
            let dietModel = DietModel(
                startDate: .now,
                durationInDays: dietValue.durationInDays,
                weightLossGoalKg: dietValue.weightLossGoalKg,
                targetWeight: dietValue.targetWeight,
                dailyStepGoal: dietValue.dailyStepGoal,
                dailyCalorieLimit: dietValue.dailyCalorieLimit,
                dailyProteinGoal: dietValue.dailyProteinGoal
            )
            self = .diet(dietModel)
            return
        }

        if let workoutValue = try? container.decode(PartialWorkoutProgram.self) {
            let workoutDays = workoutValue.days.map { day in
                WorkoutDay(
                    name: day.name,
                    order: day.order,
                    exercises: day.exercises.map { exercise in
                        WorkoutExercise(
                            name: exercise.name,
                            sets: exercise.sets,
                            reps: exercise.reps,
                            weight: exercise.weight
                        )
                    }
                )
            }
            let workoutProgram = WorkoutProgram(
                name: workoutValue.name,
                days: workoutDays
            )
            self = .workout(workoutProgram)
            return
        }

        throw DecodingError.typeMismatch(
            SuggestionActionValue.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Unsupported SuggestionActionValue type"
            )
        )
    }
}
