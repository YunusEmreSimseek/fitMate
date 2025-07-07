//
//  AppContainer.swift
//  fitMate
//
//  Created by Emre Simsek on 24.04.2025.
//

import Foundation
import Swinject

final class AppContainer {
    static let shared = AppContainer()
    private let container = Container()

    private init() {
        registerDependencies()
    }

    // App managers
    var userSessionManager: UserSessionManager {
        guard let instance = container.resolve(UserSessionManager.self) else {
            fatalError("UserSessionManager not registered")
        }
        return instance
    }

    var navigationManager: NavigationManager {
        guard let instance = container.resolve(NavigationManager.self) else {
            fatalError("NavigationManager not registered")
        }
        return instance
    }

    var logManager: LogManager {
        guard let instance = container.resolve(LogManager.self) else {
            fatalError("LogManager not registered")
        }
        return instance
    }

    var healthKitManager: HealthKitManager {
        guard let instance = container.resolve(HealthKitManager.self) else {
            fatalError("HealthKitManager not registered")
        }
        return instance
    }

    var goalManager: GoalManager {
        guard let instance = container.resolve(GoalManager.self) else {
            fatalError("GoalManager not registered")
        }
        return instance
    }

    var secretsManager: SecretsManager {
        guard let instance = container.resolve(SecretsManager.self) else {
            fatalError("SecretsManager not registered")
        }
        return instance
    }

    var userWorkoutManager: UserWorkoutManager {
        guard let instance = container.resolve(UserWorkoutManager.self) else {
            fatalError("UserWorkoutManager not registered")
        }
        return instance
    }

    var userDietManager: UserDietManager {
        guard let instance = container.resolve(UserDietManager.self) else {
            fatalError("UserDietManager not registered")
        }
        return instance
    }

    var unitManager: UnitManager {
        guard let instance = container.resolve(UnitManager.self) else {
            fatalError("UnitManager not registered")
        }
        return instance
    }

    var appStartupStateManager: AppStartupStateManager {
        guard let instance = container.resolve(AppStartupStateManager.self) else {
            fatalError("AppStartupStateManager not registered")
        }
        return instance
    }

    // App services
    var userService: IUserService {
        guard let instance = container.resolve(IUserService.self) else {
            fatalError("IUserService not registered")
        }
        return instance
    }

    var userAuthService: IUserAuthService {
        guard let instance = container.resolve(IUserAuthService.self) else {
            fatalError("IUserAuthService not registered")
        }
        return instance
    }

    var openAIService: OpenAIService {
        guard let instance = container.resolve(OpenAIService.self) else {
            fatalError("IAIService not registered")
        }
        return instance
    }

    var mistralAIService: MistralAIService {
        guard let instance = container.resolve(MistralAIService.self) else {
            fatalError("MistralService not registered")
        }
        return instance
    }

    var chatService: ChatService {
        guard let instance = container.resolve(ChatService.self) else {
            fatalError("IChatService not registered")
        }
        return instance
    }

    var storageService: StorageService {
        guard let instance = container.resolve(StorageService.self) else {
            fatalError("IStorageService not registered")
        }
        return instance
    }

    var healthDataService: HealthDataService {
        guard let instance = container.resolve(HealthDataService.self) else {
            fatalError("HealthDataService not registered")
        }
        return instance
    }

    var dietService: DietService {
        guard let instance = container.resolve(DietService.self) else {
            fatalError("DietService not registered")
        }
        return instance
    }

    var workoutService: WorkoutService {
        guard let instance = container.resolve(WorkoutService.self) else {
            fatalError("WorkoutService not registered")
        }
        return instance
    }

    private func registerDependencies() {
        container.register(UserSessionManager.self) { _ in
            UserSessionManager()
        }.inObjectScope(.container)

        container.register(NavigationManager.self) { _ in
            NavigationManager()
        }.inObjectScope(.container)

        container.register(LogManager.self) { _ in
            LogManager()
        }.inObjectScope(.container)

        container.register(HealthKitManager.self) { _ in
            HealthKitManager()
        }.inObjectScope(.container)

        container.register(GoalManager.self) { _ in
            GoalManager()
        }.inObjectScope(.container)

        container.register(SecretsManager.self) { _ in
            SecretsManager()
        }.inObjectScope(.container)

        container.register(UserWorkoutManager.self) { _ in
            UserWorkoutManager()
        }.inObjectScope(.container)

        container.register(UserDietManager.self) { _ in
            UserDietManager()
        }.inObjectScope(.container)

        container.register(UnitManager.self) { _ in
            UnitManager()
        }.inObjectScope(.container)

        container.register(AppStartupStateManager.self) { _ in
            AppStartupStateManager()
        }.inObjectScope(.container)

        container.register(IUserService.self) { _ in
            UserService()
        }.inObjectScope(.container)

        container.register(IUserAuthService.self) { _ in
            UserAuthService()
        }.inObjectScope(.container)

        container.register(OpenAIService.self) { _ in
            OpenAIService(userSessionManager: self.userSessionManager)
        }.inObjectScope(.container)

        container.register(MistralAIService.self) { _ in
            MistralAIService(userSessionManager: self.userSessionManager)
        }.inObjectScope(.container)

        container.register(ChatService.self) { _ in
            ChatService()
        }.inObjectScope(.container)

        container.register(StorageService.self) { _ in
            StorageService()
        }.inObjectScope(.container)

        container.register(HealthDataService.self) { _ in
            HealthDataService()
        }.inObjectScope(.container)

        container.register(DietService.self) { _ in
            DietService()
        }.inObjectScope(.container)

        container.register(WorkoutService.self) { _ in
            WorkoutService()
        }.inObjectScope(.container)
    }
}
